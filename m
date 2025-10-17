Return-Path: <linux-edac+bounces-5111-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBEABE8A02
	for <lists+linux-edac@lfdr.de>; Fri, 17 Oct 2025 14:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F4CB1AA386E
	for <lists+linux-edac@lfdr.de>; Fri, 17 Oct 2025 12:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5D232ABED;
	Fri, 17 Oct 2025 12:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="dngNb+Ev"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509EB2D8DC0;
	Fri, 17 Oct 2025 12:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760705029; cv=none; b=tN+/PNRKS2GGWX5cT8MiM4KSdv5gtTMRmReJFunRWhkoE7cdDrXoqVba/NX6cqlEQx6AtQhnt4z2uk/ls+JEg0fp5K5xAYczfJCTBVbEIIZRY2kXoDnOOw8LT99iAhoLRoriAqQBcnf8tNpvI3meJOjiYIDWMmQLQYekfILpR68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760705029; c=relaxed/simple;
	bh=Iybnwfko+HZb1LFVtNLjPN2UPgEojdsvK8JeLpegt+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDKlKJ36akCtWkIwGIUsle0p0k2AnK8kI2RCmOYwCiNEPRQjUXlW2QqGfi3N5vnajtkyDon6zyMydBEPPHXi7Un86tJmkuVdMzo3d9vg26czmPgMlXY5Jb/lN0SmFmyVV17iISlKhvrxT6z9C1iBJGbv4wpSOqopoWnXancbteA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=dngNb+Ev; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DC23E40E01AB;
	Fri, 17 Oct 2025 12:43:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZB0GOpxixLsM; Fri, 17 Oct 2025 12:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1760705019; bh=ZEb9iUdHzj2CcG4fOo0yjOLLivGCt8rK+T8OzBV6mFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dngNb+EvG9F+bpyo8TywrC2cBmO9EHCzSH31iKSJ+ICbWFofC1NQWvzM/fBrPOxf4
	 QHPVkP5AfpfrFDAMobNMuL5hOBXeHi/lVUzcwmBGz3oCxPng7PKtlMLCafXz2BQuUV
	 ezRZ0j7rCuJZnAMk0Onn+pLMj0FXO/hZNNwbz+k12D0XtH6mbp8Wh5zIbAWwah9FV/
	 Mk1F1nM2DDr3wgVoKWUNRO5XsgS/gcb/Vt3XqZOzWUd37QU4/5iWvjLpjA1PRX7Jai
	 etkzPP+urrsnDnPzUljomlJ2Osu0xdnA3+XmweJykYCa9k6cT/SsEhdrdptenfrs2m
	 F4DQ0Y77Z2lgr42sNHP/fTNJXNI59kwqcAHXIypYLqgrGRTjejVh4FJqPkQrEgbMCz
	 2bhlr1NFUgUGnNsi9RWFT6njX8F9c2VlHDcaj8TTl07kqMjsUnoySRKIqrhlBziO3u
	 peFkz0zfkiOK7gKqf9FR3VNxD8zq6i8KzAlhaXyj/YEkeTyN8JasbZW9I4GaDvwULM
	 pnRPNDKMNzLFJHeZHGlXBzf8m3zViWUrdjH2zEgBk5tDOuOdmk/9wNyRg1xauhitK9
	 cOdY9f/HOQxXBwWGBX1qAdpqnwlM7fgZWlsqVXg1vav5UY5IJc3FTCceAx6q/J86yM
	 6y8ouM/I5trOIIhVlBmzzbvs=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 9519C40E019B;
	Fri, 17 Oct 2025 12:43:29 +0000 (UTC)
Date: Fri, 17 Oct 2025 14:43:21 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Avadhut Naik <avadhut.naik@amd.com>,
	John Allen <john.allen@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 3/3] RAS/AMD/ATL: Return error codes from helper functions
Message-ID: <20251017124321.GFaPI56QfaoUoFfxvL@fat_crate.local>
References: <20251006-wip-atl-prm-v1-0-4a62967fb2b0@amd.com>
 <20251006-wip-atl-prm-v1-3-4a62967fb2b0@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251006-wip-atl-prm-v1-3-4a62967fb2b0@amd.com>

On Mon, Oct 06, 2025 at 03:10:27PM +0000, Yazen Ghannam wrote:
> Pass up error codes from helper functions rather than discarding them.
> 
> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  drivers/ras/amd/atl/core.c   | 7 +++++--
>  drivers/ras/amd/atl/system.c | 7 +++++--
>  2 files changed, 10 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

