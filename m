Return-Path: <linux-edac+bounces-3644-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 663DAA97006
	for <lists+linux-edac@lfdr.de>; Tue, 22 Apr 2025 17:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D44516993E
	for <lists+linux-edac@lfdr.de>; Tue, 22 Apr 2025 15:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5837E28EA6F;
	Tue, 22 Apr 2025 15:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fWMaq0EX"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321C828CF67
	for <linux-edac@vger.kernel.org>; Tue, 22 Apr 2025 15:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745334579; cv=none; b=YscS2BnnPPRogTXQW3bJMyz/iJ5E4wCUs4AbxvxK/2r8wollazamWNMsu3hlbrpAhaUrETATU3YPivWzla8We3//WjfbrOcF2Ks+10Tej1+0DTC5cIsps+NfuWljZbPP0GADgkbESybkQUcolBhNziJjUWvvehvEXMwe0XuiW8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745334579; c=relaxed/simple;
	bh=u2pTJx0Ij+runOvsJmA0q5y9Kslc+OcE1AiOs4Q52gA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ULKWlViL6AdEWaerR/Zzsz3O9Q3jOIhQmIAgE3xws8VOJdnNjB8KgZQ7lPdgFV+vhG5bRnjLeOrq/WqpMjECs4a4cyYRSKIkO0Hjz/tfZFlweVed94LmjWuBed9RmV2wclNp5f1c5XTZc5fsfhPSP4uy0FAc+mhu1fbwyE+lI6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fWMaq0EX; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b073ef14fa7so3011048a12.0
        for <linux-edac@vger.kernel.org>; Tue, 22 Apr 2025 08:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745334576; x=1745939376; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rRXArVhux4Bsw70YvwQ+lh5zlccYMqH0xPXNTi9FZ8g=;
        b=fWMaq0EXfAG3BHE7JfR6uLKMHALt98SwgbMx8tUXl5+HBynuzfsocxXtiedr9Nk8II
         O2IRJqJLxz5EQQxVg4I5U0EF4K6A9UD9yItB8uDzjYWmdW7pRZE4b+C+d0eDcteWuTpT
         qRTHOOZw+sLPzWAzpg1e59N/tkjSYjpUO7VmF2LUmUzRaj+9u/iMsNn61MV1QM+0O2cA
         +jl56znNd4NO2Z/VFmDHQJ6sI8ulRX2TDsOE1N1Jg1pPm2TrAEcdGyJchvr1Z9ky8A4+
         P6zW13gfUAmeZ/FippT/ZJ8EAHk2QpCPCHOmOphlhJ7oWdZ+X8ixc7Y/q7hVsdfIyuhJ
         AxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745334576; x=1745939376;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rRXArVhux4Bsw70YvwQ+lh5zlccYMqH0xPXNTi9FZ8g=;
        b=rtGp8wvGV/d9wAdAZtqiOMznqCSDSyZcptB1UDlpLf8zHtvNaDtQXoGF8qYDQlcKuH
         YHymqyNrjcAClVV7WYNhWC0tfUJxd/wEO4oZNfRm33wfMA4O9N55Ko69tR77XEMPOncQ
         Lv/qwO82jsASyafM8B0VHPVchBSC84tVNZbzuDky1diOfPr50DnPZmihWlXUSUB5MAvW
         sf4qUBzokHgX0tCjpuU1Xmm2M+UAZp0iqCwGqNK+VYs/wITEL2qgvcwdPgxWUkrkpaao
         ZyDGG9eMWf6rCaoF5816+NVGTFlGrwlcHgwWo9SYzUpIyDooFWxgUt3dZEqNjfQRjPVx
         HsVA==
X-Forwarded-Encrypted: i=1; AJvYcCWW7RplitFzM7HAtd/pO0LQ9EEYOS4R+y4Y8as8YUrvPc2Ge54RlHla6YxPSMbSWktSJcbkQAuJKciS@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+iYBJ6N21LTenpDQo1k3+1s7Uv75ma6CXyip1oOPC+d/zdB3l
	w/VM7RvVdwqeCVvibtFd6cBEu+oFptgIawTHhqMrVU+gG4fLLyDdpXG0JfDHtmwsgDf42vDL6/m
	nIw==
X-Google-Smtp-Source: AGHT+IHGR6YFubcBkAQrqhkjsdDwq21aLEhFyH8uteoXFGo84CYqI3Y4PMerNLsX7Qx/XFlRMipUTrfnrN0=
X-Received: from pjbrr7.prod.google.com ([2002:a17:90b:2b47:b0:2fc:2c9c:880])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4ecf:b0:2ff:692b:b15
 with SMTP id 98e67ed59e1d1-3087bbca3b0mr26039866a91.33.1745334576501; Tue, 22
 Apr 2025 08:09:36 -0700 (PDT)
Date: Tue, 22 Apr 2025 08:09:34 -0700
In-Reply-To: <20250422082216.1954310-11-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250422082216.1954310-1-xin@zytor.com> <20250422082216.1954310-11-xin@zytor.com>
Message-ID: <aAexLqjhKncFyw2V@google.com>
Subject: Re: [RFC PATCH v2 10/34] x86/msr: Convert __rdmsr() uses to
 native_rdmsrq() uses
From: Sean Christopherson <seanjc@google.com>
To: "Xin Li (Intel)" <xin@zytor.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-edac@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, acme@kernel.org, 
	jgross@suse.com, andrew.cooper3@citrix.com, peterz@infradead.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, wei.liu@kernel.org, ajay.kaher@broadcom.com, 
	bcm-kernel-feedback-list@broadcom.com, tony.luck@intel.com, 
	pbonzini@redhat.com, vkuznets@redhat.com, luto@kernel.org, 
	boris.ostrovsky@oracle.com, kys@microsoft.com, haiyangz@microsoft.com, 
	decui@microsoft.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 22, 2025, Xin Li (Intel) wrote:
> __rdmsr() is the lowest level primitive MSR read API, and its direct
> use is NOT preferred.

Doesn't mean it's wrong.

> Use its wrapper function native_rdmsrq() instead.

...

> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 1547bfacd40f..e73c1d5ba6c4 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -380,7 +380,7 @@ static __always_inline void vmx_disable_fb_clear(struct vcpu_vmx *vmx)
>  	if (!vmx->disable_fb_clear)
>  		return;
>  
> -	msr = __rdmsr(MSR_IA32_MCU_OPT_CTRL);
> +	msr = native_rdmsrq(MSR_IA32_MCU_OPT_CTRL);
>  	msr |= FB_CLEAR_DIS;
>  	native_wrmsrq(MSR_IA32_MCU_OPT_CTRL, msr);
>  	/* Cache the MSR value to avoid reading it later */
> @@ -7307,7 +7307,7 @@ void noinstr vmx_spec_ctrl_restore_host(struct vcpu_vmx *vmx,
>  		return;
>  
>  	if (flags & VMX_RUN_SAVE_SPEC_CTRL)
> -		vmx->spec_ctrl = __rdmsr(MSR_IA32_SPEC_CTRL);
> +		vmx->spec_ctrl = native_rdmsrq(MSR_IA32_SPEC_CTRL);

And what guarantees that native_rdmsrq() won't have tracing?  Ugh, a later patch
renames native_rdmsrq() => native_rdmsrq_no_trace().

I really don't like this.  It makes simple and obvious code:

	vmx->spec_ctrl = __rdmsr(MSR_IA32_SPEC_CTRL);

so much harder to read:

	vmx->spec_ctrl = native_rdmsrq_no_trace(MSR_IA32_SPEC_CTRL);

and does so in a way that is difficult to review, e.g. I have to peek ahead to
understand that this is even ok.

I strongly prefer that we find a way to not require such verbose APIs, especially
if KVM ends up using native variants throughout.  Xen PV is supposed to be the
odd one out, yet native code is what suffers.  Blech.

