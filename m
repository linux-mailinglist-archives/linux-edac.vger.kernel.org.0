Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10BC33F690B
	for <lists+linux-edac@lfdr.de>; Tue, 24 Aug 2021 20:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbhHXS0X (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 24 Aug 2021 14:26:23 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34718 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231494AbhHXS0X (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 24 Aug 2021 14:26:23 -0400
Received: from zn.tnic (p200300ec2f114400ce3b938495d443bc.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:4400:ce3b:9384:95d4:43bc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6C4981EC01FC;
        Tue, 24 Aug 2021 20:25:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629829533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zZGkwWSiDZd/SYcLT5qkYvAPUqD+oDPAAEUs5B3f5eo=;
        b=pbTnW4F/JQeXpkgNJypk6W3fcyJRq66+e87oCG9qDGS0mzB8LkGjt6fK0Fonzv12eLyJiE
        jR7+b6gKUtixMAMoyFEtTRt8783+maqHC/tqknnYhkZpQrRGfpBNMR454EiBJhe+lwMIsL
        eshGboOwyzHABQIQiNN5gslplo14aIE=
Date:   Tue, 24 Aug 2021 20:26:10 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Len Baker <len.baker@gmx.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Joe Perches <joe@perches.com>,
        David Laight <David.Laight@aculab.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] EDAC/mc: Prefer strscpy over strcpy
Message-ID: <YSU5wp/ZpsXuDgmu@zn.tnic>
References: <20210814075527.5999-1-len.baker@gmx.com>
 <YSPbOo90alPsv4vL@zn.tnic>
 <20210824090338.GB7999@titan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210824090338.GB7999@titan>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Aug 24, 2021 at 12:28:07PM +0200, Len Baker wrote:
> This is a task of the KSPP [1] and the main reason is to clean up the
> proliferation of str*cpy functions in the kernel.

That I understood - you prominently explain where the patches stem from.

What I can't parse is that formulation "previous step". What previous
step do you mean?

> Yes, you are right. The same discussion happened in the v3 review [2] and
> I agree with the reasons that Robert Richter exposed. Using the strlen()
> implementation it is not necessary to check the return code of strcpy and
> we can assume a silent truncation.
> 
> [2] https://lore.kernel.org/linux-hardening/YRN+8u59lJ6MWsOL@rric.localdomain/

Ok, looking at the asm, gcc is actually smart enough not to call
strlen() twice on the same buffer.

But then there's this in the strscpy() kernel-doc comment:

"The destination buffer is always NUL terminated, unless it's
zero-sized."

so looking at the code, we're merrily decrementing len but nothing's
checking whether len can become 0. Because if it does, strscpy() will
do:

	if (count == 0 || WARN_ON_ONCE(count > INT_MAX))
		return -E2BIG;

so if p ends up pointing to something which is *not* '\0', strlen() will
go off into the weeds.

So I don't care if it doesn't look just as nice - it better be correct
in all cases first.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
