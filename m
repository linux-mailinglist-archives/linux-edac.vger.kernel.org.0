Return-Path: <linux-edac+bounces-3666-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DEFA98B57
	for <lists+linux-edac@lfdr.de>; Wed, 23 Apr 2025 15:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 536827A5E31
	for <lists+linux-edac@lfdr.de>; Wed, 23 Apr 2025 13:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320891A5B88;
	Wed, 23 Apr 2025 13:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nT0JZxbk"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26301A2380
	for <linux-edac@vger.kernel.org>; Wed, 23 Apr 2025 13:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745415436; cv=none; b=C4/01K8C0uhFMFQ9wTFd3OJdQgshxUTm90FzezxWjzIf8jIRhr1jHCxpARMGQSHwaSxBX/h+K2tP725Q7IHemXWkm4FPXUj2bUVvYxWd4CqtT964cDf14HCNUZjc+qJMbdo6KpDsX0/ag0d27/rEET/AZ7gErua6GqjBvqa81ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745415436; c=relaxed/simple;
	bh=dXr0vdvJSE4CQmBa2fTuILJV/L6G5HpSxSHQ49PKVqY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QMJyPBFP8csFjoBdzMHWvslFgY/I5E1QSewPi48VKm25iqEBCoIlC3wwfecDcIIJRZdFro6b/ehLTidIbDgpzOs7ofVPOMZq6fQl/DmDEAreasdEFnfqErf4PPbBfVFcZ52eSGJB7yoXHTTBe0xhal6AiN6VXp3izwh8h08prw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nT0JZxbk; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3055f2e1486so9192646a91.0
        for <linux-edac@vger.kernel.org>; Wed, 23 Apr 2025 06:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745415433; x=1746020233; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QTV99TNe8c9V+BGz9HYw0E5RTZLdGwFx/9m2XgmuzHE=;
        b=nT0JZxbkLOWuAaq4nDpqtJy0UU3fVSwyW/pnNNBGYtoYR/+veEUbsw1SW7uJkXUY9+
         O8RFZ5mI3iZ/bhFeyS6mpQMMAXezkdZIzt5lXK/oKDFsuDimPPcn2I6rOaU8XnWilwy4
         Qflh7jQ/97QLXGCjRrnvUz0MJpppmkyoylDcvcx1GHi73/C77pzsSBWavAJzDCuOl8Vu
         Bx69HB/Nd+cusCL5TPzdZ2tLrS0aQKRNqjrAQAhL7fNktV8FmsgyGiJ37d7CE0puVmjy
         sSKyhx/48E0CSccNslHjG8NDhKl65lvTaigTuvvrWJaiU24iVs3SZBs7noSsvJEIf+mE
         70Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745415433; x=1746020233;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QTV99TNe8c9V+BGz9HYw0E5RTZLdGwFx/9m2XgmuzHE=;
        b=ozbPwFmg/Sx89Sr+eGtrf7m64Qkzp0rknXK3br/X4GH2apv5hMek4Oar/ndFxdpdks
         4LRAkee0r8qUn3Ze/JsmrrVh1/MGm2FoNhwlO/PcMHD5jT/KJFX/DNyHKz0kSSxl+Ajk
         WY23avkg5vxtKGfWtcHI1usn+VLax8DzB+TlSPbzybrduAEIXU6d10hc7Jd06D2PzCJK
         DSKaXeRMr8iVqospDbrL9oSF1EWWhpQql+pSWOc0WSfdY+7PqpRY7pJEE5DENQ5AcIF+
         dQvDkvogmpnvvgkjsBYk8zDQ7lmiOtEdfYESbTcUHaibVofXKPE8hEeWglx3hp8BrLmO
         QiqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOc1ExiY+Izq+1ogsMcWH08xHfSeJmAeXUg0nVTysSrfZMe8aVOQGi5Him3BISAmliReUZiC4+wQb8@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg+1xtWJpfTTTTxbz5S44lRwAZvj0AXiC1JDmQzFxuIXZhZRNa
	27e4Q/iOYRBfiVa8JwWk4HBHxO8gdIrIWxqEs3G0O83+Vb6ovbGpvTwg4imR9Re8oD5NMoDRwVq
	HIg==
X-Google-Smtp-Source: AGHT+IEWS42km52dkYFlmcKZWmN1wttg5SPG3JN+o4kIB9LzXEDLrbHh1gdrPp7a64YZSw75FwPTF5N3xvo=
X-Received: from pjur12.prod.google.com ([2002:a17:90a:d40c:b0:308:867e:1ced])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2650:b0:2ee:9b2c:3253
 with SMTP id 98e67ed59e1d1-3087bbc9333mr25668631a91.30.1745415432973; Wed, 23
 Apr 2025 06:37:12 -0700 (PDT)
Date: Wed, 23 Apr 2025 06:37:11 -0700
In-Reply-To: <7527f09c-7163-4276-b9a4-edac6c8217ae@zytor.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250422082216.1954310-1-xin@zytor.com> <20250422082216.1954310-11-xin@zytor.com>
 <aAexLqjhKncFyw2V@google.com> <7527f09c-7163-4276-b9a4-edac6c8217ae@zytor.com>
Message-ID: <aAjtBxzvRgNt4Uzr@google.com>
Subject: Re: [RFC PATCH v2 10/34] x86/msr: Convert __rdmsr() uses to
 native_rdmsrq() uses
From: Sean Christopherson <seanjc@google.com>
To: Xin Li <xin@zytor.com>
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

On Wed, Apr 23, 2025, Xin Li wrote:
> On 4/22/2025 8:09 AM, Sean Christopherson wrote:
> > I strongly prefer that we find a way to not require such verbose APIs, especially
> > if KVM ends up using native variants throughout.  Xen PV is supposed to be the
> > odd one out, yet native code is what suffers.  Blech.
> 
> Will try to figure out how to name the APIs.
> 
> One reason I chose verbose names is that short names are in use and
> renaming needs to touch a lot of files (and not fun at all).

Yeah, I've looked at modifying rdmsrl() to "return" a value more than once, and
ran away screaming every time.

But since you're already doing a pile of renames, IMO this is the perfect time to
do an aggressive cleanup.

