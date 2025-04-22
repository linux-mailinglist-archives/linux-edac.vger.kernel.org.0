Return-Path: <linux-edac+bounces-3643-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC08A96FE3
	for <lists+linux-edac@lfdr.de>; Tue, 22 Apr 2025 17:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74A251B80296
	for <lists+linux-edac@lfdr.de>; Tue, 22 Apr 2025 15:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E00B28FFCD;
	Tue, 22 Apr 2025 15:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I6IV+lrb"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F9828F935
	for <linux-edac@vger.kernel.org>; Tue, 22 Apr 2025 15:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745334187; cv=none; b=UDIPOM4uakMjlE3kqgadCWqAaVV14UlBWPcwyYgGde/jKRNlmy1x5NvKeUue5c9pdL3vOn4XgMGJ8/WrpIV8X1dDg3a7DpZVjZj3jZJVbIMUFN6Pd8KlE8AuY1jGR5sJumN8UR4xsOkow8GD60vuni6Q8zCD436uurDk9bHD1rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745334187; c=relaxed/simple;
	bh=a9oHiuIRd+Lat23wgyOLQVKu0davNOYNyV1lqgu94Hc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q1vOtXcfO0PS7AHd35efYUZCFQzPZ5BZhQj5oQnBaDtsL7ae651GQhhhPLeaT7sZYkCPGBj+tlXKvULQwmt8MTkuxD2/l0W21YLNTKQrI6NsBGuvHY/g6CffgcdOx/v5fcyiQzz4lH1HkypDfBtpMwY2KlWT8GRACQIauSFp0uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I6IV+lrb; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff798e8c3bso4464206a91.2
        for <linux-edac@vger.kernel.org>; Tue, 22 Apr 2025 08:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745334183; x=1745938983; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZR743ev6ExzRYE8cINx+AM9cywgAmFfoIc+SqezuNJU=;
        b=I6IV+lrbYv0t+bvIaiG0TbVyWJT40Lj0vRqcLzc3/x+0dcZml1AnFM8HQY5Ii0wkCK
         EFI9GLLncA7Nf81PeY4qYgGpbEdk6GQtvjHUrP43uS7sYSItfs/Hp/W+equBtADhN9iR
         H8kGG/d5XAZylKSAL++q+ioYsECrBM0IYZU7VUdqcrJGhPa3joqiDrIgBusCnfsOOjmZ
         /a1Dr6t8bvSNSFRCHQvERf4r1hilrZRf/fX4p3Lkj5VzPiie0d1c69yQE2wP4ATTE3E/
         J6p2quspRGpvtugOYU1sLARWmrmhAeltWiFl33W2BwncgY4q3qCNTdFwpdJXyCO/Kkkj
         To3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745334183; x=1745938983;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZR743ev6ExzRYE8cINx+AM9cywgAmFfoIc+SqezuNJU=;
        b=JCz6bN7af/jcx52EVywcMz2d+WTmLkDkzIlG6O2Hayzh8psbDBElSHbCw02o+mFHj8
         xcTLWfAYKHXmOzNYmlNlWrDRxkhTzo8tsOfjXuRjupAwN8Fz+N+/mfUcrxKhqAl3jqO2
         e6LkBaC77pQHAE8kClYQvEkY7N0frbS3Gow8RjbjFqB3TKBx2/jUDCxmNT31aQTA+Gpt
         I2LgxcOSJ3m3PSOAO4ur8MU4BL7AXjbu7ixbcLA6EvuP6bC3la8q1TyxTWp8NirwTTeQ
         51RGwszTqmJu5/NQDwz3lj+JEde+bTejgeuy2u4a3KZgLNdo9iFt6kB904SKqMK40Bej
         1Bdw==
X-Forwarded-Encrypted: i=1; AJvYcCWEyHBWEDL6vua8waoDkfsN1Y/mO/Av9eJZ321EinBlAlmC/pwd+hRbTnM7UndvUhHfmlNMTxc5+FzX@vger.kernel.org
X-Gm-Message-State: AOJu0YyDH7vIPvMghOCi4+XiEx7XWAoQMi/dtoeuQbsZ/K7kxxj8hs9M
	V9OUyIiSBBeWxicW0u6G4VBm91627JRJ8MvRx/iy5qUw1z2O9s0pCviLdverfVOx482+5bsv7/i
	8JA==
X-Google-Smtp-Source: AGHT+IEIapJZJRM9UWSGs3HX5eEFDXXhucM1QTXJfnPOK/9YTrDfsNmQubNfg9xjcSY4LHTjaYmG0pXn5/g=
X-Received: from pjbsn11.prod.google.com ([2002:a17:90b:2e8b:b0:308:861f:fddb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3a0c:b0:2ef:31a9:95c6
 with SMTP id 98e67ed59e1d1-3087bb56439mr25794718a91.14.1745334182926; Tue, 22
 Apr 2025 08:03:02 -0700 (PDT)
Date: Tue, 22 Apr 2025 08:03:01 -0700
In-Reply-To: <20250422082216.1954310-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250422082216.1954310-1-xin@zytor.com>
Message-ID: <aAevpauKYWwObsB7@google.com>
Subject: Re: [RFC PATCH v2 00/34] MSR refactor with new MSR instructions support
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
> base-commit: f30a0c0d2b08b355c01392538de8fc872387cb2b

This commit doesn't exist in Linus' tree or the tip tree, and the series doesn't
apply cleanly on any of the "obvious" choices.  Reviewing a 34 patches series
without being able to apply it is a wee bit difficult...

