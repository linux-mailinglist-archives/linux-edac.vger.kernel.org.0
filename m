Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C7D1B7B71
	for <lists+linux-edac@lfdr.de>; Fri, 24 Apr 2020 18:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgDXQWc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 24 Apr 2020 12:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbgDXQWF (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 24 Apr 2020 12:22:05 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE482C09B046;
        Fri, 24 Apr 2020 09:22:04 -0700 (PDT)
Received: from zn.tnic (p200300EC2F1D0400A18A6B210CB54187.dip0.t-ipconnect.de [IPv6:2003:ec:2f1d:400:a18a:6b21:cb5:4187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C98B51EC0DA8;
        Fri, 24 Apr 2020 18:22:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1587745323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1/3wK0YNoGRPgjYsn9oUGnsqgYhnz2Yh2ZUOTxwEzQ4=;
        b=eohtvaGF3ILzwSoVe1lk9xga7qFL5WdSdne1qA/a3ULGzwdkQMm5a0/Bup1IZMzqWii64A
        glshfR87GSezL1s683/XIbPr7Xkyl2NwkwffwIPRqkBDXw4zYeMM+Qbpp8068s/RG6Gsxo
        BQSfhloSuc5+9wpmXaYJzZLIo/Ii/YI=
Date:   Fri, 24 Apr 2020 18:21:57 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Matthias Brugger <mbrugger@suse.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/10] EDAC/ghes: Make SMBIOS handle private data to
 ghes
Message-ID: <20200424162157.GB6916@zn.tnic>
References: <20200422115814.22205-1-rrichter@marvell.com>
 <20200422115814.22205-5-rrichter@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200422115814.22205-5-rrichter@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Apr 22, 2020 at 01:58:08PM +0200, Robert Richter wrote:
> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index 39efce0df881..23adb7674f9b 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -15,6 +15,12 @@
>  #include "edac_module.h"
>  #include <ras/ras_event.h>
>  
> +struct ghes_dimm {

Simply struct dimm

> +	struct list_head entry;
> +	struct dimm_info *dimm;
> +	u16 handle;
> +};
> +
>  struct ghes_mci {
>  	struct mem_ctl_info *mci;
>  
> @@ -42,6 +48,16 @@ static DEFINE_MUTEX(ghes_reg_mutex);
>   */
>  static DEFINE_SPINLOCK(ghes_lock);
>  
> +/*
> + * Locking:
> + *
> + *  dimms, ghes_dimm_pool:  ghes_reg_mutex
> + *  ghes_dimm_list:         ghes_lock
> + */
> +static struct ghes_dimm *dimms;
> +static LIST_HEAD(ghes_dimm_list);
> +static LIST_HEAD(ghes_dimm_pool);

Those are static lists, no need to prefix them with "ghes_". There's too
much "ghes" in that code. :)

> +
>  /* "ghes_edac.force_load=1" skips the platform check */
>  static bool __read_mostly force_load;
>  module_param(force_load, bool, 0);
> @@ -72,11 +88,63 @@ struct memdev_dmi_entry {
>  	u16 conf_mem_clk_speed;
>  } __attribute__((__packed__));
>  
> -struct ghes_edac_dimm_fill {
> +struct dimm_fill {
> +	struct list_head dimms;
>  	struct mem_ctl_info *mci;
>  	unsigned int count;
>  };
>  
> +static int ghes_dimm_pool_create(int num_dimm)

Yeah, drop "ghes_" here too. I'm not going to comment on this in the
rest of the patchset but for the next version, please drop the "ghes_"
prefix from static functions and members - it unnecessarily gets in the
way when reading the code.

> +{
> +	struct ghes_dimm *ghes_dimm;
> +
> +	if (!num_dimm)
> +		return 0;
> +
> +	lockdep_assert_held(ghes_reg_mutex);
> +
> +	dimms = kcalloc(num_dimm, sizeof(*dimms), GFP_KERNEL);
> +	if (!dimms)
> +		return -ENOMEM;
> +
> +	for (ghes_dimm = dimms; ghes_dimm < dimms + num_dimm; ghes_dimm++)

And with the above shortening of names, this loop becomes:

	for (d = dimms; d < dimms + num_dimms; d++)
		list_add(&d->entry, &dimm_pool);

Simple.

> +
> +	return 0;
> +}
> +
> +static void ghes_dimm_pool_destroy(void)
> +{
> +	lockdep_assert_held(ghes_reg_mutex);
> +	INIT_LIST_HEAD(&ghes_dimm_pool);
> +	kfree(dimms);
> +}
> +
> +static struct ghes_dimm *ghes_dimm_alloc(struct dimm_info *dimm, u16 handle)
> +{
> +	struct ghes_dimm *ghes_dimm;
> +
> +	lockdep_assert_held(ghes_reg_mutex);

The 0day bot caught it already - this needs to be a ptr. Please test
with PROVE_LOCKING enabled before sending next time.

> +
> +	ghes_dimm = list_first_entry_or_null(&ghes_dimm_pool,
> +					struct ghes_dimm, entry);

Let that line stick out.

> +
> +	/* should be always non-zero */
> +	if (!WARN_ON_ONCE(!ghes_dimm)) {
> +		ghes_dimm->dimm = dimm;
> +		ghes_dimm->handle = handle;
> +		list_del(&ghes_dimm->entry);
> +	}
> +
> +	return ghes_dimm;
> +}
> +
> +static void ghes_dimm_release(struct list_head *dimms)
> +{
> +	lockdep_assert_held(ghes_reg_mutex);
> +	list_splice(dimms, &ghes_dimm_pool);
> +}
> +
>  static void ghes_edac_count_dimms(const struct dmi_header *dh, void *arg)
>  {
>  	int *num_dimm = arg;

...

> @@ -547,12 +626,18 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
>  
>  	spin_lock_irqsave(&ghes_lock, flags);
>  	ghes_pvt = pvt;
> +	list_splice_tail(&dimm_fill.dimms, &ghes_dimm_list);
>  	spin_unlock_irqrestore(&ghes_lock, flags);
>  
>  	/* only set on success */
>  	refcount_set(&ghes_refcount, 1);
>  
>  unlock:
> +	if (rc < 0) {
> +		ghes_dimm_pool_destroy();
> +		pr_err("Can't register at EDAC core: %d\n", rc);

					with the EDAC core:

> +	}
> +
>  	mutex_unlock(&ghes_reg_mutex);
>  
>  	return rc;
> @@ -562,6 +647,7 @@ void ghes_edac_unregister(struct ghes *ghes)
>  {
>  	struct mem_ctl_info *mci;
>  	unsigned long flags;
> +	LIST_HEAD(dimm_list);
>  
>  	mutex_lock(&ghes_reg_mutex);
>  
> @@ -574,14 +660,19 @@ void ghes_edac_unregister(struct ghes *ghes)
>  	spin_lock_irqsave(&ghes_lock, flags);
>  	mci = ghes_pvt ? ghes_pvt->mci : NULL;
>  	ghes_pvt = NULL;
> +	list_splice_init(&ghes_dimm_list, &dimm_list);

Why do you need to do this?

Can't you simply do:

	 ghes_dimm_release(&ghes_dimm_list);

here?

Btw, please add an explanation above ghes_dimm_list and ghes_dimm_pool
what those are and what the rules are: stuff gets added on register to
what list and freed on unreg from what list, etc. So that it is clear
upon a quick glance.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
