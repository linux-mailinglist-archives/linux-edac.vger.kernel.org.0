Return-Path: <linux-edac+bounces-3877-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA0EAB16DE
	for <lists+linux-edac@lfdr.de>; Fri,  9 May 2025 16:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4165F163627
	for <lists+linux-edac@lfdr.de>; Fri,  9 May 2025 14:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8BC291158;
	Fri,  9 May 2025 14:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jKvtZEwR"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554BE23D2AF;
	Fri,  9 May 2025 14:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746799728; cv=none; b=rcojiJgaFU+ODW7k35iItf81Xrt0LLvya5UU6+73NZOTN7c2tRwmQNP6/zT7vhHUH5NrMHE1EUSYFq42aekq/EUxCPb7DwO1J3D3mQszSu9eUQ6QG+RfOgNzWpXWqB18RB0uaAu1FcYx4rKSmyMplMTmZjP1A4yilYNa46mkMQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746799728; c=relaxed/simple;
	bh=TT+lpPy+OMdPfeE2RJdWTHLt32F9aq+bILiEC9wSg4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Va+UKoQcaBb09XadydY+qDxvWDN/PSWen7hbXfpn1DZJLBIzg6jBJ1nTS54cRSaFIe012w6HjGmdfgOQwJmzVTyvQQ+JOsfs1Vn/8W6J5LUcvhNFk3fuRGxuqMuSkMrwQNUQj6BRuz9OcJBcBen9Aboz777O2jBuoAKd4KWUhUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=jKvtZEwR; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AE6B840E015E;
	Fri,  9 May 2025 14:08:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YI9qHHUxPmSg; Fri,  9 May 2025 14:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1746799714; bh=TjXS7ec2meU62v5WeiXGJiXDH2QWa1yq0kvc6VuthsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jKvtZEwRcXVHqBJfIuqfg76A8nIMuSYZ5kppwCjOsExoYYfNrrIJQo1SEYabSuWmx
	 9ejzW/d0gLQcHekjE+ajy9u1onLzu22p3itX93Xe4tnuRj/OBgtfw53Qflvp9+1Vsb
	 ATeR47hNFTE/Skn2ZwT1DL3j5rxReHXV6C7dWG9Bm8wLOVvJmjfNqVqS+IebKeUnzx
	 7dZkd0L80PYBeYgQwEI8vXolRWKOR1w7bn5le/1DCg/syy3Ft6Zdnoa6HVNlpxwM2l
	 zi/JpRnks6+KoBhw06+BhCsY0KegLoR7ebULiB2mxJBHdEkvBTPKaJdX2yGbOfceHn
	 UGCxRpQKR7nusOVzhpfJqJI4lVmGxH4qYVJwKXvC5V3nrqwRnD+6+VRJqMHPQUoF9x
	 Y5ViyktyUyrXjyfVasLn3RDc0CFSJq2JxKFEU1jXXzB3oEB71433FAj5lHq/oG3mRX
	 yAWiOHewO+W4SJIAW5ptM8QFh5NQT5aXLx/XLWsvtlrFWUMGQ9lL+O6obXlL4eLTAZ
	 Dzs9RLiHxmTev+0GF2eQjQZseO8a5dxc75L9CADneDdpqfzqm6aq/xQoi/QCMLnAXu
	 Oe7172o1jbizazQrm5lEAfoiKlveIHBPWvJtcradgbD+inaELzNycGqhVEBkP4ITtU
	 T+TzB64bQvxhhnv3NrWhN4XQ=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D2DCF40E01CF;
	Fri,  9 May 2025 14:08:26 +0000 (UTC)
Date: Fri, 9 May 2025 16:08:21 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: Re: [PATCH v3 14/17] x86/mce/amd: Enable interrupt vectors once
 per-CPU on SMCA systems
Message-ID: <20250509140821.GQaB4MVUiLk-a5FWM-@fat_crate.local>
References: <20250415-wip-mca-updates-v3-0-8ffd9eb4aa56@amd.com>
 <20250415-wip-mca-updates-v3-14-8ffd9eb4aa56@amd.com>
 <20250507193539.GPaBu2C_Gt7ksvRHoc@fat_crate.local>
 <20250508155300.GB1939543@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250508155300.GB1939543@yaz-khff2.amd.com>

On Thu, May 08, 2025 at 11:53:00AM -0400, Yazen Ghannam wrote:
> Let me flip it around. Why is this check needed at all?

As I said above, some BIOS f*ckup.

> Was there ever a real issue to resolve?

Not that I remember...

> It seems to me the deferred error updates are just following what other code
> did.

Let's search the web for it:

* https://bbs.archlinux.org/viewtopic.php?id=299379

- silly guests, who cares

* https://gitlab.com/qemu-project/qemu/-/issues/2571

- another misguided qemu...

Aha:

https://lore.kernel.org/lkml/20241219124426.325747-1-pbonzini@redhat.com

the usual virt silly stuff.

> I figure the reason to have the platform give the offset to the OS is so
> the OS doesn't hard code it (in case it needs to change). These offsets
> were hard coded in the past (conflict between IBS/THR), and it caused
> problems when the offsets switched in the hardware. The registers that
> give the offsets were introduced soon after, I think.

Right.

> So the checks we do are defeating the purpose. The OS is still hard
> coding the offsets. The goal of this change is to follow the intent of
> the design. Sometimes we need to let go and trust [the BIOS]. ;)

Look at you being silly :-P

> Now we could update the checks to verify that an offset is not used for
> multiple interrupt sources.

... or, we won't do anything until someone in BIOS f*cks up again.
 
> Let's follow up with the design folks to be sure.

Yah, sounds like we will have to verify them after all. You can see how
universally widespread the trust in BIOS is...

:-P

In any case, whatever you do, when you axe off stuff, write in the commit
message why you do so. Silently removing it is making me want to know why it
is ok now.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

