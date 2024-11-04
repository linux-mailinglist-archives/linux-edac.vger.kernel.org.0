Return-Path: <linux-edac+bounces-2427-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B299BB9C8
	for <lists+linux-edac@lfdr.de>; Mon,  4 Nov 2024 17:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1912D2830E4
	for <lists+linux-edac@lfdr.de>; Mon,  4 Nov 2024 16:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1461C07E2;
	Mon,  4 Nov 2024 16:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="dh2QhyOL"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A20E208A7;
	Mon,  4 Nov 2024 16:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730736285; cv=none; b=l+TrAEXawY2tP5w4jVrFvsQLdpgMKhrCXWX8rVJLr9bXE8RUEPKoAc12l2fK6+eHYbqAyAsqw6p1bgYvnN3OpjFU1Jojs1ANZJhdD3UaiC8NK9WDn7dlhFSG7zg0ZaPc96cJrH+kkxCaAwIV5wZ06UqfuAinqmEy98mNMlWwH2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730736285; c=relaxed/simple;
	bh=pgxaskKeNnP5SxnUYxsflc7Snk17guSWQVK4ufZAAvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MxEys4XOaq+7CdbTT6UJxWluc7w57DHSpyKa75WM2J0KvGuWNUQzYP4VWPd15UgN0xsrLNxM5DDsjqED5G1mNS08ig2xgs+jSKYj2jp2iKF5U9sEyDrY8VSt613mB7mk1kEm+y8tB7J0r81tt+y2+5Nvy63WkAFu8Ev1TDRUsS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=dh2QhyOL; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8893940E0220;
	Mon,  4 Nov 2024 16:04:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id mimQAGbDRxLb; Mon,  4 Nov 2024 16:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730736276; bh=TddblgITNV9NvehQMxuDCHUavW4KICFXmMmyTYmMz8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dh2QhyOLmtXXgwZ9nnDeQNznfmtXCzS/K/CMZ5vIuDdxNnF4okloPmy+ub0DCwsdf
	 hTOOdlzDpTNPAmifaV/GGyluELq3bij0VBSn8+wSIS7mMrJ6i0gED0y7nPOAJ7F2xf
	 d8OG84j4Hw3ohQDAdInKxzFe0u/F0yY/0qX6LHiGlcd0MJ/5Zf0tDulaicXSTGy2/B
	 OttASO4UsJl14ZGOjojhfGgjpswykz1E8Y8PcR9o2XLRke75pxUdXn1DRhMjrBO2zc
	 NRiv8Isj5SbqLB16AnovMkpDBQes8eLhAKPziXZI+C0sb7HxK+L3SvMD9Bu7W/drBy
	 rR1QIT8dhSV//wiKiYvKOWsH1vCtnJ0kEj6dA0zWlieAPIr7qAOSiGKu1CuTA4mw0x
	 SjIRBi/QqA5XYq5zmZRbK1pibgcRzd6WfN5a7tZ4bvhDh12iTqHEnTNjiN5GQpCb37
	 4plZ/s+K0O9eKV6B9FcAMtG3cyMe3Fd6GfTdM9E5ftGGJL12OlUFTecNOdeJ8q3+v6
	 xCJvj8xv6kuh759+YhqiHzIT4Fw+K+kYyNC07M8KrUx7P8aSDHo24TagB82ggTvZVo
	 SyatMv3FjVLbKHEzC9d82uSsQzRwcaEq006i/X+mEqOroxcC15+AEsnGFYvlQp+1+X
	 tb6UAGTMOaF7C7cgD1ZCGaOM=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F25CF40E0028;
	Mon,  4 Nov 2024 16:04:30 +0000 (UTC)
Date: Mon, 4 Nov 2024 17:04:25 +0100
From: Borislav Petkov <bp@alien8.de>
To: Jason Baron <jbaron@akamai.com>
Cc: James Ye <jye836@gmail.com>, jbaron@akamai.com,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/ie31200: Add Kaby Lake-S dual-core host bridge ID
Message-ID: <20241104160425.GEZyjwiRx74PEqiZRl@fat_crate.local>
References: <20240824120622.46226-1-jye836@gmail.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240824120622.46226-1-jye836@gmail.com>

Jason,

ack/nak?

On Sat, Aug 24, 2024 at 10:06:22PM +1000, James Ye wrote:
> Add device ID for dual-core Kaby Lake-S processors e.g. i3-7100.
> 
> Signed-off-by: James Ye <jye836@gmail.com>
> ---
>  drivers/edac/ie31200_edac.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
> index 9ef13570f2e5..4fc16922dc1a 100644
> --- a/drivers/edac/ie31200_edac.c
> +++ b/drivers/edac/ie31200_edac.c
> @@ -19,7 +19,8 @@
>   * 0c04: Xeon E3-1200 v3/4th Gen Core Processor DRAM Controller
>   * 0c08: Xeon E3-1200 v3 Processor DRAM Controller
>   * 1918: Xeon E3-1200 v5 Skylake Host Bridge/DRAM Registers
> - * 5918: Xeon E3-1200 Xeon E3-1200 v6/7th Gen Core Processor Host Bridge/DRAM Registers
> + * 590f: Xeon E3-1200 v6/7th Gen Core Processor Host Bridge/DRAM Registers
> + * 5918: Xeon E3-1200 v6/7th Gen Core Processor Host Bridge/DRAM Registers
>   * 190f: 6th Gen Core Dual-Core Processor Host Bridge/DRAM Registers
>   * 191f: 6th Gen Core Quad-Core Processor Host Bridge/DRAM Registers
>   * 3e..: 8th/9th Gen Core Processor Host Bridge/DRAM Registers
> @@ -67,7 +68,8 @@
>  #define PCI_DEVICE_ID_INTEL_IE31200_HB_8  0x190F
>  #define PCI_DEVICE_ID_INTEL_IE31200_HB_9  0x1918
>  #define PCI_DEVICE_ID_INTEL_IE31200_HB_10 0x191F
> -#define PCI_DEVICE_ID_INTEL_IE31200_HB_11 0x5918
> +#define PCI_DEVICE_ID_INTEL_IE31200_HB_11 0x590f
> +#define PCI_DEVICE_ID_INTEL_IE31200_HB_12 0x5918
>  
>  /* Coffee Lake-S */
>  #define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_MASK 0x3e00
> @@ -88,6 +90,7 @@
>  	 ((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_9) ||                        \
>  	 ((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_10) ||                       \
>  	 ((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_11) ||                       \
> +	 ((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_12) ||                       \
>  	 (((did) & PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_MASK) ==                 \
>  	  PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_MASK))
>  
> @@ -587,6 +590,7 @@ static const struct pci_device_id ie31200_pci_tbl[] = {
>  	{ PCI_VEND_DEV(INTEL, IE31200_HB_9),      PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
>  	{ PCI_VEND_DEV(INTEL, IE31200_HB_10),     PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
>  	{ PCI_VEND_DEV(INTEL, IE31200_HB_11),     PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
> +	{ PCI_VEND_DEV(INTEL, IE31200_HB_12),     PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
>  	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_1),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
>  	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_2),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
>  	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_3),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
> -- 
> 2.46.0
> 
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

