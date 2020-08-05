Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832E123C4C4
	for <lists+linux-edac@lfdr.de>; Wed,  5 Aug 2020 06:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbgHEEtO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 5 Aug 2020 00:49:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:52796 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgHEEtN (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 5 Aug 2020 00:49:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9EF0AAAC7;
        Wed,  5 Aug 2020 04:49:27 +0000 (UTC)
Date:   Wed, 5 Aug 2020 06:48:40 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
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
Message-ID: <20200805044840.GA9127@nazgul.tnic>
References: <20200805021059.1331-1-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200805021059.1331-1-ricardo.neri-calderon@linux.intel.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Aug 04, 2020 at 07:10:59PM -0700, Ricardo Neri wrote:
> The SERIALIZE instruction gives software a way to force the processor to
> complete all modifications to flags, registers and memory from previous
> instructions and drain all buffered writes to memory before the next
> instruction is fetched and executed. Thus, it serves the purpose of
> sync_core(). Use it when available.
> 
> Commit 7117f16bf460 ("objtool: Fix ORC vs alternatives") enforced stack
> invariance in alternatives. The iret-to-self does not comply with such
> invariance. Thus, it cannot be used inside alternative code. Instead, use
> an alternative that jumps to SERIALIZE when available.
> 
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Cathy Zhang <cathy.zhang@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Kyung Min Park <kyung.min.park@intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> Cc: linux-edac@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> This is a v2 from my initial submission [1]. The first three patches of
> the series have been merged in Linus' tree. Hence, I am submitting only
> this patch for review.
> 
> [1]. https://lkml.org/lkml/2020/7/27/8
> 
> Changes since v1:
>  * Support SERIALIZE using alternative runtime patching.
>    (Peter Zijlstra, H. Peter Anvin)
>  * Added a note to specify which version of binutils supports SERIALIZE.
>    (Peter Zijlstra)
>  * Verified that (::: "memory") is used. (H. Peter Anvin)
> ---
>  arch/x86/include/asm/special_insns.h |  2 ++
>  arch/x86/include/asm/sync_core.h     | 10 +++++++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
> index 59a3e13204c3..25cd67801dda 100644
> --- a/arch/x86/include/asm/special_insns.h
> +++ b/arch/x86/include/asm/special_insns.h
> @@ -10,6 +10,8 @@
>  #include <linux/irqflags.h>
>  #include <linux/jump_label.h>
>  
> +/* Instruction opcode for SERIALIZE; supported in binutils >= 2.35. */
> +#define __ASM_SERIALIZE ".byte 0xf, 0x1, 0xe8"
>  /*
>   * Volatile isn't enough to prevent the compiler from reordering the
>   * read/write functions for the control registers and messing everything up.
> diff --git a/arch/x86/include/asm/sync_core.h b/arch/x86/include/asm/sync_core.h
> index fdb5b356e59b..201ea3d9a6bd 100644
> --- a/arch/x86/include/asm/sync_core.h
> +++ b/arch/x86/include/asm/sync_core.h
> @@ -5,15 +5,19 @@
>  #include <linux/preempt.h>
>  #include <asm/processor.h>
>  #include <asm/cpufeature.h>
> +#include <asm/special_insns.h>
>  
>  #ifdef CONFIG_X86_32
>  static inline void iret_to_self(void)
>  {
>  	asm volatile (
> +		ALTERNATIVE("", "jmp 2f", X86_FEATURE_SERIALIZE)
>  		"pushfl\n\t"
>  		"pushl %%cs\n\t"
>  		"pushl $1f\n\t"
>  		"iret\n\t"
> +		"2:\n\t"
> +		__ASM_SERIALIZE "\n"
>  		"1:"
>  		: ASM_CALL_CONSTRAINT : : "memory");
>  }
> @@ -23,6 +27,7 @@ static inline void iret_to_self(void)
>  	unsigned int tmp;
>  
>  	asm volatile (
> +		ALTERNATIVE("", "jmp 2f", X86_FEATURE_SERIALIZE)

Why is this and above stuck inside the asm statement?

Why can't you simply do:

	if (static_cpu_has(X86_FEATURE_SERIALIZE)) {
		asm volatile(__ASM_SERIALIZE ::: "memory");
		return;
	}

on function entry instead of making it more unreadable for no particular
reason?

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Mary Higgins, Sri Rasiah, HRB 21284 (AG Nürnberg)
-- 
