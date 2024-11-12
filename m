Return-Path: <linux-edac+bounces-2513-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8BB9C5BD1
	for <lists+linux-edac@lfdr.de>; Tue, 12 Nov 2024 16:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3157A1F22C65
	for <lists+linux-edac@lfdr.de>; Tue, 12 Nov 2024 15:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E5F200BB9;
	Tue, 12 Nov 2024 15:27:21 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A430200BA5;
	Tue, 12 Nov 2024 15:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731425241; cv=none; b=RIJgLodCLa5Vpltj3ifqGOcBSqW/vkpDZaYkTBY6wt/aPAH6y5N378mpumvzX+RNbILALJTUyNxU83m9amax1jjaj7Rqt6pSLcd1f+cV7808qqRGK1/xKYKO8/Pedtgaw24LBnVHsQ8dXLa4wYKx9R/XwAfNK8dNfrmQR2vlPBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731425241; c=relaxed/simple;
	bh=HNgfvtBVLWi2KlzOgkPTGH92XT5IEgf6spap8erVFQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=agi3tviQ3+M471Q99/lJIvlx3XkfO/EzB8Xnx79mt1cXVHKwUyAoepS9yHWDnH9s74rOZSF4c0FxnXsKxhpTkLzgFwggVeKKH+iRZkO8bFdBG0iRrGmjA+p4/Kf2yle8f5tM6hvhOAXrQidYECPZZb2SzoHrKyu/jqQOao0CWhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1tAsnW-000536-00; Tue, 12 Nov 2024 16:27:18 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id E84ADC0110; Tue, 12 Nov 2024 16:10:40 +0100 (CET)
Date: Tue, 12 Nov 2024 16:10:40 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	linux-edac@vger.kernel.org, linux-hams@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] MAINTAINERS: Deal with the linux-mips.org mess
Message-ID: <ZzNv8PWzPsxiuPSN@alpha.franken.de>
References: <alpine.DEB.2.21.2411121327130.9262@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2411121327130.9262@angie.orcam.me.uk>

On Tue, Nov 12, 2024 at 01:47:17PM +0000, Maciej W. Rozycki wrote:
> Hi,
> 
>  Here's v2 of the patch series to address Ralf Baechle to have stopped 
> responding and linux-mips.org gone down, and Thomas stepping up as a 
> replacement maintainer.  This has been regenerated against the current 
> version of MAINTAINERS.  Please apply.
> 
>  Previous iterations:
> 
> - v1 at: <https://lore.kernel.org/r/alpine.DEB.2.21.2410131952550.40463@angie.orcam.me.uk/>.

I didn't see this mail, but the v2 series in patchwork...
Applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

