Return-Path: <linux-edac+bounces-4599-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C732B287E7
	for <lists+linux-edac@lfdr.de>; Fri, 15 Aug 2025 23:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A939166897
	for <lists+linux-edac@lfdr.de>; Fri, 15 Aug 2025 21:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC8D26059F;
	Fri, 15 Aug 2025 21:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bYzmAyX0"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA1925DB0D;
	Fri, 15 Aug 2025 21:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755294028; cv=none; b=RdWP0PDXMxxYFx5eXNdNY9XownX5gmx3PPa9wHk59D5wCKDppnnW2CcBZcUW8CZqgZIqHvTvUb7Pqld7kvgQ5fmQV2WO1ZgTeNAh/VxMB87dAn4qon9sCpjfAf12ot+8sCDR9xbNarAnOAN7zTW45MEN/VXN6pgSkLmZguTFs6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755294028; c=relaxed/simple;
	bh=Kz5awZAkv2YD8wFJHXT86Ks9LAGny5DKjG0LKo2prwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4Ck+GZHCCpz1zCWoilrG1CYUaMs3M9Uihr47UXT9ey6umufYWxdF6IMz04hi9i/Ve8c8OfAgL7JTJzRsJWGJS4GqPjsevKUNfnpolYdcU/cWV7HBtz3z5VBy5PgFgcbwFJ3eSDZiGevLn4LpI3mfe2UuJpue2S9ZceG72/jtgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bYzmAyX0; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0737D40E00DA;
	Fri, 15 Aug 2025 21:40:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PdTgR2bIKi-Z; Fri, 15 Aug 2025 21:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1755294018; bh=sYVcs6nOzvmVwfS8iCLy10NycA/vpvuTnA3nbJODvsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bYzmAyX0c8k3r7yfMt/N01mnJMH4JK58PhVedhvq0+rNIxdfwZ3GT6xNym90w0bnX
	 KxrQ6JRer7nSDyJm2pclAQWh3x8d1D/VEgK4jrRbReFOrQDZmFTDbuiA4MCarN52yR
	 oGiZ/RMyDq0vl9eAOAcAuMEaPYQ51jc59GrGGi7h3ayuhYtjyF8qxGj2bUq+0tTZW/
	 wPntndPfId7i+OQ6FEXqwBDowowqZSHuod5o17JuCU8Q1AfIYQVl85m5VrE7kzvTX6
	 1ZjN+w00E0vsm3A8WvaNR7JyHSqh9/TxOyxBRpsz4Unt3znnrW/h5zoRyKAOU4Urvg
	 ABqTt2/EXXjoPF0Q+7DYpNiZDQsh1peIBa1GxTvtZi2lmizGA4qD/0fmUGUCXMH7s3
	 cjzMIcUPgdDF/3Wzx7T1W/JUvzY6JLrVbQbse7HDbMWX2V/QH9WA9aEnVQMM5yjYrS
	 SFUSqSqmtyYdY+Pl4/6kRLxjqnFI7UiCJYH9IehD3R83yNHwwHWqoSC8JnBAh2aEv1
	 2fmnikZ3kuNCFn55vnks8MosKvMmEUu7+CROW2n5HzqO0K6XlZQBlV7rlZJNA1T1uS
	 8uF96nzlOAPVZSjb/kaHL9lSz6vyuZNKxy+JW5q7X6zrIr/qTcvrnCxTyvSpP1MYFc
	 OkGCo8F9QGvRjxkBwXM6qdsw=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7485340E0176;
	Fri, 15 Aug 2025 21:40:03 +0000 (UTC)
Date: Fri, 15 Aug 2025 23:39:57 +0200
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
Subject: Re: [v12 PATCH 0/2] Add L1 and L2 error detection for A72
Message-ID: <20250815213957.GEaJ-pLa_GupE3DUfj@fat_crate.local>
References: <1752714390-27389-1-git-send-email-vijayb@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1752714390-27389-1-git-send-email-vijayb@linux.microsoft.com>

On Wed, Jul 16, 2025 at 06:06:28PM -0700, Vijay Balakrishna wrote:
> Sascha Hauer (2):
>   EDAC: Add EDAC driver for ARM Cortex A72 cores
>   dt-bindings: arm: cpus: Add edac-enabled property
> 
>  .../devicetree/bindings/arm/cpus.yaml         |  17 ++
>  MAINTAINERS                                   |   7 +
>  drivers/edac/Kconfig                          |   8 +
>  drivers/edac/Makefile                         |   1 +
>  drivers/edac/a72_edac.c                       | 230 ++++++++++++++++++
>  5 files changed, 263 insertions(+)
>  create mode 100644 drivers/edac/a72_edac.c

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

