Return-Path: <linux-edac+bounces-2694-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA119ED77B
	for <lists+linux-edac@lfdr.de>; Wed, 11 Dec 2024 21:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2890D16869B
	for <lists+linux-edac@lfdr.de>; Wed, 11 Dec 2024 20:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4A220ADC5;
	Wed, 11 Dec 2024 20:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gVk+ePN0"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1691C5F3E;
	Wed, 11 Dec 2024 20:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950213; cv=none; b=fii9AxXJzLw9WM6dDTaBC+IDEaZXQlSfrwxUaeNaY8SgUAOzCks85JYgdRNGc35ICLA55kI9ev21dPe5sI45oac927Lj8V90JsTp/ibxd4ZpIUakv5UPqRurcFLYmAc2pPYpWNMOALjPgy7ggbAaiIcQZsZLSOQ5ZiPlAvgc+C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950213; c=relaxed/simple;
	bh=HTbeRQiKIaA6UA7J4/YeKXyk+WUyi3SWZzNc5m/UtOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J76ZjsrX6kZYMbi6kbBcX3Gg6mwvb2/NMAacJkfMzPOORS4aycNwoqr5HnEbaawW5YYuddVVQKYceqfTbfQ2i6+YBhUBxk2G+z0TShXgGPT91bp9OW/joBR5okdmBexWzZpJJrNgtmxUE7zRvqVOrmcZCOIK6HrCvngiC/TP1Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gVk+ePN0; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2328540E0169;
	Wed, 11 Dec 2024 20:50:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Fh_FKKPk_VCT; Wed, 11 Dec 2024 20:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1733950205; bh=/PKPUJilw4Rela49D1Ua0zpMYCS8TP7uFi3G3iM8L4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gVk+ePN03rfwP84SdiIEQXtEVyAaA0Ie/Qru6DWfhrZmY3DhCfLtfLa5YK3knlCD+
	 yAF9mnClcGUlxHepQsM/sc9IpG3NxNVP0G4rH6odoxnC644mwMvcmKXEnTsvAOZvIx
	 iws+qPROfQw0bL1kx56zrPlHD6VFL4Nz0rUaDwMyp68HzQX2c/8q78K7kt/OO5Bb6x
	 ioWYlD2zllEufk0+DIwApDk/a9P2+JpzsqbYyGtZ1nVCWrqmB6S9lZxy40KnPBzoul
	 RxWtIdNCf6hk6HIM2jcgrnpzpldcFJViPbhFqqOYahI6MbIqMpfn6fyfuj/KTaKe7Y
	 nVtvnaNg05e0nxleEwVJUkiWLMTYIDCiuw20aVzr9X7Y7fTHlCco011oZUI0hgr7xC
	 ovako6r6z381wuvGdBFSYksGv1Xx2YNMHEAuBBsrixfucZ1zsAqkMiMTQEr6rn/Qwt
	 w7uYTxM122Nd1yvfIqwvmp4JBqwBATeuVVpobiazYhSIdV6ZHsJtltyiuLijeH2nnU
	 ZbynF74+XkoEvTGZo1oHxLFG8llh4tVW1qNCJZRm5XG/UC9IJLaKcU44eoIRPSN9U1
	 AbILf24YAiL2WdznoQUU26Dm0+neMqerZy4dQiiJKhHFDasM59aJvMtDen/JhcQbA7
	 hrUmid6SQqSH7XlHYhY5eQHk=
Received: from zn.tnic (p200300Ea971F93ce329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:93ce:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 337D440E02B9;
	Wed, 11 Dec 2024 20:50:00 +0000 (UTC)
Date: Wed, 11 Dec 2024 21:49:54 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Naik, Avadhut" <avadnaik@amd.com>
Cc: Avadhut Naik <avadhut.naik@amd.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v2] EDAC/amd64: Fix possible module load failure on some
 UMC usage combinations
Message-ID: <20241211204954.GIZ1n68g3aNTD87EdH@fat_crate.local>
References: <20241210212054.3895697-1-avadhut.naik@amd.com>
 <20241211110729.GAZ1lycaGYmjgNDGv9@fat_crate.local>
 <20241211154637.GA1923270@yaz-khff2.amd.com>
 <20241211185109.GFZ1nfHQBJB4rdXXSI@fat_crate.local>
 <28fb96f2-726c-4a86-a72b-cdfdcac9bce0@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <28fb96f2-726c-4a86-a72b-cdfdcac9bce0@amd.com>

On Wed, Dec 11, 2024 at 01:18:39PM -0600, Naik, Avadhut wrote:
> Yes, this fixes the issue of module not loading with some UMC
> configurations.

Thanks!

> If relevant, then for the below patch:
> 
> Tested-by: Avadhut Naik <avadhut.naik@amd.com>
> Reviewed-by: Avadhut Naik <avadhut.naik@amd.com>

Added.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

