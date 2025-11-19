Return-Path: <linux-edac+bounces-5479-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D145AC70620
	for <lists+linux-edac@lfdr.de>; Wed, 19 Nov 2025 18:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 663CA2F5C9
	for <lists+linux-edac@lfdr.de>; Wed, 19 Nov 2025 17:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6805933C1BA;
	Wed, 19 Nov 2025 17:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HgP4j1yP"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A6133A6F8;
	Wed, 19 Nov 2025 17:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763572590; cv=none; b=PRz1eGB8z+ZKHSJj+r24NKULQoNc8Sx0CZuzuYjfOTsXEBxawFyRwpgE6FAmzVxkg0wlqY/RcvSRg/b50lmTyf62zAvKnKGuj3R3/jxyQiDgU0Ph+XEMvC6Mwcn4cDf7BKb5zcYr4gbLyw1Qvb4IdrVTunrdtTgdCYFrqiEd6Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763572590; c=relaxed/simple;
	bh=V80Y0SYuZzvlUZSXgNKeerq+Fj3pSU5R7Tjk9bHDih0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6DMQEwHDLAIIRS0vc0VRQhx0zVg+VBVk3PfrTON9JuyzKxkpH/T4nDkK5kBfZ3sEdvZ+n9knz+MXvZoEUnhj7kIUKXBBtxboyTYBZFJZ25k0h9CdgKMTHV8ioRhVSnFmT9aGYdEv5HRt099cu7U5bmOtIc7AqfJfLRQ3sIgihw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HgP4j1yP; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3A40C40E0216;
	Wed, 19 Nov 2025 17:16:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zD-2kN7OVgPk; Wed, 19 Nov 2025 17:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1763572577; bh=8HWfHqM4OgOLE3rOk4OkVQNQHx2rKRbYaFV9FHCUWuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HgP4j1yP+7dLHtYUB/E/2NEZS0zVF7X8UbGr4hrCMgMvuGVY8tAMgOX8hI91kf4Se
	 MnNGb8ZVu9RDmi0E9s8+OPrVTWMNGIOCn/pCGSGVpojisAG/leKMZdfnmrYjQCUSlO
	 zJy8sKgxwzazdUQkFxKzSUAYWf8+fbHpGIgXeC7I/4TvvZzv34MlqT35+robSAZs2D
	 KYto2mIhsj4kShJagxScfpm8CiFFMdab7g/jiFAKRV7ldeXxL4h1dUyKQGlS96mbQp
	 udBAFRexOcWSKy7Yxrp3b1Zh3byyEyUUyliFAdlM8WE5dwiHIqQxHENg38HW6/QkNf
	 3al7Kw6v0cCZ5O38baUXB99y7IuRg03YTcFppkoFqQYWmRxYvPXs+7sUcAPFYyXxu9
	 UK2QXydkN/9ukSbFnhIIQCOHQny11LXU8tgnIqN22eivADIQJQR0NZRzzMGfYeaTpq
	 zmjHyi5yC0SnfwXJ+OV3l5LIaZxaPD+aEniLV4BfULeyq341Kgqt1ZPVOtEzE9kXYR
	 RXlSf0KU82F1MAglsJ/GC8L6x66/laBsTnZR761YpeXE7AEqOfURpvva4RS9Vd9YTz
	 /Z0sC51QqeK+YRISd3fQ6hLDkPagp3God8x8wbtLMkjRwTZPCzxZ8JI2oN4SVrUCNv
	 e5Jg7uDC9wzqXMDLZ1qxTUAA=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 3781B40E015B;
	Wed, 19 Nov 2025 17:16:12 +0000 (UTC)
Date: Wed, 19 Nov 2025 18:16:05 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, "Lai, Yi1" <yi1.lai@intel.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/7] EDAC/{skx_common,imh}: Add EDAC driver for Intel
 Diamond Rapids servers
Message-ID: <20251119171605.GFaR37VWsqvQX8sDED@fat_crate.local>
References: <20251119134132.2389472-1-qiuxu.zhuo@intel.com>
 <20251119134132.2389472-5-qiuxu.zhuo@intel.com>
 <20251119152430.GEaR3hLonaUag36pFg@fat_crate.local>
 <SJ1PR11MB608363D7FBC9BF58DE3FFACCFCD7A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB608363D7FBC9BF58DE3FFACCFCD7A@SJ1PR11MB6083.namprd11.prod.outlook.com>

On Wed, Nov 19, 2025 at 05:05:15PM +0000, Luck, Tony wrote:
> Periodically its time to stop heaping more uglification onto the current driver
> and cut a new one.

So is adding the new functionality going to make the old one ugly enough to
warrant the clean slate? Is the integrated memory/IO hub the new thing that is
going to be done going forward?

It doesn't get clear to me from the history (parts of which I remember too,
btw. :))

Don't get me wrong - you're going to end up maintaining all this so I'm just
playing the devil's advocate here.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

