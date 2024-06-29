Return-Path: <linux-edac+bounces-1437-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8123491CDA7
	for <lists+linux-edac@lfdr.de>; Sat, 29 Jun 2024 16:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EF511F22273
	for <lists+linux-edac@lfdr.de>; Sat, 29 Jun 2024 14:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D7080C15;
	Sat, 29 Jun 2024 14:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="E0gCzjp/"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE721D52D;
	Sat, 29 Jun 2024 14:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719673070; cv=none; b=dHdij/IsoUqNb5qls/1mSG222yP27nxNRc+UgMYxkpXKCLUrGk0I9DCLVwqBSOBM5+m9MjXOGbSHI3yGln0VOa0MDxV8bViaJ9e2Fjtcw0cdXAvQ9FvTI6uK+FwwZZk0orHRHWKcE8gUTOEIRa+lrzbMHbhtVXEOVYe9oe9ZCHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719673070; c=relaxed/simple;
	bh=5KUqIH8oR9S8Oul/SubmquGzNQYNYip/VXcm9bSvXZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtwJr7yPK093xu/w7jmVfSwglB6rMua2jymTM24jUH2l3yuJHKfDuqN9BnIWvmnN7H/KRb0woAb3k8tirvhyxNhf3PJ1WyUyzqYlKsl8tq9CDLLMrJdmmTPjv2waptEK7Lu/tj0DZo0dboRp96t3Z38LV+t62FBLwj0y9E0FyOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=E0gCzjp/; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E1A3640E0219;
	Sat, 29 Jun 2024 14:57:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jaKAkfwgC1lf; Sat, 29 Jun 2024 14:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719673062; bh=eidaWZkQ9zYvGZvDZWYlfu8Wo1BVtlIeu2FB1QuEbwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E0gCzjp/3skB/ErRfxBOVZllAN4DK5yql8V+4ggu6UhPAPEaVDGZnZdLPHS3SNdMx
	 JTWj2fITRlYa9BO0Zbz7kvZYvALscohUyukiWtlwRmJa0/KIJds3Bi46ZBTchuiRFn
	 BHIJzVPjMYnZdCNca/X33kKqq/qt0DnwKD7EdGBRtw58lMJ8XwjJ8Ji5s+km0fhUH7
	 L4VUMOE0cbY6FlUM90vMiXywEWVohK0WFrmi3AV3rPsJfaOmOw++GOZ3AXNNGKuVBa
	 drrr67hn0k7tVfz4wQFZCI1xEPYGlHdTGj811aYt6/IIjNeEq37qz9v6RSK1meYyf4
	 J2y7+KDewXmXKigV74wmde7/fAOm2AAzZiwazJAovONt8Hfxc8edP6Y7KqgeZG7wzM
	 0TuSOlTxMw4+3PNiDadZZllYBI0TMmzgZ7H8ojqGkcHmoL79KoTJszuerghjZBKjc0
	 qHkl3/mqhS2n4tb7r4/dLQWhDetJ3uzfps19bDn4+zpwd2OFa0Y1qaBvKASKj4vCSd
	 jrFvn/RE89YJWZFjPfblETWIpaO7dWFXs+8Cf2nk9KMglVziYkzE19fQ0yWVKIASlM
	 dSNm1nkyIDXXmVYOpiVye/F40ESyDmSOliIPVrtLKmH2pExHEcoKbGNWEeAHoXFntP
	 U2FgEgJMCEGl9gqsU66PtVqA=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DA09440E0027;
	Sat, 29 Jun 2024 14:57:30 +0000 (UTC)
Date: Sat, 29 Jun 2024 16:57:25 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Johannes Thumshirn <morbidrsa@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-mips@vger.kernel.org
Subject: Re: [PATCH v2] EDAC: add missing MODULE_DESCRIPTION() macros
Message-ID: <20240629145725.GBZoAg1ZqBWQmJ2_FP@fat_crate.local>
References: <20240617-md-arm64-drivers-edac-v2-1-6d6c5dd1e5da@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240617-md-arm64-drivers-edac-v2-1-6d6c5dd1e5da@quicinc.com>

On Mon, Jun 17, 2024 at 12:53:52PM -0700, Jeff Johnson wrote:
> With ARCH=arm64, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/edac/layerscape_edac_mod.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro to all
> files which have a MODULE_LICENSE().
> 
> This includes mpc85xx_edac.c and four octeon_edac-*.c files which,
> although they did not produce a warning with the arm64 allmodconfig
> configuration, may cause this warning with other configurations.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
> Changes in v2:
> - Updated to fix all missing MODULE_DESCRIPTION() macros in drivers/edac
> - Link to v1: https://lore.kernel.org/r/20240613-md-arm64-drivers-edac-v1-1-149a4f0f61bb@quicinc.com
> - v1 subject: [PATCH] EDAC: layerscape: add missing MODULE_DESCRIPTION() macro
> ---
>  drivers/edac/layerscape_edac.c | 1 +
>  drivers/edac/mpc85xx_edac.c    | 1 +
>  drivers/edac/octeon_edac-l2c.c | 1 +
>  drivers/edac/octeon_edac-lmc.c | 1 +
>  drivers/edac/octeon_edac-pc.c  | 1 +
>  drivers/edac/octeon_edac-pci.c | 1 +
>  6 files changed, 6 insertions(+)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

