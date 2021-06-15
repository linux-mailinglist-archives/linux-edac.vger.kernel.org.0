Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356F13A877B
	for <lists+linux-edac@lfdr.de>; Tue, 15 Jun 2021 19:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhFOR2J (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Jun 2021 13:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbhFOR2I (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 15 Jun 2021 13:28:08 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E221BC061574;
        Tue, 15 Jun 2021 10:26:02 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f270048ecafc2d258032c.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:2700:48ec:afc2:d258:32c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 859DF1EC030E;
        Tue, 15 Jun 2021 19:26:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623777961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=xH8sUazIxzaovKLfiQftgZitdVavZKBYSHXtkR2AkLI=;
        b=mE9aVezxi1CKEkQdM/Nv2RkUwuh2FsSENzA2o4vsQrE4Kx4D0YgavaWSorAerScoj1vy5X
        QQqG12MNdHmYIgyEZxDigAOoySJJdGKkL7EJLSXhRmNBxsYywBsQvTgp/m8dVO2zpDreaI
        xO/EX3kcRdjftoykItEaF/skvaa5lek=
Date:   Tue, 15 Jun 2021 19:25:57 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>
Subject: Re: [PATCH] EDAC/mce_amd: Reduce unnecessary spew in dmesg if SMCA
 feature bit is not exposed
Message-ID: <YMjipVYQO93i46HJ@zn.tnic>
References: <20210614212129.227698-1-Smita.KoralahalliChannabasappa@amd.com>
 <YMfRxX/M4rJ5gM/R@zn.tnic>
 <16a34b6834f94f139444c2ff172645e9@intel.com>
 <YMhwAZaFr4d1QOGG@zn.tnic>
 <20210615150846.GA409@aus-x-yghannam.amd.com>
 <YMjE2iwRFWVrfzLL@zn.tnic>
 <20210615160009.GA29258@aus-x-yghannam.amd.com>
 <YMjRGFiqp2HNWUrZ@zn.tnic>
 <20210615163221.GA2991@aus-x-yghannam.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210615163221.GA2991@aus-x-yghannam.amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jun 15, 2021 at 12:32:21PM -0400, Yazen Ghannam wrote:
> Yes, I agree. I was a bit confused about the X86_FEATURE_HYPERVISOR
> thing, but I think I get it. This definitely looks simple to do.

Yeah, if you look at the qemu repo:

kvm_arch_get_supported_cpuid:

...

    } else if (function == 1 && reg == R_ECX) {
        /* We can set the hypervisor flag, even if KVM does not return it on
         * GET_SUPPORTED_CPUID
         */
        ret |= CPUID_EXT_HYPERVISOR;


so long story short, that thing is set by the HV and there's an
"agreement" of sorts and APM v3 even says so:

"CPUID Fn0000_0001_ECX Feature Identifiers

...

31:	RAZ. Reserved for use by hypervisor to indicate guest status."

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
