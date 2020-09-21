Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8F1272665
	for <lists+linux-edac@lfdr.de>; Mon, 21 Sep 2020 15:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgIUN61 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 21 Sep 2020 09:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgIUN6Y (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 21 Sep 2020 09:58:24 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0FAC061755;
        Mon, 21 Sep 2020 06:58:23 -0700 (PDT)
Received: from zn.tnic (p200300ec2f07e300be7bcf3e7fc25083.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:e300:be7b:cf3e:7fc2:5083])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 784F61EC03CE;
        Mon, 21 Sep 2020 15:58:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600696702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=d06x5TqtnNiH9Kt79EMMPddIKI/nF54f7588TlbfKnw=;
        b=hIk76tPSRPkMfQPYuXeScjMCrAGP0emWurfVxuiodcTgesUBC9YXrJSPFjnVc4i6b31MCU
        Gqs5kWZkyfi1cfOSd+oKK59LbKMmye0r+vSwkuk6piD4vkh/tGxtJEoewEmbYyYQbBNbym
        KipGX8XpyodbV6h9MALNzthPKTLzjjA=
Date:   Mon, 21 Sep 2020 15:58:21 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 5/8] x86/MCE/AMD: Use macros to get bitfields in
 translation code
Message-ID: <20200921135821.GH5901@zn.tnic>
References: <20200903200144.310991-1-Yazen.Ghannam@amd.com>
 <20200903200144.310991-6-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200903200144.310991-6-Yazen.Ghannam@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Sep 03, 2020 at 08:01:41PM +0000, Yazen Ghannam wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Define macros to get individual bits and bitfields. Use these to make
> the code more readable.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
> Link:
> https://lkml.kernel.org/r/20200814191449.183998-3-Yazen.Ghannam@amd.com
> 
> v1 -> v2:
> * New patch based on comments for v1 Patch 2.
> 
>  arch/x86/kernel/cpu/mce/amd.c | 46 +++++++++++++++++------------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> index 1e0510fd5afc..90c3ad61ae19 100644
> --- a/arch/x86/kernel/cpu/mce/amd.c
> +++ b/arch/x86/kernel/cpu/mce/amd.c
> @@ -675,6 +675,9 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
>  		deferred_error_interrupt_enable(c);
>  }
>  
> +#define get_bits(x, msb, lsb)	((x & GENMASK_ULL(msb, lsb)) >> lsb)
> +#define get_bit(x, bit)		((x >> bit) & BIT(0))
> +
>  #define DF_F0_FABRICINSTINFO3	0x50
>  #define DF_F0_MMIOHOLE		0x104
>  #define DF_F0_DRAMBASEADDR	0x110
> @@ -704,7 +707,7 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
>  
>  	/* Remove HiAddrOffset from normalized address, if enabled: */
>  	if (tmp & BIT(0)) {
> -		u64 hi_addr_offset = (tmp & GENMASK_ULL(31, 20)) << 8;
> +		u64 hi_addr_offset = get_bits(tmp, 31, 20) << 28;
>  
>  		/* Check if base 1 is used. */
>  		if (norm_addr >= hi_addr_offset) {
> @@ -723,10 +726,10 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
>  		goto out_err;
>  	}
>  
> -	lgcy_mmio_hole_en = tmp & BIT(1);
> -	intlv_num_chan	  = (tmp >> 4) & 0xF;
> -	intlv_addr_sel	  = (tmp >> 8) & 0x7;
> -	dram_base_addr	  = (tmp & GENMASK_ULL(31, 12)) << 16;
> +	lgcy_mmio_hole_en = get_bit(tmp, 1);
> +	intlv_num_chan	  = get_bits(tmp, 7, 4);
> +	intlv_addr_sel	  = get_bits(tmp, 10, 8);
> +	dram_base_addr	  = get_bits(tmp, 31, 12) << 28;

I can't say that those macros make it more readable. Now I have to go
lookup what the arguments are. I guess I can imagine what the msb and
lsb is but meh...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
