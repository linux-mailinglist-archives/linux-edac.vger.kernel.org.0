Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2B7FCE224
	for <lists+linux-edac@lfdr.de>; Mon,  7 Oct 2019 14:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfJGMrv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 7 Oct 2019 08:47:51 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:43910 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbfJGMru (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 7 Oct 2019 08:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1570452469; x=1601988469;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=iFphmDVWG0qSLbmVu83gV0dPQ/BYDB46DDk1hmRpluc=;
  b=qWGd9RjGbB8j6qdCuOZlDKuCRrpz7SkOwyLPhofIIDhnDSQeAOQcPz4R
   e8HI1ucI6D4E0GO333/rXDen7q41HlevQUHvt8jg6iPJnbLIk5ZLKQgDv
   Uia6ZqxXP7HggFWbB91jnCRNGMOgb8fxQXksdOAIOfWg5vR26d6RLUNK0
   g=;
X-IronPort-AV: E=Sophos;i="5.67,268,1566864000"; 
   d="scan'208";a="756171455"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-53356bf6.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 07 Oct 2019 12:47:48 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-53356bf6.us-west-2.amazon.com (Postfix) with ESMTPS id 0AE89A1C2F;
        Mon,  7 Oct 2019 12:47:46 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 7 Oct 2019 12:47:46 +0000
Received: from udc4a3e82dbc15a031435.hfa15.amazon.com (10.43.162.245) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 7 Oct 2019 12:47:37 +0000
From:   Talel Shenhar <talel@amazon.com>
To:     <robh+dt@kernel.org>, <maz@kernel.org>, <mark.rutland@arm.com>,
        <arnd@arndb.de>, <bp@alien8.de>, <mchehab@kernel.org>,
        <james.morse@arm.com>, <davem@davemloft.net>,
        <gregkh@linuxfoundation.org>, <paulmck@linux.ibm.com>,
        <talel@amazon.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC:     <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <hhhawa@amazon.com>, <ronenk@amazon.com>, <jonnyc@amazon.com>,
        <hanochu@amazon.com>, <amirkl@amazon.com>, <barakw@amazon.com>
Subject: [PATCH v5 1/2] dt-bindings: soc: al-pos: Amazon's Annapurna Labs POS
Date:   Mon, 7 Oct 2019 15:47:14 +0300
Message-ID: <1570452435-8505-2-git-send-email-talel@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1570452435-8505-1-git-send-email-talel@amazon.com>
References: <1570452435-8505-1-git-send-email-talel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.245]
X-ClientProxiedBy: EX13D05UWB004.ant.amazon.com (10.43.161.208) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Document Amazon's Annapurna Labs POS SoC binding.

Signed-off-by: Talel Shenhar <talel@amazon.com>
---
 .../bindings/edac/amazon,al-pos-edac.yaml          | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/amazon,al-pos-edac.yaml

diff --git a/Documentation/devicetree/bindings/edac/amazon,al-pos-edac.yaml b/Documentation/devicetree/bindings/edac/amazon,al-pos-edac.yaml
new file mode 100644
index 00000000..048c2e9
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/amazon,al-pos-edac.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: GPL-2.0
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
+    edac@f0070084 {
+      compatible = "amazon,al-pos-edac";
+      reg = <0x0 0xf0070084 0x0 0x00000008>;
+      interrupt-parent = <&amazon_system_fabric>;
+      interrupts = <24 IRQ_TYPE_LEVEL_HIGH>;
+    };
-- 
2.7.4

