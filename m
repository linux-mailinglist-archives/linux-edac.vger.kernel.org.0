Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8998520BC0
	for <lists+linux-edac@lfdr.de>; Tue, 10 May 2022 05:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbiEJDPT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 May 2022 23:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbiEJDPP (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 9 May 2022 23:15:15 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEB12532E7;
        Mon,  9 May 2022 20:11:16 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id q18so2663924pln.12;
        Mon, 09 May 2022 20:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cs5AJiUrtPIin+3SFfYWSrLnTMbQJ1lpN7zepgpEgDM=;
        b=l2ohVwocRz0FsilHfQ2ykS4ogqV2+gSA0DhzyOKftoD5Eptf77mLNFMTtOn9ubPN4+
         uYbDPQnWoFnpqjHfmblBph23d9e8E/S4aN/PRTakBGaceqGJr6niNSP00CCdldSzf2FQ
         1MVqEd3yb+BSS0R7ImH9PrlJUUI8OVxOxV5pugvEwbg5Rc8CarRjB3j39SAyjW8CWQ/Y
         Ol6gBnWQWkZkCyrsEUPT6gvwZ5fgQQPa+6gFA3jXQiNynM0L27QBXLQzWaadIIZGpWzN
         7N1R8f8jMReEKiS1ahvSDXlFkRJxYJMSmly13XvTYfUV98Vk/x0zeOf6sDCLlNMUbYm6
         O2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cs5AJiUrtPIin+3SFfYWSrLnTMbQJ1lpN7zepgpEgDM=;
        b=hx6uICeqB3doEjYFGxRtmn+m2era+Uj3gShoCLXlZa/KLZk3uB0+jKf8t2RPrtpF+M
         1UTKwQBRkgRXDh51Y2phRAMJzCxZPZ12Q7eZv3q9Extbz7VtHxVjsO66mfvW6CWGiea4
         XmqL4y/e/cgaeO8Nnu5SuKGKUPYQ2YqLKaE0FGDy6St32tpx69j46I0wuDp4fen6x4WG
         WxnuVD25OndAnOPjMWBvwx4SRahT9zwodaiGqeBWR1WEwVZLKhxrWQDPk/w3dRdsmy+A
         Fd4T6HFVboE61rupUpoaKqEagd5u7jxTzrzTtABg7uz8AX9zvGKarQ2G4Ob5zfBCn2Me
         np+Q==
X-Gm-Message-State: AOAM5314sRUccQ7mkTGYXmF5lagEO9+YYaiWuP/Sdh7CmXL60sIfn8fa
        nws5GVIAoWxBXcelBWbbp0o=
X-Google-Smtp-Source: ABdhPJzKn9d1USsne6qNHYXmJOXaqA7jhQ7vVNWjL8Tphw/i6EToB7UrzQZJeisP0Nwai+u6sDRJNg==
X-Received: by 2002:a17:90b:3b84:b0:1dc:970d:bc1b with SMTP id pc4-20020a17090b3b8400b001dc970dbc1bmr20492178pjb.147.1652152276252;
        Mon, 09 May 2022 20:11:16 -0700 (PDT)
Received: from cs20-buildserver.lan ([112.78.91.252])
        by smtp.gmail.com with ESMTPSA id g13-20020a170902c38d00b0015e8d4eb248sm648824plg.146.2022.05.09.20.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 20:11:15 -0700 (PDT)
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
Subject: [PATCH v9 2/3] dt-bindings: edac: nuvoton: add NPCM memory controller
Date:   Tue, 10 May 2022 11:10:55 +0800
Message-Id: <20220510031056.1657-3-ctcchien@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220510031056.1657-1-ctcchien@nuvoton.com>
References: <20220510031056.1657-1-ctcchien@nuvoton.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Document devicetree bindings for the Nuvoton BMC NPCM memory controller.

Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../edac/nuvoton,npcm-memory-controller.yaml  | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml

diff --git a/Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml b/Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml
new file mode 100644
index 000000000000..6f37211796a3
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml
@@ -0,0 +1,61 @@
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

