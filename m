Return-Path: <linux-edac+bounces-1154-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFE98D3EE7
	for <lists+linux-edac@lfdr.de>; Wed, 29 May 2024 21:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F8B41C236A2
	for <lists+linux-edac@lfdr.de>; Wed, 29 May 2024 19:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CE315B14E;
	Wed, 29 May 2024 19:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="YWMyRygA"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4173242045;
	Wed, 29 May 2024 19:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717011121; cv=none; b=A01Zt9cFv3w4ja9+J1GKysX/irw440cY2SxLKlL9ZAyKnmo0281VJchr/vxiKNDpfVe+EJAnW6tUgL2C0mo+CMZ7Wq8jckhq9WvmkuEMuJs1iG2UVYxZeadcJLyDOeRo4s0mczztd71D+UIjsVENVviRYW7Nttyw4/vC4d77ms4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717011121; c=relaxed/simple;
	bh=XknLD++ZbyOxVWUbX5ZNfhHP323YHHho4U/eXqTv2Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJsbXwtIOWqoog/N27UoDYgvXcJHXl5FYE69U2HWNvITgBc/tp2iRNqvWytXNWb+K8zyxzp+BWirg5MgrPB9xjgRHsk02HqNoctZ2pTjz7XmnQZlizvRdScRef7ajlhpcDmyu9RQFxtFTe5mibHb2+15A+77mxrOGY1/7uZA7xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=YWMyRygA; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 87CA040E01A3;
	Wed, 29 May 2024 19:31:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dyeE9Nzyk0oM; Wed, 29 May 2024 19:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717011110; bh=EeR0075bxj700aFxHDQNh71batfPlf0fp9sZmjOxiGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YWMyRygATvPVO4cnKAN5/M61kp9pxWyVX+W0d92nuI4x6WIUCAFgbY/9enuj42Fbt
	 2lYlrjpTLo+qCOsveJgoRQ1nnu2OgZvWV2MvjyRefGbVAehUNsGHJNZ4oOpi9ptn8Z
	 CbcKT9xiN9AdeDExDp+DddMtThO6y99cADhcbRF9iCHbiAhARinQYOFQ/icxIVxhFo
	 sJA9ZJwzcnZjyumP5iPaI3pA3B/Hzh96mtwITmDeK4AJdNqgEQ3KFdNX1aBYsDUJ3N
	 S6JonM83sFImN3cvJ3oOfmzMH4cIMheKKNPfMXFjB6UTcjwHhSh6QocZMpHU1Zjjrf
	 tcQLLZhpmT6S6zqSOEOdxzD25rFpF9XJ82HgpV9PY48bJBYDgOuF3vTuoAWPzIPgHB
	 1c9gNFdUBm48wPxpYqCuRzz3ONq6f3jLTptpG1va6vtko9hb5ZuaVauz/sGfd9c1WT
	 ilA7CQoCZ5MNZQ0WYZvHCCFqLZMVluOi9JgrC03zKUok332WClWXHC2XBXRPJSZwBW
	 QC3qGt+7a022AJVTvcNR0DjodpnU+p0EK2zTeHP4KgAxAOyc9xGNG22PrE2YQdWo42
	 5fcs5kGkS5Y6IrlKcmwsqBYntN7unUxc92HSuwPrhiyGsotDRncO80pe8n96YuUZiw
	 kP2EfD6nReWwal8oTrAIlriQ=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5246F40E0177;
	Wed, 29 May 2024 19:31:38 +0000 (UTC)
Date: Wed, 29 May 2024 21:31:27 +0200
From: Borislav Petkov <bp@alien8.de>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Arnd Bergmann <arnd@arndb.de>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, Marvin Lin <milkfafa@gmail.com>,
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC, i10nm: make skx_common.o a separate module
Message-ID: <20240529193127.GEZleCjwyUtnDv_Nc0@fat_crate.local>
References: <20240529095132.1929397-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240529095132.1929397-1-arnd@kernel.org>

On Wed, May 29, 2024 at 11:51:11AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Linking an object file into multiple modules causes a warning:
> 
> scripts/Makefile.build:236: drivers/edac/Makefile: skx_common.o is added to multiple modules: i10nm_edac skx_edac

What changed?

This wasn't an issue until now-ish...

> Make this a separate module instead.

...and I'm not crazy about the exported functions either.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

