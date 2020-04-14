Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5E91A8D4B
	for <lists+linux-edac@lfdr.de>; Tue, 14 Apr 2020 23:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732460AbgDNVHo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 14 Apr 2020 17:07:44 -0400
Received: from mail.zx2c4.com ([192.95.5.64]:52035 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732367AbgDNVHl (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 14 Apr 2020 17:07:41 -0400
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 0cd7b4b7;
        Tue, 14 Apr 2020 20:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=5DhwPdr90+QtkVR8xcg07LBrJoI=; b=U+jX9r
        8yrkUxZhtn4kQIxJC+Ea/+L8Y09Zh00N+ZBe6XOKuFtdXwoggf4VHS1wUHm5Du2s
        UemIsWwbRAXxt22CRYOhloBYQmUshvZWH56YteCK9tfQfBe2yiZUbYl9Iq3HPFUG
        d8cxr8ZxathLvctg/PdMtqoMkkL9dNkOWtzPv9geKUQiaAHUHTX5FMkGxIukiloA
        UNMB7EvM4Jr2++LTO8kvOL0jKbelySykJhPcnD4Zw+TZV13M23EfCBbIdxiESSXF
        drbnDurge8Tg9l7jOarhJRwL0NjGlTz6t0jES9AJ1lSgAuOIw8NKSvOiRU/ZILqG
        4cNesBmiZKlD9S2A==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3ff8e22b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 14 Apr 2020 20:57:44 +0000 (UTC)
Received: by mail-io1-f48.google.com with SMTP id i19so14755823ioh.12;
        Tue, 14 Apr 2020 14:07:36 -0700 (PDT)
X-Gm-Message-State: AGi0PuZq1kTStGHqsZvoCtlXR6AVdOmSchpZEBeyyd6Z/SKlsEn+OPAa
        4MIipINzQ7VeP3oSxwhTtkMVTZQ7aL364Mhp1Cc=
X-Google-Smtp-Source: APiQypIw0rxPlXTWYLvdg2GcD6Eej7w4dDwBvWfh+SHT9COBGheXV0ac0fyQudStRpT35Kyca/sHqg7sqyetbWwQmGY=
X-Received: by 2002:a02:a68e:: with SMTP id j14mr23024098jam.86.1586898455662;
 Tue, 14 Apr 2020 14:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200407063345.4484-1-Jason@zx2c4.com> <20200407063345.4484-3-Jason@zx2c4.com>
 <0e189a4fe1e69b08afc859ce83623a0e5ea0c08b.camel@linux.intel.com>
 <CAHmME9pigvAgK3Bje6DkFEcdyWwi7-C7D6QEo4YiH_cbJvxqhQ@mail.gmail.com>
 <4b75ec34ccff5abdc0b1c04a5ac39455ddd4f49b.camel@linux.intel.com>
 <CAHmME9rfXXPepanaxR6EBimSNkJp6KTuNLkYcSceGwZXp_j-Kw@mail.gmail.com>
 <20200414202328.GK31763@zn.tnic> <81359df9983fb70bd40ddb3be9090e5521294529.camel@linux.intel.com>
In-Reply-To: <81359df9983fb70bd40ddb3be9090e5521294529.camel@linux.intel.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 14 Apr 2020 15:07:24 -0600
X-Gmail-Original-Message-ID: <CAHmME9rx6w=p6+AFP=0Y5tPEq1CxUTGe4h8SXz-qRNuCvU0hyw@mail.gmail.com>
Message-ID: <CAHmME9rx6w=p6+AFP=0Y5tPEq1CxUTGe4h8SXz-qRNuCvU0hyw@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86/mce/therm_throt: allow disabling the thermal
 vector altogether
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Borislav Petkov <bp@suse.de>, LKML <linux-kernel@vger.kernel.org>,
        linux-edac@vger.kernel.org, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, bberg@redhat.com,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Apr 14, 2020 at 2:49 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Tue, 2020-04-14 at 22:23 +0200, Borislav Petkov wrote:
> > + Tony.
> >
> > On Tue, Apr 14, 2020 at 01:41:08PM -0600, Jason A. Donenfeld wrote:
> > > Generally it is desirable, and extremely common too. This thermal
> > > code
> > > -- which mostly functions to print some messages into kmsg -- is
> > > very
> > > verbose. This is not something I want to compile into smaller
> > > systems.
> > > This is the reason why kconfig has options in the first place. I'm
> > > not
> > > sure yet-another boottime flag makes sense for this.
> >
> > I don't mind making the already existing option selectable and
> > leaving
> > it default y, i.e., keeping the current situation by default. And
> > people
> > who want to disable it, can then do so.
> >
> > I do mind to having yet another config option though. No thanks -
> > they're already too many.
> >
> > So it should be an all or nothing thing.
> >
> > Poking quickly at that and
> > drivers/thermal/intel/x86_pkg_temp_thermal.c,
> > all those things do is report trip points. therm_throt reports how
> > long
> > the hw throttled due to hitting a trip point, etc.
> >
> > IINM, of course so please correct me if I'm missing anything.
> >
> > But if not and this all is only for reporting and doesn't have any
> > detrimental effects on the hardware when missing from the system,
> > then I
> > guess we could make CONFIG_X86_THERMAL_VECTOR user-selectable.
>
> We can make user selectable
>
> These drivers are used for reporting only.
> User space can select a trip temperature via x86_pkg_temp and get
> notification via uevent to start additional cooling system (additional

I didn't see any uevent stuff. Is this part of out-of-tree modules or
proprietary code that's hooking into those EXPORT_SYMBOL (non-GPL)
exports?

> fans, liquid coooling etc), so that processor don't have to go self
> throttling mode. Self throttling depending on processor series and
> firmware can be very aggressive.
> In client systems thermald will set a temperature and starts power
> control once it reaches passive temperature limit. But it can function
> without x86_pkg_temp also, so even if user disables thermal reporting
> it can still function.

The 2/3 patch may be interesting as well to you. This removes the
expensive work queue management stuff if the option is deselected,
since all those workqueues do is print messages to kmsg, while
retaining the rest of the infra.
