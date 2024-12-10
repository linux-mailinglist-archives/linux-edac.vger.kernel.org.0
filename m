Return-Path: <linux-edac+bounces-2680-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C68409EAD39
	for <lists+linux-edac@lfdr.de>; Tue, 10 Dec 2024 10:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DB782903F4
	for <lists+linux-edac@lfdr.de>; Tue, 10 Dec 2024 09:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721C723DEA8;
	Tue, 10 Dec 2024 09:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="KYRNUWD1"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A5923DEA9;
	Tue, 10 Dec 2024 09:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733824546; cv=none; b=V5j1gshw5HsPCLGDEhEREW0GJIug0dNr71vdZ9ktjryvVs5F02CPmFxEwzDIBCN804n/8+TBUwhOaT/2aiQKo3arGMnJlQ+J6fRyIJpJ2VlE92J4MYFekb7Kv37kH+GzflKjLT9/IW/v99C/DUhlwvn4qrxW2y58Io4ex/Vc/uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733824546; c=relaxed/simple;
	bh=nJvw8OjgEfN86aZGgvHDSYHwGzHylDy7C1ifR7QfabE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GA+9sMAWtFq70PILmv6+qW/ZJ6ogphX39KpSTSAukyZ6nM1XI4Oy1rB3iMn9ePJ7ImvzPJ7Ouo44o6boC5REwHfcUcndc2grHTMtCxOv6ko62HMUQIeIIZko0IRM1n5cd9AVe5pu0QbDzHDjyXVklZGQ2mXiu9/xkCsUSpiKdcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=KYRNUWD1; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C97DC40E0288;
	Tue, 10 Dec 2024 09:55:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JYr7ihBQ9jxY; Tue, 10 Dec 2024 09:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1733824528; bh=wjgFwGsPBT2Mronz4LGT7zyGe+vQt8dAgKVmYFnOZoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KYRNUWD1trLp7EMo7r1jxdZIujeof4zX5hFzGIjutWgJVzAsBVYEPrPM/bU1vK/1Y
	 ep41Jy1zCPRW4ppWLkYuY36XFrXIk0VsN8SksyZZaV9q286fjJbHfVchMepL7uAWvn
	 2AEoDUEEqFbgJjTUWI73rCXIaGWKbXHffeivj1PyUIoMvhk4Ya0xQVm1lXHZGywTRi
	 uybARW2gn/1P8va68mo61RnVgMAvbg+fCZ5eC3njfPUGm95I5z2h2W9/AikvQHJPg7
	 dkU0O5UVUeAaYnnHgloeVUDv2dWa3VQx2JwgiSAwJGGDIz604r5jAOLTyPONvOH8dP
	 IZQeBsEb51CLMFLYhCIVCVTk/ugvCAvYicFH4HzU3iEyUk5FMFrspNmZi/K0N6cbZU
	 dhwhXLlKTfPe9nky/Q1IOJX/Pu9vWMEl13mwcuUSeL/RYjJo0WCDbl+x5wwVlAGc/6
	 t/ilvAv5VqJaW+OtqKi6Jtk1DjW+ha9ziP66fme4mr16qhYUGwyD4lwh1Y5aRkSkZi
	 OAcopP1DNku+gJJnbGOS8UQE8mlKWDu9HaEL/gnweHbU2qboHQ76QSovHqmPizgbva
	 5a0Af5/eA/tHR8sNBHC70nXDuAgx1C8/dfx/AjzkZ4AlNg+nW/nXMr7k6t/v0/54Z/
	 tcWI8zLOC37uecR5fdAddPA0=
Received: from zn.tnic (p200300ea971f9307329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:9307:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 45B5B40E0277;
	Tue, 10 Dec 2024 09:55:24 +0000 (UTC)
Date: Tue, 10 Dec 2024 10:55:17 +0100
From: Borislav Petkov <bp@alien8.de>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	yazen.ghannam@amd.com
Subject: Re: [PATCH] EDAC/amd64: Fix possible module load failure on some UMC
 usage combinations
Message-ID: <20241210095517.GAZ1gQBcS2BKA30-GO@fat_crate.local>
References: <20241209215636.2744733-1-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241209215636.2744733-1-avadhut.naik@amd.com>

On Mon, Dec 09, 2024 at 09:55:10PM +0000, Avadhut Naik wrote:
> Starting Zen4, AMD SOCs have 12 Unified Memory Controllers (UMCs) per
> socket.
> 
> When the amd64_edac module is being loaded, these UMCs are traversed to
> determine if they have SdpInit (SdpCtrl[31]) and EccEnabled (UmcCapHi[30])
> bits set and create masks in umc_en_mask and ecc_en_mask respectively.
> 
> However, the current data type of these variables is u8. As a result, if
> only the last 4 UMCs (UMC8 - UMC11) of the system have been utilized,
> umc_ecc_enabled() will return false. Consequently, the module may fail to
> load on these systems.
> 
> Change the data type of these variables to u16.

No need to explain what the patch does. The "why" is enough.
 
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> ---
>  drivers/edac/amd64_edac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This looks like it needs a CC:stable and a Fixes: tag, right?

While at it, you can simply make those vars int and be done with it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

