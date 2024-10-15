Return-Path: <linux-edac+bounces-2083-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8533299F27D
	for <lists+linux-edac@lfdr.de>; Tue, 15 Oct 2024 18:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47234281037
	for <lists+linux-edac@lfdr.de>; Tue, 15 Oct 2024 16:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823741F4FCA;
	Tue, 15 Oct 2024 16:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="kSXC3tIm"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98511714BE;
	Tue, 15 Oct 2024 16:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729008731; cv=none; b=X+skOGug93/+HyhaFfs2GtUe5c/80fUb/6jHqfh2yNzV2Ea/9KoVO/i/40zFU9Tc725lbtJ8enJHaGQzZ+KTZUTTu79fCJ/vIEYASl1Xwzlya8/0g3DDkuiancwegsTi18xScMPH64xuqJKB7gdxOxRo3cYXWddn9RcqeHO4INc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729008731; c=relaxed/simple;
	bh=xC6HJtpSfsLuYDs2rkcq5M4913DPARRzoKx+owkKuAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+jwhIX+k6cNboN73nx1gGeYm26Fe3l0O3IoFtU31ivAD2+bcZFcrUx79lgWI9dypHLNt2Wvem5CBe71HxZ+L+jFPrilo4s94itGW1BCy05ub9BuRYzk6R+d64PNhf4jU5MyJQCIEH1o7SBOZrvvZoL8k0NnszIhDe+s1EFMj7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=kSXC3tIm; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8B5CD40E0184;
	Tue, 15 Oct 2024 16:12:07 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id nh40SCebYiZC; Tue, 15 Oct 2024 16:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729008722; bh=+npNlJ0RDGZqVX53oFq9mVoS50bQaKiInLVdoQQ1tdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kSXC3tImw65OzUTFwjKquU2RUgWwy6hy7Dcnoh2Lsl2C+h5gDxPu5r3tjT4p/j7GQ
	 ojOJ6xA77m+nR25NMYmWtTtob7o8h1zcDOqpgxSgMa6v3dnw9lPOJDvxAhcgdN1yfW
	 nNbaNSW0tw4enoFu7L6nUUA64vFD8V7wNrlM+vz8dGcjGDKyB4ItSA8jksdyTGNFQI
	 jfNIQ9OGyNglPmx0fm8p8IWOaJ9N0nXHNcdjiINyiaH+t05Rl19iTMc6ZBqKeZufMc
	 yF10mv95uX8V0qPYDJ9bQMAWOs7wb/lu8TgmD6zTPnJDcU58cdzAqAj1QThlHBxGSu
	 /+nRprGHvgBjAMJqe6hVQDGox9F0U477M74jwvRsAJLCXeJw/4mon/EVaOgK/WqLnW
	 BA2QnpVlZta6yT0RUgSieyytIg9YL61MiMwuRNC1XdXcJwxlUSUM5cDb3WV5b9EPTO
	 QzR3iPvUJpHyYQMOnxMTaBqP8jmB1vk99e6cD1CA1fDM9q7Q34gNBkBAHw7DXDTFeG
	 qj2BZkqJZawf1fWtMOuBdtSd4MAhFErDvO10VmnMaxA65oqHQWd7Mzwxj9BmoeWgMu
	 FcKqKhkYWYfHUvocfplk+f4Nj8NtAdptmkXfDl66Ia4en6YPC+jT4CvmUufAVW6oMz
	 BeoetI6sJ2Gh3Jeju4ykTflY=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6A1B940E0263;
	Tue, 15 Oct 2024 16:11:40 +0000 (UTC)
Date: Tue, 15 Oct 2024 18:11:39 +0200
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
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Priyanka Singh <priyanka.singh@nxp.com>,
	Sherry Sun <sherry.sun@nxp.com>, Li Yang <leoyang.li@nxp.com>
Subject: Re: [PATCH v2 3/6] EDAC/fsl_ddr: Fix bad bit shift operations
Message-ID: <20241015161139.GEZw6UO2txZVBXffKc@fat_crate.local>
References: <20241011-imx95_edac-v2-0-011b68290951@nxp.com>
 <20241011-imx95_edac-v2-3-011b68290951@nxp.com>
 <20241014181647.GQZw1gDwIhBdnFnleH@fat_crate.local>
 <Zw6K3dlsnlhV3F/6@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zw6K3dlsnlhV3F/6@lizhi-Precision-Tower-5810>

On Tue, Oct 15, 2024 at 11:31:41AM -0400, Frank Li wrote:
> I don't think it is urgent. In most system the return value is 0. I am not
> sure who caught it because patch already exist at downstream tree for a
> whole.

That current patch looks like it needs rethinking and making it sane - see
below.

> > > diff --git a/drivers/edac/fsl_ddr_edac.c b/drivers/edac/fsl_ddr_edac.c
> > > index 7a9fb1202f1a0..ccc13c2adfd6f 100644
> > > --- a/drivers/edac/fsl_ddr_edac.c
> > > +++ b/drivers/edac/fsl_ddr_edac.c
> > > @@ -338,11 +338,18 @@ static void fsl_mc_check(struct mem_ctl_info *mci)
> > >  			fsl_mc_printk(mci, KERN_ERR,
> > >  				"Faulty ECC bit: %d\n", bad_ecc_bit);
> > >
> > > -		fsl_mc_printk(mci, KERN_ERR,
> > > -			"Expected Data / ECC:\t%#8.8x_%08x / %#2.2x\n",
> > > -			cap_high ^ (1 << (bad_data_bit - 32)),
> > > -			cap_low ^ (1 << bad_data_bit),
> > > -			syndrome ^ (1 << bad_ecc_bit));
> > > +		if ((bad_data_bit > 0 && bad_data_bit < 32) && bad_ecc_bit > 0) {
> > > +			fsl_mc_printk(mci, KERN_ERR,
> > > +				      "Expected Data / ECC:\t%#8.8x_%08x / %#2.2x\n",
> > > +				      cap_high, cap_low ^ (1 << bad_data_bit),
> > > +				      syndrome ^ (1 << bad_ecc_bit));
> > > +		}
> > > +		if (bad_data_bit >= 32 && bad_ecc_bit > 0) {
> > > +			fsl_mc_printk(mci, KERN_ERR,
> > > +				      "Expected Data / ECC:\t%#8.8x_%08x / %#2.2x\n",
> > > +				      cap_high ^ (1 << (bad_data_bit - 32)),
> > > +				      cap_low, syndrome ^ (1 << bad_ecc_bit));
> > > +		}
> >
> > This is getting unnecessarily clumsy than it should be. Please do the
> > following:
> >
> > 	if (bad_data_bit != 1 && bad_ecc_bit != -1) {
> >
> > 		// prep the values you need to print
> >
> > 		// do an exactly one fsl_mc_printk() with the prepared values.
> >
> > 	}
> >
> > Not have 4 fsl_mc_printks with a bunch of silly if-checks in front.

You missed the most important feedback. See above. ^^^^^^^

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

