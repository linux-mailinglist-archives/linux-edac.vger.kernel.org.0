Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42501A8C67
	for <lists+linux-edac@lfdr.de>; Tue, 14 Apr 2020 22:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633045AbgDNUXl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 14 Apr 2020 16:23:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:43980 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2633040AbgDNUXk (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 14 Apr 2020 16:23:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BC76EAEFD;
        Tue, 14 Apr 2020 20:23:36 +0000 (UTC)
Date:   Tue, 14 Apr 2020 22:23:28 +0200
From:   Borislav Petkov <bp@suse.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-edac@vger.kernel.org,
        X86 ML <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        bberg@redhat.com, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 3/3] x86/mce/therm_throt: allow disabling the thermal
 vector altogether
Message-ID: <20200414202328.GK31763@zn.tnic>
References: <20200407063345.4484-1-Jason@zx2c4.com>
 <20200407063345.4484-3-Jason@zx2c4.com>
 <0e189a4fe1e69b08afc859ce83623a0e5ea0c08b.camel@linux.intel.com>
 <CAHmME9pigvAgK3Bje6DkFEcdyWwi7-C7D6QEo4YiH_cbJvxqhQ@mail.gmail.com>
 <4b75ec34ccff5abdc0b1c04a5ac39455ddd4f49b.camel@linux.intel.com>
 <CAHmME9rfXXPepanaxR6EBimSNkJp6KTuNLkYcSceGwZXp_j-Kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHmME9rfXXPepanaxR6EBimSNkJp6KTuNLkYcSceGwZXp_j-Kw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

+ Tony.

On Tue, Apr 14, 2020 at 01:41:08PM -0600, Jason A. Donenfeld wrote:
> Generally it is desirable, and extremely common too. This thermal code
> -- which mostly functions to print some messages into kmsg -- is very
> verbose. This is not something I want to compile into smaller systems.
> This is the reason why kconfig has options in the first place. I'm not
> sure yet-another boottime flag makes sense for this.

I don't mind making the already existing option selectable and leaving
it default y, i.e., keeping the current situation by default. And people
who want to disable it, can then do so.

I do mind to having yet another config option though. No thanks -
they're already too many.

So it should be an all or nothing thing.

Poking quickly at that and drivers/thermal/intel/x86_pkg_temp_thermal.c,
all those things do is report trip points. therm_throt reports how long
the hw throttled due to hitting a trip point, etc.

IINM, of course so please correct me if I'm missing anything.

But if not and this all is only for reporting and doesn't have any
detrimental effects on the hardware when missing from the system, then I
guess we could make CONFIG_X86_THERMAL_VECTOR user-selectable.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
