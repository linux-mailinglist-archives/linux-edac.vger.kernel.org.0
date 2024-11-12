Return-Path: <linux-edac+bounces-2512-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D23549C5DDB
	for <lists+linux-edac@lfdr.de>; Tue, 12 Nov 2024 17:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B57D9B881E2
	for <lists+linux-edac@lfdr.de>; Tue, 12 Nov 2024 15:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1D91FF7A8;
	Tue, 12 Nov 2024 15:13:44 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7251FBF6E;
	Tue, 12 Nov 2024 15:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731424424; cv=none; b=CRjQ4sfM1KlI189MithQWbLJH7ZJ3TXRdCftd8Py8tghPma9dfiVS/bn2Zt/xPmPSA47sMOqOMdJX/TTYlBPVClClRC+YQHq1HZjRtkaUBTwCU+GcKUEBCFihUkrN0CWh3yqdr4fFqixNDIou1tNveIhJd83te1xKs4F7b6DRys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731424424; c=relaxed/simple;
	bh=9eM6BZimbJgy3fw0TJnXj70JyP24g/Grvo/3PLiVHks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMiph1gRMjjwM0YEUHraN4MjuU9jjpBbgP2HSclI1knsQia58stcKCHYhnrejPJuMyjTt5SgeWDgbX3gU9+b7FeYGFaihnuVihcfYo+YqBRcqsYFhSPLonUSDkqlHnjk8GUQOClMUVCiA7w0bC9gGmgsMQ8Fd7Cmna4D0yp02CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1tAsVf-0004rZ-00; Tue, 12 Nov 2024 16:08:51 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 88997C014D; Tue, 12 Nov 2024 16:03:25 +0100 (CET)
Date: Tue, 12 Nov 2024 16:03:25 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	linux-edac@vger.kernel.org, linux-hams@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] MAINTAINERS: Deal with the linux-mips.org mess
Message-ID: <ZzNuPSb1tlDdNfTW@alpha.franken.de>
References: <alpine.DEB.2.21.2410131952550.40463@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2410131952550.40463@angie.orcam.me.uk>

On Sun, Oct 13, 2024 at 08:34:38PM +0100, Maciej W. Rozycki wrote:
> Hi,
> 
>  As promised and with extended wait time here's a small patch series to 
> address Ralf Baechle to have stopped responding and linux-mips.org gone 
> down, and Thomas stepping up as a replacement maintainer.  Please apply.

I've applied v2 of this patchset to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

