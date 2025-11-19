Return-Path: <linux-edac+bounces-5470-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C1BC6F27B
	for <lists+linux-edac@lfdr.de>; Wed, 19 Nov 2025 15:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A2FF54FD49B
	for <lists+linux-edac@lfdr.de>; Wed, 19 Nov 2025 13:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111B83624BA;
	Wed, 19 Nov 2025 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TqqUUoog"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF9B3557FE;
	Wed, 19 Nov 2025 13:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763560353; cv=none; b=JF6R5PreQBssm2D9v6S+F1Q4rzXu42avgxXewur3kNZfIhc1/xTlFH8SSpq9xn7yLJDefiKkRFwEDgUQCiKQqwnLWNsEDSvtEPknQqclCLXJ2tbyzgxY/0L3i59cWJEEOSyYB6mNoR8qSfiDVpu/ls/8Ia3g+jsLQ1P8+TCfD7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763560353; c=relaxed/simple;
	bh=R4Onzs3LFqMx8Ji7eJ85mAWSzM+DEaETYbbH1SleTeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sZfrOLuTe2nRaPsOxvjfAtlVuxjgJnmdZi0GEaOeG+ObUPx3zC0BNg2q7dU6vDWd+ioB9xgI7kjvW9MhLV37A283iFvEXbAI+1HlA6+YQ9CALCpIuu/jhhT4fZtp/dN6KVFnPxu37qq2SNxEbfMZS+G1mTS1/EV+uNpcUhIgwEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TqqUUoog; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763560352; x=1795096352;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R4Onzs3LFqMx8Ji7eJ85mAWSzM+DEaETYbbH1SleTeU=;
  b=TqqUUoogwlxUgVWZQEVB0UzRUU0PgNOBlCV9AH9OOvUXf5eTljZTevsc
   tqFJ5pyBgKntxJml31Z4Ob94DX/TFcOAzHwLdqQaJcIFRxfbVH63U+zAM
   xjntDuLiE/pWd5LPyWeLyejyCTuNg9TfYA5J5vZDPeTfX4CcPRl4/6Cc6
   5kkGhp915ru1JF4WjCbSlqfTRQtIo/p7rR01pNE+q8M9074jM+r8W9qwv
   7YeYow7qmzIyUeA28Tzi0QbO/pEk+R2WmwXDrZ60GvO22M/+TZep6PTwo
   hBBnqx8M27daq43xI1OQ1TbeC4jv4Zr67g56Fafjv9QX8CEOuFqfJmVAq
   A==;
X-CSE-ConnectionGUID: u5pM/HbnSL+1jJeaNm5Kig==
X-CSE-MsgGUID: TO8N0nMhQGeGZyXO9j3anw==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="64607322"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="64607322"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 05:52:31 -0800
X-CSE-ConnectionGUID: zPKS08OATZm6uKsq9UoZMA==
X-CSE-MsgGUID: ONeNFPCNQnu7c0naCvHMaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="214439506"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 05:52:29 -0800
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Yi Lai <yi1.lai@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] EDAC/skx_common: Prepare for skx_get_edac_list()
Date: Wed, 19 Nov 2025 21:41:26 +0800
Message-ID: <20251119134132.2389472-3-qiuxu.zhuo@intel.com>
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

The Intel EDAC library 'skx_common' maintains the Intel server EDAC device
list for {skx, i10nm}_edac drivers, which use skx_get_all_bus_mappings()
to build and retrieve the EDAC device list.

However, the upcoming Intel EDAC driver, imh_edac, for Diamond Rapids
servers is designed for memory controllers that are MMIO-based devices
rather than PCI devices. Consequently, it can't use
skx_get_all_bus_mappings() due to the absence of a PCI bus. To accommodate
this, prepare skx_get_edac_list() to enable the upcoming imh_edac driver
to obtain the EDAC device list from the skx_common library and build the
EDAC device list independently.

Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/skx_common.c | 6 ++++++
 drivers/edac/skx_common.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index cf58cb5951ab..6a1b30aa1ee6 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -384,6 +384,12 @@ int skx_get_all_bus_mappings(struct res_config *cfg, struct list_head **list)
 }
 EXPORT_SYMBOL_GPL(skx_get_all_bus_mappings);
 
+struct list_head *skx_get_edac_list(void)
+{
+	return &dev_edac_list;
+}
+EXPORT_SYMBOL_GPL(skx_get_edac_list);
+
 int skx_get_hi_lo(unsigned int did, int off[], u64 *tolm, u64 *tohm)
 {
 	struct pci_dev *pdev;
diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index 0be088f47587..52734091a79d 100644
--- a/drivers/edac/skx_common.h
+++ b/drivers/edac/skx_common.h
@@ -293,6 +293,8 @@ int skx_get_src_id(struct skx_dev *d, int off, u8 *id);
 
 int skx_get_all_bus_mappings(struct res_config *cfg, struct list_head **list);
 
+struct list_head *skx_get_edac_list(void);
+
 int skx_get_hi_lo(unsigned int did, int off[], u64 *tolm, u64 *tohm);
 
 int skx_get_dimm_info(u32 mtr, u32 mcmtr, u32 amap, struct dimm_info *dimm,
-- 
2.43.0


