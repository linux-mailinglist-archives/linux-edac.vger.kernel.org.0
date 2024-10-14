Return-Path: <linux-edac+bounces-2064-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB0399D648
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 20:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A4271C22303
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 18:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1881C9EBF;
	Mon, 14 Oct 2024 18:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="MTPMgIde"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2709B1FAA;
	Mon, 14 Oct 2024 18:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728929845; cv=none; b=Q0dQkZLOosDf+NFWgQgzNCVPA24MtVqeANyQjUX+/EVE/WvoU28VdTsMYeSc3e8Uj2KyLmJY1HV9IPAQ0VbYgcuQS78no7BwjOwx/3sxJBkKqtk5A47YjY0P+7QrbyMIy/fz6Sn9xF8Q2NfW9hmwV0yXxncgVDFMFkbBVVPlZao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728929845; c=relaxed/simple;
	bh=P3Pzj722a0qn2KFz7CJfgBKO+JfL3dlBqaxecPwjeek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSs82ZBhn5+N8AOCnxg7RPAvs3WBgKgijn/zeTWxQCG1xBCF7x4RRpZ0+/Nv+nQMwA99vBOPHJcbFeQcBWC/uxprHUHOXelGeQ+uH7KWq5lG0KFFf+tVLzMMS8CtqghMa8o7xU77ozdzeBWtkscH+QwAGjJzx4JVSGaGjUZdI7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=MTPMgIde; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9DA5440E0184;
	Mon, 14 Oct 2024 18:17:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FdZTbS5Yi9uB; Mon, 14 Oct 2024 18:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1728929835; bh=rRulwwslaCiKpYQiRcp3k5u/GU44D2gHabFxhCGCe2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MTPMgIdelKAHQlU+HXCBeAaSxV0Ui/L3cr6Xmo31ldIIcLmnP7D4yadrMwJr3I6DK
	 x5aRFKCygueVgCT4ABt6WkPjIxfTQtJzn8scvo7XLEWuY0MP3ryR+G1mU5+x39zRxy
	 0qTqJs2sr8nTWfEW4A7rDf55zuMOCqrTx65nAnEaRGkxsw+Xeq3XJopNq+hv2+NZ0w
	 zEtzEVBvFR4S5lKwKvOmwJ/gr9Samx+3Pmtkg+yd1ffZCRx3J4xoSKA9Xwh4LhGBzY
	 EssseZkPgIMoGB/ZkMXGcSdK2LhUYkqOfWJVZTz/ztw+PpEio9q6ZDI27wv3pvAxon
	 P1VUpTRXcW/ouQ1U+cD96In1NZp4abLzIxWHUDR8XuYHvnY+Szuk1LxXSS5hvNVYH6
	 SFjQD+1N7hCHFHBbVRfzIvxQ2EUjsCIMzYOn1y9Iw6g6YO+hbBU5DodBMmsoOQl4zF
	 tzxkkFFTbOiwpmsu+zHwtih92WPYNA0LSE+Yq/iMZu8XiVlF7LoVHuwaTYeM+H8hOB
	 MA0rljcPbgb5E6hGaRfnWzViLNb/ASRRL2utzBls+bEOA/tWIKGttv/AneXcKt0gzT
	 0Cxt6mJKJ/wkS+n5PXZ2t+zpKTrmVwtv6Da+sWW5OQBbWRvQISXRcNnQh8lsey/uOZ
	 yPUGFx3OJTY7fvqQ4Y2BFTLk=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E5E4140E0163;
	Mon, 14 Oct 2024 18:16:52 +0000 (UTC)
Date: Mon, 14 Oct 2024 20:16:47 +0200
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
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Priyanka Singh <priyanka.singh@nxp.com>,
	Sherry Sun <sherry.sun@nxp.com>, Li Yang <leoyang.li@nxp.com>
Subject: Re: [PATCH v2 3/6] EDAC/fsl_ddr: Fix bad bit shift operations
Message-ID: <20241014181647.GQZw1gDwIhBdnFnleH@fat_crate.local>
References: <20241011-imx95_edac-v2-0-011b68290951@nxp.com>
 <20241011-imx95_edac-v2-3-011b68290951@nxp.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241011-imx95_edac-v2-3-011b68290951@nxp.com>

On Fri, Oct 11, 2024 at 11:31:31AM -0400, Frank Li wrote:
> From: Priyanka Singh <priyanka.singh@nxp.com>
> 
> Fix undefined behavior caused by left-shifting a negative value in the
> expression:
> 
>     cap_high ^ (1 << (bad_data_bit - 32))
> 
> The variable `bad_data_bit` ranges from 0 to 63. When `bad_data_bit` is
> less than 32, `bad_data_bit - 32` becomes negative, and left-shifting by a
> negative value in C is undefined behavior.
> 
> Fix this by checking the range of `bad_data_bit` before performing the
> shift.
> 
> Fixes: ea2eb9a8b620 ("EDAC, fsl-ddr: Separate FSL DDR driver from MPC85xx")

Is this an urgent fix which needs to go to stable or someone just caught it
from code review?

Does it trigger in real life, IOW?

> Signed-off-by: Priyanka Singh <priyanka.singh@nxp.com>
> Reviewed-by: Sherry Sun <sherry.sun@nxp.com>
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/edac/fsl_ddr_edac.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/edac/fsl_ddr_edac.c b/drivers/edac/fsl_ddr_edac.c
> index 7a9fb1202f1a0..ccc13c2adfd6f 100644
> --- a/drivers/edac/fsl_ddr_edac.c
> +++ b/drivers/edac/fsl_ddr_edac.c
> @@ -338,11 +338,18 @@ static void fsl_mc_check(struct mem_ctl_info *mci)
>  			fsl_mc_printk(mci, KERN_ERR,
>  				"Faulty ECC bit: %d\n", bad_ecc_bit);
>  
> -		fsl_mc_printk(mci, KERN_ERR,
> -			"Expected Data / ECC:\t%#8.8x_%08x / %#2.2x\n",
> -			cap_high ^ (1 << (bad_data_bit - 32)),
> -			cap_low ^ (1 << bad_data_bit),
> -			syndrome ^ (1 << bad_ecc_bit));
> +		if ((bad_data_bit > 0 && bad_data_bit < 32) && bad_ecc_bit > 0) {
> +			fsl_mc_printk(mci, KERN_ERR,
> +				      "Expected Data / ECC:\t%#8.8x_%08x / %#2.2x\n",
> +				      cap_high, cap_low ^ (1 << bad_data_bit),
> +				      syndrome ^ (1 << bad_ecc_bit));
> +		}
> +		if (bad_data_bit >= 32 && bad_ecc_bit > 0) {
> +			fsl_mc_printk(mci, KERN_ERR,
> +				      "Expected Data / ECC:\t%#8.8x_%08x / %#2.2x\n",
> +				      cap_high ^ (1 << (bad_data_bit - 32)),
> +				      cap_low, syndrome ^ (1 << bad_ecc_bit));
> +		}

This is getting unnecessarily clumsy than it should be. Please do the
following:

	if (bad_data_bit != 1 && bad_ecc_bit != -1) {

		// prep the values you need to print

		// do an exactly one fsl_mc_printk() with the prepared values.

	}

Not have 4 fsl_mc_printks with a bunch of silly if-checks in front.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

