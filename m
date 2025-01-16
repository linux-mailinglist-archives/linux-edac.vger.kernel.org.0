Return-Path: <linux-edac+bounces-2927-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CA6A13F09
	for <lists+linux-edac@lfdr.de>; Thu, 16 Jan 2025 17:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E40287A52DE
	for <lists+linux-edac@lfdr.de>; Thu, 16 Jan 2025 16:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3754622BAD9;
	Thu, 16 Jan 2025 16:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="KiasD7Lt"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF32D22A7FA
	for <linux-edac@vger.kernel.org>; Thu, 16 Jan 2025 16:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737044098; cv=none; b=i+jK3xlkH9FZt1nwq0VvpazwjZ082FDM+PaMXrRBSMbh0hrT9ZzUVHcCIFUrx2Rb0ISKU2VQTX2SoSZAPDxDtWSGGAtxsZXblhKQcqoAdwPgfVgcFELK9ittxafxX82ePhlAI3dDzSlBbD3+j6f2IFwL1MYbor3oeFZWmkAjfJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737044098; c=relaxed/simple;
	bh=TF/rE5gO8F+6ECzTVonK6BvUAyoSxu7YIxsQjT2VTo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJfQVKYZpXMAl0WveNMoUSrzSk+a/VKujN5/FNmrBG8Nv7ALVf0qhoLLBB2BuomZA6kEJLUKsCuOnlmRWcGQapkE31ZRTv5c0xS3SJjyJGvj/tDODypZtnQ3FFFNJL6qb3IekuCroYVtC9Vr/4Wen3DJ0IlMt5+oujjVYl8R5s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=KiasD7Lt; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A437140E0289;
	Thu, 16 Jan 2025 16:14:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DSpXVCCTm0WF; Thu, 16 Jan 2025 16:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1737044089; bh=4cbtXMLzyPopkztv6BQOuugSdO0Hp2ZJ/CR118F3wDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KiasD7Ltwg0G/SI2EIAC+122DCxFU9a5tvYr/5rEiIw5Rk518f/QKDhVcZieo1NL7
	 Zo/HitIcvRaEAYzL9/0WF5r0aKcKdvRVotnU2itLnd0WYWTu+X8IUZpZd4mqmQRoK7
	 f9TjPLGUHlLQpaGO5Cjb2zPfzgPlH/BRo4Tm5mtgklbFVC/NUZcaKDMrDNYIqSWDru
	 2fPKzb0Ku/nBGjk6h9LusDshF+EEnK2rUMezcQcLF0ylLr5YkK+cG467m5qEN8EKMD
	 N22h1xlZ9XjHh6quo7eN6WpUIm//TI24G6w0wSGy5P6hQHzzf8HHc3E0sGpkMGJBo2
	 nmNmHoGZsXXCo3KxzoJkd1mbIAgLsgO5t0atXAms697kQgUEkwkW9qtRefvgqkmGYo
	 +D/9cnzrxdd4kUpx3Tt3nLUgRINQmzqg+RhPHEW4N8L4sc25xlH9dyQCYSddNEDEWJ
	 aFgsH9NBgP+CZf6nPJBcgGc7CIpOyJ5KoDyQdiHeqpQpale0U8Ims1enTAvijjrL+d
	 htZMPJS4BiDknjUywCNGux+fCjvZGRIUAcMXIDmp7eWl/ncPTsQwu/hjcZgF0gdgcU
	 pBb2XYdNlWUc3YvaHbxcDH4fNUxMabBfKNcQSfpu2hzYHQyRcu5hpTeaqcHQfn4J+C
	 inbcteCotyFFuf+Fepd94VDY=
Received: from zn.tnic (p200300ea971f934f329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:934f:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9787240E0288;
	Thu, 16 Jan 2025 16:14:43 +0000 (UTC)
Date: Thu, 16 Jan 2025 17:14:36 +0100
From: Borislav Petkov <bp@alien8.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, arnd@arndb.de, jk@ozlabs.org,
	segher@kernel.crashing.org, linux-edac@vger.kernel.org
Subject: Re: [PATCH v2 23/25] EDAC/cell: Remove powerpc Cell driver
Message-ID: <20250116161436.GEZ4kwbBSanEBdIb5c@fat_crate.local>
References: <20241218105523.416573-1-mpe@ellerman.id.au>
 <20241218105523.416573-23-mpe@ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241218105523.416573-23-mpe@ellerman.id.au>

On Wed, Dec 18, 2024 at 09:55:11PM +1100, Michael Ellerman wrote:
> This driver can no longer be built since support for IBM Cell Blades was
> removed, in particular PPC_CELL_COMMON.
> 
> Remove the driver.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
> v2: Rebase.
> 
> Cc: linux-edac@vger.kernel.org
> 
>  drivers/edac/Kconfig     |   8 --
>  drivers/edac/Makefile    |   2 -
>  drivers/edac/cell_edac.c | 281 ---------------------------------------
>  3 files changed, 291 deletions(-)
>  delete mode 100644 drivers/edac/cell_edac.c

You forgot a spot:

diff --git a/arch/powerpc/configs/cell_defconfig b/arch/powerpc/configs/cell_defconfig
index 53f43a34e1a9..b33f0034990c 100644
--- a/arch/powerpc/configs/cell_defconfig
+++ b/arch/powerpc/configs/cell_defconfig
@@ -168,7 +168,6 @@ CONFIG_INFINIBAND_MTHCA=m
 CONFIG_INFINIBAND_IPOIB=m
 CONFIG_INFINIBAND_IPOIB_DEBUG_DATA=y
 CONFIG_EDAC=y
-CONFIG_EDAC_CELL=y
 CONFIG_UIO=m
 CONFIG_EXT2_FS=y
 CONFIG_EXT4_FS=y

Queued with that hunk added.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

