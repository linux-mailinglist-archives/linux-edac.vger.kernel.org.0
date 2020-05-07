Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE991C90B4
	for <lists+linux-edac@lfdr.de>; Thu,  7 May 2020 16:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgEGOu7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 7 May 2020 10:50:59 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:30953 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbgEGOu6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 7 May 2020 10:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1588863057; x=1620399057;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=8GxZ5JWaOF5dn92Ks/d0RZ9+Pn/zgloMkgU+aU97AqA=;
  b=tBO1gh+bP8bvdAQtQj0RKYn6OzBvzvBwPBX49ObsfROMnelUTncp7dBA
   fwZu0vvw8Wc7bIxyPBxW1qp+5Ej6ja+E4yNn/2GTRZ4Qgni10onm5iYSd
   sGY+ihRCfoDHXd/NdxVWXmSKthn5ZC6rf/5xhQnTHrZnDWb3DyWEUDgFH
   c=;
IronPort-SDR: UEJZk9DZwIeWEBZQ19joB9qGIH5Isb2hyLAQgICV8zK4hgBUf4k54zDJrFfHdprBjugHv3iHXO
 gCdieeaZyYyQ==
X-IronPort-AV: E=Sophos;i="5.73,364,1583193600"; 
   d="scan'208";a="30530374"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-168cbb73.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 07 May 2020 14:50:41 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-168cbb73.us-west-2.amazon.com (Postfix) with ESMTPS id 89215A1C36;
        Thu,  7 May 2020 14:50:40 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 7 May 2020 14:50:40 +0000
Received: from uf25486d27d2d5b.ant.amazon.com (10.43.162.200) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 7 May 2020 14:50:30 +0000
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
Subject: [PATCH v7 1/2] dt-bindings: edac: al-mc-edac: Amazon's Annapurna Labs Memory Controller EDAC
Date:   Thu, 7 May 2020 17:50:01 +0300
Message-ID: <20200507145002.22010-2-talel@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507145002.22010-1-talel@amazon.com>
References: <20200507145002.22010-1-talel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.200]
X-ClientProxiedBy: EX13D25UWB003.ant.amazon.com (10.43.161.33) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Document Amazon's Annapurna Labs Memory Controller EDAC SoC binding.

Signed-off-by: Talel Shenhar <talel@amazon.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/edac/amazon,al-mc-edac.yaml      | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml

diff --git a/Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml b/Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml
new file mode 100644
index 000000000000..543f0a6be2f0
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml
@@ -0,0 +1,52 @@
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
2.17.1

