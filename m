Return-Path: <linux-edac+bounces-4810-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D511AB5913B
	for <lists+linux-edac@lfdr.de>; Tue, 16 Sep 2025 10:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82D931BC3B5A
	for <lists+linux-edac@lfdr.de>; Tue, 16 Sep 2025 08:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8F42741C6;
	Tue, 16 Sep 2025 08:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZQbHBJQ6"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1237C1DED52;
	Tue, 16 Sep 2025 08:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758012493; cv=none; b=R3KhqrQQLKW+XKZLF0D73RvRclIGfIz1121LTmJXBs1XXOWGrNA9/CBK0rNAFxK5FOs2A4Y5yqfZ/vWrLy6Q7ttHvUsm+4Ba22PNMdPYrHnbo/Cb++eeAoKtpAE7zTPOCYEvlepkGrxo9ZhUtYIleKhqP3/JmCtiwW0eMAdBqtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758012493; c=relaxed/simple;
	bh=vKbbtg7Na5iJInnZIagyOi1PcdqDXNi8cIhSiA8abQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KiW1+O/lRLf62KTtRGcmQNHtPZLMzEgm1fL4BJ13Msc4y314RP0gOoXuvyjJJ0VBCihlmlAmZqZDncEtFdER2f0gGhv2yfRKitUsQfgQWV09ZV/YFaB/PCSzmMrcdYIV9yaOBv+pLOtna2Z4serDg6X1VHBKRBJHvLjDaxxGFeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ZQbHBJQ6; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2461940E01A3;
	Tue, 16 Sep 2025 08:48:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id AmL-BIRRyneF; Tue, 16 Sep 2025 08:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1758012482; bh=45shmwAZiLqEtZxAd55jcbykeKkgRaUpjw+bIADDSgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZQbHBJQ6sRAshMfaX60BXHq9gz4MMNvsTTEqV1b3KAE8UiUxm7/FgyJpeA6Y8V+64
	 xSsOd3l8465PFvhiEI+zMEqyCUdSf8MY8R8LhUDHDWvqG1g20wFB4OCXTk/kLmnq+f
	 NXf/CcHgT94RCDp+jgut+oJUSQXjYCkA67Rrbj8jRd8sm/c7jMjXDz/kOHzsCAJf9h
	 NBIRmnjvaFgm2J7MIli9khoQ9SXO8LE5tR9pj6eUVxtG+2rIr0sSAGAVhVKWM9lPRW
	 vXpjiiZMvzqDEyg4HMPvz6bJMOX2zKrrDntekyU1nbVM0m+0MCz20fu54vzB4LZQyd
	 AQcnlOwO43gUkW4U5uhH17G3oci1gfK5OrwR1u2MYRSg9yNGls4FtZyU4Q9ig5Up/0
	 Koz+iH3M0uLtQybIZTJ4n55sSJtfImPQlBKFdRWK6csNy8vqpFJ7Mga79UEx7qa5t8
	 1RlLTKiVYkcJS1VLm1h1ZMlPPtqGcKyxwyp74OuIAeEoLOR6eREWpPrKsWA5A1vdaS
	 s/pTE76Z+EpoN298+qAQFaoYtjWq8CrqPdIDhEFo1RiHreV8+wEfbQMw6rvciG0Azz
	 mzEE3fa2P9shLvPqSuSWJqzgeoQQ5Zz6of0VGeWKAucQ5Nm7h7Px3LphoTiRJaYSvL
	 NNFAQNjze2M5KvGPTemfzJeU=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 034E940E00DD;
	Tue, 16 Sep 2025 08:47:44 +0000 (UTC)
Date: Tue, 16 Sep 2025 10:47:36 +0200
From: Borislav Petkov <bp@alien8.de>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, git@amd.com, ptsm@linux.microsoft.com,
	srivatsa@csail.mit.edu, shubhrajyoti.datta@gmail.com,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>
Subject: Re: [PATCH v9 0/5] EDAC/Versal NET: Add support for error
 notification
Message-ID: <20250916084736.GBaMkkKB2jPmgltQgX@fat_crate.local>
References: <20250908115649.22903-1-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250908115649.22903-1-shubhrajyoti.datta@amd.com>

On Mon, Sep 08, 2025 at 05:26:44PM +0530, Shubhrajyoti Datta wrote:
> Shubhrajyoti Datta (5):
>   cdx: Split mcdi.h and reorganize headers
>   cdx: Export Symbols for MCDI RPC and Initialization
>   ras: Export log_non_standard_event for External Usage
>   dt-bindings: memory-controllers: Add support for Versal NET EDAC
>   EDAC: Add a driver for the AMD Versal NET DDR controller
> 
>  .../xlnx,versal-net-ddrmc5.yaml               |  41 +
>  MAINTAINERS                                   |   7 +
>  drivers/cdx/controller/cdx_controller.c       |   2 +-
>  drivers/cdx/controller/cdx_rpmsg.c            |   2 +-
>  drivers/cdx/controller/mcdi.c                 |  43 +-
>  drivers/cdx/controller/mcdi_functions.c       |   1 -
>  drivers/cdx/controller/mcdi_functions.h       |   3 +-
>  drivers/cdx/controller/mcdid.h                |  63 ++
>  drivers/edac/Kconfig                          |   8 +
>  drivers/edac/Makefile                         |   1 +
>  drivers/edac/versalnet_edac.c                 | 958 ++++++++++++++++++
>  drivers/ras/ras.c                             |   1 +
>  .../linux/cdx}/bitfield.h                     |   0
>  include/linux/cdx/edac_cdx_pcol.h             |  28 +
>  .../controller => include/linux/cdx}/mcdi.h   |  47 +-
>  15 files changed, 1154 insertions(+), 51 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/xlnx,versal-net-ddrmc5.yaml
>  create mode 100644 drivers/cdx/controller/mcdid.h
>  create mode 100644 drivers/edac/versalnet_edac.c
>  rename {drivers/cdx/controller => include/linux/cdx}/bitfield.h (100%)
>  create mode 100644 include/linux/cdx/edac_cdx_pcol.h
> rename {drivers/cdx/controller => include/linux/cdx}/mcdi.h (79%)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

