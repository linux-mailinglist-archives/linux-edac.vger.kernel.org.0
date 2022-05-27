Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAB9535927
	for <lists+linux-edac@lfdr.de>; Fri, 27 May 2022 08:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244555AbiE0GMJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 27 May 2022 02:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbiE0GME (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 27 May 2022 02:12:04 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DC12FE70;
        Thu, 26 May 2022 23:12:02 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 202so3575064pfu.0;
        Thu, 26 May 2022 23:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8BinpoYpAj5+YbnUMIdRgheWrCsfK9f4139iiy8RFN8=;
        b=Ph1+TPeEMT09c8HBfUKvJayGO1ZRgJnQBlCzXCsfq+839DhkXxXuJn/6t0JNT+5lJB
         51u8g13pvMcv0rXgSFK52UmkxlKh1mNZHdu1qox51RBPF437ngDVe6nONFhDgrCsdeyc
         Wh/qToSCQO0xRfg5nnWffaEyrmyLGlUXtBEmuzRSR/akrco8t6lBdO+jWZ0khIU9g7+Z
         FWlsl+IFQXylMiiApjjy/gkGuDffBil8mCftlQrDxgGGwdfklEtpKKPB7zzglBmN2xCa
         v5V9ys+coOfbYndfJJNqf9q4OTixByAFvEf4aoKNJasjR+OhoZkbzCU7Ow4yAvWj2hpI
         Wk7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8BinpoYpAj5+YbnUMIdRgheWrCsfK9f4139iiy8RFN8=;
        b=E+hEdfYmftQUthL9vXhfDDTj0Mo8qqhhLnGYqike1yIZiA/HJfZWZVvlhZ3GiZsbkO
         bUdBODORNpw+lnv+VfnMQe7eRRpkNy7jCJlAYqjgpQYcWcp9YCIHlYsa7U8si7pOw2AO
         HMRytu9uqgHPCPby+C0bCNzUbsrgDotR5nwPKJ56JmicwjbO3JpLSubkNNctHvK425zq
         Jyx3dKh7HHlh9FVWq7uLgUl3l3CMsb3kxde9WAgzu9p8KlYx2Fv7QjWyuLo1VtimfHHY
         kPfpiZ08M2SMaItJldBZqdFk8Hw8T1DL3mY4UDd3OtxxD2NvVp+NEMTqsp2/xImuT5NW
         K9AA==
X-Gm-Message-State: AOAM5333j3Nvpk4gRtuqAY1Y0cQM1hgXrhQMNG75rAhqxQD++3aFEAZx
        Dxy9C8pgRP4mG09CDeuueoY=
X-Google-Smtp-Source: ABdhPJxqRj7nsyeEf+En0jTjo+qu1x20a6ZmFZCWE/zUeqBJaoQyepf4/CeF3pWEZmiRRUiN/edGQQ==
X-Received: by 2002:a05:6a00:24cc:b0:50d:58bf:5104 with SMTP id d12-20020a056a0024cc00b0050d58bf5104mr42294078pfv.36.1653631921740;
        Thu, 26 May 2022 23:12:01 -0700 (PDT)
Received: from localhost.localdomain ([116.89.143.231])
        by smtp.gmail.com with ESMTPSA id b10-20020a1709027e0a00b0015e8d4eb2c2sm2636306plm.268.2022.05.26.23.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 23:12:01 -0700 (PDT)
From:   medadyoung@gmail.com
X-Google-Original-From: ctcchien@nuvoton.com
To:     rric@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        mchehab@kernel.org, bp@alien8.de, robh+dt@kernel.org,
        benjaminfair@google.com, yuenn@google.com, venture@google.com,
        KWLIU@nuvoton.com, YSCHU@nuvoton.com, JJLIU0@nuvoton.com,
        KFTING@nuvoton.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, ctcchien@nuvoton.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH v11 1/3] dt-bindings: edac: nuvoton: add NPCM memory controller
Date:   Fri, 27 May 2022 14:11:46 +0800
Message-Id: <20220527061148.14948-2-ctcchien@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220527061148.14948-1-ctcchien@nuvoton.com>
References: <20220527061148.14948-1-ctcchien@nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Medad CChien <ctcchien@nuvoton.com>

Document devicetree bindings for the Nuvoton BMC NPCM memory controller.

Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../edac/nuvoton,npcm-memory-controller.yaml  | 62 +++++++++++++++++++
 MAINTAINERS                                   |  2 +
 2 files changed, 64 insertions(+)
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
diff --git a/MAINTAINERS b/MAINTAINERS
index 4383949ff654..7f832e6ed4e5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2367,12 +2367,14 @@ L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/*/*/*npcm*
 F:	Documentation/devicetree/bindings/*/*npcm*
+F:	Documentation/devicetree/bindings/*/npcm-memory-controller.yaml
 F:	arch/arm/boot/dts/nuvoton-npcm*
 F:	arch/arm/mach-npcm/
 F:	drivers/*/*npcm*
 F:	drivers/*/*/*npcm*
 F:	include/dt-bindings/clock/nuvoton,npcm7xx-clock.h
 
+
 ARM/NUVOTON WPCM450 ARCHITECTURE
 M:	Jonathan Neuschäfer <j.neuschaefer@gmx.net>
 L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
-- 
2.17.1

