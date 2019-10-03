Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F097C9D64
	for <lists+linux-edac@lfdr.de>; Thu,  3 Oct 2019 13:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729989AbfJCLdb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 3 Oct 2019 07:33:31 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:25458 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729977AbfJCLdb (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 3 Oct 2019 07:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1570102410; x=1601638410;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=+L4XG33zAeTwUOVbDcEUaW5WSc5Q+qUSuBUjq9qmDEY=;
  b=vipYrLhv+GcBEzZO485YNuPX0A300gHXRHycsY39ne46KDHlQ0wDFJsm
   SukL69Sfu43pLcisqf48H1YeRO4e3UoIE/Sa3Hn8WNNh/6tKzRzE8yyZb
   pMpt4+ANLtKD0paZVy2LJinwQE13KYzFbJNK0QzRZP2pQP/IWv7sO5/eZ
   A=;
X-IronPort-AV: E=Sophos;i="5.67,251,1566864000"; 
   d="scan'208";a="419556222"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 03 Oct 2019 11:33:28 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com (Postfix) with ESMTPS id D89CDA1C0A;
        Thu,  3 Oct 2019 11:33:27 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 3 Oct 2019 11:33:27 +0000
Received: from udc4a3e82dbc15a031435.hfa15.amazon.com (10.43.161.7) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 3 Oct 2019 11:33:18 +0000
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
Subject: [PATCH v4 1/2] dt-bindings: soc: al-pos: Amazon's Annapurna Labs POS
Date:   Thu, 3 Oct 2019 14:32:40 +0300
Message-ID: <1570102361-11696-2-git-send-email-talel@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1570102361-11696-1-git-send-email-talel@amazon.com>
References: <1570102361-11696-1-git-send-email-talel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.7]
X-ClientProxiedBy: EX13D06UWA004.ant.amazon.com (10.43.160.164) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Document Amazon's Annapurna Labs POS SoC binding.

Signed-off-by: Talel Shenhar <talel@amazon.com>
---
 .../bindings/edac/amazon,al-pos-edac.yaml          | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/amazon,al-pos-edac.yaml

diff --git a/Documentation/devicetree/bindings/edac/amazon,al-pos-edac.yaml b/Documentation/devicetree/bindings/edac/amazon,al-pos-edac.yaml
new file mode 100644
index 00000000..7936da0
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/amazon,al-pos-edac.yaml
@@ -0,0 +1,39 @@
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
+    - const: "amazon,al-pos-edac"
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
+    al_pos_edac@f0070084 {
+      compatible = "amazon,al-pos-edac";
+      reg = <0x0 0xf0070084 0x0 0x00000008>;
+      interrupt-parent = <&amazon_system_fabric>;
+      interrupts = <24 IRQ_TYPE_LEVEL_HIGH>;
+    };
-- 
2.7.4

