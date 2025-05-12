Return-Path: <linux-edac+bounces-3880-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CFEAB30E2
	for <lists+linux-edac@lfdr.de>; Mon, 12 May 2025 09:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C0FF7A9D96
	for <lists+linux-edac@lfdr.de>; Mon, 12 May 2025 07:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7989A1D8A10;
	Mon, 12 May 2025 07:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="a6lXuY/k"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8965255F48;
	Mon, 12 May 2025 07:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747036575; cv=none; b=gvGACuc5Esh5zaPCQqTnRfGVzexTbMexvdpGCwepuRnjoVJV/DnIGl62uCSYmQCM+LJaJcHlwphPHoSnQlp2uCGd96NTwsfjbvtI2W9mfo/q7J6sGt1ImbQvV0E2CyM+UmpCuRLHy0Lxc3ssHw8qST9jIqyJ9S3BwDcc2Ehi0VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747036575; c=relaxed/simple;
	bh=9Glz5LZDc7HH2FSiAtq3LuSpQaYGP+6gOkpN5kwj+zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqcQYjlWNJAExQob5xrQw5bbtEorfd7UwWElacjdOorxiGurWXPzChKBLbYYdUb/ikIyw/vljSmB4isCyRyKaSyU+Svqif2Yw3awzOID26PLsWL1dJL5LEUZL6GRQ/XoFSiBd40Qxsv5/vbSDWTS2k8qzQ458Va4yITvpatLjCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=a6lXuY/k; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 223DF40E023F;
	Mon, 12 May 2025 07:46:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id VHyi69vfs-C5; Mon, 12 May 2025 07:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1747035990; bh=oKhGyt1QxbrnNI4Wnk9jzdBGpu2nyB7Th8n6nIIp19U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a6lXuY/kD0AoY9lSeAjkmxqiwqvuvQuXahuLFky6BB4qkONTFiCwZDTSouQYvP7wu
	 cC3L2KLty7ZDAHuOruYDpzFE+A5Uk14j2h4etV4zCxTfAuVpudRX1oec/f9yDxPoN9
	 jGvD8wp/+QyXoUwM4kHQEMJLNj7qojvOM0wqhnLAgdO5DS7u+Qwtb/3TNzyp5Nlw4r
	 bWM57GhGP38IhzyvYO6j/0SQrRrBoE38pa3+YSCzSBJDSSbdL4Jnm35BAK7FLjJ16D
	 0Horft1GRUIsOIylQatBo1jhDMJjzUh8V43RfVsBAA8GPkrv+3Ir8okJGijs2EnzsL
	 +2Dv6aex3FBnDsemBmuv+2zPRH/ESBOyI0dsd7UIulLJh8eOfdynALMCYAdz133e8J
	 bVCkBCyXgfznn1s4zj2o3ayA+TZSKZ+gkpP3lMFyZK/gcFpaA9emtDT56bTXHlgtHJ
	 58RtEyGa3ZmysbX6wTT37LSbTH1XjeK7OpmC8rdTFOZmMQh8z5EgbKRstZDfH6+6QU
	 /jxnsEGO9o3tk2cYwPzWg8blfPBIQz/wFkdwtAkB1MjhCHWM6YR204m+AlFoL50wJs
	 xPuOBi0GnkP9Q1sopdO9eG8mCj9C5Ivh08lUkM3jXrOgbDcU5vw0JWZ6GigAJWWUfB
	 5K+5V0IeCh49Jp04jX62tmEA=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7F61F40E023B;
	Mon, 12 May 2025 07:46:23 +0000 (UTC)
Date: Mon, 12 May 2025 09:46:16 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: Re: [PATCH v3 17/17] x86/mce: Restore poll settings after storm
 subsides
Message-ID: <20250512074616.GSaCGnSJbBpToh2VM6@fat_crate.local>
References: <20250415-wip-mca-updates-v3-0-8ffd9eb4aa56@amd.com>
 <20250415-wip-mca-updates-v3-17-8ffd9eb4aa56@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250415-wip-mca-updates-v3-17-8ffd9eb4aa56@amd.com>

On Tue, Apr 15, 2025 at 02:55:12PM +0000, Yazen Ghannam wrote:
> Users can disable MCA polling by setting the "ignore_ce" parameter or by
> setting "check_interval=0". This tells the kernel to *not* start the MCE
> timer on a CPU.
> 
> During a CMCI storm, the MCE timer will be started with a fixed
> interval.

Why?

If a user doesn't want CEs, why are we even bothering with CMCI storms?

Might as well disable the storm handling code altogether...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

