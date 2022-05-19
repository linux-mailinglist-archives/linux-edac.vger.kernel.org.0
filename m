Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C672A52CCDC
	for <lists+linux-edac@lfdr.de>; Thu, 19 May 2022 09:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbiESHZT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 19 May 2022 03:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234777AbiESHZM (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 19 May 2022 03:25:12 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D765F8720F;
        Thu, 19 May 2022 00:25:09 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id nk9-20020a17090b194900b001df2fcdc165so8047767pjb.0;
        Thu, 19 May 2022 00:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=izhcXDphxsSYMgLi7WOIxwg7ve9I4BtGghSY1eoBQEs=;
        b=jZzhFSYQ6xCZWQ48bdsBqBDao2zARJZkZyDZsUfdzMeDDlGumxtck1+YKCQVqhOiwn
         zzWbwYkxaOrsQSp52OnMaLSG80Kz+x8GL3kyJJ0cVGc7kyQU7uCwQfPJF4Avk0KuCMYd
         vDGTVqQUNFa83s4j8Pm0YxbfhwEDkje/lPcSgsyK6vkjd+u2dQuyckvBZnFBAHrHLT9s
         Eh/40tmJitMVYZkEJBUC+q8QLiZVn+Go8EtS5x/iCKhb3Tt0EpSQhib0cLLtuzuj7wHH
         jx2826dhlVarBTt6wtB8eDqqsBZHqrT+Mbaki/HCwiHKTJfdhqWO0aXDHqi8BCeAepP4
         gMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=izhcXDphxsSYMgLi7WOIxwg7ve9I4BtGghSY1eoBQEs=;
        b=uMzI7muTf8g2wXdabfbD08l8e5c1gOPZG+6XXxle/kdw5HK8aBXlSuMoCeVIHwaDR+
         GNXAvA44Q9sum+tWdSzEOVuxbBQHjnYMyfJCQLFk1Pzi90Cs4u9VnTkV002Yl1I8b1Tg
         QiiLJ4xurzdc87boLrCwoBXaabR5X0f06v9YXdL2zK7zRY7pobbfn9tPyzkpb6IuiVed
         3q4kJav2X5pERgCZ23valw3xz+SjUA0S/bT46BTxD5eFh08DEqCnr6W7OTlaueRXVmlO
         4v6pt/yf/rifLakd2Mmrv+fNORnBynrO0sivzxEaM/p/J1Ad9AYhEBHO/U9qMozI1r2E
         npJw==
X-Gm-Message-State: AOAM530u1rLSwAZqv9Q+uFwnl8m0j52AXLuKoXiokMVLG8WNDtbQBK2Z
        0GT0bx1WTJkEwJuLihSe2I0=
X-Google-Smtp-Source: ABdhPJxRWMLiPZC1hEmCnRDpsE1fl+ZNEr/v7kfplga+jDdVtU/2eIrwAPw+PI8xO0UejtD6e40BnQ==
X-Received: by 2002:a17:903:4044:b0:161:823e:6f93 with SMTP id n4-20020a170903404400b00161823e6f93mr3501687pla.172.1652945109335;
        Thu, 19 May 2022 00:25:09 -0700 (PDT)
Received: from localhost.localdomain ([116.89.141.50])
        by smtp.gmail.com with ESMTPSA id b12-20020a170902650c00b00161ac982b9esm2974159plk.185.2022.05.19.00.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 00:25:08 -0700 (PDT)
From:   Medad CChien <medadyoung@gmail.com>
X-Google-Original-From: Medad CChien <ctcchien@nuvoton.com>
To:     rric@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        mchehab@kernel.org, bp@alien8.de, robh+dt@kernel.org,
        benjaminfair@google.com, yuenn@google.com, venture@google.com,
        KWLIU@nuvoton.com, YSCHU@nuvoton.com, JJLIU0@nuvoton.com,
        KFTING@nuvoton.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, ctcchien@nuvoton.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH v10 1/3] dt-bindings: edac: nuvoton: add NPCM memory controller
Date:   Thu, 19 May 2022 15:24:52 +0800
Message-Id: <20220519072454.24063-2-ctcchien@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220519072454.24063-1-ctcchien@nuvoton.com>
References: <20220519072454.24063-1-ctcchien@nuvoton.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Document devicetree bindings for the Nuvoton BMC NPCM memory controller.

Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../edac/nuvoton,npcm-memory-controller.yaml  | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml

diff --git a/Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml b/Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml
new file mode 100644
index 000000000000..a5c8d332d1c1
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/edac/nuvoton,npcm-memory-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton NPCM Memory Controller
+
+maintainers:
+  - Medad CChien <ctcchien@nuvoton.com>
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
+    minItems: 1
+    items:
+      - description: uncorrectable error interrupt
+      - description: correctable error interrupt
+
+  interrupt-names:
+    minItems: 1
+    items:
+      - const: ue
+      - const: ce
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
+        #address-cells = <2>;
+        #size-cells = <2>;
+        mc: memory-controller@f0824000 {
+            compatible = "nuvoton,npcm750-memory-controller";
+            reg = <0x0 0xf0824000 0x0 0x1000>;
+            interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
-- 
2.17.1

