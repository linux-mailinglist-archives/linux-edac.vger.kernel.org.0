Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A303F6985
	for <lists+linux-edac@lfdr.de>; Tue, 24 Aug 2021 21:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbhHXTGk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 24 Aug 2021 15:06:40 -0400
Received: from smtprelay0242.hostedemail.com ([216.40.44.242]:46410 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232117AbhHXTGk (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Tue, 24 Aug 2021 15:06:40 -0400
Received: from omf19.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id BE3FE100E7B5C;
        Tue, 24 Aug 2021 19:05:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id 3ADAE20D75C;
        Tue, 24 Aug 2021 19:05:53 +0000 (UTC)
Message-ID: <6dd7d45d8dccacb6d37ad5f6f137413b229d8565.camel@perches.com>
Subject: Re: [PATCH v4] EDAC/mc: Prefer strscpy over strcpy
From:   Joe Perches <joe@perches.com>
To:     Borislav Petkov <bp@alien8.de>, Len Baker <len.baker@gmx.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 24 Aug 2021 12:05:52 -0700
In-Reply-To: <YSU5wp/ZpsXuDgmu@zn.tnic>
References: <20210814075527.5999-1-len.baker@gmx.com>
         <YSPbOo90alPsv4vL@zn.tnic> <20210824090338.GB7999@titan>
         <YSU5wp/ZpsXuDgmu@zn.tnic>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.90
X-Stat-Signature: gbw8hao5yg94bjpfq3cs1hmfuybbbawk
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 3ADAE20D75C
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+qhTBzD3PJ/ihefUS3Wgwe9dpo85K7g1c=
X-HE-Tag: 1629831953-473425
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, 2021-08-24 at 20:26 +0200, Borislav Petkov wrote:
> On Tue, Aug 24, 2021 at 12:28:07PM +0200, Len Baker wrote:
> > This is a task of the KSPP [1] and the main reason is to clean up the
> > proliferation of str*cpy functions in the kernel.
> 
> That I understood - you prominently explain where the patches stem from.
> 
> What I can't parse is that formulation "previous step". What previous
> step do you mean?
> 
> > Yes, you are right. The same discussion happened in the v3 review [2] and
> > I agree with the reasons that Robert Richter exposed. Using the strlen()
> > implementation it is not necessary to check the return code of strcpy and
> > we can assume a silent truncation.
> > 
> > [2] https://lore.kernel.org/linux-hardening/YRN+8u59lJ6MWsOL@rric.localdomain/
> 
> Ok, looking at the asm, gcc is actually smart enough not to call
> strlen() twice on the same buffer.
> 
> But then there's this in the strscpy() kernel-doc comment:
> 
> "The destination buffer is always NUL terminated, unless it's
> zero-sized."
> 
> so looking at the code, we're merrily decrementing len but nothing's
> checking whether len can become 0. Because if it does, strscpy() will
> do:
> 
> 	if (count == 0 || WARN_ON_ONCE(count > INT_MAX))
> 		return -E2BIG;
> 
> so if p ends up pointing to something which is *not* '\0', strlen() will
> go off into the weeds.
> 
> So I don't care if it doesn't look just as nice - it better be correct
> in all cases first.

It's all somehat unnecessary as it seems it's guaranteed not to overflow.

$ git grep -n -w OTHER_LABEL next-20210820
next-20210820:drivers/edac/edac_mc.c:1118:                              strcpy(p, OTHER_LABEL);
next-20210820:drivers/edac/edac_mc.c:1119:                              p += strlen(OTHER_LABEL);
next-20210820:include/linux/edac.h:57:#define OTHER_LABEL " or "
next-20210820:include/linux/edac.h:470: char label[(EDAC_MC_LABEL_LEN + 1 + sizeof(OTHER_LABEL)) * EDAC_MAX_LABELS];

Also the array size of char label is too large.

First by 1 * EDAC_MAX_LABELS as sizeof(OTHER_LABEL) is 5 not 4 and
second there can only be EDAC_MAX_LABELS - 1 uses of OTHER_LABEL.

And I would remove the define for OTHER_LABEL and use " or " directly.

Lastly, this could be easier to understand using stpcpy and/or scnprintf.


