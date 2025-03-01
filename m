Return-Path: <linux-edac+bounces-3244-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3CAA4AA95
	for <lists+linux-edac@lfdr.de>; Sat,  1 Mar 2025 12:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8768E7A887A
	for <lists+linux-edac@lfdr.de>; Sat,  1 Mar 2025 11:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7AF1DE2DC;
	Sat,  1 Mar 2025 11:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="CZ9TN39J"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9502B1A5B97;
	Sat,  1 Mar 2025 11:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740827457; cv=none; b=ChXea7Pq51jhLTCQOhe8IUNg3AYVRpgYXdYahq/wVSEZlmtLMBrGTKA7BjAkSJvtECCa+oX0Jm5PgkAAeN2pXamqJkdtYtmGLZW4GS8MXpbZrmCXMTf1A2xH5sLKnuxQ3oRXz2jKG7D7UM5jp1hsocPlI/yJ8+j2iooyB6TEpa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740827457; c=relaxed/simple;
	bh=Y1f5ZrdWlv+BNiOBDoeaQwZINnOmNaj7ivJBlFLwoXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJL7rTvLP+YInS1tRMk9M92JW/yFTTaqJaypqTePbhbziRevywbO5PLy47vwNgTiNjLbPU2QBbiqnN0oG7sW8aWErS0/yjn1g+UNvuPa0xZ5kP+kVkkcGSU5bMII9eP1MlmB/egUPFHtRfRfjZg9ujzX/+dqlvWKvLPcnkv5IPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=CZ9TN39J; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E5D2040E0177;
	Sat,  1 Mar 2025 11:10:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3u-IJD7GA1my; Sat,  1 Mar 2025 11:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740827446; bh=BiSU+Q7ZrfwJRrUo70LXGiUrNSCWo21yGEk9PwKhUrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CZ9TN39JBPbtTZ5eEeEUlcUCmId+Boay7JIEaehgfJrmffwTDb8k/bCN414LSOXz/
	 RYZ2p8lQWiXpz8e5Si0p3q/Pi7S8KgQFgxIGsXFIOl8aXV7BJH7QacMxYd8A0qrafC
	 HMvKI3olYS5ZkeYWWS1syNz9sKxvX8/Xl2toIWmTDlP3IZN7IsiTlqOOS/teQOoRh5
	 Q90OJNfLP1DMka37QjWZWkX30D0yBejX5YkzZq8bzMzl5Fu1iixxxcu4WjKIbwFeMC
	 2V3R51HVY7Y8bgcOmQJ555sku1tzxqWDVA/A+HscxVQUmxnmCeWbpvtWuGsYXLDFAU
	 4ZX/+kZIo+n4I1e2XIE8lE+7gFSG1F9aj8gkq38OmuOx/vEPxo0cR3SSWuTyirr2jM
	 xXU1x5sTeSYBqD8nZtkfA6TBbTFF1xSKSJ3qWXzjP+xCpWeCccnQHGH4rL3TJuKz5K
	 kbxrjOTW6rZOUY7EnT0gw3Piw2HYUfAvV9IgScZ+8ap6m+gjbEIPrGkSyosGrpVrUx
	 K3pCWHLbJoHqE/ie9Fbe5kB5np/N6ooNUBpPwWfl1XRapXV2v8w4BY4LZsJI0+whUf
	 njHmnZCZjQNpn4Vg5WN3xVud9BMZ5l/mDV+oobreI2/r4MHLiGCKOd5LiCryb/MxS4
	 bBobDJZjb77Hl7B0dFqaRICs=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5DC4A40E015F;
	Sat,  1 Mar 2025 11:10:29 +0000 (UTC)
Date: Sat, 1 Mar 2025 12:10:22 +0100
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
Message-ID: <20250301111022.GAZ8LrHkal1bR4G1QR@fat_crate.local>
References: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
 <20250217063335.22257-3-xueshuai@linux.alibaba.com>
 <20250228123724.GDZ8GuBOuDy5xeHvjc@fat_crate.local>
 <cf9ef89c-ca91-476a-895d-2af50616242f@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cf9ef89c-ca91-476a-895d-2af50616242f@linux.alibaba.com>

On Sat, Mar 01, 2025 at 02:16:12PM +0800, Shuai Xue wrote:
> For instance, it does not specify whether the error occurred in the
> context of IN_KERNEL or IN_KERNEL_RECOV, which are crucial for
> understanding the error's circumstances.

1. Crucial for whom? For you? Or for users?

You need to explain how this error message is going to be used. Because simply
issuing such a message causes a lot of panicked people calling a lot of admins
to figure out why their machine is broken. Because they see "mce" and think
"hw broken, need to replace it immediately."

This is one of the reasons we did the cec.c thing - just to save people from
panicking unnecessarily and causing expensive and useless maintenance calls.

2. This message goes to dmesg which means something needs to parse it, beside
   a human. An AI?

3. Dmesg is a ring buffer which gets overwritten and this message is
   eventually lost

There's a reason why MCEs get logged with the notifiers and through
a tracepoint - so that agents can act upon them properly.

And we have had this discussion for years now - I'm sorry that you're late to
the party.

> For the regression cases (copy from user) in Patch 3, an error message
> 
>     "mce: Action required: data load in error recoverable area of kernel"

See above.

Besides, this message is completely useless as it has no concrete info about
the error and what is being done about it.

> I could add more explanations in next version if you have no objection.

All of the above are objections.

Please go into git history and read why we're avoiding dumping useless
messages instead of proposing silly patches.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

