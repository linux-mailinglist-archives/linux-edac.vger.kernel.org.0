Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8759F518192
	for <lists+linux-edac@lfdr.de>; Tue,  3 May 2022 11:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbiECJvX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 3 May 2022 05:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbiECJvW (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 3 May 2022 05:51:22 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C96329AE;
        Tue,  3 May 2022 02:47:49 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id q76so10578111pgq.10;
        Tue, 03 May 2022 02:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lY25J+l/icZWfRE50l9wwwRurDxjv0Qr8rloIw54cc0=;
        b=TbX6FdkoycdYFlSNFajYF5tae4wW4Zurp4/QOSdDJt/IGUh2HZ3W9dkZ+NOYGHCh6d
         MUcrDJavsmR6dGcNGmB8vOXzkPqQ081nBERORAEJV8ozDwsVfnk0/Ks76f6bou8Iv33r
         kkTYnzZS2NGySX9eK4l48pfxEi46Eona8n4wgCkg2crpmUtPS/SJIzKSyhOXnu6Y8xUi
         kl92GhNy92q4p5UUaU+K6IQtrBMuFv9gIPxjAuAyTcTG+P2s8qhKKkJZTJ4VypeFKM/2
         ROnHVkB7fEeIR957jU3A0NRd5a8Qt3Z8dNcZOjVT1FBw+kkG8SO23W9a2vnP3u2L7rbp
         5mhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lY25J+l/icZWfRE50l9wwwRurDxjv0Qr8rloIw54cc0=;
        b=t62/YDEyuuFM8g4bCbn4yvDjjsd0gTw/7Wv41ffJdJ+NrGNNIF2xCS3aUQYNA6wRXr
         kztoNS1/+MdkglAla6uiXqeZwIx/kdoCNnHqWgJmq9OjaM8eTIYk3+ryywwtWJ9H3p2s
         X1gj+x5ucxGfNuK58jruGE98syBLa4B0ablHvfa9w3PnA+04yz40dANeipRqshSRvyMV
         T7g1j5lqe0osUIrqkCgIS4HhzU6uOD6DcOD1nPH482PDpCoALe0ESfuqEJmpbYttlLhl
         WpBqRLh7Qik7Q0+a8hs4Yt+ThnRp8Q9W05AZYcVp7gMvW0TSCqgZAClWCGKcXQdvFrvJ
         IXXw==
X-Gm-Message-State: AOAM533r4Exp0y0KpIHJ7+EUpafqlk+VtF3XkG0W6rB1qaNoIEmz6gSH
        knPK5dN0r8Vu4l+8zUVbGGg=
X-Google-Smtp-Source: ABdhPJwVmlVZS/kHbZn9fs3ztG1QIUFV61PnYoDZ0gmvpkylrtQ2sj7NN/mD3+liMaMufXVXGT0HTA==
X-Received: by 2002:a63:1117:0:b0:399:2df0:7fb9 with SMTP id g23-20020a631117000000b003992df07fb9mr13617574pgl.40.1651571268903;
        Tue, 03 May 2022 02:47:48 -0700 (PDT)
Received: from cs20-buildserver.lan ([180.217.147.224])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090a421300b001d90c8b6141sm1015222pjg.53.2022.05.03.02.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 02:47:48 -0700 (PDT)
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
Subject: [PATCH v8 2/3] dt-bindings: edac: nuvoton: add NPCM memory controller
Date:   Tue,  3 May 2022 17:47:27 +0800
Message-Id: <20220503094728.926-3-ctcchien@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220503094728.926-1-ctcchien@nuvoton.com>
References: <20220503094728.926-1-ctcchien@nuvoton.com>
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
Reviewed-by: Borislav Petkov <bp@alien8.de>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Rob Herring <robh@kernel.org>
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

