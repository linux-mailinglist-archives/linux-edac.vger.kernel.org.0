Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAFB4E463C
	for <lists+linux-edac@lfdr.de>; Tue, 22 Mar 2022 19:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237570AbiCVSsx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 22 Mar 2022 14:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbiCVSsw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 22 Mar 2022 14:48:52 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3BE21B5;
        Tue, 22 Mar 2022 11:47:24 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id b18so5430887qtk.13;
        Tue, 22 Mar 2022 11:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xv2SG83/A8VIj/Yvme6nER5PuyvERHQnlLaL0v26UZU=;
        b=aAez4bENUsIVokJXzci6E7NcI8/EoYeRFg2MIV+bNEjy2Kg+goJXhVKVFZPjf2SVFx
         gYBQG3VcfaihOrVQfxZ+uMwW26BrEl3hwrcimICXp97Bjx1wbQ2d/0g1GrqTz994/72n
         z6vaIr51UvlczzhepIf6G7W9Sod3wqnfXhr5uKfb5yb3QHQ5jnqF8MgGMrPrpe5iSGIB
         Vr2Mi0ALsIzRfAsxKOGreoLnU0lUsGBaSgVCePNALrEEPIwOr9DNVpmbiTXPlIKWQoec
         IpEb3VLcDhhwZKuOW1fk4FPF42QyN1TwIRCiTTIVowmfJuIdZbMLiR/cH3IrBPOwkR0q
         Vzdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xv2SG83/A8VIj/Yvme6nER5PuyvERHQnlLaL0v26UZU=;
        b=Zvl+yaDk7DrRw9VFKjvPrm9CwvfuzmH869KqaxL/fY9jKNzKIyH8/2UOJNYUzlGOh0
         /7/FbX8vII5vqY6RA083rZJ48wjKwCPbSTQJGK7B2WfbzpUdZ/C4uMlXnijncGioeCI9
         fMQ9phdHJSpzDYZf7hz3nxFODyyJb1jtLBX6XPQtnAbrQDG2OIWYMuQVT1zEQOssTfhr
         S9/b48y0VC40w2uinnlC0eA4lNLkjIbxIW/JzAnhKsKGcwwX94b9Xa192vuTMAxL7dS2
         jqugcht6jygjXibXItb+A6Hn1oVpSrQzm7eRUOtFfHU3sqRUUC2or/l1Asb9Cj5FOE6j
         cgGQ==
X-Gm-Message-State: AOAM530EeAjHCxBuODbc5IXn9W/Si/zdvS4kvJUjLrKde0CbIFAFQwet
        lEXM9vVZYnPJFXo+ZopY6tNka5FPEMhN3fdw
X-Google-Smtp-Source: ABdhPJws46frHdp5v61m+kB2H/p59SY9YKS3aKTzXO3MMnX73gPrLba+XJeizaAl2d5LTf7HFiVLlw==
X-Received: by 2002:ac8:5b05:0:b0:2e2:1ce8:1533 with SMTP id m5-20020ac85b05000000b002e21ce81533mr5919450qtw.428.1647974843416;
        Tue, 22 Mar 2022 11:47:23 -0700 (PDT)
Received: from localhost.localdomain ([136.56.17.68])
        by smtp.gmail.com with ESMTPSA id bl3-20020a05620a1a8300b0067d4cd00231sm9356639qkb.135.2022.03.22.11.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:47:23 -0700 (PDT)
From:   joshuahant@gmail.com
To:     jbaron@akamai.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        joshuahant@gmail.com
Subject: [PATCH] EDAC/ie31200: Add Skylake-S support
Date:   Tue, 22 Mar 2022 14:47:17 -0400
Message-Id: <20220322184717.29882-1-joshuahant@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Josh Hant <joshuahant@gmail.com>

Add device IDs for Skylake-S CPUs according to datasheet.

Signed-off-by: Josh Hant <joshuahant@gmail.com>
---
Dear all,

I found that edac-util -v shows no memory controllers when using an
Intel i5-6100T with a Supermicro X11SAE motherboard. With this patch,
the ECC memory is detected. I tried to follow previous patches
that added new families of processors to the module.

This is my first submission to the kernel so please let me know if I
missed something in the process.

Thanks,
Josh Hant

 drivers/edac/ie31200_edac.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index 9a9ff5ad611a..96a3f70d06e6 100644
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
@@ -80,6 +85,7 @@
 #define DEVICE_ID_SKYLAKE_OR_LATER(did)                                        \
 	(((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_8) ||                        \
 	 ((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_9) ||                        \
+	 ((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_10) ||                       \
 	 (((did) & PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_MASK) ==                 \
 	  PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_MASK))

@@ -577,6 +583,8 @@ static const struct pci_device_id ie31200_pci_tbl[] = {
 	{ PCI_VEND_DEV(INTEL, IE31200_HB_7),      PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
 	{ PCI_VEND_DEV(INTEL, IE31200_HB_8),      PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
 	{ PCI_VEND_DEV(INTEL, IE31200_HB_9),      PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_10),     PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_11),     PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
 	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_1),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
 	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_2),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
 	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_3),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
--
2.34.1

