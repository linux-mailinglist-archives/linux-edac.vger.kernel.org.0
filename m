Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECFD23D04A
	for <lists+linux-edac@lfdr.de>; Wed,  5 Aug 2020 21:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgHETbC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 5 Aug 2020 15:31:02 -0400
Received: from mga04.intel.com ([192.55.52.120]:24715 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728411AbgHERHl (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 5 Aug 2020 13:07:41 -0400
IronPort-SDR: ftrn1bHXVaUoaYxBD+U0Z9VjorwkCEfZFERK8Cei8Gcv/qjHVs9x7o1YKm5zm27aV20rTtOQY5
 7/aBjUbmuKvw==
X-IronPort-AV: E=McAfee;i="6000,8403,9704"; a="150056026"
X-IronPort-AV: E=Sophos;i="5.75,438,1589266800"; 
   d="scan'208";a="150056026"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 10:07:37 -0700
IronPort-SDR: Rlyu2e2Xng1qZuyU9jpKnOH/LLO1CZOURgcYLNejTmMyJZ0iDuTI/eK/hiWBRfnKYEFrweY2cZ
 vQvwJeWU15Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,438,1589266800"; 
   d="scan'208";a="306768478"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga002.jf.intel.com with ESMTP; 05 Aug 2020 10:07:35 -0700
Date:   Wed, 5 Aug 2020 10:07:17 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     hpa@zytor.com, Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
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
Subject: Re: [PATCH v2] x86/cpu: Use SERIALIZE in sync_core() when available
Message-ID: <20200805170717.GB26661@ranerica-svr.sc.intel.com>
References: <20200805021059.1331-1-ricardo.neri-calderon@linux.intel.com>
 <20200805044840.GA9127@nazgul.tnic>
 <47A60E6A-0742-45FB-B707-175E87C58184@zytor.com>
 <20200805050808.GC9127@nazgul.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805050808.GC9127@nazgul.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Aug 05, 2020 at 07:08:08AM +0200, Borislav Petkov wrote:
> On Tue, Aug 04, 2020 at 09:58:25PM -0700, hpa@zytor.com wrote:
> > Because why use an alternative to jump over one instruction?
> >
> > I personally would prefer to have the IRET put out of line
> 
> Can't yet - SERIALIZE CPUs are a minority at the moment.
> 
> > and have the call/jmp replaced by SERIALIZE inline.
> 
> Well, we could do:
> 
> 	alternative_io("... IRET bunch", __ASM_SERIALIZE, X86_FEATURE_SERIALIZE, ...);
> 
> and avoid all kinds of jumping. Alternatives get padded so there
> would be a couple of NOPs following when SERIALIZE gets patched in
> but it shouldn't be a problem. I guess one needs to look at what gcc
> generates...

But the IRET-TO-SELF code has instruction which modify the stack. This
would violate stack invariance in alternatives as enforced in commit
7117f16bf460 ("objtool: Fix ORC vs alternatives"). As a result, objtool
gives warnings as follows:

arch/x86/kernel/alternative.o: warning: objtool: do_sync_core()+0xe:
alternative modifies stack

Perhaps in this specific case it does not matter as the changes in the
stack will be undone by IRET. However, using alternative_io would require
adding the macro STACK_FRAME_NON_STANDARD to functions using sync_core().
IMHO, it wouldn't look good.

So maybe the best approach is to implement as you suggested using
static_cpu_has()?

Thanks and BR,
Ricardo
