Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F522DC9F0
	for <lists+linux-edac@lfdr.de>; Fri, 18 Oct 2019 17:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfJRPzS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 18 Oct 2019 11:55:18 -0400
Received: from mga17.intel.com ([192.55.52.151]:58075 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbfJRPzR (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 18 Oct 2019 11:55:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Oct 2019 08:55:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,312,1566889200"; 
   d="scan'208";a="221781346"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga004.fm.intel.com with ESMTP; 18 Oct 2019 08:55:17 -0700
Message-ID: <0f78feb77feba6d3add74a46a16b9d0b3b9c3653.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] x86, mce, therm_throt: Optimize logging of thermal
 throttle messages
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "bberg@redhat.com" <bberg@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "ckellner@redhat.com" <ckellner@redhat.com>
Date:   Fri, 18 Oct 2019 08:55:17 -0700
In-Reply-To: <20191018132309.GD17053@zn.tnic>
References: <2c2b65c23be3064504566c5f621c1f37bf7e7326.camel@redhat.com>
         <20191014212101.25719-1-srinivas.pandruvada@linux.intel.com>
         <20191015084833.GD2311@hirez.programming.kicks-ass.net>
         <f481b4ab6dfebbc0637c843e5f1cd4ddfd4bd60b.camel@linux.intel.com>
         <20191016081405.GO2328@hirez.programming.kicks-ass.net>
         <20191016140001.GF1138@zn.tnic>
         <3908561D78D1C84285E8C5FCA982C28F7F4A57D0@ORSMSX115.amr.corp.intel.com>
         <20191017214445.GG14441@zn.tnic>
         <c2ce4ef128aad84616b2dc21f6230ad4db12194b.camel@linux.intel.com>
         <20191018132309.GD17053@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, 2019-10-18 at 15:23 +0200, Borislav Petkov wrote:
> On Fri, Oct 18, 2019 at 05:26:36AM -0700, Srinivas Pandruvada wrote:
> > Server/desktops generally rely on the embedded controller for FAN
> > control, which  kernel have no control. For them this warning helps
> > to
> > either bring in additional cooling or fix existing cooling.
> 
> How exactly does this warning help? A detailed example please.
I assume that someone is having performance issues or occasion reboots,
look at the logs. Is it a fair assumption? If not, logging has no
value.

In the current code, this logging is misleading. It is reporting all
normal throttling at PROCHOT.

But if a system is running at up to 87.5% of duty cycle on top of
lowest possible frequency of around 800MHz, someone will notice.
If logs are not the starting point, someone has to run tools like
turbostat and understand the cause of performance issues. Then probably
someone cleanup air vents on dusty desktop sitting under the desk.

Anyway, we can provide better document for the sysfs counters this code
is dumping and how to interpret them with or without logging support. I
can add some document under kernel documentation.

Thanks,
Srinivas




> 
> > If something needs to force throttle from kernel, then we should
> > use
> > some offset from the max temperature (aka TJMax), instead of this
> > warning threshold. Then we can use idle injection or change duty
> > cycle
> > of CPU clocks.
> 
> Yes, as I said, all this needs to be properly defined first. That is,
> *if* there's even need for reacting to thermal interrupts in the
> kernel.
> 

