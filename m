Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E540C3A71B5
	for <lists+linux-edac@lfdr.de>; Tue, 15 Jun 2021 00:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhFNWD5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 14 Jun 2021 18:03:57 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47190 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229979AbhFNWD5 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 14 Jun 2021 18:03:57 -0400
Received: from zn.tnic (p200300ec2f09b90088ef25f957385d7b.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:b900:88ef:25f9:5738:5d7b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A61D71EC036C;
        Tue, 15 Jun 2021 00:01:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623708112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=m3AAJQrbVnts2lZ7AysK1yHmxX97aQiFdJvbzt+9ix0=;
        b=JJWYSaJWG78Fa9MtqsKq+CyxtHjYq+dSqxbMEG7flxvc8w1UV9TWPGkVHOCk1q8uNPtDDV
        7DMdmaBqU2FsFoxFpZmtjGeAVmagYkYXzA4olD+IFqo2D1pMgBduqEoTIUqRabLMq8THx6
        DObhAFmO+8yEM2P6l/1vvBPoYrGy9qI=
Date:   Tue, 15 Jun 2021 00:01:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>, yazen.ghannam@amd.com,
        Robert Richter <rric@kernel.org>
Subject: Re: [PATCH] EDAC/mce_amd: Reduce unnecessary spew in dmesg if SMCA
 feature bit is not exposed
Message-ID: <YMfRxX/M4rJ5gM/R@zn.tnic>
References: <20210614212129.227698-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210614212129.227698-1-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jun 14, 2021 at 04:21:29PM -0500, Smita Koralahalli wrote:
> The SMCA feature bit is not exposed on the guest.
> 
> This causes a lot of noise in dmesg as the warning is printed for each
> logical CPU.
> 
> $ dmesg |grep -i family
> 
> [    0.031000] smpboot: CPU0: AMD EPYC-Milan Processor (family: 0x19, model: 0x1, stepping: 0x1)
> [    4.653422] Huh? What family is it: 0x19?!
> [    4.720732] Huh? What family is it: 0x19?!
> [    6.171028] Huh? What family is it: 0x19?!
> [    6.766552] Huh? What family is it: 0x19?!
> [    6.811119] Huh? What family is it: 0x19?!
> [    6.839855] Huh? What family is it: 0x19?!
> 
> Give these messages debug severity and output once as it is mostly useful
> for module developers and just noise for users.

I'm getting a patch like that on a pretty regular basis and each time I
tell people simply not to load the module in guests. Hypervisors do not
support SMCA...

But apparently those wrong error messages bug people on a regular basis
and I'm tired of typing this each time so I'll take a different version
of this patch: check X86_FEATURE_HYPERVISOR on entry in mce_amd_init()
and return -ENODEV if set.

So that this is done once and for all.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
