Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C075A44C62C
	for <lists+linux-edac@lfdr.de>; Wed, 10 Nov 2021 18:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbhKJRsu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 10 Nov 2021 12:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbhKJRst (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 10 Nov 2021 12:48:49 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E360FC061764;
        Wed, 10 Nov 2021 09:46:01 -0800 (PST)
Received: from zn.tnic (p200300ec2f111e00f6c7178ba52ca674.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:1e00:f6c7:178b:a52c:a674])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D5D851EC0518;
        Wed, 10 Nov 2021 18:45:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636566360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XMzH8vzJGscXn4F/jj+KM/WhSx8MT3vmGW3aedq6tfM=;
        b=cFp0B91prEHBhCvgtxT4/V/543Wiio8VV3RC/pF8qZoHgOeUzjScyoDpFI76vLSIfED/MW
        rctLEFiQPTf80h0I4Rj9jputpuDhh5GN8S0y5ldsXjXlTJYXnEDyDyKyuFgKs0rC9K/0BP
        6GjdRd0DECVbLkuzW4f0GtU8Of2qZik=
Date:   Wed, 10 Nov 2021 18:45:53 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, mchehab@kernel.org,
        yazen.ghannam@amd.com, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH v6 3/5] EDAC/amd64: Extend family ops functions
Message-ID: <YYwFUYDl8wvO02wL@zn.tnic>
References: <20211028130106.15701-1-nchatrad@amd.com>
 <20211028130106.15701-4-nchatrad@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211028130106.15701-4-nchatrad@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Oct 28, 2021 at 06:31:04PM +0530, Naveen Krishna Chatradhi wrote:
> @@ -1217,28 +1214,39 @@ static void dump_misc_regs(struct amd64_pvt *pvt)
>  /*
>   * See BKDG, F2x[1,0][5C:40], F2[1,0][6C:60]
>   */
> -static void prep_chip_selects(struct amd64_pvt *pvt)
> +static void k8_prep_chip_selects(struct amd64_pvt *pvt)
>  {
>  	if (pvt->fam == 0xf && pvt->ext_model < K8_REV_F) {
>  		pvt->csels[0].b_cnt = pvt->csels[1].b_cnt = 8;
>  		pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 8;
> -	} else if (pvt->fam == 0x15 && pvt->model == 0x30) {
> -		pvt->csels[0].b_cnt = pvt->csels[1].b_cnt = 4;
> -		pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 2;
> -	} else if (pvt->fam >= 0x17) {
> -		int umc;
> -
> -		for_each_umc(umc) {
> -			pvt->csels[umc].b_cnt = 4;
> -			pvt->csels[umc].m_cnt = 2;
> -		}
> -
> -	} else {
> +	} else if (pvt->fam == 0xf && pvt->ext_model >= K8_REV_F) {
>  		pvt->csels[0].b_cnt = pvt->csels[1].b_cnt = 8;
>  		pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 4;
>  	}

Why is this function looking at the family if it is called a k8_...
function which will be set only on K8?

>  }
>  
> +static void f15m30_prep_chip_selects(struct amd64_pvt *pvt)
> +{
> +	pvt->csels[0].b_cnt = pvt->csels[1].b_cnt = 4;
> +	pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 2;
> +}
> +
> +static void default_prep_chip_selects(struct amd64_pvt *pvt)
> +{
> +	pvt->csels[0].b_cnt = pvt->csels[1].b_cnt = 8;
> +	pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 4;
> +}
> +
> +static void f17_prep_chip_selects(struct amd64_pvt *pvt)
> +{
> +	int umc;
> +
> +	for_each_umc(umc) {
> +		pvt->csels[umc].b_cnt = 4;
> +		pvt->csels[umc].m_cnt = 2;
> +	}
> +}
> +
>  static void read_umc_base_mask(struct amd64_pvt *pvt)
>  {
>  	u32 umc_base_reg, umc_base_reg_sec;
> @@ -1297,11 +1305,6 @@ static void read_dct_base_mask(struct amd64_pvt *pvt)
>  {
>  	int cs;
>  
> -	prep_chip_selects(pvt);
> -
> -	if (pvt->umc)
> -		return read_umc_base_mask(pvt);
> -
>  	for_each_chip_select(cs, 0, pvt) {
>  		int reg0   = DCSB0 + (cs * 4);
>  		int reg1   = DCSB1 + (cs * 4);
> @@ -2512,143 +2515,181 @@ static void debug_display_dimm_sizes(struct amd64_pvt *pvt, u8 ctrl)
>  	}
>  }
>  
> +/* Prototypes for family specific ops routines */
> +static int init_csrows(struct mem_ctl_info *mci);
> +static int init_csrows_df(struct mem_ctl_info *mci);
> +static void read_mc_regs(struct amd64_pvt *pvt);
> +static void __read_mc_regs_df(struct amd64_pvt *pvt);
> +static void update_umc_err_info(struct mce *m, struct err_info *err);

Prototypes belong in headers.

> +
> +static const struct low_ops k8_ops = {

So if you're going to do this, you can go a step further and get rid of
all those static definitions which are completely unused except those of
the current family we're loaded on.

IOW, you should make all family-specific assignments dynamic and get rid
of family_types and those ops. Here's an example I did for K8:

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 1029fe84ba2e..5f1686f22947 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3656,8 +3656,18 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
 
        switch (pvt->fam) {
        case 0xf:
-               fam_type        = &family_types[K8_CPUS];
-               pvt->ops        = &family_types[K8_CPUS].ops;
+               fam_type->ctl_name              = "K8";
+               fam_type->f1_id                 = PCI_DEVICE_ID_AMD_K8_NB_ADDRMAP;
+               fam_type->f2_id                 = PCI_DEVICE_ID_AMD_K8_NB_MEMCTL;
+               fam_type->max_mcs               = 2;
+               pvt->ops->early_channel_count   = k8_early_channel_count;
+               pvt->ops->map_sysaddr_to_csrow  = k8_map_sysaddr_to_csrow;
+               pvt->ops->dbam_to_cs            = k8_dbam_to_chip_select;
+               pvt->ops->prep_chip_select      = k8_prep_chip_selects;
+               pvt->ops->get_base_mask         = read_dct_base_mask;
+               pvt->ops->get_misc_regs         = __dump_misc_regs;
+               pvt->ops->get_mc_regs           = read_mc_regs;
+               pvt->ops->populate_csrows       = init_csrows;
                break;
 
        case 0x10:

After that, pvt and fam_type have been properly set up.

> @@ -3735,7 +3784,16 @@ static int hw_info_get(struct amd64_pvt *pvt)
>  	if (ret)
>  		return ret;
>  
> -	read_mc_regs(pvt);
> +	pvt->ops->get_mc_regs(pvt);
> +
> +	pvt->ops->prep_chip_select(pvt);
> +
> +	pvt->ops->get_base_mask(pvt);
> +
> +	determine_memory_type(pvt);
> +	edac_dbg(1, "  DIMM type: %s\n", edac_mem_types[pvt->dram_type]);

Move that dbg call at the end of determine_memory_type().

> +
> +	determine_ecc_sym_sz(pvt);
>  
>  	return 0;
>  }
> @@ -3786,7 +3844,7 @@ static int init_one_instance(struct amd64_pvt *pvt)
>  
>  	setup_mci_misc_attrs(mci);
>  
> -	if (init_csrows(mci))
> +	if (pvt->ops->populate_csrows(mci))
>  		mci->edac_cap = EDAC_FLAG_NONE;
>  
>  	ret = -ENODEV;
> diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
> index 85aa820bc165..881ff6322bc9 100644
> --- a/drivers/edac/amd64_edac.h
> +++ b/drivers/edac/amd64_edac.h
> @@ -467,11 +467,17 @@ struct ecc_settings {
>   * functions and per device encoding/decoding logic.
>   */
>  struct low_ops {
> -	int (*early_channel_count)	(struct amd64_pvt *pvt);
> +	int  (*early_channel_count)	(struct amd64_pvt *pvt);
>  	void (*map_sysaddr_to_csrow)	(struct mem_ctl_info *mci, u64 sys_addr,
>  					 struct err_info *);
> -	int (*dbam_to_cs)		(struct amd64_pvt *pvt, u8 dct,
> +	int  (*dbam_to_cs)		(struct amd64_pvt *pvt, u8 dct,
>  					 unsigned cs_mode, int cs_mask_nr);
> +	void (*prep_chip_select)	(struct amd64_pvt *pvt);

That name should be "prep_chip_selects" - plural.

> +	void (*get_base_mask)		(struct amd64_pvt *pvt);
> +	void (*get_misc_regs)		(struct amd64_pvt *pvt);
> +	void (*get_mc_regs)		(struct amd64_pvt *pvt);
> +	int  (*populate_csrows)		(struct mem_ctl_info *mci);
> +	void (*get_umc_err_info)	(struct mce *m, struct err_info *err);

WARNING: Unnecessary space before function pointer arguments
#652: FILE: drivers/edac/amd64_edac.h:470:
+	int  (*early_channel_count)	(struct amd64_pvt *pvt);

WARNING: Unnecessary space before function pointer arguments
#656: FILE: drivers/edac/amd64_edac.h:473:
+	int  (*dbam_to_cs)		(struct amd64_pvt *pvt, u8 dct,

WARNING: Unnecessary space before function pointer arguments
#658: FILE: drivers/edac/amd64_edac.h:475:
+	void (*prep_chip_select)	(struct amd64_pvt *pvt);

WARNING: Unnecessary space before function pointer arguments
#659: FILE: drivers/edac/amd64_edac.h:476:
+	void (*get_base_mask)		(struct amd64_pvt *pvt);

WARNING: Unnecessary space before function pointer arguments
#660: FILE: drivers/edac/amd64_edac.h:477:
+	void (*get_misc_regs)		(struct amd64_pvt *pvt);

WARNING: Unnecessary space before function pointer arguments
#661: FILE: drivers/edac/amd64_edac.h:478:
+	void (*get_mc_regs)		(struct amd64_pvt *pvt);

WARNING: Unnecessary space before function pointer arguments
#662: FILE: drivers/edac/amd64_edac.h:479:
+	int  (*populate_csrows)		(struct mem_ctl_info *mci);

WARNING: Unnecessary space before function pointer arguments
#663: FILE: drivers/edac/amd64_edac.h:480:
+	void (*get_umc_err_info)	(struct mce *m, struct err_info *err);

total: 0 errors, 8 warnings, 507 lines checked


Please integrate scripts/checkpatch.pl into your patch creation
workflow. Some of the warnings/errors *actually* make sense.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
