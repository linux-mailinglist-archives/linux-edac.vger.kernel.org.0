Return-Path: <linux-edac+bounces-1389-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B30918E26
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jun 2024 20:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3DE41F2599F
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jun 2024 18:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BB9190482;
	Wed, 26 Jun 2024 18:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ekoVEJOn"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D471190462;
	Wed, 26 Jun 2024 18:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719426040; cv=none; b=o9D91xt8zmL64LHnNpIYoJWLvsxc/viCHQtl/d0ES2NImzOsYi8BPhrGUwE7WKYURgTCIYDRhe+y9Pi8uQNJk6oWUClp9ONdgFDOagjZXhqwFElLrTdkHKnY6SiEcgQ1v8AS12iCaqJIRVcqCm+XFbEO9PAy/ImBVLU065oLwY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719426040; c=relaxed/simple;
	bh=z27AxN76ZfzbtD0CwX3/5wDGi1LekqzkOCwGwmnzDHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eeGeDGrQXFrG0kIyEjeG5jIHQ1kCqv8e2NqQrNhA0+mH4BD/VVR9OA1lJAOiSVHm9OfRlDEUYFuZq3sRDwP0dg9duKudLt2KAnjHTw+PdOwP5QAokm+INGMjCpbc9IKzsJKm+Yhn3pEChlFvN1Ny6erLKHuJEiVmyyH18nXM9rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ekoVEJOn; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8CDA040E0185;
	Wed, 26 Jun 2024 18:20:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 16O2WKeMzR4y; Wed, 26 Jun 2024 18:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719426032; bh=51qt3WM+PNcXiXQa/UQX9tYSNmBsISQmLiUi2BYhe64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ekoVEJOnlkf8oIDtlfa7mIjpOjxbtKwRTTjZ4O3nmjk8UTY2ZTKDO+hq6aDm03HHj
	 o1ieljxyJov3OaDCIiKseGOxDp+uwlM8UnNDAtHdZ3uNK7d7vEw5Fp+UBvjjLgqcqH
	 1QdZnkiTNUVbW18urUJwRP3y1GIWhWK4vHR2kijurQq6OAJ+uHSKwrJguV5kISNGz8
	 U8UlNFichQ5rYp7doVLw+gCwOG5mKFEJmR6OqlfZZbDKU9ITfSA4uXIi53uthNQlmb
	 np3Dn+DJLx4IlhoHBG4Js0equT1b3vwmw79bH1bUbB5ZAwQdP290YJxdT71C2D4+sv
	 f5by/uEZKCKLk89gGLLlLevTFa48bnQCfvKU3ya+GiUw0CitsR8jaUVx/DBF02JHW4
	 OzDCoPWJyKoO6p0UYHZ4CN6zJu99t4mGx7y8bGIjoMHCCi1+IxqAMgnQ9qkNsHm4lQ
	 LiE/J1Hp3aR4pdSSlo3Hczdez5dPsY0IKYqXMSh0dXwS6L/p/xSB7C3a8FYGmVrLnZ
	 nEZkB/+zECRmS+evIUSTT5/fCNwiotSD1Z0/DTdZ24RQ8JUPiSn4BvGah9xUcqgN7Y
	 y8U8DGzoc5euBIJKG9v/xW1uVYeebdWQYrG84tr6qrBwC2WWks7Q0LPPPrjcoIxmYs
	 /nTOtBiSqLLOJLpDQjhQlj3s=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B068040E021D;
	Wed, 26 Jun 2024 18:20:14 +0000 (UTC)
Date: Wed, 26 Jun 2024 20:20:13 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Naik, Avadhut" <avadnaik@amd.com>
Cc: Avadhut Naik <avadhut.naik@amd.com>, x86@kernel.org,
	linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, rafael@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, rostedt@goodmis.org, lenb@kernel.org,
	mchehab@kernel.org, james.morse@arm.com, airlied@gmail.com,
	yazen.ghannam@amd.com, john.allen@amd.com
Subject: Re: [PATCH v2 4/4] EDAC/mce_amd: Add support for FRU Text in MCA
Message-ID: <20240626182013.GEZnxb3TpU6VgROX8g@fat_crate.local>
References: <20240625195624.2565741-1-avadhut.naik@amd.com>
 <20240625195624.2565741-5-avadhut.naik@amd.com>
 <20240626120429.GQZnwDzQ47y1fOlFTp@fat_crate.local>
 <ff9efb14-f3e5-4c4e-8285-7da853e6ffb7@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ff9efb14-f3e5-4c4e-8285-7da853e6ffb7@amd.com>

On Wed, Jun 26, 2024 at 01:00:30PM -0500, Naik, Avadhut wrote:
> > 
> > Why are you clearing it if you're overwriting it immediately?
> > 
> Since its a local variable, wanted to ensure that the memory is zeroed out to prevent
> any issues with the %s specifier, used later on.

What issues?

> Would you recommend removing that and using initializer instead for the string?

I'd recommend looking at what the code does and then really thinking whether
that makes any sense.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

