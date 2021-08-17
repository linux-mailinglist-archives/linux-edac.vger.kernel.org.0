Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C7F3EEA13
	for <lists+linux-edac@lfdr.de>; Tue, 17 Aug 2021 11:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236074AbhHQJkm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 17 Aug 2021 05:40:42 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:36714
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235668AbhHQJkj (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Tue, 17 Aug 2021 05:40:39 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id BF1013F09F
        for <linux-edac@vger.kernel.org>; Tue, 17 Aug 2021 09:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629193200;
        bh=YL4I+/3FxyPUFZSenvPrl5nRwbLh6LxmLfvqc1D9xQI=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=mUiosdQ3r+s/n130qzoeZeyILiQ7OC229Vx3T9XT9+wR3Yxk5QhH+Iq9AFY5LdhKN
         II9tPh4/dZi8LuGkvxkE4OibRTw4JbkCIumI0gf2uPPVdlVhyP6k17yCRV/F0UMrUD
         jxrQudHMR+JCOpXIRLBjEebUjDoJlabIGn+9+X8dRvKgqGuzpc4sdjxNDnaOm7qQ6U
         UegvY9BDj9lHw/n2Sft1fx8YRlp3s437kLbLEOIoqCt2z07ARrp1DXAf8jL6x5J2+w
         IgrV10+Y/t2VCjEubuX97FUb7WlqG6qMCw3rBfyS7znnqIznlDDZx48TkyduF/FAVa
         26BkauuNCnoxg==
Received: by mail-ed1-f70.google.com with SMTP id x4-20020a50d9c4000000b003bed5199871so4136308edj.14
        for <linux-edac@vger.kernel.org>; Tue, 17 Aug 2021 02:40:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YL4I+/3FxyPUFZSenvPrl5nRwbLh6LxmLfvqc1D9xQI=;
        b=TbiFCDaXgE7agCesM3cdPyMY1mKRK6OWbL24YNFA6wIi/+Vsp155Bm5ulK5Zt7+IA5
         xl5WLKtII6ks1stQAp9tfyjs05nsssNWjw1bl9Bok9io3FOJAMC3FfhLWqdTZwWjNxOn
         39TdIF3ZWAy4uP7QAIQlCf7IVq9noSvjGj7AQTviC3aLON++Q/ZSrNJwgKk+wepnkgGt
         0US5xW1UG+D08/9w45Z+1+7bp3kNGhGmZssfAiXduYjLpiStkCxwE/kDuJFF2UFUraN7
         20ISWppowmBR0WvTjjw4mu5c0LYoeq+pCtwx4wsfcIdkRMerKvu+xpF5TfEGLGbIdWpS
         dIOA==
X-Gm-Message-State: AOAM532lr747+7DN6Gie4OxHANrEykHwnai7bV7duB/bek21o6rRx8KF
        JVVdObcRU5EizehCXYuj9dMceqzLvkvqqxCNF7wWovPiDCv0+7aXx3kixNH8NonR645l/aCmH/f
        ago84V53kF5woTusdCaGoNXXagmI1X9qoKS9mAV8=
X-Received: by 2002:aa7:c40a:: with SMTP id j10mr3080337edq.133.1629193200556;
        Tue, 17 Aug 2021 02:40:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyP7UchvSb44LTQyUkMc1SNkzvXT8lu+tCownUHhUdvG0CPxNUo8oW+qdDebxZemYIHtntXnA==
X-Received: by 2002:aa7:c40a:: with SMTP id j10mr3080326edq.133.1629193200439;
        Tue, 17 Aug 2021 02:40:00 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id sa21sm515667ejb.108.2021.08.17.02.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 02:39:59 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Jan Luebbe <jlu@pengutronix.de>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: memory: convert Marvell MVEBU SDRAM controller to dtschema
Date:   Tue, 17 Aug 2021 11:38:06 +0200
Message-Id: <20210817093807.59531-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Convert Marvell MVEBU SDRAM controller bindings to DT schema format
using json-schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../marvell,mvebu-sdram-controller.yaml       | 31 +++++++++++++++++++
 .../mvebu-sdram-controller.txt                | 21 -------------
 2 files changed, 31 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/marvell,mvebu-sdram-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/mvebu-sdram-controller.txt

diff --git a/Documentation/devicetree/bindings/memory-controllers/marvell,mvebu-sdram-controller.yaml b/Documentation/devicetree/bindings/memory-controllers/marvell,mvebu-sdram-controller.yaml
new file mode 100644
index 000000000000..14a6bc8f421f
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/marvell,mvebu-sdram-controller.yaml
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/marvell,mvebu-sdram-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell MVEBU SDRAM controller
+
+maintainers:
+  - Jan Luebbe <jlu@pengutronix.de>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+properties:
+  compatible:
+    const: marvell,armada-xp-sdram-controller
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    memory-controller@1400 {
+        compatible = "marvell,armada-xp-sdram-controller";
+        reg = <0x1400 0x500>;
+    };
diff --git a/Documentation/devicetree/bindings/memory-controllers/mvebu-sdram-controller.txt b/Documentation/devicetree/bindings/memory-controllers/mvebu-sdram-controller.txt
deleted file mode 100644
index 89657d1d4cd4..000000000000
--- a/Documentation/devicetree/bindings/memory-controllers/mvebu-sdram-controller.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-Device Tree bindings for MVEBU SDRAM controllers
-
-The Marvell EBU SoCs all have a SDRAM controller. The SDRAM controller
-differs from one SoC variant to another, but they also share a number
-of commonalities.
-
-For now, this Device Tree binding documentation only documents the
-Armada XP SDRAM controller.
-
-Required properties:
-
- - compatible: for Armada XP, "marvell,armada-xp-sdram-controller"
- - reg: a resource specifier for the register space, which should
-   include all SDRAM controller registers as per the datasheet.
-
-Example:
-
-sdramc@1400 {
-	compatible = "marvell,armada-xp-sdram-controller";
-	reg = <0x1400 0x500>;
-};
-- 
2.30.2

