Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D81E1A8DF3
	for <lists+linux-edac@lfdr.de>; Tue, 14 Apr 2020 23:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634097AbgDNVou (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 14 Apr 2020 17:44:50 -0400
Received: from mga04.intel.com ([192.55.52.120]:29042 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2634084AbgDNVol (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 14 Apr 2020 17:44:41 -0400
IronPort-SDR: 2C1T3I+iVq7QRiYfsOPKizffsckmTlBDnlcMnGhz0glz37luvuJ0IS32rWAhv0PXD+tQcWYIVx
 6dDIPT9SK8ZA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 14:44:35 -0700
IronPort-SDR: Ppf+++9IpQ95AZ4JOb3oWVi6pLy0XoDu2jTmK7uJZBWggT44Q/pCwWrzZT1WqsqPEbUBB4eICA
 1q5HYNJqGIog==
X-IronPort-AV: E=Sophos;i="5.72,384,1580803200"; 
   d="scan'208";a="332306739"
Received: from spandruv-mobl.amr.corp.intel.com ([10.134.69.31])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 14:44:33 -0700
Message-ID: <44b08ce4e636934b1179dba41b80df3a8033a975.camel@linux.intel.com>
Subject: Re: [PATCH 3/3] x86/mce/therm_throt: allow disabling the thermal
 vector altogether
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        x86@kernel.org, arnd@arndb.de, bberg@redhat.com, bp@suse.de,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Date:   Tue, 14 Apr 2020 14:44:32 -0700
In-Reply-To: <20200414214048.GL2483@worktop.programming.kicks-ass.net>
References: <20200407063345.4484-1-Jason@zx2c4.com>
         <20200407063345.4484-3-Jason@zx2c4.com>
         <20200414214048.GL2483@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, 2020-04-14 at 23:40 +0200, Peter Zijlstra wrote:
> On Tue, Apr 07, 2020 at 12:33:45AM -0600, Jason A. Donenfeld wrote:
> > The thermal IRQ handler uses 1.21% CPU on my system when it's hot
> > from
> > compiling things. Indeed looking at /proc/interrupts reveals quite
> > a lot
> > of events coming in. Beyond logging them, the existing drivers on
> > the
> > system don't appear to do very much that I'm interested in. So, add
> > a
> > way to disable this entirely so that I can regain precious CPU
> > cycles.
> 
> Why is this MCE code?!? hysterical raisins?
When this code was developed long time ago, it was also doing mce
logging. But it is no longer doing mce logging, but code is still
there.


> 
> Anyway, I wonder if this is something we should hook up to
> SCHED_THERMAL_PRESSURE, Rafael?
> 
> > diff --git a/arch/x86/kernel/cpu/mce/intel.c
> > b/arch/x86/kernel/cpu/mce/intel.c
> > index f996ffb887bc..d14f1922fb49 100644
> > --- a/arch/x86/kernel/cpu/mce/intel.c
> > +++ b/arch/x86/kernel/cpu/mce/intel.c
> > @@ -511,7 +511,8 @@ static void intel_ppin_init(struct cpuinfo_x86
> > *c)
> >  
> >  void mce_intel_feature_init(struct cpuinfo_x86 *c)
> >  {
> > -	intel_init_thermal(c);
> > +	if (IS_ENABLED(CONFIG_X86_THERMAL_VECTOR))
> > +		intel_init_thermal(c);
> >  	intel_init_cmci();
> >  	intel_init_lmce();
> >  	intel_ppin_init(c);
> > -- 
> > 2.26.0
> > 

