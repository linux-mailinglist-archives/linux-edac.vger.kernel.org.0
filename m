Return-Path: <linux-edac+bounces-5000-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E32BBF948
	for <lists+linux-edac@lfdr.de>; Mon, 06 Oct 2025 23:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8348189D505
	for <lists+linux-edac@lfdr.de>; Mon,  6 Oct 2025 21:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1DB25949A;
	Mon,  6 Oct 2025 21:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="QjKWoBIj"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF3D226CE0;
	Mon,  6 Oct 2025 21:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759786469; cv=none; b=cNZ0e1dERwOaWlFJPKNOr9klrhUCHGWb4y4rQ40hdC1xt9vAH4E3QuD52h1RmNiC2+PDdaUBIcZTtVMe5yo+zWo7aNzevw6kyaacGBzogiltsphfsHTF4RCPoZDndJwtdsnuyKRpUA70CUVzBXJ5zhRqDP8fNrp0j/OMx30bM1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759786469; c=relaxed/simple;
	bh=osoBRikpIpNKcT931A9YyiP/3zS3uPB8LMbwXnxCKgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C17WPXetcpVA92mOaOvldlmXvxQIn5/cCWDIOMzPCJH5QkjA+zdSYndL0f2oTBX3bu6YqsZ+UtOO9ktIw6TmaEJ8bJnuI5iuVxcXo3BNTSA6PxLoWxpucJ5C/lK5/NFWtTTtlt5r8Vh+tCUxNoV3matyvAMxjHUjbnd5sqVDP84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=QjKWoBIj; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6DAA440E01C9;
	Mon,  6 Oct 2025 21:34:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FJgEHiw-qS1G; Mon,  6 Oct 2025 21:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1759786460; bh=r4AE8+z51DYtKXo1GAlHCrztFcdFRu0/JZyvx0pn99Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QjKWoBIj9TFr06SzPrV0qtX8tyeX5ELvREwXb8ms3bvY868UG995fzWnPT28H0oKv
	 fxsPi6GumhT6bt+XSQmHb7NiHgW5OUOy85BOO9m1/E2IKLQ07r1hyBlqxJ18cLRy1u
	 CQ28rTewOU2o1Q7wLv36+YHPpN+iMe/thBDDoMKjlfu3v+SLDMtK35BmSns9UgABUH
	 AmXZnVzm+XvAThZnNN0kzuREjabRl/D8lszZ/uWyQghgL03QpYR8y6KN8qT8wz7yDy
	 aTvgdatYpSIYZuHAYeU/1yL95kcQkqt3IUl4kgz+QjJtXGfQuw/38WFyUjXZ14gEJm
	 /yDxbv7Vc+iiqIo75HCPDDvRlN5hfXXBR0MWx6+Z+yKYLPjSeOPIlwECOdXOOMDpUK
	 e35ISThacDUmANujYYVPf/PpRhILUclD+2YuPOuI+QMdE7ECPxIC3TAH8B5ymroBud
	 +GA1o7eHz9qzSmDTGDE4mgifYU/1Pv7cU3FLCHh5xbcH6Dd5BeZxjR3ASJxNHHWD8v
	 Pzt0LUBBYTGp2k9APaBGP7fVjHshT20efFTdxMsjSR3hwrRNUKzGGD2gimTAa513j2
	 PyawUlieuxRrU0+YjthNzegv27jx6HHIAPcsEYVWjRdi41kcbWcN4oytTNPXcAl/KP
	 /9OO731aRiqJtiSBmVZK9SWE=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id EEAC040E01CD;
	Mon,  6 Oct 2025 21:34:13 +0000 (UTC)
Date: Mon, 6 Oct 2025 23:34:06 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: tony.luck@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com
Subject: Re: [PATCH] RAS/AMD/FMPM: Add option to ignore CEs
Message-ID: <20251006213406.GJaOQ1zoXUKEk-7eCn@fat_crate.local>
References: <20251006151731.1885098-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251006151731.1885098-1-yazen.ghannam@amd.com>

On Mon, Oct 06, 2025 at 03:17:31PM +0000, Yazen Ghannam wrote:
> Generally, FMPM will handle all memory errors as it is expected that
> "upstream" entities, like hardware thresholding or other Linux notifier
> blocks, will filter out errors.
> 
> However, some users prefer that correctable errors are not filtered out
> but only that FMPM does not take action on them.

That's a pretty shallow use case if you ask me...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

