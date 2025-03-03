Return-Path: <linux-edac+bounces-3255-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D399A4C55D
	for <lists+linux-edac@lfdr.de>; Mon,  3 Mar 2025 16:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 837753AAE2F
	for <lists+linux-edac@lfdr.de>; Mon,  3 Mar 2025 15:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844FD1AA786;
	Mon,  3 Mar 2025 15:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hhUNmYzs"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002D714F9D6;
	Mon,  3 Mar 2025 15:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741016194; cv=none; b=hBP8ffZUjMg1TRrgdhHFAeW07fO3K8OwgieJQoMOG1xjbCuOCjWUsnAXAlhe5d1wGxtYEZR9m2oi2A8biSbVqaZYfSOn9fKzQvZjmO6xonXG1PM4vIkxIgHROMXs0JCDlZL2SmWnUVHKCgq7D0SjGtTA3EGNNBz2FjG7897UwKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741016194; c=relaxed/simple;
	bh=lRcZxkNCUpC9i3cpXcoUFlIvQca6FvwQBnHeTywjTOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovL0NUl9wg1danI3sWHJXCubb/I/mGGGG4aXz1rS41/bzzH6Ma9RCtwj3anbREUiyC2qrDbencQ46txdRXn7a9O5BPARarpIYA94OnDbJVJeh27O9SDFnCqUteOzhnYZjzQxtG66zwKz0+b9BsWe46Xv//W1V5X5dAsktNAqNAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hhUNmYzs; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id F3FC940E0217;
	Mon,  3 Mar 2025 15:36:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vY09TV1g3tfu; Mon,  3 Mar 2025 15:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741016186; bh=VvdHYJX0UP/VpMkj41lRfFMKUsTh6f4n4pUKWdQgYy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hhUNmYzshKvFFGjdbmCaIrzOF+aZ8c9J2vSLD0jTYaejV2sqXIkifAnKda3ECRLz4
	 SqrjnTz+2xhljjJfNN82DdqMxu9A174AzpVyQfGhfSZhD5b4yBq5mnL8TlPsE8qPSK
	 FslUM9mDp/bTijsRcX8g2KcEFf/5FoDjGZPiUsgfRJqVh8dDE6KnCGb7FOWUGmFyI6
	 tn6RPcmPLOlX72/vJEUV9QOYl4UUvmkHkXSpawI2YWdZKobeE6aHqDUUdZaQ4V1DvE
	 2edXyWHv7af3MogwfOTgRVo7klazsdX7ltDG0TpZ0SERMlNQegtT/EmgmQfhr1EOr5
	 ygSXjnGff7eWqP64juguduMXyRSPxt2LMWjH+in8gJQwDcQCj0mTrVTHEZ2DHLI3nY
	 52dt2WUYLjiYlxIGy6BYcvi2C7UyaMn25nXxbeCg0nkOCmnfN2ifRflbJ2JpqIpd5x
	 0Fw5UhqW8wR3pYoqbD9FefHrV6SMZRfk/eYlRmcumwiLsbrdCXamOvMYPWgxPVe1zO
	 0auwYDNLV4UaHG+4Z1pTNarjdfp0vZd/Qfz0v6ZHs4iJHjQ4+Fm68jjNbjfLYQYum/
	 RJZQl0c7SFz34uY4HoDcf3X4RngdGWLK1l0E49OwZ4LBthMIP8q7NOXlhClJWJTJgS
	 EQ1Byuh7AExYnli6LM/UxvE4=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DA22D40E0216;
	Mon,  3 Mar 2025 15:36:16 +0000 (UTC)
Date: Mon, 3 Mar 2025 16:36:11 +0100
From: Borislav Petkov <bp@alien8.de>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Tony Luck <tony.luck@intel.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-edac@vger.kernel.org
Subject: Re: [PATCH] EDAC/igen6: Constify struct res_config
Message-ID: <20250303153611.GJZ8XMa61cuRbheMDO@fat_crate.local>
References: <a06153870951a64b438e76adf97d440e02c1a1fc.1738355198.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a06153870951a64b438e76adf97d440e02c1a1fc.1738355198.git.christophe.jaillet@wanadoo.fr>

On Fri, Jan 31, 2025 at 09:27:02PM +0100, Christophe JAILLET wrote:
> 'struct res_config' are not modified in this driver.
> 
> Constifying these structures moves some data to a read-only section, so
> increase overall security, especially when the structure holds some
> function pointers.
> 
> On a x86_64, with allmodconfig, as an example:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>   36777	   2479	   4304	  43560	   aa28	drivers/edac/igen6_edac.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>   37297	   1959	   4304	  43560	   aa28	drivers/edac/igen6_edac.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested-only.
> ---
>  drivers/edac/igen6_edac.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

