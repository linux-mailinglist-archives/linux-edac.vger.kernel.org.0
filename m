Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD09C654BBA
	for <lists+linux-edac@lfdr.de>; Fri, 23 Dec 2022 04:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236091AbiLWD3o (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 22 Dec 2022 22:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236093AbiLWD3k (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 22 Dec 2022 22:29:40 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC4A31DCC;
        Thu, 22 Dec 2022 19:29:40 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id x66so2522976pfx.3;
        Thu, 22 Dec 2022 19:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04Pq7MkT+QYZidf+j7cMLtCJPnocBGHBHBGxy1XfZlE=;
        b=eiKDhrRitL5X7q82QImmYTLqGN3/rojsRvebXvRXziiZLvsAzFFznqh9e5kWgNa5Fq
         VJxoUNYQUEjNDm5QPSlpBSlWRq7HfmwwPRUCHKB6kaS0WcSV/I0t4IDE9e7YEjTWbgjy
         R2sd1k6MhPq6fCZ+PZQjO9dvGBTru8LafLhdyG7H4E3QhZ4Zfus4AV4fFDxJj4hLoYMz
         vVp3fd5iWoxI5Rd5PypOBWdU4J2pnNy4khOxjPSMcT/UFYvwQjn65LpMd+HiB0Tv/9kZ
         yJpJVXSePfUTG25WiB5vdi6nWPAaIG6oA7Yr4i7Y9csrTqOEqQH7aU/j/9UDquHUr3oy
         zrJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04Pq7MkT+QYZidf+j7cMLtCJPnocBGHBHBGxy1XfZlE=;
        b=1FPcw/Rfs5jWQEv7KxxSPllxRNsosdCsA1oHUrRPx8lwWmE9gotVy0SkgTB8YkG4xB
         pecfG/8JRUiPB21lbNaJmxqRbw49jhGHbgFes36YtPLzjMNNA9+4b0WjjX/IA+9rJS0x
         GyRXig7+8RWStctoJUrPGAu1CPi+MYdRd6JhBx+b/Cj17PkYRgr1QLy74AZFpjQDJIrF
         U404x9Omhx7Jpri0fm08xbNHto1KoTYD5H0A3RElT5jYWq86uIBtSFbWnDDDDBXF+cI9
         jgzU2h7M2CRTeXxP0aw4ChdC4/7ePnIdX7rhK/VKs2FP3k2biOO5LdFkpSSl5hOuxg+B
         KAdg==
X-Gm-Message-State: AFqh2kqmU39xyOzoA3Ft63Rgn05s8enFd0qnw7Orvdq1vmYSpckCKMWv
        AKXuGa+I0xZ5Gy3CTDPPR7c=
X-Google-Smtp-Source: AMrXdXvt2lWXgZj5PD6wg5sd+uLWfCCJD30dRedp8RD5v4RR5vQTGESsaCIV4BjsQh0lwKBT2PGvdg==
X-Received: by 2002:a05:6a00:1d03:b0:573:a0a0:c5d2 with SMTP id a3-20020a056a001d0300b00573a0a0c5d2mr9368639pfx.7.1671766179660;
        Thu, 22 Dec 2022 19:29:39 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id w192-20020a6282c9000000b00575448ab0e9sm1376854pfd.123.2022.12.22.19.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 19:29:39 -0800 (PST)
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
Subject: [PATCH v17 2/3] dt-bindings: edac: nuvoton: Add document for NPCM memory controller
Date:   Fri, 23 Dec 2022 11:28:58 +0800
Message-Id: <20221223032859.3055638-3-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221223032859.3055638-1-milkfafa@gmail.com>
References: <20221223032859.3055638-1-milkfafa@gmail.com>
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

