Return-Path: <linux-edac+bounces-5594-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B18EECF0B94
	for <lists+linux-edac@lfdr.de>; Sun, 04 Jan 2026 08:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CAE6930056EC
	for <lists+linux-edac@lfdr.de>; Sun,  4 Jan 2026 07:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681DC2EB845;
	Sun,  4 Jan 2026 07:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UbrFyJTu"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935512C0F83;
	Sun,  4 Jan 2026 07:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767512424; cv=none; b=sdrNyEChyiCu53bw0iA3AUNuBCDmOwG0Pae+rBRLSQLVsHZVTZ8xAI9mIn40sXJQ2e71477UAZRvY+n7KNvHa35UqrAYlQsxWoOii41+U8uXVUStNRaiFW4T22sND3wiDXac89kbYQzaiL74q0ntPCpaTUDu4gUvIlXw67dA9i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767512424; c=relaxed/simple;
	bh=W/Uqtqxww2ieH9bt4FpJO15jbtWTBOrjQZe/Cyin8r8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKs1K0kbZbFVrcZQT3Nm3hZy48yErM3BsG3LermM1uvuiAFApTE8UxXd0i77FxPdezN/i7VmcxyOyhCn3rt4bgIDGRPOtGQTQMeRoIyjANrwR2X6QyqyJSAYMqXy5iY2V44yE7u1UY8sq2Tdg6Fjo0nnPr8UbPdsPhGpDNZBCYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UbrFyJTu; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 44F1840E01A9;
	Sun,  4 Jan 2026 07:40:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ELooDslI3c7d; Sun,  4 Jan 2026 07:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1767512412; bh=C2DOlp/Dd2QWf5LJvYulLRzQu+CXNN3VLRfzi0tEByg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UbrFyJTu6eYjAkGdDz8F9QRPL5Po/8kglGKfg6MkxOqxd1CZUZF+itakEmqjEnI0b
	 9bMjh7vZSlRDnc/VvsbIIEUGN3nZ9/abIv8lFeBSK7x1ThgBphhO7s8bylfeguqtBy
	 Cgu1ako6B3AkS1MmLsKpsHyeksu9DJFro6sLN0t2I2RBvjoPK4hkTurEnLV0qlhD2l
	 V/Ddb5d31rBUdbluq6Z6Oq184IyQEk4YwnJaWWqsagPee+ELxYXUyDKlrRK4IYy954
	 7/Sq1YLTHlxiCHXp2avAVnG8V7PFbBYZjLmgPZ65ILp8dBxWgPVYS/mbvAodFCmWCi
	 /ahFAAzYJvAoSLLX2EuPFh1ROZfuUR5ND4rb9GB6rB4RkHpZdC6L7S9pe0xXHzhthS
	 xEyy1ooBlbpGNmWl9c56uu4yHGjhE5mvrh3VMlZZ2K8XLzSaKi3V8/K3eBrmgqxX8k
	 8pI8uHp2k+XiGYar1dyUwk1wcNY8ydn33j6gmpoZTVAILojTg/dZzn8uWy8PUbQyCA
	 NX4Jp95oOA904oNUXvdxBhzXX5sBQDAVvJUXSVJhd5SXHcmYJvoOfrLS+3t6igWCn0
	 M091OANJXTgY/dj7q4iOW4StJLPJoO0c1Xek6jVdBZDWPuIcteeygDUVmdLmH84RNt
	 dFRQduG0oboiaaWygVy4Ya7E=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id D4F9C40E0194;
	Sun,  4 Jan 2026 07:40:03 +0000 (UTC)
Date: Sun, 4 Jan 2026 08:39:56 +0100
From: Borislav Petkov <bp@alien8.de>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Cc: tony.luck@intel.com, dougthompson@xmission.com,
	akpm@linux-foundation.org, juhlenko@akamai.com,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] edac: fix a resource leak in i3200_probe1()
Message-ID: <20260104073956.GCaVoZTKvmnBN4jnqr@fat_crate.local>
References: <20251223123202.1492038-1-lihaoxiang@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251223123202.1492038-1-lihaoxiang@isrc.iscas.ac.cn>

On Tue, Dec 23, 2025 at 08:32:02PM +0800, Haoxiang Li wrote:
> If edac_mc_alloc() fails, also unmap the window.
> Add a goto to do so.
> 
> Found by code review and compiled on ubuntu 20.04
> 
> Fixes: dd8ef1db87a4 ("edac: i3200 memory controller driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
> ---
>  drivers/edac/i3200_edac.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Both applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

