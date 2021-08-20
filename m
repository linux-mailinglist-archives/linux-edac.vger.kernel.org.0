Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F2D3F34A6
	for <lists+linux-edac@lfdr.de>; Fri, 20 Aug 2021 21:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhHTT1u (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 20 Aug 2021 15:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhHTT1t (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 20 Aug 2021 15:27:49 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F048C061575;
        Fri, 20 Aug 2021 12:27:11 -0700 (PDT)
Received: from zn.tnic (p200300ec2f107b00a09c9d8b407e80a9.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:7b00:a09c:9d8b:407e:80a9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 421351EC0541;
        Fri, 20 Aug 2021 21:27:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629487625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dAnnKn0seBVhyHtYQgR1qRqGXVwhn2GxxVBa61/Itj4=;
        b=cK2M8dRvu9WV0m7Wa1uCGcur5R4iqdqYueR7Edx8Iqp5w5THuvyYnAO4/mu1xCzfIARSFx
        mCwbKMvGl7f35qEblt/CKWXnFC2qr8UuFbE8gHGZnYyKQE71i03c2jzXmvzO/jsTF2Xygu
        HNvCJrV5ca7I9oV45GxKzVSomVP5kjs=
Date:   Fri, 20 Aug 2021 21:27:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Jue Wang <juew@google.com>, Ding Hui <dinghui@sangfor.com.cn>,
        naoya.horiguchi@nec.com, osalvador@suse.de,
        Youquan Song <youquan.song@intel.com>, huangcun@sangfor.com.cn,
        x86@kernel.org, linux-edac@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] x86/mce: Avoid infinite loop for copy from user
 recovery
Message-ID: <YSACMCEoU6FxjDNh@zn.tnic>
References: <20210706190620.1290391-1-tony.luck@intel.com>
 <20210818002942.1607544-1-tony.luck@intel.com>
 <20210818002942.1607544-2-tony.luck@intel.com>
 <YR/m/8PCmCTbogey@zn.tnic>
 <20210820185945.GA1623421@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210820185945.GA1623421@agluck-desk2.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Aug 20, 2021 at 11:59:45AM -0700, Luck, Tony wrote:
> It's the "when we return" part that is the problem here. Logical
> trace looks like:
> 
> user-syscall:
> 
> 	kernel does get_user() or copyin(), hits user poison address
> 
> 		machine check
> 		sees that this was kernel get_user()/copyin() and
> 		uses extable to "return" to exception path
> 
> 	still in kernel, see that get_user() or copyin() failed
> 
> 	Kernel does another get_user() or copyin() (maybe the first

I forgot all the details we were talking at the time but there's no way
to tell the kernel to back off here, is it?

As in: there was an MCE while trying to access this user memory, you
should not do get_user anymore. You did add that

         * Return zero to pretend that this copy succeeded. This
         * is counter-intuitive, but needed to prevent the code
         * in lib/iov_iter.c from retrying and running back into

which you're removing with the last patch so I'm confused.

IOW, the problem is that with repeated MCEs while the kernel is
accessing that memory, it should be the kernel which should back off.
And then we should kill that process too but apparently we don't even
come to that.

> Maybe the message could be clearer?
> 
> 	mce_panic("Too many consecutive machine checks in kernel while accessing user data", m, msg);

That's not my point - it is rather: this is a recoverable error because
it is in user memory even if it is the kernel which tries to access it.
And maybe we should not panic the whole box but try to cordon off the
faulty memory only and poison it after having killed the process using
it...

> Not quite the same answer ... but similar.  We could in theory handle
> multiple different machine check addresses by turning the "mce_addr"
> field in the task structure into an array and saving each address so
> that when the kernel eventually gives up poking at poison and tries
> to return to user kill_me_maybe() could loop through them and deal
> with each poison page.

Yes, I like the aspect of making the kernel give up poking at poison and
when we return we should kill the process and poison all pages collected
so that the error source is hopefully contained.

But again, I think the important thing is how to make the kernel to back
off quicker so that we can poison the pages at all...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
