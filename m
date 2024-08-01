Return-Path: <linux-edac+bounces-1603-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1B7943D56
	for <lists+linux-edac@lfdr.de>; Thu,  1 Aug 2024 02:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E91601C21200
	for <lists+linux-edac@lfdr.de>; Thu,  1 Aug 2024 00:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838A61A4881;
	Thu,  1 Aug 2024 00:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gov4HF5v"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562AD1A4879;
	Thu,  1 Aug 2024 00:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471873; cv=none; b=Xn61TFloLxq2Yg/Igkndle3euPkjuz5nndTrtuo/2P8qy6uUYCPxjYxZdWjYhywt7nKoc4ufYTC0xzmM+M9fqE1epjwX7ArRPeOUONROGd1s5gb7ePUSMdosTV16jFCzyP984QYjH0mgfQ5UwSDeuAN9zfZr/sULyNZnJ3zov+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471873; c=relaxed/simple;
	bh=nUUVQCzER6B/GQwZPzFs/OZUqDisnv1PkQ2u02oHrX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sBzTfIu8Vro7rVPzUw0i9p/RFRVGudSWf81USnk3TcwHInmbo6FUM2U+AoNi5CVMUJ9mDNwKqH0xERxUQ3CkkMpcu0fee34Uh/M0cu6A2AKolZXBbxCGUilZBr2IcVW/90Vuyb0yN2WrdWfWTsgjztbB4Chm5mdn6hGQsGSsUz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gov4HF5v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5666EC32786;
	Thu,  1 Aug 2024 00:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471873;
	bh=nUUVQCzER6B/GQwZPzFs/OZUqDisnv1PkQ2u02oHrX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gov4HF5vPvX/mc8RpnQWy/0htPxTHMq/Qkp7Qfy9u7D9HABziuwC4c1Z9gapCEGpO
	 Uvd6xgPh5vrTnOjio0Jft8KiihHH96wzPU8U1/Ej0fQ3douhwwQGfwHAigw6wahi2L
	 mrV5e40hWbWZ9hktpHEmcnHQyU8eUTqF1R4r4KQzR7PTw9KxDnmZrGSnRcoWfOGofQ
	 EikSZbVXTGWs3Af/TGMxzq2slkxaVP82I7R/+IxKvNG4qldFJ0d0Sk4GNtZQXHACkh
	 1uWDL7lSNz3lM/dZ4GZGkTgRC/kig7RwO9TQsmbQIJ6DUhPyjbBgiQM9MbSkIDMeqm
	 uqgQFohmn7TPQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
	Borislav Petkov <bp@alien8.de>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-edac@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 47/83] EDAC/amd64: Check return value of amd_smn_read()
Date: Wed, 31 Jul 2024 20:18:02 -0400
Message-ID: <20240801002107.3934037-47-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002107.3934037-1-sashal@kernel.org>
References: <20240801002107.3934037-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
Content-Transfer-Encoding: 8bit

From: Yazen Ghannam <yazen.ghannam@amd.com>

[ Upstream commit 5ac6293047cf5de6daca662347c19347e856c2a5 ]

Check the return value of amd_smn_read() before saving a value. This
ensures invalid values aren't saved. The struct umc instance is
initialized to 0 during memory allocation. Therefore, a bad read will
keep the value as 0 providing the expected Read-as-Zero behavior.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://lore.kernel.org/r/20240606-fix-smn-bad-read-v4-2-ffde21931c3f@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/edac/amd64_edac.c | 51 ++++++++++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index b61c7f02a8c17..cce96a982d5ba 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1720,6 +1720,7 @@ static void umc_read_base_mask(struct amd64_pvt *pvt)
 	u32 *base, *base_sec;
 	u32 *mask, *mask_sec;
 	int cs, umc;
+	u32 tmp;
 
 	for_each_umc(umc) {
 		umc_base_reg = get_umc_base(umc) + UMCCH_BASE_ADDR;
@@ -1732,13 +1733,17 @@ static void umc_read_base_mask(struct amd64_pvt *pvt)
 			base_reg = umc_base_reg + (cs * 4);
 			base_reg_sec = umc_base_reg_sec + (cs * 4);
 
-			if (!amd_smn_read(pvt->mc_node_id, base_reg, base))
+			if (!amd_smn_read(pvt->mc_node_id, base_reg, &tmp)) {
+				*base = tmp;
 				edac_dbg(0, "  DCSB%d[%d]=0x%08x reg: 0x%x\n",
 					 umc, cs, *base, base_reg);
+			}
 
-			if (!amd_smn_read(pvt->mc_node_id, base_reg_sec, base_sec))
+			if (!amd_smn_read(pvt->mc_node_id, base_reg_sec, &tmp)) {
+				*base_sec = tmp;
 				edac_dbg(0, "    DCSB_SEC%d[%d]=0x%08x reg: 0x%x\n",
 					 umc, cs, *base_sec, base_reg_sec);
+			}
 		}
 
 		umc_mask_reg = get_umc_base(umc) + UMCCH_ADDR_MASK;
@@ -1751,13 +1756,17 @@ static void umc_read_base_mask(struct amd64_pvt *pvt)
 			mask_reg = umc_mask_reg + (cs * 4);
 			mask_reg_sec = umc_mask_reg_sec + (cs * 4);
 
-			if (!amd_smn_read(pvt->mc_node_id, mask_reg, mask))
+			if (!amd_smn_read(pvt->mc_node_id, mask_reg, &tmp)) {
+				*mask = tmp;
 				edac_dbg(0, "  DCSM%d[%d]=0x%08x reg: 0x%x\n",
 					 umc, cs, *mask, mask_reg);
+			}
 
-			if (!amd_smn_read(pvt->mc_node_id, mask_reg_sec, mask_sec))
+			if (!amd_smn_read(pvt->mc_node_id, mask_reg_sec, &tmp)) {
+				*mask_sec = tmp;
 				edac_dbg(0, "    DCSM_SEC%d[%d]=0x%08x reg: 0x%x\n",
 					 umc, cs, *mask_sec, mask_reg_sec);
+			}
 		}
 	}
 }
@@ -3170,7 +3179,7 @@ static void umc_read_mc_regs(struct amd64_pvt *pvt)
 {
 	u8 nid = pvt->mc_node_id;
 	struct amd64_umc *umc;
-	u32 i, umc_base;
+	u32 i, tmp, umc_base;
 
 	/* Read registers from each UMC */
 	for_each_umc(i) {
@@ -3178,11 +3187,20 @@ static void umc_read_mc_regs(struct amd64_pvt *pvt)
 		umc_base = get_umc_base(i);
 		umc = &pvt->umc[i];
 
-		amd_smn_read(nid, umc_base + get_umc_reg(pvt, UMCCH_DIMM_CFG), &umc->dimm_cfg);
-		amd_smn_read(nid, umc_base + UMCCH_UMC_CFG, &umc->umc_cfg);
-		amd_smn_read(nid, umc_base + UMCCH_SDP_CTRL, &umc->sdp_ctrl);
-		amd_smn_read(nid, umc_base + UMCCH_ECC_CTRL, &umc->ecc_ctrl);
-		amd_smn_read(nid, umc_base + UMCCH_UMC_CAP_HI, &umc->umc_cap_hi);
+		if (!amd_smn_read(nid, umc_base + get_umc_reg(pvt, UMCCH_DIMM_CFG), &tmp))
+			umc->dimm_cfg = tmp;
+
+		if (!amd_smn_read(nid, umc_base + UMCCH_UMC_CFG, &tmp))
+			umc->umc_cfg = tmp;
+
+		if (!amd_smn_read(nid, umc_base + UMCCH_SDP_CTRL, &tmp))
+			umc->sdp_ctrl = tmp;
+
+		if (!amd_smn_read(nid, umc_base + UMCCH_ECC_CTRL, &tmp))
+			umc->ecc_ctrl = tmp;
+
+		if (!amd_smn_read(nid, umc_base + UMCCH_UMC_CAP_HI, &tmp))
+			umc->umc_cap_hi = tmp;
 	}
 }
 
@@ -3908,16 +3926,21 @@ static void gpu_read_mc_regs(struct amd64_pvt *pvt)
 {
 	u8 nid = pvt->mc_node_id;
 	struct amd64_umc *umc;
-	u32 i, umc_base;
+	u32 i, tmp, umc_base;
 
 	/* Read registers from each UMC */
 	for_each_umc(i) {
 		umc_base = gpu_get_umc_base(i, 0);
 		umc = &pvt->umc[i];
 
-		amd_smn_read(nid, umc_base + UMCCH_UMC_CFG, &umc->umc_cfg);
-		amd_smn_read(nid, umc_base + UMCCH_SDP_CTRL, &umc->sdp_ctrl);
-		amd_smn_read(nid, umc_base + UMCCH_ECC_CTRL, &umc->ecc_ctrl);
+		if (!amd_smn_read(nid, umc_base + UMCCH_UMC_CFG, &tmp))
+			umc->umc_cfg = tmp;
+
+		if (!amd_smn_read(nid, umc_base + UMCCH_SDP_CTRL, &tmp))
+			umc->sdp_ctrl = tmp;
+
+		if (!amd_smn_read(nid, umc_base + UMCCH_ECC_CTRL, &tmp))
+			umc->ecc_ctrl = tmp;
 	}
 }
 
-- 
2.43.0


