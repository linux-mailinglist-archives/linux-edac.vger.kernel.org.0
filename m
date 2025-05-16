Return-Path: <linux-edac+bounces-3928-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 971E0AB938D
	for <lists+linux-edac@lfdr.de>; Fri, 16 May 2025 03:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90F613B6433
	for <lists+linux-edac@lfdr.de>; Fri, 16 May 2025 01:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55693220F33;
	Fri, 16 May 2025 01:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yasT5pOt"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98748F4A
	for <linux-edac@vger.kernel.org>; Fri, 16 May 2025 01:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747358147; cv=none; b=QvgXiBF1RyyldJE+CChA2MyXK/KeJNW7L/VtRGIHrU0VOYaqh3XI0B9LeTIqyOfqvalGfQkAlyD2/CyNghvUN5TKZvgVRQMPHgLuXh8p6qRFTFgbaxN0mNyhRs/fD1WI46IgVrSHQidPEH+DiWYCJ4hzsykazLG+E6HEpYP534A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747358147; c=relaxed/simple;
	bh=NIzlTsdcB+N3toFqpEFnhBW4WHNKbcmfhgrOkvMx7bE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SHtpW/uM/cazeSBviXmQQNRtNdm0MriY08C6Y2nK6/QsOuNstj8u6Z9eekwY3JDCoraWxRil0PSusL0JQJjSHzQmwec86slp1opR5EBtIwWoV4rdX0oumAT3W5iYT5/UPbV8Yt3II7RL7jErio2/E+biGipDArJ4toLZwaAjTF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yasT5pOt; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30e86c46eadso64604a91.2
        for <linux-edac@vger.kernel.org>; Thu, 15 May 2025 18:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747358145; x=1747962945; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XVMuD/PalT/pmzH7BG3QdDQAVO8SDVrpqfTHUU96orc=;
        b=yasT5pOtkKZ2HIA+K53Sqk6H4Ev8CXGSUQ58YSHc821Ly+j4DoAPt9SguA4b+QGp7p
         3kXm3LYhtjpsz+pRT6dskwUlHoo1nU+BtBUHdivyiBqYR7IeWMld0yiWyG63qXqOkZim
         PpwHdxjrSeV8Se24vrlRbQl/1p1HvizesDBX++ds8cl2eg+nE3NQ7WiutdmQSHRq2hY0
         2obLDB+RR2cz4uNHhrVhhkLrbEqcVkJA8sRydxDA7reF+FlstnY4L89fNTYBN5JyZAC6
         UqRO7Q2G0L1M8bHS91dmzw7fnyphVs0p5QNOIg3d2kM7AqpoFLvxsBEjWlJETHO+BgaB
         iAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747358145; x=1747962945;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XVMuD/PalT/pmzH7BG3QdDQAVO8SDVrpqfTHUU96orc=;
        b=vfAMEtHlKRfHfXqSxnXHFQIaos5MZ06/7+vY+9WaMvtSwmtDbrbB9PWd4DHNyA2spw
         8+H/ebTEjUoLmV/uW01jIXhUJFvYl3UhHnyN1mrtN92OL9TtkLbwYuTRyNXrZpYwCtvc
         wUpKi2yHHOcLrf6uox13nsq70h/rUlg7crtmKLY62HRFQujyem/OFUtGf1W71mqIRebs
         YoXkwjKMazqdUAn6/bR3MT/Axu2d+1nQX5vVQPBtIeQCUOzuDq4M+wGrILkUHnTAumev
         3SEQF2/0RD+VUlqovFnLEleTc7HZapIgGi3CRGt8wVXKxlZJWEe85/eDhHg2FqN61Ov8
         OsDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdyn47pFvVLLM46teZwl9l7LdedVNzmC1w6QmjU97Wrs36lNEK83/s45RJpnp8IIQgYJQ0cRrF+T9u@vger.kernel.org
X-Gm-Message-State: AOJu0YxqxGOVt2t+ItkR/uHuyYX4iLY6ziY9vp9CB4nSqmA1wvuTFSZm
	1ZWEV/eNxi+pOT44oDQMQxFT6l3A5Kv2qsJ7IenXU7fZ5QT0Ah5suXVBDKCgxrbc164hg85BZow
	o/UGJSA==
X-Google-Smtp-Source: AGHT+IG5J9s2NMDhY7/8A4O+MyMGUN6e8x3str2oF1VXVAVtOy4jEWK/Fd7BwjZNXFkmEs5DGaZLrHwGgt0=
X-Received: from pjyp5.prod.google.com ([2002:a17:90a:e705:b0:30e:7783:edb6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3905:b0:30e:6a25:e4e6
 with SMTP id 98e67ed59e1d1-30e7d5acafcmr1469988a91.22.1747358145046; Thu, 15
 May 2025 18:15:45 -0700 (PDT)
Date: Thu, 15 May 2025 18:15:43 -0700
In-Reply-To: <e12abcca-b7b4-404d-b379-8636e5b68813@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250513203803.2636561-1-sohil.mehta@intel.com>
 <20250513203803.2636561-2-sohil.mehta@intel.com> <aCSljsvI0A-HC_DT@google.com>
 <e12abcca-b7b4-404d-b379-8636e5b68813@intel.com>
Message-ID: <aCaRvwnkXf07Mtue@google.com>
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

On Wed, May 14, 2025, Sohil Mehta wrote:
> On 5/14/2025 7:15 AM, Sean Christopherson wrote:
> > Compile tested only...
> > 
> 
> No worries. I'll test it out. I am assuming you want this patch to go as
> part of this series.

Yes please.  I can also post it separately, but that seems unnecessary.

> > --
> > From: Sean Christopherson <seanjc@google.com>
> > Date: Wed, 14 May 2025 07:07:55 -0700
> > Subject: [PATCH] x86/fred: Provide separate IRQ vs. NMI wrappers for "entry"
> >  from KVM
> > 
> > Provide separate wrappers for forwarding IRQs vs NMIs from KVM in
> > anticipation of adding support for NMI source reporting, which will add
> > an NMI-only parameter, i.e. will further pollute the current API with a
> > param that is a hardcoded for one of the two call sites.
> > 
> > Opportunistically tag the non-FRED NMI wrapper __always_inline, as the
> > compiler could theoretically generate a function call and trigger and a
> > (completely benign) "leaving noinstr" warning.
> > 
> 
> If this is really a concern, wouldn't there be similar semantics in
> other places as well?

There are, e.g. the stubs in include/linux/context_tracking_state.h and many
other places.  It looks ridiculous, but the compiler will generate RET+CALL for
literal nops if the right sanitizers are enabled.  E.g. see commit
432727f1cb6e ("KVM: VMX: Always inline to_vmx() and to_kvm_vmx()").

> > @@ -70,14 +71,26 @@ __visible void fred_entry_from_user(struct pt_regs *regs);
> >  __visible void fred_entry_from_kernel(struct pt_regs *regs);
> >  __visible void __fred_entry_from_kvm(struct pt_regs *regs);
> >  
> > -/* Can be called from noinstr code, thus __always_inline */
> > -static __always_inline void fred_entry_from_kvm(unsigned int type, unsigned int vector)
> > +/* Must be called from noinstr code, thus __always_inline */
> > +static __always_inline void fred_nmi_from_kvm(void)
> >  {
> >  	struct fred_ss ss = {
> >  		.ss     =__KERNEL_DS,
> > -		.type   = type,
> > +		.type   = EVENT_TYPE_NMI,
> > +		.vector = NMI_VECTOR,
> > +		.nmi    = true,
> > +		.lm     = 1,
> > +	};
> > +
> > +	asm_fred_entry_from_kvm(ss);
> > +}
> > +
> 
> The original code uses spaces for alignment. Since we are modifying it,
> I am thinking of changing it to tabs.

Oof, yeah, definitely do that.

