Return-Path: <linux-edac+bounces-5522-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E77C80B34
	for <lists+linux-edac@lfdr.de>; Mon, 24 Nov 2025 14:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 84B444E14C0
	for <lists+linux-edac@lfdr.de>; Mon, 24 Nov 2025 13:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074252AE77;
	Mon, 24 Nov 2025 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T/sbVFmH"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECE31A275;
	Mon, 24 Nov 2025 13:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763990291; cv=none; b=SdUBc0OCPILT+6VVSZ20sj+/+8jT0abSg/CqOU7O6e6Kn02Irg5TFbLaA4n5U0Mahmqdh5rYQucq18OyeMLonI1UDsnJs8wUVfbEKfK3C1tnvgqLBinWJNbk8Sd0tD5WHUoPLUMPGzUfdutxh26cJ6tIpYIb2p8WQEevND6trpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763990291; c=relaxed/simple;
	bh=nBYKyiMfppgNO0pmFiZpQllCR+r8ub67r9x8fDaqMsc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UlyhgJWcE608q94ahIpmh16hTKbl0DhvGVaOoJtjXWCxE1H2YQUA1B5AcF36RaOpWI8ecgDkjvcTxHjEIboqYqnzGVHzy53NA0GBpIlUxaHHJMufKIyEkeMl+W/dSb/IjRB6v3NYscQO5Uvt59LULOtiQ4+qLovzNQfKuEugXno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T/sbVFmH; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763990290; x=1795526290;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nBYKyiMfppgNO0pmFiZpQllCR+r8ub67r9x8fDaqMsc=;
  b=T/sbVFmHZVDYuKG3jcJ15t0gherBGl0vo/bOvTSL0SAGXsC5FQ4exyER
   Ofcx1pWfs5Ska6u0GI136E9f1uIPFr33PaM+furule5dVi75pQeZGlq/r
   wt6qX+aSzBifhVwdb45Jz1qDBSCQ0/7tu2BPxNR1gxTd6FwHj1l8A1z+j
   gEw3Z5hlSu/kf4uiHlaz+9k+reASSyV4PD66E0SYsYrzkyw051zQXZKNf
   SyKgOerjjaox3XEEWnoR0AZA9WfXFGezJOMvhy/8m3L0+xGXcx76VUf6i
   uSMLRyiD/4D31yUSVsaad2j+ZM+VgOp0p+GGkKe/ZgEDB6Ra3Nvz11/7L
   w==;
X-CSE-ConnectionGUID: T8e05FHWT++Jp1ob/LzftQ==
X-CSE-MsgGUID: Affjwd+rQvW596A5qKsGBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="76314174"
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="76314174"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 05:18:09 -0800
X-CSE-ConnectionGUID: AS2EoJ7WQCGtmfutxe9EMA==
X-CSE-MsgGUID: cyQP8hWyQU2bh1PU0DnNIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="192431958"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 05:18:08 -0800
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Lili Li <lili.li@intel.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Yi Lai <yi1.lai@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] EDAC/igen6: Add more Intel Panther Lake-H SoCs support
Date: Mon, 24 Nov 2025 21:15:37 +0800
Message-ID: <20251124131537.3633983-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lili Li <lili.li@intel.com>

Add more Intel Panther Lake-H SoC compute die IDs for EDAC support.

Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Lili Li <lili.li@intel.com>
---
 drivers/edac/igen6_edac.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index db4aa9f581e3..6d5652d67b08 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -283,6 +283,16 @@ static struct work_struct ecclog_work;
 #define DID_PTL_H_SKU1	0xb000
 #define DID_PTL_H_SKU2	0xb001
 #define DID_PTL_H_SKU3	0xb002
+#define DID_PTL_H_SKU4	0xb003
+#define DID_PTL_H_SKU5	0xb004
+#define DID_PTL_H_SKU6	0xb005
+#define DID_PTL_H_SKU7	0xb008
+#define DID_PTL_H_SKU8	0xb011
+#define DID_PTL_H_SKU9	0xb014
+#define DID_PTL_H_SKU10	0xb015
+#define DID_PTL_H_SKU11	0xb028
+#define DID_PTL_H_SKU12	0xb029
+#define DID_PTL_H_SKU13	0xb02a
 
 /* Compute die IDs for Wildcat Lake with IBECC */
 #define DID_WCL_SKU1	0xfd00
@@ -684,6 +694,16 @@ static struct pci_device_id igen6_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, DID_PTL_H_SKU1), (kernel_ulong_t)&mtl_p_cfg },
 	{ PCI_VDEVICE(INTEL, DID_PTL_H_SKU2), (kernel_ulong_t)&mtl_p_cfg },
 	{ PCI_VDEVICE(INTEL, DID_PTL_H_SKU3), (kernel_ulong_t)&mtl_p_cfg },
+	{ PCI_VDEVICE(INTEL, DID_PTL_H_SKU4), (kernel_ulong_t)&mtl_p_cfg },
+	{ PCI_VDEVICE(INTEL, DID_PTL_H_SKU5), (kernel_ulong_t)&mtl_p_cfg },
+	{ PCI_VDEVICE(INTEL, DID_PTL_H_SKU6), (kernel_ulong_t)&mtl_p_cfg },
+	{ PCI_VDEVICE(INTEL, DID_PTL_H_SKU7), (kernel_ulong_t)&mtl_p_cfg },
+	{ PCI_VDEVICE(INTEL, DID_PTL_H_SKU8), (kernel_ulong_t)&mtl_p_cfg },
+	{ PCI_VDEVICE(INTEL, DID_PTL_H_SKU9), (kernel_ulong_t)&mtl_p_cfg },
+	{ PCI_VDEVICE(INTEL, DID_PTL_H_SKU10), (kernel_ulong_t)&mtl_p_cfg },
+	{ PCI_VDEVICE(INTEL, DID_PTL_H_SKU11), (kernel_ulong_t)&mtl_p_cfg },
+	{ PCI_VDEVICE(INTEL, DID_PTL_H_SKU12), (kernel_ulong_t)&mtl_p_cfg },
+	{ PCI_VDEVICE(INTEL, DID_PTL_H_SKU13), (kernel_ulong_t)&mtl_p_cfg },
 	{ PCI_VDEVICE(INTEL, DID_WCL_SKU1), (kernel_ulong_t)&wcl_cfg },
 	{ },
 };
-- 
2.43.0


