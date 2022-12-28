Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAFC658617
	for <lists+linux-edac@lfdr.de>; Wed, 28 Dec 2022 19:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbiL1Sxf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 28 Dec 2022 13:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbiL1Sxe (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 28 Dec 2022 13:53:34 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E8515FED;
        Wed, 28 Dec 2022 10:53:31 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7B0D31EC04C1;
        Wed, 28 Dec 2022 19:53:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1672253610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HaNhDAnQUnW3eGCf7lfZiCI/y+B7ggEGtDMUKhr9xVQ=;
        b=T05EVPbnaNkNsTblWXujvigaCb+4Gge3E72SFkNqyKL/gglICltLYh5LOA2lYgaCyyI8aQ
        6BlrmV7l3QMGzgRxFhYkft6SaZsgXHXm3TC5Y60MkSIGTxaWCC9tPpjmwd23hhENglxLUX
        m/1d/fxBQv5hUMkXu3hoFHghcocvPxc=
Date:   Wed, 28 Dec 2022 19:53:25 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>, tony.luck@intel.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v6 2/4] x86/mce: Remove __mcheck_cpu_init_early()
Message-ID: <Y6yQpWtlnFmL04h6@zn.tnic>
References: <20221206173607.1185907-1-yazen.ghannam@amd.com>
 <20221206173607.1185907-3-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221206173607.1185907-3-yazen.ghannam@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Dec 06, 2022 at 11:36:05AM -0600, Yazen Ghannam wrote:
> +	mce_flags.overflow_recov = !!cpu_has(c, X86_FEATURE_OVERFLOW_RECOV);
> +	mce_flags.succor	 = !!cpu_has(c, X86_FEATURE_SUCCOR);
> +	mce_flags.smca		 = !!cpu_has(c, X86_FEATURE_SMCA);
> +	mce_flags.amd_threshold	 = 1;
>  
>  	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
>  		if (mce_flags.smca)
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 5f406d135d32..9efd6d010e2d 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1906,19 +1906,6 @@ static int __mcheck_cpu_ancient_init(struct cpuinfo_x86 *c)
>  	return 0;
>  }
>  
> -/*
> - * Init basic CPU features needed for early decoding of MCEs.
> - */
> -static void __mcheck_cpu_init_early(struct cpuinfo_x86 *c)
> -{
> -	if (c->x86_vendor == X86_VENDOR_AMD || c->x86_vendor == X86_VENDOR_HYGON) {
> -		mce_flags.overflow_recov = !!cpu_has(c, X86_FEATURE_OVERFLOW_RECOV);
> -		mce_flags.succor	 = !!cpu_has(c, X86_FEATURE_SUCCOR);
> -		mce_flags.smca		 = !!cpu_has(c, X86_FEATURE_SMCA);
> -		mce_flags.amd_threshold	 = 1;
> -	}

Yeah, looking at this, before and after the change, what we are and were
doing here is silly. Those flags are global for the whole system but we
do set them on each CPU - unnecessarily, ofc ;-\ - because we don't have
a BSP MCE init call.

That above happens on the mcheck_cpu_init() path which is per-CPU.

However, if we had to be precise and correct, this flags setup should
happen in a function called

	mcheck_bsp_init()

or so which gets called at the end of identify_boot_cpu() and which does
all the *once* actions there like allocate the gen pool, run the quirks
which need to run only once on the BSP and so on.

So that we don't have to do unnecessary work on every CPU.

Tony, thoughts?

I think we should start working towards this - doesn't have to be done
immediately but I think a proper separation of what runs where - once
on the BSP or on every CPU - is needed here. Unless I'm missing an
important angle, which is entirely possible.

Hmmm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
