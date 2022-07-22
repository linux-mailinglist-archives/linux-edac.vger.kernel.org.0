Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD4957EA3C
	for <lists+linux-edac@lfdr.de>; Sat, 23 Jul 2022 01:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbiGVXdy (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 22 Jul 2022 19:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbiGVXdw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 22 Jul 2022 19:33:52 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3DF88CE3;
        Fri, 22 Jul 2022 16:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658532832; x=1690068832;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2eUb6jjFi44WtfaMDFPHfogl5CxsvKABtplSHamEE8o=;
  b=YSvJiDydWYEBHan/JuhlO1j2yNlB55eEgFT9WxosCwUcVMqzY1tkH4t4
   q10n1SNoMDSjS1VI7xBxyxMQs9nWN1YxwZHhF1PKqyNvvqqirpJRrs9eo
   owUvQjEDdbGWigVv71/ZPATjeSKRh9UIgczFi7uZVZWDIBtq0ZT6VdDu/
   bXZMeABTM+o2DisszO5uOTcPzLI95/dLv7fUqUOyk38zrcNZxaavprsYR
   PY7KXntUko3JRwEEgrU+I4SaqD+Ix/bJRv++ErzPapKxPXliriU7C+nWL
   d6I79hbyskF+Gz6kpClmChl/OyHs7epbe/E3n1MGJPzBXkGEkp3bZEipM
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10416"; a="286185333"
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="286185333"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 16:33:48 -0700
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="574346064"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 16:33:47 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     linux-edac@vger.kernel.org
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Tony Luck <tony.luck@intel.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: [PATCH 2/4] EDAC/i10nm: Retrieve and print retry_rd_err_log registers for HBM
Date:   Fri, 22 Jul 2022 16:33:36 -0700
Message-Id: <20220722233338.341567-3-tony.luck@intel.com>
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

An HBM memory channel is divided into two pseudo channels. Each
pseudo channel has its own retry_rd_err_log registers. Retrieve and
print retry_rd_err_log registers of the HBM pseudo channel if the
memory error is from HBM.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/edac/skx_common.h |  4 ++
 drivers/edac/i10nm_base.c | 84 +++++++++++++++++++++++++++++++--------
 2 files changed, 71 insertions(+), 17 deletions(-)

diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index 70ec4f41911b..dbf8e458ad2b 100644
--- a/drivers/edac/skx_common.h
+++ b/drivers/edac/skx_common.h
@@ -158,7 +158,11 @@ struct res_config {
 	int sad_all_offset;
 	/* Offsets of retry_rd_err_log registers */
 	u32 *offsets_scrub;
+	u32 *offsets_scrub_hbm0;
+	u32 *offsets_scrub_hbm1;
 	u32 *offsets_demand;
+	u32 *offsets_demand_hbm0;
+	u32 *offsets_demand_hbm1;
 };
 
 typedef int (*get_dimm_config_f)(struct mem_ctl_info *mci,
diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index 6cf50ee0b77c..976d8e8a4d1b 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -77,18 +77,20 @@ static int retry_rd_err_log;
 
 static u32 offsets_scrub_icx[]  = {0x22c60, 0x22c54, 0x22c5c, 0x22c58, 0x22c28, 0x20ed8};
 static u32 offsets_scrub_spr[]  = {0x22c60, 0x22c54, 0x22f08, 0x22c58, 0x22c28, 0x20ed8};
+static u32 offsets_scrub_spr_hbm0[]  = {0x2860, 0x2854, 0x2b08, 0x2858, 0x2828, 0x0ed8};
+static u32 offsets_scrub_spr_hbm1[]  = {0x2c60, 0x2c54, 0x2f08, 0x2c58, 0x2c28, 0x0fa8};
 static u32 offsets_demand_icx[] = {0x22e54, 0x22e60, 0x22e64, 0x22e58, 0x22e5c, 0x20ee0};
 static u32 offsets_demand_spr[] = {0x22e54, 0x22e60, 0x22f10, 0x22e58, 0x22e5c, 0x20ee0};
+static u32 offsets_demand_spr_hbm0[] = {0x2a54, 0x2a60, 0x2b10, 0x2a58, 0x2a5c, 0x0ee0};
+static u32 offsets_demand_spr_hbm1[] = {0x2e54, 0x2e60, 0x2f10, 0x2e58, 0x2e5c, 0x0fb0};
 
-static void __enable_retry_rd_err_log(struct skx_imc *imc, int chan, bool enable)
+static void __enable_retry_rd_err_log(struct skx_imc *imc, int chan, bool enable,
+				      u32 *offsets_scrub, u32 *offsets_demand)
 {
 	u32 s, d;
 
-	if (!imc->mbase)
-		return;
-
-	s = I10NM_GET_REG32(imc, chan, res_cfg->offsets_scrub[0]);
-	d = I10NM_GET_REG32(imc, chan, res_cfg->offsets_demand[0]);
+	s = I10NM_GET_REG32(imc, chan, offsets_scrub[0]);
+	d = I10NM_GET_REG32(imc, chan, offsets_demand[0]);
 
 	if (enable) {
 		/* Save default configurations */
@@ -115,21 +117,39 @@ static void __enable_retry_rd_err_log(struct skx_imc *imc, int chan, bool enable
 			d &= ~RETRY_RD_ERR_LOG_EN;
 	}
 
-	I10NM_SET_REG32(imc, chan, res_cfg->offsets_scrub[0], s);
-	I10NM_SET_REG32(imc, chan, res_cfg->offsets_demand[0], d);
+	I10NM_SET_REG32(imc, chan, offsets_scrub[0], s);
+	I10NM_SET_REG32(imc, chan, offsets_demand[0], d);
 }
 
 static void enable_retry_rd_err_log(bool enable)
 {
+	struct skx_imc *imc;
 	struct skx_dev *d;
 	int i, j;
 
 	edac_dbg(2, "\n");
 
 	list_for_each_entry(d, i10nm_edac_list, list)
-		for (i = 0; i < I10NM_NUM_IMC; i++)
-			for (j = 0; j < I10NM_NUM_CHANNELS; j++)
-				__enable_retry_rd_err_log(&d->imc[i], j, enable);
+		for (i = 0; i < I10NM_NUM_IMC; i++) {
+			imc = &d->imc[i];
+			if (!imc->mbase)
+				continue;
+
+			for (j = 0; j < I10NM_NUM_CHANNELS; j++) {
+				if (imc->hbm_mc) {
+					__enable_retry_rd_err_log(imc, j, enable,
+								  res_cfg->offsets_scrub_hbm0,
+								  res_cfg->offsets_demand_hbm0);
+					__enable_retry_rd_err_log(imc, j, enable,
+								  res_cfg->offsets_scrub_hbm1,
+								  res_cfg->offsets_demand_hbm1);
+				} else {
+					__enable_retry_rd_err_log(imc, j, enable,
+								  res_cfg->offsets_scrub,
+								  res_cfg->offsets_demand);
+				}
+			}
+	}
 }
 
 static void show_retry_rd_err_log(struct decoded_addr *res, char *msg,
@@ -140,12 +160,24 @@ static void show_retry_rd_err_log(struct decoded_addr *res, char *msg,
 	u32 corr0, corr1, corr2, corr3;
 	u64 log2a, log5;
 	u32 *offsets;
-	int n;
+	int n, pch;
 
 	if (!imc->mbase)
 		return;
 
-	offsets = scrub_err ? res_cfg->offsets_scrub : res_cfg->offsets_demand;
+	if (imc->hbm_mc) {
+		pch = res->cs & 1;
+
+		if (pch)
+			offsets = scrub_err ? res_cfg->offsets_scrub_hbm1 :
+					      res_cfg->offsets_demand_hbm1;
+		else
+			offsets = scrub_err ? res_cfg->offsets_scrub_hbm0 :
+					      res_cfg->offsets_demand_hbm0;
+	} else {
+		offsets = scrub_err ? res_cfg->offsets_scrub :
+				      res_cfg->offsets_demand;
+	}
 
 	log0 = I10NM_GET_REG32(imc, res->channel, offsets[0]);
 	log1 = I10NM_GET_REG32(imc, res->channel, offsets[1]);
@@ -163,10 +195,24 @@ static void show_retry_rd_err_log(struct decoded_addr *res, char *msg,
 			     log0, log1, log2, log3, log4, log5);
 	}
 
-	corr0 = I10NM_GET_REG32(imc, res->channel, 0x22c18);
-	corr1 = I10NM_GET_REG32(imc, res->channel, 0x22c1c);
-	corr2 = I10NM_GET_REG32(imc, res->channel, 0x22c20);
-	corr3 = I10NM_GET_REG32(imc, res->channel, 0x22c24);
+	if (imc->hbm_mc) {
+		if (pch) {
+			corr0 = I10NM_GET_REG32(imc, res->channel, 0x2c18);
+			corr1 = I10NM_GET_REG32(imc, res->channel, 0x2c1c);
+			corr2 = I10NM_GET_REG32(imc, res->channel, 0x2c20);
+			corr3 = I10NM_GET_REG32(imc, res->channel, 0x2c24);
+		} else {
+			corr0 = I10NM_GET_REG32(imc, res->channel, 0x2818);
+			corr1 = I10NM_GET_REG32(imc, res->channel, 0x281c);
+			corr2 = I10NM_GET_REG32(imc, res->channel, 0x2820);
+			corr3 = I10NM_GET_REG32(imc, res->channel, 0x2824);
+		}
+	} else {
+		corr0 = I10NM_GET_REG32(imc, res->channel, 0x22c18);
+		corr1 = I10NM_GET_REG32(imc, res->channel, 0x22c1c);
+		corr2 = I10NM_GET_REG32(imc, res->channel, 0x22c20);
+		corr3 = I10NM_GET_REG32(imc, res->channel, 0x22c24);
+	}
 
 	if (len - n > 0)
 		snprintf(msg + n, len - n,
@@ -420,7 +466,11 @@ static struct res_config spr_cfg = {
 	.sad_all_devfn		= PCI_DEVFN(10, 0),
 	.sad_all_offset		= 0x300,
 	.offsets_scrub		= offsets_scrub_spr,
+	.offsets_scrub_hbm0	= offsets_scrub_spr_hbm0,
+	.offsets_scrub_hbm1	= offsets_scrub_spr_hbm1,
 	.offsets_demand		= offsets_demand_spr,
+	.offsets_demand_hbm0	= offsets_demand_spr_hbm0,
+	.offsets_demand_hbm1	= offsets_demand_spr_hbm1,
 };
 
 static const struct x86_cpu_id i10nm_cpuids[] = {
-- 
2.35.3

