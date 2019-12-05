Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDCDB113E97
	for <lists+linux-edac@lfdr.de>; Thu,  5 Dec 2019 10:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbfLEJxH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 5 Dec 2019 04:53:07 -0500
Received: from a27-185.smtp-out.us-west-2.amazonses.com ([54.240.27.185]:33132
        "EHLO a27-185.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726096AbfLEJxG (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 5 Dec 2019 04:53:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575539585;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
        bh=Ce3K11ERWLy+EF9gQF7x6AErPgl+OIA/TJqM7S8904Q=;
        b=GFlGfJI5//kYwgHawj4P6rt7n0Dz6aIiFCznYNyTXCRNF+Squz+mOnrMvG0AyJge
        tliMd7qeKh6we9Uu63YxnuFJgBjyIQ3ksEGEE6p7+tRmQTQtWArxBwj5osVw6qSeNKo
        eo6AdEyUpcIFcyO1pwazO+XtEhx6JaXOCAoCi604=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575539585;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
        bh=Ce3K11ERWLy+EF9gQF7x6AErPgl+OIA/TJqM7S8904Q=;
        b=B9FgIw6n6jdfkwrdR1o/6xJBvwtudhA5eI9PlmwPpIkh09Bsyg0V1JnCHCqHO/c6
        fSHj3XBbi+x6/hM3ciMQ74doU7Iy7C9DeBKMPAWbmZuMP6fOcqjK+SJekdJTYPbRv9R
        GS7Kh1EAU6G17n0IX+knDzUTb7bGJCNuomMA8pGo=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A4863C447B4
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        linux-edac@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>, tsoni@codeaurora.org,
        psodagud@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCH 1/2] dt-bindings: edac: Add DT bindings for Kryo EDAC
Date:   Thu, 5 Dec 2019 09:53:05 +0000
Message-ID: <0101016ed57a3259-eee09e9e-e99a-40f1-ab1c-63e58a42615c-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1575529553.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1575529553.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2019.12.05-54.240.27.185
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This adds DT bindings for Kryo EDAC implemented with RAS
extensions on KRYO{3,4}XX CPU cores for reporting of cache
errors.

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 .../bindings/edac/qcom-kryo-edac.yaml         | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/qcom-kryo-edac.yaml

diff --git a/Documentation/devicetree/bindings/edac/qcom-kryo-edac.yaml b/Documentation/devicetree/bindings/edac/qcom-kryo-edac.yaml
new file mode 100644
index 000000000000..1a39429a73b4
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/qcom-kryo-edac.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/edac/qcom-kryo-edac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Kryo Error Detection and Correction(EDAC)
+
+maintainers:
+  - Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
+
+description: |
+  Kryo EDAC is defined to describe on-chip error detection and correction
+  for the Kryo CPU cores which implement RAS extensions. It will report
+  all Single Bit Errors and Double Bit Errors found in L1/L2 caches in
+  in two registers ERXSTATUS_EL1 and ERXMISC0_EL1. L3-SCU cache errors
+  are reported in ERR1STATUS and ERR1MISC0 registers.
+    ERXSTATUS_EL1 - Selected Error Record Primary Status Register, EL1
+    ERXMISC0_EL1 - Selected Error Record Miscellaneous Register 0, EL1
+    ERR1STATUS - Error Record Primary Status Register
+    ERR1MISC0 - Error Record Miscellaneous Register 0
+  Current implementation of Kryo ECC(Error Correcting Code) mechanism is
+  based on interrupts.
+
+properties:
+  compatible:
+    enum:
+      - qcom,kryo-edac
+
+  interrupts:
+    minItems: 1
+    maxItems: 4
+    items:
+      - description: l1-l2 cache faultirq interrupt
+      - description: l1-l2 cache errirq interrupt
+      - description: l3-scu cache errirq interrupt
+      - description: l3-scu cache faultirq interrupt
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 4
+    items:
+      - const: l1-l2-faultirq
+      - const: l1-l2-errirq
+      - const: l3-scu-errirq
+      - const: l3-scu-faultirq
+
+required:
+  - compatible
+  - interrupts
+  - interrupt-names
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    kryo_edac {
+      compatible = "qcom,kryo-edac";
+      interrupts = <GIC_PPI 6 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-names = "l1-l2-faultirq",
+                        "l1-l2-errirq",
+                        "l3-scu-errirq",
+                        "l3-scu-faultirq";
+    };
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

