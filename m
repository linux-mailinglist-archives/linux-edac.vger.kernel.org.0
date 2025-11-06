Return-Path: <linux-edac+bounces-5360-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD1BC3A79B
	for <lists+linux-edac@lfdr.de>; Thu, 06 Nov 2025 12:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 99C7E346E24
	for <lists+linux-edac@lfdr.de>; Thu,  6 Nov 2025 11:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5900D2E6CCE;
	Thu,  6 Nov 2025 11:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Qkc8phe+"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA3E2ED844;
	Thu,  6 Nov 2025 11:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427525; cv=none; b=r5+MKoS3EaNeVfMHWOuFA6bx4p5Q0ahO3UTOGu4nn98L/q0IhyyeE/3CR3XdzXnivXRl2am3v1sttHDZ9l7l4xEB8+Xyxk+qcexmPjBrr88o2+wmcudbv9MD51CKV4JX6qJjnJUVVyktNrGDn5ygBxzg/eomTr+d+5vdyWvCXjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427525; c=relaxed/simple;
	bh=czyXdXXWmjg/tiDY4PXrh0q7V74xDEYo+JnmysKfTHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvyJJOw4TtxoIQ1laTd2lvWhX9tmZ6XMXPUskMwg9Lt2bWmFqv/zcUovn3NvdPEnU+LYNB7b2BSV6/DOCAJI0WsR9gC3VMCIhA26WnrasHvBOIJmq2tN9MCBVQRyU3bVAbP+iZS+ilZAyPg925cERjn1McxEiVdYtkM4UmxB2oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Qkc8phe+; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 090F340E0191;
	Thu,  6 Nov 2025 11:12:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id elOWLK4SqfN0; Thu,  6 Nov 2025 11:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762427514; bh=Goi2t3N7o7mLy6ON+glL1xS2AHi8Qhe2u0pKZJ0kxxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qkc8phe+0uIsqLfrlH0nhpXxdZ22YSC9KpK8/au5bMzVDOG2jFAt2WeUKtq20ZUao
	 Bt29JShk9i5F7Ziw1uUfxxoNx590jdd0q80Jy0c6r6JKfDB+GSvsXIIeOSo/8Xd2wn
	 3cYAO5eWTgUxO/7bAorEZOr/RzsfuDFM8Ec+TKesRqhsXS/l2w3AZuflOTHyAJiWza
	 zhcZLLuxDQzAgamAPk5ckdET+4Cmw0vohWqme7gHjSGFvEaR/dzZVW0x8pjhz6T50y
	 dk1njnl4orHsBZ1Gg5tGO7RcwCDzpOgcXtKKPCXClxq4LimIzB6VdXt5bE1L/L+bQU
	 x3R0VuzqvJkFdLM+VMkvpG4DzBLuiJxAuQFWCfZ9JJM/CpAdwEyCaYfzL1wll6tJK/
	 U9J+0vPl26pcsixAZ7PVlQ87Ej4pHTK+TlmMPwj9fqcFF5GvcNrWIdeH7bg+TRFkXQ
	 m1I76yu2Q8spJ25YLPl74qXmRSOuyhV2CF6AY6ZW093Cra15R3t78QlsOmKx9KTic0
	 gbz7SdFSxuzUAJWexzejy19xSv7RswekFyZussDYtgAI0YdHy2OweIpx6ytBhU5FWE
	 cpT3dO7MPQ+bp7aGrxa+s7zd3edW2XPV0R+3ACCeRFrU4DMvc1N2m+/3hMUkKnWF9B
	 B1eRCB/NK+j/tWx4cB0tAXas=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 295A640E015B;
	Thu,  6 Nov 2025 11:11:45 +0000 (UTC)
Date: Thu, 6 Nov 2025 12:11:37 +0100
From: Borislav Petkov <bp@alien8.de>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] RAS/CEC: replace use of system_wq with system_percpu_wq
Message-ID: <20251106111137.GBaQyCaXz4RBMNsULJ@fat_crate.local>
References: <20251105160819.302988-1-marco.crivellari@suse.com>
 <20251105162932.GAaQt7bON4FtSmxQ3Z@fat_crate.local>
 <CAAofZF4fBbFtiKxde2M2ikK4k-LqYVRoavPbNVh-XFiQPmfGvw@mail.gmail.com>
 <20251105210800.GCaQu8sKCjZ9Xcq8-n@fat_crate.local>
 <CAAofZF4Sdk0REJFearcrB5_MLLQZWaNpecUPV0+BOiNcvmTaWA@mail.gmail.com>
 <20251106104921.GAaQx9MWLfhyqHNDYK@fat_crate.local>
 <CAAofZF7cz_F9qgr7WqbORwH5iMuAO9f0SkWRQxQ4ns4o2X_xJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAofZF7cz_F9qgr7WqbORwH5iMuAO9f0SkWRQxQ4ns4o2X_xJA@mail.gmail.com>

On Thu, Nov 06, 2025 at 12:03:51PM +0100, Marco Crivellari wrote:
> I was torn between "replace" and "rename", because there is a new workqueue,
> not only a rename of the old one, because for now it is still existing. :-)

You can also say:

"Switch to using system_percpu_wq because system_wq is going away as part of
a workqueue restructuring."

Now it is perfectly clear what's going on.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

