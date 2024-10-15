Return-Path: <linux-edac+bounces-2082-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BFD99F257
	for <lists+linux-edac@lfdr.de>; Tue, 15 Oct 2024 18:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D1E81C20987
	for <lists+linux-edac@lfdr.de>; Tue, 15 Oct 2024 16:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C611F6662;
	Tue, 15 Oct 2024 16:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="PjZP+RiV"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAC11F4FA7;
	Tue, 15 Oct 2024 16:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729008600; cv=none; b=U2YAAXo/ozzkRvEoYq44xc4jS8z2SEDlfVN/Hr7y8IxU1ynfIEPXt/8dthLQu4OZMyQkB1IkbE0edgfSzmfHXcLCFKqMPgQlrS6V0v8SVkJK/zLw2H4Q3cEKp+eJxlrGEexvUrQKylxFXolpdJUluoixm9NsuKJfAo10+pfeOis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729008600; c=relaxed/simple;
	bh=J4VTQJ1NLVLgh7XcjAsQLSHdH78+MgqnIqovjWPlaJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XpSYdF4WYpi6UpUwAXGZPYwx84XY8nz8tDNquYyjoZRmPzZUxozulS5ShdGPCUGvTV2nPlGF3BCe77SctQH5tkbNdXMrgN5I8084eoTg0k0+6Q2GVxdE+g5YwNyrGgVNnXYZNpwdT8zMK7Y6VTeEdQzBcCIiHiUgEt9Jd5VgGxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=PjZP+RiV; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0FA5440E01A5;
	Tue, 15 Oct 2024 16:09:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id iyw_ZyN03Y41; Tue, 15 Oct 2024 16:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729008586; bh=0ACTaEqDOJk25us7DX7NyLMS5zpdolAfD3J9jJAXmK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PjZP+RiV4ak6IXFCThVYfty6P9QPAVorGOaThMZ5Oys0axaDbs6Yz5OtKu1EP1e7j
	 0WCMAPVdgbWdf2NmwrwTtsYKKSJwy18DRh1tB2MskQ7NvTE7zIvKcLPzCmoLy2beKJ
	 y2SouYs1/6wtqQnJpsKQO90fIk/UnCAiKdRzrS5tt98GvFZyXwHv+ryvpOV3F+4HwF
	 Wpvhqw9QlkR9vSURnVcjNgcPmi/fFXZans5TjQCF5Ri1mAX3rH3Akechk1Wqb59JEB
	 cdDwmac0vDEWxvAxO7Vs78EZXvFH55/u5fjxeTn6J1fYaxeB27Z6+5e10uOZXjStTs
	 s75IBvJqzrEA6wc5r5R2vgE3wajvcYAQHlwgWFHdvABmP46GOgQd/pKZGgTvwu3gq9
	 N3OqbT0PUE+d3IG+LlmUlPc/ZMZqc1WMlXvyseur9Q7Xnk79QL7JinZSyjanTQqsBd
	 ExKilHACYzrlp/T3PNcTANB9Li63qYJYo4VKC3k7pKEZ2fmE45UPk7xc+4187ddDmI
	 zWUqaJW1yn9pFyNGEkgLameLpuK3FlcbISrUApYQ9zqXbSBkghK9tOrj9xLN0ILtB2
	 0Mdb7D2V4jcZF1RRzGuDjJmoXETRjyIqu/5PvafqnklOW1QNjYY79rFhwsMXOWQ+//
	 5/tta4m4qKyhwuw611Pr98c4=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C8A3A40E0198;
	Tue, 15 Oct 2024 16:09:23 +0000 (UTC)
Date: Tue, 15 Oct 2024 18:09:18 +0200
From: Borislav Petkov <bp@alien8.de>
To: Frank Li <Frank.li@nxp.com>
Cc: York Sun <york.sun@nxp.com>, Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, Ye Li <ye.li@nxp.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 5/6] EDAC/fsl_ddr: Add support for i.MX9 DDR controller
Message-ID: <20241015160918.GDZw6TruESOa7_4pkd@fat_crate.local>
References: <20241011-imx95_edac-v2-0-011b68290951@nxp.com>
 <20241011-imx95_edac-v2-5-011b68290951@nxp.com>
 <20241015145234.GRZw6BsqnIbaGWMzG_@fat_crate.local>
 <Zw6IDnkVbN6aErTc@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zw6IDnkVbN6aErTc@lizhi-Precision-Tower-5810>

On Tue, Oct 15, 2024 at 11:19:42AM -0400, Frank Li wrote:
> I base on linux-next: next-20241010.

Found what the problem is. Your patch 2/6 was in my spam folder. And that one
removes those variables.

> I can rebase to edac-for-next
> https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git/
> 
> Is it what you expect base?

Yes, please.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

