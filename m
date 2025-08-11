Return-Path: <linux-edac+bounces-4552-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A19B216D4
	for <lists+linux-edac@lfdr.de>; Mon, 11 Aug 2025 22:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 757361A22FA9
	for <lists+linux-edac@lfdr.de>; Mon, 11 Aug 2025 20:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14F92DA760;
	Mon, 11 Aug 2025 20:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HIvHv2S8"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54DA2D6608;
	Mon, 11 Aug 2025 20:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754945756; cv=none; b=HxeljX3HYXOVOgSoocG86tINwZsSkCyM62ZnzuYjSOSTmQ9R/cwbVFWgDrf7JHZkvPhOppCW+tFovHwMpN6DMNBqnBHZFwl/mSRtrKmtPwy10yWh31S/f5FAo6XXKpssNZCfs3T/daEXnVbp7CCX9efviCIpybf4/PlxJqMrV+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754945756; c=relaxed/simple;
	bh=VvFuGXh6WDOITQJS3G7gK3fNfBfjXhCB6PVmWrqh+Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bme/4TVIjZ4u+gJ9tQptInC7o8B+E9fF+HxpYBcE1dRnHQu7dFrd2CFBbhz5PnnLVkGNSQ2cimR0mHx+8kjRn60QrvZ1aLTF2mJCbJQqM2I8FKcyWGL9BxV4X8JZC181J48eoE+AYt0nKs52pClqAzaYtzVuogxG+f7uGiXZ2mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HIvHv2S8; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0A9D840E0254;
	Mon, 11 Aug 2025 20:55:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 54dmAhYFx1iL; Mon, 11 Aug 2025 20:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1754945741; bh=aFI/MkdNla3UQwqip7Xb+cy5s4ZRjHo9kvuasotADcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HIvHv2S8NpNzYQVoiUHniSy/aLu9kbPmdwD4iCBi6sHMWUWvcmgyhYOj2cQx0c1f/
	 CPqmo/De79USUTfDmjXdKr0fvat1cuPMPLvmNy0fRGsy9Gaway27XdnfZYuYYMU5Z6
	 JZCNBGG/au11Zrmv8P/PS0B6GH18cNztF4ozXcnax8k23DPFxf+hxDPGW3OtVfVa35
	 a+mNwl8OBiulkCnKp5xbsFYlxh/OeO5rwXTL++e5Jt2A7ZGUqjje3DNUs+/rcJN7Pg
	 NIxGM2P4CdOdDNqL3A30y/XKirftZcEQWzb4EjL3cGne5bFqvKYgADUt80GrVXyTI5
	 mfIerEynRhEYCPnfcs8uPTqPvhoWpStAX5w8ixKujHnpT1qgXoAdGhmucgmAubeS5/
	 9Ex/ADLm58W20iWudwltzNVQNZu15QlB0KDRNb7qr67b1wslUk6PS6Nt1+BrhcKTFB
	 uFbY7kh+n4Eue04b/rcYfgSqwvNO9sWQGnzU/oeHt1uVO/WvJZhRMl6erBZ9nxw1bU
	 28QvQKdAsLbz/Lm4EEZGXFcB2tCiSRtyO+ihKIHIicTxz44xSU2M++fbXTWhJ+Tq6c
	 Kq4jBSzS6e1D1pgz3Rh4s6Wt/Tte9WBL/932M7QUymJ+NtW9+5e88WDl3gpxm1H+P3
	 XUtyHHKjlPIeEjRjt+ukPGrI=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C1D8F40E0217;
	Mon, 11 Aug 2025 20:55:36 +0000 (UTC)
Date: Mon, 11 Aug 2025 22:55:29 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mce: Use ZENx features for Zen IF quirk
Message-ID: <20250811205529.GBaJpYwcmMfEFqEicm@fat_crate.local>
References: <20250811-wip-mca-reduce-if-quirk-v1-1-4e0f24d94872@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250811-wip-mca-reduce-if-quirk-v1-1-4e0f24d94872@amd.com>

On Mon, Aug 11, 2025 at 04:34:08PM -0400, Yazen Ghannam wrote:
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 4da4eab56c81..0ef164568077 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1951,8 +1951,11 @@ static void apply_quirks_amd(struct cpuinfo_x86 *c)
>  	if (c->x86 == 0x15 && c->x86_model <= 0xf)
>  		mce_flags.overflow_recov = 1;
>  
> -	if (c->x86 >= 0x17 && c->x86 <= 0x1A)
> -		mce_flags.zen_ifu_quirk = 1;
> +	mce_flags.zen_ifu_quirk = cpu_feature_enabled(X86_FEATURE_ZEN1) ||
> +				  cpu_feature_enabled(X86_FEATURE_ZEN2) ||
> +				  cpu_feature_enabled(X86_FEATURE_ZEN3) ||
> +				  cpu_feature_enabled(X86_FEATURE_ZEN4) ||
> +				  cpu_feature_enabled(X86_FEATURE_ZEN5);

I was fearing this day would come where we'd need something like that and it
would look gross. And it does.

Can't we simplify the quirk to do:

	if (!m->cs)
		m->cs = regs->cs;

when X86_FEATURE_ZEN is set and that should be good enough if we squint our
eyes hard enough...

m->cs on the fixed machines won't be 0 so it all just works...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

