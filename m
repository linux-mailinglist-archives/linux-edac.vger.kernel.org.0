Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D96EFA8483
	for <lists+linux-edac@lfdr.de>; Wed,  4 Sep 2019 15:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730261AbfIDNd0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 4 Sep 2019 09:33:26 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:42971 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfIDNdZ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 4 Sep 2019 09:33:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1567604005; x=1599140005;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=FiNp0tSkBeju0CcoQKUsY2CoyeXA/ml35QT9xlP51z8=;
  b=nf7/zr5jXK4sDRu2QDJVp7El82p+aPrCCQTb/Tn7SOfTDF17tlo3yc2l
   qgLq+/0QtDBpew5Gk/ouTd0iG1NMHGoxYQ5IbpYyxwyQpkvETWhHzzaJA
   YuxXefeP3ooYZMFEiTB1fz+L2YY5rAGBO20T3WQrStNlgsY3h1C7Y972R
   c=;
X-IronPort-AV: E=Sophos;i="5.64,467,1559520000"; 
   d="scan'208";a="700663960"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 04 Sep 2019 13:33:03 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com (Postfix) with ESMTPS id 33ACF28214E;
        Wed,  4 Sep 2019 13:32:58 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 4 Sep 2019 13:32:58 +0000
Received: from udc4a3e82dbc15a031435.hfa15.amazon.com (10.43.161.82) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 4 Sep 2019 13:32:50 +0000
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
        <hanochu@amazon.com>, <barakw@amazon.com>
Subject: [PATCH 1/3] dt-bindings: edac: al-mc-edac: Amazon's Annapurna Labs Memory Controller EDAC
Date:   Wed, 4 Sep 2019 16:32:21 +0300
Message-ID: <1567603943-25316-2-git-send-email-talel@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567603943-25316-1-git-send-email-talel@amazon.com>
References: <1567603943-25316-1-git-send-email-talel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.82]
X-ClientProxiedBy: EX13D10UWA001.ant.amazon.com (10.43.160.216) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Document Amazon's Annapurna Labs Memory Controller EDAC SoC binding.

Signed-off-by: Talel Shenhar <talel@amazon.com>
---
 .../devicetree/bindings/edac/amazon,al-mc-edac.txt | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/amazon,al-mc-edac.txt

diff --git a/Documentation/devicetree/bindings/edac/amazon,al-mc-edac.txt b/Documentation/devicetree/bindings/edac/amazon,al-mc-edac.txt
new file mode 100644
index 0000000..9a3803f
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
+al_mc_edac {
+	compatible = "amazon,al-mc-edac";
+	reg = <0x0 0xf0080000 0x0 0x00010000>;
+	interrupt-parent = <&amazon_al_system_fabric>;
+	interrupt-names = "ue";
+	interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
+};
-- 
2.7.4

