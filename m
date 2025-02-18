Return-Path: <linux-edac+bounces-3140-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A23A3A144
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 16:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D72097A18F8
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 15:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB4526D5C6;
	Tue, 18 Feb 2025 15:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="PeXt2gJB"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83AE26D5AD;
	Tue, 18 Feb 2025 15:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739892724; cv=none; b=CAddlF4ABiOr+DNNjp5XB5wDl/cvLRhjKihs7p3HIQ6BDsXgtcsAI0JbJByPpGiTCtcWFSnpomw1iPKxLwcsdYNLvk769B6+yXZf1H1MMox6mkts5I5Kbne/nxZ7fGg1MZObLF4kWzIWhxlc0rM2sdA0Cjo6UDkpMtxnS7TGk9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739892724; c=relaxed/simple;
	bh=4A2sXShPAtHWuMnR6v0hXy6n/Ate9VWgRnyzmHJ6E/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7WDThiwVmarjyEsZR9Dfry6Dibo8fjpLcz9DuesZH4MwnSrrzClmv1QMBeGgP5r0ALqHcgJVk4Oyp5pBUCJ4sgxghuC2Pv5ja8hNimk49H7EMSCXJCCdoDaDudgW4h0SW8JJtkX9OkujVKkTokyrvaYJASRSB/+VY3F9PHpncw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=PeXt2gJB; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 50F4740E0212;
	Tue, 18 Feb 2025 15:32:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id h5b8z9JULs8g; Tue, 18 Feb 2025 15:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739892716; bh=xqGUt4GM0NYMO1Cjv7SB68App5WCIDQNnSBWsuJvqx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PeXt2gJBSP+HzBUrHGbRTmyDh/Nx1jkQ1fgufGgT+d6SLqfZxp1g9qQ75UhMLeNUA
	 fFTpCFgLJCOCBQ/QFdmyvcXFAub/CUSwCMT0FfT1GU+ZReFElWWxAwZXUdpiWKqbJh
	 vF7q0KhWFc7xj1lgykE8PbNeEDn8/Anewg+jQN1zgWREXT0aGZe1A4sPd+9YE2ihOU
	 2Kllps77Q5o9WulkTcwOzyRy/e6oBbcdOBwF+IaeKJBx0DYi3rruV48v7Ubpyhx8eE
	 0s6te/veXswH7EJw72xtcLbjQ1MBHokKgHE9HOiacqJqqvRcNwoBPUUsEWrud83eUR
	 VeknBeYWrFiSyIILFxHSJIemWal0QKUeYd0D+sgGIMMyoP1qU922eU/NYcvArp45hK
	 4u2drsQ4mgHDWAnN/yRStjb+tzvlzT7fysiUdksocItfpPdNxQaH7rdMfJJmmh5fr6
	 m4hfeqq6A2XMHZyPs+9XSkzCJ/358iMWoM8mQjgXPzxHaxQPLdv4z+AfKNkQIGiRS6
	 TBSiD3eM4oIPEuqHNh5g2Fi/5bCeovCl7waX82i6x8i0Sg2yGJ9i5TIcub9kkG1KWK
	 XNSsszHEIgoyutt5VzsAfBLvkvHF1Z8vnDFiJ2fEhgNvkby2+YO1I04xyq9GmFxAgl
	 L2C7uFBUaPDeI9F8J4NAAE9s=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 670F440E0220;
	Tue, 18 Feb 2025 15:31:39 +0000 (UTC)
Date: Tue, 18 Feb 2025 16:31:38 +0100
From: Borislav Petkov <bp@alien8.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: tony.luck@intel.com, nao.horiguchi@gmail.com, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, linmiaohe@huawei.com, akpm@linux-foundation.org,
	peterz@infradead.org, jpoimboe@kernel.org,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, baolin.wang@linux.alibaba.com,
	tianruidong@linux.alibaba.com
Subject: Re: [PATCH v2 0/5] mm/hwpoison: Fix regressions in memory failure
 handling
Message-ID: <20250218153138.GLZ7Sn2inSAgMo1aAM@fat_crate.local>
References: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
 <20250218082727.GCZ7REb7OG6NTAY-V-@fat_crate.local>
 <7393bcfb-fe94-4967-b664-f32da19ae5f9@linux.alibaba.com>
 <20250218122417.GHZ7R78fPm32jKYUlx@fat_crate.local>
 <02164ab7-c65b-4b2e-8686-5539bdcb8f43@linux.alibaba.com>
 <20250218131753.GIZ7SIgRZBJokysBeX@fat_crate.local>
 <4b52e6cd-1315-4b0b-8b6e-95a3d4ed96cc@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4b52e6cd-1315-4b0b-8b6e-95a3d4ed96cc@linux.alibaba.com>

On Tue, Feb 18, 2025 at 09:53:17PM +0800, Shuai Xue wrote:
> The regression is reported by end user and we also observed in the production.

Where is that report? How many times do I have to ask about different aspects
of your patches until you explain the *whole* picture?

> [5056863.064239] task: ffff8837d2a2a0c0 task.stack: ffffc90065814000
> [5056863.137299] RIP: 0010:[<ffffffff813ad231>]  [<ffffffff813ad231>] __get_user_8+0x21/0x2b
> ...
> [5056864.512018] Call Trace:

This tells me exactly 0 - I see some truncated stack trace.

> Sorry, I did not get your point.

I don't get your text either. Until this is explained and debugged properly,
it is not going anywhere.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

