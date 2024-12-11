Return-Path: <linux-edac+bounces-2692-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B31CB9ED529
	for <lists+linux-edac@lfdr.de>; Wed, 11 Dec 2024 19:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9210C188A8DC
	for <lists+linux-edac@lfdr.de>; Wed, 11 Dec 2024 18:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CEF243B78;
	Wed, 11 Dec 2024 18:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="G3pycDTM"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F14320A5CF;
	Wed, 11 Dec 2024 18:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943090; cv=none; b=dbApn/r+vGoKXQxtafB6+NFefN/Yuz9qvAJXC2lfWeE5vulut/msYDf3KnUbiV2T7CmSCmgzA16A4GlRwmNg3L9Zq94MGo8GrhbhxqANN7kQsIyRLdMKmZ15zHv0crxO3Hi28jdBlw5opBmtBMSYbfvtKx0wVW8Pbs94aYw8U2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943090; c=relaxed/simple;
	bh=WoyA7OWH5Qvlen/f3neg+ScdJPR1D5h1M4EMJoCaJTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=riNsjwxpqdTZc9LkntXXMv8Gnf9k7OLNCkUYsBeqGMmk3VHFPjNR3P5OQ1C5cT7ZRUBZ9J3SPwSoeQmMvuFyDC1eOfPvpJN5oDJaZ87DuC0C2cURFczlmjo4HztRkG8ifosEh0XNtqzkiv+DTDTdxb7yJZItMoHKqjzkfxGlj68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=G3pycDTM; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BC2E640E0286;
	Wed, 11 Dec 2024 18:51:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id eoAceNr_HFv2; Wed, 11 Dec 2024 18:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1733943079; bh=RA2H9U4SxryZDWZnv9X2f5ptbQod2yGxSYJICJzMCz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G3pycDTMFk8B3cISrO2F6Z0q59dVwQ/FUYRL8QOxOEIE85iLHEHOICBOz2VAYWRxQ
	 No5+BgmcDlYoDIboRebBepFj6GOnlkJfwRCHP0ESPNSvnb/r/5XwQ9Nq5OQBWCdMyb
	 cPWN2Irxf8y1BSkIgYq529I8MvyaXfjRteIOGg2suIom6BHnDYYrxLIHLYMlkqFjqK
	 5YGNnFpRzWJIQUcxuI0ncudCNJtkSkCigcZBGRrzcJcBH+lNT4J+PxwLJUPnKUc+g/
	 bjNzKsqyKFOeWLjRvFV5rF+lYQr6ue6X4MHayOxBVGtuoU5gD+wHNGNhmhuQkzBiR5
	 KjHZcni/9UQeZtjgoTTMt2/+LpJcpmlFyS02WFqAraVPzQu7h1c4py4/K7kUK+bMki
	 c4icbj29bhnWgqFxFpmyFAp7vHxjjo30QI7wpCb+FuTCEZsh/tvHmT9QQiiY/U/pVP
	 T3r+hzjUE6k5UMJF9DlA6frXok/cyMXekNk/jQnrpqaldlmm1eRl7VkEtHBnWReKLF
	 NzA5sRDlvLs0yzDuQZKU2kk0V1FDmkaw3aK2WCwvM8c/uQE0eSNN2E9AUO9zJk1n0C
	 EyZdYPT9hTc6jBgOLErNUiBpzL/4gwm14L/D5O1MA9h01XFAQmUZXcE5rw1RgOJqL6
	 8OL6tLgSq5VS9cedbGkuZFwc=
Received: from zn.tnic (p200300ea971f93ce329c23ffFea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:93ce:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7C19E40E0289;
	Wed, 11 Dec 2024 18:51:15 +0000 (UTC)
Date: Wed, 11 Dec 2024 19:51:09 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Avadhut Naik <avadhut.naik@amd.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] EDAC/amd64: Fix possible module load failure on some
 UMC usage combinations
Message-ID: <20241211185109.GFZ1nfHQBJB4rdXXSI@fat_crate.local>
References: <20241210212054.3895697-1-avadhut.naik@amd.com>
 <20241211110729.GAZ1lycaGYmjgNDGv9@fat_crate.local>
 <20241211154637.GA1923270@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241211154637.GA1923270@yaz-khff2.amd.com>

On Wed, Dec 11, 2024 at 10:46:37AM -0500, Yazen Ghannam wrote:
> Looks good overall. We can even remove the "nid" variable and just use
> "pvt->mc_node_id" directly in the debug message. This is another remnant
> from when this function did register accesses.

Ok, done.

Avadhut, can you pls verify this fixes your issue too?

I'll run it on my boxes too, to make sure nothing breaks.

Thx.

---
From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Wed, 11 Dec 2024 12:07:42 +0100
Subject: [PATCH] EDAC/amd64: Simplify ECC check on unified memory controllers

The intent of the check is to see whether at least one UMC has ECC
enabled. So do that instead of tracking which ones are enabled in masks
which are too small in size anyway and lead to not loading the driver on
Zen4 machines with UMCs enabled over UMC8.

Fixes: e2be5955a886 ("EDAC/amd64: Add support for AMD Family 19h Models 10h-1Fh and A0h-AFh")
Reported-by: Avadhut Naik <avadhut.naik@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/20241210212054.3895697-1-avadhut.naik@amd.com
---
 drivers/edac/amd64_edac.c | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index ddfbdb66b794..5d356b7c4589 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3362,36 +3362,24 @@ static bool dct_ecc_enabled(struct amd64_pvt *pvt)
 
 static bool umc_ecc_enabled(struct amd64_pvt *pvt)
 {
-	u8 umc_en_mask = 0, ecc_en_mask = 0;
-	u16 nid = pvt->mc_node_id;
 	struct amd64_umc *umc;
-	u8 ecc_en = 0, i;
+	bool ecc_en = false;
+	int i;
 
+	/* Check whether at least one UMC is enabled: */
 	for_each_umc(i) {
 		umc = &pvt->umc[i];
 
-		/* Only check enabled UMCs. */
-		if (!(umc->sdp_ctrl & UMC_SDP_INIT))
-			continue;
-
-		umc_en_mask |= BIT(i);
-
-		if (umc->umc_cap_hi & UMC_ECC_ENABLED)
-			ecc_en_mask |= BIT(i);
+		if (umc->sdp_ctrl & UMC_SDP_INIT &&
+		    umc->umc_cap_hi & UMC_ECC_ENABLED) {
+			ecc_en = true;
+			break;
+		}
 	}
 
-	/* Check whether at least one UMC is enabled: */
-	if (umc_en_mask)
-		ecc_en = umc_en_mask == ecc_en_mask;
-	else
-		edac_dbg(0, "Node %d: No enabled UMCs.\n", nid);
-
-	edac_dbg(3, "Node %d: DRAM ECC %s.\n", nid, (ecc_en ? "enabled" : "disabled"));
+	edac_dbg(3, "Node %d: DRAM ECC %s.\n", pvt->mc_node_id, (ecc_en ? "enabled" : "disabled"));
 
-	if (!ecc_en)
-		return false;
-	else
-		return true;
+	return ecc_en;
 }
 
 static inline void
-- 
2.43.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

