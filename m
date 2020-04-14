Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 460AD1A8BEF
	for <lists+linux-edac@lfdr.de>; Tue, 14 Apr 2020 22:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505495AbgDNUJT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 14 Apr 2020 16:09:19 -0400
Received: from mail.zx2c4.com ([192.95.5.64]:34807 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505445AbgDNUJS (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 14 Apr 2020 16:09:18 -0400
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id f26f0e78;
        Tue, 14 Apr 2020 19:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=pAmOQHaOEgfqZI+i6EXjutI5JI0=; b=WpGA60
        xAHYTARIO3swYDmA4JV0vCZkvEcHJ3GZyWQMM+IB6CJmjPVeukhIiA9sY/HKsLih
        J2i4kEHnUyxZl+OyPcXhgzQ50NsInr3ol6OBwQKU84rInXfFLHQnF37tdzgY5c0I
        B+7NNxYWyl1WpcJ29TU1jh5HyjAwr3cIsfZxoq1gSOj/wpDfLU99y2hEr8SPHKPs
        PoKv4ec3dJAwV1xhIbPIHw7KYBAJYzNhpFEuvzgqfJYINOzPKOSpPtqEopaXF59f
        uPvKy8IgT+uQvZZOgIjbDly0iXkmrB4xmFxYuxk3ILvT4pRL6vODIgDpV0pCVPw8
        eiB2j9cw6YXpqbFA==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c8bef353 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 14 Apr 2020 19:59:24 +0000 (UTC)
Received: by mail-il1-f170.google.com with SMTP id b18so1054276ilf.2;
        Tue, 14 Apr 2020 13:09:16 -0700 (PDT)
X-Gm-Message-State: AGi0Puag8TqoJOZE4tDFn8R/te/5kVMQmHlAYiw3xUQ9xc22p+2iPRfv
        2mXv3L2udu69XttBEDZMIPYpt5Cqh/NciMpCSx0=
X-Google-Smtp-Source: APiQypJZ0K1mNpMSy98DlJSx/G/Z6de7g5ow7ZKNiKa5yFTU8yGzF8WbxCEpjqHPzJ5mTQ/IUejV7KubA9PAo/tUM7A=
X-Received: by 2002:a92:9fc2:: with SMTP id z63mr1980508ilk.64.1586894955909;
 Tue, 14 Apr 2020 13:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200407063345.4484-1-Jason@zx2c4.com> <20200407063345.4484-3-Jason@zx2c4.com>
 <0e189a4fe1e69b08afc859ce83623a0e5ea0c08b.camel@linux.intel.com>
 <CAHmME9pigvAgK3Bje6DkFEcdyWwi7-C7D6QEo4YiH_cbJvxqhQ@mail.gmail.com>
 <4b75ec34ccff5abdc0b1c04a5ac39455ddd4f49b.camel@linux.intel.com>
 <CAHmME9rfXXPepanaxR6EBimSNkJp6KTuNLkYcSceGwZXp_j-Kw@mail.gmail.com> <24c4ac84671b97b5092413689b4bf224b73bc51b.camel@linux.intel.com>
In-Reply-To: <24c4ac84671b97b5092413689b4bf224b73bc51b.camel@linux.intel.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 14 Apr 2020 14:09:05 -0600
X-Gmail-Original-Message-ID: <CAHmME9p1v7mMkMf1j4FQpNm5MWAO+TeQdvn0bh_XPjpXwyJkLg@mail.gmail.com>
Message-ID: <CAHmME9p1v7mMkMf1j4FQpNm5MWAO+TeQdvn0bh_XPjpXwyJkLg@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86/mce/therm_throt: allow disabling the thermal
 vector altogether
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-edac@vger.kernel.org,
        X86 ML <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        bberg@redhat.com, bp@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Apr 14, 2020 at 1:58 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Tue, 2020-04-14 at 13:41 -0600, Jason A. Donenfeld wrote:
> > On Tue, Apr 14, 2020 at 8:45 AM Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> > > On Mon, 2020-04-13 at 22:21 -0600, Jason A. Donenfeld wrote:
> > > > On Mon, Apr 13, 2020 at 9:38 PM Srinivas Pandruvada
> > > > <srinivas.pandruvada@linux.intel.com> wrote:
> > > > > On Tue, 2020-04-07 at 00:33 -0600, Jason A. Donenfeld wrote:
> > > > > > The thermal IRQ handler uses 1.21% CPU on my system when it's
> > > > > > hot
> > > > > > from
> > > > > > compiling things. Indeed looking at /proc/interrupts reveals
> > > > > > quite a
> > > > > > lot
> > > > > I am curious why you are hitting threshold frequently?
> > > > > What is rdmsr 0x1a2
> > > >
> > > > 5640000
> > > You are getting too many interrupts at 95C. You should look at your
> > > cooling system.
> > >
> > > > > > of events coming in. Beyond logging them, the existing
> > > > > > drivers on
> > > > > > the
> > > > > > system don't appear to do very much that I'm interested in.
> > > > > > So,
> > > > > > add a
> > > > > > way to disable this entirely so that I can regain precious
> > > > > > CPU
> > > > > > cycles.
> > > > > It is showing amount of time system is running in a constrained
> > > > > environment. Lots of real time and HPC folks really care about
> > > > > this.
> > > >
> > > > Which is why this patch adds an option, not a full removal or
> > > > something. Real time and HPC people can keep their expensive
> > > > interrupt. Other people with different varieties of system
> > > > disable
> > > > it.
> > > Generally compile time flag is not desirable. If it is what
> > > required
> > > then we should have boot time flag something in lines of existing
> > > "int_pln_enable" option.
> >
> > Generally it is desirable, and extremely common too. This thermal
> > code
> > -- which mostly functions to print some messages into kmsg -- is very
> > verbose. This is not something I want to compile into smaller
> > systems.
> > This is the reason why kconfig has options in the first place. I'm
> > not
> > sure yet-another boottime flag makes sense for this.
>
> Can you send log which is still showing verbose prints with the latest
> kernel? I can see interrupts will still fire.
>
> If it is, then temperature trend is still above 95C and cooling systems
> is not in control. In another window, print in loop (with sleep 1)
> /sys/class/thermal/thermal_zone*/temp
> for the zone for which "type == x86_pkg_temp"

It sounds like you're interested in debugging the cooling system of my
[brand new Thinkpad P1 gen 2] laptop. I appreciate the concern, but
that's really not the purpose of this patch. The purpose of this patch
is to enable disabling the sizable thermal interrupt code, that does
absolutely nothing for a wide variety of systems that do not want that
code in their kernel. In other words, I don't think the particular
thinkpad cooling aspects have anything to do with the need to add the
trivial Kconfig option to not compile this code. I realize it's your
code and you might really like it, but that doesn't mean everyone
wants it in their kernel image.
