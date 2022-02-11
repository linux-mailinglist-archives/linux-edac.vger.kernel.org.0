Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CE34B30FA
	for <lists+linux-edac@lfdr.de>; Fri, 11 Feb 2022 23:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239438AbiBKWri (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Feb 2022 17:47:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234271AbiBKWri (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 11 Feb 2022 17:47:38 -0500
X-Greylist: delayed 12258 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Feb 2022 14:47:35 PST
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7E2D54;
        Fri, 11 Feb 2022 14:47:35 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 40DD31EC0373;
        Fri, 11 Feb 2022 23:47:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644619650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2LCnjyoUFVPe/KzjUBCJiTmbTvN8cuqDLjqJCXV4ReQ=;
        b=IxFzfRaDSnpa0XIsdWZwnQsOS1FLnRddCJ3scnDVyeT2ISmvJvhZVz6i7pxf2Qftqlvzps
        zaZJ+UKNXLX/8b7M17TUgCNqtU1tfsM9uvJABVTKFtFWaQC3D+Ure7KZ1uuvoyzlGLGKrY
        PQHawl9oV8uDr6CfcsvIxrESQebaOLk=
Date:   Fri, 11 Feb 2022 23:47:31 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v4 07/24] EDAC/amd64: Define function to dehash address
Message-ID: <Ygbng0RZ0Pu1fOFj@zn.tnic>
References: <20220127204115.384161-1-yazen.ghannam@amd.com>
 <20220127204115.384161-8-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220127204115.384161-8-yazen.ghannam@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jan 27, 2022 at 08:40:58PM +0000, Yazen Ghannam wrote:
> Move the dehashing code into a separate helper function. Define a
> DF2-specific function for the current code. Specific helper functions
> will be added for future DF versions.
> 
> The dehashing function used is based on the interleaving mode rather
> than the Data Fabric version. So save the function pointer in the
> context struct. The use of "df2" in the name of the current function is
> only because the interleaving mode using it only appears on Data Fabric
> 2 systems.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
> Link:
> https://lore.kernel.org/r/20211028175728.121452-12-yazen.ghannam@amd.com
> 
> v3->v4:
> * Include pr_debug() on failure.
> 
> v2->v3:
> * Was patch 12 in v2.
> 
> v1->v2:
> * Moved from arch/x86 to EDAC.
> * Add new function pointer in ctx struct.
> 
>  drivers/edac/amd64_edac.c | 36 +++++++++++++++++++++---------------
>  1 file changed, 21 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 350204eadb27..da2d0d9ce406 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -1077,7 +1077,7 @@ struct addr_ctx {
>  	u8 map_num;
>  	u8 intlv_addr_bit;
>  	u8 cs_id;
> -	bool hash_enabled;
> +	int (*dehash_addr)(struct addr_ctx *ctx);

A function pointer in a context struct?!

> @@ -1357,18 +1372,9 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
>  		goto out_err;
>  	}
>  
> -	if (ctx.hash_enabled) {
> -		/* Save some parentheses and grab ls-bit at the end. */
> -		hashed_bit =	(ctx.ret_addr >> 12) ^
> -				(ctx.ret_addr >> 18) ^
> -				(ctx.ret_addr >> 21) ^
> -				(ctx.ret_addr >> 30) ^
> -				ctx.cs_id;
> -
> -		hashed_bit &= BIT(0);
> -
> -		if (hashed_bit != ((ctx.ret_addr >> ctx.intlv_addr_bit) & BIT(0)))
> -			ctx.ret_addr ^= BIT(ctx.intlv_addr_bit);
> +	if (ctx.dehash_addr && ctx.dehash_addr(&ctx)) {

So you can just as well do:

	if (ctx->intlv_mode == 8)
		dehash_addr();

And dehash_addr() can inside determine whether df2 or df3.

Btw, that 8 looks like magic. It should be a #define.

What you have now looks a bit weird with those function pointers lumped
together with those other members of addr_ctx. Dunno, maybe it'll make
more sense when I read the rest first...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
