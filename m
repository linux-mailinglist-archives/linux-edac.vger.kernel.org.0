Return-Path: <linux-edac+bounces-4262-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F60EAEA0FD
	for <lists+linux-edac@lfdr.de>; Thu, 26 Jun 2025 16:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6726D16955B
	for <lists+linux-edac@lfdr.de>; Thu, 26 Jun 2025 14:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C3A2EACF1;
	Thu, 26 Jun 2025 14:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fw/J9A8N"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439832EB5B4;
	Thu, 26 Jun 2025 14:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750948433; cv=none; b=Weg5rklaH/a5xeQI4er1DlpMkE5QmFLL8VTDRpPlRA/ruI1e6cdqtE24TVDKN2BiNglNBNFqk7CvQq88f/RpfkGKDm5F2Y0XQdF+DcrlwIi8jNZyzKpbqW0bA0vYtWm3/zWZ7UHvuD+BViIhV8vP6QBIzFcCVHuXZEQlQl8QW0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750948433; c=relaxed/simple;
	bh=8feoRMJ5oxsKFFa8/zVv2n9uVgBaK6FEl7Xfk5TBVHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8k3MnvbEXQMXd/meLrD68HhQe18TOcakIoALv7tS6BuljUSTuRq9tEARsFCKc3LHsETMuJfz/yK4o7okCBPvKdGcw7t9gP39OpxaqMblQvdjGw7pWew4mIHkmw2hai1i6GQ03ZMsZxdzA2R6mx9RhcWNfiCKglqHPl1/jiRMe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fw/J9A8N; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1252240E0198;
	Thu, 26 Jun 2025 14:33:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 7bDul_4rMhY9; Thu, 26 Jun 2025 14:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1750948424; bh=9pTq08EIkAmh3CEKCUfS921OI6gbM0ntltJPkDq6elg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fw/J9A8N3Js/IC2yv3FufO/fxWnEONZC7aIAkwfVJUReOMwBQF4KkU+7j5azf0Pf5
	 x0TKIzQU1Yow4zDVIm0uUM3vKEN7d5zqFEeluI/yHTwl/WjUJQcEltOXNWGZVTgN2Y
	 +R1dhm/gHpwzx7ccuP2EUhf1jyFgMD72mM7CEw/hc+ZjeTtAQp3AYw7pghlLH0DOt2
	 QJBAtDfBmke9MXgkQXNqD0NaU8mFa0Y+SJF5kbiBzcAxuxm7y3FbUslJvh0lmSUb5/
	 30DnImadeOAZdPK0ByQ1HWrz5Op7wB1SLNBNT3a4Q4bu2vRKuwkq0TBhf2luou0lPb
	 34Tm5tnEOfGV7Jqs9xombhmvvSzeVdHJ/AU81rzohoYreS9iGu0FYgMIfB2ZQ92pY9
	 NhZMk4GuOrTaToutnzQgrey4oIxEE48IC1KGKUgJoWffgkCKr0oJ0c4pi9s8nRwhbi
	 qyMcfN0+aGZQP3ePyt7No6WR1IEAgwO90Shz90vTY5qYqWC/qbzMabu2SU+tlo+tuc
	 NlwAeTKLgMGgMcsxAyGcvBuBAClnFiXOKmHwp4Gg1SuKR5JY6lKB6QDIPgZY+HfcoO
	 hLFZpYqZGNAulK+5qY155jx4mJQZSxVX3cESd3kIyT7lsCmz7nlbGbpeiVkqfTrCpi
	 My96a/gmvlcUPolQEwFpbVBY=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 720F640E0169;
	Thu, 26 Jun 2025 14:33:33 +0000 (UTC)
Date: Thu, 26 Jun 2025 16:33:26 +0200
From: Borislav Petkov <bp@alien8.de>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, Shiju Jose <shiju.jose@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC: mem_repair: reduce stack usage in
 edac_mem_repair_get_desc()
Message-ID: <20250626143326.GDaF1aNlhXCRvNK43n@fat_crate.local>
References: <20250620114135.4017183-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250620114135.4017183-1-arnd@kernel.org>

On Fri, Jun 20, 2025 at 01:41:28PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Constructing an array on the stack adds complexity and can exceed the
> warning limit for per-function stack usage:
> 
> drivers/edac/mem_repair.c:361:5: error: stack frame size (1296) exceeds limit (1280) in 'edac_mem_repair_get_desc' [-Werror,-Wframe-larger-than]
> 
> Change this to have the actual attribute array allocated statically
> and then just add the instance number on the per-instance copy.
> 
> Fixes: 699ea5219c4b ("EDAC: Add a memory repair control feature")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/edac/mem_repair.c | 56 +++++++++++++++------------------------
>  1 file changed, 22 insertions(+), 34 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

