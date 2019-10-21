Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7692FDE562
	for <lists+linux-edac@lfdr.de>; Mon, 21 Oct 2019 09:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfJUHii (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 21 Oct 2019 03:38:38 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52182 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbfJUHii (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 21 Oct 2019 03:38:38 -0400
Received: from zn.tnic (p2E584653.dip0.t-ipconnect.de [46.88.70.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 92BBB1EC072D;
        Mon, 21 Oct 2019 09:38:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1571643516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NB+pW62T+4rVFO5wkCclKyVt1owZZ8MzkoOSSg4xqhU=;
        b=MCbYZIH0nD8XlOx35CYXCs2a7ThOvd0Px0CuKtV7O3ytjO1N+W2C/an40IicwoQrb8wDJI
        g7UmjPrjRDlAD+Aay8zR7dt+RCjtdRW5TOjKzqLhDfKOBdUpIzRAiyy1W+DPCmqtukwnVv
        efl133hpPjFHqOXxNfIVf4rHBCfz5Yg=
Date:   Mon, 21 Oct 2019 09:37:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     James Morse <james.morse@arm.com>
Cc:     linux-edac@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Robert Richter <rrichter@marvell.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 0/2] EDAC, ghes: Fix use after free and add reference
Message-ID: <20191021073757.GA7014@zn.tnic>
References: <20191014171919.85044-1-james.morse@arm.com>
 <20191014173006.GG4715@zn.tnic>
 <86ba3fcf-d29c-1d6a-d8c3-2a03cb11263e@arm.com>
 <20191014175319.GH4715@zn.tnic>
 <20191016151751.GH1138@zn.tnic>
 <d8899938-72c2-909d-1528-2e763820bd75@arm.com>
 <20191016185041.GM1138@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191016185041.GM1138@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Oct 16, 2019 at 08:50:41PM +0200, Borislav Petkov wrote:
> Yeah, before we do this, lemme try to simplify the situation more. And
> yeah, we don't need the mutex - we can use the spinlock only. But let's
> get rid of the need to access the pvt in the IRQ handler. Yeah, we need
> the *mci pointer but one can't have it all :)
> 
> Anyway, here's what I have, it is only build-tested. I wanna give it a
> stern look tomorrow, on a clear head again:

And now I went and redid your patch ontop and thus completely got rid of
ghes_pvt in favor of having one global ghes_mci pointer.

We access it only under the lock and we publish it in
ghes_edac_register() only in the success case. Can't get any simpler
than that.

Thoughts?

I think it is a lot cleaner and straight-forward this way. Lemme know if
you wanna run it on your setup and I'll push the two patches somewhere.

Thx.

---
diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index bcb6a9c579c6..e55a9cb8ab73 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -15,14 +15,6 @@
 #include "edac_module.h"
 #include <ras/ras_event.h>
 
-struct ghes_edac_pvt {
-	struct list_head list;
-	struct ghes *ghes;
-	struct mem_ctl_info *mci;
-};
-
-static atomic_t ghes_init = ATOMIC_INIT(0);
-static struct ghes_edac_pvt *ghes_pvt;
 static struct mem_ctl_info *ghes_mci;
 
 /* Buffers for the error handling routine */
@@ -80,9 +72,8 @@ static void ghes_edac_count_dimms(const struct dmi_header *dh, void *arg)
 		(*num_dimm)++;
 }
 
-static int get_dimm_smbios_index(u16 handle)
+static int get_dimm_smbios_index(struct mem_ctl_info *mci, u16 handle)
 {
-	struct mem_ctl_info *mci = ghes_pvt->mci;
 	int i;
 
 	for (i = 0; i < mci->tot_dimms; i++) {
@@ -345,7 +336,7 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 			p += sprintf(p, "DIMM DMI handle: 0x%.4x ",
 				     mem_err->mem_dev_handle);
 
-		index = get_dimm_smbios_index(mem_err->mem_dev_handle);
+		index = get_dimm_smbios_index(ghes_mci, mem_err->mem_dev_handle);
 		if (index >= 0) {
 			e.top_layer = index;
 			e.enable_per_layer_report = true;
@@ -456,12 +447,13 @@ static struct acpi_platform_list plat_list[] = {
 
 int ghes_edac_register(struct ghes *ghes, struct device *dev)
 {
-	bool fake = false;
-	int rc, num_dimm = 0;
-	struct mem_ctl_info *mci;
-	struct edac_mc_layer layers[1];
 	struct ghes_edac_dimm_fill dimm_fill;
-	int idx = -1;
+	struct edac_mc_layer layers[1];
+	struct mem_ctl_info *mci;
+	int err = 0, idx = -1;
+	int rc, num_dimm = 0;
+	unsigned long flags;
+	bool fake = false;
 
 	if (IS_ENABLED(CONFIG_X86)) {
 		/* Check if safe to enable on this system */
@@ -475,8 +467,9 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	/*
 	 * We have only one logical memory controller to which all DIMMs belong.
 	 */
-	if (atomic_inc_return(&ghes_init) > 1)
-		return 0;
+	spin_lock_irqsave(&ghes_lock, flags);
+	if (ghes_mci)
+		goto unlock;
 
 	/* Get the number of DIMMs */
 	dmi_walk(ghes_edac_count_dimms, &num_dimm);
@@ -491,17 +484,13 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	layers[0].size = num_dimm;
 	layers[0].is_virt_csrow = true;
 
-	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers, sizeof(struct ghes_edac_pvt));
+	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers, 0);
 	if (!mci) {
 		pr_info("Can't allocate memory for EDAC data\n");
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto unlock;
 	}
 
-	ghes_pvt	= mci->pvt_info;
-	ghes_pvt->ghes	= ghes;
-	ghes_pvt->mci	= mci;
-	ghes_mci	= mci;
-
 	mci->pdev = dev;
 	mci->mtype_cap = MEM_FLAG_EMPTY;
 	mci->edac_ctl_cap = EDAC_FLAG_NONE;
@@ -542,23 +531,30 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	if (rc < 0) {
 		pr_info("Can't register at EDAC core\n");
 		edac_mc_free(mci);
-		return -ENODEV;
+		err = -ENODEV;
 	}
-	return 0;
+
+	ghes_mci = mci;
+
+unlock:
+	spin_unlock_irqrestore(&ghes_lock, flags);
+
+	return err;
 }
 
 void ghes_edac_unregister(struct ghes *ghes)
 {
-	struct mem_ctl_info *mci;
+	unsigned long flags;
 
-	if (!ghes_pvt)
-		return;
+	spin_lock_irqsave(&ghes_lock, flags);
 
-	if (atomic_dec_return(&ghes_init))
-		return;
+	if (!ghes_mci)
+		goto unlock;
 
-	mci = ghes_pvt->mci;
-	ghes_pvt = NULL;
-	edac_mc_del_mc(mci->pdev);
-	edac_mc_free(mci);
+	edac_mc_del_mc(ghes_mci->pdev);
+	edac_mc_free(ghes_mci);
+	ghes_mci = NULL;
+
+unlock:
+	spin_unlock_irqrestore(&ghes_lock, flags);
 }

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
