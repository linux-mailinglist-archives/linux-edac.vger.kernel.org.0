Return-Path: <linux-edac+bounces-5514-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F6BC7F229
	for <lists+linux-edac@lfdr.de>; Mon, 24 Nov 2025 07:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF7413A6319
	for <lists+linux-edac@lfdr.de>; Mon, 24 Nov 2025 06:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9F92DFA5B;
	Mon, 24 Nov 2025 06:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iOcdbqal"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4F12DFA48;
	Mon, 24 Nov 2025 06:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763967476; cv=none; b=pBubhoiR1hi5JAk7NxqrtRYdOTwc2Y9hEsbougZQ7s2MvYr6azsahnHmapsbyTsdNX8NC9Onq3ToyuBI/U82f67KUKDCNJFzWUJDY9pdVs1vmIUHaofUpJ58rwthDFv7h5ycL6LDQE4Qnk+j0pEo5gUlOl0yjH5IMJUCGMzKZyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763967476; c=relaxed/simple;
	bh=k+2DyK9owP0KBKtjD+lYjGszZBTlqrdC0oHmdAKXvOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pDuCnduiPZCWrzhiCS62RDOeGRQmrnRa6vlLdvtUSIwWYhl9aBIrGT+eV8X2/7ANfVNhPLcOTV058BI4zhD2UbvbWg83VQjRX3T7CAIBHEinuTzKGG1YSbSThyOoxfHv1XnRFQMhoR/qtdgf5zdpfC6hydU6/1nwn8ap4X1xcd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iOcdbqal; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763967475; x=1795503475;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k+2DyK9owP0KBKtjD+lYjGszZBTlqrdC0oHmdAKXvOM=;
  b=iOcdbqalZQfc/AF9NwaPkWI/7sxLvJStj/h1XrRSFqgQNL23fjHXFJx1
   Mjf9zjJzsSIi9BLw7IzC0rM8zMQ46OoxdJwhZlJucXIQzYsyTpYNYoi3H
   HiybKSPYL+EmrNw8x86J902cRIb/E2GWmUZmEph43xkeiWuDLRpeuFUpM
   uSwx0BS8ZNuiwzyHKDvyjoM4YTtxffEff6/wKYfyzg2sVyssQP6/tUewC
   yair8JUgObA24bgWkHh5VCfyDnjpF8pNpRVPBkm/9MACD340pPBA+v5IN
   d7FMsY8VOXHUrAI/SXUW4fOkVEpbXovxXFTnbHLvjgLy+C4A33Xq/fFQJ
   A==;
X-CSE-ConnectionGUID: wLTneG6QQwCAzABBpYoi5w==
X-CSE-MsgGUID: pO2i0Xm2SImuYMROnqb5NA==
X-IronPort-AV: E=McAfee;i="6800,10657,11622"; a="76286903"
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="76286903"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2025 22:57:54 -0800
X-CSE-ConnectionGUID: uDLUk5UYTuibL4TWzgL7fg==
X-CSE-MsgGUID: 9IEyQGG6TYiO3Vo3OFVvsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="192272779"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2025 22:57:52 -0800
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Jianfeng Gao <jianfeng.gao@intel.com>,
	Yi Lai <yi1.lai@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] EDAC/igen6: Make masks of {MCHBAR, TOM, TOUUD, ECC_ERROR_LOG} configurable
Date: Mon, 24 Nov 2025 14:54:57 +0800
Message-ID: <20251124065457.3630949-3-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251124065457.3630949-1-qiuxu.zhuo@intel.com>
References: <20251124065457.3630949-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The masks used to retrieve base addresses from {MCHBAR, TOM, TOUUD,
ECC_ERROR_LOG} registers can be CPU model-specific. Currently,
igen6_edac hard-codes these masks with the most significant bit at
38, while some CPUs have extended the most significant bit to bit 41
or bit 45.

Systems with more than 512GB (2^39) memory need this extension to get
correct masks. But all CPUs currently supported by igen6_edac support
max memory less than 512GB (e.g., max memory size for Raptor Lake
systems is 192GB, for Alder Lake systems is 128GB, ...), which means
the previous hard-coded most significant bit 38 still works properly.
So backporting this patch to stable kernels is not necessary.

To make these masks reflect the CPUs' real support and easily support
future Intel client CPUs supported by igen6_edac that have more than
512GB memory, add four new fields to structure res_config to make these
masks CPU model-specific and configure them properly.

Tested-by: Jianfeng Gao <jianfeng.gao@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/igen6_edac.c | 67 ++++++++++++++++++++++++++++++++-------
 1 file changed, 55 insertions(+), 12 deletions(-)

diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index 5d887a3115f0..db4aa9f581e3 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -79,15 +79,11 @@
 #define ECC_ERROR_LOG_OFFSET		(IBECC_BASE + res_cfg->ibecc_error_log_offset)
 #define ECC_ERROR_LOG_CE		BIT_ULL(62)
 #define ECC_ERROR_LOG_UE		BIT_ULL(63)
-#define ECC_ERROR_LOG_ADDR_SHIFT	5
-#define ECC_ERROR_LOG_ADDR(v)		GET_BITFIELD(v, 5, 38)
-#define ECC_ERROR_LOG_ADDR45(v)		GET_BITFIELD(v, 5, 45)
 #define ECC_ERROR_LOG_SYND(v)		GET_BITFIELD(v, 46, 61)
 
 /* Host MMIO base address */
 #define MCHBAR_OFFSET			0x48
 #define MCHBAR_EN			BIT_ULL(0)
-#define MCHBAR_BASE(v)			(GET_BITFIELD(v, 16, 38) << 16)
 #define MCHBAR_SIZE			0x10000
 
 /* Parameters for the channel decode stage */
@@ -125,10 +121,21 @@
 #define MEM_SLICE_HASH_MASK(v)		(GET_BITFIELD(v, 6, 19) << 6)
 #define MEM_SLICE_HASH_LSB_MASK_BIT(v)	GET_BITFIELD(v, 24, 26)
 
+/* Non-constant mask variant of FIELD_GET() */
+#define field_get(mask, reg)  (((reg) & (mask)) >> (ffs(mask) - 1))
+
 static struct res_config {
 	bool machine_check;
 	/* The number of present memory controllers. */
 	int num_imc;
+	/* Host MMIO configuration */
+	u64 reg_mchbar_mask;
+	/* Top of memory */
+	u64 reg_tom_mask;
+	/* Top of upper usable DRAM */
+	u64 reg_touud_mask;
+	/* IBECC error log */
+	u64 reg_eccerrlog_addr_mask;
 	u32 imc_base;
 	u32 cmf_base;
 	u32 cmf_size;
@@ -305,7 +312,8 @@ static int get_mchbar(struct pci_dev *pdev, u64 *mchbar)
 		return -ENODEV;
 	}
 
-	*mchbar = MCHBAR_BASE(u.v);
+	*mchbar = u.v & res_cfg->reg_mchbar_mask;
+	edac_dbg(2, "MCHBAR 0x%llx (reg 0x%llx)\n", *mchbar, u.v);
 
 	return 0;
 }
@@ -481,11 +489,15 @@ static u64 adl_err_addr_to_imc_addr(u64 eaddr, int mc)
 
 static u64 rpl_p_err_addr(u64 ecclog)
 {
-	return ECC_ERROR_LOG_ADDR45(ecclog);
+	return field_get(res_cfg->reg_eccerrlog_addr_mask, ecclog);
 }
 
 static struct res_config ehl_cfg = {
 	.num_imc		= 1,
+	.reg_mchbar_mask	= GENMASK_ULL(38, 16),
+	.reg_tom_mask		= GENMASK_ULL(38, 20),
+	.reg_touud_mask		= GENMASK_ULL(38, 20),
+	.reg_eccerrlog_addr_mask = GENMASK_ULL(38, 5),
 	.imc_base		= 0x5000,
 	.ibecc_base		= 0xdc00,
 	.ibecc_available	= ehl_ibecc_available,
@@ -496,6 +508,10 @@ static struct res_config ehl_cfg = {
 
 static struct res_config icl_cfg = {
 	.num_imc		= 1,
+	.reg_mchbar_mask	= GENMASK_ULL(38, 16),
+	.reg_tom_mask		= GENMASK_ULL(38, 20),
+	.reg_touud_mask		= GENMASK_ULL(38, 20),
+	.reg_eccerrlog_addr_mask = GENMASK_ULL(38, 5),
 	.imc_base		= 0x5000,
 	.ibecc_base		= 0xd800,
 	.ibecc_error_log_offset	= 0x170,
@@ -507,6 +523,10 @@ static struct res_config icl_cfg = {
 static struct res_config tgl_cfg = {
 	.machine_check		= true,
 	.num_imc		= 2,
+	.reg_mchbar_mask	= GENMASK_ULL(38, 17),
+	.reg_tom_mask		= GENMASK_ULL(38, 20),
+	.reg_touud_mask		= GENMASK_ULL(38, 20),
+	.reg_eccerrlog_addr_mask = GENMASK_ULL(38, 5),
 	.imc_base		= 0x5000,
 	.cmf_base		= 0x11000,
 	.cmf_size		= 0x800,
@@ -521,6 +541,10 @@ static struct res_config tgl_cfg = {
 static struct res_config adl_cfg = {
 	.machine_check		= true,
 	.num_imc		= 2,
+	.reg_mchbar_mask	= GENMASK_ULL(41, 17),
+	.reg_tom_mask		= GENMASK_ULL(41, 20),
+	.reg_touud_mask		= GENMASK_ULL(41, 20),
+	.reg_eccerrlog_addr_mask = GENMASK_ULL(45, 5),
 	.imc_base		= 0xd800,
 	.ibecc_base		= 0xd400,
 	.ibecc_error_log_offset	= 0x68,
@@ -532,6 +556,10 @@ static struct res_config adl_cfg = {
 static struct res_config adl_n_cfg = {
 	.machine_check		= true,
 	.num_imc		= 1,
+	.reg_mchbar_mask	= GENMASK_ULL(41, 17),
+	.reg_tom_mask		= GENMASK_ULL(41, 20),
+	.reg_touud_mask		= GENMASK_ULL(41, 20),
+	.reg_eccerrlog_addr_mask = GENMASK_ULL(45, 5),
 	.imc_base		= 0xd800,
 	.ibecc_base		= 0xd400,
 	.ibecc_error_log_offset	= 0x68,
@@ -543,6 +571,10 @@ static struct res_config adl_n_cfg = {
 static struct res_config rpl_p_cfg = {
 	.machine_check		= true,
 	.num_imc		= 2,
+	.reg_mchbar_mask	= GENMASK_ULL(41, 17),
+	.reg_tom_mask		= GENMASK_ULL(41, 20),
+	.reg_touud_mask		= GENMASK_ULL(41, 20),
+	.reg_eccerrlog_addr_mask = GENMASK_ULL(45, 5),
 	.imc_base		= 0xd800,
 	.ibecc_base		= 0xd400,
 	.ibecc_error_log_offset	= 0x68,
@@ -555,6 +587,10 @@ static struct res_config rpl_p_cfg = {
 static struct res_config mtl_ps_cfg = {
 	.machine_check		= true,
 	.num_imc		= 2,
+	.reg_mchbar_mask	= GENMASK_ULL(41, 17),
+	.reg_tom_mask		= GENMASK_ULL(41, 20),
+	.reg_touud_mask		= GENMASK_ULL(41, 20),
+	.reg_eccerrlog_addr_mask = GENMASK_ULL(38, 5),
 	.imc_base		= 0xd800,
 	.ibecc_base		= 0xd400,
 	.ibecc_error_log_offset	= 0x170,
@@ -566,6 +602,10 @@ static struct res_config mtl_ps_cfg = {
 static struct res_config mtl_p_cfg = {
 	.machine_check		= true,
 	.num_imc		= 2,
+	.reg_mchbar_mask	= GENMASK_ULL(41, 17),
+	.reg_tom_mask		= GENMASK_ULL(41, 20),
+	.reg_touud_mask		= GENMASK_ULL(41, 20),
+	.reg_eccerrlog_addr_mask = GENMASK_ULL(38, 5),
 	.imc_base		= 0xd800,
 	.ibecc_base		= 0xd400,
 	.ibecc_error_log_offset	= 0x170,
@@ -577,6 +617,10 @@ static struct res_config mtl_p_cfg = {
 static struct res_config wcl_cfg = {
 	.machine_check		= true,
 	.num_imc		= 1,
+	.reg_mchbar_mask	= GENMASK_ULL(41, 17),
+	.reg_tom_mask		= GENMASK_ULL(41, 20),
+	.reg_touud_mask		= GENMASK_ULL(41, 20),
+	.reg_eccerrlog_addr_mask = GENMASK_ULL(38, 5),
 	.imc_base		= 0xd800,
 	.ibecc_base		= 0xd400,
 	.ibecc_error_log_offset	= 0x170,
@@ -908,8 +952,8 @@ static void ecclog_work_cb(struct work_struct *work)
 		if (res_cfg->err_addr)
 			eaddr = res_cfg->err_addr(node->ecclog);
 		else
-			eaddr = ECC_ERROR_LOG_ADDR(node->ecclog) <<
-				ECC_ERROR_LOG_ADDR_SHIFT;
+			eaddr = node->ecclog & res_cfg->reg_eccerrlog_addr_mask;
+
 		res.mc	     = node->mc;
 		res.sys_addr = res_cfg->err_addr_to_sys_addr(eaddr, res.mc);
 		res.imc_addr = res_cfg->err_addr_to_imc_addr(eaddr, res.mc);
@@ -1129,8 +1173,7 @@ static int debugfs_u64_set(void *data, u64 val)
 
 	pr_warn_once("Fake error to 0x%llx injected via debugfs\n", val);
 
-	val  >>= ECC_ERROR_LOG_ADDR_SHIFT;
-	ecclog = (val << ECC_ERROR_LOG_ADDR_SHIFT) | ECC_ERROR_LOG_CE;
+	ecclog = (val & res_cfg->reg_eccerrlog_addr_mask) | ECC_ERROR_LOG_CE;
 
 	if (!ecclog_gen_pool_add(0, ecclog))
 		irq_work_queue(&ecclog_irq_work);
@@ -1196,7 +1239,7 @@ static int igen6_pci_setup(struct pci_dev *pdev, u64 *mchbar)
 		goto fail;
 	}
 
-	igen6_tom = u.v & GENMASK_ULL(38, 20);
+	igen6_tom = u.v & res_cfg->reg_tom_mask;
 
 	if (get_mchbar(pdev, mchbar))
 		goto fail;
@@ -1207,7 +1250,7 @@ static int igen6_pci_setup(struct pci_dev *pdev, u64 *mchbar)
 	else if (pci_read_config_dword(pdev, TOUUD_OFFSET + 4, &u.v_hi))
 		edac_dbg(2, "Failed to read upper TOUUD\n");
 	else
-		igen6_touud = u.v & GENMASK_ULL(38, 20);
+		igen6_touud = u.v & res_cfg->reg_touud_mask;
 #endif
 
 	return 0;
-- 
2.43.0


