Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1795614CF
	for <lists+linux-edac@lfdr.de>; Sun,  7 Jul 2019 13:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfGGL62 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 7 Jul 2019 07:58:28 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:18729 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfGGL61 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 7 Jul 2019 07:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1562500707; x=1594036707;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=7Csmm4toitSG7pULM58RwQRjc3PcTsUBc9OzWJg0DuM=;
  b=PXU7GCAnzr9lh/3fg83qqAI5gJpLaAbkiutCvnR5tyi+JQWahuFzSWSO
   0HUloNaAN/7qki3PrthnOW7oBU3WRWkRe1kD0kRDt/R7zc6wh8hjjG9CK
   tZoqR6bJIBkzztwlzLZFBi0Tg/BbeEhJ3AHtvD1BgYFj9EfhC0pBZ2h9h
   I=;
X-IronPort-AV: E=Sophos;i="5.62,462,1554768000"; 
   d="scan'208";a="814727917"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2b-55156cd4.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 07 Jul 2019 11:58:25 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-55156cd4.us-west-2.amazon.com (Postfix) with ESMTPS id 76F09A1793;
        Sun,  7 Jul 2019 11:58:24 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 7 Jul 2019 11:58:23 +0000
Received: from ub6d44c9ce3e25c.ant.amazon.com (10.43.161.16) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 7 Jul 2019 11:58:15 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <james.morse@arm.com>, <davem@davemloft.net>,
        <gregkh@linuxfoundation.org>, <linus.walleij@linaro.org>,
        <Jonathan.Cameron@huawei.com>, <nicolas.ferre@microchip.com>,
        <paulmck@linux.ibm.com>
CC:     <dwmw@amazon.co.uk>, <benh@amazon.com>, <ronenk@amazon.com>,
        <talel@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-edac@vger.kernel.org>, <hhhawa@amazon.com>
Subject: [PATCH v2 1/4] dt-bindings: EDAC: Add Amazon's Annapurna Labs L1 EDAC
Date:   Sun, 7 Jul 2019 14:57:35 +0300
Message-ID: <1562500658-14717-2-git-send-email-hhhawa@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562500658-14717-1-git-send-email-hhhawa@amazon.com>
References: <1562500658-14717-1-git-send-email-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.16]
X-ClientProxiedBy: EX13D12UWC004.ant.amazon.com (10.43.162.182) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Document Amazon's Annapurna Labs L1 EDAC SoC binding.

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
---
 .../devicetree/bindings/edac/amazon,al-l1-edac.txt         | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/amazon,al-l1-edac.txt

diff --git a/Documentation/devicetree/bindings/edac/amazon,al-l1-edac.txt b/Documentation/devicetree/bindings/edac/amazon,al-l1-edac.txt
new file mode 100644
index 0000000..2ae8370
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/amazon,al-l1-edac.txt
@@ -0,0 +1,14 @@
+* Amazon's Annapurna Labs L1 EDAC
+
+Amazon's Annapurna Labs SoCs supports L1 single bit correction and
+two bits detection capability based on ARM implementation.
+
+Required properties:
+- compatible:
+	should be "amazon,al-l1-edac".
+
+Example:
+
+	al_l1_edac {
+		compatible = "amazon,al-l1-edac";
+	};
-- 
2.7.4

