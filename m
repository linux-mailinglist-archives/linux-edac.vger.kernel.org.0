Return-Path: <linux-edac+bounces-1822-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA9D96DD13
	for <lists+linux-edac@lfdr.de>; Thu,  5 Sep 2024 17:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 171FA1F21763
	for <lists+linux-edac@lfdr.de>; Thu,  5 Sep 2024 15:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1A519FA76;
	Thu,  5 Sep 2024 15:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bU0IpBTM"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D91213C8F0;
	Thu,  5 Sep 2024 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548422; cv=none; b=Fv+bg1Vi4pg+gW/NlxYITVt3IV82X1n9ckCcoR6yPHXH7a2vpdtKYROjzciuYR2YwJjBUwn+NwgbS2MxjnkXxK3Ft6GsMLsSMOlLjrNRgZepZGzp9SQooFwswNS694YoFdsqZvll3NTwwnyEYQAzzss7kTHAvpGcCQnC1KISLJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548422; c=relaxed/simple;
	bh=bnCo/rn97a40j7SezFlC511CH4VQCMOzgpdPx6Adums=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5kBgnkGwJJHADPmD87W79GARmFj+WsrhCyNNjoKTaF0Jax2oh9Q/04qcnH0We/ybBKNgUFgxPjRxQMUfBsi/J3rXclu3PUwV3/EeFopyG+0Z/Shec2GuYj7mzGpnjOpSU8dYhMMiAzlZaUA9Byf6B1Bcn2tpvhXAmMBlPV/wgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bU0IpBTM; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BF25440E0198;
	Thu,  5 Sep 2024 15:00:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zRiLxf_HpXVN; Thu,  5 Sep 2024 15:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1725548412; bh=izxcSifsjm6Enwf2h8N9L3CVMTNiwfjfZrR+OAJBlP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bU0IpBTMDajwBaxIXkUmUftirbn3oa9/clIaBDnR44ePT13fCcc9i60yRyeWsuyvU
	 sTO6rZZ1m/9JvVUkP3QFBOX9TN4py07i8/C1yyTN9jOTWUwWp1ysersH6XKWiLhnbi
	 z0mEM3ajd3jDGNCYv4AhIqYoVizJsz2UBkjjl51wiTnBuTpeTKsrwWgghvSQ3x143q
	 2dWNHWpPozB07DiM1ZPIdVMua7kRxMmY6d0cUX7jwoVkNJkuwlsom1JzgZ3VMinkYN
	 rQ9z8jhzcLDMd2gV6neeDJFpMM2lTlkU3D4ZtZP3iAd2lGNyijihCpt+63ha5RVOuD
	 c4BIWFgO5e27QIY6tnLtSVQF8DSQqXglRae9DMgyUE+Xl9qscWUEUFRlHyE55S+wGp
	 jykzRfolrmcNIAzhrTHQGtTBGlSpBGWHdQmiYDKcRW1SUxn8UG+U9+dhX8cKhOjo69
	 1BvI30LD5TNTTrYpXZComE4C6uNrIjnqLdwo5TZKy9/yLyi0Nwd6w5bF69JhDu4j6i
	 CWDVO1tqYoBFi9qLUqnv2HIxVnhDjQKyjDKbm3bFoZLqODKWCp2mQRBKutg4TWjvqB
	 Zpbjg8sUCjUPlBMAVwdwIQ0l9pcmwTbMYxtbggl1jJiWgmUFIab4f+sCDCcOXlzTdn
	 UCAS8wP1f0mTbiCkjyxg8Kw0=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 31D3440E01A2;
	Thu,  5 Sep 2024 15:00:03 +0000 (UTC)
Date: Thu, 5 Sep 2024 17:00:02 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org
Subject: Re: [PATCH] EDAC: Drop obsolete PPC4xx driver
Message-ID: <20240905150002.GEZtnHchev0n6cVqZ_@fat_crate.local>
References: <20240904192224.3060307-2-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240904192224.3060307-2-robh@kernel.org>

On Wed, Sep 04, 2024 at 02:22:22PM -0500, Rob Herring (Arm) wrote:
> Since commit 47d13a269bbd ("powerpc/40x: Remove 40x platforms.")
> support for PPC40x platforms has been removed. While the EDAC driver
> also mentions PPC440 and PPC460 processors, the driver refuses to
> probe on anything other than PPC405. It's unlikely support will ever be
> added at this point for these other old platforms, so the driver can be
> removed.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  drivers/edac/Kconfig       |    9 -
>  drivers/edac/Makefile      |    1 -
>  drivers/edac/ppc4xx_edac.c | 1425 ------------------------------------
>  drivers/edac/ppc4xx_edac.h |  167 -----
>  4 files changed, 1602 deletions(-)
>  delete mode 100644 drivers/edac/ppc4xx_edac.c
>  delete mode 100644 drivers/edac/ppc4xx_edac.h

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

