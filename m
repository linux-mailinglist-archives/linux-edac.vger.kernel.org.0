Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552955A5956
	for <lists+linux-edac@lfdr.de>; Tue, 30 Aug 2022 04:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiH3CXG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 29 Aug 2022 22:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiH3CXE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 29 Aug 2022 22:23:04 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD389CCF3;
        Mon, 29 Aug 2022 19:23:03 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 69so7737156pgb.13;
        Mon, 29 Aug 2022 19:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=XHgIC24nGh94CW9lLVRVV+s+suVxXv3u7A1PnS3bpdU=;
        b=mz5dVPkGXspdc01ahJi3pe4nwSdGdmCCAiV5zdZ/c24L3yUynKA+3QSL0YJZsOxQA6
         vIt4/9AylC8jqmZj8UCSirF2FoBdhZCs/1HdfP69Aocd87rRzn4Jhr8dltOOyLBR1wZN
         XrEFw2wzBCT64+PEUMjJM8ZWW86QQ254ieDe3MoSZrRcQJzUa4IASYGnnUJFjSS/a0Ax
         KEHmh01UDFwoL3LQJjOezKucQ6tyTnTzi0YiT2gG6pm+lPTQIAf1kc2NW6rJXVuBP6vO
         yLZ1KmunyqZS5G5ubbA+Qga1slWEDlNtcskIEjLtfbGHMv9bJ5GqwDXJ0oF2ifjhgMw3
         nPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=XHgIC24nGh94CW9lLVRVV+s+suVxXv3u7A1PnS3bpdU=;
        b=3tjHur7MFxrVTm8kbDoOb9DtFVh2oa5PaIdoUvQ5YNVvd6hF3e3BSbg/fpqy4dfyYT
         R84tjuQN6UCaBLIC48O99V+AuH12Evvr2nbIBLJhoikqDp3+3NTX9/fKXJB6lSt+tw6N
         tHQjaPtixrF5APHd3QGiBQxxrwaBiE6+beYZOat1uiLrsLqthHxf/9B2Cz8XzHfLNcjc
         uJTLWFfKYiP6XICmqwU+UeuuIn8MVD7l5l69lKFDTYtjN+JOfaPqmU4Z8hS87/v/KMV7
         p0tEZ8bnzZpwZglntUg4hyc02lT3oe7AKj6JCyu74M70YVznTA+rfHSEJSOcNQNrjFSf
         vC5g==
X-Gm-Message-State: ACgBeo3BU3Cy3RkSesos4nUKKLXeku/lYnmNkSVlGJIs7JMYjcgeFrEZ
        L0Q2aEnPLDTtuae63OPzXzaTFTkBoSLLEg==
X-Google-Smtp-Source: AA6agR4VbUFdVtaOW9jiMcmOPGsiZnPyrTwA6EPvk5CCZ9amrx84GTi35pVPOFgr2cg9l4YEowwOCw==
X-Received: by 2002:a05:6a00:1356:b0:538:1bf1:7cd with SMTP id k22-20020a056a00135600b005381bf107cdmr9830253pfu.32.1661826182086;
        Mon, 29 Aug 2022 19:23:02 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id c78-20020a621c51000000b00536531536adsm7916841pfc.47.2022.08.29.19.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 19:23:01 -0700 (PDT)
From:   Marvin Lin <milkfafa@gmail.com>
To:     linux-edac@vger.kernel.org, rric@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, mchehab@kernel.org, bp@alien8.de,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        benjaminfair@google.com, yuenn@google.com, venture@google.com,
        KWLIU@nuvoton.com, YSCHU@nuvoton.com, JJLIU0@nuvoton.com,
        KFTING@nuvoton.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, ctcchien@nuvoton.com, kflin@nuvoton.com,
        Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH v14 2/3] dt-bindings: edac: nuvoton: Add document for NPCM memory controller
Date:   Tue, 30 Aug 2022 10:22:37 +0800
Message-Id: <20220830022238.28379-3-milkfafa@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220830022238.28379-1-milkfafa@gmail.com>
References: <20220830022238.28379-1-milkfafa@gmail.com>
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
 .../edac/nuvoton,npcm-memory-controller.yaml  | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml

diff --git a/Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml b/Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml
new file mode 100644
index 000000000000..d5ef7e7a65f9
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/edac/nuvoton,npcm-memory-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton NPCM Memory Controller Device Tree Bindings
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
2.17.1

