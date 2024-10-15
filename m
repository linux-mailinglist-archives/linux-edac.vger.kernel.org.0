Return-Path: <linux-edac+bounces-2078-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF19999F02F
	for <lists+linux-edac@lfdr.de>; Tue, 15 Oct 2024 16:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 838D7281A55
	for <lists+linux-edac@lfdr.de>; Tue, 15 Oct 2024 14:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FA61C4A2B;
	Tue, 15 Oct 2024 14:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="LhEqlfvw"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FC21AF0D5;
	Tue, 15 Oct 2024 14:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729003994; cv=none; b=NBz2Ei23O+42dveaRsOFc7uyq+5ARkaAHGsmP0ca7aLqrIFMGnM4qyOHht8zhilwVGvukf7uzwvGs0B2vju72n3i2neTHxogRiLSiPQkW3dXOp5R9v+U2x2iVk67OmxELHHxyuHE8fC+hjOBBhhYXo8mhb13tQ/+1PqJv7RIKsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729003994; c=relaxed/simple;
	bh=TXL5ECwjpaQl9xrzbHeNrLMJad9K2tD5pt8Y+USrQcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICvIUtd2ICUBh1ekMqkUf1TDcuBZD9U71aJFcE3fUYSsvL2BaFU2qUhT972KVpYKga+qdGIIK3OmWnU4g57oZOYUN42z4oHB9sqGCvWmCV5W3JOf+9SI/YMqd7vNqqdf2ycC9VbEVv1P9DKjiJ4Lh2PYGBrNSWegjepNghtZv70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=LhEqlfvw; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A679740E0194;
	Tue, 15 Oct 2024 14:53:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id eTQLnIpnaaak; Tue, 15 Oct 2024 14:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729003984; bh=IWu4dX3tvzxOwCtQqhtsDrxvJqZWaM0N7YGfox1xlSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LhEqlfvwFailZ+MIpmFomDMYfFNQnVJTcMpPK31TtPGDjT2YbTH4rgGG4Pj02chhX
	 7j66HnnZKf2bL+ontS+YzhtVtau4PD5ulUpVwt2fWWV2e/2QeYyyOMPAIj5HJsJSFM
	 LOF/Osf1rGG2PQTvJG7B1Lq5bKTC8Ss7ap+G89YWLZt2hY90ExdDn8JMiG6lUt6iS4
	 E7JEPDfrKGJq74CsZYzogfEGXit681oxix7iQ1nkr+Zh4Er+8WkpYkjjTU0Q7Hq7n0
	 PREPPsbfQStwnfjsayZfUR7hJwa85PyNkjyDLxp8NU2DeiOsmvNedzSgn2eRbwHDoA
	 Yhb9ZFhIN9tHHEYAR6T4eiTmlzzPsmRHgRDuQ3TUb/yMIfpiOPcChGgAK8mMKy60Tq
	 7IAqvVEEQ42bPAENIriDrf6/miWqu6jKNuUqwGClT2Ef27azW7RhmMv7k8o8qrGxeE
	 57r5uELf1Z6ZVWUZVb8FSpapTICC7EFUvGakVW3G6lV5DdBk346BgckLC4pWhTohFP
	 5g2vhZxW14hWs2VjBM3B7r390mhDgRxt53thdFQ6Uw0jaycMmEJNlgqJF63REaQomp
	 yxzsM4jcw/elUs79mvLMaybJ6Feskdqfl5ex5AglQfvmi8KkRdr8NfHWgOARSs5NRH
	 jKYYjBC9wGkgNnD0XlBPK+VU=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 571FC40E0169;
	Tue, 15 Oct 2024 14:52:42 +0000 (UTC)
Date: Tue, 15 Oct 2024 16:52:34 +0200
From: Borislav Petkov <bp@alien8.de>
To: Frank Li <Frank.Li@nxp.com>
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
	linux-arm-kernel@lists.infradead.org, Ye Li <ye.li@nxp.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 5/6] EDAC/fsl_ddr: Add support for i.MX9 DDR controller
Message-ID: <20241015145234.GRZw6BsqnIbaGWMzG_@fat_crate.local>
References: <20241011-imx95_edac-v2-0-011b68290951@nxp.com>
 <20241011-imx95_edac-v2-5-011b68290951@nxp.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241011-imx95_edac-v2-5-011b68290951@nxp.com>

On Fri, Oct 11, 2024 at 11:31:33AM -0400, Frank Li wrote:
> From: Ye Li <ye.li@nxp.com>
> 
> Add support for the i.MX9 DDR controller, which has different register
> offsets and some function changes compared to the existing fsl_ddr
> controller. The ECC and error injection functions are almost the same, so
> update and reuse the driver for i.MX9. A special type 'TYPE_IMX9' is added
> specifically for the i.MX9 controller to distinguish the differences.
> 
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/edac/fsl_ddr_edac.c    | 48 ++++++++++++++++++++++++++++++++++++------
>  drivers/edac/fsl_ddr_edac.h    | 10 +++++++++
>  drivers/edac/layerscape_edac.c |  1 +
>  3 files changed, 53 insertions(+), 6 deletions(-)

checking file drivers/edac/fsl_ddr_edac.c
Hunk #1 FAILED at 31.
Hunk #2 succeeded at 442 (offset 4 lines).
Hunk #3 succeeded at 478 (offset 4 lines).
Hunk #4 succeeded at 492 (offset 4 lines).
Hunk #5 succeeded at 520 (offset 4 lines).
Hunk #6 succeeded at 550 (offset 4 lines).
Hunk #7 succeeded at 577 (offset 4 lines).
1 out of 7 hunks FAILED
checking file drivers/edac/fsl_ddr_edac.h
Hunk #3 FAILED at 71.
1 out of 3 hunks FAILED
checking file drivers/edac/layerscape_edac.c

What tree have you created your patches against?

> diff --git a/drivers/edac/fsl_ddr_edac.c b/drivers/edac/fsl_ddr_edac.c
> index ccc13c2adfd6f..3e4c2869a07cd 100644
> --- a/drivers/edac/fsl_ddr_edac.c
> +++ b/drivers/edac/fsl_ddr_edac.c
> @@ -31,16 +31,28 @@
>  
>  static int edac_mc_idx;

I see here:

|static int edac_mc_idx;
|
|static u32 orig_ddr_err_disable; 
|static u32 orig_ddr_err_sbe;
|static bool little_endian;
|
|static inline u32 ddr_in32(struct fsl_mc_pdata *pdata, unsigned int off)

and you don't have those in your diff.

What's up?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

