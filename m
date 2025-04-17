Return-Path: <linux-edac+bounces-3580-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E49D1A920ED
	for <lists+linux-edac@lfdr.de>; Thu, 17 Apr 2025 17:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7300F5A3DCE
	for <lists+linux-edac@lfdr.de>; Thu, 17 Apr 2025 15:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D467253F16;
	Thu, 17 Apr 2025 15:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OIfd5xhx"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412B1253B78;
	Thu, 17 Apr 2025 15:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744902568; cv=none; b=PVXLSZZ14kEWiRX9er0LIUlXOiNxtvsPXy3VmE/REVpOhbL2lx9F9hYIu3shqq/10XipmPmCuti62qNdFLbrWzqk1QsQ8bvcVK/IAk4bbKl2U7/Bbnglx7R2r9zPPZbAxs/AmbjIZn3qpkgo1RGYYTPNvLcAo8M39Nq7hfUnMmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744902568; c=relaxed/simple;
	bh=AdFC9QPAdrG+ZuiF0LMjbfb7m0Ibpa1So+c1GMQJ9Zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fbEBockRAhHBbiS7JUQjNJ+eCr+BagbbuFTfir6wsQZYkDBoLVv3CcJt35Ne8t1i/nkIzcNlS3cxeqMwA9nb0Yx9CEJHFdzd2b6BMYeL5g2p65afpV46jg4UE8F0m6+kVRCEsB2QYAMiUzVBk4szdyPtIUseo9dep77vhipk8eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OIfd5xhx; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744902567; x=1776438567;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AdFC9QPAdrG+ZuiF0LMjbfb7m0Ibpa1So+c1GMQJ9Zc=;
  b=OIfd5xhxf8vDbgbr31zSFqxCHDLhIUJpxasKBLdWqfdykwTFwNa98UMX
   +1wT9LN92MPNbuoA+kvXzHjQrKleFFJEq8jKC1A4MWaxxEIRIzMjWnNVs
   HYW7JDZqms7C5Jas60jtrWxgKzjYvw+25y93b49zwDnLJ+tHOZaEebtPW
   zw2MmtHikTyVRhlEH2Aka7yoD7g4i/fLlUUpEOeTpGc1AxRQy6vBSxEB4
   mTdR59Ggwky0QnIGPQAwiRi7XwMKESx3S2dkQaYwMrqQ6x5itCE2NLdjC
   eMx+Z68b/z73wvVE6wX0PabMmsTQN+xaG73d1VV5/OeYoj39T0tRWuc3+
   Q==;
X-CSE-ConnectionGUID: atWwOe9GTiikVPDfalxlYw==
X-CSE-MsgGUID: 4MyW9Dx+TO+9sdNr6qjhgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="57488756"
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="57488756"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 08:09:27 -0700
X-CSE-ConnectionGUID: BXXrn+CxTlak/hFwHn9DmA==
X-CSE-MsgGUID: 8thGXoyRTOeuF5R7/Ihm/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="161876948"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 08:09:24 -0700
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
Subject: [PATCH 7/7] EDAC/{skx_common,i10nm}: Add RRL support for Intel Granite Rapids server
Date: Thu, 17 Apr 2025 23:07:24 +0800
Message-ID: <20250417150724.1170168-8-qiuxu.zhuo@intel.com>
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

Compared to previous generations, Granite Rapids defines the RRL control
bits {en_patspr, noover, en} in different positions, adds an extra RRL set
for the new mode of the first patrol-scrub read error, and extends the
number of CORRERRCNT registers from 4 to 8, encoding one counter per
CORRERRCNT register.

Add a Granite Rapids reg_rrl configuration table and adjust the code to
accommodate the differences mentioned above for RRL support.

Tested-by: Feng Xu <feng.f.xu@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/i10nm_base.c | 37 +++++++++++++++++++++++++++++++++++--
 drivers/edac/skx_common.h |  4 ++--
 2 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index aefc448283d3..8863f1fb4caf 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -164,6 +164,29 @@ static struct reg_rrl spr_reg_rrl_hbm_pch1 = {
 	.cecnt_widths	= {4, 4, 4, 4},
 };
 
+static struct reg_rrl gnr_reg_rrl_ddr = {
+	.set_num = 4,
+	.reg_num = 6,
+	.modes = {FRE_SCRUB, FRE_DEMAND, LRE_SCRUB, LRE_DEMAND},
+	.offsets = {
+		{0x2f10, 0x2f20, 0x2f30, 0x2f50, 0x2f60, 0xba0},
+		{0x2f14, 0x2f24, 0x2f38, 0x2f54, 0x2f64, 0xba8},
+		{0x2f18, 0x2f28, 0x2f40, 0x2f58, 0x2f68, 0xbb0},
+		{0x2f1c, 0x2f2c, 0x2f48, 0x2f5c, 0x2f6c, 0xbb8},
+	},
+	.widths		= {4, 4, 8, 4, 4, 8},
+	.v_mask		= BIT(0),
+	.uc_mask	= BIT(1),
+	.over_mask	= BIT(2),
+	.en_patspr_mask	= BIT(14),
+	.noover_mask	= BIT(15),
+	.en_mask	= BIT(12),
+
+	.cecnt_num	= 8,
+	.cecnt_offsets	= {0x2c10, 0x2c14, 0x2c18, 0x2c1c, 0x2c20, 0x2c24, 0x2c28, 0x2c2c},
+	.cecnt_widths	= {4, 4, 4, 4, 4, 4, 4, 4},
+};
+
 static u64 read_imc_reg(struct skx_imc *imc, int chan, u32 offset, u8 width)
 {
 	switch (width) {
@@ -353,8 +376,17 @@ static void show_retry_rd_err_log(struct decoded_addr *res, char *msg,
 			width = rrl->cecnt_widths[i];
 			corr = read_imc_reg(imc, ch, offset, width);
 
-			n += snprintf(msg + n, len - n, "%.4llx %.4llx ",
-				      corr & 0xffff, corr >> 16);
+			/* CPUs {ICX,SPR} encode two counters per 4-byte CORRERRCNT register. */
+			if (res_cfg->type <= SPR) {
+				n += snprintf(msg + n, len - n, "%.4llx %.4llx ",
+					      corr & 0xffff, corr >> 16);
+			} else {
+			/* CPUs {GNR} encode one counter per CORRERRCNT register. */
+				if (width == 4)
+					n += snprintf(msg + n, len - n, "%.8llx ", corr);
+				else
+					n += snprintf(msg + n, len - n, "%.16llx ", corr);
+			}
 		}
 
 		/* Move back one space. */
@@ -985,6 +1017,7 @@ static struct res_config gnr_cfg = {
 	.uracu_bdf		= {0, 0, 1},
 	.ddr_mdev_bdf		= {0, 5, 1},
 	.sad_all_offset		= 0x300,
+	.reg_rrl_ddr		= &gnr_reg_rrl_ddr,
 };
 
 static const struct x86_cpu_id i10nm_cpuids[] = {
diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index 8f0f4af2cb27..ec4966f7ea40 100644
--- a/drivers/edac/skx_common.h
+++ b/drivers/edac/skx_common.h
@@ -80,11 +80,11 @@
 #define MCACOD_EXT_MEM_ERR	0x280
 
 /* Max RRL register sets per {,sub-,pseudo-}channel. */
-#define NUM_RRL_SET		3
+#define NUM_RRL_SET		4
 /* Max RRL registers per set. */
 #define NUM_RRL_REG		6
 /* Max correctable error count registers. */
-#define NUM_CECNT_REG		4
+#define NUM_CECNT_REG		8
 
 /* Modes of RRL register set. */
 enum rrl_mode {
-- 
2.43.0


