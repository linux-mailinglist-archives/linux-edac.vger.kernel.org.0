Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3231A7279
	for <lists+linux-edac@lfdr.de>; Tue, 14 Apr 2020 06:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405310AbgDNEVY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 14 Apr 2020 00:21:24 -0400
Received: from mail.zx2c4.com ([192.95.5.64]:38217 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405226AbgDNEVX (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 14 Apr 2020 00:21:23 -0400
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id ccc82e8a;
        Tue, 14 Apr 2020 04:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=ZHWdBzlGnU+TSQ/OY85/9pN0jDk=; b=fiurNN
        Kwg16EZkR6R765OwLLIDKvf2oVNVqv2Ovz/LbiC3xx9U4sIgVeDV3ARR1vVLROzh
        yA+9rqpAtjnNIpkaGDLRmQs2PUy/rfM7AS6uRXQhy8EpS9OMrXwPFP+ve1lbrbnN
        JE5D8A/P5qCqCcWQ+TUOYt5dR9FRfh4qya1pfoWuNkZsuJRhTnFca34XVFeU1m00
        IIeh/js5kE23MnFToIUX9YeesGlT5IXVVJTRYGaGx+pi2m5qU5WZsgRbU6GwHNyg
        MiKwWHkfOsjevH/I4zfc9hqrM+wCrfpRC7Xckxe/LJiBoJunEYuKfzVo+smA9+8a
        Hitxb1aXk2bMnOmw==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 88974827 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 14 Apr 2020 04:11:33 +0000 (UTC)
Received: by mail-il1-f174.google.com with SMTP id f82so7335232ilh.8;
        Mon, 13 Apr 2020 21:21:20 -0700 (PDT)
X-Gm-Message-State: AGi0Puag5qXIieN6iBh2lkiZGdyr/wx2ibzn7vFs1oKsFfUa9cpr/Xwb
        S8JG+s8vjbCtFMkt/TTeK9IXTvsDKmR9iRLI+yE=
X-Google-Smtp-Source: APiQypJ/7RhNGnnGookdRVoanSctjn1Vok787USuwSL3Yuhqk8qU4YRDoByE1P0QjYrfbk+dxd7U09uiMMNqPDB7Oik=
X-Received: by 2002:a92:d98c:: with SMTP id r12mr2063647iln.224.1586838079492;
 Mon, 13 Apr 2020 21:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200407063345.4484-1-Jason@zx2c4.com> <20200407063345.4484-3-Jason@zx2c4.com>
 <0e189a4fe1e69b08afc859ce83623a0e5ea0c08b.camel@linux.intel.com>
In-Reply-To: <0e189a4fe1e69b08afc859ce83623a0e5ea0c08b.camel@linux.intel.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 13 Apr 2020 22:21:08 -0600
X-Gmail-Original-Message-ID: <CAHmME9pigvAgK3Bje6DkFEcdyWwi7-C7D6QEo4YiH_cbJvxqhQ@mail.gmail.com>
Message-ID: <CAHmME9pigvAgK3Bje6DkFEcdyWwi7-C7D6QEo4YiH_cbJvxqhQ@mail.gmail.com>
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

On Mon, Apr 13, 2020 at 9:38 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Tue, 2020-04-07 at 00:33 -0600, Jason A. Donenfeld wrote:
> > The thermal IRQ handler uses 1.21% CPU on my system when it's hot
> > from
> > compiling things. Indeed looking at /proc/interrupts reveals quite a
> > lot
> I am curious why you are hitting threshold frequently?
> What is rdmsr 0x1a2

5640000

> > of events coming in. Beyond logging them, the existing drivers on the
> > system don't appear to do very much that I'm interested in. So, add a
> > way to disable this entirely so that I can regain precious CPU
> > cycles.
> It is showing amount of time system is running in a constrained
> environment. Lots of real time and HPC folks really care about this.

Which is why this patch adds an option, not a full removal or
something. Real time and HPC people can keep their expensive
interrupt. Other people with different varieties of system can disable
it.
