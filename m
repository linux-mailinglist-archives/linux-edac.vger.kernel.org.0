Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D403F46C33F
	for <lists+linux-edac@lfdr.de>; Tue,  7 Dec 2021 20:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbhLGTEH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 7 Dec 2021 14:04:07 -0500
Received: from mail.skyhub.de ([5.9.137.197]:36302 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231778AbhLGTEF (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 7 Dec 2021 14:04:05 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E20DF1EC0118;
        Tue,  7 Dec 2021 20:00:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1638903630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9enz5ts+vCqpd36KcwT4E4Jl+vidS2bA+MLNI4C40GQ=;
        b=kCuGn20tKJiYy6qhhQtQGNrjD+lpS4AzDVRblLYCAbVVTIxQaA37HRme7i7uANL4hs76pI
        Ics6/SqT2rRwR/F0glVj8ZHOQFfkfXyXc85y0VL6DZI5w6aGha5KCsMOtgxAt00nANxmxh
        pQWJPDNkd+g6BfX6/69KcugOPmnuVKA=
Date:   Tue, 7 Dec 2021 20:00:32 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, yazen.ghannam@amd.com
Subject: Re: [PATCH v3 3/6] x86/mce/inject: Check for writes ignored in
 status registers
Message-ID: <Ya+vUCP0GdMxj+dg@zn.tnic>
References: <20211104215846.254012-1-Smita.KoralahalliChannabasappa@amd.com>
 <20211104215846.254012-4-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211104215846.254012-4-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Nov 04, 2021 at 04:58:43PM -0500, Smita Koralahalli wrote:
> According to Section 2.1.16.3 under HWCR[McStatusWrEn] in "PPR for AMD
> Family 19h, Model 01h, Revision B1 Processors - 55898 Rev 0.35 - Feb 5,
> 2021", the status register may sometimes enforce write ignored behavior
> independent of the value of HWCR[McStatusWrEn] depending on the platform
> settings.

How and when can it enforce that?

Can we detect whether that enforcement is active and if so, fail the
injection directly instead of checking whether the writes have stuck in
the MSRs?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
