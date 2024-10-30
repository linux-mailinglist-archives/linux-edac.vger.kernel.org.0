Return-Path: <linux-edac+bounces-2343-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 632C69B6257
	for <lists+linux-edac@lfdr.de>; Wed, 30 Oct 2024 12:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E4BC1F21486
	for <lists+linux-edac@lfdr.de>; Wed, 30 Oct 2024 11:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960D61E5723;
	Wed, 30 Oct 2024 11:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="QKgiv0fm"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859191E572E;
	Wed, 30 Oct 2024 11:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730289229; cv=none; b=Ct+DgAssog5DSim3QBJy4Io0YTCZmKSmCn/fqpmxegiS04fYy6voKKOGFXGMAvtF+Ub3kgPiIJcP2qZpTYCz3oesM5/D3xRdJOO0mAa4t27qeaTXQW8s8rabZT5qKpe761slmBqJyhkBefBmVIt8AFjS3PyAM1ezEKIj01n8Wh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730289229; c=relaxed/simple;
	bh=mVDCoFWka0cDCNzavVR/DBPbCdODScXLc1aExcFNkvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ps91u4ehIZ47OUcS4vYZcgxFFrfn7FyJwsm2Yw6T47l9mEqDPxT+g8ITqKx3USG1EbfLy432SnPQjiItgB3NLar03I1WhZrRqmVfmFJgudk7iNIUOiANQUOWhDlyzUeo6+dChb78WKu/ebEq73dS/6CgMHVl0tsqqf2j3cdYUsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=QKgiv0fm; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 59EE940E0208;
	Wed, 30 Oct 2024 11:53:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dcQiH4xAIOwM; Wed, 30 Oct 2024 11:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730289219; bh=nyIL7XvIq62okOAaDeM08lcSaEjVO1a3J5nnJHbF0Y4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QKgiv0fmSCIbUe4yE0/0g/qnL0gZE80cQUYWz9p6g26bzNaES0jOowIKXsWMBoo4E
	 MgH0ZmWT6Ybcp114Cq6Y8KRrApMweqo5FLJ1izO0xznQY9WGMv3o7xmt4aKGQbI3n/
	 IK9p4+keQPFwNZc6UmI5bgWmpxWXWspwHA0uYhCSTLR4CTEQx+YGex0G7pN14tH8lV
	 QnQpqRfkmZVn/MgXJJczr2UvvAl0CeuL4FXX4lb3D3lnYGnYG8sp3dwsYs/Lrxk4qi
	 yWOd1mC39xxWPrKiqsE4zxhVljsE2401dsOH01dT9BIdUa1KBuWflumVuu/vZpW9QP
	 iQHpM7vKre5aTgi0AFIustFsud/neJKoi5lRlO4fhDIpPQBUPYc+F1amw7D2DBU14K
	 RvfTk4J9RfD2xKJXBciVjRLRGmt3MPA2hPOudyYzrzBlZyoy5BjVUj/4aM6oBNQsuB
	 osXvx0Gen/wMHvPvd4MfIT8Er1ZEp53kClJU1KtMGEpB8GqbliS0KPKVQmuHtLhcar
	 DVpXt2dn/v7UNenNj0n8rXB1Z1US15Wvu7V3vGCkvlG76gSgXtPfnTrGLPDgTkQzty
	 HqPCrEGN2vU4EW42TLy7odCismejrOitF5zgzNPru3q2naZmXzSyflF18MY8PhJBje
	 SInFGyTJUFape6xG3MILzVXA=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AA81A40E0191;
	Wed, 30 Oct 2024 11:53:29 +0000 (UTC)
Date: Wed, 30 Oct 2024 12:53:28 +0100
From: Borislav Petkov <bp@alien8.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>,
	imx@lists.linux.dev, York Sun <york.sun@nxp.com>
Subject: Re: [PATCH v2] EDAC: MAINTAINERS: change FSL DDR EDAC maintainer to
 Frank Li
Message-ID: <20241030115328.GDZyIeOEwKGi586acR@fat_crate.local>
References: <20241003193348.102234-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241003193348.102234-1-krzysztof.kozlowski@linaro.org>

On Thu, Oct 03, 2024 at 09:33:48PM +0200, Krzysztof Kozlowski wrote:
> Last email from York Sun is from 2019, so move him to Credits.  Frank Li
> volounteered to keep maintaining the driver.
> 
> Suggested-by: Borislav Petkov <bp@alien8.de>
> Cc: Frank Li <Frank.li@nxp.com>
> Cc: York Sun <york.sun@nxp.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changesi in v2:
> 1. Switch to Frank Li, do not orphan the driver.
> ---
>  CREDITS     | 4 ++++
>  MAINTAINERS | 3 ++-
>  2 files changed, 6 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

