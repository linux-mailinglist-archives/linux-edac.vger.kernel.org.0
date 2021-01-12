Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE52D2F3948
	for <lists+linux-edac@lfdr.de>; Tue, 12 Jan 2021 19:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732573AbhALS6C (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 12 Jan 2021 13:58:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:39746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbhALS6B (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 12 Jan 2021 13:58:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB7F623125
        for <linux-edac@vger.kernel.org>; Tue, 12 Jan 2021 18:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610477840;
        bh=qEYVDk2n6QAVg4WiGfYhBfpW3XJsw9qR39XuOVUrciE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ts9DrtUAA1GEpN4BuSOqiX5K2zQg2/sGWa1F3QirrwvHXVOEAd1AfDxYSQeqar5Ko
         yvfmuc357OHy4j7mJ1DKb5GE0t5vFMWmDXNbvRaSJPMKcll/bKH5Hclg5Krv1HCEW4
         sQ4BOSIo8jDZ+8ZBlPdp5N+t51RCsHUob2Yt41LC9Zjdt2BRoShsEHXwYwcLV/FamB
         X/cT3vGNbZV+qzEl53lVT8jwPesUnkRfbw+eY+BO+2Srvh+8ycMttP1Y5eI9JR1opa
         tlvZWoYxgbynFHHSEHRfTxHygGN6LsrfetKkMRm/KhREcXSJTiKgs1ZUQXQGFiVwFE
         WhruniVKugXiQ==
Received: by mail-ej1-f50.google.com with SMTP id t16so4958520ejf.13
        for <linux-edac@vger.kernel.org>; Tue, 12 Jan 2021 10:57:20 -0800 (PST)
X-Gm-Message-State: AOAM530ZuQDfHBL7DuJl60RA5K1m6nVhUEho92rfC9lzF1KQuemZWiXI
        tAvuwG62XUNZxx/X9RCjh+6MBCXxs+ktPf6QcXhFcw==
X-Google-Smtp-Source: ABdhPJwa1SLrf/AXA3+Oh0ElF/YK5IYtuk315jrUdJu8T9NDyOQ0b+aBKyIKdtGyqoYP5BsFhTJwcYko3HQmw2dlaIk=
X-Received: by 2002:a17:906:351a:: with SMTP id r26mr174708eja.204.1610477839172;
 Tue, 12 Jan 2021 10:57:19 -0800 (PST)
MIME-Version: 1.0
References: <20210111214452.1826-2-tony.luck@intel.com> <E1FCB534-9149-437A-971E-F93C009F99C3@amacapital.net>
 <20210111222057.GA2369@agluck-desk2.amr.corp.intel.com> <CALCETrVhRF0H+R1aiy-rdguL3A_9M35R3roVAgRGaEAMCJVW0Q@mail.gmail.com>
 <20210112171628.GA15664@agluck-desk2.amr.corp.intel.com> <CALCETrWijyKoopqAHjohMbvfX191GhmMVQCQjKWx1s3+SA+-uA@mail.gmail.com>
 <20210112182357.GA16390@agluck-desk2.amr.corp.intel.com>
In-Reply-To: <20210112182357.GA16390@agluck-desk2.amr.corp.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 12 Jan 2021 10:57:07 -0800
X-Gmail-Original-Message-ID: <CALCETrXw59WDTwfoZHVtDrveMpFF=Eh4jaOF7vFsF02Zk54mDw@mail.gmail.com>
Message-ID: <CALCETrXw59WDTwfoZHVtDrveMpFF=Eh4jaOF7vFsF02Zk54mDw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] x86/mce: Avoid infinite loop for copy from user recovery
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jan 12, 2021 at 10:24 AM Luck, Tony <tony.luck@intel.com> wrote:
>
> On Tue, Jan 12, 2021 at 09:21:21AM -0800, Andy Lutomirski wrote:
> > Well, we need to do *something* when the first __get_user() trips the
> > #MC.  It would be nice if we could actually fix up the page tables
> > inside the #MC handler, but, if we're in a pagefault_disable() context
> > we might have locks held.  Heck, we could have the pagetable lock
> > held, be inside NMI, etc.  Skipping the task_work_add() might actually
> > make sense if we get a second one.
> >
> > We won't actually infinite loop in pagefault_disable() context -- if
> > we would, then we would also infinite loop just from a regular page
> > fault, too.
>
> Fixing the page tables inside the #MC handler to unmap the poison
> page would indeed be a good solution. But, as you point out, not possible
> because of locks.
>
> Could we take a more drastic approach? We know that this case the kernel
> is accessing a user address for the current process. Could the machine
> check handler just re-write %cr3 to point to a kernel-only page table[1].
> I.e. unmap the entire current user process.

That seems scary, especially if we're in the middle of a context
switch when this happens.  We *could* make it work, but I'm not at all
convinced it's wise.

>
> Then any subsequent access to user space will page fault. Maybe have a
> flag in the task structure to help the #PF handler understand what just
> happened.
>
> The code we execute in the task_work handler can restore %cr3

This would need to be integrated with something much more local IMO.
Maybe it could be scoped to pagefault_disable()/pagefault_enable()?

--Andy
