Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C2357EA41
	for <lists+linux-edac@lfdr.de>; Sat, 23 Jul 2022 01:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbiGVXdv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 22 Jul 2022 19:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiGVXdu (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 22 Jul 2022 19:33:50 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707A888CC7;
        Fri, 22 Jul 2022 16:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658532829; x=1690068829;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YLLsmMKFc2+kDIXcFMf/ZTzeLOXAFZpqVHC2oaoMI2k=;
  b=DrMI2hOvEJLg5+fU5MRpeSAZBHE4vcL4/ddxKjZl12e2VBUGKHTtaZWn
   x4LWdFqTrm/f4qjb8GHHrqEuiWJlpkqrHSdVcX8+MANFNj45fZMBbJRle
   MhZEGSWIeJVCPBxl32SFZdHM5KNcNOmNOwTb86vAKsFTheKa+UFYQ7ZR0
   3Q3ITAaFTfOOrxqDl12a1a9aBqqdyQZcb07WzWRaRP/EIQMGAobl001Xh
   dvZKBmOVruQyJZ5wU5RFYPgikk8fhu+fHG8ZP+fcz/wivaIFkfFyAtm7q
   ItU63VQACRKVA4mU1GENXZMFJ+ccx/g83LKS6EnzJ71EsrWNPZfakeW9E
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10416"; a="373730364"
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="373730364"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 16:33:48 -0700
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="574346067"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 16:33:48 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     linux-edac@vger.kernel.org
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Tony Luck <tony.luck@intel.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: [PATCH 3/4] EDAC/i10nm: Print an extra register set of retry_rd_err_log
Date:   Fri, 22 Jul 2022 16:33:37 -0700
Message-Id: <20220722233338.341567-4-tony.luck@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220722233338.341567-1-tony.luck@intel.com>
References: <20220722233338.341567-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Sapphire Rapids server adds an extra register set for logging more
retry_rd_err_log data. So add code to print the extra register set.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/edac/skx_common.h |  2 +
 drivers/edac/i10nm_base.c | 81 +++++++++++++++++++++++++++++++++------
 2 files changed, 72 insertions(+), 11 deletions(-)

diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index dbf8e458ad2b..e7226e935718 100644
--- a/drivers/edac/skx_common.h
+++ b/drivers/edac/skx_common.h
@@ -82,6 +82,7 @@ struct skx_dev {
 			struct pci_dev	*edev;
 			u32 retry_rd_err_log_s;
 			u32 retry_rd_err_log_d;
+			u32 retry_rd_err_log_d2;
 			struct skx_dimm {
 				u8 close_pg;
 				u8 bank_xor_enable;
@@ -161,6 +162,7 @@ struct res_config {
 	u32 *offsets_scrub_hbm0;
 	u32 *offsets_scrub_hbm1;
 	u32 *offsets_demand;
+	u32 *offsets_demand2;
 	u32 *offsets_demand_hbm0;
 	u32 *offsets_demand_hbm1;
 };
diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index 976d8e8a4d1b..610ab8cce873 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -81,26 +81,38 @@ static u32 offsets_scrub_spr_hbm0[]  = {0x2860, 0x2854, 0x2b08, 0x2858, 0x2828,
 static u32 offsets_scrub_spr_hbm1[]  = {0x2c60, 0x2c54, 0x2f08, 0x2c58, 0x2c28, 0x0fa8};
 static u32 offsets_demand_icx[] = {0x22e54, 0x22e60, 0x22e64, 0x22e58, 0x22e5c, 0x20ee0};
 static u32 offsets_demand_spr[] = {0x22e54, 0x22e60, 0x22f10, 0x22e58, 0x22e5c, 0x20ee0};
+static u32 offsets_demand2_spr[] = {0x22c70, 0x22d80, 0x22f18, 0x22d58, 0x22c64, 0x20f10};
 static u32 offsets_demand_spr_hbm0[] = {0x2a54, 0x2a60, 0x2b10, 0x2a58, 0x2a5c, 0x0ee0};
 static u32 offsets_demand_spr_hbm1[] = {0x2e54, 0x2e60, 0x2f10, 0x2e58, 0x2e5c, 0x0fb0};
 
 static void __enable_retry_rd_err_log(struct skx_imc *imc, int chan, bool enable,
-				      u32 *offsets_scrub, u32 *offsets_demand)
+				      u32 *offsets_scrub, u32 *offsets_demand,
+				      u32 *offsets_demand2)
 {
-	u32 s, d;
+	u32 s, d, d2;
 
 	s = I10NM_GET_REG32(imc, chan, offsets_scrub[0]);
 	d = I10NM_GET_REG32(imc, chan, offsets_demand[0]);
+	if (offsets_demand2)
+		d2 = I10NM_GET_REG32(imc, chan, offsets_demand2[0]);
 
 	if (enable) {
 		/* Save default configurations */
 		imc->chan[chan].retry_rd_err_log_s = s;
 		imc->chan[chan].retry_rd_err_log_d = d;
+		if (offsets_demand2)
+			imc->chan[chan].retry_rd_err_log_d2 = d2;
 
 		s &= ~RETRY_RD_ERR_LOG_NOOVER_UC;
 		s |=  RETRY_RD_ERR_LOG_EN;
 		d &= ~RETRY_RD_ERR_LOG_NOOVER_UC;
 		d |=  RETRY_RD_ERR_LOG_EN;
+
+		if (offsets_demand2) {
+			d2 &= ~RETRY_RD_ERR_LOG_UC;
+			d2 |=  RETRY_RD_ERR_LOG_NOOVER;
+			d2 |=  RETRY_RD_ERR_LOG_EN;
+		}
 	} else {
 		/* Restore default configurations */
 		if (imc->chan[chan].retry_rd_err_log_s & RETRY_RD_ERR_LOG_UC)
@@ -115,10 +127,21 @@ static void __enable_retry_rd_err_log(struct skx_imc *imc, int chan, bool enable
 			d |=  RETRY_RD_ERR_LOG_NOOVER;
 		if (!(imc->chan[chan].retry_rd_err_log_d & RETRY_RD_ERR_LOG_EN))
 			d &= ~RETRY_RD_ERR_LOG_EN;
+
+		if (offsets_demand2) {
+			if (imc->chan[chan].retry_rd_err_log_d2 & RETRY_RD_ERR_LOG_UC)
+				d2 |=  RETRY_RD_ERR_LOG_UC;
+			if (!(imc->chan[chan].retry_rd_err_log_d2 & RETRY_RD_ERR_LOG_NOOVER))
+				d2 &=  ~RETRY_RD_ERR_LOG_NOOVER;
+			if (!(imc->chan[chan].retry_rd_err_log_d2 & RETRY_RD_ERR_LOG_EN))
+				d2 &= ~RETRY_RD_ERR_LOG_EN;
+		}
 	}
 
 	I10NM_SET_REG32(imc, chan, offsets_scrub[0], s);
 	I10NM_SET_REG32(imc, chan, offsets_demand[0], d);
+	if (offsets_demand2)
+		I10NM_SET_REG32(imc, chan, offsets_demand2[0], d2);
 }
 
 static void enable_retry_rd_err_log(bool enable)
@@ -139,14 +162,17 @@ static void enable_retry_rd_err_log(bool enable)
 				if (imc->hbm_mc) {
 					__enable_retry_rd_err_log(imc, j, enable,
 								  res_cfg->offsets_scrub_hbm0,
-								  res_cfg->offsets_demand_hbm0);
+								  res_cfg->offsets_demand_hbm0,
+								  NULL);
 					__enable_retry_rd_err_log(imc, j, enable,
 								  res_cfg->offsets_scrub_hbm1,
-								  res_cfg->offsets_demand_hbm1);
+								  res_cfg->offsets_demand_hbm1,
+								  NULL);
 				} else {
 					__enable_retry_rd_err_log(imc, j, enable,
 								  res_cfg->offsets_scrub,
-								  res_cfg->offsets_demand);
+								  res_cfg->offsets_demand,
+								  res_cfg->offsets_demand2);
 				}
 			}
 	}
@@ -158,7 +184,10 @@ static void show_retry_rd_err_log(struct decoded_addr *res, char *msg,
 	struct skx_imc *imc = &res->dev->imc[res->imc];
 	u32 log0, log1, log2, log3, log4;
 	u32 corr0, corr1, corr2, corr3;
+	u32 lxg0, lxg1, lxg3, lxg4;
+	u32 *xffsets = NULL;
 	u64 log2a, log5;
+	u64 lxg2a, lxg5;
 	u32 *offsets;
 	int n, pch;
 
@@ -175,8 +204,12 @@ static void show_retry_rd_err_log(struct decoded_addr *res, char *msg,
 			offsets = scrub_err ? res_cfg->offsets_scrub_hbm0 :
 					      res_cfg->offsets_demand_hbm0;
 	} else {
-		offsets = scrub_err ? res_cfg->offsets_scrub :
-				      res_cfg->offsets_demand;
+		if (scrub_err) {
+			offsets = res_cfg->offsets_scrub;
+		} else {
+			offsets = res_cfg->offsets_demand;
+			xffsets = res_cfg->offsets_demand2;
+		}
 	}
 
 	log0 = I10NM_GET_REG32(imc, res->channel, offsets[0]);
@@ -185,10 +218,28 @@ static void show_retry_rd_err_log(struct decoded_addr *res, char *msg,
 	log4 = I10NM_GET_REG32(imc, res->channel, offsets[4]);
 	log5 = I10NM_GET_REG64(imc, res->channel, offsets[5]);
 
+	if (xffsets) {
+		lxg0 = I10NM_GET_REG32(imc, res->channel, xffsets[0]);
+		lxg1 = I10NM_GET_REG32(imc, res->channel, xffsets[1]);
+		lxg3 = I10NM_GET_REG32(imc, res->channel, xffsets[3]);
+		lxg4 = I10NM_GET_REG32(imc, res->channel, xffsets[4]);
+		lxg5 = I10NM_GET_REG64(imc, res->channel, xffsets[5]);
+	}
+
 	if (res_cfg->type == SPR) {
 		log2a = I10NM_GET_REG64(imc, res->channel, offsets[2]);
-		n = snprintf(msg, len, " retry_rd_err_log[%.8x %.8x %.16llx %.8x %.8x %.16llx]",
+		n = snprintf(msg, len, " retry_rd_err_log[%.8x %.8x %.16llx %.8x %.8x %.16llx",
 			     log0, log1, log2a, log3, log4, log5);
+
+		if (len - n > 0) {
+			if (xffsets) {
+				lxg2a = I10NM_GET_REG64(imc, res->channel, xffsets[2]);
+				n += snprintf(msg + n, len - n, " %.8x %.8x %.16llx %.8x %.8x %.16llx]",
+					     lxg0, lxg1, lxg2a, lxg3, lxg4, lxg5);
+			} else {
+				n += snprintf(msg + n, len - n, "]");
+			}
+		}
 	} else {
 		log2 = I10NM_GET_REG32(imc, res->channel, offsets[2]);
 		n = snprintf(msg, len, " retry_rd_err_log[%.8x %.8x %.8x %.8x %.8x %.16llx]",
@@ -223,9 +274,16 @@ static void show_retry_rd_err_log(struct decoded_addr *res, char *msg,
 			 corr3 & 0xffff, corr3 >> 16);
 
 	/* Clear status bits */
-	if (retry_rd_err_log == 2 && (log0 & RETRY_RD_ERR_LOG_OVER_UC_V)) {
-		log0 &= ~RETRY_RD_ERR_LOG_OVER_UC_V;
-		I10NM_SET_REG32(imc, res->channel, offsets[0], log0);
+	if (retry_rd_err_log == 2) {
+		if (log0 & RETRY_RD_ERR_LOG_OVER_UC_V) {
+			log0 &= ~RETRY_RD_ERR_LOG_OVER_UC_V;
+			I10NM_SET_REG32(imc, res->channel, offsets[0], log0);
+		}
+
+		if (xffsets && (lxg0 & RETRY_RD_ERR_LOG_OVER_UC_V)) {
+			lxg0 &= ~RETRY_RD_ERR_LOG_OVER_UC_V;
+			I10NM_SET_REG32(imc, res->channel, xffsets[0], lxg0);
+		}
 	}
 }
 
@@ -469,6 +527,7 @@ static struct res_config spr_cfg = {
 	.offsets_scrub_hbm0	= offsets_scrub_spr_hbm0,
 	.offsets_scrub_hbm1	= offsets_scrub_spr_hbm1,
 	.offsets_demand		= offsets_demand_spr,
+	.offsets_demand2	= offsets_demand2_spr,
 	.offsets_demand_hbm0	= offsets_demand_spr_hbm0,
 	.offsets_demand_hbm1	= offsets_demand_spr_hbm1,
 };
-- 
2.35.3

