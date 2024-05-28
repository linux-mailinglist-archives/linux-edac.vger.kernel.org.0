Return-Path: <linux-edac+bounces-1144-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 249E08D181E
	for <lists+linux-edac@lfdr.de>; Tue, 28 May 2024 12:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99FD9B24D4A
	for <lists+linux-edac@lfdr.de>; Tue, 28 May 2024 10:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF5573471;
	Tue, 28 May 2024 10:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BXWF3DUY"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B70217E8F4;
	Tue, 28 May 2024 10:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716890861; cv=none; b=Xd+/OQuA2/RE4mIS/FXBCqBD3G30J5Wh0QitFLtH5jDuhN6GIqmgOi5dEdl58dSvSugNJbXT9011Fqg2wknWuYL5m5QWwgppIDvMV4KDj8kU+tOSXZOE/lDAFkbkhGHJdv6kHgO/eQz8zXmgXM4cnorqz2bU6zkxnavXAkaFcM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716890861; c=relaxed/simple;
	bh=+ZYEMFcqmzLwnP01IoBm835po65oMF/BzJpUDPLTk0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LeqOvwxb8LFzr2DxH1IzaFXxAAnBKfF/tW4XjdeJvls5fJfYA87t+VnxmDbBFhuk5/n7kBhj7ZnqtFfn7SOoKpcrswIBT64lWczV777uylhfJ+X8xGRRspufIOuQraDw4j8AzVr06Xxi+9q7cl0hUHALYvLUML0GZ5ZvEdknEoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BXWF3DUY; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E03F440E0244;
	Tue, 28 May 2024 10:07:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 43y5TOyS4lJC; Tue, 28 May 2024 10:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1716890847; bh=U0faEDKtC8qncKty9rd5V0UxQxSNEunFpuGzmcnCf24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BXWF3DUYKB7+ko3vv+w4qgq6TEwRTPgDe6d5qcmUGzv82I6EhPJ6pRWiYOI0pr9tQ
	 KAsvl2Kjs7p584wdBgR7AcMCb7JV+Yrj7Q6u/d5/S+z5qmo8LPIE508fFdyw/+iugC
	 7cSoL2iHjGcMe/YGvFSDa2Blr8heLFPQ+IsZAxRLSC55ugtPGHlGhjvJEP+t3H850t
	 gDSJdhu4CAB5/lGZS2B43XOi3YXRnpEq3E0wb6JJ7XE8rCqVZw6A7f2D9w9WqF2QCu
	 HPFiDt/+GrtGSkmM4xybYz7qBI7OeUJhPM/aZna9iKRZY8XxqxVRgcIN9jBsevO7cG
	 9luVle83miCdhEbGeq722lR0AooPoA5K2hp79zoyroNr2qt1BvcElLLpJMTm5/kADW
	 HOz2bevz504iOw9nkEMMUvyONW/s3OIZ41ZdaJbqS7TU4qB6LU5p3CaM5UslPnP9VP
	 P9rQhMLmDwzzD1NO9IfRXg5G1urVcOHSFDYptI4Nv47RqT/5B1CUm6H5Q+m08VOex4
	 +WCCy9u7EsWoSBXTP5HBaSWeU7hNlhvwWbWkqBmBBRvpZ6ZY0hWKCDw89xXU2eKdP9
	 LdznqK/XyQ2aBUZYcUp5lnXHje5Enozq8YD/C3omnEkjqXNDGcewEE9KpsU2mU9Mo9
	 O+3/MaN2TI1ipAf2/u0CFtfI=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B5BF140E0177;
	Tue, 28 May 2024 10:07:20 +0000 (UTC)
Date: Tue, 28 May 2024 12:07:14 +0200
From: Borislav Petkov <bp@alien8.de>
To: John Allen <john.allen@amd.com>
Cc: linux-edac@vger.kernel.org, tony.luck@intel.com, yazen.ghannam@amd.com,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	muralidhara.mk@amd.com
Subject: Re: [PATCH v4 2/4] RAS/AMD/ATL: Expand helpers for adding and
 removing base and hole
Message-ID: <20240528100714.GEZlWs0qL8tmCb9Mw3@fat_crate.local>
References: <20240506154605.71814-1-john.allen@amd.com>
 <20240506154605.71814-3-john.allen@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240506154605.71814-3-john.allen@amd.com>

On Mon, May 06, 2024 at 03:46:03PM +0000, John Allen wrote:
> +u64 add_base_and_hole(struct addr_ctx *ctx, u64 addr)
>  {
> -	ctx->ret_addr += get_base_addr(ctx);
> -
> -	if (add_legacy_hole(ctx))
> -		return -EINVAL;
> +	addr += get_base_addr(ctx);
> +	return add_legacy_hole(ctx, addr);

	return add_legacy_hole(ctx, addr + get_base_addr(ctx));

That's still readable. :)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

