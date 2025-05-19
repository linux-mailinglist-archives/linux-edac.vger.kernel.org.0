Return-Path: <linux-edac+bounces-3937-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF68BABB81B
	for <lists+linux-edac@lfdr.de>; Mon, 19 May 2025 11:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF02E7A8421
	for <lists+linux-edac@lfdr.de>; Mon, 19 May 2025 09:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB0026B953;
	Mon, 19 May 2025 09:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ibm3iPrf"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700D426A08F;
	Mon, 19 May 2025 09:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747645405; cv=none; b=Gfw8tcyCbbMJ3UNuOQ1WoeNBinySt2MsiRcofwiEoR8N+TNJE/pqADqneyPpn+8OGsp8eHMXEkrbh7oalKHUfKIZeXCUIcP7Pu3IBswX6fbG7HyHBXn3tP1l8TAvy6/EQK/RN4gYGsAdYTt2vMc2bRjZN0HPDSonlT2kZ0ExOhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747645405; c=relaxed/simple;
	bh=Q0d33B7LltNYTMr1EFERK1drpt83+vRo75Ctu5wGK/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULIqSGHWH+0MJt/wvnkvViM43RJ/9Qi18CM+4lPty2cS9tsPG0zmeAkRtvYfcTyBX7SUrIEjWlS+VN9YTpzlcg7o+mTybUhVo6UxsC9LfxzJhEURa82iJzoFTecuvAYaB9Vz926hIExWR6VIBGcKlQMzZ7krnQL5ZaOF45HerZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Ibm3iPrf; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EB1DB40E0238;
	Mon, 19 May 2025 09:03:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZakdgiBD3fyG; Mon, 19 May 2025 09:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1747645395; bh=XSJKeqsewpMLjP2mpO7y1TCFtUmCP7ECs0qYu3wgVlk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ibm3iPrfGucuXaK7YPUg9+eoD6uxCJt457GixK3I2XtVOXrNXdWz9MQJjnwmc/sVi
	 xriWnk7aTHV5Utr4FDVghTov+tfkofGSuAgpVbZJMfMrgCZHWZvLxmznJa5L/Ep528
	 QHJx2MrzTr/zcH6G1wSagFG6crasICqIsiWzm2ICQslJSe1coJwrw9R+yEMhX07ZAd
	 2IacR7XclHna11tlqENmswpqAzFlF5EoCCJ+L7dMhuAzYjj/ACZG7zjBtU7Tip6IAL
	 v5EdV4M8q90VFNvUwI5cIfOhJBoiIg0KIBVFuU7BzeKHHbsh1+lf8FYxYfLAyG/JPV
	 RNvpt3lXxPs0M57f+PxCXmhZCkjZk+zrhSbsENtnRhvItUlmSlSc/Crq04TMnL4Pdb
	 1zXxFO2abvv0X4vSsZv9hJGtIR4uMZLMBA3NoRSSdMxJEWLFO5K1/PP+tORv4Opbo6
	 3AUZleo8wQ25qiCSqxof7AEP1uIcqJfPeE/mLtu0w28+Yv68eNYrcujx/pN7GJK+t/
	 GEIyyRZK6NAjBv/LQQ/UBg8sr49xfGuh5KYM9fiJPUr/34IUifLl6g8jYJT/IiIFkc
	 FFEtoruUdF6UDXP2F6d1EYe5B9YzzcJYejxt9d7JERc8RTeh7h+Hf6mOEvZDfhzfT/
	 SKx4wp5FbcQKqMFG8wZ6XM7o=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 62AEA40E0173;
	Mon, 19 May 2025 09:03:00 +0000 (UTC)
Date: Mon, 19 May 2025 11:02:53 +0200
From: Borislav Petkov <bp@alien8.de>
To: Vijay Balakrishna <vijayb@linux.microsoft.com>
Cc: Tony Luck <tony.luck@intel.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tyler Hicks <code@tyhicks.com>,
	Marc Zyngier <maz@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: arm: cpus: Add edac-enabled property
Message-ID: <20250519090253.GGaCrzvRFC75JnFN1S@fat_crate.local>
References: <1747353973-4749-1-git-send-email-vijayb@linux.microsoft.com>
 <1747353973-4749-3-git-send-email-vijayb@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1747353973-4749-3-git-send-email-vijayb@linux.microsoft.com>

On Thu, May 15, 2025 at 05:06:12PM -0700, Vijay Balakrishna wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Some ARM Cortex CPUs including A72 have Error Detection And
> Correction (EDAC) support on their L1 and L2 caches. This is implemented
> in implementation defined registers, so usage of this functionality is
> not safe in virtualized environments or when EL3 already uses these
> registers. This patch adds a edac-enabled flag which can be explicitly
> set when EDAC can be used.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> [vijayb: Limit A72 in the commit message]
> Signed-off-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)

This needs an Ack from DT maintainers.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

