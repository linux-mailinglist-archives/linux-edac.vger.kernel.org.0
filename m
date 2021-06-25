Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1993C3B4682
	for <lists+linux-edac@lfdr.de>; Fri, 25 Jun 2021 17:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhFYPXf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 25 Jun 2021 11:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhFYPXf (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 25 Jun 2021 11:23:35 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B5DC061574;
        Fri, 25 Jun 2021 08:21:14 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0dae005eaeb42c95705db7.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:ae00:5eae:b42c:9570:5db7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5DD221EC03F0;
        Fri, 25 Jun 2021 17:21:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1624634473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0PTZ7p2IQbsEzDy2yLK9UqDrnt3n2Qm1Q8c2B02Mvy0=;
        b=XSoxFJvgTaxVEiF2XchzNvwpVOCDNMxyVszXEwiNrQR5EpxoNKSbR4WJVX0rJXubFfbhzK
        3BRJZLMKgK0RztHACYj65TUCZ147cPDcWcNAqyMCpaGiwvAe+RBcwbh+1abRetmqNshme1
        QPU7nU2J5Iku3q9c+nKMnd4z/6EvyX4=
Date:   Fri, 25 Jun 2021 17:21:08 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 03/31] EDAC/amd64: Don't use naked values for DF
 registers
Message-ID: <YNX0ZLRSLgmm2LiA@zn.tnic>
References: <20210623192002.3671647-1-yazen.ghannam@amd.com>
 <20210623192002.3671647-4-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210623192002.3671647-4-yazen.ghannam@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jun 23, 2021 at 07:19:34PM +0000, Yazen Ghannam wrote:
> +static struct df_reg df_regs[] = {
> +	/* D18F0x50 (FabricBlockInstanceInformation3_CS) */
> +	[FAB_BLK_INST_INFO_3]	=	{0, 0x50},
> +	/* D18F0x104 (DramHoleControl) */
> +	[DRAM_HOLE_CTL]		=	{0, 0x104},
> +	/* D18F0x110 (DramBaseAddress) */
> +	[DRAM_BASE_ADDR]	=	{0, 0x110},
> +	/* D18F0x114 (DramLimitAddress) */
> +	[DRAM_LIMIT_ADDR]	=	{0, 0x114},
> +	/* D18F0x1B4 (DramOffset) */
> +	[DRAM_OFFSET]		=	{0, 0x1B4},
> +	/* D18F1x208 (SystemFabricIdMask) */
> +	[SYS_FAB_ID_MASK]	=	{1, 0x208},
> +};
> +
>  static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
>  {
>  	u64 dram_base_addr, dram_limit_addr, dram_hole_base;
> @@ -1059,8 +1091,9 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
>  	u8 cs_mask, cs_id = 0;
>  	bool hash_enabled = false;
>  
> -	/* Read D18F0x1B4 (DramOffset), check if base 1 is used. */
> -	if (amd_df_indirect_read(nid, 0, 0x1B4, umc, &tmp))
> +	struct df_reg reg;
> +
> +	if (amd_df_indirect_read(nid, df_regs[DRAM_OFFSET], umc, &tmp))
>  		goto out_err;
>  
>  	/* Remove HiAddrOffset from normalized address, if enabled: */
> @@ -1073,8 +1106,9 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
>  		}
>  	}
>  
> -	/* Read D18F0x110 (DramBaseAddress). */
> -	if (amd_df_indirect_read(nid, 0, 0x110 + (8 * base), umc, &tmp))
> +	reg = df_regs[DRAM_BASE_ADDR];
> +	reg.offset += base * 8;

So this looks weird: you have a df_regs[] array of all those different
DF registers which I'd assume is a read-only thing because, well, those
func and offset things are immutable, i.e., hw registers offsets etc.

But then here you go and and modify the offset.

And that df_regs array is globally visible in the driver and if some
later functionality decides to use it, it'll see the modified offset.

IOW, I'd make that array read only (const) and use local vars instead to
pass down to amd_df_indirect_read().

And I'm also questioning what the point is for that df_reg thing?

You have them defined but then you have to change them.

I.e., you can just as well pass in func and offset separately and be
done with it.

But maybe there's something else happening in the patches which comes
later and which will make me go, ahaa.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
