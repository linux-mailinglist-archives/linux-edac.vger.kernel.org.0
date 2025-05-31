Return-Path: <linux-edac+bounces-4054-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49802AC9C6B
	for <lists+linux-edac@lfdr.de>; Sat, 31 May 2025 21:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B6439E0F95
	for <lists+linux-edac@lfdr.de>; Sat, 31 May 2025 19:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0676F19DF5F;
	Sat, 31 May 2025 19:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Cq7ZYqE7"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6D62907
	for <linux-edac@vger.kernel.org>; Sat, 31 May 2025 19:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748718474; cv=none; b=JI3HYDTPHFgDNIQbwrgZ6b0lGrGWSm/cljOmtb1+p2NT+iKCSAbdLdu9yg3r2zyJJUYvWVNfA1DT0XgCc7bYLI7HO5UUMbQjs0QIoli9IKwdIW0rL6/knmDebcDKQ5lbsO5qe5a854XR7Wy0GPVXK+2ct8LuyR6MZCJs0yE4cx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748718474; c=relaxed/simple;
	bh=qG4Gd1znDObkE95Znm5UyXr+d/OibBHcX7TPZqP7ZhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iAd/BJ5ZvdIBYoJLg8cyw20CgpxGVFKtzvp0R3ji3Cej7quvlFd0SMTgjpMa00Mm5CgjfD14gp/nzUAxzyR7BKPg5+lsTxfqZn21eWWUTV+cvTTbOKfjpMk37m3Tg/QT7/fVCWkv8v+faYEFn1uBI+ySZUmvJQqb1tbgWH1WYzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Cq7ZYqE7; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4E31040E01A8;
	Sat, 31 May 2025 19:07:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id o9YeEzeMJb9z; Sat, 31 May 2025 19:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1748718464; bh=TZEjiPXyynXIZxBTT1HB/JvF5kpeyzJZZb7FyU8d7lg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cq7ZYqE7E6PCnQ9591AKtievKtJ2LlgWuT4W22rprGG3tzb2MTbGUyi+2Ei2B7kCg
	 XQUnhkt6Fwc8SO3PUHxv7ilSjYXIyewOrpa5iqbCeQNJygdWmrJVf1HAQI4fgzJltQ
	 7JHxs2fjlakLDJ4MSjEyDvAHBuKrNq6/T4VuTNMX8CuV1yP94yT6Naj0ErO/bSR3MS
	 NSSk8wyfCGZD9zI1M9xYnWja+Uj8MpeBaax61HpgRz0RiRGxIWrnbeyuyGVc+DJB5b
	 2FTH7QINCBn7gpbByWcyKH+6JcwEQEo9lOA/8KLpm+V/Mql9ByUmPVYPLLKR1KYcnW
	 h+Z0XULQvRf/JMzU2IzpJDSV2NR4sKjfrt/PjqawftlB4rVJJbwUKU+0FLcTqc0Gfq
	 z6I/Fq9dViYdz0rukVtnN1cSz9jReXDYkzIQXEiq/XQfr+7vC0KGcMZPfS/hTQbyhk
	 HtX5UpvqUvwGGTQB7LbWWNkcWGAUUYKC8WzaRdGbiJqiNRCkIjfehWFtA9YKfDy5Jo
	 jIqv00DXmNVMYbHoCLLYpZ9EU82l7YNdIwNE82PgbTztdyT0z8o8T1p6374fwnxjEU
	 RzWhzqYiekUptOsnSJCP+tdziiplN4UQUsmAS0LceprPMk0XDKDH5xhExDvH2w1gsQ
	 q1agp1DbQ9les2WmKJt/gX+A=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8AF4F40E015E;
	Sat, 31 May 2025 19:07:37 +0000 (UTC)
Date: Sat, 31 May 2025 21:07:24 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ingo Molnar <mingo@kernel.org>
Cc: Xiongfeng Wang <wangxiongfeng2@huawei.com>, tony.luck@intel.com,
	x86@kernel.org, linux-edac@vger.kernel.org, wanghai38@huawei.com,
	bobo.shaobowang@huawei.com
Subject: Re: [RFC PATCH] x86/mce/inject: Add sanity check in inject_mce()
Message-ID: <20250531190724.GCaDtTbBgz3dFE-BDJ@fat_crate.local>
References: <20250529033256.31554-1-wangxiongfeng2@huawei.com>
 <20250529094534.GAaDgsvhdl-BrzlM0J@fat_crate.local>
 <aDq6cecrsKYrwra2@gmail.com>
 <20250531091746.GAaDrJOuUlQyfRjgv3@fat_crate.local>
 <aDtEyl5A36zRyV7B@gmail.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aDtEyl5A36zRyV7B@gmail.com>

On Sat, May 31, 2025 at 08:04:58PM +0200, Ingo Molnar wrote:
> What tool?

mce-inject. The module.

> Or if you mean the MCE-injection interface, that's not supposed to 
> trigger avoidable crashes either, it's an injection facility for 
> testing purposes:

That's an injection facility to TEST THE MCE PANIC PATHS too. YES, IT VERY MUCH
SHOULD TRIGGER CRASHES! That is actually a feature!

I have fixed bugs in the MCE handler exactly because an MCE signature gets
injected unfettered.

> It's really simple really:
> 
> - If the kernel unnecessarily locks up on the receipt of a 
>   hardware-generated MCE then that's a kernel bug that
>   should be fixed.

This is not a hw generated MCE - this is a user-generated MCE signature.
I think you're confusing things here.

> - If the kernel unnecessarily locks up on the receipt of a 
>   software-generated MCE then that's a kernel bug that
>   should be fixed.

No, it isn't. I can inject a MCE which will lock up the whole machine. And
that's a valid MCE which can also be raised by hw.

> TL;DR, this is not an acceptable kernel response:

It is very much a valid kernel response. The MCE injection module allows for
testing the MCE panic path with all that is involved in it, including the
machine dying.

Yes, because MCE is special and it can and *should* cause panics.

So for patches like this one which is masssaging the MCE - and which is also
wrong for other reasons - not every Intel uarch supports local MCEs:

NAK!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

