Return-Path: <linux-edac+bounces-5531-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA36C84F02
	for <lists+linux-edac@lfdr.de>; Tue, 25 Nov 2025 13:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7A326342037
	for <lists+linux-edac@lfdr.de>; Tue, 25 Nov 2025 12:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F307F1A9B58;
	Tue, 25 Nov 2025 12:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="kNfpkD+T"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F134C1BC41;
	Tue, 25 Nov 2025 12:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764073102; cv=none; b=lLmuVGAOipJP3HDaMwRizhrkNAEPNwtwlgG6wRueVWya/9U0fIBTeLRzW2uYoR/vX0Gf18iVU/WzDHANHqD8+gn1OOsrQblhT8zMG6Wgm810W7nQH0l8TjhqUccLGaqaKK8KALqdh5fXG40/7YI5gtSNV3M4HPGgLvynD3uK9Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764073102; c=relaxed/simple;
	bh=MGO79TfULGGnTRo5ncAznV7iVB57q4d141FjxkM7FEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BV1Tq63j8rxlmoukF2DKPmq1Dfnb7OR8UwjESHTeCYmA62UUaY3GJuVLRAxTKHhhk4VHow8Cq3f7p3iz8aryyzj+fhiFRGhl4uPB1xqFCj9BwirAsT6bJwaD/54cMYnahrt1ASYGgrjO90myLWPGnjcH6gGcIq18AusiD3zYh3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=kNfpkD+T; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B33A040E0218;
	Tue, 25 Nov 2025 12:18:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id n6UYC02tB34v; Tue, 25 Nov 2025 12:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1764073089; bh=JNIc+Sn2V0B4ExWC90Z9ukQRRPTYfg8j2HLhuMTGwQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kNfpkD+TwBOp9S5cDWxl5WJfqln+8ck0ulSKTc2eOZSBxKdLrB2iSb6RT0vJ6Yzn2
	 NLtpzpXKzM9VP9MTDUgNWW4PNB/D8SOgwXQiC+3awpm+gWm5jC3kW6T61YzsJp5Q5j
	 G+180Rt1Bh1ICKQHEfHYc2XsQ9+f+yQjCioUJtEGI+l3DUF5FNbmzYvwwJwCGolQLB
	 T7V/8UFi2EqJoOblmPCOV3kIDIlusGIJhDE/GNh6vQVwaIMspcbigCYfP3jJrPtMKC
	 RlLNwXANvp/vfi6EYz/wMuI3bgrwCcS/46EPjsHkPPpNntFtYsRDuUuX8dt3k+35kJ
	 jIDMjUAuE05nxkpMGNs1vIi0zSBgvnUccMFB3hnvfZFNNF/08zUlofx/Au+vVneahF
	 QzMxIgS/k4xCyPHecvp92Tzzllqlla68PnhmVQ0gs9rnruEYdn0XB80+tyn81CiowB
	 AsoLGK+rdvsyCAAT4dS2ftwabelReNnmIofHnFokNks8WiikcQuxInRROL/B9uerjR
	 yxzt77uckOltqBqflWtsMoqKuBI3oh/SOsXsieiPjZJkc0AJ6al8mSMHxZivT7smy4
	 FwscQcMSo1T744HoIG9GD+Un1vf31RuwhIzW6DjRTy89FpVFkfn4/IgEFkG7I73nP1
	 6X68rwrJfGi4n4X9Cldf91IU=
Received: from zn.tnic (p57969402.dip0.t-ipconnect.de [87.150.148.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id A794240E015B;
	Tue, 25 Nov 2025 12:18:03 +0000 (UTC)
Date: Tue, 25 Nov 2025 13:18:02 +0100
From: Borislav Petkov <bp@alien8.de>
To: Devang Vyas <devangnayanbhai.vyas@amd.com>
Cc: yazen.ghannam@amd.com, tony.luck@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ramesh Garidapuri <ramesh.garidapuri@amd.com>
Subject: Re: [PATCH] EDAC/amd64: Add support for family 19h, models 40h-4fh
Message-ID: <20251125121802.GEaSWeeg36pHTqMAlR@fat_crate.local>
References: <20251124181335.284780-1-devangnayanbhai.vyas@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251124181335.284780-1-devangnayanbhai.vyas@amd.com>

On Mon, Nov 24, 2025 at 11:43:35PM +0530, Devang Vyas wrote:
> This patch updates the EDAC driver to include support

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

> for AMD SoC family 19h models 40h-4fh to support
> Ryzen 6000 CPUs/APUs ("Rembrandt").
> 
> The added changes enhance the ability to detect and
> report memory errors on systems that utilize AMD SoCs
> from the specified family.

Lemme repeat my comment from last time:

"Use the commit message to explain why those need to load the EDAC driver at
all."

Your text still doesn't explain why amd64_edac should load on a client CPU:

https://en.wikipedia.org/wiki/Zen_3#Rembrandt

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

