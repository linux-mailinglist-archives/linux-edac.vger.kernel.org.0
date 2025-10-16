Return-Path: <linux-edac+bounces-5062-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1740BBE47A9
	for <lists+linux-edac@lfdr.de>; Thu, 16 Oct 2025 18:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 812844EA77C
	for <lists+linux-edac@lfdr.de>; Thu, 16 Oct 2025 16:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1738F32D0FA;
	Thu, 16 Oct 2025 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Jj1QrECd"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359A132D0F2;
	Thu, 16 Oct 2025 16:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760631057; cv=none; b=Iy6snp/PN/JgwYqUCOgH0DKv/+kcGfe7die9LAYQKJksxpbjZB0yJz9gxLInHf/kby1EPz1d46Fnn2q7t+FibZjWYeqM7OljDsyCu+ei4VzEISPHiBAoeyIiF49rdsLWBLC/x6fJWjIipVkoX6pUKwxqnH9rFKlqh1vC5QKpmU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760631057; c=relaxed/simple;
	bh=XSXlLOcantZ5ARYd4TgrcW0E70ArsId60H0GN0gKg4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DpD5p9yz21gSpimE2PhDOcBn1L3xMhe3+3l2XCjMePpUPKxHcw8hlTmqXVY0qRFLv0WCsGeS93TKFGiGlYKhBuW5RV3Kt0RzxVC+dUun3t0sjQ1G3E6vm4v44Q8goCCWFllWPyM6AP8PFzTAR2wIXPuBJx3bCh7usHfHrrJa2d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Jj1QrECd; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id F0ED840E019F;
	Thu, 16 Oct 2025 16:10:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id w3eSIvAbgA-P; Thu, 16 Oct 2025 16:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1760631048; bh=/UHl6kbY994+mlrJ8diJioELASwRlD2EMMjn+KzBonM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jj1QrECdLcV6hewCsz0GiaTJnfipLsUzGJhGlasbpWGquHHq2aFqAiYWYDjoWFfiQ
	 o1DY6JBob25HSE5YP3zyad6BXPH61BfmiSshv9uoztJd3UGaEcl55VbZeboM3Ikf4/
	 d+dppY59RLbeg2X4RpNUOIrlJIu7sIuWlG1QV7+RInxE3y4S+zE9sxSprL2RcrfCs9
	 CXncuvNERzq/j2QfB+iK4s0ANyGspneUxvYHLilhBFv0+trQAZVMCz7yviZjLxli1P
	 T7TGnwHPsBJMMGxE4o+bGmZmIHxYeMU2A7HoRIZdn6CohgedVc53OjHdrqP5a5j+wp
	 H9zZdp7opG6hSlhvPh+QV3otIMG1DMCV267wjsXzk0KKt8JXP0hE9VZj6L0c+6IYGt
	 5aXRHpMMYXSYp/OWd2ZS5l0djYRtIxeddfepSevicwbDmxkFG10Z5a0Z2ugjQe2NAi
	 2pL8i9QYra/BSJQ6OHAOs7OizuwnResMgRZYnhp4nn2PYi+u0hiz5RaDg03x2NVoOo
	 J4yu1kV1Tg4SU7YDnyiN/UAy7D+//tQuOLtisM6Ide5tyACMWKwaJnCHswnyoV2a+D
	 /JCnyI48dbQRpr+pPzYARvWIgJpARa67uwWKh2e7A6rHiJ7SM6Vvj+b3Yb6zXaJ1GU
	 vrh+skPk6Pqov0JqeSK6a9HA=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 7334840E00DE;
	Thu, 16 Oct 2025 16:10:38 +0000 (UTC)
Date: Thu, 16 Oct 2025 18:10:37 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Avadhut Naik <avadhut.naik@amd.com>,
	John Allen <john.allen@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 2/3] RAS/AMD/ATL: Require PRM support for future systems
Message-ID: <20251016161037.GEaPEY_V0fbmPvspMa@fat_crate.local>
References: <20251006-wip-atl-prm-v1-0-4a62967fb2b0@amd.com>
 <20251006-wip-atl-prm-v1-2-4a62967fb2b0@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251006-wip-atl-prm-v1-2-4a62967fb2b0@amd.com>

On Mon, Oct 06, 2025 at 03:10:26PM +0000, Yazen Ghannam wrote:
> Currently, the AMD Address Translation Library will fail to load for
> new, unrecognized systems (based on Data Fabric revision). The intention
> is to prevent the code from executing on new systems and returning
> incorrect results.
> 
> Recent AMD systems may provide UEFI PRM handlers for address
> translation. This is code provided by the platform through BIOS tables.
> These are the preferred method for translation, and the Linux native
> code can be used as a fallback.
> 
> Future AMD systems are expected to provide PRM handlers by default. And
> Linux native code will not be used.
> 
> Adjust the ATL init code so that new, unrecognized systems will default
> to using PRM handlers only.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  drivers/ras/amd/atl/internal.h | 10 +++++++++-
>  drivers/ras/amd/atl/prm.c      | 10 ++++++++++
>  drivers/ras/amd/atl/system.c   | 12 ++++++------
>  drivers/ras/amd/atl/umc.c      |  2 +-
>  4 files changed, 26 insertions(+), 8 deletions(-)

Try to simplify this this way:

Drop prm_check() and set prm_only *after* acpi_prm_handler_available() returns
true. Then use ->prm_only everywhere instead.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

