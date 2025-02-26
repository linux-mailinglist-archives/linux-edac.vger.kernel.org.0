Return-Path: <linux-edac+bounces-3214-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C50A45B1C
	for <lists+linux-edac@lfdr.de>; Wed, 26 Feb 2025 11:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E570D1886C06
	for <lists+linux-edac@lfdr.de>; Wed, 26 Feb 2025 10:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADCD224252;
	Wed, 26 Feb 2025 10:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Le3des8k"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BDE258CE0;
	Wed, 26 Feb 2025 10:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740564152; cv=none; b=F9mFxKU1ql7m6dSFPPKjpmrGgV6miGikFial6K+g6Uz/G2hCwffjK2VgZERSg3vvf9LOptgIzMvQTvkwztfUSsYP4N3NtHOTW9cGwNBYeBLZz7ognLTcBz1dzmDIg2dOWlQPa8G2iMXc02cWZ9RsAIHDXVl4Wx8N9e5EDtaF7xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740564152; c=relaxed/simple;
	bh=JkUhhZ/cPXvKSQtzh4szKpHGGz2QTCzQdjetDdrqCFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imrCnMaGqnK46lvEFM4I23yNaUuukNwkSk5oVk+ccCunV3c3NQeNuF/Qbz4hskV83yzVG3YEeTtytfxMPL+S+oGpGwD1gHr9gMOXbXfQKJiO4sfEQHSS49urkOSyDXsj7OW2YU8HknkPGGPsko5jfXFQRPNvbknUWsIalFrNLHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Le3des8k; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9593C40E01AE;
	Wed, 26 Feb 2025 10:02:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id tA2Npjn2O4QW; Wed, 26 Feb 2025 10:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740564135; bh=v03n8DOr2MkIC9c2Yj7gwP6LgCGxUWLqysuV5QE880o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Le3des8kGWg8Xhv53rxhKsopjFMjb9KrnGluDkytdTwvgG6axTAucKCHR6e6SQrJn
	 wa3CnHKq6vq34mVz6HpFhjKVGNZUIS83wdaAbw2azpSqFuy7IuF4OllPqQf9NmTZ7Q
	 C5MMy03TfbHKEeD837z5824PCKR3goyMZ9YFa85TGdAqSeRpxS74YT+2jhIbEsqTsQ
	 pAcjJxlFJaD8VyJP/eRj/XlCAp4MVJ6h1x4UCC/dzqpC6U+1tBqZxhm31Z/3V7vyz3
	 HdUN1uMxZbpH+zwgL9jHoqDCoBTdizIuclxm33ssDumnw1ydkVpgVQEknQSFrkEWPG
	 iy13xJsorr849pE8jwxyUba6gWmaR9roALLy/To8CYRMISDw02pDZNzyz/DIQ3CeYy
	 s0YerLKQByqit81PGeMr8Cet+87U29LX65BilwRKo5Fam574Wzn6Q20n0eVuDckdrN
	 l8S9iMAoj3S2vPbiIO41HxTMBRgcvSc8yQY5wnYMHrcT18SFB1/TVoVpB6Vlwzixjc
	 ZqjZtQsII0EjNLHd7vqDUMmGyTk+bxWWmfw/+zKd99lS35jQ2BVYx/as9Zaw1QBeir
	 jGtas7bvyeI+8VkJw63bx7a20nz0Us0fHlGVvGux5JhTM6jLe66ZaFuMwgE3YnF+Dx
	 liUa0RuVRwzoB+bVxP7dG6TI=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 58B2640E01AD;
	Wed, 26 Feb 2025 10:02:05 +0000 (UTC)
Date: Wed, 26 Feb 2025 11:02:00 +0100
From: Borislav Petkov <bp@alien8.de>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Khuong Dinh <khuong@os.amperecomputing.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] EDAC: Use string choice helper functions
Message-ID: <20250226100200.GBZ77mmPgF81n0cB-L@fat_crate.local>
References: <20250223212429.3466-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250223212429.3466-2-thorsten.blum@linux.dev>

On Sun, Feb 23, 2025 at 10:24:29PM +0100, Thorsten Blum wrote:
> Remove hard-coded strings by using the str_enabled_disabled(),
> str_yes_no(), str_write_read(), and str_plural() helper functions.
> 
> Add a space in "All DIMMs support ECC: yes/no" to improve readability.
> 
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/edac/amd64_edac.c | 47 +++++++++++++++++++--------------------
>  drivers/edac/debugfs.c    |  5 ++++-
>  drivers/edac/i5400_edac.c |  3 ++-
>  drivers/edac/i7300_edac.c |  7 +++---
>  drivers/edac/xgene_edac.c | 17 +++++++-------
>  5 files changed, 42 insertions(+), 37 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

