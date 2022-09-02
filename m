Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778705AAB58
	for <lists+linux-edac@lfdr.de>; Fri,  2 Sep 2022 11:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236073AbiIBJ2S (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 2 Sep 2022 05:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235924AbiIBJ1s (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 2 Sep 2022 05:27:48 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98015C926E;
        Fri,  2 Sep 2022 02:27:41 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id f24so1331458plr.1;
        Fri, 02 Sep 2022 02:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=SmFkFrSKnE5UGV/FeBagKO6cow8ZrY/ENIxZIsA8ZEo=;
        b=JPPVPAy9UNFiVUlP+UFd+zM78yy8UFlS3Qx8bY4NlbVZanWPDp72C1jlWmv8OBJ44S
         gk6w2Ltg4sbMzCqMuvGFAkGX+vOAQ9rFj9VThzsYlyqSwYtEuvCmszflX94bFbrqjbDH
         eBSLSeE7hmkNY5NHyC1JRm0x5VdAzKSIlh1NwS4eX5NCl2XuAHYOU+mwAbOno7S9h4D6
         BZFlngScsyxnovNyUUBvv8oyaenZgtI4oq0/fR3RDpmPwmnbsVQQdtpEF4QzSmUfMmCY
         umjsC9C8cVQLyw9R6b10JKu+KCu3asO3i309yi8kLMyBMznjVs6acbvj/w2DFK0RAeml
         KbrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=SmFkFrSKnE5UGV/FeBagKO6cow8ZrY/ENIxZIsA8ZEo=;
        b=BO2G5YmsI7ALQLQwRJ8REd/ZripQ+fFLK2GVbRiUBaZGHEX6m+30WvE6exDKlCcdvV
         LYXNL+s9JQw32lRwkfqpAhb/LKlvbYh5cj9EDSU/b8gGtw0FXKShCF4/68nZcbrgz21B
         nk0ov4n5n6utl/tZT8cQlh3TbZgVqiNB6qJCzXH9Sq8zN8k0cIj/WNoLF4/X1PYhWBwF
         58MFdnDgJgjhc1aoBsR2Q/PLlw2ZA3x9jG94DY4IvBlfdZtANrsfZALdyycc0Vihcd3Y
         /Ejx8j31Nw0e+qH+zVk5r7tuaE1ngDVOi48D2cnKvOXMp9PxOJ9Wm/jd2/nq7iGKpijO
         qIPQ==
X-Gm-Message-State: ACgBeo1wrjjpET1m2emHgzao+MMCYocV0KlHya2TyqaQ+g8KSGWAMtBp
        SBes9fETywqIwSTCQVBfT8CGzPZTjGf+Uw==
X-Google-Smtp-Source: AA6agR4eh9GVTn9g/d67M2zV2BYl8ri3bbUUBrZDx3R8mcVlM8dYa2tgAhYGJ9LwzpGLIUsFNfqlKQ==
X-Received: by 2002:a17:903:2102:b0:174:4d5f:8abf with SMTP id o2-20020a170903210200b001744d5f8abfmr32079734ple.11.1662110860684;
        Fri, 02 Sep 2022 02:27:40 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id s62-20020a625e41000000b005350ea966c7sm1169315pfb.154.2022.09.02.02.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 02:27:39 -0700 (PDT)
From:   Marvin Lin <milkfafa@gmail.com>
To:     linux-edac@vger.kernel.org, rric@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, mchehab@kernel.org, bp@alien8.de,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        benjaminfair@google.com, yuenn@google.com, venture@google.com,
        KWLIU@nuvoton.com, YSCHU@nuvoton.com, JJLIU0@nuvoton.com,
        KFTING@nuvoton.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, ctcchien@nuvoton.com, kflin@nuvoton.com,
        Marvin Lin <milkfafa@gmail.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH v15 2/3] dt-bindings: edac: nuvoton: Add document for NPCM memory controller
Date:   Fri,  2 Sep 2022 17:27:13 +0800
Message-Id: <20220902092714.3683980-3-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220902092714.3683980-1-milkfafa@gmail.com>
References: <20220902092714.3683980-1-milkfafa@gmail.com>
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

Add dt-bindings document for Nuvoton NPCM memory controller.

Signed-off-by: Marvin Lin <milkfafa@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../memory-controllers/nuvoton,npcm-mc.yaml   | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nuvoton,npcm-mc.yaml

diff --git a/Documentation/devicetree/bindings/memory-controllers/nuvoton,npcm-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nuvoton,npcm-mc.yaml
new file mode 100644
index 000000000000..0e752a673453
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/nuvoton,npcm-mc.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/nuvoton,npcm-mc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton NPCM Memory Controller
+
+maintainers:
+  - Marvin Lin <kflin@nuvoton.com>
+  - Stanley Chu <yschu@nuvoton.com>
+
+description: |
+  The Nuvoton BMC SoC supports DDR4 memory with and without ECC (error
+  correction check).
+
+  The memory controller supports single bit error correction, double bit
+  error detection (in-line ECC in which a section (1/8th) of the memory
+  device used to store data is used for ECC storage).
+
+  Note, the bootloader must configure ECC mode for the memory controller.
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,npcm750-memory-controller
+      - nuvoton,npcm845-memory-controller
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    ahb {
+        #address-cells = <1>;
+        #size-cells = <1>;
+        mc: memory-controller@f0824000 {
+            compatible = "nuvoton,npcm750-memory-controller";
+            reg = <0xf0824000 0x1000>;
+            interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
-- 
2.34.1

