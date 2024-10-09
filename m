Return-Path: <linux-edac+bounces-1990-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC4C997586
	for <lists+linux-edac@lfdr.de>; Wed,  9 Oct 2024 21:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 165CE1F22813
	for <lists+linux-edac@lfdr.de>; Wed,  9 Oct 2024 19:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3071117837F;
	Wed,  9 Oct 2024 19:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="LoX1egWX"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091351714A5;
	Wed,  9 Oct 2024 19:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728501779; cv=none; b=pH4YjeYpHcEOE+rREkhWuev5PgRQBobItbrJGfvy6oE+Qv30c8wBoGyvD+YYMjYoIidlMkolRcLsaCEr3qIGd+OkU3brIgp04D2hivlQV4MT8BVcEWMiTNPxpOWwAm7zMYjVWbzLrPpMQ40uiX3egPRrAYmdTRhwdSX66MjujmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728501779; c=relaxed/simple;
	bh=68MlPt2FmdqlZvjTx3dO1Nr6d8Bi+A3lDI3oCIC23ZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YeLyGLl36uykW9kYfu5BSyIlrz0lUrDfWbrbGkNo3mPlDgjKFIh0tKV/g+wsYQbjJ8TbXzbhm5vQUEv4ZGz11uB+Ije58U4UhvgNTXhWca+seMiHcABeSILwn41+q5kyq2KsFe3pTiywMxRa4XKV7mwMMhoHNJbWn4xdt6VRpZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=LoX1egWX; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AF02140E021E;
	Wed,  9 Oct 2024 19:22:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Qfk0Fl5xrSLP; Wed,  9 Oct 2024 19:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1728501768; bh=8xGJ1I642Bej1YYAfHVN3HEC/SQoBeK/jSb2L/ehR94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LoX1egWX/cKLa3MvCUkvvP0PGzMMdQm4pO5As13C/5RwJtARIeqSZ3z+QQziUoPrO
	 OXBbLAWFf9R+gvefw0N9mNtViF6QXneQD8/NSoT/gqPactVtCdk+S1lnL7hvU2tIcr
	 H2GZQQODp0TkvAna7eNDdDy44+nu68sTIX5KZZa90KnPgqS1NcrD4oIN+BRecZEJPc
	 OSyLtDlgtiWcX+75vhRdry73iZk6J62mkb/XhsEYHdcohQqRdFAcUhtu7tHP6CcKzB
	 ZRiPHgW89HEroEP28MHy8ZzBmWxlRBO9xp+Mh6t6esAzEevo7hjyRpJlBoLszCxx2g
	 gxjnrVD5MQ58MHhNk1BR9VLXiXot+4+lJEC7BLX9qj2A+aUZPw22OX6861ZOfzdimp
	 F8rafzJH0XzSE3snfsGYLk6b4j+VhPYoKtm+sBjO4+zZ6b2UwmD/otceNtwbHKUr2Y
	 nLLYYQZUqDuyAuG8+48CsaD3NgoVtYLUFEoVsUJZctvaUZBtObQsoLy1ig2+oANa4d
	 9Bnyfb11n6mJ90LMFbMjOfBD69PMNHIT4bGtfO17zQY/wjaEWJ3F7hTlOqbPrdLP4V
	 6vHwggHmlsTpsjYdh0Y/HZaIBbn0n/UXSjtYqv4O8YwD85Dpqo7msKsae6lX2pkDLw
	 tO+xkqF4Ck9Yxu5Tb8wv0U+c=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1EBDA40E0163;
	Wed,  9 Oct 2024 19:22:24 +0000 (UTC)
Date: Wed, 9 Oct 2024 21:22:17 +0200
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
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Priyanka Singh <priyanka.singh@nxp.com>,
	Sherry Sun <sherry.sun@nxp.com>, Li Yang <leoyang.li@nxp.com>,
	Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 0/6] EDAC: fsl-ddr, add imx9 support
Message-ID: <20241009192217.GPZwbX6V_PL26Hq6-6@fat_crate.local>
References: <20240709-imx95_edac-v1-0-3e9c146c1b01@nxp.com>
 <ZvsNJrxF6TpUC6ws@lizhi-Precision-Tower-5810>
 <20241002090834.GAZv0Nkp5YKcy86UmZ@fat_crate.local>
 <ZwalsAJdaHjtD1/E@lizhi-Precision-Tower-5810>
 <20241009162038.GNZwatVpTr9rOEyfQs@fat_crate.local>
 <ZwbL7iM2SV5cMb3d@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZwbL7iM2SV5cMb3d@lizhi-Precision-Tower-5810>

On Wed, Oct 09, 2024 at 02:31:10PM -0400, Frank Li wrote:
> Generally, 7-10 days is reasonable frequent to ask. Contributor also takes
> their time and efforts to make kernel better. Why they have to endure a
> questioning

You're asking me about your patches! I'm enduring questioning!

> or accusatory tone!

Where is that accusatory tone exactly? Please point me to it.

> These patches was already takes more than 3 months. I ask just because
> avoid to hold for the another 3 months just because some none technical
> reason.

I'm sorry that you have to hold for three months. I, like all maintainers, am
swamped with work for the next 10 years. You asking every 7-10 days does not
really help.

You're on the TODO list and I will get to your patches when I get to them.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

