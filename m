Return-Path: <linux-edac+bounces-5474-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC0EC6F1B2
	for <lists+linux-edac@lfdr.de>; Wed, 19 Nov 2025 15:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EA4B03A5403
	for <lists+linux-edac@lfdr.de>; Wed, 19 Nov 2025 13:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B53D363C6E;
	Wed, 19 Nov 2025 13:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="edIMOnoV"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D223035F8C5;
	Wed, 19 Nov 2025 13:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763560388; cv=none; b=H3OuzVjTh57YLujYKE3WMFf7LxFDQkY2daCsV8enlOjfi6zwiqVgyAunBVpjYm+49aCJFW+4WTqYSO96xa+BrFQTrpRQ9RcCBknnept4hzR1L1mNk4Rml/ZzFSJIsQL2c7bqjmw0tdZV7ZNZspCFB2fdbxN7P3X+vjex3BpxGks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763560388; c=relaxed/simple;
	bh=4nvQWRKP+c+lm2sgAd6g5mnHFYeTFSjXsAM4cnMd1Ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NoVigG34hPeYM8/1kZAPq2hJg6BdkdFwj87KWbbMlQCJ9CR1++7Ydg3BjTfB6BSmwJ6uAOqkP7ZbaIsZM5bw5urOxnRxHsQWmn1x0So3HQesQwFUKDoxYIHvtzY+oR4j9hrxFxlwjlj/ju4VGXAKwumroydmtRRd3psBIaH24pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=edIMOnoV; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763560387; x=1795096387;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4nvQWRKP+c+lm2sgAd6g5mnHFYeTFSjXsAM4cnMd1Ic=;
  b=edIMOnoVrgLZ/oWbHufUYZ9LtooMM+vEX/jg9aK/xW9RHkeiGzJBHL9v
   VmJEW7y7OHS7LXtsjepWtswsBnRbH2cGFIkIJsd27mgmv4n4ORkFkOPVi
   eS51n3x2VF5NVuk1AUFQvQoucnOSX3NeyLDrnwmdUrcKOXtLw9u7r7cE2
   AEkQxfH99hQnM+SMY3L938e6luBWIvcqvGQG/KRKqIW/YlA0woaAow0ql
   rIdedt11SQzkHojyeaIfCDD0JY2uTgA03iTFAVKiapdZuf6HjrXUbt81b
   4bHtCkACPLYY4H78hUk7+P1jgevxC2senLwESoICFv9EWWH7htBDQu9nI
   A==;
X-CSE-ConnectionGUID: akqBLTOaTTegXuN2XuK5JA==
X-CSE-MsgGUID: S2LYjIvDTi2Tmoyv74admA==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="64607446"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="64607446"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 05:53:04 -0800
X-CSE-ConnectionGUID: vqiEW6IUTPisxd/q6aXFQQ==
X-CSE-MsgGUID: 65PH8biHQPy4tDGN8LqPcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="214439692"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 05:53:02 -0800
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Yi Lai <yi1.lai@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] EDAC/{skx_comm,imh}: Detect 2-level memory configuration
Date: Wed, 19 Nov 2025 21:41:30 +0800
Message-ID: <20251119134132.2389472-7-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251119134132.2389472-1-qiuxu.zhuo@intel.com>
References: <20251119134132.2389472-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Detect 2-level memory configurations and notify the 'skx_common' library
to enable ADXL 2-level memory error decoding.

Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/imh_base.c   | 38 ++++++++++++++++++++++++++++++++++++++
 drivers/edac/skx_common.h |  4 ++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/edac/imh_base.c b/drivers/edac/imh_base.c
index 9c1a17c53ec1..5f0313c1ac2e 100644
--- a/drivers/edac/imh_base.c
+++ b/drivers/edac/imh_base.c
@@ -35,6 +35,9 @@
 #define TOLM(reg)			(((u64)GET_BITFIELD(reg, 16, 31)) << 16)
 #define TOHM(reg)			(((u64)GET_BITFIELD(reg, 16, 51)) << 16)
 
+/* Home Agent (HA) */
+#define NMCACHING(reg)			GET_BITFIELD(reg, 8, 8)
+
 /**
  * struct local_reg - A register as described in the local package view.
  *
@@ -346,6 +349,35 @@ static int imh_get_munits(struct res_config *cfg, struct list_head *edac_list)
 	return 0;
 }
 
+static bool check_2lm_enabled(struct res_config *cfg, struct skx_dev *d, int ha_idx)
+{
+	DEFINE_LOCAL_REG(reg, cfg, d->pkg, true, ha, ha_idx, mode);
+
+	if (!read_local_reg(&reg))
+		return false;
+
+	if (!NMCACHING(reg.val))
+		return false;
+
+	edac_dbg(2, "2-level memory configuration (reg 0x%llx, ha idx %d)\n", reg.val, ha_idx);
+	return true;
+}
+
+/* Check whether the system has a 2-level memory configuration. */
+static bool imh_2lm_enabled(struct res_config *cfg, struct list_head *head)
+{
+	struct skx_dev *d;
+	int i;
+
+	list_for_each_entry(d, head, list) {
+		for (i = 0; i < cfg->ddr_imc_num; i++)
+			if (check_2lm_enabled(cfg, d, i))
+				return true;
+	}
+
+	return false;
+}
+
 /* Helpers to read memory controller registers */
 static u64 read_imc_reg(struct skx_imc *imc, int chan, u32 offset, u8 width)
 {
@@ -467,6 +499,10 @@ static struct res_config dmr_cfg = {
 	.sca_reg_tolm_width		= 8,
 	.sca_reg_tohm_offset		= 0x2108,
 	.sca_reg_tohm_width		= 8,
+	.ha_base			= 0x3eb000,
+	.ha_size			= 0x1000,
+	.ha_reg_mode_offset		= 0x4a0,
+	.ha_reg_mode_width		= 4,
 };
 
 static const struct x86_cpu_id imh_cpuids[] = {
@@ -526,6 +562,8 @@ static int __init imh_init(void)
 	if (rc)
 		goto fail;
 
+	skx_set_mem_cfg(imh_2lm_enabled(cfg, edac_list));
+
 	rc = imh_register_mci(cfg, edac_list);
 	if (rc)
 		goto fail;
diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index 39a3462ede28..f88038e5b18c 100644
--- a/drivers/edac/skx_common.h
+++ b/drivers/edac/skx_common.h
@@ -313,6 +313,10 @@ struct res_config {
 			u8  sca_reg_tolm_width;
 			u32 sca_reg_tohm_offset;
 			u8  sca_reg_tohm_width;
+			u64 ha_base;
+			u32 ha_size;
+			u32 ha_reg_mode_offset;
+			u8  ha_reg_mode_width;
 		};
 	};
 };
-- 
2.43.0


