Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055C73B8788
	for <lists+linux-edac@lfdr.de>; Wed, 30 Jun 2021 19:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbhF3RUR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 30 Jun 2021 13:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhF3RUR (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 30 Jun 2021 13:20:17 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E575BC061756;
        Wed, 30 Jun 2021 10:17:47 -0700 (PDT)
Received: from zn.tnic (p200300ec2f12c300d32a22941298d01c.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:c300:d32a:2294:1298:d01c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4F3161EC046E;
        Wed, 30 Jun 2021 19:17:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1625073466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lZkWfm5u08oDdFUR6N+KHOvVmnsC24sm5yc+HxeB/CY=;
        b=ldHx2lzmiOHxUFziw6arVd4BG2SyN/yZtPY3lsNNSX+TrqizOvZUohfsFjCxugP2u5JEOw
        WHp4EICXAI/oleuPVK7/8WR5UUZDFmGdRM0Js4KjtoBeAF0b2X1viO9PZm6lWLAY0Jbv+A
        QODloyCYzYOjlXa+UX3sEF5oVUr5pZ8=
Date:   Wed, 30 Jun 2021 19:17:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 05/31] EDAC/amd64: Add context struct
Message-ID: <YNynNc9oMZVnri8X@zn.tnic>
References: <20210623192002.3671647-1-yazen.ghannam@amd.com>
 <20210623192002.3671647-6-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210623192002.3671647-6-yazen.ghannam@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jun 23, 2021 at 07:19:36PM +0000, Yazen Ghannam wrote:
> Define an address translation context struct. This will hold values that
> will be passed between multiple functions.
> 
> Save return address, Node ID, and the Instance ID number to start.
> Currently, we use the UMC number as the Instance ID, but future DF

Please use passive voice in your commit message: no "we" or "I", etc.

And this here is a perfect example: it sounds here like "we" is "AMD"
but we use "we" mostly for the kernel. And there's the confusion.

So please teach yourself to formulate those commit messages properly -
the future you will thank you, trust me!

:-)

> versions may use another value.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
> Link:
> https://lkml.kernel.org/r/20210507190140.18854-3-Yazen.Ghannam@amd.com
> 
> v1->v2:
> * Moved from arch/x86 to EDAC.
> * Changed "umc" variable to "inst_id".
> * Drop df_types enum.
> 
>  drivers/edac/amd64_edac.c | 49 +++++++++++++++++++++++++--------------
>  1 file changed, 31 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index d67cd8f57b94..62eca188458f 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -1079,12 +1079,15 @@ static struct df_reg df_regs[] = {
>  	[SYS_FAB_ID_MASK]	=	{1, 0x208},
>  };
>  
> +struct addr_ctx {
> +	u64 ret_addr;
> +	u16 nid;
> +	u8 inst_id;
> +};
> +
>  static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
>  {
>  	u64 dram_base_addr, dram_limit_addr, dram_hole_base;
> -	/* We start from the normalized address */
> -	u64 ret_addr = norm_addr;
> -
>  	u32 tmp;
>  
>  	u8 die_id_shift, die_id_mask, socket_id_shift, socket_id_mask;
> @@ -1097,6 +1100,16 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
>  
>  	struct df_reg reg;
>  
> +	struct addr_ctx ctx;

Those empty-lines spaced-out local vars look weird.

> +	memset(&ctx, 0, sizeof(ctx));
> +
> +	/* We start from the normalized address */
> +	ctx.ret_addr = norm_addr;
> +
> +	ctx.nid = nid;
> +	ctx.inst_id = umc;
> +
>  	if (amd_df_indirect_read(nid, df_regs[DRAM_OFFSET], umc, &tmp))
>  		goto out_err;
>  
> @@ -1105,7 +1118,7 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
>  		u64 hi_addr_offset = (tmp & GENMASK_ULL(31, 20)) << 8;
>  
>  		if (norm_addr >= hi_addr_offset) {
> -			ret_addr -= hi_addr_offset;
> +			ctx.ret_addr -= hi_addr_offset;
>  			base = 1;
>  		}
>  	}
> @@ -1236,14 +1249,14 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
>  		 * bits there are. "intlv_addr_bit" tells us how many "Y" bits
>  		 * there are (where "I" starts).
>  		 */
> -		temp_addr_y = ret_addr & GENMASK_ULL(intlv_addr_bit-1, 0);
> +		temp_addr_y = ctx.ret_addr & GENMASK_ULL(intlv_addr_bit - 1, 0);
>  		temp_addr_i = (cs_id << intlv_addr_bit);
> -		temp_addr_x = (ret_addr & GENMASK_ULL(63, intlv_addr_bit)) << num_intlv_bits;
> -		ret_addr    = temp_addr_x | temp_addr_i | temp_addr_y;
> +		temp_addr_x = (ctx.ret_addr & GENMASK_ULL(63, intlv_addr_bit)) << num_intlv_bits;
> +		ctx.ret_addr    = temp_addr_x | temp_addr_i | temp_addr_y;

You want to align those vertically on the "=" for better readability.

>  	}
>  
>  	/* Add dram base address */
> -	ret_addr += dram_base_addr;
> +	ctx.ret_addr += dram_base_addr;
>  
>  	/* If legacy MMIO hole enabled */
>  	if (lgcy_mmio_hole_en) {
> @@ -1251,29 +1264,29 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
>  			goto out_err;
>  
>  		dram_hole_base = tmp & GENMASK(31, 24);
> -		if (ret_addr >= dram_hole_base)
> -			ret_addr += (BIT_ULL(32) - dram_hole_base);
> +		if (ctx.ret_addr >= dram_hole_base)
> +			ctx.ret_addr += (BIT_ULL(32) - dram_hole_base);
>  	}
>  
>  	if (hash_enabled) {
>  		/* Save some parentheses and grab ls-bit at the end. */
> -		hashed_bit =	(ret_addr >> 12) ^
> -				(ret_addr >> 18) ^
> -				(ret_addr >> 21) ^
> -				(ret_addr >> 30) ^
> +		hashed_bit =	(ctx.ret_addr >> 12) ^
> +				(ctx.ret_addr >> 18) ^
> +				(ctx.ret_addr >> 21) ^
> +				(ctx.ret_addr >> 30) ^
>  				cs_id;
>  
>  		hashed_bit &= BIT(0);
>  
> -		if (hashed_bit != ((ret_addr >> intlv_addr_bit) & BIT(0)))
> -			ret_addr ^= BIT(intlv_addr_bit);
> +		if (hashed_bit != ((ctx.ret_addr >> intlv_addr_bit) & BIT(0)))
> +			ctx.ret_addr ^= BIT(intlv_addr_bit);
>  	}
>  
>  	/* Is calculated system address is above DRAM limit address? */
> -	if (ret_addr > dram_limit_addr)
> +	if (ctx.ret_addr > dram_limit_addr)
>  		goto out_err;
>  
> -	*sys_addr = ret_addr;
> +	*sys_addr = ctx.ret_addr;

So adding ctx to exchange data between functions - that was a good idea.

But what this patch does is pointless because you simply replace those
variables with a local struct.

I guess the aha moment will come with the later patches when you start
passing it around to functions.

/me waits to see.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
