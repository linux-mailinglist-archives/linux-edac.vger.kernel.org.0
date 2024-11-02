Return-Path: <linux-edac+bounces-2409-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E249BA054
	for <lists+linux-edac@lfdr.de>; Sat,  2 Nov 2024 14:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38CD01C20A23
	for <lists+linux-edac@lfdr.de>; Sat,  2 Nov 2024 13:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4035018B494;
	Sat,  2 Nov 2024 13:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="E7n/EJPq"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB331AB513;
	Sat,  2 Nov 2024 13:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730553224; cv=none; b=qsPXWMreQD1XatH5r0YGBfkNFhOh38x9L3Y26VVLfx1dOb6ZVsoH47bar/FupK8JXGQLBgKjF2rvgXrKEzFcW9a9MHWD3FoPK2kiLRgF7g5RaLY+8HpF1OZwjLeolGte2exqzgzeOXU5RtpRnft6aRfuyp/J9Av7G+nslwdmKjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730553224; c=relaxed/simple;
	bh=6/65pIb5ndNYa9noe9mOGH7S8Lx6mQcVHE2d7kMkiBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObJVe3q/d2Fg4O9fExUVKn+dWIdrXWPGfFmrrOA9pn274xi4Kk6givUVOaBuUBv9FX0e3XasKJw7eM4fG6iP5Iy7NUGN+8iQjKE9GQmX4FDkC3bZmof56zLPsOZO1Rayf/N7BTiTm8bzg5B+86kpcgk0cNBo5ppt43wVUrAT5AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=E7n/EJPq; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3130940E0184;
	Sat,  2 Nov 2024 13:13:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id KqbIVZ5My0aj; Sat,  2 Nov 2024 13:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730553214; bh=4AkUjEDwanlU2m83/S/nynUi7OpncKP1iwIp29w3Zu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E7n/EJPqZgrsRrl87JyPffnC3Kjfzcwx2pSNWbKys//7hvk9XZu/CuktNiIqqH5y8
	 7P8j1uwwLy+oT0+VRvK2PSlmhMzOTbnmjRq9COXOzo9FuIlY/MmyBCiD8XJD8NZ4js
	 awieL3aBoOzelxNAyCWmNznsYdjY9zB/Qwq+wrtWyH/REhMqnRzaY4+0fucHGK9q/j
	 w5e7+Ipl8Kj+d5LDUEu6bULBgwLqmF2lgqXcrP6JQ4wEVag3SZwchVPQRusKVsRjAh
	 H+JOEYRcFEloOg4ato2s5o9a2KizJn+zb/tHc+haOzedsBS1E6IBu+kfpNwD3GG97S
	 +4lqbFdEBrX+0lDjk5jRjzdKiEYxb8mkBq0mE2zsroHmPwds/NgyRBhPs5MpSQAh4y
	 GL4OP2B1jMWE7Xbjb3+PYT//ExyGf98EttPvZ+OFKxcv1SYFG3eUtHGnLlNmxUtpxI
	 J9mGuFEkWjq6jQ/RjvZcgLYYwTG6PytT58bTKQAFaF2itFiduyI6+pFPIF5ajerBT0
	 yKqs5Vbb9qaTMkpFEYPj5tcCIY43T1z29W8cvWHrQwcyRm5UXY+n6m1iZH/xJhgqHw
	 sTP3ScBVYtTe/iGcjtGTYv947Ijfa+ZPJpMdUAgLvL2RigN4F/bnjGgdn1pcfadoyq
	 8tH6nF+qhxU1J/SJ45eIP3k0=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CAA9240E0163;
	Sat,  2 Nov 2024 13:13:24 +0000 (UTC)
Date: Sat, 2 Nov 2024 14:13:18 +0100
From: Borislav Petkov <bp@alien8.de>
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: tony.luck@intel.com, tglx@linutronix.de, dave.hansen@linux.intel.com,
	mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/10] x86/mce/genpool: Make mce_gen_pool_create()
 return explicit error codes
Message-ID: <20241102131318.GMZyYlbjX0c4q1YEx4@fat_crate.local>
References: <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241025024602.24318-1-qiuxu.zhuo@intel.com>
 <20241025024602.24318-6-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241025024602.24318-6-qiuxu.zhuo@intel.com>

On Fri, Oct 25, 2024 at 10:45:57AM +0800, Qiuxu Zhuo wrote:
>  	mce_numrecords = max(MCE_MIN_ENTRIES, num_possible_cpus() * MCE_PER_CPU);
>  	mce_poolsz = mce_numrecords * (1 << order);
>  	mce_pool = kmalloc(mce_poolsz, GFP_KERNEL);
>  	if (!mce_pool) {
>  		gen_pool_destroy(gpool);
> -		return ret;
> +		return -ENOMEM;

This patch is just silly: the function is not that huge not to be able to see
at a quick glance that it is -ENOMEM that is being returned in all error cases
...

>  	}
>  	ret = gen_pool_add(gpool, (unsigned long)mce_pool, mce_poolsz, -1);
>  	if (ret) {

... except in this case where, oh well, actually, it is -ENOMEM again but you
have to go down the bowells of genalloc to see it.

All in all, this is causing more churn than actually improving something...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

