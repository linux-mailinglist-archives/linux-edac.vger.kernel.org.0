Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDBC71A8B42
	for <lists+linux-edac@lfdr.de>; Tue, 14 Apr 2020 21:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505018AbgDNTl2 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 14 Apr 2020 15:41:28 -0400
Received: from mail.zx2c4.com ([192.95.5.64]:38323 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504949AbgDNTl1 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 14 Apr 2020 15:41:27 -0400
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id e19eaa70;
        Tue, 14 Apr 2020 19:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=h/aE5SG6wxx7pSOie0SLEE7AeHU=; b=ueL7pC
        5QY12n2HfHdvyvsYLpUVOW4X2stzK6kd4Z1g0X2SRgYM0vQwjlaUR8Wrs2zH4/AJ
        dyh9G7LCTMREU+GFZDVnKVQldKIZ6Qg/JxLm9Nw6f+9TnfncYuiQe6Yj2rMpJeDE
        h6BDJpdhCloK6DbabBkJOT0RuKX9mHE/bnZrpB7zu88Cz8K00KGV+rH8iujAmJXI
        FJYgIOIzD05lhSBzQWRsE6COyU4LMD9tpUOIEQ/BryOSslHi5Z9KRPisuzHSYx8K
        CICUxlFKLqTUXN8kWxvYiSS+B/HNv/hZb4tU71GyDwFpyLvGp7X6fHACD+2z5mfT
        dcwcMvD7E2oJkHRw==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e6fd408d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 14 Apr 2020 19:31:28 +0000 (UTC)
Received: by mail-il1-f170.google.com with SMTP id i2so902523ils.12;
        Tue, 14 Apr 2020 12:41:20 -0700 (PDT)
X-Gm-Message-State: AGi0Pubd6kI6GaWTYl2jUWdsoQugfsqQWrYJIqvqc2YZ28P9C1Of3ZP/
        orMKLthdb7etz4naXK6Of4rDKHfQkLtmo2xtVes=
X-Google-Smtp-Source: APiQypLkVGkvLIsHGulPITZS3NPQWVdbPBZMqpBJ0lrhd8gs1AWtilULaBZVAcr5z+2q9NRlWUnLHZL2vlZjHqcVXh0=
X-Received: by 2002:a92:c7a3:: with SMTP id f3mr1922827ilk.207.1586893279635;
 Tue, 14 Apr 2020 12:41:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200407063345.4484-1-Jason@zx2c4.com> <20200407063345.4484-3-Jason@zx2c4.com>
 <0e189a4fe1e69b08afc859ce83623a0e5ea0c08b.camel@linux.intel.com>
 <CAHmME9pigvAgK3Bje6DkFEcdyWwi7-C7D6QEo4YiH_cbJvxqhQ@mail.gmail.com> <4b75ec34ccff5abdc0b1c04a5ac39455ddd4f49b.camel@linux.intel.com>
In-Reply-To: <4b75ec34ccff5abdc0b1c04a5ac39455ddd4f49b.camel@linux.intel.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 14 Apr 2020 13:41:08 -0600
X-Gmail-Original-Message-ID: <CAHmME9rfXXPepanaxR6EBimSNkJp6KTuNLkYcSceGwZXp_j-Kw@mail.gmail.com>
Message-ID: <CAHmME9rfXXPepanaxR6EBimSNkJp6KTuNLkYcSceGwZXp_j-Kw@mail.gmail.com>
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

On Tue, Apr 14, 2020 at 8:45 AM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Mon, 2020-04-13 at 22:21 -0600, Jason A. Donenfeld wrote:
> > On Mon, Apr 13, 2020 at 9:38 PM Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> > > On Tue, 2020-04-07 at 00:33 -0600, Jason A. Donenfeld wrote:
> > > > The thermal IRQ handler uses 1.21% CPU on my system when it's hot
> > > > from
> > > > compiling things. Indeed looking at /proc/interrupts reveals
> > > > quite a
> > > > lot
> > > I am curious why you are hitting threshold frequently?
> > > What is rdmsr 0x1a2
> >
> > 5640000
> You are getting too many interrupts at 95C. You should look at your
> cooling system.
>
> >
> > > > of events coming in. Beyond logging them, the existing drivers on
> > > > the
> > > > system don't appear to do very much that I'm interested in. So,
> > > > add a
> > > > way to disable this entirely so that I can regain precious CPU
> > > > cycles.
> > > It is showing amount of time system is running in a constrained
> > > environment. Lots of real time and HPC folks really care about
> > > this.
> >
> > Which is why this patch adds an option, not a full removal or
> > something. Real time and HPC people can keep their expensive
> > interrupt. Other people with different varieties of system
> > disable
> > it.
> Generally compile time flag is not desirable. If it is what required
> then we should have boot time flag something in lines of existing
> "int_pln_enable" option.

Generally it is desirable, and extremely common too. This thermal code
-- which mostly functions to print some messages into kmsg -- is very
verbose. This is not something I want to compile into smaller systems.
This is the reason why kconfig has options in the first place. I'm not
sure yet-another boottime flag makes sense for this.
