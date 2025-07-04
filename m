Return-Path: <linux-edac+bounces-4313-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14931AF8BC9
	for <lists+linux-edac@lfdr.de>; Fri,  4 Jul 2025 10:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FD3F762B5D
	for <lists+linux-edac@lfdr.de>; Fri,  4 Jul 2025 08:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271D22EA15F;
	Fri,  4 Jul 2025 07:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V4EuBuNB"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AC02E6122;
	Fri,  4 Jul 2025 07:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751615685; cv=none; b=sQkF9SXASpo3cx8pw1SUsPznGEAbWyJGCZD1q/OzMJ2SXckG1isaRcLmDlfOBxJk7dQhijTc0MN4vMDOG2nsOWE8V+FxKrk2T8i42TdnlcAUGifIYMEoAAWutvplBtxif825QkKsOm9KOs/BgEIraNwS7ExYWf+kqYuID2oxZJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751615685; c=relaxed/simple;
	bh=b0C3UNB2dTcxpMxJCVwNrXIVV0k0Pl+FY3tJp3Vlkr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXd3Gk/bDPIv+1jcl+qX9BVJd3N1EtUqfljz00ZIUDXLpQrZK4jqaDlqRsZfgftPuBk2gLI2zke/nw4tigvslRPPROwhGxLYUgsQ2+a8LE9uD4nZE07dm+BQ4DtA2hye+eETyJXJOYL/owhR/0rE9lqw7XJU4B4qmOL4h7syIO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V4EuBuNB; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751615684; x=1783151684;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b0C3UNB2dTcxpMxJCVwNrXIVV0k0Pl+FY3tJp3Vlkr0=;
  b=V4EuBuNBLN8wda+p6F5T3D3W3aBM8tvSNV6oB6ufuGitSQxrIcehHyX+
   X0d1rFnI2Z7RHTc0YkVrLc/CFT6CceUQbD5T0hkenpNds3bDwIH4qv85g
   thQpv8nYvbWYHRchZiLokiQX8X4+/kMMXzEIa6ohjgIYpS+BStarxoWYY
   fxkXRn+1NUL+LKzR+D2p11J1Ak53/WqyzPP62HPY/8FWCg9utYT7dU/dM
   R89i0B211WESiKVT207H2McKHtppZd455xVTpEPhj7L8tTEwKFooX+IMU
   otEYrVIpnTBV45GSr9PHkSrWhFLBTcvdIoFFrHcq7vZm0xIn9MQ7ddGDY
   Q==;
X-CSE-ConnectionGUID: mZf86BatRIefkC30p90Kwg==
X-CSE-MsgGUID: 7PPIePUQRuKwCgDCrdW1ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="57621157"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="57621157"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:43 -0700
X-CSE-ConnectionGUID: If/1wdNKQx+vexxxA3uzaA==
X-CSE-MsgGUID: XCHaFuSMTNqs5WSHg7I5KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="154664052"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:40 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Lili Li <lili.li@intel.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Laurens SEGHERS <laurens@rale.com>,
	VikasX Chougule <vikasx.chougule@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] EDAC/igen6: Add Intel Wildcat Lake SoCs support
Date: Fri,  4 Jul 2025 23:16:08 +0800
Message-ID: <20250704151609.7833-3-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704151609.7833-1-qiuxu.zhuo@intel.com>
References: <20250704151609.7833-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lili Li <lili.li@intel.com>

Intel Wildcat Lake is a mobile derivative of Panther Lake with one
memory controller. Wildcat Lake SoCs share the same IBECC registers
with Meteor Lake-P SoCs.

Add a compute die ID and a new configuration structure for Wildcat
Lake SoCs with In-Band ECC capability for EDAC support.

Signed-off-by: Lili Li <lili.li@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/igen6_edac.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index 5ffe9579959f..2fc59f9eed69 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -275,6 +275,9 @@ static struct work_struct ecclog_work;
 #define DID_PTL_H_SKU2	0xb001
 #define DID_PTL_H_SKU3	0xb002
 
+/* Compute die IDs for Wildcat Lake with IBECC */
+#define DID_WCL_SKU1	0xfd00
+
 static int get_mchbar(struct pci_dev *pdev, u64 *mchbar)
 {
 	union  {
@@ -569,6 +572,17 @@ static struct res_config mtl_p_cfg = {
 	.err_addr_to_imc_addr	= adl_err_addr_to_imc_addr,
 };
 
+static struct res_config wcl_cfg = {
+	.machine_check		= true,
+	.num_imc		= 1,
+	.imc_base		= 0xd800,
+	.ibecc_base		= 0xd400,
+	.ibecc_error_log_offset	= 0x170,
+	.ibecc_available	= mtl_p_ibecc_available,
+	.err_addr_to_sys_addr	= adl_err_addr_to_sys_addr,
+	.err_addr_to_imc_addr	= adl_err_addr_to_imc_addr,
+};
+
 static struct pci_device_id igen6_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, DID_EHL_SKU5), (kernel_ulong_t)&ehl_cfg },
 	{ PCI_VDEVICE(INTEL, DID_EHL_SKU6), (kernel_ulong_t)&ehl_cfg },
@@ -622,6 +636,7 @@ static struct pci_device_id igen6_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, DID_PTL_H_SKU1), (kernel_ulong_t)&mtl_p_cfg },
 	{ PCI_VDEVICE(INTEL, DID_PTL_H_SKU2), (kernel_ulong_t)&mtl_p_cfg },
 	{ PCI_VDEVICE(INTEL, DID_PTL_H_SKU3), (kernel_ulong_t)&mtl_p_cfg },
+	{ PCI_VDEVICE(INTEL, DID_WCL_SKU1), (kernel_ulong_t)&wcl_cfg },
 	{ },
 };
 MODULE_DEVICE_TABLE(pci, igen6_pci_tbl);
-- 
2.43.0


