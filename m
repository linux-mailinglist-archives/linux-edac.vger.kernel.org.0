Return-Path: <linux-edac+bounces-3256-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B8AA4C575
	for <lists+linux-edac@lfdr.de>; Mon,  3 Mar 2025 16:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 670E33ABD5A
	for <lists+linux-edac@lfdr.de>; Mon,  3 Mar 2025 15:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610BF214A64;
	Mon,  3 Mar 2025 15:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Lj9xjYNd"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F697213E66;
	Mon,  3 Mar 2025 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741016469; cv=none; b=X2omTwG09J+/33+9o+6QL6jvoX1ek8sabKuqh68QfpMs/TcI+cIMnyx/+hIXA/GBhLhjFmwK9sIemPdUtV7VK6Bj4f1lzBeLR50QY3w7nlPPEaVtgK30mPKdchgujFgA64xlpeUjfpaolkUzmSK6xpWGcW53pYFnu53pEAi4kx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741016469; c=relaxed/simple;
	bh=4zJm7j9QhbIaZsVeyEG0PWhJqVlCjEGa6wLnDkCe+bQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dpkMDJeW6eAzWFumxqEpZUevvLf/zaQ66VGP7B7wwREW1SbYVgiDla7GR6nTqR/KayQdBy5PN2z3TWfCp/9ic4M1mT+9oPLtVsQNl5N+CVbh7zoEZ4hBinfrdZStXtMAvqj0SAUUwuPekS2yypM1tWAWx/VvjCPPujTcKTT0Fa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Lj9xjYNd; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7403B40E020E;
	Mon,  3 Mar 2025 15:41:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6GodhKPa1y1N; Mon,  3 Mar 2025 15:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741016459; bh=p7t/oJsp9GovKtA2uK6Hr37llYhptSKxRgfXL+NAWu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lj9xjYNd9kIQwC/8bSvPEczhiSsetYTkktxPS+wQBRUnxZ14TtXQkk+yVW/yqDk80
	 Ls9OJ1jgipxLHDxnl/2fD386EPa3M5eg1nyUXmUDglN64hrplH/aPJ47BI01d6eF+w
	 3Vz6L6xK4OOVO4NJmv9UTTKtMbbLm7IJLouzUk0VreGoKelmX+ZlSj/i4IRYoKdz4Q
	 56cwOYk9Bv//PoAmyndJOVaXSlV4i8PUz7QPr0/G2iYObsWymcTD57sgR1QnksE+XD
	 L2/o+C9ipPeQT33Ne6MjmEoCR091el2zdJIBPPb7qRM7szz8vaujxeYCc6qQY4plhq
	 2sSspaEh0IIXZzfC7XFKPlQEaDoSf4yO+5gbR3dOoY2tFEcxD/3sFFIC6SdaaxFJ+M
	 SnNPTbNm+ikJh/oFUqlXr5eYO/oMVN8CBk0tzEetbegtV+zzQaV45LPWuFooUJ3FWd
	 l9R/9Z564ZdXZc563hWvzA4qpIPkSdo9kaPkMRmRiFow4Qns1Od7aqH4Meq5tIUuLi
	 2xkWoU6dD7FKPRbxONtvB34LHP4lf+SKwss8fZZO7c4j0tPr5vLFJ8v5ZBjQYC/1xr
	 Jxpgs++779EMh7ngBs0rjMt1REJREWBJSWoSBSiNPFR/24Gg+lMCtimNSW9q3DGggL
	 gHTfRe4Jf0SF6yJn9X1moHa4=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A9C2540E0215;
	Mon,  3 Mar 2025 15:40:51 +0000 (UTC)
Date: Mon, 3 Mar 2025 16:40:50 +0100
From: Borislav Petkov <bp@alien8.de>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next][V2] EDAC, pnd2: Make read-only const array intlv
 static
Message-ID: <20250303154050.GKZ8XNgll0FjqQX_Tu@fat_crate.local>
References: <20240919170427.497429-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240919170427.497429-1-colin.i.king@gmail.com>

On Thu, Sep 19, 2024 at 06:04:27PM +0100, Colin Ian King wrote:
> Don't populate the const read-only array intlv on the stack at
> run time, instead make it static. This also shrinks the object size:
> 
> $ size pnd2_edac.o.*
> 
>    text    data     bss     dec     hex filename
>   15632     264    1384   17280    4380 pnd2_edac.o.new
>   15644     264    1384   17292    438c pnd2_edac.o.old
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> ---
> 
> V2: add note showing that this change shrinks the object size as
>     suggested by Qiuxu Zhuo.
> 
> ---
>  drivers/edac/pnd2_edac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

