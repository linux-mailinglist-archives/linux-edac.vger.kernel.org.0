Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C38D495EF8
	for <lists+linux-edac@lfdr.de>; Fri, 21 Jan 2022 13:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380341AbiAUMZi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 21 Jan 2022 07:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380326AbiAUMZg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 21 Jan 2022 07:25:36 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E649C061574;
        Fri, 21 Jan 2022 04:25:35 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 44A1C1EC0606;
        Fri, 21 Jan 2022 13:25:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642767928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0yQ74R3NaNtXXiWLWuDtVTd005DK5LpC2uXC3cyXYk4=;
        b=nYvxqep4R7UqYo06jtTajr6nqpQb+zu2NmtQ8OYSnbeVqSOp/bOhp1m31WOoLPm6GWxulH
        3bhGfzAlN9Mtp3TzyBBSRyMUQZpYbziDnVNjYVdVjcxZcW8OP6vWe2cPPS5Ny+4q79Z+nX
        O7z5nMKvUAFKvjrJkbEqfqKFFwMlmWk=
Date:   Fri, 21 Jan 2022 13:25:21 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, Smita.KoralahalliChannabasappa@amd.com,
        william.roche@oracle.com
Subject: Re: [PATCH v3 2/2] EDAC/amd64: Add new register offset support and
 related changes
Message-ID: <YeqmMcOSpjgHwYFD@zn.tnic>
References: <20211228200615.412999-1-yazen.ghannam@amd.com>
 <20211228200615.412999-3-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211228200615.412999-3-yazen.ghannam@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Dec 28, 2021 at 08:06:15PM +0000, Yazen Ghannam wrote:
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 4db92c77276f..a299c361a904 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -15,6 +15,31 @@ static struct msr __percpu *msrs;
>  
>  static struct amd64_family_type *fam_type;
>  
> +/* Family flag helpers */
> +static inline u64 get_addr_cfg(void)
> +{
> +	if (fam_type->flags.zn_regs_v2)
> +		return UMCCH_ADDR_CFG_DDR5;
> +
> +	return UMCCH_ADDR_CFG;
> +}
> +
> +static inline u64 get_addr_mask_sec(void)
> +{
> +	if (fam_type->flags.zn_regs_v2)
> +		return UMCCH_ADDR_MASK_SEC_DDR5;
> +
> +	return UMCCH_ADDR_MASK_SEC;
> +}
> +
> +static inline u64 get_dimm_cfg(void)
> +{
> +	if (fam_type->flags.zn_regs_v2)
> +		return UMCCH_DIMM_CFG_DDR5;
> +
> +	return UMCCH_DIMM_CFG;
> +}

Yeah, you can do it either this way and have a lot of small functions
or you can do what I did with mca_msr_reg() which is a single mapping
function you then use everywhere.

Your call.

> +
>  /* Per-node stuff */
>  static struct ecc_settings **ecc_stngs;
>  
> @@ -1429,8 +1454,10 @@ static void __dump_misc_regs_df(struct amd64_pvt *pvt)
>  		edac_dbg(1, "UMC%d x16 DIMMs present: %s\n",
>  				i, (umc->dimm_cfg & BIT(7)) ? "yes" : "no");
>  
> -		if (pvt->dram_type == MEM_LRDDR4) {
> -			amd_smn_read(pvt->mc_node_id, umc_base + UMCCH_ADDR_CFG, &tmp);
> +		if (pvt->dram_type == MEM_LRDDR4 || pvt->dram_type == MEM_LRDDR5) {

This still keeps the ->dram_type per pvt, which is per memory controller
in amd64_edac nomenclature.

But AFAIR, we said last time that the DRAM type is per UMC now, as you
do in the previous patch.

Which means, you either have to test umc->dimm_cfg to get the DRAM type
here or push ->dram_type into the umc struct...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
