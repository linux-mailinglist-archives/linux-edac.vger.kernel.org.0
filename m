Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF5272EFB9B
	for <lists+linux-edac@lfdr.de>; Sat,  9 Jan 2021 00:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbhAHXP6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 8 Jan 2021 18:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbhAHXP5 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 8 Jan 2021 18:15:57 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3CEC061574;
        Fri,  8 Jan 2021 15:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TmO09cObcPohwfcznvarkJ3GaxSuxbSBMS5Y5aaVzdk=; b=TyXKOGDk9E8YintME3xbAqr/B9
        K+tYo9PPw3b3nuqfZ1us1zZLL7vIzv0mkZbT9jkIetntI8a0A/SRNJ12IlxJZgEeA6O9ieAa1ClrH
        61WReUB0glKhhrH33J4teA1L77tLr8VzY+HQvewUAqesj0rUIqgb+E91EYKhNuGZmfm7cOzmNqzEE
        KOYZfImxWooGC26vkLSXNU05SkgqezmppqCDEt8XJSNnO9Kr6glaka/Y8Y6Osoz+If7t4DLqntkO9
        Q6fbLpuHyCmW672fn/PAoYFMQcrjsoPrJZArUbhYCSbVp6HnOSanMwRo016uKcqCh9MFKPS2Tl7u6
        uHVGhTbg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ky0yF-0005sk-M4; Fri, 08 Jan 2021 23:15:04 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9605A9866B2; Sat,  9 Jan 2021 00:14:59 +0100 (CET)
Date:   Sat, 9 Jan 2021 00:14:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 2/2] futex, x86/mce: Avoid double machine checks
Message-ID: <20210108231459.GC2453@worktop.programming.kicks-ass.net>
References: <20210108222251.14391-1-tony.luck@intel.com>
 <20210108222251.14391-3-tony.luck@intel.com>
 <20210108224715.GB2453@worktop.programming.kicks-ass.net>
 <4493a015ffcd4d82bbea7d1e5c2e73e4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4493a015ffcd4d82bbea7d1e5c2e73e4@intel.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jan 08, 2021 at 11:08:58PM +0000, Luck, Tony wrote:
> > I think this is horrid; why can't we have it return something different
> > then -EFAULT instead?
> 
> I did consider this ... but it appears that architectures aren't unified in the
> return value from get_user()

But surely none are currently returning -EMEMERR or whatever name we
come up with.

> Here's another function involved in the futex call chain leading to this:
> 
> static int get_futex_value_locked(u32 *dest, u32 __user *from)
> {
>         int ret;
> 
>         pagefault_disable();
>         ret = __get_user(*dest, from);
>         pagefault_enable();
> 
>         return ret ? -EFAULT : 0;
> }
> 
> It seems like the expectation here is just "zero or not" and we
> don't care what the "not" value is ... just turn it into -EFAULT.

Yeah, saw that, but that should be trivially fixable I'm thinking.
