Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7414E2E12
	for <lists+linux-edac@lfdr.de>; Thu, 24 Oct 2019 12:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393165AbfJXKEE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 24 Oct 2019 06:04:04 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:23195 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfJXKEE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 24 Oct 2019 06:04:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1571911444; x=1603447444;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=gC16cAJMLu5WP+emoOhktH/MirBmX7dKyDnTJ3chBzo=;
  b=C8JgnPH8YHPVemn1jJsr9TrTZ326hsJmYxvrG2BvkeXa8fXAEQpwtQdg
   bggGRN7Y5iqhBwnsj7GWo/aaw5COVzDNCo3scqY0tO9pU+mjQwdjmZj3g
   momW76d/DtXmUwhUp3aDCSktH/G8g9E/5umPLRb2Yb9f5ctJn/615tAc6
   w=;
X-IronPort-AV: E=Sophos;i="5.68,224,1569283200"; 
   d="scan'208";a="762728929"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 24 Oct 2019 10:04:03 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com (Postfix) with ESMTPS id EE7C3A27C4;
        Thu, 24 Oct 2019 10:03:59 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 24 Oct 2019 10:03:59 +0000
Received: from udc4a3e82dbc15a031435.hfa15.amazon.com (10.43.162.31) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 24 Oct 2019 10:03:50 +0000
From:   Talel Shenhar <talel@amazon.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <james.morse@arm.com>, <talel@amazon.com>,
        <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <nicolas.ferre@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC:     <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <hhhawa@amazon.com>, <ronenk@amazon.com>, <jonnyc@amazon.com>,
        <hanochu@amazon.com>, <amirkl@amazon.com>, <barakw@amazon.com>
Subject: [PATCH v5 1/2] dt-bindings: edac: al-mc-edac: Amazon's Annapurna Labs Memory Controller EDAC
Date:   Thu, 24 Oct 2019 13:03:26 +0300
Message-ID: <1571911407-29379-2-git-send-email-talel@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571911407-29379-1-git-send-email-talel@amazon.com>
References: <1571911407-29379-1-git-send-email-talel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.31]
X-ClientProxiedBy: EX13D17UWB001.ant.amazon.com (10.43.161.252) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Document Amazon's Annapurna Labs Memory Controller EDAC SoC binding.

Signed-off-by: Talel Shenhar <talel@amazon.com>
---
 .../bindings/edac/amazon,al-mc-edac.yaml           | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml

diff --git a/Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml b/Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml
new file mode 100644
index 00000000..20505f37
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: GPL-2.0-only
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
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    edac@f0080000 {
+      compatible = "amazon,al-mc-edac";
+      reg = <0x0 0xf0080000 0x0 0x00010000>;
+      interrupt-parent = <&amazon_al_system_fabric>;
+      interrupt-names = "ue";
+      interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
+    };
-- 
2.7.4

