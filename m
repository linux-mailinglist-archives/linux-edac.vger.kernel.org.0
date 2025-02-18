Return-Path: <linux-edac+bounces-3133-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 552C0A39D38
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 14:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 273521882D21
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 13:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC29626770D;
	Tue, 18 Feb 2025 13:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="LVJB6exv"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8324D22F155;
	Tue, 18 Feb 2025 13:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739884704; cv=none; b=PdKyNB+OO48QfT1d0T+q33/6Jd5iwK908xxDvE9139PbN8tGcvmBtk0T2Pu5fLf+jljKdQrghPyqRqqflKeUzvRl2dYhipW1Jehjf4e7UjXV18uE8eptTEgVhUcn3WgIKWrKgrtxxboB527ep81aKFDNKCWQv3k6U/Ayq+vOGzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739884704; c=relaxed/simple;
	bh=kA2fNkwc5OPwz2/SzwDsSIfywB8B4X2oTdGgdzJp50M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=teyXKR6Jex/Ojtkp6ORhCZEe4mPpv1+egRbXjnV3sBp7B6GvbZzE4Nmg9wIFi7YNA2OUzk/k8qiAgnb50AT5HWFdcj2VUvyn0tyKj+XapDpe/UvxwlW6dty8YqCOR+hyoeId07u/Rnvwpuznvb2f2dz0c+k1RsB9zU08JPA3API=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=LVJB6exv; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 29EF840E0176;
	Tue, 18 Feb 2025 13:18:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8jD86xlP2WPL; Tue, 18 Feb 2025 13:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739884695; bh=Yk6zcbDKLG3prX/xnIegA4Rq9Tk3/+CrjBLDfzcnems=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LVJB6exvo+MT16YysdP91iU2FZ0VWnfLJXQAD4cEzMW9B4T10f441F3zItxv9+yDt
	 iCyjFo+bRq630mvyVn5DzdEC2UzvDYdi6Ad69e0XmUY428vUEQycMFpyzU3QcYyQUK
	 vHBaWQo/KgIJUVS5hwC93VJkQWajSnjkpzxvehebjzj5r8lTThwAxXaAsN22w5DN4b
	 EjT/gd4cRJZ5i9AUOZubsX4m6ytFxx40BQJL5O0t8piYeLxJvN5BTtR9lnP7tYWS21
	 fs0e9uzlMzrUumi7jRaJKQBTYA2g+IuAHus7JULZCBFrypI+xZTjQv5xqMl4Z3Brgl
	 KckUF1PktjfbqT54m3IlqAMD4c0p70hM1bQ/tDTnLUxN7/DPo6/xOFP6+/nOvuBaZc
	 DlQmXVg1Ef+/w9pRMqTcU5In/KdZZ77agV12OLj/Aj1kD9Uq/aBVybCaoWbJO8ucAN
	 qg54WoavkVj/V2OR2B8cgPzGIhGJRtkbfOkgw71Y8oPlx1MrLgc7hovwlaUot1PPut
	 3ni0H4vPGpvVn/XG0StcbggJxvP8zyAia3esp2ErlDWfCUonCvIvYI15JcEYkzeHjY
	 AI4taU2lAMMmZOizUYEMOMhGwGDCLsOYeNMfxuRwZtKwgldtyzOvTAKtaGqXss3F59
	 jEHZ8Cx0gmdsmXeIuN0ALbfE=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6707640E01A1;
	Tue, 18 Feb 2025 13:17:58 +0000 (UTC)
Date: Tue, 18 Feb 2025 14:17:53 +0100
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
Message-ID: <20250218131753.GIZ7SIgRZBJokysBeX@fat_crate.local>
References: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
 <20250218082727.GCZ7REb7OG6NTAY-V-@fat_crate.local>
 <7393bcfb-fe94-4967-b664-f32da19ae5f9@linux.alibaba.com>
 <20250218122417.GHZ7R78fPm32jKYUlx@fat_crate.local>
 <02164ab7-c65b-4b2e-8686-5539bdcb8f43@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <02164ab7-c65b-4b2e-8686-5539bdcb8f43@linux.alibaba.com>

On Tue, Feb 18, 2025 at 09:08:25PM +0800, Shuai Xue wrote:
> Yes, the poison is found on user pages.
> 
> Form commit log, the mechanism is added by Tony and suggested by you.
> https://lkml.kernel.org/r/20210818002942.1607544-3-tony.luck@intel.com

I'm not talking about how it is detected - I'm asking about *what* you're
doing exactly. I want to figure out what and why you're doing what you're
doing.

> It's the same as with real issue. There's no magic to it.

Magic or not, doesn't matter. The only question is whether this can happen in
real life and it is not just you using some tools and "fixing" things that
ain't broke.

> > What do futexes have to do with copying user memory?
> 
> Return -EFAULT to userspace.

This doesn't even begin to answer my question so I'll ask again:

"What do futexes have to do with copying user memory?"

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

