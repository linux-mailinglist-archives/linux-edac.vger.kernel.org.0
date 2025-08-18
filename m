Return-Path: <linux-edac+bounces-4600-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5971B29DEE
	for <lists+linux-edac@lfdr.de>; Mon, 18 Aug 2025 11:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A28105E6BED
	for <lists+linux-edac@lfdr.de>; Mon, 18 Aug 2025 09:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD48E30E0F7;
	Mon, 18 Aug 2025 09:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="PbwEErHZ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FDA30E0EC;
	Mon, 18 Aug 2025 09:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755509364; cv=none; b=OMhv6CJMYVF/ynSuhuab9jcb7YQeaufOSMsa4LN4Ic0fovFSeUyIwwtie4d26oFDYDAxSxdrznAPs8rrR4QRx/jqPv7i2otsNUj8fYnncjn6yMt6kXTRvahwTx+3fBHNHI5vHCnmj7YYfMx3MbqZh7JB591iaZtc01lF2JRQnuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755509364; c=relaxed/simple;
	bh=YbpbzS9pZmXIHNctEDZokm40EsqDUwk07NW8veXkPuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtgP9Scypy63ziBxTqdZPs9ls0ES4pRVJrP8JsnkIjR3Ntzjqma1pax61PZJbJ8n2zasM2Pmh2Qxw0rlAKKPq2X/v8PFvB88cYApfVA42WpJyEARfmAGKb+u7ZjiX1sWg2YlM3BMSSoHaaEfqzsPX3/kptLJooJZkCs6VNTqImI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=PbwEErHZ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2D74440E0286;
	Mon, 18 Aug 2025 09:29:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id IDhdCe3QH4eG; Mon, 18 Aug 2025 09:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1755509348; bh=qedUOEz2i54OQ5jb7g+72zEnHZ/gNwRt1n/3yK4kPNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PbwEErHZ7v/k2w8S8E+psC9spWf2xMJ061F/8bKIc2H8/6PK44Bu2gjt2NmQnj21N
	 HsuUGUIJO0woRRmEbkCRbh/xX3papQhMzN4VBcRLgXQtVTGlKDrhJxQQJUFcPl7y3V
	 WFqZI+TrQuHqOtJVKcYjj+URBi2X5aSH9H6lcxgyQo8WMP9DaMpX/Bem+9YDD9r7sH
	 JG5Z9AHqfrZxtbDyFO4sidff7MwynqFkrhwJr+TXMqC6gCeA2Ipgu+S6EOPOXSF17Q
	 zlivAhcS1wCnI0txAr7GO9QhxA6Bzwj6q0ChNi1JYRp2C9kt5AfmiZhp3OcrV9KsGf
	 Kzw36XeBz6EijFaHrAfOTKGtS3DxRU5aruaXpJ/nS94GTX3K+OxuY6VswYwZnkm7KO
	 pXENOumO1sbKrG1TtCCiLj1T7h3ykRlvWfGA+1H98wJF0umynPGy9IjzoY8xjDMef8
	 x/narPkgN6xEj8LOOqCyuG9+LydblKvjZS9KsJONWVQBuIjQFeEV6LUAWPhwxXwI4J
	 h52R0fJWEjWYU+vkwxAyyOb4GGbXNYhh6dT5GXWmUBEAzZmazMFJ1nhB/bzK6L7bOk
	 xo/Y7Ady0eGNZ1OTLqJe45W9y4YlWfarE6qBnUppgcenlE99Nw3AxoAA6+P66mvGHl
	 nsjzuOkim2e3kkX1FWwe8m+Q=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D40E040E0217;
	Mon, 18 Aug 2025 09:29:01 +0000 (UTC)
Date: Mon, 18 Aug 2025 11:29:00 +0200
From: Borislav Petkov <bp@alien8.de>
To: Borislav Petkov <bp@kernel.org>
Cc: James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	linux-edac <linux-edac@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: EDAC: Drop inactive reviewers
Message-ID: <20250818092900.GCaKLyXDeaB7EBEuD6@fat_crate.local>
References: <20250622161943.4700-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250622161943.4700-1-bp@kernel.org>

On Sun, Jun 22, 2025 at 06:19:43PM +0200, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> I know y'all busy with other stuff and don't have time for EDAC review.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
>  MAINTAINERS | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3ecb44458a7e..748c0e732da5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8579,9 +8579,6 @@ F:	drivers/edac/thunderx_edac*
>  EDAC-CORE
>  M:	Borislav Petkov <bp@alien8.de>
>  M:	Tony Luck <tony.luck@intel.com>
> -R:	James Morse <james.morse@arm.com>
> -R:	Mauro Carvalho Chehab <mchehab@kernel.org>
> -R:	Robert Richter <rric@kernel.org>
>  L:	linux-edac@vger.kernel.org
>  S:	Supported
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac-for-next
> -- 

Now queued.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

