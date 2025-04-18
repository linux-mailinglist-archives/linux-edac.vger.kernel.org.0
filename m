Return-Path: <linux-edac+bounces-3591-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E50A93F07
	for <lists+linux-edac@lfdr.de>; Fri, 18 Apr 2025 22:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EFAB460E97
	for <lists+linux-edac@lfdr.de>; Fri, 18 Apr 2025 20:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53C821325C;
	Fri, 18 Apr 2025 20:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="c2aZCiO3"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D542868B;
	Fri, 18 Apr 2025 20:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745009122; cv=none; b=LkAteoECgNh7vsILrf5pYmIp5xjJn+FK70v/WqhkqcE9tFNxrO+NL+D+nnLXC5FJzm6snS5fjnPWwNrf+yvpw51s5U66G9w0y7y90wHzlDKXj4KRQ1lcPS9IwB46plU7KdQ6r+b4kdHQTyZwY5TDWb/GZa8ZZZryI1HBLbpQBQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745009122; c=relaxed/simple;
	bh=SWhMq7EEykkiSLh6AkXVMXflLkia3IhfyNr+kjedS54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uoz68elrKdKmWxya32+U7Yu7G49OxsEx58H2v0lmEI7iMAvlGL1u4aeNA6MWxmU7FXjNecySmivwIDVZObK/TRAZyixK9F/IlVIoIfjdVkxnVjR//uTFdfuqQwkP09Tg/4uj8eUr3IkcXpECASLMfhY3IT3FS/QUm1pLDi8hIhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=c2aZCiO3; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D294F40E0200;
	Fri, 18 Apr 2025 20:45:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Z9dMenDm3W3E; Fri, 18 Apr 2025 20:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1745009113; bh=F6o7Xb9qIamzCoDoNgbWH9E8jO17VFIup3c2wRj3x/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c2aZCiO3haWNBlhN4vQLIQRtHigrEytnFdFJgsRE/ChIinHzljvnUDKwLufdIK0Pk
	 PVpyUCi1XHEvx1UKmHfd9X/aocWCVpRVetelBhgga0GVLOe3et6mGwkikNG71c9KUJ
	 3iUO/D01my+P44PZj7ixDt52sYIsbwWTdqoozT2+iSG7iKeD287zIC0CNifUSQ7PzP
	 0OClCxlnVSCCI9POuJkftE4PJx/b3A1b197QLuJRXdvCD6h5F8VRStdtr+0HRg2LnS
	 Kj1namUha1cWGgVbOKObs9Eg2v/0vkf+G8NK6iC98uYKCCOJwQ1H47kDwRr01s3L1d
	 FIKBX+lo6l7qdqO7beCNX04iJaEBN0eq7l1lVBoHw0WFig4a8uV0Lc28iBRho02CQb
	 CXlVybkOvsmbA4iCNgybbxLrFnAuuNKZx6VjwG005zg4DBJiadgEF0GwyZ3GLUvO2R
	 cHTPjc7RQ2etTLjD3/+UHkeEeOjyJSotDeKxqcuIYfAz9bHqOZ8XYVXDcyPgJoOOIf
	 qa9YjHcCLtPHYFuz1twtOEpXIMEBakfPq7L4TDg2VAf09Nw+1pMuH854B4wLbt6YSl
	 WWLkq3BY/TYZyu7x38+XT/CGiB3u+opLI5DLUJ9wTCjdp63OhVLlqb554lzIjCsrdr
	 cYLYu8DX4QY12gfcKiAoTIe8=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F2D4F40E0214;
	Fri, 18 Apr 2025 20:45:03 +0000 (UTC)
Date: Fri, 18 Apr 2025 22:45:02 +0200
From: Borislav Petkov <bp@alien8.de>
To: Matthew Gerlach <matthew.gerlach@altera.com>
Cc: dinguyen@kernel.org, tony.luck@intel.com, james.morse@arm.com,
	mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Niravkumar L Rabara <niravkumar.l.rabara@altera.com>
Subject: Re: [PATCH 1/2] EDAC/altera: fix cut and paste error
Message-ID: <20250418204502.GGaAK5zt0verzZOQAd@fat_crate.local>
References: <20250418143052.38593-1-matthew.gerlach@altera.com>
 <20250418143052.38593-2-matthew.gerlach@altera.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250418143052.38593-2-matthew.gerlach@altera.com>

On Fri, Apr 18, 2025 at 07:30:51AM -0700, Matthew Gerlach wrote:
> From: Niravkumar L Rabara <niravkumar.l.rabara@altera.com>
> 
> Fix bug testing the wrong structure member, ecc_uecnt_offset, before using

A lot of patches "fix bug". Just write "Test the correct structure member..."

> ecc_cecnt_offset.
> 
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@altera.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
> ---
>  drivers/edac/altera_edac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Any

Fixes:
Cc: <stable@kernel.org>

tags for this one?

You probably want this propagated to the affected trees no?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

