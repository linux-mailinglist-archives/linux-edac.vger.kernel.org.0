Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4C82300D5
	for <lists+linux-edac@lfdr.de>; Tue, 28 Jul 2020 06:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgG1Eld (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 28 Jul 2020 00:41:33 -0400
Received: from mga05.intel.com ([192.55.52.43]:11458 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbgG1Elc (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 28 Jul 2020 00:41:32 -0400
IronPort-SDR: cMAjMP4N03WsfwYZUHcn848+uzhZA90M6Zo8J6njIlxHVKeDxM7H4thKMZwqYb4Z2sYaUrNSgV
 76ezdDCumaxw==
X-IronPort-AV: E=McAfee;i="6000,8403,9695"; a="236011911"
X-IronPort-AV: E=Sophos;i="5.75,405,1589266800"; 
   d="scan'208";a="236011911"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2020 21:41:32 -0700
IronPort-SDR: PH25oO8DGEUs2cptBJuid8luFpeBSFdSgvpVTKQZyv+xjrjfWW2JzRmpvHYWmYDPiU/6sOPwd3
 81JotbjpxOiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,405,1589266800"; 
   d="scan'208";a="273458071"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 27 Jul 2020 21:41:32 -0700
Date:   Mon, 27 Jul 2020 21:41:14 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     peterz@infradead.org
Cc:     hpa@zytor.com, Thomas Gleixner <tglx@linutronix.de>,
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
        linux-edac@vger.kernel.org, frederic@kernel.org
Subject: Re: [PATCH 4/4] x86/cpu: Use SERIALIZE in sync_core() when available
Message-ID: <20200728044114.GA24129@ranerica-svr.sc.intel.com>
References: <20200727043132.15082-1-ricardo.neri-calderon@linux.intel.com>
 <20200727043132.15082-5-ricardo.neri-calderon@linux.intel.com>
 <D51F2DC3-3C56-44E6-A1F2-434E7D27133C@zytor.com>
 <20200727083619.GF119549@hirez.programming.kicks-ass.net>
 <49251CFA-8AC3-462D-A60F-0337593BE9CD@zytor.com>
 <20200727130536.GM119549@hirez.programming.kicks-ass.net>
 <20200727133020.GN119549@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727133020.GN119549@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jul 27, 2020 at 03:30:20PM +0200, peterz@infradead.org wrote:
> On Mon, Jul 27, 2020 at 03:05:36PM +0200, peterz@infradead.org wrote:
> > Yeah, I'm not sure.. the 'funny' thing is that typically call
> > sync_core() from an IPI anyway. And the synchronous broadcast IPI is by
> > far the most expensive part of that.
> > 
> > Something like this...
> > 
> > diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> > index 20e07feb4064..528e049ee1d9 100644
> > --- a/arch/x86/kernel/alternative.c
> > +++ b/arch/x86/kernel/alternative.c
> > @@ -989,12 +989,13 @@ void *text_poke_kgdb(void *addr, const void *opcode, size_t len)
> >  
> >  static void do_sync_core(void *info)
> >  {
> > -	sync_core();
> > +	/* IRET implies sync_core() */
> >  }
> >  
> >  void text_poke_sync(void)
> >  {
> >  	on_each_cpu(do_sync_core, NULL, 1);
> > +	sync_core();
> >  }
> >  
> >  struct text_poke_loc {
> 
> So 'people' have wanted to optimize this for NOHZ_FULL and I suppose
> virt as well.
> 
> IFF VMENTER is serializing, I suppose we can simply do something like:
> 
> bool text_poke_cond(int cpu, void *info)
> {
> 	/*
> 	 * If we observe the vCPU is preempted, it will do VMENTER
> 	 * no point in sending an IPI to SERIALIZE.
> 	 */
> 	return !vcpu_is_preempted(cpu);
> }
> 
> void text_poke_sync(void)
> {
> 	smp_call_function_many_cond(cpu_possible_mask,
> 				    do_sync_core, NULL, 1, text_poke_cond);
> 	sync_core();
> }
> 
> The 'same' for NOHZ_FULL, except we need to cmpxchg a value such that
> if the cmpxchg() succeeds we know the CPU is in userspace and will
> SERIALIZE on the next entry. Much like kvm_flush_tlb_others().
> 
> 
> Anyway, that's all hand-wavey.. I'll let someone that cares about those
> things write actual patches :-)

I think I got a little lost here. If I understand correctly, there are
two alternatives to implement support for serialize better:

  a) alternative(IRET_TO_SELF, SERIALIZE, X86_FEATURE_SERIALIZE); or
  b) asm volatile("1:.byte 0xf, 0x1, 0xe8;2:" _ASM_EXTABLE(1b:2b)

a) would be the traditional and simpler solution. b) would rely on
causing an #UD and getting an IRET on existing hardware b) would need some
more optimization work when handling the exception and a few reworks on
the poke patching code.

Which option should I focus on? Which option would be more desirable/better?

Thanks and BR,
Ricardo
