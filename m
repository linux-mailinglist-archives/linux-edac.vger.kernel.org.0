Return-Path: <linux-edac+bounces-4601-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CBDB2B351
	for <lists+linux-edac@lfdr.de>; Mon, 18 Aug 2025 23:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C72FE1BA4232
	for <lists+linux-edac@lfdr.de>; Mon, 18 Aug 2025 21:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB7A260569;
	Mon, 18 Aug 2025 21:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gtIkk530"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1614725BEF1;
	Mon, 18 Aug 2025 21:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755552189; cv=none; b=uWHKzU4Fch8CJAt9Yl22fvRNsPrrr8Lg76A5XrVQTKweTW175KuOTqWg/UMBXhnjJvvhRGMS2VwrMwW0D8ynoZFgHKQ7bUBjV7nzq0SOzbnwYJZawwzhaCCT6ayiI2vNbUYY+XJ/nBLi13zpm/zqALCJjqgpHT31NX6fCVBSi60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755552189; c=relaxed/simple;
	bh=KAA+Ej2DMravAwXvG7VPosSEFzzNj9wXjBp0gOxHBF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ql1hJD87FKdIJrLHR8VLrIiQ1hfTvS58JR1759zg4HZSvTGrLLOZAUt1pfveFY0Nmw5twG5khkRKi3WSKeqRm6RSNETJ7ouKyovH2j8i73N+T5YTQMVG3SEGD41gjhAklOzCiW5+ewts0PmfNhAC8xfUTyYWDC6oAfa6+2Wt3N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gtIkk530; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E1FFB40E0232;
	Mon, 18 Aug 2025 21:23:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id eXbhWCOROy8s; Mon, 18 Aug 2025 21:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1755552179; bh=00O8sK8kIvI3EMkC/abIlVLhJ1TvCnrTYXlTvVssRTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gtIkk530gjT/dayP+lDJc/zkmSm/2acoU27bFR0hEjtgi7ZxGcJ03773CU3/wQnm/
	 zi2x8fWIz0NCBnNWJ/PvWxe0d09gt+xAcWuKrhsrtheO2bfC2/ciDrM+rXO4rn31y6
	 v4y3Jog8ep9I8ZxaRQ4kbcJI8DgU+n0lNaTxpQHJ5pMs48CNTCeyZI9gjNnQ5FFy1r
	 uK7Bc88++q8OgqM+oAFuvx5VWMF8mO3Xp6E4/2DIv/IycTngvhbeob4vXNjEkRkjsS
	 byTyyQcYnDUhnb6SZe5DevNRC3/+/qZpLxslKlW88U2h0e0hUNXNOolkRdL5WbCM7P
	 +I71QvzrmQv1SeaLM+EIhactMkK8op2Msb1xulJLkHn93EFpj/ZQ1Zs49pM5TI0KBW
	 oez3sCqzM8vOwLbNARC/d5/Zei2/dEca/u5ymWzM+x8DN2I2kb8B1L0+cPw5WbWsvk
	 F6aM7L37PIj20Zbgi2W6gkNaPrIwgQ74ylkOFmP9Hh504xOGb0I9lt7i/4qxYHxK9d
	 9WkI7XTWIxp9As/GThIgKnaazqbK1wjCmCTL3e5GEb3lzOG1jjrZgPlHJ1c4nShsNS
	 qc3S/sRKvSv94Hjk9JqpzMLDnA6PPLRE472w6EIiGzaIVkIaWOlNFfSYRLmtUGL2/Q
	 mzgACHUG4waPVHdMwjD/moqY=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AA74640E0217;
	Mon, 18 Aug 2025 21:22:55 +0000 (UTC)
Date: Mon, 18 Aug 2025 23:22:48 +0200
From: Borislav Petkov <bp@alien8.de>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-edac@vger.kernel.org, yazen.ghannam@amd.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] EDAC/amd64: Add support for AMD family 1Ah-based
 newer models
Message-ID: <20250818212248.GHaKOZqGhfCciWWOcD@fat_crate.local>
References: <20250807201843.4045761-1-avadhut.naik@amd.com>
 <20250807201843.4045761-2-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250807201843.4045761-2-avadhut.naik@amd.com>

On Thu, Aug 07, 2025 at 08:14:53PM +0000, Avadhut Naik wrote:
> Add support for family 1Ah-based models 50h-57h, 90h-9Fh, A0h-AFh, and
> C0h-C7h.
> 
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> ---
>  drivers/edac/amd64_edac.c | 20 ++++++++++++++++++++
>  drivers/edac/amd64_edac.h |  2 +-
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 07f1e9dc1ca7..2f6ab783bf20 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -3923,6 +3923,26 @@ static int per_family_init(struct amd64_pvt *pvt)
>  			pvt->ctl_name           = "F1Ah_M40h";
>  			pvt->flags.zn_regs_v2   = 1;
>  			break;
> +		case 0x50 ... 0x57:
> +			pvt->ctl_name           = "F1Ah_M50h";
> +			pvt->max_mcs            = 16;
> +			pvt->flags.zn_regs_v2   = 1;
> +			break;
> +		case 0x90 ... 0x9f:
> +			pvt->ctl_name           = "F1Ah_M90h";
> +			pvt->max_mcs            = 8;
> +			pvt->flags.zn_regs_v2   = 1;
> +			break;
> +		case 0xa0 ... 0xaf:
> +			pvt->ctl_name           = "F1Ah_MA0h";
> +			pvt->max_mcs            = 8;
> +			pvt->flags.zn_regs_v2   = 1;
> +			break;
> +		case 0xc0 ... 0xc7:
> +			pvt->ctl_name           = "F1Ah_MC0h";
> +			pvt->max_mcs            = 16;
> +			pvt->flags.zn_regs_v2   = 1;
> +			break;
>  		}

Oh boy, this pvt->ctl_name is ridiculous: we're collecting a zoo of string
objects where this thing can simply be scnprintf()-ed once at driver init and
then the pointer handed in to mci->ctl_name.

Something like

static char *ctl_name[MAX_CTL_NAMELEN]; 

or so. And then

	scnprintf(...)

into it based on family and model.

Can you pls do that as a cleanup upfront?

This is slowly getting out of hand.

And then you can group them together:

case 0x50 ... 0x57:
case 0xc0 ... 0xc7:
	pvt->max_mcs            = 16;
	pvt->flags.zn_regs_v2   = 1;
	break;

...

and so on.

So that this function turns back into something saner again.

Thx.





>  		break;
>  
> diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
> index 17228d07de4c..d70b8a8d0b09 100644
> --- a/drivers/edac/amd64_edac.h
> +++ b/drivers/edac/amd64_edac.h
> @@ -96,7 +96,7 @@
>  /* Hardware limit on ChipSelect rows per MC and processors per system */
>  #define NUM_CHIPSELECTS			8
>  #define DRAM_RANGES			8
> -#define NUM_CONTROLLERS			12
> +#define NUM_CONTROLLERS			16

I've asked this before but can we read out the number of controllers from the
hw somewhere instead of diddling with this silly define all the time?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

