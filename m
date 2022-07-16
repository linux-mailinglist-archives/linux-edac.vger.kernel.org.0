Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C56576B26
	for <lists+linux-edac@lfdr.de>; Sat, 16 Jul 2022 02:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiGPAyE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 15 Jul 2022 20:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiGPAyC (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 15 Jul 2022 20:54:02 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D97012AD9;
        Fri, 15 Jul 2022 17:54:01 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id h22so5011362qta.3;
        Fri, 15 Jul 2022 17:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1IkFEFuHKxBSmk2ERSe1RdUN0F0xBF4E1Hci9y4zc3M=;
        b=ZeRWwzwro/RsDD5GMb13S+MK2ByiCIbvDaGChJUQKS5IS4T9m57lATzt8ygeWaJgax
         u7foT3Ngv4Po7dVhBKwrqVt06OqhztE0wlM89wqb+SDj9zWdLv4HZMDpRZP33F39kZ8j
         9V21IZCTJ+Ccp32CxQbK4bboreF7lY+F3FFc3hAYTtjIGU+jBnIiSrDR6ATPUcrpmATg
         2Fp7V/k3Kk8eerypcqrPTT7dpYYdx1l7d6fL37/ppH2Be5qNFgxwsN6uMzNuOwyG+pzG
         tmEES/tVGQuGOK3yH9JaC/00n3ABF5DGuR2Gg6ZU7vnY6aZpnpXJ46ZSCpcfHPb36IPi
         P+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1IkFEFuHKxBSmk2ERSe1RdUN0F0xBF4E1Hci9y4zc3M=;
        b=JEPglzKdDGqQjXMBXad/0yNChD1E6naz7NaY5NK6fHgWQuDpqOvlbHU2/PyvMbILjb
         iN3t+2rGcP0q6NP49C24l8FtobEMjdOIN8rew4YOPXXOztCk9S5MeSxK+efAauHI4m/i
         6LxcgOV2DwG85KN5GmoecO7vLoyPX+QrtbPe9g+NHr/8O1HUzjEpYiEbpvK9NuEvJu/v
         pK3GM2AD68kOvPK2dVE/fgli0T4fAfYmy5T3Sw4VoBgHjmrDriJXMessWcusFuDcqwQn
         LqOx27LPyWGL4DH5L/45XCuYYv5mPcBnAq6sXPFIfk0CWB5XdQgO0QkIBGpL0reEsZ8m
         R0Hw==
X-Gm-Message-State: AJIora9ZwKDXzlWYrIJEd2+5OL4NfxMMxI1/X+pk/FBh3tX1yCOr84Jl
        ieufLDwHxh6mPpUv2rD95Ods/8Pv0ns=
X-Google-Smtp-Source: AGRyM1tEKz81Bqip/gmBYz47mQGPd7kVywaWh1dmkQwhE+HzP1l99Myjm2h4WUqLPas9jRtpiEdUxQ==
X-Received: by 2002:a05:622a:30a:b0:319:294b:cb88 with SMTP id q10-20020a05622a030a00b00319294bcb88mr14116256qtw.336.1657932840241;
        Fri, 15 Jul 2022 17:54:00 -0700 (PDT)
Received: from localhost.localdomain ([136.56.17.68])
        by smtp.gmail.com with ESMTPSA id bk35-20020a05620a1a2300b006b5b33915besm5431226qkb.85.2022.07.15.17.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 17:53:59 -0700 (PDT)
From:   Josh Hant <joshuahant@gmail.com>
To:     jbaron@akamai.com
Cc:     joshuahant@gmail.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] EDAC/ie31200: Add Skylake-S support
Date:   Fri, 15 Jul 2022 20:53:48 -0400
Message-Id: <20220716005348.13756-1-joshuahant@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <ab77d779-31a6-62f7-a81c-97d6b9a35018@akamai.com>
References: <ab77d779-31a6-62f7-a81c-97d6b9a35018@akamai.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add device IDs for Skylake-S CPUs according to datasheet.

Signed-off-by: Josh Hant <joshuahant@gmail.com>
---
Here is the patch with both documents included.

Thanks,
Josh

 drivers/edac/ie31200_edac.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index 9a9ff5ad611a..9ef13570f2e5 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -20,11 +20,15 @@
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
+ * https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/xeon-e3-1200v6-vol-2-datasheet.pdf
  * https://www.intel.com/content/www/us/en/processors/core/7th-gen-core-family-mobile-h-processor-lines-datasheet-vol-2.html
  * https://www.intel.com/content/www/us/en/products/docs/processors/core/8th-gen-core-family-datasheet-vol-2.html
  *
@@ -53,15 +57,17 @@
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
@@ -80,6 +86,8 @@
 #define DEVICE_ID_SKYLAKE_OR_LATER(did)                                        \
 	(((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_8) ||                        \
 	 ((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_9) ||                        \
+	 ((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_10) ||                       \
+	 ((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_11) ||                       \
 	 (((did) & PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_MASK) ==                 \
 	  PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_MASK))

@@ -577,6 +585,8 @@ static const struct pci_device_id ie31200_pci_tbl[] = {
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

