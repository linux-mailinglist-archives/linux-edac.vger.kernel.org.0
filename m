Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDB4B2EAB
	for <lists+linux-edac@lfdr.de>; Sun, 15 Sep 2019 08:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbfIOGoo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 15 Sep 2019 02:44:44 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:27890 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfIOGoo (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 15 Sep 2019 02:44:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568529882; x=1600065882;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=K8qHOy9fVvlLJRAIk73fH7CpEDoCuO1D+QYFSr26fIE=;
  b=I44xiNrA2YVoDLvpyLna2lgmXktd7T5+QXXHw07jrMu5TQQtyR+/x/MU
   c0PHl3P91vLmJxTfzcoC/BiiAsuDAdasFLq1T45ODpfjCFCL9/jIc9emx
   mV0EwDqUbrngcsMgsRLJpIzZfVVaz1ebdA9StRlMN69BfJjj2ybBvJlM3
   8=;
X-IronPort-AV: E=Sophos;i="5.64,506,1559520000"; 
   d="scan'208";a="832100191"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 15 Sep 2019 06:44:39 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com (Postfix) with ESMTPS id B7E87A23F6;
        Sun, 15 Sep 2019 06:44:39 +0000 (UTC)
Received: from EX13D01EUB002.ant.amazon.com (10.43.166.113) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 15 Sep 2019 06:44:39 +0000
Received: from udc4a3e82dbc15a031435.hfa15.amazon.com (10.43.161.34) by
 EX13D01EUB002.ant.amazon.com (10.43.166.113) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 15 Sep 2019 06:44:29 +0000
From:   Talel Shenhar <talel@amazon.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <james.morse@arm.com>, <talel@amazon.com>,
        <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <nicolas.ferre@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC:     <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <hhhawa@amazon.com>, <ronenk@amazon.com>, <jonnyc@amazon.com>,
        <hanochu@amazon.com>, <amirkl@amazon.com>, <barakw@amazon.com>
Subject: [PATCH v2 1/2] dt-bindings: edac: al-mc-edac: Amazon's Annapurna Labs Memory Controller EDAC
Date:   Sun, 15 Sep 2019 09:43:54 +0300
Message-ID: <1568529835-15319-2-git-send-email-talel@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568529835-15319-1-git-send-email-talel@amazon.com>
References: <1568529835-15319-1-git-send-email-talel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.34]
X-ClientProxiedBy: EX13d09UWA002.ant.amazon.com (10.43.160.186) To
 EX13D01EUB002.ant.amazon.com (10.43.166.113)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Document Amazon's Annapurna Labs Memory Controller EDAC SoC binding.

Signed-off-by: Talel Shenhar <talel@amazon.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/edac/amazon,al-mc-edac.txt | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/amazon,al-mc-edac.txt

diff --git a/Documentation/devicetree/bindings/edac/amazon,al-mc-edac.txt b/Documentation/devicetree/bindings/edac/amazon,al-mc-edac.txt
new file mode 100644
index 0000000..4f612e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/amazon,al-mc-edac.txt
@@ -0,0 +1,24 @@
+Amazon's Annapurna Labs Memory Controller EDAC
+
+EDAC node is defined to describe on-chip error detection and correction for
+Amazon's Annapurna Labs Memory Controller.
+
+Required properties:
+- compatible:	Shall be "amazon,al-mc-edac".
+- reg:		DDR controller resource.
+
+Optional:
+- interrupt-names:	may include "ue", for uncorrectable errors,
+			and/or "ce", for correctable errors.
+- interrupts:		should contain the interrupts associated with the
+			interrupts names.
+
+Example:
+
+edac@f0080000 {
+	compatible = "amazon,al-mc-edac";
+	reg = <0x0 0xf0080000 0x0 0x00010000>;
+	interrupt-parent = <&amazon_al_system_fabric>;
+	interrupt-names = "ue";
+	interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
+};
-- 
2.7.4

