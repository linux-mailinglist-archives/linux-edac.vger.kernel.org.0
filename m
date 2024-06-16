Return-Path: <linux-edac+bounces-1297-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D087F909E31
	for <lists+linux-edac@lfdr.de>; Sun, 16 Jun 2024 17:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BC54B20B89
	for <lists+linux-edac@lfdr.de>; Sun, 16 Jun 2024 15:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF6D13ADA;
	Sun, 16 Jun 2024 15:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DSsyiO92"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBBA79DC;
	Sun, 16 Jun 2024 15:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718552651; cv=none; b=MXmjeljk79oMW+1bACqpL9EfWIbEB7iJXwnC5Ngo/ZKFgrWXGTFocGvO6UXAdc8d8u2S18J0EiGfo0EI+Wf67UmQ4KCLbraUu+/RBJ2Muya2b+360UwZhPIFW3Wlkne/C8umq44yoBPgmxd3UPqL1Nf4vQod+6aeVsy6DkqqxFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718552651; c=relaxed/simple;
	bh=5J9509OFTzcHXg0xKY5e9qCb+9NQ/M515MoxHsqYDhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pobwi0ZbBE43z2ZkcYOn2qH/fuUaj0/im1IMpLkgD0QeabvdX9GM9+8qBL9xhkl6b/95MYOHXklgfVyfdMti6ECnAd/sMQiHyZKjgWM3VCZ9L1jr90OOEpeyhPnZhoHhCEzXRl0lo0/b6LjA7ASFMWgyWpCaDCuwjrJ6nQ7VjV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DSsyiO92; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4132740E01D6;
	Sun, 16 Jun 2024 15:44:05 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BQB8rDG1Y4lR; Sun, 16 Jun 2024 15:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718552641; bh=cs5k6wCM6WEBXE8GoO5vcyrZNJxaQk9crLc+eqq03Wg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DSsyiO922uLiu8V6vg4kFpQXkH4Yq3KyXfQq7szvqvFQj1/e8H4/Oio/L+KchEt3G
	 hCA94/WdtNUoOiLYXjC8NHInLqHwAJfhZgN2UW+BqavHbD7oAe79V0OVuJ272zxzFP
	 EOyzg6RtkJ9ZBiXmZYlsy48f8Xnl7+qlSaD0ZxAJ4xu1EqJ8nagO6vlv4vqXgNHUTQ
	 lZS5VkwMO++ij1KMxjOXMGvnM322qfIOpGAkY4rvzKUFUSI9Fg5kuYoucdyVoFsTIo
	 qn7mGSXssSwo82zMxksdalDG7ZquOSUkVSHyaeHmWlfGPIPX4Qs1KzuClpXwp4+caf
	 37rfKlFIsi5bj+BLGb4Z8MJHdZBukWYQUsLtubbTcLiib3IDLMHEdu2Dp9XSVhg7sT
	 5ph9d9kz9q8JrsZlNmTei3aO26q8Brgmct8xTGMEXzMUAIeYoAcWT6/uZoVpFfCotT
	 /kcDCshJpiDxtYDsDXcS6Lkg497pm2Wxad4cZYcgZ2v+T3Q8nMKUXTXGkq4xeYGK7D
	 CNR55nSaZ1nfKlw5941Iw7aMqn4a3UNrw6aBocH2dOwR3gpIS1ix8gKQaZtQzTy2/1
	 laIBxr0VGvLGBA+uHZ6KC2Q5vdOM9pHHpyGupzCKZhWJhHkSvIBMIDFfD1xTFvREjq
	 UlL4X3mdzSgFIwD/OFvBjQz8=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4B82F40E0185;
	Sun, 16 Jun 2024 15:43:53 +0000 (UTC)
Date: Sun, 16 Jun 2024 17:43:47 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] EDAC: layerscape: add missing MODULE_DESCRIPTION() macro
Message-ID: <20240616154347.GCZm8IMxshO8YYTTjB@fat_crate.local>
References: <20240613-md-arm64-drivers-edac-v1-1-149a4f0f61bb@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240613-md-arm64-drivers-edac-v1-1-149a4f0f61bb@quicinc.com>

On Thu, Jun 13, 2024 at 02:36:21PM -0700, Jeff Johnson wrote:
> With ARCH=arm64, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/edac/layerscape_edac_mod.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/edac/layerscape_edac.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/edac/layerscape_edac.c b/drivers/edac/layerscape_edac.c
> index d2f895033280..b70d5d258fcb 100644
> --- a/drivers/edac/layerscape_edac.c
> +++ b/drivers/edac/layerscape_edac.c
> @@ -69,6 +69,7 @@ static void __exit fsl_ddr_mc_exit(void)
>  
>  module_exit(fsl_ddr_mc_exit);
>  
> +MODULE_DESCRIPTION("Freescale Layerscape EDAC module");
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("NXP Semiconductor");
>  module_param(edac_op_state, int, 0444);
> 
> ---

$ git grep -E "MODULE_(DESCRIPTION|LICENSE)" drivers/edac/

I'd expect to see regular pairs like this:

drivers/edac/al_mc_edac.c:348:MODULE_LICENSE("GPL v2");
drivers/edac/al_mc_edac.c:350:MODULE_DESCRIPTION("Amazon's Annapurna Lab's Memory Controller EDAC Driver");

drivers/edac/altera_edac.c:2216:MODULE_DESCRIPTION("EDAC Driver for Altera Memories");

drivers/edac/amd64_edac.c:4238:MODULE_LICENSE("GPL");
drivers/edac/amd64_edac.c:4240:MODULE_DESCRIPTION("MC support for AMD64 memory controllers");
...

but there are cases which need fixing.

How about you do them all with one patch?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

