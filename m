Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD7457172F
	for <lists+linux-edac@lfdr.de>; Tue, 12 Jul 2022 12:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiGLKVx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 12 Jul 2022 06:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbiGLKVu (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 12 Jul 2022 06:21:50 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C47ADD58;
        Tue, 12 Jul 2022 03:21:48 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id z11so4401280qkz.13;
        Tue, 12 Jul 2022 03:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ju3dMMy387I8KJ90v34qgF9dDa8M7KnfAZaqnz942SY=;
        b=XN0y2hOzC002RPOTy41oFPJkCfNO6fWg62USwJfIPzZYl/lzL1XMgE/9NZmstcGLhR
         gZ0O3WQSBuR9zIRMmof9b1kdFijxT19nqJS3b9ObYN28vNsL3vjjalQQvC0PYS48TwJ7
         dDko83C8P3siwbP3wfuN0LovSujneRqfMlAuiPqYVmbFS4HI8AKbJGqzvyTOjwLXtyx6
         5NhrKFw6yl7eL3GnaWZW2okxjnpINRC9xjICM1EnhKKW9syeHYkzPlViDOmW1YYKCa6d
         3BN66mqH6rmE9Y1jm/X9jJbbKd0LXc2wXBP7hkw01zQQUwQam1o4QRG7rRwfoElbnnIY
         FOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ju3dMMy387I8KJ90v34qgF9dDa8M7KnfAZaqnz942SY=;
        b=haA66Ev/8r+wURQEruT+skE0OC3IwXNoMvNs+ooHpHR6ZyYUoA2k2yAUCFQPHf9Try
         2fZUSGwcrThgZdKOMXrd2FdUqlbhh//5I607rzbNuli6LaWy3JMSgANL1e9ANTQm8fPI
         Iy9biC264eFhYwPPg3dp2fyqQ+CPpMUE5ONrEFOV6Z1B6xrMPB+5nlA/cGrABpcSmiCz
         cKDROUiN2wS8u+0TIHZS5wTD1ZE2a4PGIxf33U7DrU3eYjKSadiCKO+H+cLCWbQTwSqA
         DpZGncenxZ7qZysGtoSj8uvat4NabFV2r7EaISblkmQGl4e98dpryrjtzf3wyP8tPt8R
         sa9g==
X-Gm-Message-State: AJIora+VZdu9C4kHNIp8L/91Qe+K6cBOshGLZ5m3YrqU8roBMyB6ZK5R
        h1meg+7q5E7Jb0x33gW8lis=
X-Google-Smtp-Source: AGRyM1sX7oW1+ZN3W1I/IZvVuZA53av5CErnYWuQpB+gETPBaBwBaSKvWgwrrw26KVMtTdcd+tIcRQ==
X-Received: by 2002:a05:620a:bc9:b0:6a6:5d5a:4306 with SMTP id s9-20020a05620a0bc900b006a65d5a4306mr14649676qki.391.1657621308102;
        Tue, 12 Jul 2022 03:21:48 -0700 (PDT)
Received: from localhost.localdomain ([136.56.17.68])
        by smtp.gmail.com with ESMTPSA id m3-20020a05620a24c300b006b53fe19c41sm9195177qkn.14.2022.07.12.03.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 03:21:47 -0700 (PDT)
From:   Josh Hant <joshuahant@gmail.com>
To:     jbaron@akamai.com
Cc:     joshuahant@gmail.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] EDAC/ie31200: Add Skylake-S support
Date:   Tue, 12 Jul 2022 06:21:21 -0400
Message-Id: <20220712102121.20812-1-joshuahant@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <8e44d499-ad55-d90a-d4e6-2a97aa6d0c41@akamai.com>
References: <8e44d499-ad55-d90a-d4e6-2a97aa6d0c41@akamai.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add device IDs for Skylake-S CPUs according to datasheet.

Signed-off-by: Josh Hant <joshuahant@gmail.com>
---
Hi Jason,

Sorry for the late response. I added the missing check you asked for. I
kept the documentation the same for now. I found the register in table 3
of the original document I linked. If you would rather I provide the one
you linked, I'll do that in the next patch.

I confirmed that the name and size in /proc/meminfo is consistent with
what is in /sys/devices/system/edac/mc/mc0.

Thanks
-Josh
 drivers/edac/ie31200_edac.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index 9a9ff5ad611a..3d322603bce8 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -20,11 +20,14 @@
  * 0c08: Xeon E3-1200 v3 Processor DRAM Controller
  * 1918: Xeon E3-1200 v5 Skylake Host Bridge/DRAM Registers
  * 5918: Xeon E3-1200 Xeon E3-1200 v6/7th Gen Core Processor Host Bridge/DRAM Registers
+ * 190f: 6th Gen Core Dual-Core Processor Host Bridge/DRAM Registers
+ * 191f: 6th Gen Core Quad-Core Processor Host Bridge/DRAM Registers
  * 3e..: 8th/9th Gen Core Processor Host Bridge/DRAM Registers
  *
  * Based on Intel specification:
  * https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/xeon-e3-1200v3-vol-2-datasheet.pdf
  * http://www.intel.com/content/www/us/en/processors/xeon/xeon-e3-1200-family-vol-2-datasheet.html
+ * https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/desktop-6th-gen-core-family-datasheet-vol-2.pdf
  * https://www.intel.com/content/www/us/en/processors/core/7th-gen-core-family-mobile-h-processor-lines-datasheet-vol-2.html
  * https://www.intel.com/content/www/us/en/products/docs/processors/core/8th-gen-core-family-datasheet-vol-2.html
  *
@@ -53,15 +56,17 @@
 #define ie31200_printk(level, fmt, arg...) \
 	edac_printk(level, "ie31200", fmt, ##arg)

-#define PCI_DEVICE_ID_INTEL_IE31200_HB_1 0x0108
-#define PCI_DEVICE_ID_INTEL_IE31200_HB_2 0x010c
-#define PCI_DEVICE_ID_INTEL_IE31200_HB_3 0x0150
-#define PCI_DEVICE_ID_INTEL_IE31200_HB_4 0x0158
-#define PCI_DEVICE_ID_INTEL_IE31200_HB_5 0x015c
-#define PCI_DEVICE_ID_INTEL_IE31200_HB_6 0x0c04
-#define PCI_DEVICE_ID_INTEL_IE31200_HB_7 0x0c08
-#define PCI_DEVICE_ID_INTEL_IE31200_HB_8 0x1918
-#define PCI_DEVICE_ID_INTEL_IE31200_HB_9 0x5918
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_1  0x0108
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_2  0x010c
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_3  0x0150
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_4  0x0158
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_5  0x015c
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_6  0x0c04
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_7  0x0c08
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_8  0x190F
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_9  0x1918
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_10 0x191F
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_11 0x5918

 /* Coffee Lake-S */
 #define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_MASK 0x3e00
@@ -80,6 +85,8 @@
 #define DEVICE_ID_SKYLAKE_OR_LATER(did)                                        \
 	(((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_8) ||                        \
 	 ((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_9) ||                        \
+	 ((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_10) ||                       \
+	 ((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_11) ||                       \
 	 (((did) & PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_MASK) ==                 \
 	  PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_MASK))

@@ -577,6 +584,8 @@ static const struct pci_device_id ie31200_pci_tbl[] = {
 	{ PCI_VEND_DEV(INTEL, IE31200_HB_7),      PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
 	{ PCI_VEND_DEV(INTEL, IE31200_HB_8),      PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
 	{ PCI_VEND_DEV(INTEL, IE31200_HB_9),      PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_10),     PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_11),     PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
 	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_1),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
 	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_2),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
 	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_3),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
--
2.34.3

