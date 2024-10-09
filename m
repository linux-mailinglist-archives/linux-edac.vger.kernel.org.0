Return-Path: <linux-edac+bounces-1988-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2290B997165
	for <lists+linux-edac@lfdr.de>; Wed,  9 Oct 2024 18:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53D261C229EB
	for <lists+linux-edac@lfdr.de>; Wed,  9 Oct 2024 16:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB2B1A255A;
	Wed,  9 Oct 2024 16:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="GEjFQCEE"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D66C1AED5C;
	Wed,  9 Oct 2024 16:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728490885; cv=none; b=J2GPARvsaCIZHeBmx8zwsTarqP1RdP6nAC81mNVfqrUWyhEt6RcQb5/vcZOYj5VsSJeUzVzby/CxXFQMdi1V+FvNF5q0NYsRoa6SMK6GAD3b30Ii/NrbUCBQyVcZodu7z5951F/EAwSB5O7IsfMfTejx6ikS4M8Gfe9+dsnBEPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728490885; c=relaxed/simple;
	bh=Ok9ZtuIgcD+MQaNILCyMh17zxRIUPLnuQH0j3hcqwJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4fG49jR/8oI5FmhjfpdvpYT2y0HeN0wXLYsRXuAqppvmkheLp51HR3meCwbDAezFRiQNLsZKq5H1QpeYQ63biraZhLGIvnuUYV5LpxGBuPqpzPR3QOrPyNZoz04QLRX8uz8wbukFzGjmzw2hyN1tXxWuUWp0Y/yu3x6ZW6BUQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=GEjFQCEE; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D10FD40E0285;
	Wed,  9 Oct 2024 16:21:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id mHKlzqZqGJYT; Wed,  9 Oct 2024 16:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1728490869; bh=bbDRV4m3jwpRnQ+O2uAwiQT09VhhIkvuVjmqabiMkbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GEjFQCEEW0f+s3OboPolT+yyvsB+S7PvMd200t4SmlBWZNzfIXOK/Lwh2XhZkKBKQ
	 wx1/R7FGO8zDMnZ0zRF/+tfsErBhzsXogYsfCZmSJOOow4jx08wNzLvZYOM7vyNWq4
	 kPZoMJ/9IP79foPP3lBleVSBPwLfEpsfyA9UvBhWQbkSp7e0CIkjWoxdILhzQq6tmS
	 v8g6UaY3aPIzS2F/CPoJv8w2ibAVeOJ63AQJZZBdlpc5RunCqEmcOKbyutak49pbEn
	 I3A86/eyI8KaM0ObuuNs6i5A8MZRFQ39FPQUQK8UxuTn7AwJT6QyziIMMPE47eRFWd
	 2QOL8bUpW7qPZL8Rfmniqjan2IgSCjyU/Mg4/Q7bXANE3w3iSnoCzRmt8vcQAImVGf
	 C1CWEysp/9rYn8u0j3HZNE0NPeqK3CXV++xnCovCVKTYJyH/0HNuBSsZYnNfOw28uU
	 cR5NCqt7Ava9PYzmheFz10qJErsrBIqXCQw8JTsu6jjxA4zdhdfvQQBWQD0CoTXM89
	 9KdyoBaQkpj2ckEvif7AOmO+K8gxUsTQCHi5DuRjPYhc2fa1jIpryUi43dAbd0S7hs
	 2vXhaZaiQXBH1E4MghJF8+w+JxuipkttIGQuvstTzWjr5mm0qBz8yemZGD/KhgzE5D
	 fq9QQwRe3AIeYT7SijyTzt9g=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 64B6D40E0163;
	Wed,  9 Oct 2024 16:20:44 +0000 (UTC)
Date: Wed, 9 Oct 2024 18:20:38 +0200
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
	linux-arm-kernel@lists.infradead.org,
	Priyanka Singh <priyanka.singh@nxp.com>,
	Sherry Sun <sherry.sun@nxp.com>, Li Yang <leoyang.li@nxp.com>,
	Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 0/6] EDAC: fsl-ddr, add imx9 support
Message-ID: <20241009162038.GNZwatVpTr9rOEyfQs@fat_crate.local>
References: <20240709-imx95_edac-v1-0-3e9c146c1b01@nxp.com>
 <ZvsNJrxF6TpUC6ws@lizhi-Precision-Tower-5810>
 <20241002090834.GAZv0Nkp5YKcy86UmZ@fat_crate.local>
 <ZwalsAJdaHjtD1/E@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZwalsAJdaHjtD1/E@lizhi-Precision-Tower-5810>

Frank,

On Wed, Oct 09, 2024 at 11:48:00AM -0400, Frank Li wrote:
> Krzy already sent patch remove him from MAINTANINERS.
> 
> Do you have any more concerns about this patch series?

What are you actually asking?

Whether I should drop everything I'm doing and review your patches?

Do you need to read about the kernel development process and when new stuff
gets queued for the next merge window?

Let's cut to the chase and you explain to me what the reason is for you not
waiting patiently for your turn to come but keep pinging.

So, which is it?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

