Return-Path: <linux-edac+bounces-5130-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB57BF1A1B
	for <lists+linux-edac@lfdr.de>; Mon, 20 Oct 2025 15:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E15A18A2F94
	for <lists+linux-edac@lfdr.de>; Mon, 20 Oct 2025 13:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7EC31283D;
	Mon, 20 Oct 2025 13:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="WJ8eYV1y"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDCF31A049;
	Mon, 20 Oct 2025 13:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760968104; cv=none; b=PU21hIediDivEjtT/OcYH/GoJ+T6K3xMlE+MaZ1SmLldLefieT83XBUe+VNfNAcG/KV/XZBZgkkhg4ICMnWACBrYpVE/ieTcGS8xJij4FVhVYWdXb3PzInu/vybSWslCYKInn5anBgceyoAOXeH13OFzgvyKazQQuObwu37RznE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760968104; c=relaxed/simple;
	bh=DQF4I5gIK8XfB7Z4MneVuPussMd9G6jFx9CvKqts1iU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XpbiiyY0DRZLez1ow4sESx70ebqei4TC83tjlO56TARfw3Wg8kzQ9lr7gpJysGZnqVzVZy1Q+wuBeRXi+Q54VcJ3wFNu6TBtjeyei4uK5n9DvmlPv8naHCxvZw9Qe6n+HdpCIjbDSBJ/RsTBlsPNrqQs83BXoDyZVwDvdvwQIM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=WJ8eYV1y; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C903040E016E;
	Mon, 20 Oct 2025 13:48:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id MhVNxkJfbrga; Mon, 20 Oct 2025 13:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1760968089; bh=GzIRxm1SBVAAETsnzXUiJdfSRkI9bRYohsmtfZRZM78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WJ8eYV1yT59n8bo6PbK6sgKMnpn2aCdEiVpjtwoRGUGFcH895EJD2U3IRVkmpcGrA
	 RuZw9RiGSlgaRIKEwRxxXLUzVgyzD04rdjYwIFSdmmsTYl4ypXWclUyGujLkc4Uo/o
	 0McIm8JfZp5Vw3BXapbajdysziqr32VLIlo/wH8OHmN8U52s5ZGfh8CgO2JJTc5bTn
	 9zKGw7LJUMnCche5P7nauVN5DfK5QfpFOZSeVk2zEVZxX9TXzEWRnjnOF6XAmAO6hP
	 xUHUWyI66cWaht4MrO1uFMDQbiVIHlwzjpc7fP28YYBwOlZOMrc+ywB7C/1z16c5Ya
	 4kK61KNShF6hYMGewSvXS3gJLZ56AyZs2/IvNyLUfl0jYSNTf3O5dP0bVdabczlQvk
	 BMp/PeHPon0OHOw68t3JwvgBJhUImS0GGo9ePpb15kRk6a2i14xVLZj72qcChfBxFW
	 zTUO0/Dovn5sxpDBGiQ/Auhn2u56O8ftYcRibm7SHJEbh/QJwvgN9lSNYYcM+z5PBe
	 P6nLY4Xp+E8mMAwqzaUUXnhaV5oqqyorL+fSHraVBBMYPdk4BESky6RhS3w7t2axXs
	 5gKULesMob+DYopXRe/GEd00JCVdbpTgFZHksxAaDpOP+4PT4TsvX0Chlazu70Lsmv
	 idlsJDUpkXrOtGzQpU4y9Hvg=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 6298A40E00DE;
	Mon, 20 Oct 2025 13:48:05 +0000 (UTC)
Date: Mon, 20 Oct 2025 15:47:56 +0200
From: Borislav Petkov <bp@alien8.de>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-edac@vger.kernel.org, yazen.ghannam@amd.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] EDAC/amd64: Generate ctl_name string at runtime
Message-ID: <20251020134756.GIaPY9jAoeEcBp95-k@fat_crate.local>
References: <20251013173632.1449366-1-avadhut.naik@amd.com>
 <20251013173632.1449366-2-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251013173632.1449366-2-avadhut.naik@amd.com>

On Mon, Oct 13, 2025 at 05:30:40PM +0000, Avadhut Naik wrote:
> +#define MAX_CTL_NAMELEN	20

Any particular reason for the 20?

AFAICT, the longest string is "K8 revE or earlier" which is 18 so 19 with the
'\0'...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

