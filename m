Return-Path: <linux-edac+bounces-3575-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD737A920DF
	for <lists+linux-edac@lfdr.de>; Thu, 17 Apr 2025 17:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DFCD19E330C
	for <lists+linux-edac@lfdr.de>; Thu, 17 Apr 2025 15:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F54252905;
	Thu, 17 Apr 2025 15:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dEk6IrGW"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA5F2528FD;
	Thu, 17 Apr 2025 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744902540; cv=none; b=AWXBTatB2fbIQIHB7a2vzElFd+mNHcv62t+v4+qTzg4aI1dR6cr3v193UsisWNUWYLA1PR3dYBf34C/tEF2h1TZ2iaoJnw/OXTIkMvb4Jgo4p3H1JqJCQJ1QOmjs+R6VQFmMnOfNGTkA2rmkMd55r2Z6tlzpF6seI78QxBYsbfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744902540; c=relaxed/simple;
	bh=P5cQvtwHFprTvaKH1BDhr2iMULhAjxnJwD+E5qasORk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aWFlR1WcirA6uAVeoM2qA2ODyvWbSai8hSCeR37is67HgXlDkWAum4KWhojTxryvlpcCC4Av2SgTCMUvV+thTjoK7BrWUg+fnPvHjQgb6H1mTMROZbVBItUuXVF4Z0vGEyQPuCr/HNls0fV5e/MIkV/7FFcKLyodt+2X1Gv3BLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dEk6IrGW; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744902538; x=1776438538;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P5cQvtwHFprTvaKH1BDhr2iMULhAjxnJwD+E5qasORk=;
  b=dEk6IrGWlgk/YkkiX6lqgis612V6jkfYL7jLuQcrC7oL6giDuVv5rPgI
   plHiAGvXjqCLf5ExlvU3yOQVyVwGbghOGSJhj65b9ftxiWRSRWfx8Bri1
   WbT3IBc/Ha6sNO8SolCs/WQGpmhydScV6/ASL2hmaLnDvY2H4Y1BF0S4o
   tbtU5FF2O8O+A/8yBTgnceumuC/HzCCiQ1qiQ6w1uDSdsGeGRFH0YpFhs
   bSxsmEFLgVq38y7OeTSJ+enyoG2mBv7nm3w5VIKMOcKrpNJdxCTtThbWg
   RK9S6OX6nCs4uBF+xSPoTH0jQ1aLRsiu1qbAI7qMxj+poURIANGR6AjXC
   A==;
X-CSE-ConnectionGUID: n2NivDivRqyIp35zaJZY5A==
X-CSE-MsgGUID: ZuHrpZAWSM+Dw6Czo2h2ew==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="57488663"
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="57488663"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 08:08:57 -0700
X-CSE-ConnectionGUID: KX3ZYkofSbyCIz3dIVHk0A==
X-CSE-MsgGUID: 7UoTKLZgT7KMb0claor4kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="161876811"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 08:08:55 -0700
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
Subject: [PATCH 2/7] EDAC/{skx_common,i10nm}: Fix the loss of saved RRL for HBM pseudo channel 0
Date: Thu, 17 Apr 2025 23:07:19 +0800
Message-ID: <20250417150724.1170168-3-qiuxu.zhuo@intel.com>
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

When enabling the retry_rd_err_log (RRL) feature during the loading of the
i10nm_edac driver with the module parameter retry_rd_err_log=2 (Linux RRL
control mode), the default values of the control bits of RRL are saved so
that they can be restored during the unloading of the driver.

In the current code, the RRL of pseudo channel 1 of HBM overwrites pseudo
channel 0 during the loading of the driver, resulting in the loss of saved
RRL for pseudo channel 0. This causes the RRL of pseudo channel 0 of HBM to
be wrongly restored with the values from pseudo channel 1 when unloading
the driver.

Fix this issue by creating two separate groups of RRL control registers
per channel to save default RRL settings of two {sub-,pseudo-}channels.

Fixes: acd4cf68fefe ("EDAC/i10nm: Retrieve and print retry_rd_err_log registers for HBM")
Tested-by: Feng Xu <feng.f.xu@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/i10nm_base.c | 35 +++++++++++++++++++----------------
 drivers/edac/skx_common.h | 11 ++++++++---
 2 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index 355a977019e9..355b527d839e 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -95,7 +95,7 @@ static u32 offsets_demand2_spr[] = {0x22c70, 0x22d80, 0x22f18, 0x22d58, 0x22c64,
 static u32 offsets_demand_spr_hbm0[] = {0x2a54, 0x2a60, 0x2b10, 0x2a58, 0x2a5c, 0x0ee0};
 static u32 offsets_demand_spr_hbm1[] = {0x2e54, 0x2e60, 0x2f10, 0x2e58, 0x2e5c, 0x0fb0};
 
-static void __enable_retry_rd_err_log(struct skx_imc *imc, int chan, bool enable,
+static void __enable_retry_rd_err_log(struct skx_imc *imc, int chan, bool enable, u32 *rrl_ctl,
 				      u32 *offsets_scrub, u32 *offsets_demand,
 				      u32 *offsets_demand2)
 {
@@ -108,10 +108,10 @@ static void __enable_retry_rd_err_log(struct skx_imc *imc, int chan, bool enable
 
 	if (enable) {
 		/* Save default configurations */
-		imc->chan[chan].retry_rd_err_log_s = s;
-		imc->chan[chan].retry_rd_err_log_d = d;
+		rrl_ctl[0] = s;
+		rrl_ctl[1] = d;
 		if (offsets_demand2)
-			imc->chan[chan].retry_rd_err_log_d2 = d2;
+			rrl_ctl[2] = d2;
 
 		s &= ~RETRY_RD_ERR_LOG_NOOVER_UC;
 		s |=  RETRY_RD_ERR_LOG_EN;
@@ -125,25 +125,25 @@ static void __enable_retry_rd_err_log(struct skx_imc *imc, int chan, bool enable
 		}
 	} else {
 		/* Restore default configurations */
-		if (imc->chan[chan].retry_rd_err_log_s & RETRY_RD_ERR_LOG_UC)
+		if (rrl_ctl[0] & RETRY_RD_ERR_LOG_UC)
 			s |=  RETRY_RD_ERR_LOG_UC;
-		if (imc->chan[chan].retry_rd_err_log_s & RETRY_RD_ERR_LOG_NOOVER)
+		if (rrl_ctl[0] & RETRY_RD_ERR_LOG_NOOVER)
 			s |=  RETRY_RD_ERR_LOG_NOOVER;
-		if (!(imc->chan[chan].retry_rd_err_log_s & RETRY_RD_ERR_LOG_EN))
+		if (!(rrl_ctl[0] & RETRY_RD_ERR_LOG_EN))
 			s &= ~RETRY_RD_ERR_LOG_EN;
-		if (imc->chan[chan].retry_rd_err_log_d & RETRY_RD_ERR_LOG_UC)
+		if (rrl_ctl[1] & RETRY_RD_ERR_LOG_UC)
 			d |=  RETRY_RD_ERR_LOG_UC;
-		if (imc->chan[chan].retry_rd_err_log_d & RETRY_RD_ERR_LOG_NOOVER)
+		if (rrl_ctl[1] & RETRY_RD_ERR_LOG_NOOVER)
 			d |=  RETRY_RD_ERR_LOG_NOOVER;
-		if (!(imc->chan[chan].retry_rd_err_log_d & RETRY_RD_ERR_LOG_EN))
+		if (!(rrl_ctl[1] & RETRY_RD_ERR_LOG_EN))
 			d &= ~RETRY_RD_ERR_LOG_EN;
 
 		if (offsets_demand2) {
-			if (imc->chan[chan].retry_rd_err_log_d2 & RETRY_RD_ERR_LOG_UC)
+			if (rrl_ctl[2] & RETRY_RD_ERR_LOG_UC)
 				d2 |=  RETRY_RD_ERR_LOG_UC;
-			if (!(imc->chan[chan].retry_rd_err_log_d2 & RETRY_RD_ERR_LOG_NOOVER))
+			if (!(rrl_ctl[2] & RETRY_RD_ERR_LOG_NOOVER))
 				d2 &=  ~RETRY_RD_ERR_LOG_NOOVER;
-			if (!(imc->chan[chan].retry_rd_err_log_d2 & RETRY_RD_ERR_LOG_EN))
+			if (!(rrl_ctl[2] & RETRY_RD_ERR_LOG_EN))
 				d2 &= ~RETRY_RD_ERR_LOG_EN;
 		}
 	}
@@ -157,6 +157,7 @@ static void __enable_retry_rd_err_log(struct skx_imc *imc, int chan, bool enable
 static void enable_retry_rd_err_log(bool enable)
 {
 	int i, j, imc_num, chan_num;
+	struct skx_channel *chan;
 	struct skx_imc *imc;
 	struct skx_dev *d;
 
@@ -171,8 +172,9 @@ static void enable_retry_rd_err_log(bool enable)
 			if (!imc->mbase)
 				continue;
 
+			chan = d->imc[i].chan;
 			for (j = 0; j < chan_num; j++)
-				__enable_retry_rd_err_log(imc, j, enable,
+				__enable_retry_rd_err_log(imc, j, enable, chan[j].rrl_ctl[0],
 							  res_cfg->offsets_scrub,
 							  res_cfg->offsets_demand,
 							  res_cfg->offsets_demand2);
@@ -186,12 +188,13 @@ static void enable_retry_rd_err_log(bool enable)
 			if (!imc->mbase || !imc->hbm_mc)
 				continue;
 
+			chan = d->imc[i].chan;
 			for (j = 0; j < chan_num; j++) {
-				__enable_retry_rd_err_log(imc, j, enable,
+				__enable_retry_rd_err_log(imc, j, enable, chan[j].rrl_ctl[0],
 							  res_cfg->offsets_scrub_hbm0,
 							  res_cfg->offsets_demand_hbm0,
 							  NULL);
-				__enable_retry_rd_err_log(imc, j, enable,
+				__enable_retry_rd_err_log(imc, j, enable, chan[j].rrl_ctl[1],
 							  res_cfg->offsets_scrub_hbm1,
 							  res_cfg->offsets_demand_hbm1,
 							  NULL);
diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index ca5408803f87..5afd425f3b4f 100644
--- a/drivers/edac/skx_common.h
+++ b/drivers/edac/skx_common.h
@@ -79,6 +79,9 @@
  */
 #define MCACOD_EXT_MEM_ERR	0x280
 
+/* Max RRL register sets per {,sub-,pseudo-}channel. */
+#define NUM_RRL_SET		3
+
 /*
  * Each cpu socket contains some pci devices that provide global
  * information, and also some that are local to each of the two
@@ -117,9 +120,11 @@ struct skx_dev {
 		struct skx_channel {
 			struct pci_dev	*cdev;
 			struct pci_dev	*edev;
-			u32 retry_rd_err_log_s;
-			u32 retry_rd_err_log_d;
-			u32 retry_rd_err_log_d2;
+			/*
+			 * Two groups of RRL control registers per channel to save default RRL
+			 * settings of two {sub-,pseudo-}channels in Linux RRL control mode.
+			 */
+			u32 rrl_ctl[2][NUM_RRL_SET];
 			struct skx_dimm {
 				u8 close_pg;
 				u8 bank_xor_enable;
-- 
2.43.0


