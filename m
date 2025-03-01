Return-Path: <linux-edac+bounces-3246-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7B8A4AD69
	for <lists+linux-edac@lfdr.de>; Sat,  1 Mar 2025 19:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11E5B3B0C83
	for <lists+linux-edac@lfdr.de>; Sat,  1 Mar 2025 18:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0789C1BD00C;
	Sat,  1 Mar 2025 18:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="JQMXtY2L"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7F3249F9;
	Sat,  1 Mar 2025 18:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740854881; cv=none; b=S4KoIDyhWOQP2eqJINVFqqZRcNavMMSdBn8wZ7bdmrCr399W4jr+eHzGgkLk91WfN/Xx7lRnsr4Y+9ftFvsFddQb/WektRXSk4txZV5WZbX3D86T+OUbJpSavAfBlK+kplHOhauarxsdG4GVHKf5SeS7f7aiea5bGJD5ACAf9u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740854881; c=relaxed/simple;
	bh=efDsyWtQ79yh+glCJAxW/XDwXPgyVjWRh+dsAy5Dd/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KItvSgaQ9brf9wdcv0KwdVu8iARVJPh7cAQKU3ONp7OMJUPihxFU0VLtPrsG6/FfELcOiZSR4KytnliSUMcwyedDCPD2Iq+HdEVoNu8XekHXusjU2ldpdjk9VvuzHYk+1gGRqDodhjBTeRMJfSDcPjvwVXG2TpAq4iMm5ezv9WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=JQMXtY2L; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id ADA4740E0173;
	Sat,  1 Mar 2025 18:47:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id iIcm_nZK5oGm; Sat,  1 Mar 2025 18:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740854868; bh=l71h9KXcCuDFU+fj0zNN0wy4uU4tSQfRahhqWOcy5yA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JQMXtY2Lxgk1ihOvpFWTuQR6nmFfH4WvcJSzINNVCY4tVIkMAcEKpP56oGL33LX0Y
	 UM+YZzhvXhpWpVDCGLiqFcSZTufYO4UNSLznub0PXKkSZpBTrZIqvvhLXcBy3vMeo5
	 a4jPOyOIW4Ol+VYOZvQVbbnAn1Yzhd+DVJ/0KflWTCgq1u7A0aPI3iyLa9wEyCyTmr
	 PUYlpTrJTOyaNmxBpu/EcBzjd3KTAAvro9tASGZDnbgxC9RXVsTp7bSczc7/3oy4mG
	 3ZNf4YsLZJ2OfjakKmfrPZbMw4gbbCVTDCWSX9Ldfb924KjNGGN0UK251jO8d+iNQs
	 hpx4PUukCdqbOWAwFhd67hLJT4BkaSRhe+t/lrXx2MMqvDNsGyF968qyPlGiQHU6N5
	 PYqywEf1u03V4Z42V1K22uymdSvJilh6eJJbyIeCGwDtL4I6+v+HxNRgw0MoXlV117
	 B3aBpMkXIX0ACIcUwKvT/c9OPpghNBpxgEmCnw43rqKUgxhsKsamIhNwRa2dNIhRlE
	 RTs1Kl6dMYsGwbQywCqxxPJPLDvx1eT+PbUr6nkGakURVt3Elf+0K/Wxse2hsuFte6
	 bwaQtBxEiiAqSUnL8F5awrQnm55aGsfgsa6nD5jvY1EMfjXDrGmTVp6tQOBjmrzkn1
	 2xhyl/IQsGjBaK3wCZPaIViE=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2045B40E0028;
	Sat,  1 Mar 2025 18:47:31 +0000 (UTC)
Date: Sat, 1 Mar 2025 19:47:24 +0100
From: Borislav Petkov <bp@alien8.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: tony.luck@intel.com, nao.horiguchi@gmail.com, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, linmiaohe@huawei.com, akpm@linux-foundation.org,
	peterz@infradead.org, jpoimboe@kernel.org,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, baolin.wang@linux.alibaba.com,
	tianruidong@linux.alibaba.com
Subject: Re: [PATCH v2 2/5] x86/mce: dump error msg from severities
Message-ID: <20250301184724.GGZ8NWPI2Ys_BX-w2F@fat_crate.local>
References: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
 <20250217063335.22257-3-xueshuai@linux.alibaba.com>
 <20250228123724.GDZ8GuBOuDy5xeHvjc@fat_crate.local>
 <cf9ef89c-ca91-476a-895d-2af50616242f@linux.alibaba.com>
 <20250301111022.GAZ8LrHkal1bR4G1QR@fat_crate.local>
 <dee8d758-dd65-4438-8e42-251fb1a305a7@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dee8d758-dd65-4438-8e42-251fb1a305a7@linux.alibaba.com>

On Sat, Mar 01, 2025 at 10:03:13PM +0800, Shuai Xue wrote:
> (By the way, Cenots/Redhat build kernel without CONFIG_RAS_CEC set, becase
> it breaks EDAC decoding. We do not use CEC in production at all for the same
> reasion.)

It doesn't "break" error decoding - it collects every correctable DRAM error
and puts it in "leaky" bucket of sorts. And when a certain error address
generates too many errors, it memory_failure()s the page and poisons it.

You do not use it in production because you want to see every error, collect
it, massage it and perhaps decide when DIMMs go bad and you can replace
them... or whatever you do.

All the others who enable it and we can sleep properly, without getting
unnecessarily upset about a correctable error.

> Yes, we collect all kernel message from host, parse the logs and predict panic
> with AI tools. The more details we collect, the better the performance of
> the AI model.

LOL.

We go the great effort of going a MCE tracepoint which gives a *structured*
error record, show an example how to use
it in rasdaemon and you go and do the crazy hard and, at the same time, silly
thing and parse dmesg?!??!

This is priceless. Oh boy.

> Agreed, tracepoint is a more elegant way. However, it does not include error
> context, just some hardware registers.

The error context is in the behavior of the hw. If the error is fatal, you
won't see it - the machine will panic or do something else to prevent error
propagation. It definitely won't run any software anymore.

If you see the error getting logged, it means it is not fatal enough to kill
the machine.

> > Besides, this message is completely useless as it has no concrete info about
> > the error and what is being done about it.
> 
> I don't think so,

I think so and you're not reading my mail.

>     "mce: Uncorrected hardware memory error in user-access at 3b116c400"

Ask yourself: what can you do when you see a message like that?

Exactly *nothing* because there's not nearly enough information to recover
from it or log it or whatever. That error message is *totally useless* and
you're upsetting your users unnecessarily and even if they report it to you,
you can't help them.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

