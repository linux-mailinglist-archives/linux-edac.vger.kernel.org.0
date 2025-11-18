Return-Path: <linux-edac+bounces-5455-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FC7C69666
	for <lists+linux-edac@lfdr.de>; Tue, 18 Nov 2025 13:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 06AB52B234
	for <lists+linux-edac@lfdr.de>; Tue, 18 Nov 2025 12:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8BC2D4B66;
	Tue, 18 Nov 2025 12:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="kd7Nl+a5"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34B919E7F7;
	Tue, 18 Nov 2025 12:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763469252; cv=none; b=g+4qn6OE5nXhVz/mKmAOaO16Ryr2r3jJ5QuGhKno+Zlc8eCS6tUwQ7Ta6zqgnDmWT6ZfKO/o6isUbkf60QoS40Xv5xo1lpV7HdIMtENWjwj7zyqo4bF56mkcr+0ym2MHHQv5yTW8vrGwmyX9yR7g1ZOWVAZIi/hEgrZZb+sHWSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763469252; c=relaxed/simple;
	bh=Du3wG7BUDkFfqjUWXMfI/MBlAnN8RyKGu7QvyGbJq34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+J9DJJ/wiInnGTxjQeykOGUHf4gtYTM2AtU0kYV60ETyBWbMTAYAKfMkAhWrqDG9Uv9Xjm7ORx4ZFL3Nk3Exg0ZwjbxvIsRf6OFPhINiPp6BvKRz5y0U6Th8knN5rp3j/GLHoMvglQCnFcTM+hA5HXaNQyzZfjwBTCCrTw3rjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=kd7Nl+a5; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9612C40E01CD;
	Tue, 18 Nov 2025 12:34:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id pv4sv9cKeaPb; Tue, 18 Nov 2025 12:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1763469244; bh=yXwC/i4DShB6VVRSOU6+wYh0x2wBJXrtVjgJn9HpWQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kd7Nl+a5LUrd7ny8/fHeSAYSBDKFwm8QS9kqTufyUyfd+i8bRKRoFl3KCyXaB1JCe
	 Sex16oclJQ2OHmei+CneOyrxf0cRSd1CMDcORdcXzoPpZeTEeMxeYt8AqlwHcEkWEp
	 KkdT+rCg6CjXiMR+tf/uYZCljNXPL8DRCEDA4/6OI46ONSCazuSQStLgkH+HIyipyY
	 sAPQVbFwfcvbGUjSnPNLuhivoIBt2LwKcKIlXD5TP1LB5EWSONsn2m4v8Abxz1M51G
	 cDfexcNxgDMDy2hmpLaZ8YNqtGTBPISyGBE8ii5mfQQSNkomj3Vl6N3GIEM0DWCaBp
	 4I0tstq3VSatxYNpIKHWRPSSeXAxLIVHXt3k67KcKfRF3V5zUlIvAsJE0HlOSAoF5c
	 ua/VWv2yTExqOSnttMqQHqwoxGyfTtkwOVtg522UxhfTdROU4XkwIDRb9MoI0X5B26
	 1EiwfVFQO6v1xxNC7wZEbEWd9bOrAydY890+WpvHLntyUPk9IF3Z54B9Nhm/eT0gpx
	 Tqj42nrqpOuS4B0U9GMU/ygsfsf3x6un6kiZG/ufA6aH592bNyqUqHtya/46S5iWlJ
	 2b9s+/oxcS5UzJR6Huuccw2Z0CmIQBTTZ+3GXcf5pdW6mwy2yNZ+aDCWxHWMDDvzgG
	 e6YGl9krohafJt9DxS3tEIeQ=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id EFF8640E0216;
	Tue, 18 Nov 2025 12:33:59 +0000 (UTC)
Date: Tue, 18 Nov 2025 13:33:52 +0100
From: Borislav Petkov <bp@alien8.de>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: Yazen.Ghannam@amd.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RAS/AMD/ATL: Remove bitwise_xor_bits
Message-ID: <20251118123352.GJaRxnsHRC6KcbQanQ@fat_crate.local>
References: <20251113111125.823960-1-nik.borisov@suse.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251113111125.823960-1-nik.borisov@suse.com>

On Thu, Nov 13, 2025 at 01:11:25PM +0200, Nikolay Borisov wrote:
> The name of the function is somewhat misleading, it's not just XORing
> bits, but is calculating the parity of the passed in value.

Huh?

It is bitwise XORing the bits. That just *happens* to be the same thing as
calculating the parity modulo 2.

Unless you wanna say something else here which I don't grok...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

