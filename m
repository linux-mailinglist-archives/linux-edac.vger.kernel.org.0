Return-Path: <linux-edac+bounces-2784-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A03A01406
	for <lists+linux-edac@lfdr.de>; Sat,  4 Jan 2025 11:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8F8D163D09
	for <lists+linux-edac@lfdr.de>; Sat,  4 Jan 2025 10:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A013189BB0;
	Sat,  4 Jan 2025 10:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gZ3oll3m"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D2577F1B;
	Sat,  4 Jan 2025 10:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735987655; cv=none; b=WG6Lhp90MMVZlcheY2hwNkcbJHFxkjJr/0SBU6yCxkUP9NK5I7l2UExpUDp8u8GsvkvoOXYIK3T1TY9oIhrYbZIR90chugBZ9IBqDoWxNQ/LF9CYUXdf07nWsAkEwFqo+HSxZSyEgjwImyh4U3uplSV62KVnyqLWbFO0WaIOOm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735987655; c=relaxed/simple;
	bh=aWpmdBxIUR96ra3mB6foXSMBu/mJrLe3UcP4rMdfqSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMxQQwFxEB9Jeqk7dOFHQYUAAck9XUdjWLy0Fdh4/GbVai0513Kanw77iUCt0+SdxwF34pFG2FkL5SbyUKTRJj9J3Dz6I5E/7UY/EphgM9Ktdqjc2h+RtAQRuZTz2UkZqubU2vX7BlCHjqQUwUuMupPt2qtZxPsRnDF3bC2nuhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gZ3oll3m; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1BFD540E0169;
	Sat,  4 Jan 2025 10:47:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id j9nOTcgUhFiw; Sat,  4 Jan 2025 10:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1735987648; bh=juW6oz1GgIpLN05C4DhS5HeWDOvIkn4VJwK86A653ZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gZ3oll3m9eVaWpZFz9xLtXj7qyEpzDdyBljo52IvNGmnd7Z6KzhUvllHMm6u7MG6I
	 DBapUgKMe+dLjPXtQp0//WNH0j2xWs3necQhj/PjMu2dcacV3vp2XTZt7QDDXSg93J
	 Cg/WxlwyC8OkNxZaB7wxYGRtp0cdaSta3m1g8qqwvYdhSgBl9l5jBSiNGUOnySgbiq
	 qoE6KZ+7AH1XpDetqegd6zmhWQGCgrgcxj2RMqVA0OOg97MnT5NNNLRYgdql+A3cHX
	 OrphNFO8bL0mqas3wkfdOzMCCjkttassvgo0Po0AzPGNpDAFRkR1a4hU08qvCh1Ae8
	 hGoyxG6qkBlsEZQgaeZX40FUo/NAugos+iGv1hsfPcaMLdX6JeA36Dlowjm9e33CnJ
	 LC/ei575mMNm3DHZQ+r08vSTBHv4XXFaFJp2XVbz9zadzdbImNj56Hjqd3lKQkElB+
	 PyYKSanAfx4GfJ4HnYNUbGZ+Oq9+0f4Q/bz8TwvB1Bo57x3lCjsWclXmGSjoqfKWv5
	 sJG4vWyvJ9Y9UOetrwh0kvi7qWB5sVK4QKGCbLX4bvTpYGDnMyIjW6ZNUPmlXBiTKq
	 qzeMgENILAQXjRMUHTjppCJkxQRakOSiwXctLkmFbU/z+FEmtkLYpkJ2P5fdF45tMJ
	 C9KoxGpvUVz6da1FIZ81W9EA=
Received: from zn.tnic (p200300eA971f93Ba329C23FfFea6A903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:93ba:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C32BB40E01F9;
	Sat,  4 Jan 2025 10:47:13 +0000 (UTC)
Date: Sat, 4 Jan 2025 11:47:05 +0100
From: Borislav Petkov <bp@alien8.de>
To: Zhao Qunqin <zhaoqunqin@loongson.cn>
Cc: chenhuacai@kernel.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@xen0n.name,
	tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
	rric@kernel.org, loongarch@lists.linux.dev, xry111@xry111.site,
	Markus.Elfring@web.de, Jonathan.Cameron@huawei.com,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH V10 RESEND] EDAC: Add EDAC driver for loongson memory
 controller
Message-ID: <20250104104705.GAZ3kRqVra2JaQPn8h@fat_crate.local>
References: <20241216013351.15432-1-zhaoqunqin@loongson.cn>
 <20241216115546.GHZ2AVQi9u5lABWboE@fat_crate.local>
 <2d4e5bd0-34dc-d781-3bd6-9eb7be2c1b17@loongson.cn>
 <20250103161942.GGZ3gOHmenp37jlyyd@fat_crate.local>
 <3194f91f-f20d-714a-20e0-3731df7029c1@loongson.cn>
 <20250104103100.GBZ3kN5GP_EqgD_Urq@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250104103100.GBZ3kN5GP_EqgD_Urq@fat_crate.local>

On Sat, Jan 04, 2025 at 11:31:00AM +0100, Borislav Petkov wrote:
> > That ECC register can not be zeroed.
> 
> Pfff, that's some weird hardware you have there. Oh well. Lemme take a look at
> your patch.

diff --git a/drivers/edac/loongson_edac.c b/drivers/edac/loongson_edac.c
index e267b526b52f..38745800ed01 100644
--- a/drivers/edac/loongson_edac.c
+++ b/drivers/edac/loongson_edac.c
@@ -15,6 +15,13 @@
 
 struct loongson_edac_pvt {
 	void __iomem *ecc_base;
+
+	/*
+	 * The ECC register in this controller records the number of errors
+	 * encountered since reset and cannot be zeroed so in order to be able
+	 * to report the error count at each check, this records the previous
+	 * register state.
+	 */
 	int last_ce_count;
 };


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

