Return-Path: <linux-edac+bounces-1190-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B438FD21C
	for <lists+linux-edac@lfdr.de>; Wed,  5 Jun 2024 17:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9294281826
	for <lists+linux-edac@lfdr.de>; Wed,  5 Jun 2024 15:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F17013AD29;
	Wed,  5 Jun 2024 15:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hy6c60dx"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EC82BCF4;
	Wed,  5 Jun 2024 15:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717602811; cv=none; b=mSzgw/6Zdd2ohMNmisSBMdj/4LeORR0GqGzlnV/oHhrGNCgSdS/i7syPSy7pJh6UOb+54dfuveGrHSdXfU7nDYbs90R+y55TU6OIlo2mCxkfcz5jrkp5oemdPr3VhvpTdBPP9J/jJkz2M2o8zhP6LR7qPoM3C1TLKAitDhoxx7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717602811; c=relaxed/simple;
	bh=GPuI67Q4QN2AdbsA+Og7v3ZSXJUY4ThgSpOcmWh8zfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VH+Jd0eQ4x//9iS2tjyV9kIYZRg5DZnMB+YAUaw45PUo70A6dgk2LexK7sUEAoSCPYewI1J9prUgXLMwls2Cv1jngSiyTgJDHvZUQxK+lOFM6xXoeLNnwx7LtzyXqeDW5F0X6HcC8Akrf96Zyxa1aUBqTYWblb73WKqv491zaLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hy6c60dx; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8DC8A40E016C;
	Wed,  5 Jun 2024 15:53:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PJucYi0PQ18w; Wed,  5 Jun 2024 15:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717602800; bh=z0fGa6Mjc8FDWbwQf4t4X0jOVOil0Q5fF5z4mZagBa4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hy6c60dxyFjpVVPa37xqrQGilB6OgRurUK7Y5cSrXOjxyFps8cfi93yqCkzv2EMGn
	 acrQvmvPotepc2/ZIiDXnIv8/qDEI/ZT/ZI7xPy37GmIyJTVSDSxbzELDB7TR6ZmWK
	 umuW/gMldvVF5oCnTTJ7F1quhI5XmNU0OEqPWXFBmMvhMHQnHMJHP86BQZLQZtkudh
	 jRLrMKMUUJzO+rUc+MzpD3NNuiMyYQHmtg8YIBvWz0lYttAATgh8eelINQS4pCgIdt
	 z483i052lE4szpjng1SuftlzFyZfJKkqRdYsThoBKc0KPODr+4glWxLTW6eomGZttv
	 XjzdVDPJL6sMly8zVtBVRats+mnYAte6sFThBejLtocTyrjT1nj3NMqAalC3RerClY
	 +onBfdfoB5QVclZDvd5K/t6FmECyxN56j+U8UMUHPO4NC6JLbpyWvpcZqdp51qnrSW
	 wN8ZjBpvRwyUHwtbwEBB4gp3ytPJJ8n8gymVNqIAFDWFEDsr1CC/96u6Co1pvkrCUc
	 YydNaY5sB4JnWVSGE0Hx17LZFwI4X8A4vP+LjMqkoyrK9VuJHTGPw5laNYBIGDWDyo
	 TNJjSfWj95dp+6p31QyYhTP927XVUQMDBc94kSoq6O5tnGADjOgWXhCoZzmnIs1goC
	 T91aATTFX5DUDDi1y8fDR84A=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7FA3B40E0176;
	Wed,  5 Jun 2024 15:53:14 +0000 (UTC)
Date: Wed, 5 Jun 2024 17:53:07 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, Tony Luck <tony.luck@intel.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RAS/AMD/ATL: add missing MODULE_DESCRIPTION() macro
Message-ID: <20240605155307.GGZmCJ46VkY-hWn_z8@fat_crate.local>
References: <20240604-md-ras-amd-atl-v1-1-d4eb3cf3abe4@quicinc.com>
 <20240605094051.GDZmAyo1-j_uBri_YO@fat_crate.local>
 <1d9e1530-be63-4374-b952-e12b15cee9d3@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1d9e1530-be63-4374-b952-e12b15cee9d3@quicinc.com>

On Wed, Jun 05, 2024 at 07:10:14AM -0700, Jeff Johnson wrote:
> I actually did use a simple script to do a conversion locally, but the hard
> part is determining what text to use for the description. So my local
> conversion just added:
> MODULE_DESCRIPTION("TBD");

Ah, there's that. Can't script that. ;-\

> https://lore.kernel.org/all/20240604-md-hid-letsketch-v1-1-ff38ae7b4cb0@quicinc.com/
> https://lore.kernel.org/all/20240604-md-hid-lg-g15-v1-1-265b094db089@quicinc.com/
> https://lore.kernel.org/all/20240604-md-hid-logitech-dj-v1-1-560f6b3cb54b@quicinc.com/
> https://lore.kernel.org/all/20240603-md-hid-logitech-hidpp-v1-1-060f06e4529f@quicinc.com/

I would've merged them into one - it's not like it is really complicated
changes you're doing so that each maintainer must deal with it
separately.

> I then sent a large patch for all of the remaining drivers/hid patches:
> https://lore.kernel.org/all/20240604-md-hid-misc-v1-1-4f9560796f3c@quicinc.com/

Yap, exactly what I had in mind.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

