Return-Path: <linux-edac+bounces-3492-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 323BAA813BE
	for <lists+linux-edac@lfdr.de>; Tue,  8 Apr 2025 19:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 721311BC001A
	for <lists+linux-edac@lfdr.de>; Tue,  8 Apr 2025 17:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F5C22F150;
	Tue,  8 Apr 2025 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="e/454+UT"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4598F4A00;
	Tue,  8 Apr 2025 17:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744133629; cv=none; b=Ktvzr6ezFqq+seaDpbs8a1NKn6VMZKtyJP25TeZQvF18/JJ5NAqFL99BdHY4KSCq3tXbutV1OwYnEkoYATo+j76j6Uo3oToFkf9mMFBegel12L1uGeBfEqHbi1O2jGtRAgfmN1GYnFmHH0ntr14dTcgHwiYH81CmaS2Mkw3er+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744133629; c=relaxed/simple;
	bh=QREUDbQzRf7w9lKrG1xuyKIYiY6j3MZkE+jBRGcKgds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUuBr52eeKSppKA0fwegk2D0gB6X5x4KDlgHaWyIxr05BNhaIuCAFTYl8tjQT2cSAHOkKpLLTizPbw1zTqa8g84GDEZ99rW9lBKOX9QmrBZ/9lFwWmz3WN1zh+MrJ8l7YDOcCWAmsLsKx3xUpk87K987ASTm5OxH3f6Z7CBKufY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=e/454+UT; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 30E4940E019F;
	Tue,  8 Apr 2025 17:33:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xsSz-F8LuVwG; Tue,  8 Apr 2025 17:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1744133619; bh=g/LpMeFJ1yJcKe8WHOuBe0XU/0xiJE0+8BBgrwK6zts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e/454+UTvh01ibtcfKTI29UTLb+WDh1aSkFZGtinowrYtExlXPQoLVZRnhrUR55Me
	 nNmp1hiFyHfizx1SLyC/hj7ssS2ShjFiUcq3XOAawhCurtAZQ77ljVvzq4R/k2MDGa
	 6QFUVRwN+Oc7ZXaT6xxHn10HizGCunDPJvig8Q8LZbYaTcxxbbv1bxIh/4kXhGS8iy
	 LhWC4xrdrEFKCOU2ibDy+Kg+ta8K4fcLqzC3aJMuKAxaVQL3bOT9rf6udmzNy0Qfee
	 v7a7e5z4l8rp4SlAkVgXhAXG3HG5pF8bqLzlR2FaniQFkZc9efNZxmQt2ZjvAoBhZE
	 32lyCRb5XywmnT7ROEgVfaghYkIEn9cHgmaur/1mXcit/vDEjZsDXpi9/6SgP0XB/4
	 n0lX98VE7ZScqe6H5xDyjpV4h9yDNaetJAIxh7Oxkaof8bhYnk/H4S5YVnM8jbxwV/
	 Puq8a0JgHX4dKn3yAjssAhiLLlEc2UXdoY0rGJztVq4gikjxXH4lS7QoGxwPwTU2ap
	 7DT4uTsZ0juM7lqiHKQVPV0X8kZMEYdN8Zel2fNh2zzTgl0buAoDl5Tc+ytUx+FZfs
	 bFCsd/Uscuoc5fXUgzx63IZoV7ts6+0BjNO5la0x5OcesMfjR8H9OgTY9vx+09vI7q
	 PvOJwHvKftxScnl2Wt138EKc=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5265C40E016D;
	Tue,  8 Apr 2025 17:33:34 +0000 (UTC)
Date: Tue, 8 Apr 2025 19:33:33 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
	Muralidhara M K <muralidhara.mk@amd.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] RAS/AMD/{ATL,FMPM}: Get masked address
Message-ID: <20250408173333.GEZ_Vd7V0hqJfBXFRu@fat_crate.local>
References: <20250401-fix-fmpm-extra-records-v1-0-840bcf7a8ac5@amd.com>
 <20250401-fix-fmpm-extra-records-v1-2-840bcf7a8ac5@amd.com>
 <20250407132415.GCZ_PR_82FKBcsIuGr@fat_crate.local>
 <20250407151657.GA1948540@yaz-khff2.amd.com>
 <20250408101415.GEZ_T29wiuh-_sExlk@fat_crate.local>
 <20250408155242.GA2523543@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250408155242.GA2523543@yaz-khff2.amd.com>

On Tue, Apr 08, 2025 at 11:52:42AM -0400, Yazen Ghannam wrote:
> At the moment, FMPM only loads on MI300A. We can just have a local
> function to mask the addresses. I was thinking we can have function
> pointers to make things generic. But maybe we keep it simple until
> really necessary by just using the MI300 version by default.

Now you're talking! :-P

> Please see patch below.

... which I simplified even more.

I'm thinking whoever is going to test fmpm on something else besides MI300A,
they will have to extend this address masking thing and then we can cross that
bridge when we get to it.

So this is keeping it simple for now.

Ack?

---

commit 58029c39cdc54ac4f4dc40b4a9c05eed9f9b808a (HEAD -> refs/heads/edac-urgent)
Author: Yazen Ghannam <yazen.ghannam@amd.com>
Date:   Thu Feb 27 19:31:32 2025 +0000

    RAS/AMD/FMPM: Get masked address
    
    Some operations require checking, or ignoring, specific bits in an address
    value. For example, this can be comparing address values to identify unique
    structures.
    
    Currently, the full address value is compared when filtering for duplicates.
    This results in over counting and creation of extra records.  This gives the
    impression that more unique events occurred than did in reality.
    
    Mask the address for physical rows on MI300.
    
      [ bp: Simplify. ]
    
    Fixes: 6f15e617cc99 ("RAS: Introduce a FRU memory poison manager")
    Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
    Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
    Cc: stable@vger.kernel.org

diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
index f9be26d25348..d096b58cd0ae 100644
--- a/drivers/ras/amd/atl/internal.h
+++ b/drivers/ras/amd/atl/internal.h
@@ -362,4 +362,7 @@ static inline void atl_debug_on_bad_intlv_mode(struct addr_ctx *ctx)
 	atl_debug(ctx, "Unrecognized interleave mode: %u", ctx->map.intlv_mode);
 }
 
+#define MI300_UMC_MCA_COL	GENMASK(5, 1)
+#define MI300_UMC_MCA_ROW13	BIT(23)
+
 #endif /* __AMD_ATL_INTERNAL_H__ */
diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
index cb8ace3d4e42..6e072b7667e9 100644
--- a/drivers/ras/amd/atl/umc.c
+++ b/drivers/ras/amd/atl/umc.c
@@ -229,7 +229,6 @@ int get_umc_info_mi300(void)
  * Additionally, the PC and Bank bits may be hashed. This must be accounted for before
  * reconstructing the normalized address.
  */
-#define MI300_UMC_MCA_COL	GENMASK(5, 1)
 #define MI300_UMC_MCA_BANK	GENMASK(9, 6)
 #define MI300_UMC_MCA_ROW	GENMASK(24, 10)
 #define MI300_UMC_MCA_PC	BIT(25)
@@ -360,7 +359,6 @@ static void _retire_row_mi300(struct atl_err *a_err)
  *
  * See MI300_UMC_MCA_ROW for the row bits in MCA_ADDR_UMC value.
  */
-#define MI300_UMC_MCA_ROW13	BIT(23)
 static void retire_row_mi300(struct atl_err *a_err)
 {
 	_retire_row_mi300(a_err);
diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
index 90de737fbc90..8877c6ff64c4 100644
--- a/drivers/ras/amd/fmpm.c
+++ b/drivers/ras/amd/fmpm.c
@@ -250,6 +250,13 @@ static bool rec_has_valid_entries(struct fru_rec *rec)
 	return true;
 }
 
+/*
+ * Row retirement is done on MI300 systems, and some bits are 'don't
+ * care' for comparing addresses with unique physical rows.  This
+ * includes all column bits and the row[13] bit.
+ */
+#define MASK_ADDR(addr)	((addr) & ~(MI300_UMC_MCA_ROW13 | MI300_UMC_MCA_COL))
+
 static bool fpds_equal(struct cper_fru_poison_desc *old, struct cper_fru_poison_desc *new)
 {
 	/*
@@ -258,7 +265,7 @@ static bool fpds_equal(struct cper_fru_poison_desc *old, struct cper_fru_poison_
 	 *
 	 * Also, order the checks from most->least likely to fail to shortcut the code.
 	 */
-	if (old->addr != new->addr)
+	if (MASK_ADDR(old->addr) != MASK_ADDR(new->addr))
 		return false;
 
 	if (old->hw_id != new->hw_id)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

