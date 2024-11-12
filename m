Return-Path: <linux-edac+bounces-2510-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FE39C5A54
	for <lists+linux-edac@lfdr.de>; Tue, 12 Nov 2024 15:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9142E1F22FE8
	for <lists+linux-edac@lfdr.de>; Tue, 12 Nov 2024 14:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882471FE11B;
	Tue, 12 Nov 2024 14:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pRNf38qr"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B75B1FE0EE;
	Tue, 12 Nov 2024 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731421635; cv=none; b=HPhnI/5qvXaKF9s2n/7TVhV7Pa0bgaZ2fmHBSF3U7yh2LE5WZcK9XyZePa/WGZbQKBQx5x1fFpR0B4OwFYAN2qw333LBE2+SB4rBkndO90YSSMZYkElqyPw/sWqwWPkksE8izk/ycZ2xCSBbt36mPewzANScHFks87czOlOkNMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731421635; c=relaxed/simple;
	bh=HTpM+eKAqGbwDKrX9ecoYdIiV2FUGt3/i53J6qYdlro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6AAG4xdc7G6Aln9SL3bwTlIfVhfy4bXIqeMz/W0A5BXHxX0W6FVG7eyG3q/uAqYIEurh54/Rd9Hee5yiKwQspgG5+YJSaLX84EgLzhfQr/39LVHRNLdD+2jVjkWb4z71x/i1GkI4iY3+OW5ZwOrKXlY9+SB4Pa90kpFULvuW4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pRNf38qr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80A1C4CECD;
	Tue, 12 Nov 2024 14:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731421634;
	bh=HTpM+eKAqGbwDKrX9ecoYdIiV2FUGt3/i53J6qYdlro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pRNf38qr/39WE2bwnXVTXQaiQMqIRS9x1jtYlzdGIogtrbvX/QqgV276v7n0khk43
	 Su5sTnrSFPZfbF9FUHszXHfHSvbnAokfU8zJVfW4EnSqumE9+cTSaZwwXahChTG6hh
	 ezcOFw/qOQdN/M7rIBsy2jlptdVgRPQI/k27xxG8=
Date: Tue, 12 Nov 2024 09:27:11 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	linux-edac@vger.kernel.org, linux-hams@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] MAINTAINERS: Deal with the linux-mips.org mess
Message-ID: <4eyfwcmuw2axndrxthgzayzjfso2ydw6zvc7v3pi6z4weyfmr3@3xapew225gju>
References: <alpine.DEB.2.21.2411121327130.9262@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2411121327130.9262@angie.orcam.me.uk>

On Tue, Nov 12, 2024 at 01:47:17PM +0000, Maciej W. Rozycki wrote:
> Hi,
> 
>  Here's v2 of the patch series to address Ralf Baechle to have stopped 
> responding and linux-mips.org gone down, and Thomas stepping up as a 
> replacement maintainer.  This has been regenerated against the current 
> version of MAINTAINERS.  Please apply.

Acked-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>

-K

