Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E5D3A83CD
	for <lists+linux-edac@lfdr.de>; Tue, 15 Jun 2021 17:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhFOPVH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Jun 2021 11:21:07 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36798 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230452AbhFOPVG (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 15 Jun 2021 11:21:06 -0400
Received: from zn.tnic (p200300ec2f0f27007132ab63e0ed4371.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:2700:7132:ab63:e0ed:4371])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5F1811EC04CC;
        Tue, 15 Jun 2021 17:19:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623770340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=vuI1AvOE74lmRhMGsswqDGbG80VLscdMnetSm7TxXIc=;
        b=A9G/igUvX9ZJKQIFp8bIeK5wtgSLxAIsgSUAWVvhnvBMAqBVrHyYNs6bOE89p7YO0mdpkO
        xJeVyvlGyNMeeU2kkGStxNDufRo7GsKKZyXoG5AjC88xSq70E5c5cei8SFQdx3C4bA+mg9
        roq4jyisXXnTaGq4s5TR6H5HBm1gYs0=
Date:   Tue, 15 Jun 2021 17:18:50 +0200
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
Message-ID: <YMjE2iwRFWVrfzLL@zn.tnic>
References: <20210614212129.227698-1-Smita.KoralahalliChannabasappa@amd.com>
 <YMfRxX/M4rJ5gM/R@zn.tnic>
 <16a34b6834f94f139444c2ff172645e9@intel.com>
 <YMhwAZaFr4d1QOGG@zn.tnic>
 <20210615150846.GA409@aus-x-yghannam.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210615150846.GA409@aus-x-yghannam.amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jun 15, 2021 at 11:08:46AM -0400, Yazen Ghannam wrote:
> How about adding the the SMCA feature to the amd64_cpuids[] table in
> amd64_edac.c?
> 
> We can use X86_MATCH_VENDOR_FEATURE to match on AMD (and Hygon) systems
> with SMCA. And we can remove the X86_MATCH_VENDOR_FAM entries for
> families 17h-19h.

Sure. That'll alleviate the need to add new families which support SMCA
too.

> I'm assuming the issue is that amd64_edac_mod is autoloading due to the
> family-based device table, and this will load edac_mce_amd as a
> dependency.

Is it?

We have

early_initcall(mce_amd_init);

in mce_amd.c which attempts to load this thing unconditionally.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
