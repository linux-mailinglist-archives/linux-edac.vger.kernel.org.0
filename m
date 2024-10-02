Return-Path: <linux-edac+bounces-1952-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1083E98CFCE
	for <lists+linux-edac@lfdr.de>; Wed,  2 Oct 2024 11:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38C021C241A1
	for <lists+linux-edac@lfdr.de>; Wed,  2 Oct 2024 09:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809B21990BA;
	Wed,  2 Oct 2024 09:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ql0lH9E5"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A66194AE8;
	Wed,  2 Oct 2024 09:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727860163; cv=none; b=Hs5v1dxkGkVLiXGtyyMtLRNBsqCnvCPfbT0PngtswSJAFIAX0P/+6usYQmbdaVAykTn9Dk4/eP5+JMlkKZN3OCk4k4IKXFxAUHuvUyIrqxcHQWIQErODEf3duXOn4FVpQyN8cyvlZhmwLK/LL6FrpVvvuobCcF+9T9NiA5jGT2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727860163; c=relaxed/simple;
	bh=z3qVt3aq6xHKfyBtITWNSaiM9zLgWRd52sZpxCWShh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdBdKGjAadyEJmTAcq5vQikb5w4bEJicK82mV9b65oVCdPoGWFj4BnKg5PJq+uWDYl6Dy9Clk+NX8fZCwPR9a4aVTxPnxY1osACMnXn/+vRbBYADJPPwu/LlgCwgcfvL/fLpQVcMH6xCQD+dMy78x/1Gg0+Qk6CnKfygptgHv8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Ql0lH9E5; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9D20940E0198;
	Wed,  2 Oct 2024 09:09:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id n_wrIeIIcGBE; Wed,  2 Oct 2024 09:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1727860145; bh=u7WrhdtUdM2CZPjYE8gSq6pu8OUfgUSF0bC4CJ+gHs8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ql0lH9E5m071LeXaMw8E2iP6NyAU+ppBVBJKxBOc+GXx1SFsIOJcPloAXad3/OR5B
	 +T+EthaWDV9gb1qaJNYaKWiu6dkBseq8cYLFzBlLOPAURg7aOtSARMKVRyaUumEM9J
	 ++cW8jdu4RjbxJtZN5ja/w1aqp08fID35e+6GPBfTiaen/zbiUN/L83Iu9ryLdpqcF
	 dXDS+D4bcf8v9r5CNAlggTBVkNh8LrpF0eIbHRk+g9Ez7jOPIALgRh3E+QDfMrEhdA
	 3olm2PFhnPSba/O9vVyF+ooaXf4zEy5uWojjgp8vyz1FNmDWGB8WjN4SQXlLgFHtWi
	 MVRSe6tQoKb8gYwxAk5fQzrSyYR2zuc9DnuX0yRpU/ewhEiBVawmL1DTiRedE5BRit
	 gjvpvnl2iM41WR0x92e7tlxZTmlQVI74rOTSpTLX6RvLlv7em6PY3HWco6SU8LkbFm
	 DgWkRfc0otaA6iCErBC6DwlKZm0kgGO/XY9TPmpRr/AaDi24FTi3Bq4BFjF1SxmKLy
	 UEN+hfhvNqINYIGjAbbMA4su99kdVE5WM7sOtTMORiJIUFkw0z2MdjKqSrGoNg2SaO
	 FrgkTE1OobkYjV6W9gmz3ew+PFnMNJLxAXoUYcj0icfXLrxloGMWjQ28ogoj5w6iC3
	 iqMC43HBhubmVORfB8IWLmE8=
Received: from nazgul.tnic (214.red-2-136-55.staticip.rima-tde.net [2.136.55.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4692D40E021A;
	Wed,  2 Oct 2024 09:08:40 +0000 (UTC)
Date: Wed, 2 Oct 2024 11:08:34 +0200
From: Borislav Petkov <bp@alien8.de>
To: Frank Li <Frank.li@nxp.com>
Cc: York Sun <york.sun@nxp.com>, Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Priyanka Singh <priyanka.singh@nxp.com>,
	Sherry Sun <sherry.sun@nxp.com>, Li Yang <leoyang.li@nxp.com>,
	Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 0/6] EDAC: fsl-ddr, add imx9 support
Message-ID: <20241002090834.GAZv0Nkp5YKcy86UmZ@fat_crate.local>
References: <20240709-imx95_edac-v1-0-3e9c146c1b01@nxp.com>
 <ZvsNJrxF6TpUC6ws@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZvsNJrxF6TpUC6ws@lizhi-Precision-Tower-5810>

On Mon, Sep 30, 2024 at 04:42:14PM -0400, Frank Li wrote:
> On Tue, Jul 09, 2024 at 04:23:01PM -0400, Frank Li wrote:
> > Add imx9 support for fsl-ddr.
> >
> > Patch 1-2 is prepare patch, no function chagne
> > Patch 3 is small fix for bit shift
> > Patch 4 is dt binding patch.
> > Patch 5 is driver change to support imx9
> > Patch 6 is imx93 dts change
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> 
> Borislav Petkov:
> 
> 	More than 2 monthes. I ping at Thu, 29 Aug
> https://lore.kernel.org/imx/ZtDwG2xFGaUssJVN@lizhi-Precision-Tower-5810/
> 
> 	Any reason why not pick these EDAC patches?

$ ./scripts/get_maintainer.pl -f  drivers/edac/fsl_ddr_edac.c
York Sun <york.sun@nxp.com> (maintainer:EDAC-FSL_DDR)
Borislav Petkov <bp@alien8.de> (supporter:EDAC-CORE)
Tony Luck <tony.luck@intel.com> (supporter:EDAC-CORE)
James Morse <james.morse@arm.com> (reviewer:EDAC-CORE)
Mauro Carvalho Chehab <mchehab@kernel.org> (reviewer:EDAC-CORE)
Robert Richter <rric@kernel.org> (reviewer:EDAC-CORE)
linux-edac@vger.kernel.org (open list:EDAC-FSL_DDR)
linux-kernel@vger.kernel.org (open list)

This driver has a maintainer. Is he going to review it or can I remove
him from MAINTAINERS?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

