Return-Path: <linux-edac+bounces-4625-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87812B2E246
	for <lists+linux-edac@lfdr.de>; Wed, 20 Aug 2025 18:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 686B23AC637
	for <lists+linux-edac@lfdr.de>; Wed, 20 Aug 2025 16:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D00C32778E;
	Wed, 20 Aug 2025 16:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Xpn3rQL5"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76131322747;
	Wed, 20 Aug 2025 16:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755707085; cv=none; b=cB7XIIukdT3VAwN8XJhB0eajf9VFBW2vsug/cD/i+fC0+W+xdFebxC4fQ99wMYp3LU8kysS2GCTX/swYncL/1BZ4U3URNxcwZqk4lWd7Fgur5oh9fBg5IN0/eZibgLfoCii6mRAjTJCag6PXIehjxlAD44/4syvfHBzt47fbTFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755707085; c=relaxed/simple;
	bh=wwps0N/86vOfUDd1Y2Jf/4c5untsNqYTzcR0bDOAy+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GU9QqO2tNE3wMolXc3+BWqFpP0I06eZadN9szo0UIFJyCzlL6XP1OUMmvMp0kqMHpQk5HG59g45/K7whgvRhZvdWN0dAf5iThmQK6ejCcz+IpKDAiE5BHmaZpFdPbHvOJMITzhp+U3eHDlfdTyuIf7hjHMiL9AR94VK1p1K7M/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Xpn3rQL5; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C886440E0217;
	Wed, 20 Aug 2025 16:24:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 9tN_kXF78LWW; Wed, 20 Aug 2025 16:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1755707074; bh=HWIAN4COtM7EocQZHQEUT/ZaG//VJsQJBVIvh+BQZUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xpn3rQL5/5YWQaTL2Wl6Zq8PEQsQQuzoN5NnGFx02U7/GYrOQ3I+uA5XwysHJg9/u
	 cdNqbtwlD65rmvAXOPF4Sa8mK+0VIaxHc1rOb7s1OnwdnXnLuBbiK9dUoz4jJgiP+W
	 AccyxDqfEtlfHZwdkuFu1ZN2XPLo0zooqH1af3upiyMsXnACNZxBfQCAe+rF2Gfwbm
	 BgYPI3mYNJwGIqaa/4s/fw1NXEQnI8fDpma4eyysC+Nrdt/roil9yHy5CesZ2Q7ZiJ
	 1x1a8FU1QW1iwVxSifswYXCtCl0MSs8wDqW0Wm0c431M1IENk27T98na5idLDyho6W
	 zOU8R2AVkQScFfdL2myM4O31iPX7eeu6lHAS7VquNABV1bjwJd54jZiSuP8q5R6Ia6
	 1s8qRwMVC399qltOPx+58EA22u8Yxjn5st2dySsZBB/p7E040zCpdWMewhcpp69rv3
	 YHXjl9I/kAY3SqdbXue62zfszj5L3OfGTQEKarGGRjpySIZdrEmfqynf4idOj6gbqM
	 0Ksj15IuBJkSbMhxFt+K91D8NZLoZrq8yjye+TsGcE7hZCNI1qEwXdPzZlx5VB+20+
	 EnoQeC6kBKaTuDB7fzUb2NzqOfmTwZpPqxs/6XK7LbOaaAPnvyOOCR6ZyIVSvijtRB
	 nwjfw0M/sVGK97ACv/UxgKUo=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EF46540E0206;
	Wed, 20 Aug 2025 16:24:24 +0000 (UTC)
Date: Wed, 20 Aug 2025 18:24:18 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
	Dinh Nguyen <dinguyen@kernel.org>, Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org
Subject: Re: [PATCH -resend] edac: Use dev_fwnode()
Message-ID: <20250820162418.GLaKX2soq1RgYCAPCA@fat_crate.local>
References: <20250723062631.1830757-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250723062631.1830757-1-jirislaby@kernel.org>

On Wed, Jul 23, 2025 at 08:26:31AM +0200, Jiri Slaby (SUSE) wrote:
> irq_domain_create_simple() takes fwnode as the first argument. It can be
> extracted from the struct device using dev_fwnode() helper instead of
> using of_node with of_fwnode_handle().
> 
> So use the dev_fwnode() helper.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Robert Richter <rric@kernel.org>
> Link: https://lore.kernel.org/all/4bc0e1ca-a523-424a-8759-59e353317fba@kernel.org/
> 
> ---
> Cc: linux-edac@vger.kernel.org
> ---
>  drivers/edac/altera_edac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> index cae52c654a15..cfd17a8e5865 100644
> --- a/drivers/edac/altera_edac.c
> +++ b/drivers/edac/altera_edac.c
> @@ -2131,8 +2131,8 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
>  	edac->irq_chip.name = pdev->dev.of_node->name;
>  	edac->irq_chip.irq_mask = a10_eccmgr_irq_mask;
>  	edac->irq_chip.irq_unmask = a10_eccmgr_irq_unmask;
> -	edac->domain = irq_domain_create_linear(of_fwnode_handle(pdev->dev.of_node),
> -						64, &a10_eccmgr_ic_ops, edac);
> +	edac->domain = irq_domain_create_linear(dev_fwnode(&pdev->dev), 64, &a10_eccmgr_ic_ops,
> +						edac);
>  	if (!edac->domain) {
>  		dev_err(&pdev->dev, "Error adding IRQ domain\n");
>  		return -ENOMEM;
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

