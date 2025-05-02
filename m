Return-Path: <linux-edac+bounces-3802-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB32AAA6870
	for <lists+linux-edac@lfdr.de>; Fri,  2 May 2025 03:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49CBA1BA3E1C
	for <lists+linux-edac@lfdr.de>; Fri,  2 May 2025 01:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695708635D;
	Fri,  2 May 2025 01:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RR6wK5c0"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D242626AD9;
	Fri,  2 May 2025 01:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746149981; cv=none; b=URJVc1/XRyUggVthtQ6tnS+JbzHIoBzYX7arfvY7RKEPxcZA/97P8zTk2V0/GzthlJ7EuisW/m/GxwCnH62ylRGbp+6h8q1M1epPuORh4SIPQSAoJHciKUW9iwgtI2Er0ih/2kRMUS8UVGN4N/NA0qRdgQXCobtk0OFwvxCyAjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746149981; c=relaxed/simple;
	bh=3zVuQw+HTDcea1hXOfP2Sl/+HBL4z+uYXaoaFlkXkSo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ClCVINsdh0RivXvBSjPqXaOwuthfenP2sfTPOxuq5KQTUhXD58RHo3e6ME9NZfWr/vunWXUswhYf+jkT3XPKfC6Y/rd8TJtQg68tmeG3uqVfvsacVYjLiZz1sfkhOxa66EDisFVI1abh5XqJC4UlA8yx8cgsoOpkNkNgRN96QCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RR6wK5c0; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746149980; x=1777685980;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3zVuQw+HTDcea1hXOfP2Sl/+HBL4z+uYXaoaFlkXkSo=;
  b=RR6wK5c0kWmUZKE5o4RO8qORmnCudeoTdHGMBweuy1S3nkSJuw3+dTAV
   AgHLbACdVfPfqbnhD6t/i3BzD8foQv4G/sxCwZDj2GBNmZkWSMcCm6MHf
   yr2ONZtj6wKCm/U3U08SCzwuvdhkMliWHGMLHl1eBiLScFsiJgvx35kO5
   YraBAd3XEXyNGRocXb3HlG6Da4m7RrpUhOX07g6wPrBAHTq4wyIotPHOR
   XP9GvQYexLYzUSzGaGu84AhsiTFR+iLOSD0rtlZaVjqFiOiqpB1ArBSIE
   gxxaoeN7A3xoTpOy56Aiue5OqfvIPXq+Rt1XMjqsPQ+j2cxLsaGfvfw7G
   Q==;
X-CSE-ConnectionGUID: JSyaFa8jQ46THra2kwIZaw==
X-CSE-MsgGUID: 2XKc5gL2SRq8pHjCoo8rHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="47716524"
X-IronPort-AV: E=Sophos;i="6.15,255,1739865600"; 
   d="scan'208";a="47716524"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 18:39:39 -0700
X-CSE-ConnectionGUID: iRlh85/DSx6/VwiNrNUPSw==
X-CSE-MsgGUID: cgw/mgtRQPeG8pg+iW7zEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,255,1739865600"; 
   d="scan'208";a="139672933"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 18:39:35 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Jason Baron <jbaron@akamai.com>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Yi Lai <yi1.lai@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] ie31200/EDAC: Add Intel Bartlett Lake-S SoCs support
Date: Fri,  2 May 2025 09:39:00 +0800
Message-ID: <20250502013900.343430-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bartlett Lake-S is a derivative of Raptor Lake-S and is optimized for
IoT/Edge applications. It shares the same memory controller registers
as Raptor Lake-S. Add compute die IDs of Bartlett Lake-S and reuse the
configuration data of Raptor Lake-S for Bartlett Lake-S EDAC support.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
This patch is on top of the RAS tree edac-for-next branch [1] with the
top commit [2].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac-for-next
[2] 4521b86e4a6e ("Merge ras/edac-urgent into for-next")

 drivers/edac/ie31200_edac.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index 55cf54741aa0..1ec00d458463 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -94,6 +94,18 @@
 /* Alder Lake-S */
 #define PCI_DEVICE_ID_INTEL_IE31200_ADL_S_1	0x4660
 
+/* Bartlett Lake-S */
+#define PCI_DEVICE_ID_INTEL_IE31200_BTL_S_1	0x4639
+#define PCI_DEVICE_ID_INTEL_IE31200_BTL_S_2	0x463c
+#define PCI_DEVICE_ID_INTEL_IE31200_BTL_S_3	0x4642
+#define PCI_DEVICE_ID_INTEL_IE31200_BTL_S_4	0x4643
+#define PCI_DEVICE_ID_INTEL_IE31200_BTL_S_5	0xa731
+#define PCI_DEVICE_ID_INTEL_IE31200_BTL_S_6	0xa732
+#define PCI_DEVICE_ID_INTEL_IE31200_BTL_S_7	0xa733
+#define PCI_DEVICE_ID_INTEL_IE31200_BTL_S_8	0xa741
+#define PCI_DEVICE_ID_INTEL_IE31200_BTL_S_9	0xa744
+#define PCI_DEVICE_ID_INTEL_IE31200_BTL_S_10	0xa745
+
 #define IE31200_RANKS_PER_CHANNEL	8
 #define IE31200_DIMMS_PER_CHANNEL	2
 #define IE31200_CHANNELS		2
@@ -740,6 +752,16 @@ static const struct pci_device_id ie31200_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_RPL_S_3), (kernel_ulong_t)&rpl_s_cfg},
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_RPL_S_4), (kernel_ulong_t)&rpl_s_cfg},
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_ADL_S_1), (kernel_ulong_t)&rpl_s_cfg},
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_BTL_S_1), (kernel_ulong_t)&rpl_s_cfg},
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_BTL_S_2), (kernel_ulong_t)&rpl_s_cfg},
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_BTL_S_3), (kernel_ulong_t)&rpl_s_cfg},
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_BTL_S_4), (kernel_ulong_t)&rpl_s_cfg},
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_BTL_S_5), (kernel_ulong_t)&rpl_s_cfg},
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_BTL_S_6), (kernel_ulong_t)&rpl_s_cfg},
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_BTL_S_7), (kernel_ulong_t)&rpl_s_cfg},
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_BTL_S_8), (kernel_ulong_t)&rpl_s_cfg},
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_BTL_S_9), (kernel_ulong_t)&rpl_s_cfg},
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_BTL_S_10), (kernel_ulong_t)&rpl_s_cfg},
 	{ 0, } /* 0 terminated list. */
 };
 MODULE_DEVICE_TABLE(pci, ie31200_pci_tbl);
-- 
2.43.0


