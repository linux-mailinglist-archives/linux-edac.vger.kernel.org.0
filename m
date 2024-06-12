Return-Path: <linux-edac+bounces-1271-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD31905C73
	for <lists+linux-edac@lfdr.de>; Wed, 12 Jun 2024 22:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A29D1F24A3C
	for <lists+linux-edac@lfdr.de>; Wed, 12 Jun 2024 20:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A167183CDA;
	Wed, 12 Jun 2024 20:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="QNAN/pF1"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B56412E61;
	Wed, 12 Jun 2024 20:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718222480; cv=none; b=qvlONOfpn7gZxrqSK9WsX8xSP9T/W9VL6Hx0+a1zFPicWqFO23rOq2XgAi24iOpRVPFqdP42CLGQykqqeseFKuwS1m4bJAWfbmvO64rB709ytKsO+3ul1tf/VGbI8vvRctyNKa015Tbdm/Yqn8Quz6ATtl4CerXKfd2tMU8nVgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718222480; c=relaxed/simple;
	bh=7OyQ3rFkewMNoKXLLCpqRc4pn0D0NK/EKUMpItvjHOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+EVVmuVuEZsSti4X+VX/rbQ8IqfVirnMq6anPtxX1isqRz6HxCevUpwAygH+Z8V+79hKlBncl3fAQkWXtUSn2+4klNswkG1Ua8oeNa+QosojUXUuEzt2q9PfuhFa+ChwdHOYO2d8gqd9KixR7b2QJXBkrN5JvDMUrrSCavw9do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=QNAN/pF1; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C006D40E016C;
	Wed, 12 Jun 2024 20:01:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bwaUVT6yOVHN; Wed, 12 Jun 2024 20:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718222471; bh=eofNYV0tt5LQVQJm8Gzo1T+sEAzPcM96k4aJGffrnrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QNAN/pF1v1x5lbI2pQQD1zc95VZB9pTIS3GbdQOtZpiyhljDlMljKnOurEm1Ze8cI
	 MNmW5LSS6XH45qXjO36irfFfScgbefOf0E2XKiAKNMP6f+0txcrNAgT6FVo3YC3ANp
	 6QDAyUN1EOWInLRR18eSGrJBDQXOSRJUSuNCWcJ9YVUSWLWNOv03dH8026eHoieZ3i
	 vjZDtzIPFQoAPHpierCMVlFrc3JZaMkdiCvEeavAHQPb2gdBwq4iwb0ocKDusC1bzO
	 s/81UlgR+pOCB2N/UiiX2cKoc/9d3keCJRV1H7QzdFrdRf0dP0U9zneYHp2XssNzbc
	 V+5vwr+7VUN60ULPa3/pvP1Ly98XsnvwbIjRNbEwZECs0evFJdvxJGM127tBGYWddl
	 Rn80PFudUV9XHjU27Lez76mY6jN62rQV4EJ6J83L96oKw24pb39qPeUzlPxPaKJhw9
	 gVR2nZLsi4iITeJYHF0mJQ2exobvbTYBR6Gom4+8zrZgCN3vFftaGzLwsC4N/RNZT5
	 G+VNQ5+MEOVie7RLqJIfPXp5ULa9VYTdnmx5Sm8mFJOfxh5HX44Cd5fIHuGteJZXCa
	 uF6LYcRfMR9kocZvteE5kRsXLXN3qXYQXoAiA3TnqlnAjSoA3v0aChygd+W/K7jPDe
	 tdSywu0V9OrpLcHiNfUwWSMI=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 881D940E0176;
	Wed, 12 Jun 2024 20:01:03 +0000 (UTC)
Date: Wed, 12 Jun 2024 22:00:56 +0200
From: Borislav Petkov <bp@alien8.de>
To: David Thompson <davthompson@nvidia.com>
Cc: tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
	rric@kernel.org, shravankr@nvidia.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] EDAC/bluefield: fix white space in
 bluefield_edac_mc_probe
Message-ID: <20240612200056.GGZmn-eO15ePolbAPo@fat_crate.local>
References: <20240612193831.25913-1-davthompson@nvidia.com>
 <20240612193831.25913-2-davthompson@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240612193831.25913-2-davthompson@nvidia.com>

On Wed, Jun 12, 2024 at 03:38:30PM -0400, David Thompson wrote:
> This patch removes an empty line in bluefield_edac_mc_probe().

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

Also, feel free to peruse that whole directory.

> Signed-off-by: David Thompson <davthompson@nvidia.com>
> Reviewed-by: Shravan Kumar Ramani <shravankr@nvidia.com>
> ---
>  drivers/edac/bluefield_edac.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/edac/bluefield_edac.c b/drivers/edac/bluefield_edac.c
> index 5b3164560648..1f6f39a7dbf3 100644
> --- a/drivers/edac/bluefield_edac.c
> +++ b/drivers/edac/bluefield_edac.c
> @@ -320,7 +320,6 @@ static int bluefield_edac_mc_probe(struct platform_device *pdev)
>  	edac_mc_free(mci);
>  
>  	return ret;
> -
>  }
>  
>  static void bluefield_edac_mc_remove(struct platform_device *pdev)
> -- 

So just the effort to create a whole patch just for that is an overkill.

Please do not do that. If you notice very minor style issues like that, you can
do them when touching this code as part of a change with more substance. Or you
can simply ignore such minor issues.

Whitespace cleanup like that gets in the way of real work and pretty much all
maintainers are overworked already.

So I'd appreciate it if you concentrate on real fixes and improvements.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

