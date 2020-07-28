Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722EF230707
	for <lists+linux-edac@lfdr.de>; Tue, 28 Jul 2020 11:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgG1Jwe (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 28 Jul 2020 05:52:34 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:55083 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728277AbgG1Jwe (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 28 Jul 2020 05:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1595929954; x=1627465954;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Xv6O8YcpDOqDU4VhzNG2lK83aUpYO35qo0XMHB+BvlI=;
  b=kZs7cKS7NXmKxX1qbWIzCzqwh1Ky+mNXW34QLGF7+r2TpfW7MKP2Rq8b
   wrbY7bgVmMxdBpZsYe7J/BiIqlqvcS1M6KXJ5jxzpjNZ6OoOZ7aKrMxHd
   WYQ3rx9afXWTgkzWfMX5EJffV2bSfTM/DA06H7eqsPc6itR6PwRadSmCa
   4=;
IronPort-SDR: 3MRMBesoA5+836qHKzfE7B6MFMvA7weAXNc6p417RUWri8IlxoNzd4cAO9l29+eRgzeA87qrHb
 o15V2UlzCaTA==
X-IronPort-AV: E=Sophos;i="5.75,405,1589241600"; 
   d="scan'208";a="44504125"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-53356bf6.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 28 Jul 2020 09:52:32 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-53356bf6.us-west-2.amazon.com (Postfix) with ESMTPS id 88CD2A2778;
        Tue, 28 Jul 2020 09:52:30 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 28 Jul 2020 09:52:29 +0000
Received: from uf25486d27d2d5b.ant.amazon.com (10.43.161.71) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 28 Jul 2020 09:52:21 +0000
From:   Talel Shenhar <talel@amazon.com>
To:     <bp@alien8.de>, <mchehab@kernel.org>, <james.morse@arm.com>,
        <talel@amazon.com>, <davem@davemloft.net>,
        <gregkh@linuxfoundation.org>, <nicolas.ferre@microchip.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linux-edac@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <hhhawa@amazon.com>, <ronenk@amazon.com>, <jonnyc@amazon.com>,
        <hanochu@amazon.com>, <eitan@amazon.com>
Subject: [PATCH v9 1/2] dt-bindings: edac: al-mc-edac: Amazon's Annapurna Labs Memory Controller EDAC
Date:   Tue, 28 Jul 2020 12:51:54 +0300
Message-ID: <20200728095155.18506-2-talel@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200728095155.18506-1-talel@amazon.com>
References: <20200728095155.18506-1-talel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.71]
X-ClientProxiedBy: EX13D34UWC002.ant.amazon.com (10.43.162.137) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Document Amazon's Annapurna Labs Memory Controller EDAC SoC binding.

Signed-off-by: Talel Shenhar <talel@amazon.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/edac/amazon,al-mc-edac.yaml      | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml

diff --git a/Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml b/Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml
new file mode 100644
index 000000000000..a25387df0865
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/edac/amazon,al-mc-edac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amazon's Annapurna Labs Memory Controller EDAC
+
+maintainers:
+  - Talel Shenhar <talel@amazon.com>
+  - Talel Shenhar <talelshenhar@gmail.com>
+
+description: |
+  EDAC node is defined to describe on-chip error detection and correction for
+  Amazon's Annapurna Labs Memory Controller.
+
+properties:
+
+  compatible:
+    const: amazon,al-mc-edac
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 2
+
+  "#size-cells":
+    const: 2
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+    items:
+      - description: uncorrectable error interrupt
+      - description: correctable error interrupt
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      - const: ue
+      - const: ce
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        edac@f0080000 {
+          #address-cells = <2>;
+          #size-cells = <2>;
+          compatible = "amazon,al-mc-edac";
+          reg = <0x0 0xf0080000 0x0 0x00010000>;
+          interrupt-parent = <&amazon_al_system_fabric>;
+          interrupt-names = "ue";
+          interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
-- 
2.17.1

