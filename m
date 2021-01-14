Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960D12F6772
	for <lists+linux-edac@lfdr.de>; Thu, 14 Jan 2021 18:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbhANRXi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 14 Jan 2021 12:23:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:59116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726625AbhANRXi (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 14 Jan 2021 12:23:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 156C423B53
        for <linux-edac@vger.kernel.org>; Thu, 14 Jan 2021 17:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610644977;
        bh=Lq+/xcRpcAsTNgRFXMjtZMsufCcASKMREtzWScmKsx8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eOgVUgX5LmAOS+3Pf3BfXtV1UbVoa8q+bsLMhWyEOWKBUb183XZQPToLJNlO3CLwL
         7H6+rq5uydSQYKzR/oNK5M3/JIa2fMJawFXWMVSTOmmhRi21OCGE768j4VY5OZ8DKt
         1DHHluBgRO8LxHXdCYb3vGcaJ9UOtzVdCTVHV7aflPj1WyXCz4v9/gM2obCqHUx35F
         /hhc5wKqhLy316gnKhnmyDfvjXgO3HJkLadFDmd6Jy0Xx3XN50RrC06xMZCVh3sVKn
         E3JOa+BYyCd+Rq++dJMDn52dEF76AwveSpioiiIlNc8b1VXuDFqq2rNNzoErCWAYu5
         BvuyPq+drm9Gg==
Received: by mail-ed1-f45.google.com with SMTP id by27so6524616edb.10
        for <linux-edac@vger.kernel.org>; Thu, 14 Jan 2021 09:22:57 -0800 (PST)
X-Gm-Message-State: AOAM531XE1oPXGEQq7y5K1iUNeE00ME1Li1+sSrHURdKxCl4j/snE01J
        FavZyLvAVCY8iRcbmrO7Nb9VHdp7OzheylOHEYn2UA==
X-Google-Smtp-Source: ABdhPJyq73kf+KpUuM9wTZCEJ8GlDuZb8DugLPNVJAXiCHPSjK5bJt4ippgXkIZxCRZ8JN1rKeHrvWuB33jSajK1+q8=
X-Received: by 2002:a05:6402:a5b:: with SMTP id bt27mr6684201edb.222.1610644975588;
 Thu, 14 Jan 2021 09:22:55 -0800 (PST)
MIME-Version: 1.0
References: <20210108222251.14391-1-tony.luck@intel.com> <20210111214452.1826-1-tony.luck@intel.com>
In-Reply-To: <20210111214452.1826-1-tony.luck@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 14 Jan 2021 09:22:44 -0800
X-Gmail-Original-Message-ID: <CALCETrUvSWM5yOviJRD4Y+HZxDschAuTHfyffTVc8qifvh1AiA@mail.gmail.com>
Message-ID: <CALCETrUvSWM5yOviJRD4Y+HZxDschAuTHfyffTVc8qifvh1AiA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Fix infinite machine check loop in futex_wait_setup()
To:     Tony Luck <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jan 11, 2021 at 1:45 PM Tony Luck <tony.luck@intel.com> wrote:
>
> Linux can now recover from machine checks where kernel code is
> doing get_user() to access application memory. But there isn't
> a way to distinguish whether get_user() failed because of a page
> fault or a machine check.
>
> Thus there is a problem if any kernel code thinks it can retry
> an access after doing something that would fix the page fault.
>
> One such example (I'm sure there are more) is in futex_wait_setup()
> where an attempt to read the futex with page faults disabled. Then
> a retry (after dropping a lock so page faults are safe):
>
>
>         ret = get_futex_value_locked(&uval, uaddr);
>
>         if (ret) {
>                 queue_unlock(*hb);
>
>                 ret = get_user(uval, uaddr);
>
> It would be good to avoid deliberately taking a second machine
> check (especially as the recovery code does really bad things
> and ends up in an infinite loop!).
>
> V2 (thanks to feedback from PeterZ) fixes this by changing get_user() to
> return -ENXIO ("No such device or address") for the case where a machine
> check occurred. Peter left it open which error code to use (suggesting
> "-EMEMERR or whatever name we come up with"). I think the existing ENXIO
> error code seems appropriate (the address being accessed has effectively
> gone away). But I don't have a strong attachment if anyone thinks we
> need a new code.
>
> Callers can check for ENXIO in paths where the access would be
> retried so they can avoid a second machine check.
>

I don't love this -- I'm concerned that there will be some code path
that expects a failing get_user() to return -EFAULT, not -ENXIO.
Also, get_user() *can* return -EFAULT when it hits bad memory even
with your patch if the recovery code manages to yank the PTE before
get_user().

So I tend to think that the machine check code should arrange to
survive some reasonable number of duplicate machine checks.
