Return-Path: <linux-edac+bounces-4819-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F139CB7DBD6
	for <lists+linux-edac@lfdr.de>; Wed, 17 Sep 2025 14:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED687161D9B
	for <lists+linux-edac@lfdr.de>; Wed, 17 Sep 2025 10:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7D83090C4;
	Wed, 17 Sep 2025 10:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Tr8Q1dbF"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813832F546D;
	Wed, 17 Sep 2025 10:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758103317; cv=none; b=OH+P2zYqI2zamLvOWJqShiAgydLNeiiWw0xnNUNsZEQSAZpcysJKXRGalohd7/fLvPyG8mQXbBZMvshGzV17Lcwjq6K7Xkxi3PmONhCOx32EJ26VxHGDR4XJ4hBVZvKD57Vbo660pggyyZRaxd3yYoChG9QS9nkk7tg6USeXp2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758103317; c=relaxed/simple;
	bh=2zXoZqbe7apP7oCO8jdSpNDUB/kSJDzsCawwEjREvgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvPdYWucwP638hQ2TdRElbjxE145ShquiuMobyPRwZI/bMTkNMdMmiRyrZShnDx0G8sN6OKNLD2MAUZd5b88tBsP09axDfy4RMWOyqr5lqiL92lJSUSZV8A7UU0hlnMWhMsB/VizJ5KprRWecm3DeuEhTtfb6c4TwHgbWPfgv6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Tr8Q1dbF; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7374940E01B0;
	Wed, 17 Sep 2025 10:01:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id RLQ_e6Ozh2iq; Wed, 17 Sep 2025 10:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1758103306; bh=cz1Iv/44JZAGuuMVa+YY2FpUjrFJfYGnVd9mov+3qho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tr8Q1dbF3O5uyYoUQvkHSvdEm/tsBmqOVPtH7olYyZPDQ/XKZXSsq9oQVP3E+AJ1M
	 tgUJk2p3eOvzwVdU3uJIAj7hsQX/hgAhmLhhCXqC5dFr5h1jSkb+ybD3Vhj+KO3AZj
	 O6wcYrZ1cD8GbJv3UD2KzEODouPLdVzt+3o9Ole4sQJej0A4LgnihX6Cpn/hUgegxN
	 joaNHpLoUFccH5x2BEUHotsv1FRi5hf79+WDrriyPoSs1RsijheYZJPzbA+Yhz7bTu
	 pIer1H0ZaRmRtRNEAH4xpd9DOJBn/cqPUWhNAhvc63O4F7SH4difOYePjY3EeBWee/
	 LyBefVEZIiOI/kLWB9T97HEOjNyAwykr/EbhTZAXzkrDHaxU6hcMsUvYKiaZ2Rb6qs
	 tdlq2zC2Zllo9Dv+snihG4VfzU0rK2sktZcgsN4gblUSHXGX2Do+EFlBhXeNn/6kv/
	 HeSpCdN2ZzI0ohbfA/wJTYaz5A5nrtKq6r2GP5ztlai0XgixYKC/MvsF/j6lRUDXpt
	 tL114vTMltoamibRx1jp3m9s/wVM9q4KVT1oDsdpn+Mvkn8g18GpgYHUKFR3nM+t3P
	 K9FD9V0SqjP1F9Njt8amttDIHRI5gwCKmfoR3hS8MvPJFXkgWVI85cJ2TTgYzKQdtk
	 dLjyZ4XBdyL3zdUKM5aa9DRU=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 8835440E019E;
	Wed, 17 Sep 2025 10:01:41 +0000 (UTC)
Date: Wed, 17 Sep 2025 12:01:35 +0200
From: Borislav Petkov <bp@alien8.de>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-edac@vger.kernel.org, yazen.ghannam@amd.com,
	linux-kernel@vger.kernel.org, avadnaik@amd.com
Subject: Re: [PATCH 0/2] Add support for AMD Family 1Ah-based SOCs
Message-ID: <20250917100135.GBaMqG_6Da1Dywf_3X@fat_crate.local>
References: <20250916203242.1281036-1-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250916203242.1281036-1-avadhut.naik@amd.com>

On Tue, Sep 16, 2025 at 08:30:15PM +0000, Avadhut Naik wrote:
> This patchset adds support for newer AMD's Family 1Ah-based SOCs.
> 
> The first patch adds support for these new SOCs in the amd64_edac module.
> 
> The second patch modifies the legacy EDAC sysfs interface so that the 16
> UMCs supported by some of these new SOCs are appropriately visible through
> the interface.
> 
> NOTE:
> This set was part of the larger EDAC updates and cleanups set sent out
> last week.
> 
> Link: https://lore.kernel.org/all/20250909185748.1621098-1-avadhut.naik@amd.com/
> 
> However, since some cleanups are still being worked on and since these
> patches are required for enabling EDAC on Venice, have separated the sets.
> 
> The cleanups will now be posted as a separate set.
> 
> Avadhut Naik (2):
>   EDAC/amd64: Add support for AMD family 1Ah-based newer models
>   EDAC/mc_sysfs: Increase legacy channel support to 16
> 
>  drivers/edac/amd64_edac.c    | 20 ++++++++++++++++++++
>  drivers/edac/amd64_edac.h    |  2 +-
>  drivers/edac/edac_mc_sysfs.c | 24 ++++++++++++++++++++++++
>  3 files changed, 45 insertions(+), 1 deletion(-)
> 
> 
> base-commit: f55d2af9afe33db61b58e1c5273dfdd8c102e4f9
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

