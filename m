Return-Path: <linux-edac+bounces-5265-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F39C20993
	for <lists+linux-edac@lfdr.de>; Thu, 30 Oct 2025 15:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBAEB3B3961
	for <lists+linux-edac@lfdr.de>; Thu, 30 Oct 2025 14:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A62426D4D8;
	Thu, 30 Oct 2025 14:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="lKkCLsvy"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7C337A3C2;
	Thu, 30 Oct 2025 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834681; cv=none; b=ZDc9e3cK77FWaKd3QzqBODUAIqvXTI7puKyORKAkICQ5Oi++2BIslJ5IEy61qXAID3WWVty2i0po+QvLjhVE4vBi65hhYKZY36djbKThqQMijMpP4ruBGUh1llQE+zHfCIDvmVNXpMp6GMYYlBo+wuIYP8DCjp255NJVggYVjmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834681; c=relaxed/simple;
	bh=e6HAsM8qCwruXaBbFHe8xlN7IjIUIii5LrVM8vD/1n0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJopixrYxnwijdGjSUdotu+TTHgMvxqgd94MqASpToC3ooOkH6hmMf5OvOYefeapoUUyeKKreog59v45MlDMLViZmmJrIOzol6EQflXfCzbrqpfXprogJXbfoc9i+wGoTDUFo9i9M7mR0i+viTa1v0DpBWx+VcIPLI7/0p5Ng1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=lKkCLsvy; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5AD4240E021B;
	Thu, 30 Oct 2025 14:31:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4-6kVergOxGE; Thu, 30 Oct 2025 14:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761834669; bh=Q0yjiK17p1Kzsm/19BErWjeOR//w7QftLf38LWxDPaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lKkCLsvyS1/EDdP8fmRTByBuywq8Kdmdv+npiQtzHoa6C4bDksJ+aEU0siALQL8n+
	 pJNLxu9zEIBpWKAAjN71OPOkLoFyQ8UpOYeRKCYGWpGS2sEUNYgwk9hxLObaVcfJ5+
	 khYPUZWNR1m8S5qXR0ZMHWF1fZFOojenbOmWPsalWESfy9uWP2j2P9RqVFZLtl3lzR
	 CJviH8O5yBGOGx/cIALP5kj8UPln1h+nPgY/awVIO5QtsjLnHMdJV2iJBaJjq3EiNl
	 crbi4viDSXzKmlvvVtsjdDZw5KnNCIIg7cCPznShoXnigZLrzImQIalpzVLVOG5AET
	 jkLTvFDi4kTL0hRJnsugAQ6W9uMM8Z5ggBXIOb6LX6jypVEO/5nNOYFgKpKkLc5ml4
	 S8FJL/hnaq+vLhbuqNPggAmK0u6HCiTVDnky/f/07Ekg+LezO9SdPCDWQyF/69HunX
	 m8hMIV9ExWoXwb4pM5v+mW45V+G4i1PfXNJ0h2ZIEJERluNFQbh4wmwTf/k+PbdMZ9
	 BawenmeLsa4eb23q+3CL72ure8jxreniIdHIvTwbkDjCItGDE1V+N06ccODjRsX445
	 Y7CBrH2puuLYQOanlk9vsDVItN2X7fJlWcjNWnGCAcGRXi4Ec4b65dUxdoVvtbjPFT
	 Szb7Ln7n0vKrwshn+xc56T5I=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 571A740E015B;
	Thu, 30 Oct 2025 14:30:59 +0000 (UTC)
Date: Thu, 30 Oct 2025 15:30:51 +0100
From: Borislav Petkov <bp@alien8.de>
To: niravkumarlaxmidas.rabara@altera.com
Cc: dinguyen@kernel.org, matthew.gerlach@altera.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, tony.luck@intel.com,
	linux-edac@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] EDAC/altera: Add IO96B ECC support for Agilex5
 SoCFPGA
Message-ID: <20251030143051.GJaQN2m2fniYVRtBxn@fat_crate.local>
References: <20251028092232.773991-1-niravkumarlaxmidas.rabara@altera.com>
 <20251028092232.773991-5-niravkumarlaxmidas.rabara@altera.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251028092232.773991-5-niravkumarlaxmidas.rabara@altera.com>

On Tue, Oct 28, 2025 at 05:22:30PM +0800, niravkumarlaxmidas.rabara@altera.com wrote:
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 39352b9b7a7e..33a9fccde2fe 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -410,6 +410,16 @@ config EDAC_ALTERA_SDRAM
>  	  preloader must initialize the SDRAM before loading
>  	  the kernel.
>  
> +config EDAC_ALTERA_IO96B
> +	bool "Altera I096B ECC"

Is this and the other new Kconfig symbols you're adding absolutely needed?

IOW, why can't the driver simply load on that new hw without needing Kconfig
symbols at all?

What are they really saving?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

