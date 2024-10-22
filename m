Return-Path: <linux-edac+bounces-2177-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 191159A9EE1
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2024 11:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 301351C21FC5
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2024 09:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D26199EA7;
	Tue, 22 Oct 2024 09:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="dZT4i07S"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D158145B22;
	Tue, 22 Oct 2024 09:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729590307; cv=none; b=nkB1XX6aIUSAbS0yd0GhLPIPybtvvy9VdTbpUKg/kmYiwyy5fQiEg1yCnCtzdH9bwWA76169yH7aC15sMHUNzh6s5KqL9LYCgzNmVCX21QxNxSrQyLBsd1CyzLteL1lek1YoT4Gwl9N4wlr8qGqFSg9TFMzm8MR1FXSXpHvUVJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729590307; c=relaxed/simple;
	bh=GlLoCR43om/v9r9E86LKKa/FKLNVx5CmjA/L9r7EudA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAjKdOUVkl8UiH+tStsRdEFqwzUb3ptdjO8aEDK4Wqqaz4oia7W270K/s8Qbl23PpfmgLoCrMO2uVLDZuBKLiGL5OGp0OMS5+sReUgY9+8lIi1fmxbrsm3ppaqRSwQKVM6az7ikJCwNhTLolSM8c6meIRB+UVp5ua2rucVrmzJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=dZT4i07S; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CE43640E0219;
	Tue, 22 Oct 2024 09:45:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id llMr0-Ydhu4W; Tue, 22 Oct 2024 09:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729590298; bh=rDNfhvCyWnIJtBt/cVyjCF1IKMrba30fvxrKzlQyRNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dZT4i07Sd+NwwdlM4Axx/COyVdbGqXuEhvR6he0hLYxXRFe0FIaYuiMD7NRITkFBW
	 N97SKZCxFfkoD5+2izcSf4d4x7g+JKQNhA4kiw+Ro50bMczvm7S3XiMLp2n83pUvPI
	 1AOTD523p78tUkdxbO9KdoL35Q0F2og8hsDmzYCanCmsKgVUmASpio0wMn8C0fDhIi
	 LN/OD3IpSO1gOtRYUFKc1Sdl1WM0vcRZbOranUmqvxz01pXPmtC3h56Grso7sYfX5w
	 HH8FBLE9ppoiq0yQHQPNHdXfsQ1o4U2Jd220koiACcuP0bchUe4iszoI81ugsclF+k
	 QW4jKmfjCnGfws8gCIBjuEUzu1VSppMzSggiigf/1gD3kVGIUHfBe0IlcViVUGUnYh
	 iFlnm0Lm0z12q8OD7TeCX8thTlzh5hmcXPE4N23uCAopTBXIGZdR9A8BCG81qKC0eC
	 on39IgcW8yzdN6hcZkeDldE1/DzOx8/d/Ifzism909UUEsMqu5+NG1ieCUlAR11IDU
	 XvHRjlP3NWKhvsepBCPKUwwumeY8neN8LPfJAB9jop8dfbWPp0nEYRATRQmb3DZ5IG
	 KkgcKcavZ1Yx9vn24jymDLwIHszHC4Ies1z1CWWV6Qsda/rzVUDoVMoq2SN9yA3hmF
	 Rw2YyJhryeh2WiIZVZ5KDEPk=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C3E4940E015F;
	Tue, 22 Oct 2024 09:44:34 +0000 (UTC)
Date: Tue, 22 Oct 2024 11:44:29 +0200
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
	linux-arm-kernel@lists.infradead.org,
	Priyanka Singh <priyanka.singh@nxp.com>,
	Sherry Sun <sherry.sun@nxp.com>, Li Yang <leoyang.li@nxp.com>
Subject: Re: [PATCH v3 3/6] EDAC/fsl_ddr: Fix bad bit shift operations
Message-ID: <20241022094429.GFZxdz_QNHHr_DCPp3@fat_crate.local>
References: <20241016-imx95_edac-v3-0-86ae6fc2756a@nxp.com>
 <20241016-imx95_edac-v3-3-86ae6fc2756a@nxp.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241016-imx95_edac-v3-3-86ae6fc2756a@nxp.com>

On Wed, Oct 16, 2024 at 04:31:11PM -0400, Frank Li wrote:
> From: Priyanka Singh <priyanka.singh@nxp.com>
> 
> Fix undefined behavior caused by left-shifting a negative value in the
> expression:
> 
>     cap_high ^ (1 << (bad_data_bit - 32))
> 
> The variable 'bad_data_bit' ranges from 0 to 63. When 'bad_data_bit' is
> less than 32, 'bad_data_bit - 32' becomes negative, and left-shifting by a
> negative value in C is undefined behavior.
> 
> Fix this by combining 'cap_high' and 'cap_low' into a 64-bit variable.
> 
> Fixes: ea2eb9a8b620 ("EDAC, fsl-ddr: Separate FSL DDR driver from MPC85xx")
> Signed-off-by: Priyanka Singh <priyanka.singh@nxp.com>
> Reviewed-by: Sherry Sun <sherry.sun@nxp.com>

You can't keep Reviewed-by tags when you change a patch considerably: Documentation/process/submitting-patches.rst

> Signed-off-by: Li Yang <leoyang.li@nxp.com>

What does that SOB tag mean?

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/edac/fsl_ddr_edac.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/edac/fsl_ddr_edac.c b/drivers/edac/fsl_ddr_edac.c
> index 7a9fb1202f1a0..846a4ba25342a 100644
> --- a/drivers/edac/fsl_ddr_edac.c
> +++ b/drivers/edac/fsl_ddr_edac.c
> @@ -328,6 +328,9 @@ static void fsl_mc_check(struct mem_ctl_info *mci)
>  	 * TODO: Add support for 32-bit wide buses
>  	 */
>  	if ((err_detect & DDR_EDE_SBE) && (bus_width == 64)) {
> +		u64 cap = (u64)cap_high << 32 | (u64)cap_low;
> +		u32 s = syndrome;
> +
>  		sbe_ecc_decode(cap_high, cap_low, syndrome,
>  				&bad_data_bit, &bad_ecc_bit);
>  
> @@ -338,11 +341,15 @@ static void fsl_mc_check(struct mem_ctl_info *mci)
>  			fsl_mc_printk(mci, KERN_ERR,
>  				"Faulty ECC bit: %d\n", bad_ecc_bit);
>  
> +		if (bad_data_bit >= 0)

>= 0 implies != -1, right?

IOW?

diff --git a/drivers/edac/fsl_ddr_edac.c b/drivers/edac/fsl_ddr_edac.c
index 846a4ba25342..fe822cb9b562 100644
--- a/drivers/edac/fsl_ddr_edac.c
+++ b/drivers/edac/fsl_ddr_edac.c
@@ -328,24 +328,21 @@ static void fsl_mc_check(struct mem_ctl_info *mci)
 	 * TODO: Add support for 32-bit wide buses
 	 */
 	if ((err_detect & DDR_EDE_SBE) && (bus_width == 64)) {
-		u64 cap = (u64)cap_high << 32 | (u64)cap_low;
+		u64 cap = (u64)cap_high << 32 | cap_low;
 		u32 s = syndrome;
 
 		sbe_ecc_decode(cap_high, cap_low, syndrome,
 				&bad_data_bit, &bad_ecc_bit);
 
-		if (bad_data_bit != -1)
-			fsl_mc_printk(mci, KERN_ERR,
-				"Faulty Data bit: %d\n", bad_data_bit);
-		if (bad_ecc_bit != -1)
-			fsl_mc_printk(mci, KERN_ERR,
-				"Faulty ECC bit: %d\n", bad_ecc_bit);
-
-		if (bad_data_bit >= 0)
+		if (bad_data_bit >= 0) {
+			fsl_mc_printk(mci, KERN_ERR, "Faulty Data bit: %d\n", bad_data_bit);
 			cap ^= 1ULL << bad_data_bit;
+		}
 
-		if (bad_ecc_bit >= 0)
+		if (bad_ecc_bit >= 0) {
+			fsl_mc_printk(mci, KERN_ERR, "Faulty ECC bit: %d\n", bad_ecc_bit);
 			s ^= 1 << bad_ecc_bit;
+		}
 
 		fsl_mc_printk(mci, KERN_ERR,
 			"Expected Data / ECC:\t%#8.8x_%08x / %#2.2x\n",

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

