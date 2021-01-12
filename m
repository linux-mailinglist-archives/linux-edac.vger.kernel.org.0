Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 806482F36F4
	for <lists+linux-edac@lfdr.de>; Tue, 12 Jan 2021 18:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391359AbhALRWS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 12 Jan 2021 12:22:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:56078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392446AbhALRWQ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 12 Jan 2021 12:22:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 71D5A2311C
        for <linux-edac@vger.kernel.org>; Tue, 12 Jan 2021 17:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610472094;
        bh=ELOARBBiofdYIx02xC2M8PkPXYlHSTVJmEKHZzgBULE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kM63G85GYcDem7lfwRdnJAqLP1ebW9sR8qmat/Ayek+uF749MSGlAaBYStRjg5TBD
         b2zNPH5RoM2/8UgPTWlOiLgKPSqlq9ZTGoOIo9c2o5+OBt6VUQR/TqupvBv9QHcEzm
         CPDDnw6RxTjerTu1EQDG6pkwb4zqEp8vvHbI37wZ+x0YNxDCVVb5bRID+Yl53YiPwg
         +59dFtO4wISZG6pDx6fqTnTCVo8dkOhqitf1oBt18J/pGzVWC/Kjcl2pv2fAGY99T2
         VvsHxXEpTFdAotUwGFio7bHOhxC9LOEVA52Oen5psYp6uJmB0qOgUGdZfU5VxHtri7
         pm3S2EOLos/ig==
Received: by mail-ej1-f41.google.com with SMTP id w1so4574990ejf.11
        for <linux-edac@vger.kernel.org>; Tue, 12 Jan 2021 09:21:34 -0800 (PST)
X-Gm-Message-State: AOAM533n8rDFluNsanillfSzHee3EnNAU2JNROcoMhrmlrWNgcFqbWMN
        F9+PJSbFDT1AVibfa7ZmNMjvVPlh6Rg3UDXHOWOXOQ==
X-Google-Smtp-Source: ABdhPJzG45Q6mZpr5OuQGqeovuqrQr66d54Wzrwvejj9Io/dicJpF2AjAct15P9qtUGkYrC3a/347ZsTPv1uM0FABxU=
X-Received: by 2002:a17:906:351a:: with SMTP id r26mr3767359eja.204.1610472092963;
 Tue, 12 Jan 2021 09:21:32 -0800 (PST)
MIME-Version: 1.0
References: <20210111214452.1826-2-tony.luck@intel.com> <E1FCB534-9149-437A-971E-F93C009F99C3@amacapital.net>
 <20210111222057.GA2369@agluck-desk2.amr.corp.intel.com> <CALCETrVhRF0H+R1aiy-rdguL3A_9M35R3roVAgRGaEAMCJVW0Q@mail.gmail.com>
 <20210112171628.GA15664@agluck-desk2.amr.corp.intel.com>
In-Reply-To: <20210112171628.GA15664@agluck-desk2.amr.corp.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 12 Jan 2021 09:21:21 -0800
X-Gmail-Original-Message-ID: <CALCETrWijyKoopqAHjohMbvfX191GhmMVQCQjKWx1s3+SA+-uA@mail.gmail.com>
Message-ID: <CALCETrWijyKoopqAHjohMbvfX191GhmMVQCQjKWx1s3+SA+-uA@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jan 12, 2021 at 9:16 AM Luck, Tony <tony.luck@intel.com> wrote:
>
> On Tue, Jan 12, 2021 at 09:00:14AM -0800, Andy Lutomirski wrote:
> > > On Jan 11, 2021, at 2:21 PM, Luck, Tony <tony.luck@intel.com> wrote:
> > >
> > > =EF=BB=BFOn Mon, Jan 11, 2021 at 02:11:56PM -0800, Andy Lutomirski wr=
ote:
> > >>
> > >>>> On Jan 11, 2021, at 1:45 PM, Tony Luck <tony.luck@intel.com> wrote=
:
> > >>>
> > >>> =EF=BB=BFRecovery action when get_user() triggers a machine check u=
ses the fixup
> > >>> path to make get_user() return -EFAULT.  Also queue_task_work() set=
s up
> > >>> so that kill_me_maybe() will be called on return to user mode to se=
nd a
> > >>> SIGBUS to the current process.
> > >>>
> > >>> But there are places in the kernel where the code assumes that this
> > >>> EFAULT return was simply because of a page fault. The code takes so=
me
> > >>> action to fix that, and then retries the access. This results in a =
second
> > >>> machine check.
> > >>>
> > >>> While processing this second machine check queue_task_work() is cal=
led
> > >>> again. But since this uses the same callback_head structure that
> > >>> was used in the first call, the net result is an entry on the
> > >>> current->task_works list that points to itself.
> > >>
> > >> Is this happening in pagefault_disable context or normal sleepable f=
ault context?  If the latter, maybe we should reconsider finding a way for =
the machine check code to do its work inline instead of deferring it.
> > >
> > > The first machine check is in pagefault_disable() context.
> > >
> > > static int get_futex_value_locked(u32 *dest, u32 __user *from)
> > > {
> > >        int ret;
> > >
> > >        pagefault_disable();
> > >        ret =3D __get_user(*dest, from);
> >
> > I have very mixed feelings as to whether we should even try to recover
> > from the first failure like this.  If we actually want to try to
> > recover, perhaps we should instead arrange for the second MCE to
> > recover successfully instead of panicking.
>
> Well we obviously have to "recover" from the first machine check
> in order to get to the second. Are you saying you don't like the
> different return value from get_user()?
>
> In my initial playing around with this I just had the second machine
> check simply skip the task_work_add(). This worked for this case, but
> only because there wasn't a third, fourth, etc. access to the poisoned
> data. If the caller keeps peeking, then we'll keep taking more machine
> checks - possibly forever.
>
> Even if we do recover with just one extra machine check ... that's one
> more than was necessary.

Well, we need to do *something* when the first __get_user() trips the
#MC.  It would be nice if we could actually fix up the page tables
inside the #MC handler, but, if we're in a pagefault_disable() context
we might have locks held.  Heck, we could have the pagetable lock
held, be inside NMI, etc.  Skipping the task_work_add() might actually
make sense if we get a second one.

We won't actually infinite loop in pagefault_disable() context -- if
we would, then we would also infinite loop just from a regular page
fault, too.
