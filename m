Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C300542E2FC
	for <lists+linux-edac@lfdr.de>; Thu, 14 Oct 2021 22:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbhJNU7X (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 14 Oct 2021 16:59:23 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41160 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232537AbhJNU7V (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 14 Oct 2021 16:59:21 -0400
Received: from zn.tnic (p200300ec2f0c720083d5cb613c3a152b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:7200:83d5:cb61:3c3a:152b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 791FE1EC0136;
        Thu, 14 Oct 2021 22:57:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634245034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=K5jVYDYpo2SuHDXGnI+KSEFfIqZ+k70o6c+m/JWkA14=;
        b=Y0Ef0wi1zvwUrReVx98MNbStY/zKGPpguytZTdgX3bj1INStDwX2F67djlbYHZlJpG40VF
        1RjVjynrElPOHeR+0SNp2bu28zbZAXjFNNPiq0+xbZp/w4wVmi5rQjB+BZlFtoYhVa4mid
        ivhnoSqFPNUFZZMHcQxNEX7zl2UdLbs=
Date:   Thu, 14 Oct 2021 22:57:10 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
Cc:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, yazen.ghannam@amd.com
Subject: Re: [PATCH 1/5] x86/mce/inject: Check if a bank is unpopulated
 before error simulation
Message-ID: <YWiZpm/HzKybyOt2@zn.tnic>
References: <20210915232739.6367-1-Smita.KoralahalliChannabasappa@amd.com>
 <20210915232739.6367-2-Smita.KoralahalliChannabasappa@amd.com>
 <YU2Lm+11Pqg/RBK3@zn.tnic>
 <78bec0e8-a64a-466c-4245-2386de7db5c9@amd.com>
 <YWh1bc6Lol65f0RH@zn.tnic>
 <f6b6b66d-0e6b-e64a-9c97-4e067610a3da@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f6b6b66d-0e6b-e64a-9c97-4e067610a3da@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Oct 14, 2021 at 03:26:13PM -0500, Koralahalli Channabasappa, Smita wrote:
> My concern was, we need to determine whether the bank is unpopulated or
> populated before trying to inject the errors on a hw injection, for which
> we need to read the IPID MSR of that bank.

Ah, that. Look at the smca_banks[] array in .../mce/amd.c and how
smca_configure() prepares all banks in there. You could use that array
to query which SMCA bank on which CPU is initialized, before injecting
into it.

> should be retained inside inj_bank_set() ?

And yes, I guess you'll have to do it there because then you know which
bank and which CPU the hw injection is supposed to happen on.

> And inj_ipid_set() should just set m->ipid = val on a SW_INJ as you mentioned
> above?

Yap.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
