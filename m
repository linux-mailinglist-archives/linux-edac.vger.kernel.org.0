Return-Path: <linux-edac+bounces-413-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B98843A16
	for <lists+linux-edac@lfdr.de>; Wed, 31 Jan 2024 10:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24E181F2F7F4
	for <lists+linux-edac@lfdr.de>; Wed, 31 Jan 2024 09:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4255E633F5;
	Wed, 31 Jan 2024 08:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gcReUIKU"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05408627E2
	for <linux-edac@vger.kernel.org>; Wed, 31 Jan 2024 08:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706691414; cv=none; b=UYZi9F2Q2QRDbM7OqBLa63g0HbNc8nFnIF5c5zQtWMlaebc9UUtTIju7oUyRD0DIYAnc7sWpdhFlcd5w/eLhZZJv5RGq8Jeh0t7ittoMgLbKNvakeSVHAB/1IqY55pFzo57Z0jcsoQ4BKCyPbWFIh7fTQcFWEvyyvIVSWD1hrzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706691414; c=relaxed/simple;
	bh=C3ieyfZsnBEMem9shMliYHuec0hANkL7T50SOUOMQ2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0YuUmp3Li1IcZtaAlP2f/KpeyXVxEY5qCuu4VBM8rJhuRDAv3VXmQD8p72vGt45kuM8Sy5aHeuUSYE+xk7Kkg6fVc0hq/7Mc0YRSGhHHznj1ahpNfuor1XADU7xOfPyZrftx6G6WtJpLZYSStN/OlC/xQq2LluUFkm6svKrq2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gcReUIKU; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A97BD40E00C5;
	Wed, 31 Jan 2024 08:56:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Hhbo1yJ-guZm; Wed, 31 Jan 2024 08:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706691403; bh=Cg4htfhEEjh8H9Z484jwBH/nB3FaN3bSdjKZLJiKJJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gcReUIKUA+gg3CTWWa485FkpH3zPrWzna4ogVU248DPhzo6qhX30DsVEDN+Qr/+eA
	 Gl/bvnsedsPk2cmRRBGRipY2d4nKLyT7acCLXXPZK1ucDWSq+wB5867giSiGIKnvIE
	 u1TXK/3Ly/9Id7UoFGmbSLJC5ONw2AaQ23Fj8m9/6i6av6h28oBwMosWPaj9oi8BpG
	 DtfceYZx5z7DjEaAtcgb7ytXpviaxmWr3PZf5Wr6n9ra/16BTlP2wg0TsaEsVexIN2
	 LfQJs6iDs9VQqxQsvUPOaySEAdZDy+THME6ddZglSAwQD/RpRBvqIVbBaZTgYFzMpm
	 PnV2zm9i0WdqEwPRXMsiCaM1ZUyX2HXqJQ8XPnjlz94g8P92rpzBH6RpBfcQHoQWSh
	 0oCy9g8/TtQBXuuIVCCLJVpxnj6vvMijMUytPcCpaLmuicAWGzihu+is3SIC5epkmx
	 2YdDLJQ1crzTz8NWBrQN9UH+U4AgJObh8x4o1aTC7Iw/rA57sQz7TyU0GUwhRsQO0c
	 4PBMVS/783PuWdF4bdBYTd+ABmZmx4Ue2urDDDvGO61ThhI/3hUUn4657kgl8guZTY
	 qdOF2zMilSc6tw+QrLSUzY9EZVxbHw4opICOyCLf+CrkV2dO0uu8cy30c2IVHRGVVd
	 TEmx1Rk29aLxC/A4Ire2h2w8=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DE86240E00B2;
	Wed, 31 Jan 2024 08:56:38 +0000 (UTC)
Date: Wed, 31 Jan 2024 09:56:38 +0100
From: Borislav Petkov <bp@alien8.de>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: muralidhara.mk@amd.com, linux-edac@vger.kernel.org,
	Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [bug report] RAS/AMD/ATL: Add MI300 support
Message-ID: <20240131085638.GBZboLRr6jsZhqwjfP@fat_crate.local>
References: <18bb00a0-5742-47a5-9dd6-c35c164114e2@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <18bb00a0-5742-47a5-9dd6-c35c164114e2@moroto.mountain>

+ Yazen.

On Wed, Jan 31, 2024 at 11:24:37AM +0300, Dan Carpenter wrote:
> Hello Muralidhara M K,
> 
> The patch 453f0ae79732: "RAS/AMD/ATL: Add MI300 support" from Jan 28,
> 2024 (linux-next), leads to the following (unpublished) Smatch static
> checker warning:
> 
> drivers/ras/amd/atl/dehash.c:389 mi300_dehash_addr() warn: bool mask is always false 'test_bit & hash_ctl_4k'
> drivers/ras/amd/atl/dehash.c:394 mi300_dehash_addr() warn: bool mask is always false 'test_bit & hash_ctl_64k'
> drivers/ras/amd/atl/dehash.c:396 mi300_dehash_addr() warn: bool mask is always false 'test_bit & hash_ctl_2M'
> drivers/ras/amd/atl/dehash.c:398 mi300_dehash_addr() warn: bool mask is always false 'test_bit & hash_ctl_1G'
> drivers/ras/amd/atl/dehash.c:400 mi300_dehash_addr() warn: bool mask is always false 'test_bit & hash_ctl_1T'
> drivers/ras/amd/atl/dehash.c:402 mi300_dehash_addr() warn: bool mask is always false 'test_bit & hash_ctl_1T'
> drivers/ras/amd/atl/dehash.c:419 mi300_dehash_addr() warn: bool mask is always false 'test_bit & hash_ctl_64k'
> drivers/ras/amd/atl/dehash.c:421 mi300_dehash_addr() warn: bool mask is always false 'test_bit & hash_ctl_2M'
> drivers/ras/amd/atl/dehash.c:423 mi300_dehash_addr() warn: bool mask is always false 'test_bit & hash_ctl_1G'
> drivers/ras/amd/atl/dehash.c:425 mi300_dehash_addr() warn: bool mask is always false 'test_bit & hash_ctl_1T'
> 
> drivers/ras/amd/atl/dehash.c
>     357 static int mi300_dehash_addr(struct addr_ctx *ctx)
>     358 {
>     359         bool hash_ctl_4k, hash_ctl_64k, hash_ctl_2M, hash_ctl_1G, hash_ctl_1T;
>     360         bool hashed_bit, intlv_bit, test_bit;
>     361         u8 num_intlv_bits, base_bit, i;
>     362 
>     363         if (!map_bits_valid(ctx, 8, 8, 4, 1))
>     364                 return -EINVAL;
>     365 
>     366         hash_ctl_4k  = FIELD_GET(DF4p5_HASH_CTL_4K, ctx->map.ctl);
> 
> hash_ctl_4k is bool.
> 
>     367         hash_ctl_64k = FIELD_GET(DF4_HASH_CTL_64K,  ctx->map.ctl);
>     368         hash_ctl_2M  = FIELD_GET(DF4_HASH_CTL_2M,   ctx->map.ctl);
>     369         hash_ctl_1G  = FIELD_GET(DF4_HASH_CTL_1G,   ctx->map.ctl);
>     370         hash_ctl_1T  = FIELD_GET(DF4p5_HASH_CTL_1T, ctx->map.ctl);
>     371 
>     372         /* Channel bits */
>     373         num_intlv_bits = ilog2(ctx->map.num_intlv_chan);
>     374 
>     375         for (i = 0; i < num_intlv_bits; i++) {
>     376                 base_bit = 8 + i;
>     377 
>     378                 /* COH_ST_Select[4] jumps to a base bit of 14. */
>     379                 if (i == 4)
>     380                         base_bit = 14;
>     381 
>     382                 intlv_bit = BIT_ULL(base_bit) & ctx->ret_addr;
>     383 
>     384                 hashed_bit = intlv_bit;
>     385 
>     386                 /* 4k hash bit only applies to the first 3 bits. */
>     387                 if (i <= 2) {
>     388                         test_bit    = BIT_ULL(12 + i) & ctx->ret_addr;
> 
> test_bit is BIT(12 - 14).

test_bit is (BIT(14) & ctx->ret_addr), if i == 2, for example.

If ctx->ret_addr has bit 14 set, test_bit will be 1.

I'm confused.

Leaving in the rest for Yazen.

> 
> --> 389                         hashed_bit ^= test_bit & hash_ctl_4k;
> 
> BIT(12) & true is always false.
> 
>     390                 }
>     391 
>     392                 /* Use temporary 'test_bit' value to avoid Sparse warnings. */
>     393                 test_bit    = BIT_ULL(15 + i) & ctx->ret_addr;
>     394                 hashed_bit ^= test_bit & hash_ctl_64k;
>     395                 test_bit    = BIT_ULL(22 + i) & ctx->ret_addr;
>     396                 hashed_bit ^= test_bit & hash_ctl_2M;
>     397                 test_bit    = BIT_ULL(29 + i) & ctx->ret_addr;
>     398                 hashed_bit ^= test_bit & hash_ctl_1G;
>     399                 test_bit    = BIT_ULL(36 + i) & ctx->ret_addr;
>     400                 hashed_bit ^= test_bit & hash_ctl_1T;
>     401                 test_bit    = BIT_ULL(43 + i) & ctx->ret_addr;
>     402                 hashed_bit ^= test_bit & hash_ctl_1T;
>     403 
>     404                 if (hashed_bit != intlv_bit)
>     405                         ctx->ret_addr ^= BIT_ULL(base_bit);
>     406         }
>     407 
>     408         /* Die bits */
>     409         num_intlv_bits = ilog2(ctx->map.num_intlv_dies);
>     410 
>     411         for (i = 0; i < num_intlv_bits; i++) {
>     412                 base_bit = 12 + i;
>     413 
>     414                 intlv_bit = BIT_ULL(base_bit) & ctx->ret_addr;
>     415 
>     416                 hashed_bit = intlv_bit;
>     417 
>     418                 test_bit    = BIT_ULL(20 + i) & ctx->ret_addr;
>     419                 hashed_bit ^= test_bit & hash_ctl_64k;
>     420                 test_bit    = BIT_ULL(27 + i) & ctx->ret_addr;
>     421                 hashed_bit ^= test_bit & hash_ctl_2M;
>     422                 test_bit    = BIT_ULL(34 + i) & ctx->ret_addr;
>     423                 hashed_bit ^= test_bit & hash_ctl_1G;
>     424                 test_bit    = BIT_ULL(41 + i) & ctx->ret_addr;
>     425                 hashed_bit ^= test_bit & hash_ctl_1T;
>     426 
>     427                 if (hashed_bit != intlv_bit)
>     428                         ctx->ret_addr ^= BIT_ULL(base_bit);
>     429         }
>     430 
>     431         return 0;
>     432 }
> 
> regards,
> dan carpenter
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

