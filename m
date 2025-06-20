Return-Path: <linux-edac+bounces-4198-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B170AE25FF
	for <lists+linux-edac@lfdr.de>; Sat, 21 Jun 2025 01:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 918F57A297E
	for <lists+linux-edac@lfdr.de>; Fri, 20 Jun 2025 23:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A18A2417D9;
	Fri, 20 Jun 2025 23:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jh0NsVmU"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A52542A9D
	for <linux-edac@vger.kernel.org>; Fri, 20 Jun 2025 23:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750461505; cv=none; b=kju0MgMurOVy5kptHqN6YOJche6AScUnTuwysmHKwQAG5WemRay65/FprMX3SViKyuJQYn82NX4RRhlCEbvhuQWDpmLtEpz1tYLpvGAhDeP+V+CYIyxF25pUH/FxNcTiqZmWsL9/7o5H91IN1A2GwX+amuLuT4Js8uywnjFXDKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750461505; c=relaxed/simple;
	bh=cJ5hZsPH7NDmBvT6ASMgxpAnAccRQKVdWnl0tO0A/YQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YW3YyykeYBbnJ1Lhtix3h4WRCjUVOWc9dZv9PEbL72Ix1BumU4xj2dT7OGav8mGunGLnVmP9IZxc5EdSOEUoy41XYdCHNCjb1AaNpMqi2P4sP1xvHn32vnBwNfFg01wRcE0vpSi1T2IEl0/FxCGOxOTgPlcnoJFryw5Ih6wFCYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jh0NsVmU; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b3183193374so1435129a12.1
        for <linux-edac@vger.kernel.org>; Fri, 20 Jun 2025 16:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750461503; x=1751066303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bSZq6ddE7mNucAzAya10S33mWQ/Wp8htlhyW4f0AToQ=;
        b=jh0NsVmUCKPkJN/5NcLIgPyrdcHrdOZjBQ1dbZ8lIqXIgCuwY1UOmLhkkr6Duk68gz
         tGBvRziXWNTXYIWjlgj/cuciQ1ykw+18J13j2itp8ohS9kW7jIZJw7ZgCfAJkj+POgsz
         YfFvVRk+S0PYSMaXlE3hBvE5w5gQgr+yduyktiZcWEmwBVP8yNlqie5+G2EoEUufHZD7
         zp4dcyShxqLZmhqSfzl2RnpsCfXpbHvuqJUJIG3l+Vr4zwCI4HbC0YvlSDUTfWc0FLbt
         FyvScPerRgx3lP6IFWiIkkR14Ow2GelvzAbIPLQDCcmxwB54on5YaRfel4a8OwCYgf7q
         uy6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750461503; x=1751066303;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bSZq6ddE7mNucAzAya10S33mWQ/Wp8htlhyW4f0AToQ=;
        b=inIIfEIjnZm9FPLo5WCmFiKf1k3rkjW+qRQCr6Mf03Vv1vfjZ4d7xhb4qSfTqm8/Vk
         ucreDHTBczz0w2Q86a2bUPvf5YSJtRkCQtUWDXZPYU3F0jYBo+5ZlFHuEm95JodaKN76
         4JAlhU6GvMqpwyUO/dIPkYx+uRWHvYSf94ee0m2WmgJ7wVlmUa6xnANS624gpAtaiSxb
         +y40UBgeyNRhVJ3Xy5wCh92YYHxhzraixUQcI03/IntCeAUkq3GH7Lazn8GcfveOMyOS
         QqPfZ/6HqKk+FlsX+obxn5tIMD2QDhqNSAO3vLi/u0adriA/tAkNAIWYSD7/tA90CSQw
         CkrA==
X-Forwarded-Encrypted: i=1; AJvYcCUoz1R381vEC8Huc85etVb7CW9qW7nNJF0Du9JzwhvOis8/XIgxMaxrUXCWL3q37wklHC4faQknJ2gu@vger.kernel.org
X-Gm-Message-State: AOJu0YxT5NTwP/HeFWe1NjSrulqof6rD9mYSOvXLCoYy+PW6czxBhO21
	U5/57a6E52yftyddCjyUSlX0N6xbqEKKPKhpxwVHlUc5qOozhLfbfb0JcEiHCMGYdXnFb7SEh35
	stOeHQg==
X-Google-Smtp-Source: AGHT+IHKltIi0JMRBvpdhKHOFBvjdjaZcxVKi/npJ75GZzdSdCdBTLTS5ifTyl+QncNm67zNvNizSCphOrA=
X-Received: from pjbsc5.prod.google.com ([2002:a17:90b:5105:b0:2fc:3022:36b8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c4f:b0:313:1e9d:404b
 with SMTP id 98e67ed59e1d1-3159d62ac81mr7486543a91.2.1750461502772; Fri, 20
 Jun 2025 16:18:22 -0700 (PDT)
Date: Fri, 20 Jun 2025 16:18:21 -0700
In-Reply-To: <7acedeba-9c90-403c-8985-0247981bf2b5@zytor.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250612214849.3950094-1-sohil.mehta@intel.com>
 <20250612214849.3950094-3-sohil.mehta@intel.com> <7525af7f-a817-47d5-91f7-d7702380c85f@zytor.com>
 <3281866f-2593-464d-a77e-5893b5e7014f@intel.com> <36374100-0587-47f1-9319-6333f6dfe4db@zytor.com>
 <39987c98-1f63-4a47-b15e-8c78f632da4e@intel.com> <7acedeba-9c90-403c-8985-0247981bf2b5@zytor.com>
Message-ID: <aFXsPVIKi6wFUB6x@google.com>
Subject: Re: [PATCH v7 02/10] x86/fred: Pass event data to the NMI entry point
 from KVM
From: Sean Christopherson <seanjc@google.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Sohil Mehta <sohil.mehta@intel.com>, Xin Li <xin@zytor.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Tony Luck <tony.luck@intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Andi Kleen <ak@linux.intel.com>, Kai Huang <kai.huang@intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-edac@vger.kernel.org, kvm@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025, H. Peter Anvin wrote:
> On 2025-06-19 15:57, Sohil Mehta wrote:
> > On 6/19/2025 3:45 PM, Xin Li wrote:
> > > On 6/19/2025 3:15 PM, Sohil Mehta wrote:
> > > >=20
> > > > I want to say that the event data for IRQ has to be zero until the
> > > > architecture changes =E2=80=94 Similar to the /* Reserved, must be =
0 */ comment
> > > > in asm_fred_entry_from_kvm().
> > > >=20
> > >=20
> > > FRED spec says:
> > >=20
> > > For any other event, the event data are not currently defined and wil=
l
> > > be zero until they are.
> > >=20
> > > So "Event data not defined for IRQ thus 0."
> >=20
> > I am fine with this. Not *defined* removes the ambiguity.
> >=20
>=20
> So I was thinking about this, and wonder: how expensive is it to get the
> event data exit information out of VMX? If it is not very expensive, it
> would arguably be a good thing to future-proof by fetching that informati=
on,
> even if it is currently always zero.

It's trivially easy to do in KVM, and the cost of the VMREAD should be less=
 than
20 cycles.  So quite cheap in the grand scheme.  If VMREAD is more costly t=
han
that, then we have bigger problems :-)

