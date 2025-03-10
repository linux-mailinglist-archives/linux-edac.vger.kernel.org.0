Return-Path: <linux-edac+bounces-3327-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0033A58A00
	for <lists+linux-edac@lfdr.de>; Mon, 10 Mar 2025 02:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D6B9188C882
	for <lists+linux-edac@lfdr.de>; Mon, 10 Mar 2025 01:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DE214A0BC;
	Mon, 10 Mar 2025 01:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d7hfoQ+R"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E74914A098;
	Mon, 10 Mar 2025 01:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741570144; cv=none; b=mo4Ik4fBPa8jJWONuhN6KvoQZOn2SJnQjB79mBd041pgJ0elQqp1NiIJ08Ig6D9LeQvRfqPzS2WezgTUXgO40Gu5o3ga4Fl58y910veyjXhRrBNzcb3QMGzInr3JIzLhxUYDuJeZvb5bo9U+z2Gx3P/K1De1KQx/H9pFyU8RipU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741570144; c=relaxed/simple;
	bh=jST+CAkMJaE+g4Yh4Uo6TqgzKlns8eutGQHcovr48r8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=rykK9G3CtZRixNhkBgqo11oarfc+5am5M7J97iznHiaE3sq0p9chPjvGalQiDDKqAsklIpZ5e/X1jTDl7xnE3KWtEqbeFRdFrNYAbCwVYM01m/uyRkKWWb0kswVr+VyGTeP2zo1jtp9LekgY2uP9AP0r1ZiUJcAxCiFBNh/GA2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d7hfoQ+R; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741570143; x=1773106143;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=jST+CAkMJaE+g4Yh4Uo6TqgzKlns8eutGQHcovr48r8=;
  b=d7hfoQ+RyaVfQYxMG5wEeg5jVKC2lPFcPpxO668jWWdg6rtXQIM4RcgD
   8hFDHn4T9EbG3qG4kIhkRKQiuDF5C4D6NuXvUfB9i0b6Uo1xkUKsHInvp
   nWQtipseLULSPIVPjJ2WquSCe1MTpSRgGbNZM//bJ/VQSJgWnLzwW3Prk
   ydTSgs1stWc5tGYbRzpuUcPECB8IRpq1I+zkDEAT+VHCOozNfyusK/AZc
   blyWjU1aJOhT+etplEg60TYp2gKwAhHTi9h14FXGckHE5yAHOVvyySMXa
   ghfwLA46HFWcxun0AmuPbi7g1YIu2ae10ODbKxdZ8qd56tYIViW8721XC
   w==;
X-CSE-ConnectionGUID: uGQKtpToTzSQaEIpsdt0uA==
X-CSE-MsgGUID: 6wamp6iHSg2GbOcr7fGWcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="67914582"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="67914582"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 18:29:03 -0700
X-CSE-ConnectionGUID: oRkbitZQS1OkWxlkiIa0cg==
X-CSE-MsgGUID: RVxcgI/iQYq4SsqIvOB0gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="124925546"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 18:29:00 -0700
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
Subject: [PATCH v2 05/11] EDAC/ie31200: Simplify the pci_device_id table
Date: Mon, 10 Mar 2025 09:14:05 +0800
Message-Id: <20250310011411.31685-6-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250310011411.31685-1-qiuxu.zhuo@intel.com>
References: <20250226015202.36576-1-qiuxu.zhuo@intel.com>
 <20250310011411.31685-1-qiuxu.zhuo@intel.com>
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


