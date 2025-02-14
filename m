Return-Path: <linux-edac+bounces-3083-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71676A35303
	for <lists+linux-edac@lfdr.de>; Fri, 14 Feb 2025 01:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0F237A1CAA
	for <lists+linux-edac@lfdr.de>; Fri, 14 Feb 2025 00:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9288E1362;
	Fri, 14 Feb 2025 00:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MjJElKox"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30498C1E;
	Fri, 14 Feb 2025 00:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739493400; cv=none; b=sVEROslMClbcDpvZgnQBg3kXwR3LdsGGKqkoC2l1qHz+Bao+VXNRELZ4YtA/GgdCdi4CGF4dbr+JoDEdUM6uiKyeUk4/cwhN8ZfE1tHvVRe0GmFljeXqQCFCkOpTWYPy51CeuXqLmWRWWrRBnuuyoVlDQE3W9yqmCUGzm25B6tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739493400; c=relaxed/simple;
	bh=kjlznG2D4gTQ1jGzO20AzuJ/CD7MgJE2quqCzxYI9CM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=t9MbzZ3dkdI3xPKb0kPTNiL0BaQGAwahLJLjQwLk9JpwvloAluzyt5BskA/+umhyghYYcMvUeBY9cS9CF8+6C6UVC15dHJdkyx2A1PuYRlaooelCfgkdvB4IO99qgsnXw9XsESxmTxf6/cNsI0uN6VHZinz2zYDP+2aLFIsRqt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MjJElKox; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739493399; x=1771029399;
  h=from:to:cc:subject:date:message-id;
  bh=kjlznG2D4gTQ1jGzO20AzuJ/CD7MgJE2quqCzxYI9CM=;
  b=MjJElKoxy2Ohr0e8QzzZkQu9j8eHM/OrDtwcRJJQq7tA5BTmRcouO6dB
   PFt9j8rHFzT1VTs+1f7GyjtBxpDXBxNiSfXZ6b18uI7X2UxPOQPehhAhE
   czSXggJbQ7ldq+SUdhEGG/9yYAsku2p6ZqoDT/PVmOmf+HojIgPSjPKD7
   /i4QuYkjYRLCT8dlM6ObpE3+ESxPQ0ntGV7b2I25cgsU1jbmyJoTeyO46
   aPSTVJdj+hHqTTWaVzKQmZHC67LApoqCBZUjLWXgK+zIoQVQuhrh0MfCX
   SC9xPd7MtyJLOloWtiM6dGKu0lg8vVJM2WDLTGmIUtxh7qeo/VvPM2Qx4
   A==;
X-CSE-ConnectionGUID: zIZyohxJQGCPqm1fffErJg==
X-CSE-MsgGUID: mK2j7NJoTCK0rZ4jmiAvSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40348450"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="40348450"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 16:36:38 -0800
X-CSE-ConnectionGUID: gBsajGR4ROCL9/FjiV5W4g==
X-CSE-MsgGUID: OHUF5LraR1GvWvTdEhjlhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118513232"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 16:36:35 -0800
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Kevin Chang <kevin1.chang@intel.com>,
	Thomas Chen <Thomas.Chen@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] EDAC/{skx_common,i10nm}: Fix some missing error reports on Emerald Rapids
Date: Fri, 14 Feb 2025 08:27:28 +0800
Message-Id: <20250214002728.6287-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

When doing error injection to some memory DIMMs on certain Intel Emerald
Rapids servers, the i10nm_edac missed error reports for some memory DIMMs.

Certain BIOS configurations may hide some memory controllers, and the
i10nm_edac doesn't enumerate these hidden memory controllers. However, the
ADXL decodes memory errors using memory controller physical indices even
if there are hidden memory controllers. Therefore, the memory controller
physical indices reported by the ADXL may mismatch the logical indices
enumerated by the i10nm_edac, resulting in missed error reports for some
memory DIMMs.

Fix this issue by creating a mapping table from memory controller physical
indices (used by the ADXL) to logical indices (used by the i10nm_edac) and
using it to convert the physical indices to the logical indices during the
error handling process.

Fixes: c545f5e41225 ("EDAC/i10nm: Skip the absent memory controllers")
Reported-by: Kevin Chang <kevin1.chang@intel.com>
Tested-by: Kevin Chang <kevin1.chang@intel.com>
Reported-by: Thomas Chen <Thomas.Chen@intel.com>
Tested-by: Thomas Chen <Thomas.Chen@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/i10nm_base.c |  2 ++
 drivers/edac/skx_common.c | 33 +++++++++++++++++++++++++++++++++
 drivers/edac/skx_common.h | 11 +++++++++++
 3 files changed, 46 insertions(+)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index f45d849d3f15..355a977019e9 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -751,6 +751,8 @@ static int i10nm_get_ddr_munits(void)
 				continue;
 			} else {
 				d->imc[lmc].mdev = mdev;
+				if (res_cfg->type == SPR)
+					skx_set_mc_mapping(d, i, lmc);
 				lmc++;
 			}
 		}
diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index f7bd930e058f..fa5b442b1844 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -121,6 +121,35 @@ void skx_adxl_put(void)
 }
 EXPORT_SYMBOL_GPL(skx_adxl_put);
 
+static void skx_init_mc_mapping(struct skx_dev *d)
+{
+	/*
+	 * By default, the BIOS presents all memory controllers within each
+	 * socket to the EDAC driver. The physical indices are the same as
+	 * the logical indices of the memory controllers enumerated by the
+	 * EDAC driver.
+	 */
+	for (int i = 0; i < NUM_IMC; i++)
+		d->mc_mapping[i] = i;
+}
+
+void skx_set_mc_mapping(struct skx_dev *d, u8 pmc, u8 lmc)
+{
+	edac_dbg(0, "Set the mapping of mc phy idx to logical idx: %02d -> %02d\n",
+		 pmc, lmc);
+
+	d->mc_mapping[pmc] = lmc;
+}
+EXPORT_SYMBOL_GPL(skx_set_mc_mapping);
+
+static u8 skx_get_mc_mapping(struct skx_dev *d, u8 pmc)
+{
+	edac_dbg(0, "Get the mapping of mc phy idx to logical idx: %02d -> %02d\n",
+		 pmc, d->mc_mapping[pmc]);
+
+	return d->mc_mapping[pmc];
+}
+
 static bool skx_adxl_decode(struct decoded_addr *res, enum error_source err_src)
 {
 	struct skx_dev *d;
@@ -188,6 +217,8 @@ static bool skx_adxl_decode(struct decoded_addr *res, enum error_source err_src)
 		return false;
 	}
 
+	res->imc = skx_get_mc_mapping(d, res->imc);
+
 	for (i = 0; i < adxl_component_count; i++) {
 		if (adxl_values[i] == ~0x0ull)
 			continue;
@@ -326,6 +357,8 @@ int skx_get_all_bus_mappings(struct res_config *cfg, struct list_head **list)
 			 d->bus[0], d->bus[1], d->bus[2], d->bus[3]);
 		list_add_tail(&d->list, &dev_edac_list);
 		prev = pdev;
+
+		skx_init_mc_mapping(d);
 	}
 
 	if (list)
diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index b0845bdd4516..ca5408803f87 100644
--- a/drivers/edac/skx_common.h
+++ b/drivers/edac/skx_common.h
@@ -93,6 +93,16 @@ struct skx_dev {
 	struct pci_dev *uracu; /* for i10nm CPU */
 	struct pci_dev *pcu_cr3; /* for HBM memory detection */
 	u32 mcroute;
+	/*
+	 * Some server BIOS may hide certain memory controllers, and the
+	 * EDAC driver skips those hidden memory controllers. However, the
+	 * ADXL still decodes memory error address using physical memory
+	 * controller indices. The mapping table is used to convert the
+	 * physical indices (reported by ADXL) to the logical indices
+	 * (used the EDAC driver) of present memory controllers during the
+	 * error handling process.
+	 */
+	u8 mc_mapping[NUM_IMC];
 	struct skx_imc {
 		struct mem_ctl_info *mci;
 		struct pci_dev *mdev; /* for i10nm CPU */
@@ -242,6 +252,7 @@ void skx_adxl_put(void);
 void skx_set_decode(skx_decode_f decode, skx_show_retry_log_f show_retry_log);
 void skx_set_mem_cfg(bool mem_cfg_2lm);
 void skx_set_res_cfg(struct res_config *cfg);
+void skx_set_mc_mapping(struct skx_dev *d, u8 pmc, u8 lmc);
 
 int skx_get_src_id(struct skx_dev *d, int off, u8 *id);
 
-- 
2.17.1


