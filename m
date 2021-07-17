Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6203CC220
	for <lists+linux-edac@lfdr.de>; Sat, 17 Jul 2021 11:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbhGQJQe (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 17 Jul 2021 05:16:34 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:35503 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhGQJQe (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 17 Jul 2021 05:16:34 -0400
Received: (Authenticated sender: ralf@linux-mips.org)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id A074220005;
        Sat, 17 Jul 2021 09:13:33 +0000 (UTC)
Date:   Sat, 17 Jul 2021 11:13:31 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Tiezhu Yang <yangtiezhu@loongson.cn>, Willy Tarreau <w@1wt.eu>,
        linux-edac@vger.kernel.org, linux-hams@vger.kernel.org,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] MAINTAINERS: mark sections from Ralf Baechle
 orphan
Message-ID: <YPKfO/d5rjG+C/fG@linux-mips.org>
References: <20210625110419.24503-1-lukas.bulwahn@gmail.com>
 <20210625110419.24503-2-lukas.bulwahn@gmail.com>
 <CAKXUXMxFBaBneVZf3WCCYJ8Theu55Nf-gFe=hs5u3mMVd41mTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKXUXMxFBaBneVZf3WCCYJ8Theu55Nf-gFe=hs5u3mMVd41mTw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sat, Jul 17, 2021 at 09:03:05AM +0200, Lukas Bulwahn wrote:

> So, given the feedback on this overall patch set from Maciej and Kurt:
> - the domain lookup for linux-mips.org does resolve again.
> - the patchwork instance moved.
> - Ralf Baechle's email now does at least forward somewhere.

Sorry, the site suffered a complete collapse after a hardware failure
earlier this year - and I couldn't even get the failed drive replaced at
the hoster as I didn't have the privilege of opening a ticket; that was
only possible to the owner of the master account, a former MIPS employee
who for health reasons no longer is with the company.  The parent company
of MIPS Wavecomp going through bankrupcy proceedings didn't help resolving
the situation either.

Anyway, there's progress on that front and I hope to get replacement
hardware within the next week or so.

The failed drive of the lmo server hardware changed its behavioud allowing
me to reboot the system again on July 1st.  I had given up on the old
hardware in frustration so Kurt deserves the credits for getting me to try
again.
No data was lost in the crash itself.  I'm now working on fixing all the
failed subsystems, primarily due to a major OS upgrade by several releases,
some old to-do list items and changes in the environment that affect the
system.  The time required to do so is enormous; I've done virtually
nothing else since 1st of July.

I've put an writeup about the system status to
https://www.linux-mips.org/wiki/System_Recovery_Status which I'm
keeping updated as work progresses.

As for the MAINTAINERS for the ham radio protocols - AX.25 use
is going down for many years and so is NET\ROM.  ROSE has always
been a very rare protocol but all three stacks still have active
users.  With that said, I doubt somebody to do active development
and maintenace will be found.  So maybe leave my name in but
lower to "Odd Fixes" which has been the reality for years even
before I took over and imho is how it should be continued.

At this point my immediate priorities are the full restoration of
the lmo server and after that linux-ax25.org will need TLC and I want
those to be completed before diving into code again.

  Ralf
