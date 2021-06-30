Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4353B8798
	for <lists+linux-edac@lfdr.de>; Wed, 30 Jun 2021 19:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbhF3RWP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 30 Jun 2021 13:22:15 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59478 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229963AbhF3RWP (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 30 Jun 2021 13:22:15 -0400
Received: from zn.tnic (p200300ec2f12c300d32a22941298d01c.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:c300:d32a:2294:1298:d01c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7A3731EC046E;
        Wed, 30 Jun 2021 19:19:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1625073585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=syI5n/mgumSxP3cXwbe5EO+1+eQv1oVSzGSYKAY8H7g=;
        b=SlpZ0VlFkPFToeVN1iWtPvSyrWP7p9oyaGFJIzxrtvApfrjOHt92zKNj8gK7GFVFYb9BYE
        Kacay/dfnA/sUnpchO9nINqt+qtBzCP9czo/putShdSwmglUcOKbkfdEUQ5Z1W65I/gkmg
        yiHUGMWMoNrTL56JA7N3MGY2MHPifw8=
Date:   Wed, 30 Jun 2021 19:19:45 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 06/31] EDAC/amd64: Define Data Fabric operations
Message-ID: <YNynsT6J1NTddv0z@zn.tnic>
References: <20210623192002.3671647-1-yazen.ghannam@amd.com>
 <20210623192002.3671647-7-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210623192002.3671647-7-yazen.ghannam@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jun 23, 2021 at 07:19:37PM +0000, Yazen Ghannam wrote:
> Define a stub to hold operations for different Data Fabric versions.
> This will be filled in following patches.
> 
> Define a function to set the appropriate operations. Use a return code
> because future updates have checks that may fail.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
> Link:
> https://lkml.kernel.org/r/20210507190140.18854-3-Yazen.Ghannam@amd.com
> 
> v1->v2:
> * New in v2.
> 
>  drivers/edac/amd64_edac.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 62eca188458f..f769353ef7e4 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -1085,6 +1085,21 @@ struct addr_ctx {
>  	u8 inst_id;
>  };
>  
> +struct data_fabric_ops {
> +};
> +
> +struct data_fabric_ops df2_ops = {
> +};
> +
> +struct data_fabric_ops *df_ops;
> +
> +static int set_df_ops(struct addr_ctx *ctx)
> +{
> +	df_ops = &df2_ops;
> +
> +	return 0;
> +}
> +
>  static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
>  {
>  	u64 dram_base_addr, dram_limit_addr, dram_hole_base;
> @@ -1110,6 +1125,9 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
>  	ctx.nid = nid;
>  	ctx.inst_id = umc;
>  
> +	if (set_df_ops(&ctx))
> +		return -EINVAL;
> +
>  	if (amd_df_indirect_read(nid, df_regs[DRAM_OFFSET], umc, &tmp))
>  		goto out_err;
>  
> -- 

Why?

You can simply assign to df_ops as this is all driver-static data.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
