Return-Path: <linux-edac+bounces-3152-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E696DA3BBC9
	for <lists+linux-edac@lfdr.de>; Wed, 19 Feb 2025 11:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3DD41772DF
	for <lists+linux-edac@lfdr.de>; Wed, 19 Feb 2025 10:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C731DE2D7;
	Wed, 19 Feb 2025 10:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZZJ2z1F6"
X-Original-To: linux-edac@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D734A1ACED2;
	Wed, 19 Feb 2025 10:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739961665; cv=none; b=eftCG/mJMaVZwH+0VbKp4womcMTg3+sQOhiibS7EdSyfJ5Bf/d/uoCbRBCt8syZmcdEQm13lFiA8zwJE5yhtRloAjfc8jgd59a/fckWwYQztvyBfdykIN807u9Q7sCjjlJ6wTg5wdJHnesXE6+OIWkLf64zM2d/djdYMp1UvP1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739961665; c=relaxed/simple;
	bh=1ZifGDt6ZsCQyZDMlCaNaOvYPhCX16g7i+WBuMry1HM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4teib9Y7jG91hF5T5pGdevT+Ef2U/OubM5/uvnISRZNhr8tanezHRGShVg9lafaeu5yUVfeV3TZjUoqiWFVkVBqPsvvDHM6yfAwEtG1T0VhgtRGzlTx0yBz/ia5vdiWC7ceCEqqiScGQAaV8Orb1Ss9cAvnhi2ivjRQpiF3lHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZZJ2z1F6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3G6kUYCeF3vQA0srZDA8CCP/Hwqz0yhm4jKVJ6oazFg=; b=ZZJ2z1F676sZRKBnsd2zd+5eNa
	W7JGCVMwwTsxjM8oX9qzYCwG02vZ70AgwhgZtTFjVKjO2XvAaXBZHMToy7XFCMVlJIwdnLdxAnQ/z
	55qm8Cd41GYNVm3OzFFPz9itzjIUgvZSjYEzXWld5ZDxMmojS9uTLyQdjT0qMC5TBEidMTVn2+7dd
	5JhhufeQdigioyM77qdRhzoLJMGDLkDHT53t1Wnl86mpJItw9yW53Dp471njAcr3Y6OaF6cWbpc1o
	syQdV6vWDR7HvAIfBJVeg4TkthkHP6S2rqM8EmGmTrIcAJGzXts4W548AYOTAL0bgTWn+rxYaRg2U
	1IfeEkpw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tkhVO-00000005kiw-2Fle;
	Wed, 19 Feb 2025 10:40:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8EC60300783; Wed, 19 Feb 2025 11:40:37 +0100 (CET)
Date: Wed, 19 Feb 2025 11:40:37 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>, tony.luck@intel.com,
	nao.horiguchi@gmail.com, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	linmiaohe@huawei.com, akpm@linux-foundation.org,
	jpoimboe@kernel.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	baolin.wang@linux.alibaba.com, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v2 3/5] x86/mce: add EX_TYPE_EFAULT_REG as in-kernel
 recovery context to fix copy-from-user operations regression
Message-ID: <20250219104037.GG40464@noisy.programming.kicks-ass.net>
References: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
 <20250217063335.22257-4-xueshuai@linux.alibaba.com>
 <20250218125408.GD40464@noisy.programming.kicks-ass.net>
 <1ff716d3-eb3d-477e-ae30-1abe97eee01b@linux.alibaba.com>
 <20250218141535.GC34567@noisy.programming.kicks-ass.net>
 <20250218164800.GNZ7S5wL1A4dTaySOP@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218164800.GNZ7S5wL1A4dTaySOP@fat_crate.local>

On Tue, Feb 18, 2025 at 05:48:00PM +0100, Borislav Petkov wrote:
> On Tue, Feb 18, 2025 at 03:15:35PM +0100, Peter Zijlstra wrote:
> > diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
> > index dac4d64dfb2a..cfdae25eacd7 100644
> > --- a/arch/x86/kernel/cpu/mce/severity.c
> > +++ b/arch/x86/kernel/cpu/mce/severity.c
> > @@ -301,18 +301,19 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
> >  	instrumentation_end();
> >  
> >  	switch (fixup_type) {
> > -	case EX_TYPE_UACCESS:
> > -		if (!copy_user)
> > -			return IN_KERNEL;
> > -		m->kflags |= MCE_IN_KERNEL_COPYIN;
> > -		fallthrough;
> > -
> >  	case EX_TYPE_FAULT_MCE_SAFE:
> >  	case EX_TYPE_DEFAULT_MCE_SAFE:
> >  		m->kflags |= MCE_IN_KERNEL_RECOV;
> >  		return IN_KERNEL_RECOV;
> >  
> >  	default:
> > +		if (copy_user) {
> 
> As said on chat, if we can make is_copy_from_user() *always* correctly detect
> user access, then sure but I'm afraid EX_TYPE_UACCESS being generated at the
> handful places where we do user memory access is there for a reason as it
> makes it pretty explicit.

Thing is, we have copy routines that do not know if its user or not.
is_copy_from_user() must be reliable.

Anyway, if you all really want to go all funny, try the below.

Someone has to go and stick some EX_FLAG_USER on things, but I just
really don't believe that's doing to be useful. Because while you're
doing that, you should also audit if is_copy_from_user() will catch it
and if it does, you don't need the tag.

See how much tags you end up with..


---
diff --git a/arch/x86/include/asm/extable_fixup_types.h b/arch/x86/include/asm/extable_fixup_types.h
index 906b0d5541e8..1d6c6ff51d28 100644
--- a/arch/x86/include/asm/extable_fixup_types.h
+++ b/arch/x86/include/asm/extable_fixup_types.h
@@ -31,6 +31,9 @@
 #define EX_FLAG_CLEAR_DX		EX_DATA_FLAG(2)
 #define EX_FLAG_CLEAR_AX_DX		EX_DATA_FLAG(3)
 
+#define EX_FLAG_USER			EX_DATA_FLAG(4)
+#define EX_FLAG_MCE			EX_DATA_FLAG(8)
+
 /* types */
 #define	EX_TYPE_NONE			 0
 #define	EX_TYPE_DEFAULT			 1
@@ -46,8 +49,6 @@
 #define	EX_TYPE_RDMSR_SAFE		11 /* reg := -EIO */
 #define	EX_TYPE_WRMSR_IN_MCE		12
 #define	EX_TYPE_RDMSR_IN_MCE		13
-#define	EX_TYPE_DEFAULT_MCE_SAFE	14
-#define	EX_TYPE_FAULT_MCE_SAFE		15
 
 #define	EX_TYPE_POP_REG			16 /* sp += sizeof(long) */
 #define EX_TYPE_POP_ZERO		(EX_TYPE_POP_REG | EX_DATA_IMM(0))
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index dac4d64dfb2a..86a32fa020d2 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -300,21 +300,20 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
 	copy_user  = is_copy_from_user(regs);
 	instrumentation_end();
 
-	switch (fixup_type) {
-	case EX_TYPE_UACCESS:
-		if (!copy_user)
-			return IN_KERNEL;
-		m->kflags |= MCE_IN_KERNEL_COPYIN;
-		fallthrough;
-
-	case EX_TYPE_FAULT_MCE_SAFE:
-	case EX_TYPE_DEFAULT_MCE_SAFE:
+	if (fixup_type == EX_TYPE_NONE)
+		return IN_KERNEL;
+
+	if (fixup_type & EX_FLAG_MCE) {
 		m->kflags |= MCE_IN_KERNEL_RECOV;
 		return IN_KERNEL_RECOV;
+	}
 
-	default:
-		return IN_KERNEL;
+	if ((fixup_type & EX_FLAG_USER) || copy_user) {
+		m->kflags |= MCE_IN_KERNEL_COPYIN | MCE_IN_KERNEL_RECOV;
+		return IN_KERNEL_RECOV;
 	}
+
+	return IN_KERNEL;
 }
 
 /* See AMD PPR(s) section Machine Check Error Handling. */
diff --git a/arch/x86/kernel/fpu/legacy.h b/arch/x86/kernel/fpu/legacy.h
index 098f367bb8a7..3f6036840d65 100644
--- a/arch/x86/kernel/fpu/legacy.h
+++ b/arch/x86/kernel/fpu/legacy.h
@@ -24,7 +24,7 @@ static inline void ldmxcsr(u32 mxcsr)
 	asm volatile(ASM_STAC "\n"					\
 		     "1: " #insn "\n"					\
 		     "2: " ASM_CLAC "\n"				\
-		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_FAULT_MCE_SAFE)	\
+		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_FAULT | EX_FLAG_MCE)	\
 		     : [err] "=a" (err), output				\
 		     : "0"(0), input);					\
 	err;								\
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index aa16f1a1bbcf..eef534091105 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -115,7 +115,7 @@ static inline int update_pkru_in_sigframe(struct xregs_state __user *buf, u64 ma
 	asm volatile("1:" op "\n\t"					\
 		     "xor %[err], %[err]\n"				\
 		     "2:\n\t"						\
-		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_FAULT_MCE_SAFE)	\
+		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_FAULT | EX_FLAG_MCE)	\
 		     : [err] "=a" (err)					\
 		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
 		     : "memory")
diff --git a/arch/x86/lib/copy_mc_64.S b/arch/x86/lib/copy_mc_64.S
index c859a8a09860..7977689ad46e 100644
--- a/arch/x86/lib/copy_mc_64.S
+++ b/arch/x86/lib/copy_mc_64.S
@@ -103,9 +103,9 @@ SYM_FUNC_START(copy_mc_fragile)
 	movl	%ecx, %edx
 	jmp copy_mc_fragile_handle_tail
 
-	_ASM_EXTABLE_TYPE(.L_read_leading_bytes, .E_leading_bytes, EX_TYPE_DEFAULT_MCE_SAFE)
-	_ASM_EXTABLE_TYPE(.L_read_words, .E_read_words, EX_TYPE_DEFAULT_MCE_SAFE)
-	_ASM_EXTABLE_TYPE(.L_read_trailing_bytes, .E_trailing_bytes, EX_TYPE_DEFAULT_MCE_SAFE)
+	_ASM_EXTABLE_TYPE(.L_read_leading_bytes, .E_leading_bytes, EX_TYPE_DEFAULT | EX_FLAG_MCE)
+	_ASM_EXTABLE_TYPE(.L_read_words, .E_read_words, EX_TYPE_DEFAULT | EX_FLAG_MCE)
+	_ASM_EXTABLE_TYPE(.L_read_trailing_bytes, .E_trailing_bytes, EX_TYPE_DEFAULT | EX_FLAG_MCE)
 	_ASM_EXTABLE(.L_write_leading_bytes, .E_leading_bytes)
 	_ASM_EXTABLE(.L_write_words, .E_write_words)
 	_ASM_EXTABLE(.L_write_trailing_bytes, .E_trailing_bytes)
@@ -143,7 +143,7 @@ SYM_FUNC_START(copy_mc_enhanced_fast_string)
 	movq %rcx, %rax
 	RET
 
-	_ASM_EXTABLE_TYPE(.L_copy, .E_copy, EX_TYPE_DEFAULT_MCE_SAFE)
+	_ASM_EXTABLE_TYPE(.L_copy, .E_copy, EX_TYPE_DEFAULT | EX_FLAG_MCE)
 
 SYM_FUNC_END(copy_mc_enhanced_fast_string)
 #endif /* !CONFIG_UML */
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index 51986e8a9d35..7358bf10baba 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -293,8 +293,10 @@ static bool ex_handler_eretu(const struct exception_table_entry *fixup,
 int ex_get_fixup_type(unsigned long ip)
 {
 	const struct exception_table_entry *e = search_exception_tables(ip);
+	if (!e)
+		return EX_TYPE_NONE;
 
-	return e ? FIELD_GET(EX_DATA_TYPE_MASK, e->data) : EX_TYPE_NONE;
+	return FIELD_GET(EX_DATA_TYPE_MASK, e->data) | (e->data & (EX_FLAG_USER | EX_FLAG_MCE));
 }
 
 int fixup_exception(struct pt_regs *regs, int trapnr, unsigned long error_code,
@@ -327,10 +329,8 @@ int fixup_exception(struct pt_regs *regs, int trapnr, unsigned long error_code,
 
 	switch (type) {
 	case EX_TYPE_DEFAULT:
-	case EX_TYPE_DEFAULT_MCE_SAFE:
 		return ex_handler_default(e, regs);
 	case EX_TYPE_FAULT:
-	case EX_TYPE_FAULT_MCE_SAFE:
 		return ex_handler_fault(e, regs, trapnr);
 	case EX_TYPE_UACCESS:
 		return ex_handler_uaccess(e, regs, trapnr, fault_addr);

