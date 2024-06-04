Return-Path: <linux-edac+bounces-1177-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A21FA8FAEFF
	for <lists+linux-edac@lfdr.de>; Tue,  4 Jun 2024 11:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56B521F267A8
	for <lists+linux-edac@lfdr.de>; Tue,  4 Jun 2024 09:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1566582D98;
	Tue,  4 Jun 2024 09:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="M/VhqMX5"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F286815E97;
	Tue,  4 Jun 2024 09:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717493935; cv=none; b=BeYDfaPda74UNAayJztk4XSrwSbBd+06T9cFoLE1+G7qREoB2LvKps8q0Ih8u1S+hR08dkr5gohfbcigtKo/jJjxiHhW6oLj7J3oJlkEiObrvs550M0GK5SEew8v8FOCogNguQeqPIWxUrAjTySTmJkIAYHDUh9Lb/h0YMWcNXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717493935; c=relaxed/simple;
	bh=KXW9jaZ3br95+nPszaj2WZ1ZODLazlHG7OY2GYqXx0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKMg9T3W5XCDETX3IbnswNtrcf2i6q0LcfMZ+t1KjdowhJ9aEpvkD3st9FpsOLY2/Gb9dyLrAoXv4YNDyt0Kwf40DNKIzoTuTWNXvs+7gOUV3LS1eP1SFDyBzghCBSrWTFt3SsL4QsDp69bGNMyaxQsofqd6ZXyi1s16dKVUUOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=M/VhqMX5 reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2165940E016C;
	Tue,  4 Jun 2024 09:38:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 9pUY6dyk2sen; Tue,  4 Jun 2024 09:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717493926; bh=fPmd5vkAgm6VBBlBRLo1jP2zwKxmbCbrYG8W22UgTOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M/VhqMX5mFEzExYan715FG88DwuG17w0zgolv1Rr06a33LtSYV5/v3TdzsWX3aTsF
	 xv+9l9ue+Q0WR+ka5ZSkzlqudfh2OjAXGLRDIZ9OhizfwteMmiQMF/0NyKBobpQDhD
	 jidwLMi7QqUuiC2iXaxg66FX3lRQ2h+DxuNKlj59zGfxuj8zidRHV5Px248uB+ap6a
	 kmy8Zyhgo+WNoWp+ELJE1AUueQYi61GPLADYG7iKGFRN9BsNvAqkX+mcGXdxtOEaga
	 Wv/XgIhVd6mZ5KnlWcSvm6u9xd8YF0fQVsnE1rLyD2HEaOopnoum8B15BDJKT2hoyQ
	 yVvIZl4+Uyip3Gh9lFbX+6NrprNiGWXt7+cvK+BrQGcBoa7E69E/vogTUWd8v/PcAP
	 Fh+T2cWK5I9E6BNycDzIn0ah8iHqVflpfC6QxFAT3Jb33zd9+kPovFxs9EOgo7osI5
	 txGiyx7RmoVJzmgqFMarwtV9shYsdeQdVxtGrPfoq4jtUxMQWs2nN9VlGSSO9pP/os
	 1CJ0FRB1ZO13RgyhU2pHLpS0qUbst6aSLRGYF8X8hMap+6imVfMbsWsnhlUgxizWeF
	 O1nGeak4b3QAfh8n6lrW1FqVwNDK8bLY2H9L31LSg/yBtRBjEB7e0IXBU2NLLHhRtw
	 8DRDMovVACobqxke90QdxgDI=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EF50F40E0081;
	Tue,  4 Jun 2024 09:38:35 +0000 (UTC)
Date: Tue, 4 Jun 2024 11:38:29 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Muralidhara M K <muralidhara.mk@amd.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] EDAC/amd64: Convert PCIBIOS_* return codes to errnos
Message-ID: <20240604093829.GAZl7glS0QRGGOF_EH@fat_crate.local>
References: <20240527132236.13875-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240527132236.13875-1-ilpo.jarvinen@linux.intel.com>
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 04:22:34PM +0300, Ilpo J=C3=A4rvinen wrote:
> gpu_get_node_map() uses pci_read_config_dword() that returns PCIBIOS_*
> codes. The return code is then returned all the way into the module
> init function amd64_edac_init() that returns it as is. The module init
> functions, however, should return normal errnos.

...

Both queued.

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

