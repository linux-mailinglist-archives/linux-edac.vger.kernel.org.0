Return-Path: <linux-edac+bounces-5448-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BD6C61A0E
	for <lists+linux-edac@lfdr.de>; Sun, 16 Nov 2025 19:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 6EE3E28DA1
	for <lists+linux-edac@lfdr.de>; Sun, 16 Nov 2025 18:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E81A30DD31;
	Sun, 16 Nov 2025 18:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fQnMQgBI"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3414225A29;
	Sun, 16 Nov 2025 18:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763316328; cv=none; b=KJlwRCK17XOrgQlg8Z14Lod/iNypqPU9kXR7yB5pZfJ07E6/B8ZW//nA56mIP7FRGZOa6eEF/9qg3R5MuHUL17lohk/axkDodjNku9LsSb6e7P5DVHO6P0R5yNWx8WGtO72VyL2Xn8WOfaF7IARYnDWIabBExZH5xyXsHBmctwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763316328; c=relaxed/simple;
	bh=YmIscBBSCBiBzghee1xvmqGkb0fda22ameDylSdmHnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtDKxSFUnPw7L7Myw8KZzftZM/0s84Jyb8iTq8xMbYJTRkZJIQfQJ5lS819SqcvKoXo2feGATOKCvFIYrshNUVbxwTGQXJ2+hTVIBvdrbuV1s1K7u9y12lwzOU/Zq/bQTgMBzDODGxiwMghlykVbVBKxU+8ZP1F7HDt3ic+OE2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fQnMQgBI; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BA5CC40E016E;
	Sun, 16 Nov 2025 18:05:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id hZjkTPCYSL7W; Sun, 16 Nov 2025 18:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1763316314; bh=lmMVqgZlC0X92aStt4oeOukQZPpC9xwSLjgqNNIi1jU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fQnMQgBInjPnp3baBGIs9HTjiH2iP0JLkYUpjyrOonOBmOUWZbzR+Ee83NQ18vHBT
	 rV1CB5dA7fIGQ9ayxNwYSNsC5rL1yZN4cyPMqtO1Z4VxQ7/3kePkDO9XZI5vIrSHBM
	 Bj+IpfA5fey12IMwGMjIjwXg1enfeC0Uaqgb2ErWdsdPizSlT3qRfC7TsmIeFuHOPF
	 i7ACrXM0WL9IY1Y9ZC3kwKismCfePMGBHH7lGJHcY6accB9AUA6wQmhhBGDy00aN2x
	 AWsOCmWuN9mnuXB4zdgn0M73J5K3mXUEKmy42DMv2aYBaXMD9EpG2F4up4YjLeshgT
	 VObZVcmhWOp4/H6qQKHtZsANGIIk6sqGMiiN5uxTM9K4DjJnvy7Hb3697CW6CBQGLA
	 K1LbBBaX8hQIb1RjsuuMzG6wmkF6QSOTfWPSRekLe5ox4Pj7lbn1ERWfk+uXdKheiu
	 Beeb89uwSkmz1u+eW8uyBmDzzlRmGw6yG6yO/ZeOFW6EtZW61jSiyw9cCYcnljRkk2
	 iwcgWXAeVxf7vqU4KJbeDO4wCIvOv5pAvT3kuWQd84QUyL/W8dfyToAmVVVGnB8NJZ
	 8RvnNJrYC3/RrU1DLa0llSjaQ3ehn7k7S6SddXPyHGfcy1v7462ctfgl2rza1yft1J
	 PqqKg2H/wQcyjKdG+lfsmztw=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id EFE1440E015B;
	Sun, 16 Nov 2025 18:05:07 +0000 (UTC)
Date: Sun, 16 Nov 2025 19:05:00 +0100
From: Borislav Petkov <bp@alien8.de>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: x86@kernel.org, linux-edac@vger.kernel.org, tony.luck@intel.com,
	yazen.ghannam@amd.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mce: Add support for PHYSADDRV and
 PHYSADDRVALIDSUPPORTED bits
Message-ID: <20251116180500.GCaRoSTLkTf8q5bWFv@fat_crate.local>
References: <20251113165256.GEaRYM6KyP299yO2Pi@fat_crate.local>
 <20251114202042.2899644-1-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251114202042.2899644-1-avadhut.naik@amd.com>

On Fri, Nov 14, 2025 at 08:20:20PM +0000, Avadhut Naik wrote:
> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> index 53385e6aa230..c6be2f520476 100644
> --- a/arch/x86/kernel/cpu/mce/amd.c
> +++ b/arch/x86/kernel/cpu/mce/amd.c
> @@ -87,6 +87,7 @@ struct smca_bank {
>  	const struct smca_hwid *hwid;
>  	u32 id;			/* Value of MCA_IPID[InstanceId]. */
>  	u8 sysfs_id;		/* Value used for sysfs name. */
> +	bool paddrv_support;	/* Physical Address Valid bit in MCA_CONFIG */

	u64 paddrv	: 1,
	    __reserved	: 63;

Otherwise, yes.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

