Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923E44747A5
	for <lists+linux-edac@lfdr.de>; Tue, 14 Dec 2021 17:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235741AbhLNQWd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 14 Dec 2021 11:22:33 -0500
Received: from mail.skyhub.de ([5.9.137.197]:54960 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235787AbhLNQWY (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 14 Dec 2021 11:22:24 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EB64A1EC059F;
        Tue, 14 Dec 2021 17:22:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1639498939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ElMEZwBi9lGuGXuDKL/j94OhTbiHka/x/xBLqceRvV4=;
        b=H0m2EORL3edd5rgUyzY56wps9bCremL8d5Izsld2nO5jR0fEc/qb8ZRS1Ikg1ZIP8Z9kZm
        uwE86kaOrnnwci1GRJzoezOC3UUcKZnZWJstD8p7EIJph8gxPcNTRflJRdai/b6I1vx1F7
        cmnE4L2es+lFcPGzCKSYiAWhsPa7N/E=
Date:   Tue, 14 Dec 2021 17:22:20 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, Smita.KoralahalliChannabasappa@amd.com,
        william.roche@oracle.com
Subject: Re: [PATCH 4/4] EDAC/amd64: Add DDR5 support and related register
 changes
Message-ID: <YbjEvMTaW9+AiBZ8@zn.tnic>
References: <20211208174356.1997855-1-yazen.ghannam@amd.com>
 <20211208174356.1997855-5-yazen.ghannam@amd.com>
 <YbNK9jV06al93XDN@zn.tnic>
 <YbeHD5PW0sv4O13r@yaz-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YbeHD5PW0sv4O13r@yaz-ubuntu>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Dec 13, 2021 at 05:46:55PM +0000, Yazen Ghannam wrote:
> Yeah, sorry it's not clear. The purpose of the flag is to indicate some minor
> changes that show up with future systems like register offsets changes, etc. I
> didn't want to tie the name to a specific model or core name. I went with DDR5
> as a new feature that shows up with these changes, but they're not directly
> tied to DDR5.
> 
> But yes, a system may support DDR5 and DDR4. And this can be detected from the
> hardware.
> 
> What do you think about calling the flag "uses_f19h_m10h_offsets" or something
> like that? I was trying to avoid family/model in the name, but the code
> already does this all over. And the convention has been to call something by
> the first family/model where it shows up.

Good question.

So AFAIU, these register offset changes are probably going to propagate
beyond F19M10... In any case, they won't be tied to the family/model
so your flag idea is in the right direction, AFAICT. I'd do something
shorter, though, so that the code accessing it is short'n'sweet:

	if (pvt->flags.f19h_regs_ng)		- "new generation" regs :-)

or even

	if (pvt->flags.zn_new_regs_fmt)

or whatever that's called. The GPU UMC is called UMC_v2 so I guess

	if (pvt->flags.zn_regs_v2)

:-)

You get the idea...

With an ample explanation in a comment what that means, ofc.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
