Return-Path: <linux-edac+bounces-3592-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F95A93F3E
	for <lists+linux-edac@lfdr.de>; Fri, 18 Apr 2025 22:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA927188C685
	for <lists+linux-edac@lfdr.de>; Fri, 18 Apr 2025 20:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA64A23A562;
	Fri, 18 Apr 2025 20:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="aLtrBZ+4"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6A02868B;
	Fri, 18 Apr 2025 20:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745009555; cv=none; b=UXv5K75oTFP76mgJUXqmr4zBtzeBBjd7EQo6+jGdL1UwrsBG8oBsq88jmnGy2OxiLXFX76k8YAz9syswtodAeS6Gj9mDbsqsLFz6mvUHzmbitLHhXCWGuapIbW2ptBMZvuqi76BDoT4AdoZah9pSwAIJFZHCONxW+txasYSFjO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745009555; c=relaxed/simple;
	bh=OOhK84kOMzX4ELVYm1YOJAx/F+Rkq4pOAWFntcZrD5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1IMrfgqgTBS1V1T4TFw8xZr9cIrCe0ImYF5fG0ccQ19nmS0/AACVjINZi/MjGMWBuIT/fy0wgUzALiD6Hz8K+c7aodKCDVGZ68YmIwKhaDFsqTuCdzJu7bf4Cc7Gb2QMa0WwVzszzBde3ASU39j62gUHGHeeuw119jPBaugQHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=aLtrBZ+4; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C272640E0200;
	Fri, 18 Apr 2025 20:52:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Cr-r0VT2sgz0; Fri, 18 Apr 2025 20:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1745009547; bh=IhINhiXAjZodkvSqUkNpE5uFJ6Xp0i375N0Si9ptnh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aLtrBZ+41SILwEQxAihRq13soDv/74B3Oj/UYUMKP2Kf6Qp5Gem1XHxanKrOCUQCh
	 CsaWA0L3EAPb0cJ0ahUAC9+baFuj0MOh/4GBoNDY6f8C17fPyTxufnsdS+6XUfKXVu
	 hNyqUYJpgI1wVt4gc0P0heeGxW0E41g7g/++UnnXJG6161p6L2Ape7pUCOsArSmSiO
	 JD0SjlwAKC8pOVN9pJoK/8YpkeSRWE4NyjNwfYC02bnH6mNyvAs6ND/RxPqn90swb5
	 Gx/CmTG5jpA6lxpTJgApAvdusRzdCq1vmX3WJb7Yg6Kic0iMSLple89a1g2v7J4klv
	 hNPRZrkskL5RpKDvV2f0cbwPcszIsYqxjwqeQYTFAydGzI+zJ54FEZbbb2shwlPPf9
	 j7IwWI+myJm6syczGkgA7PGzszR6aH5j8tpTj9WlwmZyxAbXVjn0L7YmYTNV+hiavw
	 TcOyeGnmZtPE6JUOC7D+Muai6u34oGecfoPxorkCZns24ylC69M9kMEO9MZmiowBdf
	 s7DW9bUa8h7WUWcJBsE2kRj9ODN6PjT37TLP403IefTmCA5KyAMLZnqVa/CUJErGBg
	 OwhSYzkI90IsFodq/IIdLFaTlFyuvD99MW4iuW/wlb2pKBcOYx8qDjKj2pVC7MCXLp
	 bQcyGcTFjpIAU8vGI9SFZW7s=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F159A40E0214;
	Fri, 18 Apr 2025 20:52:17 +0000 (UTC)
Date: Fri, 18 Apr 2025 22:52:16 +0200
From: Borislav Petkov <bp@alien8.de>
To: Matthew Gerlach <matthew.gerlach@altera.com>
Cc: dinguyen@kernel.org, tony.luck@intel.com, james.morse@arm.com,
	mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Niravkumar L Rabara <niravkumar.l.rabara@altera.com>
Subject: Re: [PATCH 2/2] EDAC/altera: Set DDR and SDMMC interrupt mask before
 registration
Message-ID: <20250418205216.GHaAK7gIRlWPSSoL-7@fat_crate.local>
References: <20250418143052.38593-1-matthew.gerlach@altera.com>
 <20250418143052.38593-3-matthew.gerlach@altera.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250418143052.38593-3-matthew.gerlach@altera.com>

On Fri, Apr 18, 2025 at 07:30:52AM -0700, Matthew Gerlach wrote:
> From: Niravkumar L Rabara <niravkumar.l.rabara@altera.com>
> 
> Mask DDR and SDMMC in probe function to avoid spurious irq before
> registration.  Removed invalid register write to system manager.
> 
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@altera.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
> ---
>  drivers/edac/altera_edac.c | 7 ++++---
>  drivers/edac/altera_edac.h | 2 ++
>  2 files changed, 6 insertions(+), 3 deletions(-)

Same comments about this one.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

