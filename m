Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE1D6C74B4
	for <lists+linux-edac@lfdr.de>; Fri, 24 Mar 2023 01:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjCXAt3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 Mar 2023 20:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCXAt2 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 23 Mar 2023 20:49:28 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EA27D87;
        Thu, 23 Mar 2023 17:49:27 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 198EA1EC064A;
        Fri, 24 Mar 2023 01:49:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1679618966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=IVrYt4QZLSPAFEiRfM7Jzfmm4ikmM8iLWSRtNyBat5g=;
        b=PZdrYyx7FE02Rb2Uf1F+AaLCPj70y0u1dCzgxuIUu4+NLhJ3zv39/mpY+AuLC1nxbmvfJQ
        kZE3q11iYZMyDdWnc4TxpIY8U+GJsRxEckEc3KJ8yj1K/eU1VkkIr+LZpNPY5vEfPsADxV
        pnzZYVatIoKbhb1/t+IQNKYBKpTnCVE=
Date:   Fri, 24 Mar 2023 01:49:19 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     kyle-meyer <kyle.meyer@hpe.com>
Cc:     dimitri.sivanich@hpe.com, steve.wahl@hpe.com, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, tony.luck@intel.com, qiuxu.zhuo@intel.com,
        yazen.ghannam@amd.com, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH] RAS/CEC: Move non-debug attributes out of debugfs
Message-ID: <20230324004919.GHZBzzj1FzwEZclTCL@fat_crate.local>
References: <20230323202158.37937-1-kyle.meyer@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230323202158.37937-1-kyle.meyer@hpe.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Mar 23, 2023 at 03:22:01PM -0500, kyle-meyer wrote:
> From: Kyle Meyer <kyle.meyer@hpe.com>
> 
> When kernel lockdown is in effect, use of debugfs is not permitted. Move
> decay_interval and action_threshold out of debugfs, from debugfs/ras/cec
> to sysfs/system/devices/machinecheck/cec.

All those knobs are in debugfs because we wanted to discuss the proper
interface design first and only then cast them in stone. I guess that
has not happened yet.

What you're doing is certainly not what we had in mind so just because
some lockdown policy says so, is not good enough.

> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 2eec60f50057..1a3eaa501ae4 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -2376,10 +2376,11 @@ static void mce_enable_ce(void *all)
>  		__mcheck_cpu_init_timer();
>  }
>  
> -static struct bus_type mce_subsys = {
> +struct bus_type mce_subsys = {
>  	.name		= "machinecheck",
>  	.dev_name	= "machinecheck",
>  };
> +EXPORT_SYMBOL_GPL(mce_subsys);

Nope, this is not going to happen.

Besides, that error collector is used on x86 but it is generic enough so
that it can be used by other arches. So if anything, it should not be
exposed in the x86's "machinecheck" hierarchy but somewhere generic.

And until that proper interface has been hammered out, you can just as
well disable it in your lockdown configs.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
