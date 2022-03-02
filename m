Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7334CA0A1
	for <lists+linux-edac@lfdr.de>; Wed,  2 Mar 2022 10:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240453AbiCBJZi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 2 Mar 2022 04:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240455AbiCBJZh (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 2 Mar 2022 04:25:37 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58A77E09A;
        Wed,  2 Mar 2022 01:24:54 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id x18so1395430pfh.5;
        Wed, 02 Mar 2022 01:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ogow4DiJjDktRfj4hcio5HqKMsSdPYDh3kYUtkpLBD0=;
        b=lingdd6g7q8/UiV48cU4Vyvp0EvmSgJciUFxe5a5cOud+7ZqKFtjqRTq050oPfJEoS
         uos95crCxAFnySkP7Gzo9EX+DMV0YvtDiU16etjaUCcis6ARd0SmzYIpMzCtnQx9ZIuP
         QRCSh0+2/SBvvJ73l+qKZXvBKamttACEO1cOr8joyaSWDPVzImdBRutShfUxHIApO9+j
         vtDxGDiLrLyDZ7lrJb3Pgr43Hn+56ylqqhmm5M5sRhgNLRgNEziZ6mxXIQl2Uw4eIfb/
         II56FZ/3KXwUYSIqNSJUfDdkwtHEPRdoRLHV0Hxxc2DkHY1bGn38fQBRzDdY6GpoNDx8
         IF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ogow4DiJjDktRfj4hcio5HqKMsSdPYDh3kYUtkpLBD0=;
        b=MRpZsvwRgcgEaFOqw575D+iV6Cngr3HtzcV37DUzj7VlOw6SPf3gBqXFjPivVXRJey
         ogdRLnG+LOkbHM7cAI6E5sBcLxw68Hc6KqqZsQ+QoeYiUhc42kg0nDoOpQBNXYfdpV7K
         8zZ/nb2wCVBIs8AeVw/gH3NPCKpsezarNADuOhSNjpGKpOrbSmV4OWCjE4xnD3s3H3Gm
         dTQgf6l7qQ9Kq2GGXVTQE4WwEEwpX2NNnoT6F5IGW7d/bWbMdQowxewxl0S2mSDkk86D
         qyLFjuFpoINAJPB2W2lBZcq1lxqKbNZzySmmEMbKZIp0+1QAos7dpp3wj5rYHQX920Vx
         BziA==
X-Gm-Message-State: AOAM530jxVwGW+ivzMJ0bG6QeG9AznDPUQO2uaHZp7ACu60BkYsoLcsX
        p/c5N0/dx7tQtH1tenm3SNk=
X-Google-Smtp-Source: ABdhPJx+eXTu+5IPKHxuqlJY7ZgWlcuuRD5Zk9LmMPCBlrtqE+s9rjTw0bk6RdbOhX9DruZmHhFxgA==
X-Received: by 2002:a63:d47:0:b0:373:598c:e0aa with SMTP id 7-20020a630d47000000b00373598ce0aamr25225085pgn.243.1646213094357;
        Wed, 02 Mar 2022 01:24:54 -0800 (PST)
Received: from localhost.localdomain ([112.78.94.140])
        by smtp.gmail.com with ESMTPSA id q22-20020a056a00085600b004f397d1f3b5sm21351153pfk.171.2022.03.02.01.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 01:24:53 -0800 (PST)
From:   Medad CChien <medadyoung@gmail.com>
X-Google-Original-From: Medad CChien <ctcchien@nuvoton.com>
To:     rric@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        mchehab@kernel.org, bp@alien8.de, robh+dt@kernel.org,
        benjaminfair@google.com, yuenn@google.com, venture@google.com,
        KWLIU@nuvoton.com, YSCHU@nuvoton.com, JJLIU0@nuvoton.com,
        KFTING@nuvoton.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        Medad CChien <ctcchien@nuvoton.com>
Subject: [PATCH v2 2/3] dt-bindings: edac: npcm-edac.yaml
Date:   Wed,  2 Mar 2022 17:24:33 +0800
Message-Id: <20220302092434.16625-3-ctcchien@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220302092434.16625-1-ctcchien@nuvoton.com>
References: <20220302092434.16625-1-ctcchien@nuvoton.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add the device tree bindings for the EDAC driver npcm-edac.

Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
---
 .../devicetree/bindings/edac/npcm-edac.yaml   | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/npcm-edac.yaml

diff --git a/Documentation/devicetree/bindings/edac/npcm-edac.yaml b/Documentation/devicetree/bindings/edac/npcm-edac.yaml
new file mode 100644
index 000000000000..936e9787ec80
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/npcm-edac.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/edac/npcm-edac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton NPCM Memory Controller EDAC
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
+      - nuvoton,npcm8xx-memory-controller
+      - nuvoton,npcm7xx-memory-controller
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
+            compatible = "nuvoton,npcm7xx-memory-controller";
+            reg = <0x0 0xf0824000 0x0 0x1000>;
+            interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
+
-- 
2.17.1

