Return-Path: <linux-edac+bounces-1545-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16069934651
	for <lists+linux-edac@lfdr.de>; Thu, 18 Jul 2024 04:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5FBC2834D4
	for <lists+linux-edac@lfdr.de>; Thu, 18 Jul 2024 02:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECE328DA0;
	Thu, 18 Jul 2024 02:23:18 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.priv.miraclelinux.com (202x210x215x66.ap202.ftth.ucom.ne.jp [202.210.215.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D957E18EBF
	for <linux-edac@vger.kernel.org>; Thu, 18 Jul 2024 02:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.210.215.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721269398; cv=none; b=OvHx2A2cNuHBvrDZQLiJjZlMN/jI/FGvqVzT87+i50X7JGhtaoCBTiXzSSnwPx8duymLxXVlIQeYQ48KwGnxkZUHrUkRJNq8Ttgkxh8sECafC0oR8guBi/1wkG7c2OXw54cFiG3hXuTkXs6OZ24ZJHbYDWFEYru0bZWAhZ6MB6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721269398; c=relaxed/simple;
	bh=mz1+xO42r5/Wfk3d5Ch3/1ahSjaZu3nEDi1/ZR9Q/QU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b26j4nv4JYuFv4eH/lIk2BAlFlFOvJ3U/M4ec3QljrfwomRy5xKQw6KQ0e7ZhiHN5oE3KmjzCR7TJUcXcNvw5jO/2eH7kfvg5nHLRJQGyNnvWNnDAs4ixwQ3flI3qOkIkJ30Rm4U4296fUM/5mJ753LI8k4U0VudVQtXQiFzTGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=miraclelinux.com; spf=pass smtp.mailfrom=miraclelinux.com; arc=none smtp.client-ip=202.210.215.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraclelinux.com
Received: from twakazono-desk.miraclelinux.com (twakazono-desk.priv.miraclelinux.com [10.2.1.181])
	by smtp.priv.miraclelinux.com (Postfix) with ESMTP id E33671400BB;
	Thu, 18 Jul 2024 11:14:08 +0900 (JST)
From: Takuya Wakazono <takuya.wakazono@miraclelinux.com>
To: jbaron@akamai.com
Cc: linux-edac@vger.kernel.org
Subject: [PATCH] EDAC/ie31200: Add more device IDs
Date: Thu, 18 Jul 2024 11:14:08 +0900
Message-ID: <20240718021408.396155-1-takuya.wakazono@miraclelinux.com>
X-Mailer: git-send-email 2.44.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We verified that the following CPUs can detect errors when single-bit
and multi-bit errors occur: 1614, 1900, 3e10, 3ec4

Signed-off-by: Takuya Wakazono <takuya.wakazono@miraclelinux.com>
---
 drivers/edac/ie31200_edac.c | 42 ++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index 9ef13570f2e5..8c5a4ae54364 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -18,6 +18,8 @@
  * 015c: Xeon E3-1200 v2/3rd Gen Core processor DRAM Controller
  * 0c04: Xeon E3-1200 v3/4th Gen Core Processor DRAM Controller
  * 0c08: Xeon E3-1200 v3 Processor DRAM Controller
+ * 1614: Broadwell-U Host Bridge - DMI 
+ * 1900: Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor Host Bridge/DRAM Registers
  * 1918: Xeon E3-1200 v5 Skylake Host Bridge/DRAM Registers
  * 5918: Xeon E3-1200 Xeon E3-1200 v6/7th Gen Core Processor Host Bridge/DRAM Registers
  * 190f: 6th Gen Core Dual-Core Processor Host Bridge/DRAM Registers
@@ -27,6 +29,7 @@
  * Based on Intel specification:
  * https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/xeon-e3-1200v3-vol-2-datasheet.pdf
  * http://www.intel.com/content/www/us/en/processors/xeon/xeon-e3-1200-family-vol-2-datasheet.html
+ * https://www.intel.com/content/www/us/en/content-details/332379/mobile-5th-generation-intel-core-processor-datasheet-vol-2.html
  * https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/desktop-6th-gen-core-family-datasheet-vol-2.pdf
  * https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/xeon-e3-1200v6-vol-2-datasheet.pdf
  * https://www.intel.com/content/www/us/en/processors/core/7th-gen-core-family-mobile-h-processor-lines-datasheet-vol-2.html
@@ -64,30 +67,35 @@
 #define PCI_DEVICE_ID_INTEL_IE31200_HB_5  0x015c
 #define PCI_DEVICE_ID_INTEL_IE31200_HB_6  0x0c04
 #define PCI_DEVICE_ID_INTEL_IE31200_HB_7  0x0c08
-#define PCI_DEVICE_ID_INTEL_IE31200_HB_8  0x190F
-#define PCI_DEVICE_ID_INTEL_IE31200_HB_9  0x1918
-#define PCI_DEVICE_ID_INTEL_IE31200_HB_10 0x191F
-#define PCI_DEVICE_ID_INTEL_IE31200_HB_11 0x5918
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_8  0x1614
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_9  0x1900
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_10 0x190F
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_11 0x1918
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_12 0x191F
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_13 0x5918
 
 /* Coffee Lake-S */
 #define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_MASK 0x3e00
 #define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_1    0x3e0f
-#define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_2    0x3e18
-#define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_3    0x3e1f
-#define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_4    0x3e30
-#define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_5    0x3e31
-#define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_6    0x3e32
-#define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_7    0x3e33
-#define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_8    0x3ec2
-#define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_9    0x3ec6
-#define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_10   0x3eca
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_2    0x3e10
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_3    0x3e18
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_4    0x3e1f
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_5    0x3e30
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_6    0x3e31
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_7    0x3e32
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_8    0x3e33
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_9    0x3ec2
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_10   0x3ec4
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_11   0x3ec6
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_12   0x3eca
 
 /* Test if HB is for Skylake or later. */
 #define DEVICE_ID_SKYLAKE_OR_LATER(did)                                        \
-	(((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_8) ||                        \
-	 ((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_9) ||                        \
+	(((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_9) ||                        \
 	 ((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_10) ||                       \
 	 ((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_11) ||                       \
+	 ((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_12) ||                       \
+	 ((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_13) ||                       \
 	 (((did) & PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_MASK) ==                 \
 	  PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_MASK))
 
@@ -587,6 +595,8 @@ static const struct pci_device_id ie31200_pci_tbl[] = {
 	{ PCI_VEND_DEV(INTEL, IE31200_HB_9),      PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
 	{ PCI_VEND_DEV(INTEL, IE31200_HB_10),     PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
 	{ PCI_VEND_DEV(INTEL, IE31200_HB_11),     PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_12),     PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_13),     PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
 	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_1),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
 	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_2),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
 	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_3),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
@@ -597,6 +607,8 @@ static const struct pci_device_id ie31200_pci_tbl[] = {
 	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_8),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
 	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_9),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
 	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_10), PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_11), PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_12), PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
 	{ 0, } /* 0 terminated list. */
 };
 MODULE_DEVICE_TABLE(pci, ie31200_pci_tbl);
-- 
2.44.1


