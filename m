Return-Path: <linux-edac+bounces-3908-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1B4AB6DE3
	for <lists+linux-edac@lfdr.de>; Wed, 14 May 2025 16:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93FD286000C
	for <lists+linux-edac@lfdr.de>; Wed, 14 May 2025 14:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B30D1537A7;
	Wed, 14 May 2025 14:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b9dQZtUd"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B947F79DA
	for <linux-edac@vger.kernel.org>; Wed, 14 May 2025 14:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747232151; cv=none; b=OS6eztlWiOylITO7rmHJ8OS/VbAlESd3xdX9VbXP5VVydYHF5kcF1cQa0JInNpmxYwfLhrWn7cyAwnJ3XKKJV8HyOYZ2Ctz6swGQtu+7UUxFJtyyMdUrHOVHmH6iGT1P/u/zVnDxI4m+a3Cqd0MJgP4HnGLtKMGRxgHGVvos2WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747232151; c=relaxed/simple;
	bh=Vni+4rSFtgKkhj4M9hes19xnkZVVVh6560vIbrsuwcs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XjfqMeTZYG+b0MWNsfYI2UAFbs8aXEfk+uqwG3nemv8I5fOYbjNCK4N6QFATUUSMe1C5NVeS9RnOK9GY9FznPsAY4X1cqojvae7JRuFPavru0Kjq5UbrQurxCpBf+PzfRQD2nn0S9yVtNwefKHaKTEqkoIUJRY0ovAwWZFDNT3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b9dQZtUd; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22e6c82716dso8707975ad.0
        for <linux-edac@vger.kernel.org>; Wed, 14 May 2025 07:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747232149; x=1747836949; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t7ibtTN1MnsJc6E1eBxUxx8I+Mw5Swe/fTJWwFyUmjo=;
        b=b9dQZtUdVp761zGXUN1GOvgKa6cUUwdVurdewUUUiRSa2084aZ8YRXSnFRhlEZEAYs
         e3Y/B3kHN2Z9CUhtxiDCYY7TQENsrAgzWB2UsixUjkwtvrxSa9kOxEA/kxm17FzTF3Kd
         MnIBqJnd2AuRHOQ3VCYIVOzkgjT/ueiquMoM9iQGrXhUMYRb35veN5k8smQyApM0kL4Q
         66UUIuCOzuFIBcf/RhIBY56JehE6RArmn8nHwTPxcR4out09W/p78FNgpK6pKsWtatl7
         qjZp9iH/6ffDh72kjOLGO/bERGnuha1nLlSv5pykERnb3AXSUIEMh2FSUAEbwutkUKSw
         786Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747232149; x=1747836949;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t7ibtTN1MnsJc6E1eBxUxx8I+Mw5Swe/fTJWwFyUmjo=;
        b=diMwh6BpBS8dbNgm2iJv/WVqmu94dNyiFd8uyCiBwPqgrwVqicXCztD2TwYRN/qyfp
         4j7vWu1g9Oh06IG9HLLr5qS2JKOVaf8BijIgSnFgqgmHwbx6b7AmoR7hYsWha3ttZJEG
         58v7dTt/GnWpIbuuuSXxrga1P84R9XdVE8eTihnfPnsEtR53yDH0By7Wx/CdLzQZ8A6l
         0+u7TTIsCcseYZXvwXsBYRD6aT11K1L4T3V1A8lN2u139gUQ/ELcR4s/ROf/hpgeTnzV
         L+Af7ydDknvGHaHL4BFJ80rr9wAOEWyd20snWTqFczgrpzgh2Ha8qn26p/ct1JGp3tg4
         pw2g==
X-Forwarded-Encrypted: i=1; AJvYcCUjlsEL0tUlq+xHxunjUt1l3+sb4C7fB7NYppvMRCpU8+FCONrRV8cE1RSC8WOS+95ZnflDvLnto0wY@vger.kernel.org
X-Gm-Message-State: AOJu0YzP9nymKieNZHQzqRjuSnaueBEr9OxGvH1W4F/PfIRhzGTs2wMa
	4VrZVRafACCfJL31FoxnD6P0y82ofBPP/uw6Y7e0LAjX5I79xGeS4fSYzNS+93C02OMUhS7QltI
	lng==
X-Google-Smtp-Source: AGHT+IF9L3gdmcUnBmViiAIB+CbEBP/3GNzYJ74W69/RQCJXO9WEtDuMKsjbGgOXh1LtWeoxFLt4egw1KwI=
X-Received: from plbmb16.prod.google.com ([2002:a17:903:990:b0:223:4788:2e83])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a4e:b0:22e:50f2:1450
 with SMTP id d9443c01a7336-23197fc77f2mr53990535ad.22.1747232149047; Wed, 14
 May 2025 07:15:49 -0700 (PDT)
Date: Wed, 14 May 2025 07:15:42 -0700
In-Reply-To: <20250513203803.2636561-2-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250513203803.2636561-1-sohil.mehta@intel.com> <20250513203803.2636561-2-sohil.mehta@intel.com>
Message-ID: <aCSljsvI0A-HC_DT@google.com>
Subject: Re: [PATCH v6 1/9] x86/fred, KVM: VMX: Pass event data to the FRED
 entry point from KVM
From: Sean Christopherson <seanjc@google.com>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, Xin Li <xin@zytor.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Tony Luck <tony.luck@intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Andi Kleen <ak@linux.intel.com>, Kai Huang <kai.huang@intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-edac@vger.kernel.org, kvm@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, May 13, 2025, Sohil Mehta wrote:
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 5c5766467a61..1d43d4a2f6b6 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7079,7 +7079,7 @@ static void handle_external_interrupt_irqoff(struct kvm_vcpu *vcpu,
>  
>  	kvm_before_interrupt(vcpu, KVM_HANDLING_IRQ);
>  	if (cpu_feature_enabled(X86_FEATURE_FRED))
> -		fred_entry_from_kvm(EVENT_TYPE_EXTINT, vector);
> +		fred_entry_from_kvm(EVENT_TYPE_EXTINT, vector, 0);
>  	else
>  		vmx_do_interrupt_irqoff(gate_offset((gate_desc *)host_idt_base + vector));
>  	kvm_after_interrupt(vcpu);
> @@ -7393,7 +7393,8 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
>  	    is_nmi(vmx_get_intr_info(vcpu))) {
>  		kvm_before_interrupt(vcpu, KVM_HANDLING_NMI);
>  		if (cpu_feature_enabled(X86_FEATURE_FRED))
> -			fred_entry_from_kvm(EVENT_TYPE_NMI, NMI_VECTOR);
> +			fred_entry_from_kvm(EVENT_TYPE_NMI, NMI_VECTOR,
> +					    vmx_get_exit_qual(vcpu));
>  		else
>  			vmx_do_nmi_irqoff();
>  		kvm_after_interrupt(vcpu);

As a prep patch, what if we provide separate wrappers for IRQ vs. NMI?  That way
KVM doesn't need to shove a '0' literal for the IRQ case.  There isn't that much
code that's actually shared between the two, once you account for KVM having to
hardcode the NMI information.

Compile tested only...

--
From: Sean Christopherson <seanjc@google.com>
Date: Wed, 14 May 2025 07:07:55 -0700
Subject: [PATCH] x86/fred: Provide separate IRQ vs. NMI wrappers for "entry"
 from KVM

Provide separate wrappers for forwarding IRQs vs NMIs from KVM in
anticipation of adding support for NMI source reporting, which will add
an NMI-only parameter, i.e. will further pollute the current API with a
param that is a hardcoded for one of the two call sites.

Opportunistically tag the non-FRED NMI wrapper __always_inline, as the
compiler could theoretically generate a function call and trigger and a
(completely benign) "leaving noinstr" warning.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/fred.h | 24 +++++++++++++++++++-----
 arch/x86/kvm/vmx/vmx.c      |  4 ++--
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/fred.h b/arch/x86/include/asm/fred.h
index 2a29e5216881..dfb4f5e6a37a 100644
--- a/arch/x86/include/asm/fred.h
+++ b/arch/x86/include/asm/fred.h
@@ -10,6 +10,7 @@
 
 #include <asm/asm.h>
 #include <asm/trapnr.h>
+#include <asm/irq_vectors.h>
 
 /*
  * FRED event return instruction opcodes for ERET{S,U}; supported in
@@ -70,14 +71,26 @@ __visible void fred_entry_from_user(struct pt_regs *regs);
 __visible void fred_entry_from_kernel(struct pt_regs *regs);
 __visible void __fred_entry_from_kvm(struct pt_regs *regs);
 
-/* Can be called from noinstr code, thus __always_inline */
-static __always_inline void fred_entry_from_kvm(unsigned int type, unsigned int vector)
+/* Must be called from noinstr code, thus __always_inline */
+static __always_inline void fred_nmi_from_kvm(void)
 {
 	struct fred_ss ss = {
 		.ss     =__KERNEL_DS,
-		.type   = type,
+		.type   = EVENT_TYPE_NMI,
+		.vector = NMI_VECTOR,
+		.nmi    = true,
+		.lm     = 1,
+	};
+
+	asm_fred_entry_from_kvm(ss);
+}
+
+static inline void fred_irq_from_kvm(unsigned int vector)
+{
+	struct fred_ss ss = {
+		.ss     =__KERNEL_DS,
+		.type   = EVENT_TYPE_EXTINT,
 		.vector = vector,
-		.nmi    = type == EVENT_TYPE_NMI,
 		.lm     = 1,
 	};
 
@@ -109,7 +122,8 @@ static __always_inline unsigned long fred_event_data(struct pt_regs *regs) { ret
 static inline void cpu_init_fred_exceptions(void) { }
 static inline void cpu_init_fred_rsps(void) { }
 static inline void fred_complete_exception_setup(void) { }
-static inline void fred_entry_from_kvm(unsigned int type, unsigned int vector) { }
+static __always_inline void fred_nmi_from_kvm(void) { }
+static inline void fred_irq_from_kvm(unsigned int vector) { }
 static inline void fred_sync_rsp0(unsigned long rsp0) { }
 static inline void fred_update_rsp0(void) { }
 #endif /* CONFIG_X86_FRED */
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 5c5766467a61..271f92fee76b 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7079,7 +7079,7 @@ static void handle_external_interrupt_irqoff(struct kvm_vcpu *vcpu,
 
 	kvm_before_interrupt(vcpu, KVM_HANDLING_IRQ);
 	if (cpu_feature_enabled(X86_FEATURE_FRED))
-		fred_entry_from_kvm(EVENT_TYPE_EXTINT, vector);
+		fred_irq_from_kvm(vector);
 	else
 		vmx_do_interrupt_irqoff(gate_offset((gate_desc *)host_idt_base + vector));
 	kvm_after_interrupt(vcpu);
@@ -7393,7 +7393,7 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 	    is_nmi(vmx_get_intr_info(vcpu))) {
 		kvm_before_interrupt(vcpu, KVM_HANDLING_NMI);
 		if (cpu_feature_enabled(X86_FEATURE_FRED))
-			fred_entry_from_kvm(EVENT_TYPE_NMI, NMI_VECTOR);
+			fred_nmi_from_kvm();
 		else
 			vmx_do_nmi_irqoff();
 		kvm_after_interrupt(vcpu);

base-commit: 9f35e33144ae5377d6a8de86dd3bd4d995c6ac65
--

