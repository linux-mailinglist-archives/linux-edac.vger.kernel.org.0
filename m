Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7623E440C
	for <lists+linux-edac@lfdr.de>; Mon,  9 Aug 2021 12:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbhHIKnv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 Aug 2021 06:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbhHIKnt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 9 Aug 2021 06:43:49 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBB7C0613D3;
        Mon,  9 Aug 2021 03:43:29 -0700 (PDT)
Received: from zn.tnic (p200300ec2f26f300329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f26:f300:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D47E21EC03FE;
        Mon,  9 Aug 2021 12:43:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1628505804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=iRZgmeCr/Savpcr/auC+m2pX5jLL5wpQZZXyOWrBPUc=;
        b=kEl2pueuhWRmxbCPU2YGFyTIm0CA72sLxsE7iGU8w/YUwUbr80EKuCFiEkxrUlFUwPeKnP
        nBbFFNJExUwVq9MWMJ2c7d4wpheBOqQgTBaItGCtHfS8zuItHLw4wSbnIyi3zA0RsGkpJN
        FnoK3e6cneFPXPkEitmc50zUKZLH2zc=
Date:   Mon, 9 Aug 2021 12:44:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Richter <rric@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>, yazen.ghannam@amd.com
Subject: Re: [PATCH] EDAC/mce_amd: Do not load edac_mce_amd module on guests
Message-ID: <YREG8Pzj5n5AIEAs@zn.tnic>
References: <20210628172740.245689-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210628172740.245689-1-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jun 28, 2021 at 12:27:40PM -0500, Smita Koralahalli wrote:
> Hypervisors may not expose SMCA feature to the guest.
> 
> Check for X86_FEATURE_HYPERVISOR on entry in mce_amd_init() and return
> -ENODEV if set.
> 
> Suggested-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
>  drivers/edac/mce_amd.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
> index 5dd905a3f30c..1a1629166aa3 100644
> --- a/drivers/edac/mce_amd.c
> +++ b/drivers/edac/mce_amd.c
> @@ -1176,6 +1176,9 @@ static int __init mce_amd_init(void)
>  	    c->x86_vendor != X86_VENDOR_HYGON)
>  		return -ENODEV;
>  
> +	if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
> +		return -ENODEV;
> +
>  	if (boot_cpu_has(X86_FEATURE_SMCA)) {
>  		xec_mask = 0x3f;
>  		goto out;
> -- 
> 2.17.1

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
