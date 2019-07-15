Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0E0D68A6A
	for <lists+linux-edac@lfdr.de>; Mon, 15 Jul 2019 15:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbfGONYp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 15 Jul 2019 09:24:45 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:6220 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730093AbfGONYp (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 15 Jul 2019 09:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1563197084; x=1594733084;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=7Csmm4toitSG7pULM58RwQRjc3PcTsUBc9OzWJg0DuM=;
  b=hWyLYNd3bzeNF8Pp68dx9i3BdJlMNVHmy0g81XbDe+3a7y0gqU5bi79a
   H7CY2054E0U5NqVsXIuEN7OnR9qdvViIFWrv5t2gmWkCGiYjfYWnB8ctI
   o2oewj5+ja1O9Pr450N+QerjfqPnGCcZU6GPmHtHtfH6XzieUSMh64+q9
   8=;
X-IronPort-AV: E=Sophos;i="5.62,493,1554768000"; 
   d="scan'208";a="685555081"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 15 Jul 2019 13:24:41 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com (Postfix) with ESMTPS id 103C8A275B;
        Mon, 15 Jul 2019 13:24:36 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 15 Jul 2019 13:24:36 +0000
Received: from ub6d44c9ce3e25c.ant.amazon.com (10.43.162.137) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 15 Jul 2019 13:24:27 +0000
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
Subject: [PATCH v3 1/4] dt-bindings: EDAC: Add Amazon's Annapurna Labs L1 EDAC
Date:   Mon, 15 Jul 2019 16:24:06 +0300
Message-ID: <1563197049-12679-2-git-send-email-hhhawa@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1563197049-12679-1-git-send-email-hhhawa@amazon.com>
References: <1563197049-12679-1-git-send-email-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.137]
X-ClientProxiedBy: EX13D05UWC003.ant.amazon.com (10.43.162.226) To
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

