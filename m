Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B494DBCBF
	for <lists+linux-edac@lfdr.de>; Thu, 17 Mar 2022 02:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358390AbiCQCAe (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 16 Mar 2022 22:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358393AbiCQCAd (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 16 Mar 2022 22:00:33 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BBB1E3C2;
        Wed, 16 Mar 2022 18:59:17 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id bx24-20020a17090af49800b001c6872a9e4eso70888pjb.5;
        Wed, 16 Mar 2022 18:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xJ9GfFhZddrKv5u5rmWflw0LJ2oRtvcB/gDMBiL/rp4=;
        b=iHtg4Ll0q4cyNl44XcDa8NErOtHepB9QlTJdcO1U9BDYlg+uotYRUnbIGn73BktwX6
         tjIPW6IICy5I5/cZWGOLEnlrjtl4j/e4w8d8sMrrLMa5uzwT1wVnNzVIEs0BmSdfHxAC
         v2e774+Gjpa8+eJGMMVoLRoYMv6g1BWbyMfx3lKM8sNomCWicz1S/A3Lg7slVBml9X9r
         51WfI8vml0g/lWy02sNtgaNWDGBsR7Vt366PPCxyjEtLuKgFBtcPJyPLOMiTIOjRiip9
         MvmUzqDx/3R7sKzIP1MsILL/yVwSHSfgD5HZsqjdPlWVYoujMk1fDqbypWqN0wNPMlQz
         WY4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xJ9GfFhZddrKv5u5rmWflw0LJ2oRtvcB/gDMBiL/rp4=;
        b=Sbkir0WKtY+vwomozhBMl1vbaZaE5cPo7h+t0O2kjaJFwTRODfdg8H3mJuSezMUTzA
         P0y4Ea2vc/G+9oD0fRRHk1b53/S+xPsP4c+0O3TrsTZPcovZ3Y+6dmXdV+rG2GOdhLpB
         A6hAlDq0WYkLmkZBfTXxFMxp7k3oNcKgGI3jtgUqkWB4Plbf7+AcqWPcgbiGZudJ9LdE
         DA35UZd11LZWlXs6lgSnlEC4Q7jZvNdWQjiNHG/nAt6Cv7Q8S/+9aPIMy+bjYsJ5Gy66
         7zxV1D8ypxU8jpujWVWeU841uy3b5TDaYY5KwMzZ7/j7FNtza3h/WZyr2PjBKsl+Yl46
         HqNQ==
X-Gm-Message-State: AOAM531I9cLxKrHD1xVsx/Elh/b40ixJJB+T9BxVb6aK8zOLwzJhpSxV
        6pdjGbC00vGyiZKEV3QJRvE=
X-Google-Smtp-Source: ABdhPJyiSLGUAZ5oSsPuma8C4J6uru2hhM5qNewg1ArRv/ZAS5HLo1BS5xqDAFGnuzgGLzkvU6sUZw==
X-Received: by 2002:a17:90a:4802:b0:1c5:df70:ff66 with SMTP id a2-20020a17090a480200b001c5df70ff66mr13188998pjh.137.1647482357281;
        Wed, 16 Mar 2022 18:59:17 -0700 (PDT)
Received: from localhost.localdomain ([116.89.135.255])
        by smtp.gmail.com with ESMTPSA id nn15-20020a17090b38cf00b001bfceefd8cfsm7945528pjb.48.2022.03.16.18.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 18:59:16 -0700 (PDT)
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
Subject: [PATCH v5 2/3] dt-bindings: edac: nuvoton: add NPCM memory controller
Date:   Thu, 17 Mar 2022 09:58:53 +0800
Message-Id: <20220317015854.18864-3-ctcchien@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220317015854.18864-1-ctcchien@nuvoton.com>
References: <20220317015854.18864-1-ctcchien@nuvoton.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Added device tree binding documentation for Nuvoton BMC
NPCM memory controller.

Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../edac/nuvoton,npcm-memory-controller.yaml  | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml

diff --git a/Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml b/Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml
new file mode 100644
index 000000000000..97469294f4ba
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
+
+description: |
+  The Nuvoton BMC SoC supports DDR4 memory with and without ECC (error
+  correction check).
+
+  The memory controller supports single bit error correction, double bit
+  error detection (in-line ECC in which a section (1/8th) of the
+  memory device used to store data is used for ECC storage).
+
+  Note, the bootloader must configure ECC mode for the memory controller.
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,npcm845-memory-controller
+      - nuvoton,npcm750-memory-controller
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
+
-- 
2.17.1

