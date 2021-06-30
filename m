Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0F53B87A9
	for <lists+linux-edac@lfdr.de>; Wed, 30 Jun 2021 19:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbhF3R3k (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 30 Jun 2021 13:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhF3R3i (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 30 Jun 2021 13:29:38 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50BEC061756;
        Wed, 30 Jun 2021 10:27:08 -0700 (PDT)
Received: from zn.tnic (p200300ec2f12c300d32a22941298d01c.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:c300:d32a:2294:1298:d01c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 68EEC1EC046E;
        Wed, 30 Jun 2021 19:27:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1625074027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=TznjOMhbFMgc14+LdXkaV2w6tRCRxdLm5VVhXjvmvd8=;
        b=FveZntmeUxnrwG21EvwJtW0Zgyd6foRCbseoHhSuSVclQVtzc4kUe8FRqEaxdcf4eFxw8m
        8NKv9oRZCQusCvUlPEQCDSth2qFskzN4v/AQWiU1jZ6ecElJAq4/SOleWjcP6GKeC+PBCW
        fCSA0N2Gh35RlqBf6NSLQzIVc/UJdcI=
Date:   Wed, 30 Jun 2021 19:27:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 07/31] EDAC/amd64: Define functions for DramOffset
Message-ID: <YNypa1iphyIuogtZ@zn.tnic>
References: <20210623192002.3671647-1-yazen.ghannam@amd.com>
 <20210623192002.3671647-8-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210623192002.3671647-8-yazen.ghannam@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jun 23, 2021 at 07:19:38PM +0000, Yazen Ghannam wrote:
> Add helper functions to read the DramOffset register and to remove the
> offset from the calculated address.
> 
> The helper functions will be expanded in future DF versions.
> 
> Rename the "base" variable to "map_num" to indicate that this is the
> address map number. An address map is defined with a base and limit
> value. The map_num variable is used to select the proper base and limit
> registers to use for the address translation.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
> Link:
> https://lkml.kernel.org/r/20210507190140.18854-4-Yazen.Ghannam@amd.com
> 
> v1->v2:
> * Moved from arch/x86 to EDAC.
> * Add function to data_fabric_ops.
> 
>  drivers/edac/amd64_edac.c | 57 +++++++++++++++++++++++++++++----------
>  1 file changed, 43 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index f769353ef7e4..389f0621e885 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -1079,16 +1079,26 @@ static struct df_reg df_regs[] = {
>  	[SYS_FAB_ID_MASK]	=	{1, 0x208},
>  };
>  
> +/* Use "reg_" prefix for raw register values. */
>  struct addr_ctx {
>  	u64 ret_addr;
> +	u32 reg_dram_offset;
>  	u16 nid;
>  	u8 inst_id;
> +	u8 map_num;
>  };
>  
>  struct data_fabric_ops {
> +	u64 (*get_hi_addr_offset)(struct addr_ctx *ctx);
>  };
>  
> +static u64 get_hi_addr_offset_df2(struct addr_ctx *ctx)
> +{
> +	return (ctx->reg_dram_offset & GENMASK_ULL(31, 20)) << 8;
> +}
> +
>  struct data_fabric_ops df2_ops = {

Those "df2" ops are for UMC v2? 

> +	.get_hi_addr_offset		=	&get_hi_addr_offset_df2,
						^

No need for the "&".

Also, if you define a member ->get_hi_addr_offset in df2_ops, then you
need to define that member in *every* df_ops structure you have so that
there's no NULL pointers.

I guess that's coming...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
