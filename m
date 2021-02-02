Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFAE430CDA0
	for <lists+linux-edac@lfdr.de>; Tue,  2 Feb 2021 22:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbhBBVGr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 2 Feb 2021 16:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhBBVGp (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 2 Feb 2021 16:06:45 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8D9C061573;
        Tue,  2 Feb 2021 13:06:04 -0800 (PST)
Received: from zn.tnic (p200300ec2f0e1f0020339110b9493ea9.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:1f00:2033:9110:b949:3ea9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AB6981EC0489;
        Tue,  2 Feb 2021 22:06:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1612299962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=q6L9rhyrJTIFzle1zVvDWk/ej5JXAdlKMIkTzGJKZEk=;
        b=V2fQWNHOugTsgtHYlbc/g/l5hSJK79OYzF3s35yFm5rDNsXOgRE3rSz6GyI7bKEyYb4C/R
        oBcb7Ny6m47O818px+Ohwx7oqZhfhWkV9z3VZN/0SNsQfdzoUYQSEH/DlffjLT2UWkQvp8
        nQnHRqT5mIZrly548O5vTBbHF0NPo+w=
Date:   Tue, 2 Feb 2021 22:06:00 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v5] x86/mce: Avoid infinite loop for copy from user
 recovery
Message-ID: <20210202210600.GF18075@zn.tnic>
References: <20210119235759.GA9970@agluck-desk2.amr.corp.intel.com>
 <20210120121812.GF825@zn.tnic>
 <20210121210959.GA10304@agluck-desk2.amr.corp.intel.com>
 <20210125225509.GA7149@agluck-desk2.amr.corp.intel.com>
 <20210126110314.GC6514@zn.tnic>
 <20210126223605.GA14355@agluck-desk2.amr.corp.intel.com>
 <20210128175735.GB2120@zn.tnic>
 <20210201185812.GA54867@agluck-desk2.amr.corp.intel.com>
 <20210202110126.GB18075@zn.tnic>
 <d99c43608909400199e9384bb7425beb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d99c43608909400199e9384bb7425beb@intel.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Feb 02, 2021 at 04:04:17PM +0000, Luck, Tony wrote:
> > And the much more important question is, what is the code supposed to
> > do when that overflow *actually* happens in real life? Because IINM,
> > an overflow condition on the same page would mean killing the task to
> > contain the error and not killing the machine...
> 
> Correct. The cases I've actually hit, the second machine check is on the
> same address as the first. But from a recovery perspective Linux is going
> to take away the whole page anyway ... so not complaining if the second
> (or subsequent) access is within the same page makes sense (and that's
> what the patch does).
> 
> The code can't handle it if a subsequent #MC is to a different page (because
> we only have a single spot in the task structure to store the physical page
> address).  But that looks adequate. If the code is wildly accessing different
> pages *and* getting machine checks from those different pages ... then
> something is very seriously wrong with the system.

Right, that's clear.

But I meant something else: this thread had somewhere upthread:

"But the real validation folks took my patch and found that it has
destabilized cases 1 & 2 (and case 3 also chokes if you repeat a few
more times). System either hangs or panics. Generally before 100
injection/conumption cycles."

To which I asked:

"Or what is the failure exactly?"

and you said:

"After a few cycles of the test injection to user mode, I saw an
overflow in the machine check bank. As if it hadn't been cleared from
the previous iteration ... but all the banks are cleared as soon as we
find that the machine check is recoverable. A while before getting to
the code I changed."

And you also said:

"I tried reporoducing (applied the original patch I posted back to -rc3)
and the same issue stubbornly refused to show up again."

So that "system hang or panic" which the validation folks triggered,
that cannot be reproduced anymore? Did they run the latest version of
the patch?

And the overflow issue is something else which the patch handles fine,
as you say.

So that original mysterious hang is still unsolved.

Or am I missing something and am misrepresenting the situation?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
