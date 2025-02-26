Return-Path: <linux-edac+bounces-3207-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A23EA452AF
	for <lists+linux-edac@lfdr.de>; Wed, 26 Feb 2025 03:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ACBE167BA7
	for <lists+linux-edac@lfdr.de>; Wed, 26 Feb 2025 02:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3641FFC44;
	Wed, 26 Feb 2025 02:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SIuU4Giz"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119BD18FDDF;
	Wed, 26 Feb 2025 02:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740535522; cv=none; b=n0eBRTLshcPrt1M1E07ak9xdwfa9e6lbW0RYQI1XKcpsMnJx/aUFZ+GJloDGDnKSnSoMJOEOrdT+rD/4GLhBbQzTs321obi4CGCgQiyGqZOx2IDogWu/1vNxarVJjsUYgnkDI/6GVsBwUi2W2G6rAwDNrzhV1H3ue50RpAeLMQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740535522; c=relaxed/simple;
	bh=jST+CAkMJaE+g4Yh4Uo6TqgzKlns8eutGQHcovr48r8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=TfR6D9BuJBqu/9nEcomXhX9fz5/EJf+jhPXSyCuaRRSIiTURmzRwZ5pMPbEpwlQeMBW5jAmMWKc1vHVfPEicCIhJJs5PIy69RPKeGtmtpNZR92pfCHg141j47CxQp2zonUp/9IQXn16kPiwN/5LMoC5HbeP2vLyEDT94QHHog2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SIuU4Giz; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740535521; x=1772071521;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=jST+CAkMJaE+g4Yh4Uo6TqgzKlns8eutGQHcovr48r8=;
  b=SIuU4GizbPxIXnW0OooR19eyPF+WKv2wM0t7bGkO9aN4DlXAobEy179A
   W3CSPKM3sw2RHIwsrByBKRuRA2mtWfq50BjXqraKRbl32kckYMiI+jrDx
   vfTPdCqtqpDXR1DvaaEWPfgWIOdxQFWLvgt/93cKrhFp3pzW9la41Ja+G
   QFyKU2+sETVJVHvmMj/rJzRG3HnpOpO/aN0RZRrM+b+C1KiP+ntRk9SRL
   HG76fjcnOrQufQUA2BFOKoGCnyiz7rXe/re15OlogsYCwW2ToC+KgFydU
   uJvzYauXub9T8A+5gzYyV04mZuOvWYCBFzIJWdFX3/Fgla+dC/j/i8kG6
   A==;
X-CSE-ConnectionGUID: 53D91IKiSEGUjPWwVKWR8A==
X-CSE-MsgGUID: biT1fWPIRhePqULiGIdBCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="28959811"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="28959811"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 18:05:20 -0800
X-CSE-ConnectionGUID: uZ0bnLrmRXmORNtr3hU1iQ==
X-CSE-MsgGUID: dDTSHQL8Q56NMXZY5a/KEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="121180393"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 18:05:18 -0800
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Jason Baron <jbaron@akamai.com>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Gary Wang <gary.c.wang@intel.com>,
	Yi Lai <yi1.lai@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] EDAC/ie31200: Simplify the pci_device_id table
Date: Wed, 26 Feb 2025 09:51:56 +0800
Message-Id: <20250226015202.36576-6-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226015202.36576-1-qiuxu.zhuo@intel.com>
References: <20250226015202.36576-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

Use PCI_VDEVICE() to simplify the pci_device_id table.

No functional changes intended.

Tested-by: Gary Wang <gary.c.wang@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/ie31200_edac.c | 44 ++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index 35f4e8e46ca2..4e1f85dc1679 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -576,28 +576,28 @@ static void ie31200_remove_one(struct pci_dev *pdev)
 }
 
 static const struct pci_device_id ie31200_pci_tbl[] = {
-	{ PCI_VEND_DEV(INTEL, IE31200_HB_1),      PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
-	{ PCI_VEND_DEV(INTEL, IE31200_HB_2),      PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
-	{ PCI_VEND_DEV(INTEL, IE31200_HB_3),      PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
-	{ PCI_VEND_DEV(INTEL, IE31200_HB_4),      PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
-	{ PCI_VEND_DEV(INTEL, IE31200_HB_5),      PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
-	{ PCI_VEND_DEV(INTEL, IE31200_HB_6),      PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
-	{ PCI_VEND_DEV(INTEL, IE31200_HB_7),      PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
-	{ PCI_VEND_DEV(INTEL, IE31200_HB_8),      PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
-	{ PCI_VEND_DEV(INTEL, IE31200_HB_9),      PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
-	{ PCI_VEND_DEV(INTEL, IE31200_HB_10),     PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
-	{ PCI_VEND_DEV(INTEL, IE31200_HB_11),     PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
-	{ PCI_VEND_DEV(INTEL, IE31200_HB_12),     PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
-	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_1),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
-	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_2),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
-	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_3),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
-	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_4),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
-	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_5),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
-	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_6),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
-	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_7),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
-	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_8),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
-	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_9),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
-	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_10), PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_1), IE31200 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_2), IE31200 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_3), IE31200 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_4), IE31200 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_5), IE31200 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_6), IE31200 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_7), IE31200 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_8), IE31200 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_9), IE31200 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_10), IE31200 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_11), IE31200 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_12), IE31200 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_1), IE31200 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_2), IE31200 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_3), IE31200 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_4), IE31200 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_5), IE31200 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_6), IE31200 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_7), IE31200 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_8), IE31200 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_9), IE31200 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_10), IE31200 },
 	{ 0, } /* 0 terminated list. */
 };
 MODULE_DEVICE_TABLE(pci, ie31200_pci_tbl);
-- 
2.17.1


