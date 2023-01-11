Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767CF665797
	for <lists+linux-edac@lfdr.de>; Wed, 11 Jan 2023 10:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjAKJfx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 11 Jan 2023 04:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbjAKJet (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 11 Jan 2023 04:34:49 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA8311A3F;
        Wed, 11 Jan 2023 01:33:16 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id z4-20020a17090a170400b00226d331390cso16478732pjd.5;
        Wed, 11 Jan 2023 01:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04Pq7MkT+QYZidf+j7cMLtCJPnocBGHBHBGxy1XfZlE=;
        b=bU6uyyVagRm7mOv1aZ3gQz55Eoy5d+bMIfNCDZeFW2tgO4h8L5idJVgledXrTlMS93
         foXhEPpu4pq9eItwhj6dY8bzLE7FcOfLn4crPPTqRsjLUcbpHoOtrpvQW0Q9EC1a7SZN
         WnPwjlAUK5tt9YZUh+vAGtCd5ELdq/NlQ+DmrPlYUkKrJ+SC8SaH42038za5+9ry12/m
         k9bdZpZpfBKN8fSEoRd7ggZuloaViSjtkLAIqciLNgaUnXmFkEp+L3rfhta2kudjKZ/b
         IEY+dL1TjAjEFbktwZ8lXbjOPfUIowuNYioBr3O3HcypVQQSPaS4u8VTV/OTSCxWMuZu
         FIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04Pq7MkT+QYZidf+j7cMLtCJPnocBGHBHBGxy1XfZlE=;
        b=VE73wO4GgJ+MR5x2VlHjGR3z2b7G89H/9rnNHb9eh8Kpg6oawvvLOU57U8pcd92pw9
         lLIW3A9PQmMNT6SHhGFeQ2YoLoXY6rDsOeBeltZBcEdfH3GdPcp3yw1zv1DfcZxtBitW
         5K4crgr9mg6hr8ECICvjnR+77oU46Sk2MgpDx+u/OWy2wWrQEWyO6+j5tga9gdbLygNF
         QI5x3Xv0Z3RAy5f8ZpMyUNrf7clZaGYL1OQ/jP8vq4zCuIvt0GMz91oFiovbRKOJ7+6I
         VrI/56bDh4mYYWdiUNZkJW4tpUoN4oPcXUYjTyhgY9HMqFqVFT6lTioQSv5VDksuw6V0
         TEHg==
X-Gm-Message-State: AFqh2kpIQOn6KnA98uxzg06TRDUn0L03pHjRkV3wKrhBLlKv63o/Yv/+
        VL1TPtxW8RQ47Unx+3IyM2M=
X-Google-Smtp-Source: AMrXdXvEgyl+40V2qNwoQJiAL/kOPJkH3yxsQ5OkOicj4z59EPaUdL4YO7z+LKm32SXN3zr4DDtYXw==
X-Received: by 2002:a17:902:c702:b0:191:2a9b:ec9b with SMTP id p2-20020a170902c70200b001912a9bec9bmr68842416plp.67.1673429595971;
        Wed, 11 Jan 2023 01:33:15 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902714600b001769e6d4fafsm2001341plm.57.2023.01.11.01.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 01:33:15 -0800 (PST)
From:   Marvin Lin <milkfafa@gmail.com>
To:     krzysztof.kozlowski@linaro.org, robh+dt@kernel.org, bp@alien8.de,
        tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
        rric@kernel.org, benjaminfair@google.com, yuenn@google.com,
        venture@google.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        KWLIU@nuvoton.com, YSCHU@nuvoton.com, ctcchien@nuvoton.com,
        kflin@nuvoton.com, Marvin Lin <milkfafa@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v18 2/3] dt-bindings: memory-controllers: nuvoton: Add NPCM memory controller
Date:   Wed, 11 Jan 2023 17:32:44 +0800
Message-Id: <20230111093245.318745-3-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230111093245.318745-1-milkfafa@gmail.com>
References: <20230111093245.318745-1-milkfafa@gmail.com>
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
 .../nuvoton,npcm-memory-controller.yaml       | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nuvoton,npcm-memory-controller.yaml

diff --git a/Documentation/devicetree/bindings/memory-controllers/nuvoton,npcm-memory-controller.yaml b/Documentation/devicetree/bindings/memory-controllers/nuvoton,npcm-memory-controller.yaml
new file mode 100644
index 000000000000..ac1a5a17749d
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/nuvoton,npcm-memory-controller.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/nuvoton,npcm-memory-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton NPCM Memory Controller
+
+maintainers:
+  - Marvin Lin <kflin@nuvoton.com>
+  - Stanley Chu <yschu@nuvoton.com>
+
+description: |
+  The Nuvoton BMC SoC supports DDR4 memory with or without ECC (error correction
+  check).
+
+  The memory controller supports single bit error correction, double bit error
+  detection (in-line ECC in which a section (1/8th) of the memory device used to
+  store data is used for ECC storage).
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
+
+    mc: memory-controller@f0824000 {
+        compatible = "nuvoton,npcm750-memory-controller";
+        reg = <0xf0824000 0x1000>;
+        interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+    };
-- 
2.34.1

