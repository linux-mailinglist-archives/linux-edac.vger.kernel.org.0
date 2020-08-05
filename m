Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667E523D2CB
	for <lists+linux-edac@lfdr.de>; Wed,  5 Aug 2020 22:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbgHEUQH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 5 Aug 2020 16:16:07 -0400
Received: from mga01.intel.com ([192.55.52.88]:28979 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbgHEQUC (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 5 Aug 2020 12:20:02 -0400
IronPort-SDR: wVshM2Ol8Vg2U9I+dHLAeFm9G/HFVvD1ZkTsOUbuZLQdrcZPLL+c6jZHni6i4ePsNCz0ph8ArI
 bE9jUSBeysbQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="170650160"
X-IronPort-AV: E=Sophos;i="5.75,438,1589266800"; 
   d="scan'208";a="170650160"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 08:54:19 -0700
IronPort-SDR: Q7NbfeMyv4NMG/aVS6MzmzUFxfTUeW1A1Ya3OMdA+P+MVudymtl3L8OesjU8hFmvyyKJbVYVYL
 H3C1asV0McGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,438,1589266800"; 
   d="scan'208";a="292981672"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga006.jf.intel.com with ESMTP; 05 Aug 2020 08:54:19 -0700
Date:   Wed, 5 Aug 2020 08:54:01 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Borislav Petkov <bp@suse.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Cathy Zhang <cathy.zhang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kyung Min Park <kyung.min.park@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH v2] x86/cpu: Use SERIALIZE in sync_core() when available
Message-ID: <20200805155401.GB25981@ranerica-svr.sc.intel.com>
References: <20200805021059.1331-1-ricardo.neri-calderon@linux.intel.com>
 <20200805044840.GA9127@nazgul.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805044840.GA9127@nazgul.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Aug 05, 2020 at 06:48:40AM +0200, Borislav Petkov wrote:
> On Tue, Aug 04, 2020 at 07:10:59PM -0700, Ricardo Neri wrote:
> > The SERIALIZE instruction gives software a way to force the processor to
> > complete all modifications to flags, registers and memory from previous
> > instructions and drain all buffered writes to memory before the next
> > instruction is fetched and executed. Thus, it serves the purpose of
> > sync_core(). Use it when available.
> > 
> > Commit 7117f16bf460 ("objtool: Fix ORC vs alternatives") enforced stack
> > invariance in alternatives. The iret-to-self does not comply with such
> > invariance. Thus, it cannot be used inside alternative code. Instead, use
> > an alternative that jumps to SERIALIZE when available.
> > 
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Cathy Zhang <cathy.zhang@intel.com>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: Fenghua Yu <fenghua.yu@intel.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Kyung Min Park <kyung.min.park@intel.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> > Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> > Cc: linux-edac@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Suggested-by: Andy Lutomirski <luto@kernel.org>
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> > This is a v2 from my initial submission [1]. The first three patches of
> > the series have been merged in Linus' tree. Hence, I am submitting only
> > this patch for review.
> > 
> > [1]. https://lkml.org/lkml/2020/7/27/8
> > 
> > Changes since v1:
> >  * Support SERIALIZE using alternative runtime patching.
> >    (Peter Zijlstra, H. Peter Anvin)
> >  * Added a note to specify which version of binutils supports SERIALIZE.
> >    (Peter Zijlstra)
> >  * Verified that (::: "memory") is used. (H. Peter Anvin)
> > ---
> >  arch/x86/include/asm/special_insns.h |  2 ++
> >  arch/x86/include/asm/sync_core.h     | 10 +++++++++-
> >  2 files changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
> > index 59a3e13204c3..25cd67801dda 100644
> > --- a/arch/x86/include/asm/special_insns.h
> > +++ b/arch/x86/include/asm/special_insns.h
> > @@ -10,6 +10,8 @@
> >  #include <linux/irqflags.h>
> >  #include <linux/jump_label.h>
> >  
> > +/* Instruction opcode for SERIALIZE; supported in binutils >= 2.35. */
> > +#define __ASM_SERIALIZE ".byte 0xf, 0x1, 0xe8"
> >  /*
> >   * Volatile isn't enough to prevent the compiler from reordering the
> >   * read/write functions for the control registers and messing everything up.
> > diff --git a/arch/x86/include/asm/sync_core.h b/arch/x86/include/asm/sync_core.h
> > index fdb5b356e59b..201ea3d9a6bd 100644
> > --- a/arch/x86/include/asm/sync_core.h
> > +++ b/arch/x86/include/asm/sync_core.h
> > @@ -5,15 +5,19 @@
> >  #include <linux/preempt.h>
> >  #include <asm/processor.h>
> >  #include <asm/cpufeature.h>
> > +#include <asm/special_insns.h>
> >  
> >  #ifdef CONFIG_X86_32
> >  static inline void iret_to_self(void)
> >  {
> >  	asm volatile (
> > +		ALTERNATIVE("", "jmp 2f", X86_FEATURE_SERIALIZE)
> >  		"pushfl\n\t"
> >  		"pushl %%cs\n\t"
> >  		"pushl $1f\n\t"
> >  		"iret\n\t"
> > +		"2:\n\t"
> > +		__ASM_SERIALIZE "\n"
> >  		"1:"
> >  		: ASM_CALL_CONSTRAINT : : "memory");
> >  }
> > @@ -23,6 +27,7 @@ static inline void iret_to_self(void)
> >  	unsigned int tmp;
> >  
> >  	asm volatile (
> > +		ALTERNATIVE("", "jmp 2f", X86_FEATURE_SERIALIZE)
> 
> Why is this and above stuck inside the asm statement?
> 
> Why can't you simply do:
> 
> 	if (static_cpu_has(X86_FEATURE_SERIALIZE)) {
> 		asm volatile(__ASM_SERIALIZE ::: "memory");
> 		return;
> 	}
> 
> on function entry instead of making it more unreadable for no particular
> reason?

My my first submission I had implemented it as you describe. The only
difference was that I used boot_cpu_has() instead of static_cpu_has()
as the latter has a comment stating that:
	"Use static_cpu_has() only in fast paths (...) boot_cpu_has() is
	 already fast enough for the majority of cases..."

sync_core_before_usermode() already handles what I think are the
critical paths.

Thanks and BR,
Ricardo
