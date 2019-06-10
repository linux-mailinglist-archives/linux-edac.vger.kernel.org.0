Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E75153BCAE
	for <lists+linux-edac@lfdr.de>; Mon, 10 Jun 2019 21:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388954AbfFJTPh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 10 Jun 2019 15:15:37 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:49465 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389195AbfFJTOf (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 10 Jun 2019 15:14:35 -0400
Received: by mail-vs1-f73.google.com with SMTP id 184so3378364vsw.16
        for <linux-edac@vger.kernel.org>; Mon, 10 Jun 2019 12:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=boLZuSG3N/M8DQ81P181ktkcspG8tZVzYoDDzeN32S8=;
        b=iXH131DKGX2UMUlAAUKxHnoRXNmqPh28xSMaCgEFeFtAR80G8MAMxI1PfRZ9B3r18n
         d5ZJzNkdUIyvrBOK46suRLEJAlaPOGJYwj7mBlrPRxYk9Ly10frk6YvNWTTHM5vbRdXg
         xmKYG28r+BUQxAMGQ3HArjyLuPNPNZg7poHBscgfk2LQUP++hrYIh18TuzPcopo22Jfc
         kXFjPJzHP+EqnT2xTwPBDyBodzDROX+K8E3zAm7sRmpexjjorM87Ht52fvqkt/Y5zD3L
         mUeNtWZuP2pDXDm2P43dls7kFaI2e9/90OO9GuwDK/jkUGTTIbPpHL9tXhPqxKwjvDV8
         EqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=boLZuSG3N/M8DQ81P181ktkcspG8tZVzYoDDzeN32S8=;
        b=FyKxN6KcRsCF4stqCcu5Ve2O3tH1K9eAJtPP2uXcDqaQeXAi7TJ7aOAscNn4Bm6Rg5
         +QFcEc0xEEsHds3rp92TIbr6FDA5rsjAzNmFFL4tY7cjn1BxX6ynjqRGdGM9xVs0j1Lk
         GxnmsXL+x/5U8FMUdyK6fD0zCjEZkjXErSTqIXuO8WoFBjlQlmI6Zxa/APb2nd9SyTBy
         4lm/chIEnh2vGaFxAv7FfM1fHilBSP4jljxvgLOXrLoWQGZdp5Scgr8zw/XWYvKBE9ax
         5OIXvYiF+my0n3zqhIQOhOd/UUhDjD4kD1XOeftpHXX70fuwuNaKCveBFbao/uIxlYpz
         f0OQ==
X-Gm-Message-State: APjAAAU51gVsRf3VB8y0SGS5w2sLB2obEO8cRHUZr5nOnfxYEilEO4Rz
        Sz5aiLzdzNniI2XCpXplo4AIIRpzpQ==
X-Google-Smtp-Source: APXvYqzdoEf4jWI24NW1XHaaDjxDWgWHFwRIZbIFV5V22iA8DuN3pc9LCBZTnlLaSiIhw1BJJ3513F06NQ==
X-Received: by 2002:a67:2781:: with SMTP id n123mr37283823vsn.141.1560194074287;
 Mon, 10 Jun 2019 12:14:34 -0700 (PDT)
Date:   Mon, 10 Jun 2019 21:14:21 +0200
Message-Id: <20190610191422.177931-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v2 1/2] EDAC, ie31200: Add Intel Coffee Lake CPU support
From:   Marco Elver <elver@google.com>
To:     bp@alien8.de, tony.luck@intel.com, jbaron@akamai.com
Cc:     linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Coffee Lake seems to work like Skylake and Kaby Lake. This patch adds all
device IDs for Coffee Lake-S CPUs according to datasheet.

Signed-off-by: Marco Elver <elver@google.com>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
---

v2:
- Reverted formatting existing pci_tbl entries.

Tested with a Xeon E-2124G.
---
 drivers/edac/ie31200_edac.c | 58 +++++++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index adf60eb45bd4..cdb26014d929 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -20,11 +20,13 @@
  * 0c08: Xeon E3-1200 v3 Processor DRAM Controller
  * 1918: Xeon E3-1200 v5 Skylake Host Bridge/DRAM Registers
  * 5918: Xeon E3-1200 Xeon E3-1200 v6/7th Gen Core Processor Host Bridge/DRAM Registers
+ * 3e..: 8th/9th Gen Core Processor Host Bridge/DRAM Registers
  *
  * Based on Intel specification:
  * http://www.intel.com/content/dam/www/public/us/en/documents/datasheets/xeon-e3-1200v3-vol-2-datasheet.pdf
  * http://www.intel.com/content/www/us/en/processors/xeon/xeon-e3-1200-family-vol-2-datasheet.html
  * http://www.intel.com/content/www/us/en/processors/core/7th-gen-core-family-mobile-h-processor-lines-datasheet-vol-2.html
+ * https://www.intel.com/content/www/us/en/products/docs/processors/core/8th-gen-core-family-datasheet-vol-2.html
  *
  * According to the above datasheet (p.16):
  * "
@@ -61,6 +63,26 @@
 #define PCI_DEVICE_ID_INTEL_IE31200_HB_8 0x1918
 #define PCI_DEVICE_ID_INTEL_IE31200_HB_9 0x5918
 
+/* Coffee Lake-S */
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_MASK 0x3e00
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_1    0x3e0f
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_2    0x3e18
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_3    0x3e1f
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_4    0x3e30
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_5    0x3e31
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_6    0x3e32
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_7    0x3e33
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_8    0x3ec2
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_9    0x3ec6
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_10   0x3eca
+
+/* Helper macro to test if HB is for Skylake or later. */
+#define DEVICE_ID_SKYLAKE_OR_LATER(did)                                        \
+	(((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_8) ||                        \
+	 ((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_9) ||                        \
+	 (((did)&PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_MASK) ==                   \
+	  PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_MASK))
+
 #define IE31200_DIMMS			4
 #define IE31200_RANKS			8
 #define IE31200_RANKS_PER_CHANNEL	4
@@ -381,10 +403,10 @@ static int ie31200_probe1(struct pci_dev *pdev, int dev_idx)
 	u32 addr_decode, mad_offset;
 
 	/*
-	 * Kaby Lake seems to work like Skylake. Please re-visit this logic
-	 * when adding new CPU support.
+	 * Kaby Lake, Coffee Lake seem to work like Skylake. Please re-visit
+	 * this logic when adding new CPU support.
 	 */
-	bool skl = (pdev->device >= PCI_DEVICE_ID_INTEL_IE31200_HB_8);
+	bool skl = DEVICE_ID_SKYLAKE_OR_LATER(pdev->device);
 
 	edac_dbg(0, "MC:\n");
 
@@ -569,6 +591,36 @@ static const struct pci_device_id ie31200_pci_tbl[] = {
 	{
 		PCI_VEND_DEV(INTEL, IE31200_HB_9), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		IE31200},
+	{
+		PCI_VEND_DEV(INTEL, IE31200_HB_CFL_1), PCI_ANY_ID, PCI_ANY_ID,
+		0, 0, IE31200},
+	{
+		PCI_VEND_DEV(INTEL, IE31200_HB_CFL_2), PCI_ANY_ID, PCI_ANY_ID,
+		0, 0, IE31200},
+	{
+		PCI_VEND_DEV(INTEL, IE31200_HB_CFL_3), PCI_ANY_ID, PCI_ANY_ID,
+		0, 0, IE31200},
+	{
+		PCI_VEND_DEV(INTEL, IE31200_HB_CFL_4), PCI_ANY_ID, PCI_ANY_ID,
+		0, 0, IE31200},
+	{
+		PCI_VEND_DEV(INTEL, IE31200_HB_CFL_5), PCI_ANY_ID, PCI_ANY_ID,
+		0, 0, IE31200},
+	{
+		PCI_VEND_DEV(INTEL, IE31200_HB_CFL_6), PCI_ANY_ID, PCI_ANY_ID,
+		0, 0, IE31200},
+	{
+		PCI_VEND_DEV(INTEL, IE31200_HB_CFL_7), PCI_ANY_ID, PCI_ANY_ID,
+		0, 0, IE31200},
+	{
+		PCI_VEND_DEV(INTEL, IE31200_HB_CFL_8), PCI_ANY_ID, PCI_ANY_ID,
+		0, 0, IE31200},
+	{
+		PCI_VEND_DEV(INTEL, IE31200_HB_CFL_9), PCI_ANY_ID, PCI_ANY_ID,
+		0, 0, IE31200},
+	{
+		PCI_VEND_DEV(INTEL, IE31200_HB_CFL_10), PCI_ANY_ID, PCI_ANY_ID,
+		0, 0, IE31200},
 	{
 		0,
 	}            /* 0 terminated list. */
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

