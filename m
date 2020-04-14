Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1991A8BB9
	for <lists+linux-edac@lfdr.de>; Tue, 14 Apr 2020 21:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505301AbgDNT6W (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 14 Apr 2020 15:58:22 -0400
Received: from mga18.intel.com ([134.134.136.126]:62397 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505317AbgDNT6R (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 14 Apr 2020 15:58:17 -0400
IronPort-SDR: iWC8AtW5tZSY/zT8y1nVewR3JcuaoC7zTX7ARFhpd5cV/FbBvd2joj14j6KwcIUWoSGVEIVMSU
 5qeL+b4vZH3A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 12:58:12 -0700
IronPort-SDR: pdkL40ELjhuGUKWhIbAR8yzLKgEiDVcAac7aIY1qps6kzICYdSwEa96h/zysx5ct0vNL07nkcF
 bqYXZDkhB8ZA==
X-IronPort-AV: E=Sophos;i="5.72,384,1580803200"; 
   d="scan'208";a="332280312"
Received: from spandruv-mobl.amr.corp.intel.com ([10.134.69.31])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 12:58:11 -0700
Message-ID: <24c4ac84671b97b5092413689b4bf224b73bc51b.camel@linux.intel.com>
Subject: Re: [PATCH 3/3] x86/mce/therm_throt: allow disabling the thermal
 vector altogether
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-edac@vger.kernel.org,
        X86 ML <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        bberg@redhat.com, bp@suse.de
Date:   Tue, 14 Apr 2020 12:58:04 -0700
In-Reply-To: <CAHmME9rfXXPepanaxR6EBimSNkJp6KTuNLkYcSceGwZXp_j-Kw@mail.gmail.com>
References: <20200407063345.4484-1-Jason@zx2c4.com>
         <20200407063345.4484-3-Jason@zx2c4.com>
         <0e189a4fe1e69b08afc859ce83623a0e5ea0c08b.camel@linux.intel.com>
         <CAHmME9pigvAgK3Bje6DkFEcdyWwi7-C7D6QEo4YiH_cbJvxqhQ@mail.gmail.com>
         <4b75ec34ccff5abdc0b1c04a5ac39455ddd4f49b.camel@linux.intel.com>
         <CAHmME9rfXXPepanaxR6EBimSNkJp6KTuNLkYcSceGwZXp_j-Kw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, 2020-04-14 at 13:41 -0600, Jason A. Donenfeld wrote:
> On Tue, Apr 14, 2020 at 8:45 AM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > On Mon, 2020-04-13 at 22:21 -0600, Jason A. Donenfeld wrote:
> > > On Mon, Apr 13, 2020 at 9:38 PM Srinivas Pandruvada
> > > <srinivas.pandruvada@linux.intel.com> wrote:
> > > > On Tue, 2020-04-07 at 00:33 -0600, Jason A. Donenfeld wrote:
> > > > > The thermal IRQ handler uses 1.21% CPU on my system when it's
> > > > > hot
> > > > > from
> > > > > compiling things. Indeed looking at /proc/interrupts reveals
> > > > > quite a
> > > > > lot
> > > > I am curious why you are hitting threshold frequently?
> > > > What is rdmsr 0x1a2
> > > 
> > > 5640000
> > You are getting too many interrupts at 95C. You should look at your
> > cooling system.
> > 
> > > > > of events coming in. Beyond logging them, the existing
> > > > > drivers on
> > > > > the
> > > > > system don't appear to do very much that I'm interested in.
> > > > > So,
> > > > > add a
> > > > > way to disable this entirely so that I can regain precious
> > > > > CPU
> > > > > cycles.
> > > > It is showing amount of time system is running in a constrained
> > > > environment. Lots of real time and HPC folks really care about
> > > > this.
> > > 
> > > Which is why this patch adds an option, not a full removal or
> > > something. Real time and HPC people can keep their expensive
> > > interrupt. Other people with different varieties of system
> > > disable
> > > it.
> > Generally compile time flag is not desirable. If it is what
> > required
> > then we should have boot time flag something in lines of existing
> > "int_pln_enable" option.
> 
> Generally it is desirable, and extremely common too. This thermal
> code
> -- which mostly functions to print some messages into kmsg -- is very
> verbose. This is not something I want to compile into smaller
> systems.
> This is the reason why kconfig has options in the first place. I'm
> not
> sure yet-another boottime flag makes sense for this.

Can you send log which is still showing verbose prints with the latest
kernel? I can see interrupts will still fire.

If it is, then temperature trend is still above 95C and cooling systems
is not in control. In another window, print in loop (with sleep 1)
/sys/class/thermal/thermal_zone*/temp
for the zone for which "type == x86_pkg_temp"




