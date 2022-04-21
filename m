Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844B3509790
	for <lists+linux-edac@lfdr.de>; Thu, 21 Apr 2022 08:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384862AbiDUGcI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 21 Apr 2022 02:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377348AbiDUGbq (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 21 Apr 2022 02:31:46 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877F813F40;
        Wed, 20 Apr 2022 23:28:57 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id bg9so3820263pgb.9;
        Wed, 20 Apr 2022 23:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xp8JbitFpwmkimxt2q3dNIEPhYraj/7nc8LE+MNCmNk=;
        b=BQIf9PhtP9A9t8eaL04Ijm3/UDNTUix2u87de70fIvkTHHvr/U3KrkwxxLKx2sYYEi
         R0pkPpmxQp8xGNamgCDZS3+b+55Op47tLgNRgp8xmGCnL+98yLqJ22CvaJCvXs/DIspT
         IaAQnYdeckwxzBPwNrF8vZMlKzbBQ/0hM/6jGRKLyL9JSe5E4p9IY2W1h5FbP8i/sUbS
         HnUlkitnOahm/E7E9b4+ICQQhFxiKQQpnG5BzWND12sOYjKIx8CRPIsSZ4o/GKRHjBXE
         7usf2xozu4FE3eAGNbddouOGy0MbC14c7qSjhdH0vzWij8QmZTbj7cdGhOdLS27puKTA
         0atg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xp8JbitFpwmkimxt2q3dNIEPhYraj/7nc8LE+MNCmNk=;
        b=dsnjlrepXLYpcI720QAkm1Re2GOjLbw8QPdygBpIAkr9a1yeMPB861I8PAf6CUcyUb
         PfqrP9MVeUcWmtDoE4qtpm3gnmrZtIjqEXbtCzM4hG0NEVc2t+/VJsRnTf2TyGgl7YZb
         ZYpntNxsp5Lh/iPEE17U0h848+5CwvUUM50ktNZNCmdGD/FSqd0uU3C/bTqb3w/Wkc13
         O7c2Yv+N9vjC98Yx6bDCPqhDjKT/uYb26vH+eWa5yOX/aYNgNt73rR6oqHB8OlWCYUza
         Gya9oGSH7omnPAubJ2e0nSg+9J7MemGMzvBh0SzHi+ibu7Qh2+wWqQ09XgXUauV7ycyN
         Y0Aw==
X-Gm-Message-State: AOAM531VtzvWvPDP5Ol9NbIhuFIV3dwzeoi5amHa6h2jRAF17SyHUJEO
        Du4U2jJFumN2PsEcxLKiNoU=
X-Google-Smtp-Source: ABdhPJz06+QbuMKznzphUqCaDVd9ogFZ4uAti5aoj2GfsRB7NdK2JdPRpJKFolhy8vxoz6mZBMGI5Q==
X-Received: by 2002:a63:e709:0:b0:3a9:f988:c595 with SMTP id b9-20020a63e709000000b003a9f988c595mr16643366pgi.435.1650522536952;
        Wed, 20 Apr 2022 23:28:56 -0700 (PDT)
Received: from cs20-buildserver.lan ([1.200.153.245])
        by smtp.gmail.com with ESMTPSA id p23-20020a17090adf9700b001d6e0fe8d28sm273305pjv.22.2022.04.20.23.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 23:28:56 -0700 (PDT)
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
Subject: [PATCH v7 2/3] dt-bindings: edac: nuvoton: add NPCM memory controller
Date:   Thu, 21 Apr 2022 14:28:35 +0800
Message-Id: <20220421062836.16662-3-ctcchien@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220421062836.16662-1-ctcchien@nuvoton.com>
References: <20220421062836.16662-1-ctcchien@nuvoton.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
---
 .../edac/nuvoton,npcm-memory-controller.yaml  | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml

diff --git a/Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml b/Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml
new file mode 100644
index 000000000000..b6ba7778c1eb
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
\ No newline at end of file
-- 
2.17.1

