Return-Path: <linux-edac+bounces-1450-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF00926BBF
	for <lists+linux-edac@lfdr.de>; Thu,  4 Jul 2024 00:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13637284637
	for <lists+linux-edac@lfdr.de>; Wed,  3 Jul 2024 22:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBB318FC7E;
	Wed,  3 Jul 2024 22:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="lQ9JcN7u"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9969913C8EE;
	Wed,  3 Jul 2024 22:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720046798; cv=none; b=UYDRjOSPD5hKu4Ya1N/0ezInJecrubS7kJqpTpWTF0w3Wx4vYP7eycz5ttt1xfZdISjCZFs2WHm5m/UdLezsE8NFMzrSzDD5ZMwc1zYLG8EYcukVYg4IoUA68lSvOei4X+RI/Ae7jw0wgHLxdVXgaPPGwgBUzVIAik2gSKyhxAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720046798; c=relaxed/simple;
	bh=JJJ12lNXuIbwooXoYwbH6PTqCB9tKCRzkL1V8+ooC4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcdlGNbP6GGKsytEcj1kgnfkaudg7bqf3/fEAM8wZwoo4iEZJ67wUSI3UQjd+H6sGuIswwPKApHbcUxvvlOodrYWc+0dCqNdmSYLn/sOqeCe29sroaNF86p9KqUmFbEISvui17ypdOm5035xbm9Ku/zDBrVcfQZKFEMfqpguj+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=lQ9JcN7u; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id F155240E0194;
	Wed,  3 Jul 2024 22:46:27 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vfJyq0TgD1hn; Wed,  3 Jul 2024 22:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1720046785; bh=b5Bb4jBo4uSvVka56BV/u/Ge9WVyID8cnF4LTN5W710=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lQ9JcN7u2vylGzTWqKa5/jGLcyTVUmr/g0M3HUiev+spF53J8ktazapeWkvaJnKhi
	 uQioTCCI5nDBMOvRniUZV9VuSmRm2HBu3dzO4aZCKgUQgVNKMFI10b2vkgAQn5fURA
	 OlVOJhTkyOHTDvgjGkD5ftOGoCUB/lDIGx1N6SqbxuWmrkxAULo2Wry0/pgBJdFuE9
	 GWy73NAF4HvuWU9wBL9zzPr6abMf++tUeEXKIfneHTvL2mTHgMYPpCOwsOeplpG6Y3
	 TPMSUZgCktwwqkDxmaUgsjY6V/2Cdzx5zyoCcmaInvUAIYcGv14X4fESy3s11qdS3K
	 lSRSsex/r/AsDvVLFssXfEtKvgeowqr4aHS7kjok7SEm4wdK7e4EcIViPNnXoggCGZ
	 Ksxhx42EnrmXhsMObkDfnr5gIkPxnc4jW7DDm5DWRmuYKJ2CXkZBxJBQKHrjaEzyRC
	 z2uHMDTqZgY6aOyRQr19ejMG6I22GFPL5AgKrBxpj9HdQU/wq3CY/DqiVxmtsjcXVH
	 UUZeVeYQfBQ8+eRCSurrWckhTg5rSYJyNrcfzKePf0YyPO7pvCIC92vTW+MrluNWjW
	 yg+/MxPl8S0R9KLhNtaxtqo45aj0h+21ZuZDBzqWn05LAlQ6UP0G0DnYfoj0Ifs0dB
	 Vb5Dh/Fo+cMrEOLjb3gY3OfA=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D6E7540E0185;
	Wed,  3 Jul 2024 22:46:17 +0000 (UTC)
Date: Thu, 4 Jul 2024 00:46:11 +0200
From: Borislav Petkov <bp@alien8.de>
To: John Allen <john.allen@amd.com>
Cc: rafael@kernel.org, lenb@kernel.org, yazen.ghannam@amd.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org
Subject: Re: [PATCH v2 2/2] RAS/AMD/ATL: Translate normalized to system
 physical addresses using PRM
Message-ID: <20240703224611.GDZoXUs7INLbRM4v1a@fat_crate.local>
References: <20240506174721.72018-1-john.allen@amd.com>
 <20240506174721.72018-3-john.allen@amd.com>
 <20240628074522.GDZn5qEkTXG0EvQ4Lv@fat_crate.local>
 <ZoWxPR+A3xjV1Y/j@AUS-L1-JOHALLEN.amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZoWxPR+A3xjV1Y/j@AUS-L1-JOHALLEN.amd.com>

On Wed, Jul 03, 2024 at 03:14:53PM -0500, John Allen wrote:
> I'm not sure this works the way we need it to. If ACPI_PRMT is not
> enabled, then the norm to sys translation function will be referenced by
> the base AMD ATL, but will the symbol will not be found since the the
> PRM file doesn't get compiled.

So you don't delete the stub but you put it in the internal.h header:

#ifndef CONFIG_AMD_ATL_PRM
+unsigned long prm_umc_norm_to_sys_addr(u8 socket_id, u64 umc_bank_inst_id, unsigned long addr)
+{
+       return -ENODEV;
+}
+
+#endif

Don't be afraid to grep the tree - there are gazillion examples how stuff like
that is usually done.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

