Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A69164E7C7
	for <lists+linux-edac@lfdr.de>; Fri, 16 Dec 2022 08:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiLPHcQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 16 Dec 2022 02:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiLPHcN (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 16 Dec 2022 02:32:13 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24AD3D393;
        Thu, 15 Dec 2022 23:32:12 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id a14so1239648pfa.1;
        Thu, 15 Dec 2022 23:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmFkFrSKnE5UGV/FeBagKO6cow8ZrY/ENIxZIsA8ZEo=;
        b=Rqv6ctUPh65ooObUJAc+XBE63AmQwLkaQjwUl5tlyK0bXkU2Tj8rLaxwvw475iArhg
         QMAhdKYDDqxHGIpWfi9QbKmuA4ovYujkBXIgSkI565jZhVq8j4gnACL+3swSv6v19Kz9
         HQ1G2EMLwInxAYHK2DULn0aIV5HZjFzZjt/YQpigtbIMOF6mzJh1Xab/jdaCz4Tw+Fdp
         ngcuTCvQhxl8itbB9HLd5dv2Lwo2F+4HDzyh9BkL8Noj2pJVl61IqNRluNmGAn52zACo
         AAqPlScoKHzThh0jLhdyZ+JwWUerpZEp4yGXO2gNQ9W77dWzYdOBta2eh0oi+9Ast+zQ
         /U8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SmFkFrSKnE5UGV/FeBagKO6cow8ZrY/ENIxZIsA8ZEo=;
        b=i8MLU3QHqNz7qxxh6v5pRw4U69exPBJMBrJfjtXzDZCWabe0kCnaROQOMqbF3p+O/R
         /74S7n/EhrAlxib2Vj5cWcA+e8fsxjPszAmy+Aa3BCpFJE+1u0XQJZsQan02O7n4mX3i
         doQrXvZdp0L4RsdUcLJMJP7WnDBm9/34clr1AW2QsdS+eAPZ1s0slvy99YgEWMuoLO92
         5VHx+CFVPuerUNPbPp94nQqofWfGBhGt5ScUXJXrGZnQOD1AzFm93OuTq2+6b8rXzXi7
         ng3+TwpuirKg01wCkLTqIdxjvL5IytBHqURB1LeYpav7/0i03vmgZfU8NxSXWvwkF9ha
         8DkA==
X-Gm-Message-State: ANoB5pnMBf6wwtLJt8bHFVW+U0Kbfa6WtmFIAKDd8xijAEPEijbsC3Ct
        y/lcHTayQ9ONpYZpUXdeq9Fv5Q3pPlLnRg==
X-Google-Smtp-Source: AA0mqf6ithiPn84o576XYEzrdVRRYLuLgSHP7552KuoA1fiuLqt+OGGzM2EAAydlcbTIbSwcmvzpQA==
X-Received: by 2002:aa7:9243:0:b0:566:900d:5ae8 with SMTP id 3-20020aa79243000000b00566900d5ae8mr29818336pfp.24.1671175932028;
        Thu, 15 Dec 2022 23:32:12 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 193-20020a6217ca000000b00574cf11aaf3sm770123pfx.208.2022.12.15.23.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 23:32:11 -0800 (PST)
From:   Marvin Lin <milkfafa@gmail.com>
To:     linux-edac@vger.kernel.org, rric@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, mchehab@kernel.org, bp@alien8.de,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski@linaro.org
Cc:     openbmc@lists.ozlabs.org, benjaminfair@google.com,
        yuenn@google.com, venture@google.com, KWLIU@nuvoton.com,
        YSCHU@nuvoton.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, ctcchien@nuvoton.com, kflin@nuvoton.com,
        Marvin Lin <milkfafa@gmail.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH v16 2/3] dt-bindings: edac: nuvoton: Add document for NPCM memory controller
Date:   Fri, 16 Dec 2022 15:31:40 +0800
Message-Id: <20221216073141.3289309-3-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221216073141.3289309-1-milkfafa@gmail.com>
References: <20221216073141.3289309-1-milkfafa@gmail.com>
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

