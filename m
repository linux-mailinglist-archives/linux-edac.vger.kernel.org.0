Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39CF02F365A
	for <lists+linux-edac@lfdr.de>; Tue, 12 Jan 2021 18:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404668AbhALRBL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 12 Jan 2021 12:01:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:46848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405789AbhALRBI (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 12 Jan 2021 12:01:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7ABA223122
        for <linux-edac@vger.kernel.org>; Tue, 12 Jan 2021 17:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610470827;
        bh=tCbxKujI10pNeT2qDClnRO79KvrvLxikcI5B4muZGVA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H3b3afDJblxw0v2aj4WYAzWL2vg9qBy6rnfIwmO9afYS1w/rlouGjfbZjfupbATS5
         bH/yMFzEj2JOnS7IENRCwWToTMw1sHlARCrUFS9Gtc0ZN8OB0LYIOOy9jpgToCfZTV
         LoEgfBUyVSLASvLwNCKwOT4IyAUPipC6AHfKNhfpAZSQQBx2P/RjrrPXUgYOhae85k
         mrxvZeVTBFQkGSuxXdfdwIbfeOdTHOX/5TAJq30PjM0kw9vcCSUGiKg2Obcv10zPar
         R5yS1xBR/BdbSehxgX7KG/9GhRwHZjroEtihovqu6ySQ3QFLvQwRHEeZtMO+vIpdxP
         GdrBM8aeF3OmA==
Received: by mail-ed1-f52.google.com with SMTP id w10so2183272edu.5
        for <linux-edac@vger.kernel.org>; Tue, 12 Jan 2021 09:00:27 -0800 (PST)
X-Gm-Message-State: AOAM532jd/wZLw5zPyay2NEeSCbWjOUN37oZZueygj2TlIWZPTba/qBY
        Sa2/M4kaC3Ud+MVG1uM23Wry8muB7lHYX+pcCmHcww==
X-Google-Smtp-Source: ABdhPJyGazjWMMRy7pPL3L2Y5X0VrBDF1yaBeJLIhIG+bd9wRtrykiTD4iIdg3jGAxS1Cd1twFgKjVVkxFxGmAonX6A=
X-Received: by 2002:a05:6402:a5b:: with SMTP id bt27mr87467edb.222.1610470826025;
 Tue, 12 Jan 2021 09:00:26 -0800 (PST)
MIME-Version: 1.0
References: <20210111214452.1826-2-tony.luck@intel.com> <E1FCB534-9149-437A-971E-F93C009F99C3@amacapital.net>
 <20210111222057.GA2369@agluck-desk2.amr.corp.intel.com>
In-Reply-To: <20210111222057.GA2369@agluck-desk2.amr.corp.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 12 Jan 2021 09:00:14 -0800
X-Gmail-Original-Message-ID: <CALCETrVhRF0H+R1aiy-rdguL3A_9M35R3roVAgRGaEAMCJVW0Q@mail.gmail.com>
Message-ID: <CALCETrVhRF0H+R1aiy-rdguL3A_9M35R3roVAgRGaEAMCJVW0Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] x86/mce: Avoid infinite loop for copy from user recovery
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> On Jan 11, 2021, at 2:21 PM, Luck, Tony <tony.luck@intel.com> wrote:
>
> =EF=BB=BFOn Mon, Jan 11, 2021 at 02:11:56PM -0800, Andy Lutomirski wrote:
>>
>>>> On Jan 11, 2021, at 1:45 PM, Tony Luck <tony.luck@intel.com> wrote:
>>>
>>> =EF=BB=BFRecovery action when get_user() triggers a machine check uses =
the fixup
>>> path to make get_user() return -EFAULT.  Also queue_task_work() sets up
>>> so that kill_me_maybe() will be called on return to user mode to send a
>>> SIGBUS to the current process.
>>>
>>> But there are places in the kernel where the code assumes that this
>>> EFAULT return was simply because of a page fault. The code takes some
>>> action to fix that, and then retries the access. This results in a seco=
nd
>>> machine check.
>>>
>>> While processing this second machine check queue_task_work() is called
>>> again. But since this uses the same callback_head structure that
>>> was used in the first call, the net result is an entry on the
>>> current->task_works list that points to itself.
>>
>> Is this happening in pagefault_disable context or normal sleepable fault=
 context?  If the latter, maybe we should reconsider finding a way for the =
machine check code to do its work inline instead of deferring it.
>
> The first machine check is in pagefault_disable() context.
>
> static int get_futex_value_locked(u32 *dest, u32 __user *from)
> {
>        int ret;
>
>        pagefault_disable();
>        ret =3D __get_user(*dest, from);

I have very mixed feelings as to whether we should even try to recover
from the first failure like this.  If we actually want to try to
recover, perhaps we should instead arrange for the second MCE to
recover successfully instead of panicking.

--Andy


>        pagefault_enable();
>
>        return (ret =3D=3D -ENXIO) ? ret : ret ? -EFAULT : 0;
> }
>
> -Tony
