Return-Path: <linux-edac+bounces-1599-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF1B942D39
	for <lists+linux-edac@lfdr.de>; Wed, 31 Jul 2024 13:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1F881C219D8
	for <lists+linux-edac@lfdr.de>; Wed, 31 Jul 2024 11:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065AA1AD405;
	Wed, 31 Jul 2024 11:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="e6ZFbuiu"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7573C1AD3FD;
	Wed, 31 Jul 2024 11:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722425211; cv=none; b=uv68gihNkwmWs18W91ykpm4HIPCcOJcf2OsG3zB89Lq6wmhKcVPYwTJGsskJZ0OvNcaD/c0RVnPcJbEIZ65hVrHccuVgrV9jD3XSbeJXuCO5lPa3zgKI9zYcNBS0caXigKOjs2gKmE71WZUbe/s6iiBLBTJs3b/clORHdOuO39U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722425211; c=relaxed/simple;
	bh=q8RGUzmrzGnFZWMaM66/wOZVWp5Bt8Gsgp5GeaLs39w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FeyX4qanJfLwe25jRNuT51Sqx4OWz2RiXnwlFu9C5g7o0Yc1LFbyT/OooqHTIyYNk9lStgFDTPmd+U6lGqQ1z2tBAm5LK4oWzy2h9dZzwl2pFham2T5RagCgK9bfQkfSryYrE9CVuyddN5ZAZTF8d0wnIqcp4NhL8xOExLOBj8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=e6ZFbuiu; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1FA7740E026B;
	Wed, 31 Jul 2024 11:26:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id mN5fGE1YcXbg; Wed, 31 Jul 2024 11:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1722425203; bh=vvUpcQaPAHoFu+XzobVHDUiYwRPf8QgYSynEpDbYLvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e6ZFbuiu+wV9TzfAAqfYMOmDKnfSG03F1IZadA6NdzTEKWS7YrsHXqfp1re17pkac
	 1+O73yGOSuqdiIhT6tdkMikkTKLlgS+nEADFsm8oLphG/p9U2a4ZsLoIqwUn8Dt9GD
	 uVZIzbhr4yiRr6rLiUcnhHmciKc3FAKmcyuW4jbfzve1Rh0RnXscav4oOOxikfWrEz
	 WGzXLFkc8yTrtzByLnHi6La9m7wzcOFQI0n1dbIBJ1SgzxnCEBB305cMleUk1g9sAE
	 GIVnh7jnp/akA0lS8c9MX+Sw/CRyLHXFK4SxizF7D9PnPaNPJgHd8E73IXHfY3TDnu
	 za87f2mr5nJdPdsMEpLuDmjyI0vUQRf1qEurgdEqxK+deffX5nVZlbczHvnDMY4ljJ
	 vjyfg5QAzpwmBRomlSjsVJzENT2WjL5759LnLF9aX5UyVndLRGHnqmME2mWsSdHkBV
	 /tx+yBsvIWl6DSjUz2b85Gohh1wl0Lb9v340cJlS9dZPiwbKNj6UfRAnXvLSF9CZ9u
	 croW5E41n5VGkbp4S7iiqZ30LtJwIGFhnMlAScuSMRArnwgagS+aDPSnozKnoJxc0p
	 gKBvf56gn783Zq3JrKUvKN0t8ahoNHL1ZAFc8q3tAuE7oS30XJBMXRceAzfNzxfrRd
	 /YsA9mvPJ6/DUkgLLl/MsZgc=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 190CB40E0263;
	Wed, 31 Jul 2024 11:26:35 +0000 (UTC)
Date: Wed, 31 Jul 2024 13:26:29 +0200
From: Borislav Petkov <bp@alien8.de>
To: Vasyl Gomonovych <vgomonovych@marvell.com>
Cc: tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
	rric@kernel.org, sgoutham@marvell.com, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org
Subject: Re: [PATCH] Add EDAC Driver for Marvell OcteonTX2/CN10K SoCs
Message-ID: <20240731112629.GCZqofZTIg9AoTUQez@fat_crate.local>
References: <20240731111800.2253740-1-vgomonovych@marvell.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240731111800.2253740-1-vgomonovych@marvell.com>

On Wed, Jul 31, 2024 at 04:17:40AM -0700, Vasyl Gomonovych wrote:
> This commit introduces an Error Detection and Correction (EDAC)
> driver for Marvell OcteonTX2 and CN10K System on Chips (SoCs).
> The driver supports the firmware-first model and
> handles error notifications via the
> Software Delegated Exception Interface (SDEI).
> It also provides error injection capabilities
> through System Management Calls (SMC).
> 
> Key Features:
>  - Support for EDAC-capable on-chip peripherals.
>  - Integration with the SDEI for error notification.
>  - Error injection via SMC calls.
>  - Detailed error reporting and logging.
> 
> Signed-off-by: Vasyl Gomonovych <vgomonovych@marvell.com>
> ---
>  drivers/edac/Kconfig         |   10 +
>  drivers/edac/Makefile        |    1 +
>  drivers/edac/octeontx_edac.c | 1274 ++++++++++++++++++++++++++++++++++
>  3 files changed, 1285 insertions(+)
>  create mode 100644 drivers/edac/octeontx_edac.c

$ ls drivers/edac/octeon_edac-*
drivers/edac/octeon_edac-l2c.c  drivers/edac/octeon_edac-pc.c
drivers/edac/octeon_edac-lmc.c  drivers/edac/octeon_edac-pci.c

Why is a new, separate one needed and can the functionality be shared?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

