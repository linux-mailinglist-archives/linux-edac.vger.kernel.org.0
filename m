Return-Path: <linux-edac+bounces-1636-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A9894CC3B
	for <lists+linux-edac@lfdr.de>; Fri,  9 Aug 2024 10:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F0BA1C219A4
	for <lists+linux-edac@lfdr.de>; Fri,  9 Aug 2024 08:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147A216C6BD;
	Fri,  9 Aug 2024 08:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gqCsp/Fk"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4D9161314
	for <linux-edac@vger.kernel.org>; Fri,  9 Aug 2024 08:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723192400; cv=none; b=omnr9mOLwWXLQLG3JZPC4vMLtKLck1hbvNNaOwAEshXBCRLHNIQet2gJMbr/GGZBG1mFl2r3+mdHN8X6YSjlfg0yock+zwkc8IVDtGwUNHQQxRWnMkpF4sd8wfAdveH8a2F9bqilZHHnMajPyyRIXjNUkif61uBfYWOeCJtl/qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723192400; c=relaxed/simple;
	bh=mE+17Cn5vNblXQ91YAYeaVn0oWGpJ+GJVZ/kQ3hcVZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WErnwd0Ax1UdF467uEMnmb11iHieblh1l1DFp5IOYBTXGICG4Oq4Dn9rD0AcBQ4Ox2uO/M/H4v9C3sAZO2s84OYD/VbCsAAj7RRBeplbh8F+HpYYnZh/0bBP2DilXSyZryNIujCQ7MCpqOUWP4TFZ8wRcVBNB6PEU1LQL35bjL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gqCsp/Fk; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E7BF640E0269;
	Fri,  9 Aug 2024 08:33:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Tbamw100d6V2; Fri,  9 Aug 2024 08:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1723192390; bh=mL+0Ufw6+fU09Yd6bywSJf+EsstuDQyFiAfOqpKLYG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gqCsp/Fk2X3Y0KeOYFm5NohZB/FSTIQo/XJn1M3HCNBPsIbhrAvwNZJgDHa+52oRB
	 2u1wLEHXBw9O+Jeq+1zI7x4+OFhSVy6vEf9xvxJq4ZHt+rC5j9Yyl62o877KCJgHSZ
	 95GV5kPHU6Vid6tNeOBleHSZMwNXw/BhiLipiHbtDWJTT+LD7sefOpu4gAZVEnaauz
	 WyGFEUYG2aCTf/MjHTWAJB4VEXsTql/5Ui1Lxz6CGxV+mP9bVyDGrUpSXoUYpHEuGe
	 CzvC04u9ZOhclaS/0LKRwpL0ip8ppOlGh0Xl+kJq7CSzy/M8Lupw4MBHHRZpH8WcNR
	 eyB5ZzuUD0JfHMWKnkR1E+RXcsq7QgsxVlABXjohVh7dcbyxpnC7Wph8nH3GIMbLzM
	 dzt2EHlkb4hmuubKfCUAZX5+qwX+zGBpZZ0zj+DxCipVHI8LVmkW+kgCtWJFv8hTau
	 AKtPhnENFpFnZQ7k5v3dMO41GBB0CCbTVTsRR2P9gtjqoMN4fCe9nEWL+3D52+oQuU
	 d2LmRzJciVgm05SnXbF7FQutRwAHLQJ0oMnKhW8e7DWSO9i/LCn76JEYG4Ju3rajJP
	 b94oxf+pI29MRKbJrE9BFTD3jkkHSzYm6gyr5MAR26lEP4YApNF9c6Tvlci85EJZd6
	 ZrTVX6dBwwInr4LltfKOhUVo=
Received: from nazgul.tnic (unknown [87.120.165.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A25FF40E0263;
	Fri,  9 Aug 2024 08:33:04 +0000 (UTC)
Date: Fri, 9 Aug 2024 10:34:00 +0200
From: Borislav Petkov <bp@alien8.de>
To: Andrew Zaborowski <andrew.zaborowski@intel.com>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Eric Biederman <ebiederm@xmission.com>,
	"x86@kernel.org" <x86@kernel.org>, Tony Luck <tony.luck@intel.com>
Subject: Re: [RESEND][PATCH 1/3] x86: Add task_struct flag to force SIGBUS on
 MCE
Message-ID: <20240809083229.GAZrXUHfjgVcHSZPsb@fat_crate.local>
References: <20240723144752.1478226-1-andrew.zaborowski@intel.com>
 <202408052135.342F9455@keescook>
 <6273D749-9CEC-45E4-8C56-FA3A1DBE1137@alien8.de>
 <SA1PR11MB69926BFE8EFDA7B3C3D84560E7B82@SA1PR11MB6992.namprd11.prod.outlook.com>
 <CAOq732KXwsKdht55E-Z18choiAYn6dMpXc-TD15B7MOUH1fpxQ@mail.gmail.com>
 <20240808145331.GAZrTb60FX_I3p0Ukx@fat_crate.local>
 <CAOq732JV+zcCqgqTbAtVdE+7jYuen2ioG+F+3i5yaBd7Aj8ANA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOq732JV+zcCqgqTbAtVdE+7jYuen2ioG+F+3i5yaBd7Aj8ANA@mail.gmail.com>

On Fri, Aug 09, 2024 at 03:22:19AM +0200, Andrew Zaborowski wrote:
> I don't have a "real world" use case, we hit these two bugs in HW
> testing.

You inject MCEs or what testing do you mean here?

In what pages? I presume user...

So instead of the process getting killed, you want to return SIGBUS
because, "hey caller, your process encountered an MCE while being
attempted to be executed"?

> Qemu relies on the SIGBUS logic but the execve and rseq
> cases cannot be recovered from, the main benefit of sending the
> correct signal is perhaps information to the user.

You will have that info in the logs - we're usually very loud when we
get an MCE...

> If this cannot be fixed then optimally it should be documented.

I'm not convinced at all that jumping through hoops you're doing, is
worth the effort.

> As for "all that code", the memory failure handling code is of certain
> size and this is a comparatively tiny fix for a tiny issue.

No, I didn't say anything about the memory failure code - it is about
supporting that obscure use case and the additional logic you're adding
to the #MC handler which looks like a real mess already and us having to
support that use case indefinitely.

So why does it matter if a process which is being executed and gets an
MCE beyond the point of no return absolutely needs to return SIGBUS vs
it getting killed and you still get an MCE logged on the machine, in
either case?

I mean, I would understand it when the parent process can do something
meaningful about it but if not, why does it matter at all?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

