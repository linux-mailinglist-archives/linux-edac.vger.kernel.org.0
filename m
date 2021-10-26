Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4295843AFA9
	for <lists+linux-edac@lfdr.de>; Tue, 26 Oct 2021 12:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhJZKE0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 26 Oct 2021 06:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233868AbhJZKEY (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 26 Oct 2021 06:04:24 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF279C061745;
        Tue, 26 Oct 2021 03:02:00 -0700 (PDT)
Received: from zn.tnic (p200300ec2f131c00c83ef6486df21458.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:1c00:c83e:f648:6df2:1458])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7E3B31EC03AD;
        Tue, 26 Oct 2021 12:01:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1635242519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=WhjVDXMFSu8Xxoze/JOX25dHFUwk5eljGOQCDrVyJYI=;
        b=RA7fOra9IGQkqGgYf34IEhAcFA3OAz2hhUHSSaRq72KIpjvXMWQjPk/RpOfXjaY2vwxqMa
        374hSANxgEmNv7WCmm8e99ocs+xiPEDSuoyroTAKSBNGGmjZH9piqH5oQs9E9hHgs/GRj2
        ULBYiKhrkVIEg2ewawvGhSy/iEHZekg=
Date:   Tue, 26 Oct 2021 12:02:01 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, yazen.ghannam@amd.com
Subject: Re: [PATCH v2 2/5] x86/mce/inject: Warn the user on a not set valid
 bit in MCA_STATUS
Message-ID: <YXfSGW1i5dLsiX84@zn.tnic>
References: <20211019233641.140275-1-Smita.KoralahalliChannabasappa@amd.com>
 <20211019233641.140275-3-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211019233641.140275-3-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Oct 19, 2021 at 06:36:38PM -0500, Smita Koralahalli wrote:
> MCA handlers check the valid bit in each status register (MCA_STATUS[Val])
> and will likely ignore signatures if the valid bit is not set.
> 
> Warn the user if the valid bit is not set before doing error injection.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
> v2:
> 	Added a warning statement instead of setting the valid bit.
> ---
>  arch/x86/kernel/cpu/mce/inject.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
> index 601efd104bb4..a993dc3d0333 100644
> --- a/arch/x86/kernel/cpu/mce/inject.c
> +++ b/arch/x86/kernel/cpu/mce/inject.c
> @@ -487,6 +487,9 @@ static void do_inject(void)
>  
>  	i_mce.tsc = rdtsc_ordered();
>  
> +	if (!(i_mce.status & MCI_STATUS_VAL))
> +		pr_warn("Handlers might ignore signatures with Val=0 in MCA_STATUS\n");
> +
>  	if (i_mce.misc)
>  		i_mce.status |= MCI_STATUS_MISCV;
>  
> -- 

So what's the real reason for this?

You've injected and you didn't get any feedback and were wondering why?

If handlers ignore !VAL MCEs, why don't you simply set it
unconditionally on entry to do_inject()?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
