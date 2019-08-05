Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBF2781F45
	for <lists+linux-edac@lfdr.de>; Mon,  5 Aug 2019 16:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbfHEOjx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 5 Aug 2019 10:39:53 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:43345 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729037AbfHEOjx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 5 Aug 2019 10:39:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1565015992; x=1596551992;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=95OK+Xwarn4yaQvhKro6HMis5mAanxMefgDhZJeu4RA=;
  b=KWFJFdBjxR99dsd2oJBH9tsBlxOz7h2u9ifST0MSGxu3qFXfKl6hwgrj
   GKOSTAMDGvd8BGuxnIrDPYWyTj8WMQ718lP1EK0T1Y7NNVEQTzAINf23l
   nNCyTNAAEP0yfOTtjWIp6vjQhW36ZVXuQgrirVmkLbxcyZZMl/h2pw5Hm
   Y=;
X-IronPort-AV: E=Sophos;i="5.64,350,1559520000"; 
   d="scan'208";a="816815291"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1e-a70de69e.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 05 Aug 2019 14:39:49 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-a70de69e.us-east-1.amazon.com (Postfix) with ESMTPS id A2806A2446;
        Mon,  5 Aug 2019 14:39:44 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 5 Aug 2019 14:39:43 +0000
Received: from ua9e4f3715fbc5f.ant.amazon.com (10.43.162.137) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 5 Aug 2019 14:39:34 +0000
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
Subject: [PATCH v5 1/4] dt-bindings: EDAC: Add Amazon's Annapurna Labs L1 EDAC
Date:   Mon, 5 Aug 2019 15:39:08 +0100
Message-ID: <20190805143911.12185-2-hhhawa@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190805143911.12185-1-hhhawa@amazon.com>
References: <20190805143911.12185-1-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.137]
X-ClientProxiedBy: EX13D03UWA001.ant.amazon.com (10.43.160.141) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Document Amazon's Annapurna Labs L1 EDAC SoC binding.

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
---
 .../devicetree/bindings/edac/amazon,al-l1-edac.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/amazon,al-l1-edac.txt

diff --git a/Documentation/devicetree/bindings/edac/amazon,al-l1-edac.txt b/Documentation/devicetree/bindings/edac/amazon,al-l1-edac.txt
new file mode 100644
index 000000000000..2ae8370216bc
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
2.17.1

