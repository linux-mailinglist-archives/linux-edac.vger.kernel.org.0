Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F25CCC9DC6
	for <lists+linux-edac@lfdr.de>; Thu,  3 Oct 2019 13:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbfJCLuA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 3 Oct 2019 07:50:00 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:21215 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfJCLuA (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 3 Oct 2019 07:50:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1570103398; x=1601639398;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=WY5GNASin+RjuIanTGocjZ1/56DxZcULXNDQo/JU2QI=;
  b=of/jQcGf9Mwp1q90UDD5NSH3un7TA5Jf0STlAHYdHDP3pqo9wBSYH6gp
   AvQRghrLOTmNtJaEMlG7bPb5RvM+gu2+kCPNCCyqoymNw/Cd5ZVxGPdkF
   SRD680myUk55f4Edco+mc4xEvqJKmfV21HkIatXWCdIh715XPT/WmQkVc
   g=;
X-IronPort-AV: E=Sophos;i="5.67,251,1566864000"; 
   d="scan'208";a="789349510"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 03 Oct 2019 11:49:57 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com (Postfix) with ESMTPS id 0A738A2E56;
        Thu,  3 Oct 2019 11:49:53 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 3 Oct 2019 11:49:53 +0000
Received: from udc4a3e82dbc15a031435.hfa15.amazon.com (10.43.161.223) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 3 Oct 2019 11:49:43 +0000
From:   Talel Shenhar <talel@amazon.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <james.morse@arm.com>, <talel@amazon.com>,
        <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <paulmck@linux.ibm.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC:     <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <hhhawa@amazon.com>, <ronenk@amazon.com>, <jonnyc@amazon.com>,
        <hanochu@amazon.com>, <amirkl@amazon.com>, <barakw@amazon.com>
Subject: [PATCH v3 1/2] dt-bindings: edac: al-mc-edac: Amazon's Annapurna Labs Memory Controller EDAC
Date:   Thu, 3 Oct 2019 14:49:22 +0300
Message-ID: <1570103363-21486-2-git-send-email-talel@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1570103363-21486-1-git-send-email-talel@amazon.com>
References: <1570103363-21486-1-git-send-email-talel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.223]
X-ClientProxiedBy: EX13D10UWB003.ant.amazon.com (10.43.161.106) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Document Amazon's Annapurna Labs Memory Controller EDAC SoC binding.

Signed-off-by: Talel Shenhar <talel@amazon.com>
---
 .../bindings/edac/amazon,al-mc-edac.yaml           | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml

diff --git a/Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml b/Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml
new file mode 100644
index 0000000..33da051
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: GPL-2.0
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
+    - const: "amazon,al-mc-edac"
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
+
+examples:
+  - |
+    edac@f0080000 {
+      compatible = "amazon,al-mc-edac";
+      reg = <0x0 0xf0080000 0x0 0x00010000>;
+      interrupt-parent = <&amazon_al_system_fabric>;
+      interrupt-names = "ue";
+      interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
+    };
-- 
2.7.4

