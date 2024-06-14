Return-Path: <linux-edac+bounces-1285-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 887A490824E
	for <lists+linux-edac@lfdr.de>; Fri, 14 Jun 2024 05:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04B352844FC
	for <lists+linux-edac@lfdr.de>; Fri, 14 Jun 2024 03:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CAE157E7D;
	Fri, 14 Jun 2024 03:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mXoppFcU"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD33619D880;
	Fri, 14 Jun 2024 03:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718334501; cv=none; b=YWvP1JUaQEmRUFSNkkDUOOx7wEe0O0PQl1bGbm4evIzl7VrZCCVwosVxKYjSd3JAHsPB5bZTqUUdEwXfVZExT/Bp0o6DPJKcep13ki244Lc2noayR5N7V3j+yIEigenHDdDWtsVmVMvfvN9aZmFaUtrNwWoc9djlElG3ScxRNUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718334501; c=relaxed/simple;
	bh=jZoKqNduJ5SaJerRXkWZiTOxBSPCWwWsZ1MKWUW5LFw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Qeuie3AsMxgU+9sXT98yrUekFjvUHZs+xHWJjNsOcag2N8ijAr4YBmXEul390xq+rl+lPFY7I2zH16CjhzEogZ0f27m6DM3TqY1seu1btmfhhavj7LPmCwnV0RvH/gQ092YziO8MdFgf36mQFpd40qADbiJ1Rk0NTZTrSXN7RMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mXoppFcU; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718334500; x=1749870500;
  h=from:to:cc:subject:date:message-id;
  bh=jZoKqNduJ5SaJerRXkWZiTOxBSPCWwWsZ1MKWUW5LFw=;
  b=mXoppFcU/Geyo29EH9l1BhZW97TxoFVj/D7DcCHYlGzxU/60m5VOficX
   YfTpb2q5EneGx3d2uatVw3m6noA4LZTi0rsRT4kdXn7VlTCHP/FRm88xT
   eSMoC0p3Ako5lQQ3oG98iw0Ml8s2qsKy4jNilP00fygEg3iHpjaTgW9Wp
   1MQVbPxiOC2Z4slypvMNP31Ojd+w2EP6w0CkSTDSP/S08GGpsswnOUDew
   T0+J5gIQOFGq9HOVyUHt7hwZVSaTFr/fDkvoEFDCzGXXqZgA7KYE1c3HU
   2Ln1uSCH/I8Jidz5G+asyynelHDKa30gDDJM4vrzE61m3ccz3F4vvmZgW
   w==;
X-CSE-ConnectionGUID: 9nsNSbz9Q4q4lbIM50WBig==
X-CSE-MsgGUID: sO8pvDVBTqqNo+gNVmZJtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="40616513"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="40616513"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 20:08:14 -0700
X-CSE-ConnectionGUID: LK/H5JbsQmqcjN8IpX4MSw==
X-CSE-MsgGUID: aCzzxsRXQnKUuKEDX/Fz9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="40327257"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 20:08:13 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Aristeu Rozanski <aris@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] EDAC/igen6: Add Intel Arrow Lake-U/H SoCs support
Date: Fri, 14 Jun 2024 11:03:54 +0800
Message-Id: <20240614030354.69180-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

Arrow Lake-U/H SoCs share same IBECC registers with Meteor Lake-P
SoCs. Add Arrow Lake-U/H SoC compute die IDs for EDAC support.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/igen6_edac.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index dbe9fe5f2ca6..0fe75eed8973 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -258,6 +258,11 @@ static struct work_struct ecclog_work;
 #define DID_MTL_P_SKU2	0x7d02
 #define DID_MTL_P_SKU3	0x7d14
 
+/* Compute die IDs for Arrow Lake-UH with IBECC */
+#define DID_ARL_UH_SKU1	0x7d06
+#define DID_ARL_UH_SKU2	0x7d20
+#define DID_ARL_UH_SKU3	0x7d30
+
 static int get_mchbar(struct pci_dev *pdev, u64 *mchbar)
 {
 	union  {
@@ -597,6 +602,9 @@ static const struct pci_device_id igen6_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, DID_MTL_P_SKU1), (kernel_ulong_t)&mtl_p_cfg },
 	{ PCI_VDEVICE(INTEL, DID_MTL_P_SKU2), (kernel_ulong_t)&mtl_p_cfg },
 	{ PCI_VDEVICE(INTEL, DID_MTL_P_SKU3), (kernel_ulong_t)&mtl_p_cfg },
+	{ PCI_VDEVICE(INTEL, DID_ARL_UH_SKU1), (kernel_ulong_t)&mtl_p_cfg },
+	{ PCI_VDEVICE(INTEL, DID_ARL_UH_SKU2), (kernel_ulong_t)&mtl_p_cfg },
+	{ PCI_VDEVICE(INTEL, DID_ARL_UH_SKU3), (kernel_ulong_t)&mtl_p_cfg },
 	{ },
 };
 MODULE_DEVICE_TABLE(pci, igen6_pci_tbl);
-- 
2.17.1


