Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760FD3F9E56
	for <lists+linux-edac@lfdr.de>; Fri, 27 Aug 2021 19:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhH0RyZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 27 Aug 2021 13:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbhH0RyY (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 27 Aug 2021 13:54:24 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8698C061757;
        Fri, 27 Aug 2021 10:53:31 -0700 (PDT)
Received: from zn.tnic (p200300ec2f111700cf40790d4c46ba75.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:1700:cf40:790d:4c46:ba75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C0D781EC0464;
        Fri, 27 Aug 2021 19:53:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1630086805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Vnzi8i4BEi+cvl2op6fLcbMnIqawCJJ9n45UwHm3acc=;
        b=dE/4cW7JIYkODgbdUOgqYWF853o0YXGEMA5Vs0UV4nyXDhklFT5wPwDMO8d42wsyIDh5L8
        03OTw4N2uUvYWb0eoiVLN4YFaDAT5e59Ge8dIewEO6WY+HjqER9WJ6zSPSmtouSFZVtbKb
        Vv30fIMAPxzc3cFG7H+3NN/vD7XmHJY=
Date:   Fri, 27 Aug 2021 19:54:07 +0200
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
Message-ID: <YSkmv8kz2z3OBHVe@zn.tnic>
References: <20210814075527.5999-1-len.baker@gmx.com>
 <YSPbOo90alPsv4vL@zn.tnic>
 <20210824090338.GB7999@titan>
 <YSU5wp/ZpsXuDgmu@zn.tnic>
 <20210827173633.GA3040@titan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210827173633.GA3040@titan>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Aug 27, 2021 at 07:36:33PM +0200, Len Baker wrote:
> Well, the main purpose is to clean up the proliferation of str*cpy functions.
> One task is to remove the strcpy uses: The first step (previous step) would
> be to remove all the strcpy uses. Then, as a second step remove all the
> strcpy implementations.
> 
> I hope that this clarify your question.

Yes, it does.

Now lemme clarify why I'm asking: when your patch is committed to the
kernel tree and someone reads its commit message months or even years
from now - and those who do that are mostly maintainers trying to figure
out why stuff was done the way it was - they will read:

"This is a previous step in the path to remove the strcpy() function
entirely from the kernel."

and wonder what previous step that is what the following step is...

So, long story short, your commit message should be complete on its own
and understandable without any references to things which might not be
as clear and self-evident in the future as they are now.

Makes sense?

Also, if you're wondering if you should send the patch with the error
checking of strscpy() added, as I requested, even if it might look
superfluous now, yes you should.

Even if it looks impossible now, we might change some of those defines
in the future and forget to touch the logic which generates e->label and
we might end up exhausting that string.

So it would be a lot more robust if something would catch that change,
albeit seemingly redundant now.

I sincerely hope that clears up things.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
