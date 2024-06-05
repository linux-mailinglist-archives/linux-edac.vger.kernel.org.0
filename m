Return-Path: <linux-edac+bounces-1184-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEA58FC6F7
	for <lists+linux-edac@lfdr.de>; Wed,  5 Jun 2024 10:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B61641C233DB
	for <lists+linux-edac@lfdr.de>; Wed,  5 Jun 2024 08:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792FC7344C;
	Wed,  5 Jun 2024 08:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="PyIjdpIi"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6DB1946A9;
	Wed,  5 Jun 2024 08:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717577524; cv=none; b=gj1oSoqtk7DlzUx+oDiE1BVWPXq579+xzm1qp0EdDMoVKQIPNaYaZ/rwx+vADW//ycP2pvMYLh40sbShUc6jZcqABQh1p5npb1FtolHvKnfdGFak5xPdQ97JkwYQXdhc1V1bUwx+C5K/v00aK+0nN6cbiX8f2BlNzm+2GMWR46g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717577524; c=relaxed/simple;
	bh=KVo0CDA7CinqPGCJH+/lMOn6Db3ejCQh3A/WJGsD9hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VxiWfH7dsX9fSxfJsuIM9wdluAslQi1AW7r318377TYoBna/Lh1k/7LW8N5DuuX69z9WAPOkOjJtQ206LWEIUSN33s5bBQ6LU3hfE6o/Fuvy1Yey2dydtMysOGJB25kdTCpRtNNP0XWYDwYjZQDTzMFUYP8zphkleO6DRkO5bSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=PyIjdpIi; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 442BB40E016E;
	Wed,  5 Jun 2024 08:52:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id mQSl4PYr5Z_z; Wed,  5 Jun 2024 08:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717577515; bh=pc9sf9qZhy+fcRBG5stiu+nUi7lrBalV1BjEV7RY3dA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PyIjdpIiz6n5xuGF6CqjtbullZqVyf1/akA89RidHLs/mr9cKNVEeqklBDxhQaOxk
	 f9a7n8EHGPrONbY8EosT3V2iM4TVPm9GFwr3lngPfvtTzbt6udbKgqtSdZv4e46d/M
	 K6yi+q3RYhy6D1FQLXZCJK88ln6zTFSJqukyu7EyBGR4K8mAwKCoJWNL0O/8nbEu0n
	 LQMTHtBtxiPlbi/4iBI5RbGW6QEuvRxGFfOrwvdbY8Ekunh/BkLbmJK+DzL4lp3sYw
	 dT/c51m6ZnFMtkqdtenkdJwAmIXG4Gb2+Q11xn1sTmS1NFKnDjyDKoLvVxM31FYdMW
	 5dB2muZys7d8QS4Yn3eb3MwXYnwrdZ0bFEPd2ENYt0s50SR5VTK54xViVti5wpKNu7
	 yYbgD6ZYkfZJOlnB35cOTCSkKv4Q22hg2kpe6US0bWfvpUlntIijfVI8E4WZBD8P09
	 KlFA4JuxreDI3nqwBmFzBTjpLdh0O5CK0tdXblFe7E2o5HGPAs1+tzQIh8GATZHayA
	 3S1NHn3bi3ZBrrfVxfLZzKVA5+FkVb9XHfg+uRWNZXUymGRYRK9+Z5NUHmlYuDR5ga
	 WIxjx7vQNRUqm0niRE3j/oubo/vIeR3fdcnbEbAI4Dj+HOMiMXjWGBIPbv2L+4w8Pn
	 PAJotargnDxkHQtfwDgApDoY=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7566640E016C;
	Wed,  5 Jun 2024 08:51:48 +0000 (UTC)
Date: Wed, 5 Jun 2024 10:51:42 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Guenter Roeck <linux@roeck-us.net>, x86@kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v3 1/8] EDAC/amd64: Remove unused register accesses
Message-ID: <20240605085142.GUZmAnHiPyhceOBvWc@fat_crate.local>
References: <20240523-fix-smn-bad-read-v3-0-aa44c622de39@amd.com>
 <20240523-fix-smn-bad-read-v3-1-aa44c622de39@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240523-fix-smn-bad-read-v3-1-aa44c622de39@amd.com>

On Thu, May 23, 2024 at 01:26:52PM -0500, Yazen Ghannam wrote:
> A number of UMC registers are read only for the purpose of debug
> printing. They are not used in any calculations. Nor do they have any
> specific debug value.
> 
> Remove these register accesses.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Cc: stable@vger.kernel.org

Definitely not stable material.

With that tag dropped, applied, thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

