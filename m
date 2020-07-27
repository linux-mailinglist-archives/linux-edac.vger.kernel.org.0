Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA7C22ED55
	for <lists+linux-edac@lfdr.de>; Mon, 27 Jul 2020 15:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgG0Nae (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Jul 2020 09:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgG0Nad (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 27 Jul 2020 09:30:33 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B10C061794;
        Mon, 27 Jul 2020 06:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kyc3BfjwesjA1ByfvEc2/LYx9mR5ZObBawwL9fp0vYM=; b=axc+fmSPwCejjbt6xZSmADYBU5
        piPxmkw1iKcFVUI7Sce/EVLU0OwkxXn0yrdjxSILF7qwkLv6pp4e9l04CX1N2CKOjKYBFc1/vCnXJ
        o0tnjxmUtj7OawPZEfjOZYAmsmfU7aXIteVGGwGSEesu1esWjbF9czKK7WsOebq5xbbou2Eal+b+K
        B7+ULeiN+KpqCynpiQtv5vI6WNcE1yl7ds0HHvp8w4trerRp/h5baaWCQKbrQejZBdjpb6pipWiiO
        dUVGpZgJeoaw6n/VGBBOGKmj72uW7T6lJm3O/sT1vT1R1rScZbEcs86+AU6wirdzHTkIiWpX/yAvl
        5u01TQEA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k03Cx-0005B4-1L; Mon, 27 Jul 2020 13:30:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0980230018A;
        Mon, 27 Jul 2020 15:30:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DDFED29DBEB19; Mon, 27 Jul 2020 15:30:20 +0200 (CEST)
Date:   Mon, 27 Jul 2020 15:30:20 +0200
From:   peterz@infradead.org
To:     hpa@zytor.com
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <20200727133020.GN119549@hirez.programming.kicks-ass.net>
References: <20200727043132.15082-1-ricardo.neri-calderon@linux.intel.com>
 <20200727043132.15082-5-ricardo.neri-calderon@linux.intel.com>
 <D51F2DC3-3C56-44E6-A1F2-434E7D27133C@zytor.com>
 <20200727083619.GF119549@hirez.programming.kicks-ass.net>
 <49251CFA-8AC3-462D-A60F-0337593BE9CD@zytor.com>
 <20200727130536.GM119549@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727130536.GM119549@hirez.programming.kicks-ass.net>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jul 27, 2020 at 03:05:36PM +0200, peterz@infradead.org wrote:
> Yeah, I'm not sure.. the 'funny' thing is that typically call
> sync_core() from an IPI anyway. And the synchronous broadcast IPI is by
> far the most expensive part of that.
> 
> Something like this...
> 
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 20e07feb4064..528e049ee1d9 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -989,12 +989,13 @@ void *text_poke_kgdb(void *addr, const void *opcode, size_t len)
>  
>  static void do_sync_core(void *info)
>  {
> -	sync_core();
> +	/* IRET implies sync_core() */
>  }
>  
>  void text_poke_sync(void)
>  {
>  	on_each_cpu(do_sync_core, NULL, 1);
> +	sync_core();
>  }
>  
>  struct text_poke_loc {

So 'people' have wanted to optimize this for NOHZ_FULL and I suppose
virt as well.

IFF VMENTER is serializing, I suppose we can simply do something like:

bool text_poke_cond(int cpu, void *info)
{
	/*
	 * If we observe the vCPU is preempted, it will do VMENTER
	 * no point in sending an IPI to SERIALIZE.
	 */
	return !vcpu_is_preempted(cpu);
}

void text_poke_sync(void)
{
	smp_call_function_many_cond(cpu_possible_mask,
				    do_sync_core, NULL, 1, text_poke_cond);
	sync_core();
}

The 'same' for NOHZ_FULL, except we need to cmpxchg a value such that
if the cmpxchg() succeeds we know the CPU is in userspace and will
SERIALIZE on the next entry. Much like kvm_flush_tlb_others().


Anyway, that's all hand-wavey.. I'll let someone that cares about those
things write actual patches :-)
