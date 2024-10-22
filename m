Return-Path: <linux-edac+bounces-2181-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A609AB3A4
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2024 18:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E0BF1F213FD
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2024 16:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7FB1A76D2;
	Tue, 22 Oct 2024 16:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZGRL2LX4"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556EE136345;
	Tue, 22 Oct 2024 16:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729613843; cv=none; b=n5FfaQ1jyqcVfpmJHkUnm758c15dTyeckV7eneTeAVB9g9dqhxnIpZjJmDr8gLTnwawpB9jms7VKG0VIAFOA+siM83XqLLYwWWMd3uobibihMMw0RJ/MOXcWDxi6AMiPB1j5eFh55maM8ld+u61qRGmJVX/t0BvK+s2VuB7v350=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729613843; c=relaxed/simple;
	bh=OFG7HFBoDbhMI8g7Y0r6Mn6NKm9OxNRgu1rPCmMM3zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYIBRDi9a4D3eO6oT4hPx4UioF3L0P5kxcWo8V7ld+PDJncSZAM20JA4cOcZKjmhgmfOKSkB9JNLW+/KuMUcK9RwjaH2KMQaIvmN0Qm5KaZP8iroQ6Z9ub+Xfl2xT+lYU0Q8UpdxhYQ+rrWqJBMKEnL8oWHvQPuWnfzMskg+ehw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ZGRL2LX4; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AF6B740E0184;
	Tue, 22 Oct 2024 16:17:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SxRAUl6Qx8eO; Tue, 22 Oct 2024 16:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729613832; bh=7VI+P72dXu6jlbrLu+mj4ToB+LSegaKux0yMSJVY1L8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZGRL2LX47xj4+x5nUWTk6qLQo0uorMLfWGLV54Sqml8sjmkqbcJ8lduVAy5s0SFRI
	 e9fN4jrQGgHvrUT45siw4x++tGpUCPZ2dXTRG/aWB4TpMd0z4eS6JKjVb93lx85vqw
	 8nQuuIJlm+7G67mXuBlMNzOAcY0s4Z/LbuDosAcy7n14ISoHzI+nKBYgSu7SkToTmU
	 k/qGEXRG/t7R83envtCR74bZDzIHWJgBJKBAlR5Ytob4BPjyYhR6TRlSnkimlgyz+X
	 OYSwvnxwn4+fgkAN5PZXfK+xE4ux9fKE2VFvVBeWT8H8uXtn6Iczis0+Zf0KEDc//j
	 OQytNdiHdZcTxd23G5bFWRkEDlv+4hnmqqIJo0Es8CCFhzAhw6enA0vll6rPxjgfdn
	 AmpEOU3psFsEYAMlXT2RGQLWbgeuqsgisFybtrYftqTErq52ofk/Hulnt1KLGImc+Q
	 pFCheKGYViGDP178iRmUpokm2dtLigY020fKdn14msl4XOe4N0qy35OFpOce0NF1Kg
	 HfF4HnI4AasTC3UafDxPNSWJ3g1/qev5iS12Fwx3D+Oye8Nicae8E1YjBqI+SiE2Gx
	 Fgzfq9LhnJ9OkEU4XxJDlYP+qMnJy6dQkMXeZXGGTbqnOyMLTcxXlbuxFYSr9l753q
	 k6TWNR8XDnB9w9uw0PVV3zH8=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 46AC040E0194;
	Tue, 22 Oct 2024 16:16:49 +0000 (UTC)
Date: Tue, 22 Oct 2024 18:16:42 +0200
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
	Sherry Sun <sherry.sun@nxp.com>, Li Yang <leoyang.li@nxp.com>
Subject: Re: [PATCH v3 3/6] EDAC/fsl_ddr: Fix bad bit shift operations
Message-ID: <20241022161642.GJZxfP6kbzHPahW3oe@fat_crate.local>
References: <20241016-imx95_edac-v3-0-86ae6fc2756a@nxp.com>
 <20241016-imx95_edac-v3-3-86ae6fc2756a@nxp.com>
 <20241022094429.GFZxdz_QNHHr_DCPp3@fat_crate.local>
 <ZxfEvxA+0iMKBZh4@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZxfEvxA+0iMKBZh4@lizhi-Precision-Tower-5810>

On Tue, Oct 22, 2024 at 11:29:03AM -0400, Frank Li wrote:
> > You can't keep Reviewed-by tags when you change a patch considerably: Documentation/process/submitting-patches.rst
> 
> Sorry, I omitted it since it is nxp internal reviewer. Do I need repost
> it?

No, I can zap it.

> > > Signed-off-by: Li Yang <leoyang.li@nxp.com>
> >
> > What does that SOB tag mean?
> 
> It is original nxp layerscape platform maintainer. He leave NXP recently
> and some item in MAINTANERS already been removed. It intents to fix
> layerscape platform problem at beginning. And orginal patch have his SOB.
> So I kept as original one.

Ok.

You forgot to comment on this part:

> > >= 0 implies != -1, right?
> >
> > IOW?
> >
> > diff --git a/drivers/edac/fsl_ddr_edac.c b/drivers/edac/fsl_ddr_edac.c
> > index 846a4ba25342..fe822cb9b562 100644
> > --- a/drivers/edac/fsl_ddr_edac.c
> > +++ b/drivers/edac/fsl_ddr_edac.c
> > @@ -328,24 +328,21 @@ static void fsl_mc_check(struct mem_ctl_info *mci)
> >  	 * TODO: Add support for 32-bit wide buses
> >  	 */
> >  	if ((err_detect & DDR_EDE_SBE) && (bus_width == 64)) {
> > -		u64 cap = (u64)cap_high << 32 | (u64)cap_low;
> > +		u64 cap = (u64)cap_high << 32 | cap_low;
> >  		u32 s = syndrome;
> >
> >  		sbe_ecc_decode(cap_high, cap_low, syndrome,
> >  				&bad_data_bit, &bad_ecc_bit);
> >
> > -		if (bad_data_bit != -1)
> > -			fsl_mc_printk(mci, KERN_ERR,
> > -				"Faulty Data bit: %d\n", bad_data_bit);
> > -		if (bad_ecc_bit != -1)
> > -			fsl_mc_printk(mci, KERN_ERR,
> > -				"Faulty ECC bit: %d\n", bad_ecc_bit);
> > -
> > -		if (bad_data_bit >= 0)
> > +		if (bad_data_bit >= 0) {
> > +			fsl_mc_printk(mci, KERN_ERR, "Faulty Data bit: %d\n", bad_data_bit);
> >  			cap ^= 1ULL << bad_data_bit;
> > +		}
> >
> > -		if (bad_ecc_bit >= 0)
> > +		if (bad_ecc_bit >= 0) {
> > +			fsl_mc_printk(mci, KERN_ERR, "Faulty ECC bit: %d\n", bad_ecc_bit);
> >  			s ^= 1 << bad_ecc_bit;
> > +		}
> >
> >  		fsl_mc_printk(mci, KERN_ERR,
> >  			"Expected Data / ECC:\t%#8.8x_%08x / %#2.2x\n",
> >

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

