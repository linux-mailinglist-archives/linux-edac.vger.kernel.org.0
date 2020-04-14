Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A69311A8CD3
	for <lists+linux-edac@lfdr.de>; Tue, 14 Apr 2020 22:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633382AbgDNUt0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 14 Apr 2020 16:49:26 -0400
Received: from mga05.intel.com ([192.55.52.43]:21026 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729251AbgDNUtY (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 14 Apr 2020 16:49:24 -0400
IronPort-SDR: Pkf0MVaWl4FGcR/JSWZkC5PkHCiINzQ1/5+27WulJnkLMJ0LQyyiXEgQngnT7uxUFV6hTTlI9U
 6VEUkwrukOjw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 13:49:23 -0700
IronPort-SDR: z09oPnrrskOdKVIxrcy/Slo2HLk4de2A8to5xuDqqtfJZXnIOJSvU+cBOE8i2EWeMm4PVIqFQ7
 07MK1U32Hfxw==
X-IronPort-AV: E=Sophos;i="5.72,384,1580803200"; 
   d="scan'208";a="298809985"
Received: from spandruv-mobl.amr.corp.intel.com ([10.134.69.31])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 13:49:22 -0700
Message-ID: <81359df9983fb70bd40ddb3be9090e5521294529.camel@linux.intel.com>
Subject: Re: [PATCH 3/3] x86/mce/therm_throt: allow disabling the thermal
 vector altogether
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Borislav Petkov <bp@suse.de>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-edac@vger.kernel.org,
        X86 ML <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        bberg@redhat.com, Tony Luck <tony.luck@intel.com>
Date:   Tue, 14 Apr 2020 13:49:21 -0700
In-Reply-To: <20200414202328.GK31763@zn.tnic>
References: <20200407063345.4484-1-Jason@zx2c4.com>
         <20200407063345.4484-3-Jason@zx2c4.com>
         <0e189a4fe1e69b08afc859ce83623a0e5ea0c08b.camel@linux.intel.com>
         <CAHmME9pigvAgK3Bje6DkFEcdyWwi7-C7D6QEo4YiH_cbJvxqhQ@mail.gmail.com>
         <4b75ec34ccff5abdc0b1c04a5ac39455ddd4f49b.camel@linux.intel.com>
         <CAHmME9rfXXPepanaxR6EBimSNkJp6KTuNLkYcSceGwZXp_j-Kw@mail.gmail.com>
         <20200414202328.GK31763@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, 2020-04-14 at 22:23 +0200, Borislav Petkov wrote:
> + Tony.
> 
> On Tue, Apr 14, 2020 at 01:41:08PM -0600, Jason A. Donenfeld wrote:
> > Generally it is desirable, and extremely common too. This thermal
> > code
> > -- which mostly functions to print some messages into kmsg -- is
> > very
> > verbose. This is not something I want to compile into smaller
> > systems.
> > This is the reason why kconfig has options in the first place. I'm
> > not
> > sure yet-another boottime flag makes sense for this.
> 
> I don't mind making the already existing option selectable and
> leaving
> it default y, i.e., keeping the current situation by default. And
> people
> who want to disable it, can then do so.
> 
> I do mind to having yet another config option though. No thanks -
> they're already too many.
> 
> So it should be an all or nothing thing.
> 
> Poking quickly at that and
> drivers/thermal/intel/x86_pkg_temp_thermal.c,
> all those things do is report trip points. therm_throt reports how
> long
> the hw throttled due to hitting a trip point, etc.
> 
> IINM, of course so please correct me if I'm missing anything.
> 
> But if not and this all is only for reporting and doesn't have any
> detrimental effects on the hardware when missing from the system,
> then I
> guess we could make CONFIG_X86_THERMAL_VECTOR user-selectable.

We can make user selectable

These drivers are used for reporting only.
User space can select a trip temperature via x86_pkg_temp and get
notification via uevent to start additional cooling system (additional
fans, liquid coooling etc), so that processor don't have to go self
throttling mode. Self throttling depending on processor series and
firmware can be very aggressive.
In client systems thermald will set a temperature and starts power
control once it reaches passive temperature limit. But it can function
without x86_pkg_temp also, so even if user disables thermal reporting
it can still function.
 
Thanks,
Srinivas


> 
> Thx.
> 

