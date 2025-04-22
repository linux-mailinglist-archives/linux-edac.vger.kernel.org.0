Return-Path: <linux-edac+bounces-3642-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41293A96D47
	for <lists+linux-edac@lfdr.de>; Tue, 22 Apr 2025 15:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF2D97A2030
	for <lists+linux-edac@lfdr.de>; Tue, 22 Apr 2025 13:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809DF27CCF3;
	Tue, 22 Apr 2025 13:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kkr2LAPZ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171394C85;
	Tue, 22 Apr 2025 13:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745329558; cv=none; b=ChZ5B5TQbA8x5jMJt56rhEgLb2yztUItZbMSYi/7Rf+WC8IQjEMc6NFLch8YfURbi3GFVr/kYwyxKnko5JSCZzNUbcjplsbfy82cZ6UHWPPMst/YTO7Qn7kKnZ+TANdb4tJByB/JRmwXPjCewxzFQ6Y6v6+1C/O6PAaKPmaFT+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745329558; c=relaxed/simple;
	bh=jIOq4QvOdlHSw26DEIMRQ/KisyqK6PA8sRT/Pyqybrs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SCgYqwKxYyj6A6ud11CdGz0sgtFsP1UQTSSkg3Nrp4tlt0JEFQwYnDR3ZNFJDrYp7sXR4G0tb4Z9YevIWuW2uk7waRS7Cjayar9dJhIGPrWGjjwty5XLOsEoAaDbuaZrcV8cbKhcWw9+mtEQvBw8L2nd3yRqoSKpvE/1aV5Nk/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kkr2LAPZ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745329556; x=1776865556;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jIOq4QvOdlHSw26DEIMRQ/KisyqK6PA8sRT/Pyqybrs=;
  b=kkr2LAPZDSeo4k6Z/OajHdH4oQR7L82oRH4sV41U9oxEsOzbtVhJXQ3t
   N52KpIjiSpf5Lt9aSke4WeKlamFPKxIWfpz1qP6Wi5SAmhMJ4V5yUuyTe
   Dktovt1q6SLveuq4lJiGZhtXgj7CV45d6MbXrlMf8m9gUXX0BJ5kx+6oK
   dbX4bCOE+CS8ENSKW6m4nt0AH3lEBHz7PPHadPj989+LVbCv32NWH40fd
   HqEpnHBeQT8mJmUHVhqgfoW/8zTwCSPKl2sZwHyfWfbA0+j4CN8Pd/HeR
   SledSl0Fxotbap137/q8y343Oopjk6MF1hWoQuTIaPfzV7aOXMTFIsn0F
   Q==;
X-CSE-ConnectionGUID: DpE8WdeTQ1Kqqc/RzYO8FQ==
X-CSE-MsgGUID: HtMF6/YpTICht6sY6H1ggw==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="49551228"
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="49551228"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 06:45:55 -0700
X-CSE-ConnectionGUID: sSKjILpCQDmtG85Sar3PhQ==
X-CSE-MsgGUID: gVNrwwuyQ7C/OQ+sBn6pJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="131867441"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 06:45:53 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Jason Baron <jbaron@akamai.com>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	James Jernigan <jameswestonjernigan@gmail.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Yi Lai <yi1.lai@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] EDAC/ie31200: Add two Intel SoCs for EDAC support
Date: Tue, 22 Apr 2025 21:44:50 +0800
Message-ID: <20250422134450.1880648-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add two compute die IDs for Raptor Lake-S and Alder Lake-S for EDAC
support. Note that because Alder Lake-S shares the same memory controller
registers as Raptor Lake-S, it can reuse the configuration data of Raptor
Lake-S for EDAC support.

Tested-by: James Jernigan <jameswestonjernigan@gmail.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/ie31200_edac.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index 204834149579..55cf54741aa0 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -89,6 +89,10 @@
 #define PCI_DEVICE_ID_INTEL_IE31200_RPL_S_1	0xa703
 #define PCI_DEVICE_ID_INTEL_IE31200_RPL_S_2	0x4640
 #define PCI_DEVICE_ID_INTEL_IE31200_RPL_S_3	0x4630
+#define PCI_DEVICE_ID_INTEL_IE31200_RPL_S_4	0xa700
+
+/* Alder Lake-S */
+#define PCI_DEVICE_ID_INTEL_IE31200_ADL_S_1	0x4660
 
 #define IE31200_RANKS_PER_CHANNEL	8
 #define IE31200_DIMMS_PER_CHANNEL	2
@@ -734,6 +738,8 @@ static const struct pci_device_id ie31200_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_RPL_S_1), (kernel_ulong_t)&rpl_s_cfg},
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_RPL_S_2), (kernel_ulong_t)&rpl_s_cfg},
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_RPL_S_3), (kernel_ulong_t)&rpl_s_cfg},
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_RPL_S_4), (kernel_ulong_t)&rpl_s_cfg},
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_ADL_S_1), (kernel_ulong_t)&rpl_s_cfg},
 	{ 0, } /* 0 terminated list. */
 };
 MODULE_DEVICE_TABLE(pci, ie31200_pci_tbl);
-- 
2.43.0


