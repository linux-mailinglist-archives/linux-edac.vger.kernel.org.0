Return-Path: <linux-edac+bounces-3577-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FCFA920E5
	for <lists+linux-edac@lfdr.de>; Thu, 17 Apr 2025 17:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2E748A1A9C
	for <lists+linux-edac@lfdr.de>; Thu, 17 Apr 2025 15:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B13252905;
	Thu, 17 Apr 2025 15:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TJj2EEbx"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4349D23E330;
	Thu, 17 Apr 2025 15:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744902555; cv=none; b=leUJLtud7PlQ4CvjvOMt2tECJhWaj6FTnrc/XQmMtgPGb8+24IR2LRzWwy22pyh3YRsw1JflXvIGvVWhsYO3pgiXb6iNQvqVXLR23gPc+q7NZNbvkZt6oL2raUVRODqAi/Co1lFbVwntrfl3E8NkNYG1E4JDyRgJMt4Bkz+9IS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744902555; c=relaxed/simple;
	bh=81mjvg8U/osmb1FQogQ+eTd2UD/5Qvf+iQjQ+5a9Hn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ftk2R5QXsuoDKGpH6785fjNRWcsh7AcMZXgnw8SybmKFsPRhTi14a5Fow/wGB+ynGwvV9jRioimeW4Em5YQnY62F47dMgkCUzbGTzAl5rUMOqDs+Mepm7K87ZT3VhA8wJFzPBGkan1ot2VUxwQAN8I+p7Kgu+uFf0NwPqzfZGcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TJj2EEbx; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744902550; x=1776438550;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=81mjvg8U/osmb1FQogQ+eTd2UD/5Qvf+iQjQ+5a9Hn0=;
  b=TJj2EEbx6yiF/ddTL58msEUhNRvInZf4C3P3T+YFJPcdA9KeT6nexTs/
   qiZdgF2ZNhQ4uX8DHcsOPTlYOZc6ToVBYIyUUTfvcEudLkCv15JMhBf5z
   mQpzkf64CP8VbouryLCIRfYCpN4/S+GrQO8pWzgT0fRJ8jEHfRZ0//zAT
   uLCFsCHP0nEtXWzZyMyHnXNA1b0GHPXZLbvr2rgsKufRp8nPwvvExBUak
   /NAewVuzoPF6+d33G/68AVmID+me80gT3bxVwLxPyN7FxVqtrmbdgikHF
   n76MkZ7/oGY2oaWezgrk5NZLWmgIrs6rMnYBrSBr4jzpTy/HhV7iMkCMP
   Q==;
X-CSE-ConnectionGUID: cWf3dyQOS6ea+QSt1EAwKg==
X-CSE-MsgGUID: TqnU90usRo6Zk+Kopq9PrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="57488709"
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="57488709"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 08:09:10 -0700
X-CSE-ConnectionGUID: utWSB8YdS/axiXF26v3Qvg==
X-CSE-MsgGUID: j6mBMZ3/T9iJzUKyXNlEIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="161876876"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 08:09:07 -0700
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
Subject: [PATCH 4/7] EDAC/{skx_common,i10nm}: Structure the per-channel RRL registers
Date: Thu, 17 Apr 2025 23:07:21 +0800
Message-ID: <20250417150724.1170168-5-qiuxu.zhuo@intel.com>
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

As the number of RRL (retry_rd_err_log) registers per memory channel
increases, the positions of the RRL control bits and the widths of the
RRL registers vary across different CPU generations. Adding RRL support
for a new CPU requires handling these differences throughout the
RRL-related code.

Structure the offsets, widths, control bit positions, set numbers, modes,
etc., of the per-channel RRL registers and make them configurable to
facilitate easier RRL support for new CPUs.

No functional changes are intended.

Tested-by: Feng Xu <feng.f.xu@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/i10nm_base.c | 92 ++++++++++++++++++++++++---------------
 drivers/edac/skx_common.h | 21 +++++----
 2 files changed, 69 insertions(+), 44 deletions(-)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index 50a16ce0aa22..b47da970510c 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -86,15 +86,38 @@ static int retry_rd_err_log;
 static int decoding_via_mca;
 static bool mem_cfg_2lm;
 
-static u32 offsets_scrub_icx[]  = {0x22c60, 0x22c54, 0x22c5c, 0x22c58, 0x22c28, 0x20ed8};
-static u32 offsets_scrub_spr[]  = {0x22c60, 0x22c54, 0x22f08, 0x22c58, 0x22c28, 0x20ed8};
-static u32 offsets_scrub_spr_hbm0[]  = {0x2860, 0x2854, 0x2b08, 0x2858, 0x2828, 0x0ed8};
-static u32 offsets_scrub_spr_hbm1[]  = {0x2c60, 0x2c54, 0x2f08, 0x2c58, 0x2c28, 0x0fa8};
-static u32 offsets_demand_icx[] = {0x22e54, 0x22e60, 0x22e64, 0x22e58, 0x22e5c, 0x20ee0};
-static u32 offsets_demand_spr[] = {0x22e54, 0x22e60, 0x22f10, 0x22e58, 0x22e5c, 0x20ee0};
-static u32 offsets_demand2_spr[] = {0x22c70, 0x22d80, 0x22f18, 0x22d58, 0x22c64, 0x20f10};
-static u32 offsets_demand_spr_hbm0[] = {0x2a54, 0x2a60, 0x2b10, 0x2a58, 0x2a5c, 0x0ee0};
-static u32 offsets_demand_spr_hbm1[] = {0x2e54, 0x2e60, 0x2f10, 0x2e58, 0x2e5c, 0x0fb0};
+static struct reg_rrl icx_reg_rrl_ddr = {
+	.set_num = 2,
+	.offsets = {
+		{0x22c60, 0x22c54, 0x22c5c, 0x22c58, 0x22c28, 0x20ed8},
+		{0x22e54, 0x22e60, 0x22e64, 0x22e58, 0x22e5c, 0x20ee0},
+	},
+};
+
+static struct reg_rrl spr_reg_rrl_ddr = {
+	.set_num = 3,
+	.offsets = {
+		{0x22c60, 0x22c54, 0x22f08, 0x22c58, 0x22c28, 0x20ed8},
+		{0x22e54, 0x22e60, 0x22f10, 0x22e58, 0x22e5c, 0x20ee0},
+		{0x22c70, 0x22d80, 0x22f18, 0x22d58, 0x22c64, 0x20f10},
+	},
+};
+
+static struct reg_rrl spr_reg_rrl_hbm_pch0 = {
+	.set_num = 2,
+	.offsets = {
+		{0x2860, 0x2854, 0x2b08, 0x2858, 0x2828, 0x0ed8},
+		{0x2a54, 0x2a60, 0x2b10, 0x2a58, 0x2a5c, 0x0ee0},
+	},
+};
+
+static struct reg_rrl spr_reg_rrl_hbm_pch1 = {
+	.set_num = 2,
+	.offsets = {
+		{0x2c60, 0x2c54, 0x2f08, 0x2c58, 0x2c28, 0x0fa8},
+		{0x2e54, 0x2e60, 0x2f10, 0x2e58, 0x2e5c, 0x0fb0},
+	},
+};
 
 static void __enable_retry_rd_err_log(struct skx_imc *imc, int chan, bool enable, u32 *rrl_ctl,
 				      u32 *offsets_scrub, u32 *offsets_demand,
@@ -185,9 +208,11 @@ static void enable_retry_rd_err_log(bool enable)
 			chan = d->imc[i].chan;
 			for (j = 0; j < chan_num; j++)
 				__enable_retry_rd_err_log(imc, j, enable, chan[j].rrl_ctl[0],
-							  res_cfg->offsets_scrub,
-							  res_cfg->offsets_demand,
-							  res_cfg->offsets_demand2);
+							  res_cfg->reg_rrl_ddr->offsets[0],
+							  res_cfg->reg_rrl_ddr->offsets[1],
+							  res_cfg->reg_rrl_ddr->set_num > 2 ?
+							  res_cfg->reg_rrl_ddr->offsets[2] : NULL);
+
 		}
 
 		imc_num += res_cfg->hbm_imc_num;
@@ -201,12 +226,12 @@ static void enable_retry_rd_err_log(bool enable)
 			chan = d->imc[i].chan;
 			for (j = 0; j < chan_num; j++) {
 				__enable_retry_rd_err_log(imc, j, enable, chan[j].rrl_ctl[0],
-							  res_cfg->offsets_scrub_hbm0,
-							  res_cfg->offsets_demand_hbm0,
+							  res_cfg->reg_rrl_hbm[0]->offsets[0],
+							  res_cfg->reg_rrl_hbm[0]->offsets[1],
 							  NULL);
 				__enable_retry_rd_err_log(imc, j, enable, chan[j].rrl_ctl[1],
-							  res_cfg->offsets_scrub_hbm1,
-							  res_cfg->offsets_demand_hbm1,
+							  res_cfg->reg_rrl_hbm[1]->offsets[0],
+							  res_cfg->reg_rrl_hbm[1]->offsets[1],
 							  NULL);
 			}
 		}
@@ -233,17 +258,18 @@ static void show_retry_rd_err_log(struct decoded_addr *res, char *msg,
 		pch = res->cs & 1;
 
 		if (pch)
-			offsets = scrub_err ? res_cfg->offsets_scrub_hbm1 :
-					      res_cfg->offsets_demand_hbm1;
+			offsets = scrub_err ? res_cfg->reg_rrl_hbm[1]->offsets[0] :
+					      res_cfg->reg_rrl_hbm[1]->offsets[1];
 		else
-			offsets = scrub_err ? res_cfg->offsets_scrub_hbm0 :
-					      res_cfg->offsets_demand_hbm0;
+			offsets = scrub_err ? res_cfg->reg_rrl_hbm[0]->offsets[0] :
+					      res_cfg->reg_rrl_hbm[0]->offsets[1];
 	} else {
 		if (scrub_err) {
-			offsets = res_cfg->offsets_scrub;
+			offsets = res_cfg->reg_rrl_ddr->offsets[0];
 		} else {
-			offsets = res_cfg->offsets_demand;
-			xffsets = res_cfg->offsets_demand2;
+			offsets = res_cfg->reg_rrl_ddr->offsets[1];
+			if (res_cfg->reg_rrl_ddr->set_num > 2)
+				xffsets = res_cfg->reg_rrl_ddr->offsets[2];
 		}
 	}
 
@@ -883,8 +909,7 @@ static struct res_config i10nm_cfg0 = {
 	.ddr_mdev_bdf		= {0, 12, 0},
 	.hbm_mdev_bdf		= {0, 12, 1},
 	.sad_all_offset		= 0x108,
-	.offsets_scrub		= offsets_scrub_icx,
-	.offsets_demand		= offsets_demand_icx,
+	.reg_rrl_ddr		= &icx_reg_rrl_ddr,
 };
 
 static struct res_config i10nm_cfg1 = {
@@ -902,8 +927,7 @@ static struct res_config i10nm_cfg1 = {
 	.ddr_mdev_bdf		= {0, 12, 0},
 	.hbm_mdev_bdf		= {0, 12, 1},
 	.sad_all_offset		= 0x108,
-	.offsets_scrub		= offsets_scrub_icx,
-	.offsets_demand		= offsets_demand_icx,
+	.reg_rrl_ddr		= &icx_reg_rrl_ddr,
 };
 
 static struct res_config spr_cfg = {
@@ -926,13 +950,9 @@ static struct res_config spr_cfg = {
 	.ddr_mdev_bdf		= {0, 12, 0},
 	.hbm_mdev_bdf		= {0, 12, 1},
 	.sad_all_offset		= 0x300,
-	.offsets_scrub		= offsets_scrub_spr,
-	.offsets_scrub_hbm0	= offsets_scrub_spr_hbm0,
-	.offsets_scrub_hbm1	= offsets_scrub_spr_hbm1,
-	.offsets_demand		= offsets_demand_spr,
-	.offsets_demand2	= offsets_demand2_spr,
-	.offsets_demand_hbm0	= offsets_demand_spr_hbm0,
-	.offsets_demand_hbm1	= offsets_demand_spr_hbm1,
+	.reg_rrl_ddr		= &spr_reg_rrl_ddr,
+	.reg_rrl_hbm[0]		= &spr_reg_rrl_hbm_pch0,
+	.reg_rrl_hbm[1]		= &spr_reg_rrl_hbm_pch1,
 };
 
 static struct res_config gnr_cfg = {
@@ -1121,7 +1141,7 @@ static int __init i10nm_init(void)
 	mce_register_decode_chain(&i10nm_mce_dec);
 	skx_setup_debug("i10nm_test");
 
-	if (retry_rd_err_log && res_cfg->offsets_scrub && res_cfg->offsets_demand) {
+	if (retry_rd_err_log && res_cfg->reg_rrl_ddr) {
 		skx_set_decode(i10nm_mc_decode, show_retry_rd_err_log);
 		if (retry_rd_err_log == 2)
 			enable_retry_rd_err_log(true);
@@ -1141,7 +1161,7 @@ static void __exit i10nm_exit(void)
 {
 	edac_dbg(2, "\n");
 
-	if (retry_rd_err_log && res_cfg->offsets_scrub && res_cfg->offsets_demand) {
+	if (retry_rd_err_log && res_cfg->reg_rrl_ddr) {
 		skx_set_decode(NULL, NULL);
 		if (retry_rd_err_log == 2)
 			enable_retry_rd_err_log(false);
diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index 5afd425f3b4f..5833fbe7c0fb 100644
--- a/drivers/edac/skx_common.h
+++ b/drivers/edac/skx_common.h
@@ -81,6 +81,15 @@
 
 /* Max RRL register sets per {,sub-,pseudo-}channel. */
 #define NUM_RRL_SET		3
+/* Max RRL registers per set. */
+#define NUM_RRL_REG		6
+
+/* RRL registers per {,sub-,pseudo-}channel. */
+struct reg_rrl {
+	/* RRL register parts. */
+	int set_num;
+	u32 offsets[NUM_RRL_SET][NUM_RRL_REG];
+};
 
 /*
  * Each cpu socket contains some pci devices that provide global
@@ -237,14 +246,10 @@ struct res_config {
 	/* HBM mdev device BDF */
 	struct pci_bdf hbm_mdev_bdf;
 	int sad_all_offset;
-	/* Offsets of retry_rd_err_log registers */
-	u32 *offsets_scrub;
-	u32 *offsets_scrub_hbm0;
-	u32 *offsets_scrub_hbm1;
-	u32 *offsets_demand;
-	u32 *offsets_demand2;
-	u32 *offsets_demand_hbm0;
-	u32 *offsets_demand_hbm1;
+	/* RRL register sets per DDR channel */
+	struct reg_rrl *reg_rrl_ddr;
+	/* RRL register sets per HBM channel */
+	struct reg_rrl *reg_rrl_hbm[2];
 };
 
 typedef int (*get_dimm_config_f)(struct mem_ctl_info *mci,
-- 
2.43.0


