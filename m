Return-Path: <linux-edac+bounces-4605-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D656B2C627
	for <lists+linux-edac@lfdr.de>; Tue, 19 Aug 2025 15:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23A7C18903D8
	for <lists+linux-edac@lfdr.de>; Tue, 19 Aug 2025 13:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32ACA33CE8A;
	Tue, 19 Aug 2025 13:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="QJxEHck5"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C65B2C11FC;
	Tue, 19 Aug 2025 13:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755611352; cv=none; b=Co2eDekYAHFgcxRx8/TmMot7Y9eVPEWrJaAngZ5PjQGXrb1ro+aWDLaizegRUvUXYhq1TDl/cZcAlyoSM7Ae5mAhsOggKVZPy6uzkMDqUhe+Ld4Iku1BdjueWng/8vo9ObwBionbLscqEYHIuERNAJ4x0xlYypZKGFk1xA0xzKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755611352; c=relaxed/simple;
	bh=lud/lXMLpcg+6k40Unk5Vvbc3F87BdpQ9ll7DPMri7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9fOjYsX9wqTaJCPdU74kXQ3NDPfMIRWhrUqeWZlf+aylkts8A1aHeM+VRaMLx5+pFfenEtC5zO0aO3bR1SUdkESkimaiqRlIC7KEvfgY59sEqBFwchtfcTAEsV18mE7TgMQNR/EgdxYNlcmx9Y1ybDWkVe2wZb5cc1ewfYuqxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=QJxEHck5; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2259640E0232;
	Tue, 19 Aug 2025 13:49:07 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id LhfCHcjT8P5Y; Tue, 19 Aug 2025 13:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1755611343; bh=hX8gkKPCknuwFfJe0Mc+DoX1O/AMSSHAZ5TIElPIwQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QJxEHck5a0prvkNWAop/I7j1LrMcmQ40P1a8YQ4uXqXfqmTuOV0raf9J5auxpMFdA
	 A6PL7PS9YGR5j1Ui7kwhv7mlxBKOxfpQXZ8asRSbJo81Y1gRi2Lata92xsN62E63Nm
	 h1kFSfKle7FQx2PT1XZqmwwHOfzkEOTZ8rQKp+62iDiLry21TyNyL7dG47o3AdVgxL
	 ZbTR3qJRTzXezUXSY80KjbzVIgnjOkOn9+HnMFW0ku5qUhZuiBnwdl2B3813ppzhdm
	 AqHHpqbPG2A67rnsZrL1jhwsoFdp/4ONiniopYfE8I+TJh25VncRjqyz8AYVo+ryp+
	 dJ3+IL/7YnWX34V86TEfgtwNqm1Yeqfeny15rz08SWS2ZWDz/ApF3Cohd1fK+fODki
	 RGtSazL0PcGsgUNUc8KLyKeP6zCRgR+britVO2PWPNezaPzrG9g5kia5jz2yAbWzEP
	 xqOVvYNoRrZp5ngRUcGvTTVsczGD1zVrYsJTWrqwXaGzDaO7DBCR9d2W1ub326I8Vy
	 YIrJpMwzOycGXu4rPSaJhmIWVfD0JRKC0QEV0eprKANL1xjWBVoQZWSwqXPMM/9NgP
	 pWNDTko166zr3aqviTtEgFXqNs2Nh58C7HfAdz9BaKXqej7YhM5r49kToahDMYj6VI
	 ZzEOw8EcUWKxciWchslrGUJ4=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A61A540E0206;
	Tue, 19 Aug 2025 13:48:59 +0000 (UTC)
Date: Tue, 19 Aug 2025 15:48:53 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Avadhut Naik <avadhut.naik@amd.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] EDAC/mc_sysfs: Increase legacy channel support to
 16
Message-ID: <20250819134853.GEaKSAxRGK0SPOmU0I@fat_crate.local>
References: <20250807201843.4045761-1-avadhut.naik@amd.com>
 <20250807201843.4045761-3-avadhut.naik@amd.com>
 <20250818213651.GIaKOc88InL4iy-SGM@fat_crate.local>
 <20250819133040.GA359442@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250819133040.GA359442@yaz-khff2.amd.com>

On Tue, Aug 19, 2025 at 09:30:40AM -0400, Yazen Ghannam wrote:
> Maybe it's time to final remove this legacy interface? It's been
> obsolete for more than a decade now.
> 
> 199747106934 ("edac: add a new per-dimm API and make the old per-virtual-rank API obsolete")

Bah, look how time flies... :-\

Good catch - I had completely forgotten about this gunk.

> Any guidance on the best way to remove this?

Yeah, you set it to default n in Kconfig and add a warning when someone reads
the old sysfs nodes. Something along the lines that this interface has been
deprecated for a decade now and that people should switch to the new dimm
interface and that it will be removed in, say, 2-3 kernel releases or so.

I'd say.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

