Return-Path: <linux-edac+bounces-1139-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D548D00BE
	for <lists+linux-edac@lfdr.de>; Mon, 27 May 2024 15:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F6F4B24539
	for <lists+linux-edac@lfdr.de>; Mon, 27 May 2024 13:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D114161B43;
	Mon, 27 May 2024 12:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="GFbn4st0"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0C016079D;
	Mon, 27 May 2024 12:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716814620; cv=none; b=F0xZPi/8+/RPAW0deqtUw4TNwjthVOnxbkHq6TKMNa8ym7Nnnd6O1ui5YbhYSYNi7kw+bbHVlprm1Nf5fhHw4nFLqmMxgQbK+7o9mHN6a1+h7+0cNVbTh5nVYkdlAjLCFdn5oDImYLo3FutHXc9pAXorDJqBHEw076MdUVCnJWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716814620; c=relaxed/simple;
	bh=otmXjCzv9e1yKhrG2FOGrSXgT59YxsBJtrlYqKPOgso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SFe87xv8RwH1sfIttCcRnDsUj8WnQ4/XwQlAafSmOtp83rW8SEP8aDE5kmPwYnu0j+i3mxIRau/Nik4HHhNp8vNx/zgI3t487uxHhNgt7lPuBrmxI1hwNqZZYbCdTAFJjTL/r9iCIAIqIHWzqCvO4HoCI4QWgBGua/RWCS5H+Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=GFbn4st0; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0A5F540E01A1;
	Mon, 27 May 2024 12:56:55 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id EZOzCBgsOdXp; Mon, 27 May 2024 12:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1716814611; bh=0G0ODqoWY+xI0sbXQornRwLP45IDPVjo5oOKNS4y6/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GFbn4st0nSfJtxcpqiI4PN9DW5ppqeyHiKqbpSvsy9x4og1JYNogEERgar7czWUV0
	 5D/snq9k9sfORqPoUMhVQThS8FzG1fyCLkdA4Q1GBFDah3Aci7C+sgAafLYUFGrJEV
	 QYFi53i6Uic5m1PPG9GweQO7lfeIbkQKEscK2C02SWZbN3LkSS7K9M/Ljm4rFHypMR
	 47u7+WJpnNmoGQ5C+btUihBggyHK08ABWsG8y5BNS6V2wEb5a4I+QeYntwzyFARs43
	 eCuvLuSaVugk/cYze0wmWKSLoRR2go5dbGecPYxwMU7FbHGH1vUEiy+92HPGVjaVZq
	 0qSilI7IbennS+39KBAmQ0cRL/yA5pM0ZmzoNZ3AN8tgfbzrfbraNcAADANl8fWIPB
	 N7Q7AFVKjRz8lKixTiBWJ3TykohPQYBxhWJKmLpauviJMM38JHX8/FXXmwXiTt1xfA
	 Y4Cdxj+2Vb863hsU9YPvDSYNKAT1MFp1HkFdLCH/a/KYSphpsonjrUArYpZxEpaL5V
	 GhaFtNUyCVvCCrZdW/wmKJPM+BedZdQOUuEGDSNH/LIs7231oQT1RC+bU93QWnsqGn
	 4Eb479a5hX4yf0SP5GyNiRBGzhSUMGT9hCeUs9Rc80IevN0EVUrUAu6P/0Gqs8CDSu
	 eIeZQQ4OPg8rU9rJ+j10bZY8=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 138DE40E01E8;
	Mon, 27 May 2024 12:56:46 +0000 (UTC)
Date: Mon, 27 May 2024 14:56:39 +0200
From: Borislav Petkov <bp@alien8.de>
To: linux@treblig.org
Cc: rric@kernel.org, james.morse@arm.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] edac: thunderx: remove unused struct 'error_syndrome'
Message-ID: <20240527125639.GDZlSDB23LuyyP8fb2@fat_crate.local>
References: <20240516133404.251397-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240516133404.251397-1-linux@treblig.org>

On Thu, May 16, 2024 at 02:34:04PM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'error_syndrome' appears never to have been used.
> Remove it, together with the MAX_SYNDROME_REGS it used.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  drivers/edac/thunderx_edac.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/edac/thunderx_edac.c b/drivers/edac/thunderx_edac.c
> index fab9891e569a..75c04dfc3962 100644
> --- a/drivers/edac/thunderx_edac.c
> +++ b/drivers/edac/thunderx_edac.c
> @@ -35,12 +35,6 @@ enum {
>  	ERR_UNKNOWN	= 3,
>  };
>  
> -#define MAX_SYNDROME_REGS 4
> -
> -struct error_syndrome {
> -	u64 reg[MAX_SYNDROME_REGS];
> -};
> -
>  struct error_descr {
>  	int	type;
>  	u64	mask;
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

