Return-Path: <linux-edac+bounces-1156-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 637668D3F61
	for <lists+linux-edac@lfdr.de>; Wed, 29 May 2024 22:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9417B1C215ED
	for <lists+linux-edac@lfdr.de>; Wed, 29 May 2024 20:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDB61C6896;
	Wed, 29 May 2024 20:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="WgabCIb4"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA26318E06;
	Wed, 29 May 2024 20:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717013416; cv=none; b=PGV4EIOfQHLs1yszeEMT/W/k38joSMtvddT2zrZBkJd3a8DobWKhCQ8sju1jL+E6G2M0EcZ9ejUNAJsKhEMFDSlhYMqYfmI9hZwJyLmKLTkItm2fpFR2YU22EgHWRNrXfnENlScYDyOJJgCwJN7fnXFRdCtkcKV57LNVoEM9uDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717013416; c=relaxed/simple;
	bh=dbzk/a5JW/20BuFXVjmuN0kgqEvg6DNfu1vI8J6pyP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=axyS4Ma++AHL6h7EtafeRWzGxDBCYUAUYbI7L8FLKpT/hPirtDu653gpQchQSeh3q6cVihDa8s42VIssLpcVJFMFT8zWr8BXypRmTzO4eYbL9UdU8bwoX/xKvPERFXyZ3uaQA3mB3Ws4sCbgg1YCDRJ+5qn3j/IiH7Pl18li8kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=WgabCIb4; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4A2D140E01E8;
	Wed, 29 May 2024 20:10:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 9aZzfH1uuNjS; Wed, 29 May 2024 20:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717013408; bh=73f/1KhBwHSD2Gb8IwWVkcZO7O2Ot+HSxzuxsTqHla8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WgabCIb4NzzKQWAKng+Ku1pySu8f4dMlaK6dUr09WEphv6V3RTT7GAmmw3vNWYzxI
	 fCdRoCwa15LY1jvu33E9IHhycngTajHQLXlngeyysDHDVBqfhIoJ+xifXURJwKNGur
	 NU1Qw4QqMkD7M4JG4cPGczj6DwtUwyw2wqdaN6zrKaacqSv75jsV3eX4nRAHqT0/OE
	 4sydJZEeOhcPG5F/7bB5ZDPqDQEVOCCilRX/hhGsIGBEujiQDQhmHnImf62RczCytd
	 KREWAYgaNeEYHAfR5sjbe90vzPsdQ6LShkxaULRnIb8pSFdHli3GJqwP2KIYQoazLT
	 FcmppXhDAQGVesohwh8rc1mMGU0d/CAv2XutnGzm8ZPlD6MEjjV4FmnEV3wQBm4at9
	 jeVSbZbPF040Jk6owat38Xg4qAeldjECj68yOaqjxICqVzlV4F/Et25Keex0TYGP98
	 ckLCuJqwyigXKieICx9IyjLhA1PDk9NTP+P+tpwGzCuvritd1BWzHOoaR1ezlV/gQP
	 fydSQIcWeLKVtMsFW2+RVzfTWT4+rqjV+PukM29kDzmcwBaX0fT/+eqlEElNdkzhfL
	 91p5ke1vMTWBWRpSbo4aXfgKyg5KG8uNMGKO1l9lPxYBkg54x+Qz9UfWA9SdVA0SA1
	 RceWR+37fVS1IJBq+2G9UR4M=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0FE7A40E01A3;
	Wed, 29 May 2024 20:09:56 +0000 (UTC)
Date: Wed, 29 May 2024 22:09:50 +0200
From: Borislav Petkov <bp@alien8.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, Marvin Lin <milkfafa@gmail.com>,
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC, i10nm: make skx_common.o a separate module
Message-ID: <20240529200950.GFZleLjk22m3kt2K61@fat_crate.local>
References: <20240529095132.1929397-1-arnd@kernel.org>
 <20240529193127.GEZleCjwyUtnDv_Nc0@fat_crate.local>
 <fc7f2a95-2a61-4eea-a1b8-b764893eabe3@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fc7f2a95-2a61-4eea-a1b8-b764893eabe3@app.fastmail.com>

On Wed, May 29, 2024 at 09:55:04PM +0200, Arnd Bergmann wrote:
> It has caused problems in enough other drivers that we now
> have a warning for it, it was added in commit 598afa050403
> ("kbuild: warn objects shared among multiple modules").
> 
> Most modules are modified already, and we are now down to
> the last handful. Since the bugs are fairly hard to understand
> when they happen, it would be nice to enable the warning
> by default.

Yah, this should've been in the commit message: it's not like I've
caught a public announcement that we're doing this now... :)

Tony, please add it before committing.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

