Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4E23D3037
	for <lists+linux-edac@lfdr.de>; Fri, 23 Jul 2021 01:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbhGVWuX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 22 Jul 2021 18:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbhGVWuX (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 22 Jul 2021 18:50:23 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226FEC061757
        for <linux-edac@vger.kernel.org>; Thu, 22 Jul 2021 16:30:57 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id c9so2713323uat.1
        for <linux-edac@vger.kernel.org>; Thu, 22 Jul 2021 16:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BPY6X6Rtw90AF5qvM0t4dkoLpJt3vYNK9WYhKNctEG8=;
        b=Z+/cUWopycJ/hLUaIbpaykOlK1CidWr4Ry5yl2uN8wfUATjJzR4e+vZ+FGKoqg8VUH
         ZWk4+lVCRoJb55ZFkRhwzyTQt9MfWBxunFNr2oYRS+hXmoDgFiqIsltQAhGLzi+TAkvr
         yd0VtOHHYiOReYQW9FAOYlXvTt/CtIFAuy13VrI1T0Pco3gGiOuLd27JGbJQfHUAfHnn
         8T3t4rZpqUEqYu6E+PECBBuZj22G0XdJOB/DEfCsGMZiiVTWCbk1BTxNRadJbf5A5FJ8
         lDKCXwDVyCYcDpB7UNUnnxLsfkoJbymP7hXeUpN0TyQM0PwwAKBEttR7TcNjgZIN2VRh
         M9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BPY6X6Rtw90AF5qvM0t4dkoLpJt3vYNK9WYhKNctEG8=;
        b=m6qqsqTt6yWDeZbvrC9sy/5wVxBvkby+KoG1sbFLnx0UByDbcxhX9jljVRQ3avL/yC
         jB3TXsEcZGgQAekh82Pu6Lh4xzHilcJpx2IGr9ojckQC/nUtu7Am2bn/2IpbNoxi29lA
         fDfJkNWDv3D5FmA5b0bjk3nYu8cYiJxpyohnkUXui4P5xjLtD/UbGoMcD9LpwhXK2QU1
         hQSlKp8WsN92V9ehICEKew7KPU9NB4ljugY4Zr60wmckD3JPgodsaUEzQ2EEqawKosx6
         44esdvJyyTXz5A1N8IcNrvRsJp5NETD3AZJZBY7/aYu6OrhW/QRWXNozgvVsmAE8fBqE
         KWNA==
X-Gm-Message-State: AOAM533iLIIjr3LeXO5j54opejYzn8s+qnFywLEWCXJYdoB1v5ga4XVM
        CPSqqbOBqWZMOvmoh0L4YKP4wj2qjNTGXqBRfKwgfQ==
X-Google-Smtp-Source: ABdhPJzV1u7Nmx1s6U90suVoJm1WVLVMV8qE4Q4yO//QLsjdAGGbgcokX4grSdZuofesC94eqPdTCf3JR9oUyaaS3jY=
X-Received: by 2002:ab0:5b59:: with SMTP id v25mr2722821uae.112.1626996655977;
 Thu, 22 Jul 2021 16:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcxDJ7YsnYtyzSmgfBj-rmALkjigKx2ODB=SCYCzY8FJYg4iA@mail.gmail.com>
 <20210722151930.GA1453521@agluck-desk2.amr.corp.intel.com>
In-Reply-To: <20210722151930.GA1453521@agluck-desk2.amr.corp.intel.com>
From:   Jue Wang <juew@google.com>
Date:   Thu, 22 Jul 2021 16:30:44 -0700
Message-ID: <CAPcxDJ6bB7GEhTq9fkHuT4chRTUk_s-crci=nh+COCwAzMP8Yw@mail.gmail.com>
Subject: Re: [PATCH 2/3] x86/mce: Avoid infinite loop for copy from user recovery
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, dinghui@sangfor.com.cn,
        huangcun@sangfor.com.cn, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Oscar Salvador <osalvador@suse.de>,
        x86 <x86@kernel.org>, "Song, Youquan" <youquan.song@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

I think the challenge being the uncorrectable errors are essentially
random. It's
just a matter of time for >1 UC errors to show up in sequential kernel accesses.

It's easy to create such cases with artificial error injections.

I suspect we want to design this part of the kernel to be able to handle generic
cases?

Thanks,
-Jue

On Thu, Jul 22, 2021 at 8:19 AM Luck, Tony <tony.luck@intel.com> wrote:
>
> On Thu, Jul 22, 2021 at 06:54:37AM -0700, Jue Wang wrote:
> > This patch assumes the UC error consumed in kernel is always the same UC.
> >
> > Yet it's possible two UCs on different pages are consumed in a row.
> > The patch below will panic on the 2nd MCE. How can we make the code works
> > on multiple UC errors?
> >
> >
> > > + int count = ++current->mce_count;
> > > +
> > > + /* First call, save all the details */
> > > + if (count == 1) {
> > > + current->mce_addr = m->addr;
> > > + current->mce_kflags = m->kflags;
> > > + current->mce_ripv = !!(m->mcgstatus & MCG_STATUS_RIPV);
> > > + current->mce_whole_page = whole_page(m);
> > > + current->mce_kill_me.func = func;
> > > + }
> > > ......
> > > + /* Second or later call, make sure page address matches the one from first call */
> > > + if (count > 1 && (current->mce_addr >> PAGE_SHIFT) != (m->addr >> PAGE_SHIFT))
> > > + mce_panic("Machine checks to different user pages", m, msg);
>
> The issue is getting the information about the location
> of the error from the machine check handler to the "task_work"
> function that processes it. Currently there is a single place
> to store the address of the error in the task structure:
>
>         current->mce_addr = m->addr;
>
> Plausibly that could be made into an array, indexed by
> current->mce_count to save mutiple addresses (perhaps
> also need mce_kflags, mce_ripv, etc. to also be arrays).
>
> But I don't want to pre-emptively make such a change without
> some data to show that situations arise with multiple errors
> to different addresses:
> 1) Actually occur
> 2) Would be recovered if we made the change.
>
> The first would be indicated by seeing the:
>
>         "Machine checks to different user pages"
>
> panic. You'd have to code up the change to have arrays
> to confirm that would fix the problem.
>
> -Tony
