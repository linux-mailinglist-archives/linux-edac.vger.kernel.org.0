Return-Path: <linux-edac+bounces-3579-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC2BA920E9
	for <lists+linux-edac@lfdr.de>; Thu, 17 Apr 2025 17:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4387F5A3A42
	for <lists+linux-edac@lfdr.de>; Thu, 17 Apr 2025 15:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87938253B74;
	Thu, 17 Apr 2025 15:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X/rHbQiW"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB4E253B66;
	Thu, 17 Apr 2025 15:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744902564; cv=none; b=q8c7oNV/Fxr5LZOn+ISakwj/LkPhXNYY5Yr+1uMUOshPFkRFnHshBLKrVjHNUqwk3YDaenlnjR1TvdjpahMMI9iCQGPaAho2TwxeYDWzERiWpga56Wy8xyph893g5a5AUaHZBAisbvl47X5EmuYoaxtMYbvfKn7QN+nSZp9SGoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744902564; c=relaxed/simple;
	bh=2+rdq708IgOQ8Y9SrhY0PXGXgcLtCeRE4b9uBqxRRyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ym+rHLluqO04zSTodhLd+jpNxS7c0ecyU8LO6RaMqYgCPV/DGxZLkMkago/35UPsqL9l33qvDjOaVxBfkUpArFhYR9DtHJYIgYG2KXbRAgFEF83tHA3sNJgh7MGH6LXgIxok+g3L2UrcIsg3+Hn11jx8zg/a0kW/kZmv/hMTjCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X/rHbQiW; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744902562; x=1776438562;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2+rdq708IgOQ8Y9SrhY0PXGXgcLtCeRE4b9uBqxRRyA=;
  b=X/rHbQiWOBkQuUiE0qwjPAO/wadOKcE78T+y7S6qom03ZDK2Zi9gfrlo
   254fYT+Tgd+zY8XUUVIGEWsoPppFQeTIOnVNgQiEtdhDQ1kgsOMSbhFOY
   C6j3ooBKJPivfY+kmoU0Tk+M/rW9AuVX8nmaZJyvibeopveParWrvv/5t
   kxN3Duo0gtF/7S1Q/BcH3dnsMjtmXYFA3TdsBRFmGPd9ZxnuQIYzJ5fw3
   rQQHG/HV90WmAG30sKHkOI25/53cN6+GuJFGvkpCMVcsx9AdAkLLlQa3q
   1irTZ3RR/iSt8TyZx1LvTqB62Cg37p91j0KBf6znZmlq7M2WASqZOR87o
   w==;
X-CSE-ConnectionGUID: pcZQe3nbQlmowMrTxFnLnQ==
X-CSE-MsgGUID: 1UBPZomBSci5LLZT4UX5Jg==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="57488743"
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="57488743"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 08:09:22 -0700
X-CSE-ConnectionGUID: iEpU18jaToyCyaaAXg9N7g==
X-CSE-MsgGUID: dbxj0U2wQGaJaTbvt1xWiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="161876933"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 08:09:19 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Feng Xu <feng.f.xu@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Yi Lai <yi1.lai@intel.com>,
	Shawn Fan <shawn.fan@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] EDAC/{skx_common,i10nm}: Refactor show_retry_rd_err_log()
Date: Thu, 17 Apr 2025 23:07:23 +0800
Message-ID: <20250417150724.1170168-7-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417150724.1170168-1-qiuxu.zhuo@intel.com>
References: <20250417150724.1170168-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make the {valid bit, overwritten status, number} of RRL registers and the
{number, offsets, widths} of per-channel CORRERRCNT registers configurable.
Refactor show_retry_rd_err_log() to use the configurable fields of struct
reg_rrl, making the code more scalable and simpler.

No functional changes intended.

Tested-by: Feng Xu <feng.f.xu@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/i10nm_base.c | 158 +++++++++++++++++---------------------
 drivers/edac/skx_common.h |  11 ++-
 2 files changed, 79 insertions(+), 90 deletions(-)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index 2a03db86883c..aefc448283d3 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -72,8 +72,6 @@
 #define I10NM_SAD_ENABLE(reg)		GET_BITFIELD(reg, 0, 0)
 #define I10NM_SAD_NM_CACHEABLE(reg)	GET_BITFIELD(reg, 5, 5)
 
-#define RETRY_RD_ERR_LOG_OVER_UC_V	(BIT(2) | BIT(1) | BIT(0))
-
 static struct list_head *i10nm_edac_list;
 
 static struct res_config *res_cfg;
@@ -83,20 +81,28 @@ static bool mem_cfg_2lm;
 
 static struct reg_rrl icx_reg_rrl_ddr = {
 	.set_num = 2,
+	.reg_num = 6,
 	.modes = {LRE_SCRUB, LRE_DEMAND},
 	.offsets = {
 		{0x22c60, 0x22c54, 0x22c5c, 0x22c58, 0x22c28, 0x20ed8},
 		{0x22e54, 0x22e60, 0x22e64, 0x22e58, 0x22e5c, 0x20ee0},
 	},
 	.widths		= {4, 4, 4, 4, 4, 8},
+	.v_mask		= BIT(0),
 	.uc_mask	= BIT(1),
+	.over_mask	= BIT(2),
 	.en_patspr_mask	= BIT(13),
 	.noover_mask	= BIT(14),
 	.en_mask	= BIT(15),
+
+	.cecnt_num	= 4,
+	.cecnt_offsets	= {0x22c18, 0x22c1c, 0x22c20, 0x22c24},
+	.cecnt_widths	= {4, 4, 4, 4},
 };
 
 static struct reg_rrl spr_reg_rrl_ddr = {
 	.set_num = 3,
+	.reg_num = 6,
 	.modes = {LRE_SCRUB, LRE_DEMAND, FRE_DEMAND},
 	.offsets = {
 		{0x22c60, 0x22c54, 0x22f08, 0x22c58, 0x22c28, 0x20ed8},
@@ -104,38 +110,58 @@ static struct reg_rrl spr_reg_rrl_ddr = {
 		{0x22c70, 0x22d80, 0x22f18, 0x22d58, 0x22c64, 0x20f10},
 	},
 	.widths		= {4, 4, 8, 4, 4, 8},
+	.v_mask		= BIT(0),
 	.uc_mask	= BIT(1),
+	.over_mask	= BIT(2),
 	.en_patspr_mask	= BIT(13),
 	.noover_mask	= BIT(14),
 	.en_mask	= BIT(15),
+
+	.cecnt_num	= 4,
+	.cecnt_offsets	= {0x22c18, 0x22c1c, 0x22c20, 0x22c24},
+	.cecnt_widths	= {4, 4, 4, 4},
 };
 
 static struct reg_rrl spr_reg_rrl_hbm_pch0 = {
 	.set_num = 2,
+	.reg_num = 6,
 	.modes = {LRE_SCRUB, LRE_DEMAND},
 	.offsets = {
 		{0x2860, 0x2854, 0x2b08, 0x2858, 0x2828, 0x0ed8},
 		{0x2a54, 0x2a60, 0x2b10, 0x2a58, 0x2a5c, 0x0ee0},
 	},
 	.widths		= {4, 4, 8, 4, 4, 8},
+	.v_mask		= BIT(0),
 	.uc_mask	= BIT(1),
+	.over_mask	= BIT(2),
 	.en_patspr_mask	= BIT(13),
 	.noover_mask	= BIT(14),
 	.en_mask	= BIT(15),
+
+	.cecnt_num	= 4,
+	.cecnt_offsets	= {0x2818, 0x281c, 0x2820, 0x2824},
+	.cecnt_widths	= {4, 4, 4, 4},
 };
 
 static struct reg_rrl spr_reg_rrl_hbm_pch1 = {
 	.set_num = 2,
+	.reg_num = 6,
 	.modes = {LRE_SCRUB, LRE_DEMAND},
 	.offsets = {
 		{0x2c60, 0x2c54, 0x2f08, 0x2c58, 0x2c28, 0x0fa8},
 		{0x2e54, 0x2e60, 0x2f10, 0x2e58, 0x2e5c, 0x0fb0},
 	},
 	.widths		= {4, 4, 8, 4, 4, 8},
+	.v_mask		= BIT(0),
 	.uc_mask	= BIT(1),
+	.over_mask	= BIT(2),
 	.en_patspr_mask	= BIT(13),
 	.noover_mask	= BIT(14),
 	.en_mask	= BIT(15),
+
+	.cecnt_num	= 4,
+	.cecnt_offsets	= {0x2c18, 0x2c1c, 0x2c20, 0x2c24},
+	.cecnt_widths	= {4, 4, 4, 4},
 };
 
 static u64 read_imc_reg(struct skx_imc *imc, int chan, u32 offset, u8 width)
@@ -276,110 +302,64 @@ static void enable_retry_rd_err_log(bool enable)
 static void show_retry_rd_err_log(struct decoded_addr *res, char *msg,
 				  int len, bool scrub_err)
 {
+	int i, j, n, ch = res->channel, pch = res->cs & 1;
 	struct skx_imc *imc = &res->dev->imc[res->imc];
-	u32 log0, log1, log2, log3, log4;
-	u32 corr0, corr1, corr2, corr3;
-	u32 lxg0, lxg1, lxg3, lxg4;
-	u32 *xffsets = NULL;
-	u64 log2a, log5;
-	u64 lxg2a, lxg5;
-	u32 *offsets;
-	int n, pch;
+	u32 offset, status_mask;
+	struct reg_rrl *rrl;
+	u64 log, corr;
+	bool scrub;
+	u8 width;
 
 	if (!imc->mbase)
 		return;
 
-	if (imc->hbm_mc) {
-		pch = res->cs & 1;
+	rrl = imc->hbm_mc ? res_cfg->reg_rrl_hbm[pch] : res_cfg->reg_rrl_ddr;
 
-		if (pch)
-			offsets = scrub_err ? res_cfg->reg_rrl_hbm[1]->offsets[0] :
-					      res_cfg->reg_rrl_hbm[1]->offsets[1];
-		else
-			offsets = scrub_err ? res_cfg->reg_rrl_hbm[0]->offsets[0] :
-					      res_cfg->reg_rrl_hbm[0]->offsets[1];
-	} else {
-		if (scrub_err) {
-			offsets = res_cfg->reg_rrl_ddr->offsets[0];
-		} else {
-			offsets = res_cfg->reg_rrl_ddr->offsets[1];
-			if (res_cfg->reg_rrl_ddr->set_num > 2)
-				xffsets = res_cfg->reg_rrl_ddr->offsets[2];
-		}
-	}
+	if (!rrl)
+		return;
 
-	log0 = I10NM_GET_REG32(imc, res->channel, offsets[0]);
-	log1 = I10NM_GET_REG32(imc, res->channel, offsets[1]);
-	log3 = I10NM_GET_REG32(imc, res->channel, offsets[3]);
-	log4 = I10NM_GET_REG32(imc, res->channel, offsets[4]);
-	log5 = I10NM_GET_REG64(imc, res->channel, offsets[5]);
+	status_mask = rrl->over_mask | rrl->uc_mask | rrl->v_mask;
 
-	if (xffsets) {
-		lxg0 = I10NM_GET_REG32(imc, res->channel, xffsets[0]);
-		lxg1 = I10NM_GET_REG32(imc, res->channel, xffsets[1]);
-		lxg3 = I10NM_GET_REG32(imc, res->channel, xffsets[3]);
-		lxg4 = I10NM_GET_REG32(imc, res->channel, xffsets[4]);
-		lxg5 = I10NM_GET_REG64(imc, res->channel, xffsets[5]);
-	}
+	n = snprintf(msg, len, " retry_rd_err_log[");
+	for (i = 0; i < rrl->set_num; i++) {
+		scrub = (rrl->modes[i] == FRE_SCRUB || rrl->modes[i] == LRE_SCRUB);
+		if (scrub_err != scrub)
+			continue;
 
-	if (res_cfg->type == SPR) {
-		log2a = I10NM_GET_REG64(imc, res->channel, offsets[2]);
-		n = snprintf(msg, len, " retry_rd_err_log[%.8x %.8x %.16llx %.8x %.8x %.16llx",
-			     log0, log1, log2a, log3, log4, log5);
+		for (j = 0; j < rrl->reg_num && len - n > 0; j++) {
+			offset = rrl->offsets[i][j];
+			width = rrl->widths[j];
+			log = read_imc_reg(imc, ch, offset, width);
 
-		if (len - n > 0) {
-			if (xffsets) {
-				lxg2a = I10NM_GET_REG64(imc, res->channel, xffsets[2]);
-				n += snprintf(msg + n, len - n, " %.8x %.8x %.16llx %.8x %.8x %.16llx]",
-					     lxg0, lxg1, lxg2a, lxg3, lxg4, lxg5);
-			} else {
-				n += snprintf(msg + n, len - n, "]");
-			}
-		}
-	} else {
-		log2 = I10NM_GET_REG32(imc, res->channel, offsets[2]);
-		n = snprintf(msg, len, " retry_rd_err_log[%.8x %.8x %.8x %.8x %.8x %.16llx]",
-			     log0, log1, log2, log3, log4, log5);
-	}
+			if (width == 4)
+				n += snprintf(msg + n, len - n, "%.8llx ", log);
+			else
+				n += snprintf(msg + n, len - n, "%.16llx ", log);
 
-	if (imc->hbm_mc) {
-		if (pch) {
-			corr0 = I10NM_GET_REG32(imc, res->channel, 0x2c18);
-			corr1 = I10NM_GET_REG32(imc, res->channel, 0x2c1c);
-			corr2 = I10NM_GET_REG32(imc, res->channel, 0x2c20);
-			corr3 = I10NM_GET_REG32(imc, res->channel, 0x2c24);
-		} else {
-			corr0 = I10NM_GET_REG32(imc, res->channel, 0x2818);
-			corr1 = I10NM_GET_REG32(imc, res->channel, 0x281c);
-			corr2 = I10NM_GET_REG32(imc, res->channel, 0x2820);
-			corr3 = I10NM_GET_REG32(imc, res->channel, 0x2824);
+			/* Clear RRL status if RRL in Linux control mode. */
+			if (retry_rd_err_log == 2 && !j && (log & status_mask))
+				write_imc_reg(imc, ch, offset, width, log & ~status_mask);
 		}
-	} else {
-		corr0 = I10NM_GET_REG32(imc, res->channel, 0x22c18);
-		corr1 = I10NM_GET_REG32(imc, res->channel, 0x22c1c);
-		corr2 = I10NM_GET_REG32(imc, res->channel, 0x22c20);
-		corr3 = I10NM_GET_REG32(imc, res->channel, 0x22c24);
 	}
 
-	if (len - n > 0)
-		snprintf(msg + n, len - n,
-			 " correrrcnt[%.4x %.4x %.4x %.4x %.4x %.4x %.4x %.4x]",
-			 corr0 & 0xffff, corr0 >> 16,
-			 corr1 & 0xffff, corr1 >> 16,
-			 corr2 & 0xffff, corr2 >> 16,
-			 corr3 & 0xffff, corr3 >> 16);
+	/* Move back one space. */
+	n--;
+	n += snprintf(msg + n, len - n, "]");
 
-	/* Clear status bits */
-	if (retry_rd_err_log == 2) {
-		if (log0 & RETRY_RD_ERR_LOG_OVER_UC_V) {
-			log0 &= ~RETRY_RD_ERR_LOG_OVER_UC_V;
-			I10NM_SET_REG32(imc, res->channel, offsets[0], log0);
-		}
+	if (len - n > 0) {
+		n += snprintf(msg + n, len - n, " correrrcnt[");
+		for (i = 0; i < rrl->cecnt_num && len - n > 0; i++) {
+			offset = rrl->cecnt_offsets[i];
+			width = rrl->cecnt_widths[i];
+			corr = read_imc_reg(imc, ch, offset, width);
 
-		if (xffsets && (lxg0 & RETRY_RD_ERR_LOG_OVER_UC_V)) {
-			lxg0 &= ~RETRY_RD_ERR_LOG_OVER_UC_V;
-			I10NM_SET_REG32(imc, res->channel, xffsets[0], lxg0);
+			n += snprintf(msg + n, len - n, "%.4llx %.4llx ",
+				      corr & 0xffff, corr >> 16);
 		}
+
+		/* Move back one space. */
+		n--;
+		n += snprintf(msg + n, len - n, "]");
 	}
 }
 
diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index cf3d0aac035a..8f0f4af2cb27 100644
--- a/drivers/edac/skx_common.h
+++ b/drivers/edac/skx_common.h
@@ -83,6 +83,8 @@
 #define NUM_RRL_SET		3
 /* Max RRL registers per set. */
 #define NUM_RRL_REG		6
+/* Max correctable error count registers. */
+#define NUM_CECNT_REG		4
 
 /* Modes of RRL register set. */
 enum rrl_mode {
@@ -99,16 +101,23 @@ enum rrl_mode {
 /* RRL registers per {,sub-,pseudo-}channel. */
 struct reg_rrl {
 	/* RRL register parts. */
-	int set_num;
+	int set_num, reg_num;
 	enum rrl_mode modes[NUM_RRL_SET];
 	u32 offsets[NUM_RRL_SET][NUM_RRL_REG];
 	/* RRL register widths in byte per set. */
 	u8 widths[NUM_RRL_REG];
 	/* RRL control bits of the first register per set. */
+	u32 v_mask;
 	u32 uc_mask;
+	u32 over_mask;
 	u32 en_patspr_mask;
 	u32 noover_mask;
 	u32 en_mask;
+
+	/* CORRERRCNT register parts. */
+	int cecnt_num;
+	u32 cecnt_offsets[NUM_CECNT_REG];
+	u8 cecnt_widths[NUM_CECNT_REG];
 };
 
 /*
-- 
2.43.0


