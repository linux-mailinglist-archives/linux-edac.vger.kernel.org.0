Return-Path: <linux-edac+bounces-3578-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AD0A920E7
	for <lists+linux-edac@lfdr.de>; Thu, 17 Apr 2025 17:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AD587B1CC3
	for <lists+linux-edac@lfdr.de>; Thu, 17 Apr 2025 15:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A64253B51;
	Thu, 17 Apr 2025 15:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IcNZstgU"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBCD253955;
	Thu, 17 Apr 2025 15:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744902560; cv=none; b=trKQJrxoy9FsJbg9Fktj7nvcyWYiC+Z714bWkUVYTPQqkN0iGQ3WQl2yu40SXwWJrgAWftB6IT5E4lUq58zLoGkyLF0lY6wpnBaKHYiFSPuAdyrK+dgybb9uxx7iwvzHypLsZJZJzmUza2GxYGn7XXzEHAQ3t2zlRHaKC12xtns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744902560; c=relaxed/simple;
	bh=HskvPqh0fp+Xs08GCGluLWoFMFTiGIhDxXetKAaR2zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sro1Ijqcj/cmIoEQTluajz07y6hhbHBtVPOpN3uWph8psmY5D9ol/ad5IgzD8QpkSsBcU8/t3SSkTMzHl3MjebXdqZ1GmLUtazPyPOHXyQhdRfb4eK1K2T817kg3gxL48jhNWzSOsWxSCHVA4S5iBzGaCmb4D8tEMGIyRnIFtlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IcNZstgU; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744902557; x=1776438557;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HskvPqh0fp+Xs08GCGluLWoFMFTiGIhDxXetKAaR2zo=;
  b=IcNZstgUZQi1JiTeElGnVrIsE2dYt6rblFejKJwK2Awsb4Im3dPHQItd
   BkBzTh99PKlGrdPwDZIGa8zwoUW8toWWYbf7GmZEeAMNQV/SqmRm8Ux76
   JoElhbNQAj+dDzg5pxMRFjIAPn+OirENHknHFbwnIiXbc5hyndtKP9LSB
   p3ghz+tQZy6RrfE1yhxtavK4SGlPaz9vE7HtNvpD+p7V5b1QsxdNl8IQh
   asQD1PaoCRFnCxo65H4+7tlvP7W9PfSiwYvrRO+JtVZ6cqMKHsNsyj0+i
   oj66/oGBld/vuunSR5lxOQClzM73GFwewL13vXqg+yCs4Jp2H/YYMW6s5
   A==;
X-CSE-ConnectionGUID: atgH34e5TZG8cdm20ASeQw==
X-CSE-MsgGUID: 3/5DysP8TdawPpnKNVjOyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="57488732"
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="57488732"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 08:09:17 -0700
X-CSE-ConnectionGUID: z9KLyd6+SsyicaVLGaPR1Q==
X-CSE-MsgGUID: NYORa+7LQcipEQVt690L0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="161876913"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 08:09:14 -0700
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
Subject: [PATCH 5/7] EDAC/{skx_common,i10nm}: Refactor enable_retry_rd_err_log()
Date: Thu, 17 Apr 2025 23:07:22 +0800
Message-ID: <20250417150724.1170168-6-qiuxu.zhuo@intel.com>
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

Refactor enable_retry_rd_err_log() using helper functions for both
DDR and HBM, making the RRL control bits configurable instead of
hard-coded. Additionally, explicitly define the four RRL modes for
better readability.

No functional changes intended.

Tested-by: Feng Xu <feng.f.xu@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/i10nm_base.c | 233 ++++++++++++++++++++++----------------
 drivers/edac/skx_common.h |  20 ++++
 2 files changed, 154 insertions(+), 99 deletions(-)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index b47da970510c..2a03db86883c 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -72,11 +72,6 @@
 #define I10NM_SAD_ENABLE(reg)		GET_BITFIELD(reg, 0, 0)
 #define I10NM_SAD_NM_CACHEABLE(reg)	GET_BITFIELD(reg, 5, 5)
 
-#define RETRY_RD_ERR_LOG_UC		BIT(1)
-#define RETRY_RD_ERR_LOG_EN_PATSPR	BIT(13)
-#define RETRY_RD_ERR_LOG_NOOVER		BIT(14)
-#define RETRY_RD_ERR_LOG_EN		BIT(15)
-#define RETRY_RD_ERR_LOG_NOOVER_UC	(BIT(14) | BIT(1))
 #define RETRY_RD_ERR_LOG_OVER_UC_V	(BIT(2) | BIT(1) | BIT(0))
 
 static struct list_head *i10nm_edac_list;
@@ -88,153 +83,193 @@ static bool mem_cfg_2lm;
 
 static struct reg_rrl icx_reg_rrl_ddr = {
 	.set_num = 2,
+	.modes = {LRE_SCRUB, LRE_DEMAND},
 	.offsets = {
 		{0x22c60, 0x22c54, 0x22c5c, 0x22c58, 0x22c28, 0x20ed8},
 		{0x22e54, 0x22e60, 0x22e64, 0x22e58, 0x22e5c, 0x20ee0},
 	},
+	.widths		= {4, 4, 4, 4, 4, 8},
+	.uc_mask	= BIT(1),
+	.en_patspr_mask	= BIT(13),
+	.noover_mask	= BIT(14),
+	.en_mask	= BIT(15),
 };
 
 static struct reg_rrl spr_reg_rrl_ddr = {
 	.set_num = 3,
+	.modes = {LRE_SCRUB, LRE_DEMAND, FRE_DEMAND},
 	.offsets = {
 		{0x22c60, 0x22c54, 0x22f08, 0x22c58, 0x22c28, 0x20ed8},
 		{0x22e54, 0x22e60, 0x22f10, 0x22e58, 0x22e5c, 0x20ee0},
 		{0x22c70, 0x22d80, 0x22f18, 0x22d58, 0x22c64, 0x20f10},
 	},
+	.widths		= {4, 4, 8, 4, 4, 8},
+	.uc_mask	= BIT(1),
+	.en_patspr_mask	= BIT(13),
+	.noover_mask	= BIT(14),
+	.en_mask	= BIT(15),
 };
 
 static struct reg_rrl spr_reg_rrl_hbm_pch0 = {
 	.set_num = 2,
+	.modes = {LRE_SCRUB, LRE_DEMAND},
 	.offsets = {
 		{0x2860, 0x2854, 0x2b08, 0x2858, 0x2828, 0x0ed8},
 		{0x2a54, 0x2a60, 0x2b10, 0x2a58, 0x2a5c, 0x0ee0},
 	},
+	.widths		= {4, 4, 8, 4, 4, 8},
+	.uc_mask	= BIT(1),
+	.en_patspr_mask	= BIT(13),
+	.noover_mask	= BIT(14),
+	.en_mask	= BIT(15),
 };
 
 static struct reg_rrl spr_reg_rrl_hbm_pch1 = {
 	.set_num = 2,
+	.modes = {LRE_SCRUB, LRE_DEMAND},
 	.offsets = {
 		{0x2c60, 0x2c54, 0x2f08, 0x2c58, 0x2c28, 0x0fa8},
 		{0x2e54, 0x2e60, 0x2f10, 0x2e58, 0x2e5c, 0x0fb0},
 	},
+	.widths		= {4, 4, 8, 4, 4, 8},
+	.uc_mask	= BIT(1),
+	.en_patspr_mask	= BIT(13),
+	.noover_mask	= BIT(14),
+	.en_mask	= BIT(15),
 };
 
-static void __enable_retry_rd_err_log(struct skx_imc *imc, int chan, bool enable, u32 *rrl_ctl,
-				      u32 *offsets_scrub, u32 *offsets_demand,
-				      u32 *offsets_demand2)
+static u64 read_imc_reg(struct skx_imc *imc, int chan, u32 offset, u8 width)
 {
-	u32 s, d, d2;
+	switch (width) {
+	case 4:
+		return I10NM_GET_REG32(imc, chan, offset);
+	case 8:
+		return I10NM_GET_REG64(imc, chan, offset);
+	default:
+		i10nm_printk(KERN_ERR, "Invalid readd RRL 0x%x width %d\n", offset, width);
+		return 0;
+	}
+}
 
-	s = I10NM_GET_REG32(imc, chan, offsets_scrub[0]);
-	d = I10NM_GET_REG32(imc, chan, offsets_demand[0]);
-	if (offsets_demand2)
-		d2 = I10NM_GET_REG32(imc, chan, offsets_demand2[0]);
+static void write_imc_reg(struct skx_imc *imc, int chan, u32 offset, u8 width, u64 val)
+{
+	switch (width) {
+	case 4:
+		return I10NM_SET_REG32(imc, chan, offset, (u32)val);
+	default:
+		i10nm_printk(KERN_ERR, "Invalid write RRL 0x%x width %d\n", offset, width);
+	}
+}
+
+static void enable_rrl(struct skx_imc *imc, int chan, struct reg_rrl *rrl,
+		       int rrl_set, bool enable, u32 *rrl_ctl)
+{
+	enum rrl_mode mode = rrl->modes[rrl_set];
+	u32 offset = rrl->offsets[rrl_set][0], v;
+	u8 width = rrl->widths[0];
+	bool first, scrub;
+
+	/* First or last read error. */
+	first = (mode == FRE_SCRUB || mode == FRE_DEMAND);
+	/* Patrol scrub or on-demand read error. */
+	scrub = (mode == FRE_SCRUB || mode == LRE_SCRUB);
+
+	v = read_imc_reg(imc, chan, offset, width);
 
 	if (enable) {
-		/* Save default configurations */
-		rrl_ctl[0] = s;
-		rrl_ctl[1] = d;
-		if (offsets_demand2)
-			rrl_ctl[2] = d2;
+		/* Save default configurations. */
+		*rrl_ctl = v;
+		v &= ~rrl->uc_mask;
 
-		s &= ~RETRY_RD_ERR_LOG_NOOVER_UC;
-		s |=  RETRY_RD_ERR_LOG_EN_PATSPR;
-		s |=  RETRY_RD_ERR_LOG_EN;
-		d &= ~RETRY_RD_ERR_LOG_NOOVER_UC;
-		d &= ~RETRY_RD_ERR_LOG_EN_PATSPR;
-		d |=  RETRY_RD_ERR_LOG_EN;
+		if (first)
+			v |= rrl->noover_mask;
+		else
+			v &= ~rrl->noover_mask;
 
-		if (offsets_demand2) {
-			d2 &= ~RETRY_RD_ERR_LOG_UC;
-			d2 &= ~RETRY_RD_ERR_LOG_EN_PATSPR;
-			d2 |=  RETRY_RD_ERR_LOG_NOOVER;
-			d2 |=  RETRY_RD_ERR_LOG_EN;
-		}
+		if (scrub)
+			v |= rrl->en_patspr_mask;
+		else
+			v &= ~rrl->en_patspr_mask;
+
+		v |= rrl->en_mask;
 	} else {
-		/* Restore default configurations */
-		if (rrl_ctl[0] & RETRY_RD_ERR_LOG_UC)
-			s |=  RETRY_RD_ERR_LOG_UC;
-		if (rrl_ctl[0] & RETRY_RD_ERR_LOG_NOOVER)
-			s |=  RETRY_RD_ERR_LOG_NOOVER;
-		if (!(rrl_ctl[0] & RETRY_RD_ERR_LOG_EN_PATSPR))
-			s &=  ~RETRY_RD_ERR_LOG_EN_PATSPR;
-		if (!(rrl_ctl[0] & RETRY_RD_ERR_LOG_EN))
-			s &= ~RETRY_RD_ERR_LOG_EN;
-		if (rrl_ctl[1] & RETRY_RD_ERR_LOG_UC)
-			d |=  RETRY_RD_ERR_LOG_UC;
-		if (rrl_ctl[1] & RETRY_RD_ERR_LOG_NOOVER)
-			d |=  RETRY_RD_ERR_LOG_NOOVER;
-		if (rrl_ctl[1] & RETRY_RD_ERR_LOG_EN_PATSPR)
-			d |=  RETRY_RD_ERR_LOG_EN_PATSPR;
-		if (!(rrl_ctl[1] & RETRY_RD_ERR_LOG_EN))
-			d &= ~RETRY_RD_ERR_LOG_EN;
-
-		if (offsets_demand2) {
-			if (rrl_ctl[2] & RETRY_RD_ERR_LOG_UC)
-				d2 |=  RETRY_RD_ERR_LOG_UC;
-			if (rrl_ctl[2] & RETRY_RD_ERR_LOG_EN_PATSPR)
-				d2 |=  RETRY_RD_ERR_LOG_EN_PATSPR;
-			if (!(rrl_ctl[2] & RETRY_RD_ERR_LOG_NOOVER))
-				d2 &=  ~RETRY_RD_ERR_LOG_NOOVER;
-			if (!(rrl_ctl[2] & RETRY_RD_ERR_LOG_EN))
-				d2 &= ~RETRY_RD_ERR_LOG_EN;
+		/* Restore default configurations. */
+		if (*rrl_ctl & rrl->uc_mask)
+			v |= rrl->uc_mask;
+
+		if (first) {
+			if (!(*rrl_ctl & rrl->noover_mask))
+				v &= ~rrl->noover_mask;
+		} else {
+			if (*rrl_ctl & rrl->noover_mask)
+				v |= rrl->noover_mask;
+		}
+
+		if (scrub) {
+			if (!(*rrl_ctl & rrl->en_patspr_mask))
+				v &= ~rrl->en_patspr_mask;
+		} else {
+			if (*rrl_ctl & rrl->en_patspr_mask)
+				v |= rrl->en_patspr_mask;
 		}
+
+		if (!(*rrl_ctl & rrl->en_mask))
+			v &= ~rrl->en_mask;
 	}
 
-	I10NM_SET_REG32(imc, chan, offsets_scrub[0], s);
-	I10NM_SET_REG32(imc, chan, offsets_demand[0], d);
-	if (offsets_demand2)
-		I10NM_SET_REG32(imc, chan, offsets_demand2[0], d2);
+	write_imc_reg(imc, chan, offset, width, v);
+}
+
+static void enable_rrls(struct skx_imc *imc, int chan, struct reg_rrl *rrl,
+			bool enable, u32 *rrl_ctl)
+{
+	for (int i = 0; i < rrl->set_num; i++)
+		enable_rrl(imc, chan, rrl, i, enable, rrl_ctl + i);
+}
+
+static void enable_rrls_ddr(struct skx_imc *imc, bool enable)
+{
+	struct reg_rrl *rrl_ddr = res_cfg->reg_rrl_ddr;
+	int i, chan_num = res_cfg->ddr_chan_num;
+	struct skx_channel *chan = imc->chan;
+
+	if (!imc->mbase)
+		return;
+
+	for (i = 0; i < chan_num; i++)
+		enable_rrls(imc, i, rrl_ddr, enable, chan[i].rrl_ctl[0]);
+}
+
+static void enable_rrls_hbm(struct skx_imc *imc, bool enable)
+{
+	struct reg_rrl **rrl_hbm = res_cfg->reg_rrl_hbm;
+	int i, chan_num = res_cfg->hbm_chan_num;
+	struct skx_channel *chan = imc->chan;
+
+	if (!imc->mbase || !imc->hbm_mc || !rrl_hbm[0] || !rrl_hbm[1])
+		return;
+
+	for (i = 0; i < chan_num; i++) {
+		enable_rrls(imc, i, rrl_hbm[0], enable, chan[i].rrl_ctl[0]);
+		enable_rrls(imc, i, rrl_hbm[1], enable, chan[i].rrl_ctl[1]);
+	}
 }
 
 static void enable_retry_rd_err_log(bool enable)
 {
-	int i, j, imc_num, chan_num;
-	struct skx_channel *chan;
-	struct skx_imc *imc;
 	struct skx_dev *d;
+	int i, imc_num;
 
 	edac_dbg(2, "\n");
 
 	list_for_each_entry(d, i10nm_edac_list, list) {
 		imc_num  = res_cfg->ddr_imc_num;
-		chan_num = res_cfg->ddr_chan_num;
-
-		for (i = 0; i < imc_num; i++) {
-			imc = &d->imc[i];
-			if (!imc->mbase)
-				continue;
-
-			chan = d->imc[i].chan;
-			for (j = 0; j < chan_num; j++)
-				__enable_retry_rd_err_log(imc, j, enable, chan[j].rrl_ctl[0],
-							  res_cfg->reg_rrl_ddr->offsets[0],
-							  res_cfg->reg_rrl_ddr->offsets[1],
-							  res_cfg->reg_rrl_ddr->set_num > 2 ?
-							  res_cfg->reg_rrl_ddr->offsets[2] : NULL);
-
-		}
+		for (i = 0; i < imc_num; i++)
+			enable_rrls_ddr(&d->imc[i], enable);
 
 		imc_num += res_cfg->hbm_imc_num;
-		chan_num = res_cfg->hbm_chan_num;
-
-		for (; i < imc_num; i++) {
-			imc = &d->imc[i];
-			if (!imc->mbase || !imc->hbm_mc)
-				continue;
-
-			chan = d->imc[i].chan;
-			for (j = 0; j < chan_num; j++) {
-				__enable_retry_rd_err_log(imc, j, enable, chan[j].rrl_ctl[0],
-							  res_cfg->reg_rrl_hbm[0]->offsets[0],
-							  res_cfg->reg_rrl_hbm[0]->offsets[1],
-							  NULL);
-				__enable_retry_rd_err_log(imc, j, enable, chan[j].rrl_ctl[1],
-							  res_cfg->reg_rrl_hbm[1]->offsets[0],
-							  res_cfg->reg_rrl_hbm[1]->offsets[1],
-							  NULL);
-			}
-		}
+		for (; i < imc_num; i++)
+			enable_rrls_hbm(&d->imc[i], enable);
 	}
 }
 
diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index 5833fbe7c0fb..cf3d0aac035a 100644
--- a/drivers/edac/skx_common.h
+++ b/drivers/edac/skx_common.h
@@ -84,11 +84,31 @@
 /* Max RRL registers per set. */
 #define NUM_RRL_REG		6
 
+/* Modes of RRL register set. */
+enum rrl_mode {
+	/* Last read error from patrol scrub. */
+	LRE_SCRUB,
+	/* Last read error from demand. */
+	LRE_DEMAND,
+	/* First read error from patrol scrub. */
+	FRE_SCRUB,
+	/* First read error from demand. */
+	FRE_DEMAND,
+};
+
 /* RRL registers per {,sub-,pseudo-}channel. */
 struct reg_rrl {
 	/* RRL register parts. */
 	int set_num;
+	enum rrl_mode modes[NUM_RRL_SET];
 	u32 offsets[NUM_RRL_SET][NUM_RRL_REG];
+	/* RRL register widths in byte per set. */
+	u8 widths[NUM_RRL_REG];
+	/* RRL control bits of the first register per set. */
+	u32 uc_mask;
+	u32 en_patspr_mask;
+	u32 noover_mask;
+	u32 en_mask;
 };
 
 /*
-- 
2.43.0


