Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBB57E349F
	for <lists+linux-edac@lfdr.de>; Thu, 24 Oct 2019 15:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393765AbfJXNqY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 24 Oct 2019 09:46:24 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:32657 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393672AbfJXNqX (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 24 Oct 2019 09:46:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1571924783; x=1603460783;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=ZtTBJqS62bMTnPiDj6iWcN4i2rfnH830UkJ3srD0SVE=;
  b=VVzMCpzlky9RwfPt5g6ub1pG94Kf46PvoDh/uIeZhULCwcf05qppwMjm
   yLRpisiImFwyKaruTjPpr3oz9o0o1kqXP/BfFQfpVJL8wpny3E8HrIu0H
   sN8nUCZVxnwcAoKzPB1YekS6+KePpIc5FGs8CZyxIon5v2aLJNIWAeXEp
   c=;
IronPort-SDR: cR7bh5xAbiNLB44ltc2oFZaIAlIxemboL8qPXrC5WLnZikqtACwxS0KaZhqndVKSLZNPsi9NKy
 mg73ivfkV8YA==
X-IronPort-AV: E=Sophos;i="5.68,224,1569283200"; 
   d="scan'208";a="219252"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 24 Oct 2019 13:46:22 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com (Postfix) with ESMTPS id AC8D4A28D8;
        Thu, 24 Oct 2019 13:46:17 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 24 Oct 2019 13:46:16 +0000
Received: from udc4a3e82dbc15a031435.hfa15.amazon.com (10.43.161.34) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 24 Oct 2019 13:46:07 +0000
From:   Talel Shenhar <talel@amazon.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <james.morse@arm.com>, <talel@amazon.com>,
        <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <nicolas.ferre@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC:     <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <hhhawa@amazon.com>, <ronenk@amazon.com>, <jonnyc@amazon.com>,
        <hanochu@amazon.com>, <amirkl@amazon.com>, <barakw@amazon.com>
Subject: [PATCH v7 1/2] dt-bindings: soc: al-pos: Amazon's Annapurna Labs POS
Date:   Thu, 24 Oct 2019 16:45:45 +0300
Message-ID: <1571924746-8107-2-git-send-email-talel@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571924746-8107-1-git-send-email-talel@amazon.com>
References: <1571924746-8107-1-git-send-email-talel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.34]
X-ClientProxiedBy: EX13D21UWA004.ant.amazon.com (10.43.160.252) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Document Amazon's Annapurna Labs POS SoC binding.

Signed-off-by: Talel Shenhar <talel@amazon.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/edac/amazon,al-pos-edac.yaml          | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/amazon,al-pos-edac.yaml

diff --git a/Documentation/devicetree/bindings/edac/amazon,al-pos-edac.yaml b/Documentation/devicetree/bindings/edac/amazon,al-pos-edac.yaml
new file mode 100644
index 00000000..54afa43
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/amazon,al-pos-edac.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/edac/amazon,al-pos-edac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amazon's Annapurna Labs POS
+
+maintainers:
+  - Talel Shenhar <talel@amazon.com>
+  - Talel Shenhar <talelshenhar@gmail.com>
+
+description: |
+  POS node is defined to describe the Point Of Serialization (POS) error
+  detection capability.
+
+properties:
+
+  compatible:
+    const: "amazon,al-pos-edac"
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: Interrupt for the error event.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    edac@f0070084 {
+      compatible = "amazon,al-pos-edac";
+      reg = <0x0 0xf0070084 0x0 0x00000008>;
+      interrupt-parent = <&amazon_system_fabric>;
+      interrupts = <24 IRQ_TYPE_LEVEL_HIGH>;
+    };
-- 
2.7.4

