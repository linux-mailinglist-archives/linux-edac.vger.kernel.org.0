Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5465D959A
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2019 17:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393547AbfJPPa1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 16 Oct 2019 11:30:27 -0400
Received: from foss.arm.com ([217.140.110.172]:43374 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbfJPPa1 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 16 Oct 2019 11:30:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 776D9142F;
        Wed, 16 Oct 2019 08:30:26 -0700 (PDT)
Received: from [10.1.196.105] (unknown [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86D3D3F68E;
        Wed, 16 Oct 2019 08:30:25 -0700 (PDT)
Subject: Re: [PATCH 0/2] EDAC, ghes: Fix use after free and add reference
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Robert Richter <rrichter@marvell.com>,
        John Garry <john.garry@huawei.com>
References: <20191014171919.85044-1-james.morse@arm.com>
 <20191014173006.GG4715@zn.tnic>
 <86ba3fcf-d29c-1d6a-d8c3-2a03cb11263e@arm.com>
 <20191014175319.GH4715@zn.tnic> <20191016151751.GH1138@zn.tnic>
From:   James Morse <james.morse@arm.com>
Message-ID: <d8899938-72c2-909d-1528-2e763820bd75@arm.com>
Date:   Wed, 16 Oct 2019 16:30:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191016151751.GH1138@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Boris,

On 16/10/2019 16:17, Borislav Petkov wrote:
> On Mon, Oct 14, 2019 at 07:53:19PM +0200, Borislav Petkov wrote:
>> Provided unregister cannot be called concurrently, the
>>
>>         if (!ghes_pvt)
>>                 return;
>>
>> in ghes_edac_unregister() should suffice.
>>
>> But just to be on the safe side, it could get an "instance_mutex" or so
>> under which ghes_pvt is set and cleared and then that silly counter can
>> simply go away.
>>
>> Thoughts?
> 
> IOW, something simple and straight-forward like this:


> ---
> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index 0bb62857ffb2..b600f010fa0e 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -26,9 +26,11 @@ struct ghes_edac_pvt {
>  	char msg[80];
>  };
>  
> -static atomic_t ghes_init = ATOMIC_INIT(0);
>  static struct ghes_edac_pvt *ghes_pvt;
>  
> +/* GHES instances reg/dereg mutex */
> +static DEFINE_MUTEX(ghes_reg_mutex);
> +
>  /*
>   * Sync with other, potentially concurrent callers of
>   * ghes_edac_report_mem_error(). We don't know what the
> @@ -461,7 +463,7 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
>  	struct mem_ctl_info *mci;
>  	struct edac_mc_layer layers[1];
>  	struct ghes_edac_dimm_fill dimm_fill;
> -	int idx = -1;
> +	int idx = -1, err = 0;
>  
>  	if (IS_ENABLED(CONFIG_X86)) {
>  		/* Check if safe to enable on this system */
> @@ -472,11 +474,13 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
>  		idx = 0;
>  	}
>  
> +	mutex_lock(&ghes_reg_mutex);
> +
>  	/*
>  	 * We have only one logical memory controller to which all DIMMs belong.
>  	 */
> -	if (atomic_inc_return(&ghes_init) > 1)
> -		return 0;
> +	if (ghes_pvt)
> +		goto unlock;
>  
>  	/* Get the number of DIMMs */
>  	dmi_walk(ghes_edac_count_dimms, &num_dimm);
> @@ -494,7 +498,8 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
>  	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers, sizeof(struct ghes_edac_pvt));
>  	if (!mci) {
>  		pr_info("Can't allocate memory for EDAC data\n");
> -		return -ENOMEM;
> +		err = -ENOMEM;
> +		goto unlock;
>  	}
>  
>  	ghes_pvt	= mci->pvt_info;
> @@ -541,23 +546,29 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
>  	if (rc < 0) {
>  		pr_info("Can't register at EDAC core\n");
>  		edac_mc_free(mci);
> -		return -ENODEV;
> +		err = -ENODEV;
>  	}
> -	return 0;
> +
> +unlock:
> +	mutex_unlock(&ghes_reg_mutex);
> +
> +	return err;
>  }

There are a few more warts we should try and get rid of with this:
ghes_edac_register() publishes the ghes_pvt pointer under the mutex, but the irq handler
reads it without taking the mutex. (obviously it can't).

ghes_edac_register() publishes the pointer before its called edac_mc_add_mc(), which is
pleasant.

(sorry I've been sitting on this while I found new and exciting ways to break my test
machine!)

Combined with the spinlocky bits of:
--------------------------%<--------------------------
From 61fa061790fe7c19af25b25693b61bb75a498058 Mon Sep 17 00:00:00 2001
From: James Morse <james.morse@arm.com>
Date: Wed, 16 Oct 2019 10:02:15 +0100
Subject: [PATCH] EDAC, ghes: Move ghes_init and ghes_pvt under the ghes_lock

ghes_edac has an irqsave spinlock that protects the contents of ghes_pvt,
but not the pointer itself. The register, unregister and irq-handler
functions read this bare global variable expecting to see NULL or the
allocated value. Without READ_ONCE()/WRITE_ONCE(), this is racy.
ghes_edac_register() also publishes the pointer before it has registered
the mci.

Replace ghes_init with an unsigned int counter in ghes_pvt. To access
this or read the ghes_pvt pointer, you must hold the ghes_lock. This
prevents races when these values are modified.

Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/edac/ghes_edac.c | 69 ++++++++++++++++++++++++++++------------
 1 file changed, 48 insertions(+), 21 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 0bb62857ffb2..804bb07c6acf 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -15,7 +15,10 @@
 #include "edac_module.h"
 #include <ras/ras_event.h>

+/* Hold ghes_lock when accessing ghes_pvt */
 struct ghes_edac_pvt {
+	unsigned int users;
+
 	struct list_head list;
 	struct ghes *ghes;
 	struct mem_ctl_info *mci;
@@ -26,7 +29,6 @@ struct ghes_edac_pvt {
 	char msg[80];
 };

-static atomic_t ghes_init = ATOMIC_INIT(0);
 static struct ghes_edac_pvt *ghes_pvt;

 /*
@@ -79,9 +81,8 @@ static void ghes_edac_count_dimms(const struct dmi_header *dh, void *arg)
 		(*num_dimm)++;
 }

-static int get_dimm_smbios_index(u16 handle)
+static int get_dimm_smbios_index(u16 handle, struct mem_ctl_info *mci)
 {
-	struct mem_ctl_info *mci = ghes_pvt->mci;
 	int i;

 	for (i = 0; i < mci->tot_dimms; i++) {
@@ -197,15 +198,12 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err
*mem_err)
 {
 	enum hw_event_mc_err_type type;
 	struct edac_raw_error_desc *e;
+	struct ghes_edac_pvt *pvt;
 	struct mem_ctl_info *mci;
-	struct ghes_edac_pvt *pvt = ghes_pvt;
 	unsigned long flags;
 	char *p;
 	u8 grain_bits;

-	if (!pvt)
-		return;
-
 	/*
 	 * We can do the locking below because GHES defers error processing
 	 * from NMI to IRQ context. Whenever that changes, we'd at least
@@ -215,6 +213,11 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err
*mem_err)
 		return;

 	spin_lock_irqsave(&ghes_lock, flags);
+	pvt = ghes_pvt;
+	if (!pvt) {
+		spin_unlock_irqrestore(&ghes_lock, flags);
+		return;
+	}

 	mci = pvt->mci;
 	e = &mci->error_desc;
@@ -348,7 +351,7 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 			p += sprintf(p, "DIMM DMI handle: 0x%.4x ",
 				     mem_err->mem_dev_handle);

-		index = get_dimm_smbios_index(mem_err->mem_dev_handle);
+		index = get_dimm_smbios_index(mem_err->mem_dev_handle, mci);
 		if (index >= 0) {
 			e->top_layer = index;
 			e->enable_per_layer_report = true;
@@ -457,8 +460,10 @@ static struct acpi_platform_list plat_list[] = {
 int ghes_edac_register(struct ghes *ghes, struct device *dev)
 {
 	bool fake = false;
+	unsigned long flags;
 	int rc, num_dimm = 0;
 	struct mem_ctl_info *mci;
+	struct ghes_edac_pvt *pvt;
 	struct edac_mc_layer layers[1];
 	struct ghes_edac_dimm_fill dimm_fill;
 	int idx = -1;
@@ -475,7 +480,13 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	/*
 	 * We have only one logical memory controller to which all DIMMs belong.
 	 */
-	if (atomic_inc_return(&ghes_init) > 1)
+	spin_lock_irqsave(&ghes_lock, flags);
+	pvt = ghes_pvt;
+	if (pvt)
+		pvt->users++;
+	spin_unlock_irqrestore(&ghes_lock, flags);
+
+	if (pvt)
 		return 0;

 	/* Get the number of DIMMs */
@@ -497,9 +508,10 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 		return -ENOMEM;
 	}

-	ghes_pvt	= mci->pvt_info;
-	ghes_pvt->ghes	= ghes;
-	ghes_pvt->mci	= mci;
+	pvt		= mci->pvt_info;
+	pvt->ghes	= ghes;
+	pvt->mci	= mci;
+	pvt->users	= 1;

 	mci->pdev = dev;
 	mci->mtype_cap = MEM_FLAG_EMPTY;
@@ -543,21 +555,36 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 		edac_mc_free(mci);
 		return -ENODEV;
 	}
+
+	spin_lock_irqsave(&ghes_lock, flags);
+	WARN_ON_ONCE(ghes_pvt);
+	ghes_pvt = pvt;
+	spin_unlock_irqrestore(&ghes_lock, flags);
+
 	return 0;
 }

 void ghes_edac_unregister(struct ghes *ghes)
 {
 	struct mem_ctl_info *mci;
+	bool do_free = false;
+	unsigned long flags;

-	if (!ghes_pvt)
-		return;
-
-	if (atomic_dec_return(&ghes_init))
-		return;
+	spin_lock_irqsave(&ghes_lock, flags);
+	if (ghes_pvt) {
+		ghes_pvt->users -= 1;
+
+		/* Are we the last user? */
+		if (!ghes_pvt->users) {
+			do_free = true;
+			mci = ghes_pvt->mci;
+			ghes_pvt = NULL;
+		}
+	}
+	spin_unlock_irqrestore(&ghes_lock, flags);

-	mci = ghes_pvt->mci;
-	ghes_pvt = NULL;
-	edac_mc_del_mc(mci->pdev);
-	edac_mc_free(mci);
+	if (do_free) {
+		edac_mc_del_mc(mci->pdev);
+		edac_mc_free(mci);
+	}
 }
-- 
2.20.1
--------------------------%<--------------------------



Thanks,

James
