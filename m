Return-Path: <linux-edac+bounces-1639-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B60B94DA46
	for <lists+linux-edac@lfdr.de>; Sat, 10 Aug 2024 05:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B32831F21DD8
	for <lists+linux-edac@lfdr.de>; Sat, 10 Aug 2024 03:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5971EB3E;
	Sat, 10 Aug 2024 03:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="dmJVjwxS"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3917A101EE
	for <linux-edac@vger.kernel.org>; Sat, 10 Aug 2024 03:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723260080; cv=none; b=esTyph9fR3ttWR8ads4vY/sW0IFDcNiS8POf4rOHF2DM8g+wdL+0g9T5fcGsjN1jTQc6QzQl7QHNMf8I+II0nLZwjFl0NEcvY6H1N+dCwzQy29+Nbz6+F15EeZtGTHwC4MOjqWtN54v1P7DtnkNTfLoxBCtdp5A/Z9YfgH5XIMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723260080; c=relaxed/simple;
	bh=x49stirWWXr0MCSv/qgO0nUE0IPMTWDRurxV+CDF7as=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umxjhhsyDApuE+XmpPoYO9g0C+fW0AmCgV6vLrzG66D7JBvQHmGIpGepWtCbeJU42BpXNyQejJ7OI6KwLUkl2wfFu59X19aPU8oADn3ZCL4meXifJPy0dy1nWpIJdU2gT1zW2/9nwmNIX1WNSaLYxsXFdZgDEURDSySRZgU+cl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=dmJVjwxS; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CA29540E0263;
	Sat, 10 Aug 2024 03:21:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id aChhZq3rybOW; Sat, 10 Aug 2024 03:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1723260060; bh=EWj1ieL4VaFASgQnFt9FPnrOKju2ddoBf6+jL+AxRwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dmJVjwxSb3wPTXSvs3oXps257Op2uZQlX4caBfXvS2vAeXkxXaGQiRkonq9s6yMvc
	 QTgova5d440avYtiec6QtrOsPmtgQ7+BmSbwGM9JHDzKiLYpVd2eWJcIKYg7BFS51C
	 nNrVlr6dNF6N2YW4JDPFFfF4KSlTsOGgVwfYNwywB+COl7NiB3NTIjUFpnZqxTq5k3
	 wi17hrMHIugA+sLSbkB7aB/L19T4W9YKaiL8oUjl6Vq0DM5jpaDdSPXet/0s518x5B
	 QoyciqxkPOZXn6fn37CiIMerRX/J4ZHY+vHNJFuk44EFvyW1COUr8YeTDGFaO9onfv
	 7gBxs6RP3zBJXPdSNSYppLFULrBOf+hyJBd69aYKvQkM2qNXVIf8yagh45FuG3aP9X
	 pEOh/uvUcrTiqqD5oZiwMJsA6eR9wdLKJ3/8a4YyZvRUcJT9JEbqQ6CG1eVdWAbmb5
	 AWU5OyOTetuty0RTShq1o3KGBKlgBqZ5FAtSTyKr8LV5f/ESeV8NYLSjE/x4K8MKwj
	 nCinz+0DDSFsmtlT8S41T3oD4Bh7AuGTVUppl0C6qva6+XwToivnCzVxzhcbrEsRv1
	 VcvnyCONYPecnQfp30QQNVWpdPGlOVDcua7UiBUdQMf/DmEGpeZ7pMEJEL8Gy9lvWJ
	 aI4AkFlbY0rjihVcfBKBYZto=
Received: from nazgul.tnic (unknown [87.120.165.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 493EE40E022F;
	Sat, 10 Aug 2024 03:20:53 +0000 (UTC)
Date: Sat, 10 Aug 2024 05:21:49 +0200
From: Borislav Petkov <bp@alien8.de>
To: Andrew Zaborowski <andrew.zaborowski@intel.com>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Eric Biederman <ebiederm@xmission.com>,
	"x86@kernel.org" <x86@kernel.org>, Tony <tony.luck@intel.com>,
	Andrew Zaborowski <balrogg@gmail.com>
Subject: Re: [RESEND][PATCH 1/3] x86: Add task_struct flag to force SIGBUS on
 MCE
Message-ID: <20240810032134.GAZrbcvpn_cYzFdEwB@fat_crate.local>
References: <20240723144752.1478226-1-andrew.zaborowski@intel.com>
 <202408052135.342F9455@keescook>
 <6273D749-9CEC-45E4-8C56-FA3A1DBE1137@alien8.de>
 <SA1PR11MB69926BFE8EFDA7B3C3D84560E7B82@SA1PR11MB6992.namprd11.prod.outlook.com>
 <CAOq732KXwsKdht55E-Z18choiAYn6dMpXc-TD15B7MOUH1fpxQ@mail.gmail.com>
 <20240808145331.GAZrTb60FX_I3p0Ukx@fat_crate.local>
 <CAOq732JV+zcCqgqTbAtVdE+7jYuen2ioG+F+3i5yaBd7Aj8ANA@mail.gmail.com>
 <20240809083229.GAZrXUHfjgVcHSZPsb@fat_crate.local>
 <SA1PR11MB69927AE28B46583DCB5C97DEE7BA2@SA1PR11MB6992.namprd11.prod.outlook.com>
 <CAOq732KnHFo3VaRH9V-x0k5m=h1jyNrdtKj4quG8Yaq7wPQjKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOq732KnHFo3VaRH9V-x0k5m=h1jyNrdtKj4quG8Yaq7wPQjKg@mail.gmail.com>

On Sat, Aug 10, 2024 at 03:20:10AM +0200, Andrew Zaborowski wrote:
> True, though that's hard to link to a specific process crash.

The process name when the MCE gets reported is *actually* there in the
splat: current->comm.

> I was replying to your comment about the size of the change.

My comment was about the code you're adding:

 arch/x86/kernel/cpu/mce/core.c | 18 +++++++++++++++++-
 fs/exec.c                      | 15 ++++++++++++---
 include/linux/sched.h          |  2 ++
 kernel/rseq.c                  | 25 +++++++++++++++++++++----
 4 files changed, 52 insertions(+), 8 deletions(-)

If it is in drivers, I don't care. But it is in main paths and for
a questionable use case.

> Supporting something generally includes supporting the common and the
> obscure cases.

Bullshit. We certainly won't support some obscure use cases just
because.

> From the user's point of view the kernel has been committed to
> supporting these scenarios indefinitely or until the deprecation of
> the SIGBUS-on-memory-error logic, and simply has a bug.

And lemme repeat my question:

So why does it matter if a process which is being executed and gets an
MCE beyond the point of no return absolutely needs to return SIGBUS vs
it getting killed and you still get an MCE logged on the machine, in
either case?

Bug which is seen by whom or what?

If a process dies, it dies.

> In these tests the workload was simply relaunched on a SIGBUS which
> sounded fair to me.  A qemu VM could similarly be restarted on an
> unrecoverable MCE in a page that doesn't belong to the VM but to qemu
> itself.

If an MCE hits at that particular point once in a blue moon, I don't
care. If it is a special use case where you inject an MCE right then and
there to test recovery actions, then that's perhaps a different story.

Usually, a lot of things can be done. As long as there's a valid use
case to support. But since you hesitate to explain what exactly we're
supporting, I can't help you.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

