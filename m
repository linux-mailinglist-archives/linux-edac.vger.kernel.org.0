Return-Path: <linux-edac+bounces-3277-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E442BA50F17
	for <lists+linux-edac@lfdr.de>; Wed,  5 Mar 2025 23:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C1D03A13B1
	for <lists+linux-edac@lfdr.de>; Wed,  5 Mar 2025 22:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA3D1FF1A2;
	Wed,  5 Mar 2025 22:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZhMCAHUH"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C411C6FEC;
	Wed,  5 Mar 2025 22:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741215122; cv=none; b=E8ueOE2f3f08cpKaJmgRHQfZt7drGgvf990XXEIS8EY7d4/iQIxG0FSFbo0cn2c1dfhmAtUlPb+JK5feQWbK4gI+0TiXfonfxBR5btallv/3cp86O1M8PaF05sWIRAfcWPQIbHIytMikAG452wp+rnZ+YiD+5varsLB88xCFR7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741215122; c=relaxed/simple;
	bh=oT6fvNrLOsWxZqGpdrwUmJ1gfmViURJYZXEWlYAoHQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EOD0Kz4ytpFLGBSRoOHyR1KCF6XsPY7s+uHiR+Fna6Eds5Zr2bghOXc9Z0GsAYR8r+HaMcpY8+SBJIDjqOTGDcebinrk7Djjf75vRBROYXGnu4Mm+nc9r94xq1ibWt62zFll2Hs0TDsdE5rBMfeUhOxWYVtgZE0DDeOKYVYAWmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ZhMCAHUH; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E3CD040E016E;
	Wed,  5 Mar 2025 22:51:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id i3-SvKTXMLmd; Wed,  5 Mar 2025 22:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741215114; bh=flP+a9zKS/YcU9z6llipJ5zEPm3ChIPMga2uqHGCyrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZhMCAHUHs+jNpX0K0EROO8zZJV6nVXODsICQT2Y/dj7gbOuOYwHwZt7XL7S8/ZqcW
	 oMUL3J4JYVmeH2kLP9/LdNM0s69znOlhtK0mF31aFecwGS2u3MkwnEM7kmeCKIr3Ln
	 9oWB7gZh0we4+ZVUKIF6ZcIuOxdAeYCI6MnL35b62nWNxZGUsbw+DtyqxdHSAR12sK
	 rBB0RAh1T5+gijUAHgubzQheDCRoRz8Tb/HGWqselhbdd21gv5bnWHZ58bb5/Y3pOP
	 9oIrSqshUew68vq9uUhogaF6UP+BYh0hGfEzqFTkRlFstB3X6Mocgu3+ys06WA5fTM
	 avWzuu/E3R0Ka1+UibdWQ/8cKK9/ToNRvpcdNVDAzajvYKhT2I3Vk11QDTfLyKwvmP
	 668Mq+qVmjLcqceNCVlio/C5sbaCuCsuTAaTE+dhzMHGeuVrgxOhWNnts61YwuWifB
	 S2N9HQIDEUxkiEILKycLW6rhHXoiehX7t5JVU8/gbFwU2YWOG37zWZYGSx/A3DeuRv
	 aXJ39laMmyRyUxe+sXmlNDG7bvOx8DKD80IbY9ayk1sWTzMb5mQkaFxZQdFN+2Rd3L
	 WJKLsVBouBs2lUggfTWsLjLmTjAmJ5WU4omZ2fDWxdtM1ovakg/iSGAl/V9EebKgiE
	 ykqRhQE2cNnFHmtv6M7gtm18=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8D66040E01AD;
	Wed,  5 Mar 2025 22:51:42 +0000 (UTC)
Date: Wed, 5 Mar 2025 23:51:41 +0100
From: Borislav Petkov <bp@alien8.de>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, Fan Ni <fan.ni@samsung.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>, Arnd Bergmann <arnd@arndb.de>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC: fix dev_set_name() format string
Message-ID: <20250305225141.GCZ8jVfTBDi0x0XhTW@fat_crate.local>
References: <20250304143603.995820-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250304143603.995820-1-arnd@kernel.org>

On Tue, Mar 04, 2025 at 03:35:58PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Passing a variable string as the format to dev_set_name() causes a W=1 warning:
> 
> drivers/edac/edac_device.c:736:9: error: format not a string literal and no format arguments [-Werror=format-security]
>   736 |         ret = dev_set_name(&ctx->dev, name);
>       |         ^~~
> 
> Use a literal "%s" instead so the name can be the argument.
> 
> Fixes: db99ea5f2c03 ("EDAC: Add support for EDAC device features control")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/edac/edac_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

