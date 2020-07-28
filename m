Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6939922FEA4
	for <lists+linux-edac@lfdr.de>; Tue, 28 Jul 2020 02:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgG1Azz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Jul 2020 20:55:55 -0400
Received: from mga03.intel.com ([134.134.136.65]:9773 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgG1Azy (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 27 Jul 2020 20:55:54 -0400
IronPort-SDR: h5p0olUpGF9ooLhzNfQfIDrrrgTNdKsHyz7GB6QZJRvM30z2WzCLdHZJPh3YA7QqY7p7GPLcm1
 i2z3Ztf14Lmg==
X-IronPort-AV: E=McAfee;i="6000,8403,9695"; a="151116580"
X-IronPort-AV: E=Sophos;i="5.75,404,1589266800"; 
   d="scan'208";a="151116580"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2020 17:55:53 -0700
IronPort-SDR: kffFnXfuJa226G3x+5zKZm7o0hRAail1hqbvUI0+Kzhm5u/CfXd0H4FgT0FvUsj/Of0ROKJhVP
 wVLS52a/mL6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,404,1589266800"; 
   d="scan'208";a="272157472"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga007.fm.intel.com with ESMTP; 27 Jul 2020 17:55:52 -0700
Date:   Mon, 27 Jul 2020 17:55:32 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     hpa@zytor.com
Cc:     peterz@infradead.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Cathy Zhang <cathy.zhang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Kyung Min Park <kyung.min.park@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH 4/4] x86/cpu: Use SERIALIZE in sync_core() when available
Message-ID: <20200728005532.GC23421@ranerica-svr.sc.intel.com>
References: <20200727043132.15082-1-ricardo.neri-calderon@linux.intel.com>
 <20200727043132.15082-5-ricardo.neri-calderon@linux.intel.com>
 <20200727082003.GD119549@hirez.programming.kicks-ass.net>
 <2A0D15F3-BAF2-47CE-AF5F-DB681793D07D@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2A0D15F3-BAF2-47CE-AF5F-DB681793D07D@zytor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jul 27, 2020 at 05:47:32AM -0700, hpa@zytor.com wrote:
> On July 27, 2020 1:20:03 AM PDT, peterz@infradead.org wrote:
> >On Sun, Jul 26, 2020 at 09:31:32PM -0700, Ricardo Neri wrote:
> >> +static inline void serialize(void)
> >> +{
> >> +	asm volatile(".byte 0xf, 0x1, 0xe8");
> >> +}
> >
> >Can we pretty please have a comment with the binutils version that has
> >the mnomic? Such that when we increase the required binutils version we
> >can grep for this.
> 
> It also needs : : : "memory" to be a barrier.

Sure Peter, I will make this change.

Thanks and BR,
Ricardo
