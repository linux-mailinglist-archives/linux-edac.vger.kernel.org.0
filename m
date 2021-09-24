Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5309A416DBB
	for <lists+linux-edac@lfdr.de>; Fri, 24 Sep 2021 10:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244655AbhIXI2g (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 24 Sep 2021 04:28:36 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52902 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244692AbhIXI2f (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 24 Sep 2021 04:28:35 -0400
Received: from zn.tnic (p200300ec2f0dd600c2485b7778a62ff5.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:d600:c248:5b77:78a6:2ff5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5679F1EC0301;
        Fri, 24 Sep 2021 10:26:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632472017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=bHMJS/aYXU9qw9zIv9pZZwDh/cCLOLB5X5GoNoeX9vo=;
        b=W4yJdlgqBzi5H0z5kuAc7jGN3hOJFaAm3WA1VGMNO5mXT1u6rQbb3Y6o7vKGhHYy+DlBWc
        1z+DDpJme5HKDHBaqCfOW6De4mvGO74oqOiF9aKiel8SKG2+az6tV6r1TtJFI8h7V1dYTv
        WCCAQe23QdWh9+yzlMEAbnCg1loyf70=
Date:   Fri, 24 Sep 2021 10:26:55 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, yazen.ghannam@amd.com
Subject: Re: [PATCH 5/5] x86/mce/mce-inject: Return error code to userspace
 from mce-inject module
Message-ID: <YU2LzwNm4CNZ8fT8@zn.tnic>
References: <20210915232739.6367-1-Smita.KoralahalliChannabasappa@amd.com>
 <20210915232739.6367-6-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210915232739.6367-6-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Sep 15, 2021 at 06:27:39PM -0500, Smita Koralahalli wrote:
> Currently, the mce-inject module fails silently and user must look for
> kernel logs to determine if the injection has succeeded.
> 
> Save time for the user and return error code from the module if error
> injection fails.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
>  arch/x86/kernel/cpu/mce/inject.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
> index c7d1564f244b..0ef9ff921c6a 100644
> --- a/arch/x86/kernel/cpu/mce/inject.c
> +++ b/arch/x86/kernel/cpu/mce/inject.c
> @@ -549,8 +549,10 @@ static void do_inject(void)
>  	}
>  
>  	cpus_read_lock();
> -	if (!cpu_online(cpu))
> +	if (!cpu_online(cpu)) {
> +		mce_err.err = -ENODEV;

You could issue a pr_err() here too. That ENODEV probably turns into
"write failed" but that doesn't say why.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
