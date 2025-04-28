Return-Path: <linux-edac+bounces-3776-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9528AA9EE28
	for <lists+linux-edac@lfdr.de>; Mon, 28 Apr 2025 12:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3ADD189D22D
	for <lists+linux-edac@lfdr.de>; Mon, 28 Apr 2025 10:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3841325FA0E;
	Mon, 28 Apr 2025 10:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="FqT7ii4x"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE0038F9C;
	Mon, 28 Apr 2025 10:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745836901; cv=none; b=lS0mpW1lPpmNmVEvgTcVtH6+KENmWjstv+oMBN3COaydYZdWFvn3jkdYVwMlYUpC/TyGCDL3ckV87KLyKUFr8FXCX1I3i66PLBM8aZzxuWPB31m3Y4/nT/mMe6hj8yWEWzFwfWGE2xMTjRlCQXosSozAKrMqANB8Bel5GALLfIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745836901; c=relaxed/simple;
	bh=zpndmjIOJY0jV7iDNOvfLsb6vCnmy7a3L/TUik4yOh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FB2Km2PKO2f5s8UvRJ4LSWC5aJnEPFb2Y7iR5lrR/u9TOCw3VL2VviuvAFgElnkHX5pj8a+JstxyuHqKzHkkvVgcGTgCn/iTo1AiJwwflp/7YBiIj88b2CAjMGdEKBlr/8u4hlb8VyPcmNCk97EHZHzswmNCuDXEvjaUUew8rmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=FqT7ii4x; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4F0AF40E0214;
	Mon, 28 Apr 2025 10:41:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id RNVIay7sXf5f; Mon, 28 Apr 2025 10:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1745836891; bh=OBhff9tvGgMS25PpTWgAvD0r7/55ssc+Ah+E01cCjJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FqT7ii4xXPGSGobjl5jQCVxBharMhfoGOE9hWSzQ8eV9KmiNvfTXfK7C8kJCVT5xy
	 mlIRtUA3jhjfJ61ODidQllkKW2JNLZJIb5m7qJaQbAbYcKYyTj0Mrpg2OhigjDRUTb
	 hEVkTeeBXiVkMj2XlHfbN2PM7qTOuZG9I8UJSlk2gXh3nf3oQYCegobZSkuvBypwfF
	 bT8Zq3ptqkwSZBEBdsDFWklLP5YKU+/H1gFmkuCfBRyGEgEaXrjFFhf+2GOQJ5LCno
	 ndAZvYdoj9qsWVLvjK0OJ7FujPPqMKRzBwaPsuQpe2mV117XustfoI1ClBx9INfAOQ
	 ugf1JToQczOR6Xw0lKqC1IeT8Dg/Kx+MFkTF0mX8C4t/ZDStI+tUMQWxGZrs19zTS7
	 5A1S7eqy5EeLYeSxECqBuB/HOXKciWpQzVzH2OzIugcHACUKX+kwphJkp5uLBaiEP2
	 hSvhcPEg/5D8nWPMV/Qsg4EMVlW/ArVfe7v6aztEqRxALjEpwOyBL5PKza/KtD/V9S
	 /XCWlImkUfpXYgpPWCodd8UQ5UjW8E5lSGb8Bh+RVl9rQ0sHaGRalBOh9Da9nutFVR
	 4ibSU9bO459lKZjfX8QnWwWzA27zIPYE97JzrclOcxl45WTMIk3Wv4+ZULG94aEJYq
	 tijqHth0XIC48/I9egJ9ZJ4o=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 06F7840E01FF;
	Mon, 28 Apr 2025 10:41:22 +0000 (UTC)
Date: Mon, 28 Apr 2025 12:41:15 +0200
From: Borislav Petkov <bp@alien8.de>
To: Matthew Gerlach <matthew.gerlach@altera.com>
Cc: dinguyen@kernel.org, tony.luck@intel.com, james.morse@arm.com,
	mchehab@kernel.org, rric@kernel.org, tthayer@opensource.altera.com,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] EDAC/altera: two bug fixes
Message-ID: <20250428104115.GAaA9bSzXJg62faGc-@fat_crate.local>
References: <20250425142640.33125-1-matthew.gerlach@altera.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250425142640.33125-1-matthew.gerlach@altera.com>

On Fri, Apr 25, 2025 at 07:26:38AM -0700, Matthew Gerlach wrote:
> This patch set contains two bug fixes for the Altera ECC manager.
> 
> Patch 1:
>  - Fix bug testing the wrong structure member.
> 
> Patch 2:
>  - Mask HW interrupts until handler registered.
> 
> Niravkumar L Rabara (2):
>   EDAC/altera: fix cut and paste error
>   EDAC/altera: Set DDR and SDMMC interrupt mask before registration
> 
>  drivers/edac/altera_edac.c | 9 +++++----
>  drivers/edac/altera_edac.h | 2 ++
>  2 files changed, 7 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

