Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A12F3A79F0
	for <lists+linux-edac@lfdr.de>; Tue, 15 Jun 2021 11:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhFOJTF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Jun 2021 05:19:05 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33944 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231280AbhFOJTF (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 15 Jun 2021 05:19:05 -0400
Received: from zn.tnic (p200300ec2f0f2700c2d40b448c69f909.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:2700:c2d4:b44:8c69:f909])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C4DB61EC04CC;
        Tue, 15 Jun 2021 11:16:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623748619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hqIYPsMwV7tG6Ke4inrHNWrKVe2HcOY1FBNTW2EP1K8=;
        b=MYGKSP2mEXE480lkbMjFysAOLu325KtlnsVqcDX1+2Xy4APTwDlG4IC5hyO0jaW9GaLSvc
        xIz/ftNhxNKi4cvMi1DQHoRU1lxaB94iyHNT0XBrnp0ZiDdXzlT3Cf6tI6Ovu3NqyIhMxQ
        C2JLW5g8oK5noF6ikjPxooEd1Zi5VyY=
Date:   Tue, 15 Jun 2021 11:16:49 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
        Robert Richter <rric@kernel.org>
Subject: Re: [PATCH] EDAC/mce_amd: Reduce unnecessary spew in dmesg if SMCA
 feature bit is not exposed
Message-ID: <YMhwAZaFr4d1QOGG@zn.tnic>
References: <20210614212129.227698-1-Smita.KoralahalliChannabasappa@amd.com>
 <YMfRxX/M4rJ5gM/R@zn.tnic>
 <16a34b6834f94f139444c2ff172645e9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <16a34b6834f94f139444c2ff172645e9@intel.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jun 14, 2021 at 10:25:36PM +0000, Luck, Tony wrote:
> I expect all the Intel EDAC drivers that load based on CPU model have similar
> issues. Maybe they aren't whining as loudly about not being able to find the
> memory controller devices?

Right.

> Though perhaps this is an issue outside of EDAC and x86_match_cpu()
> could do the HYPERVISOR check and return no match. The few callers
> who want to believe the fictional CPU model number passed in by the
> VMM would need to use some new variant of the call?

Yeah, we could do

X86_MATCH_VENDOR_FAM_MODEL_STEPPINGS_NOT_FEATURE

notice the "NOT" and have a x86_cpu_id.not_feature which to match
X86_FEATURE_HYPERVISOR. I'm not sure it is worth it, though, for a
handful of drivers.

The whole thing is a meh, why bother, but I got tired of this particular
intent of people wanting to shut this error message up just because they
should not load that driver in a VM in the first place.

But what happens is they boot a guest with -cpu host and in that case
that's a new CPU - family 0x19 - so it doesn't have a case 0x19 for the
pr_warn_once() there.

And instead of keep adding adding families there, I'd simply check
X86_FEATURE_HYPERVISOR.

Oh and that thing - mce_amd.c - doesn't use x86_match_cpu() so it has to
be an explicit check on function entry.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
