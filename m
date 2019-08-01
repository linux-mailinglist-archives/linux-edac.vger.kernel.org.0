Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2337DC38
	for <lists+linux-edac@lfdr.de>; Thu,  1 Aug 2019 15:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731613AbfHANKd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 1 Aug 2019 09:10:33 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:27812 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731449AbfHANKd (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 1 Aug 2019 09:10:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1564665032; x=1596201032;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=95OK+Xwarn4yaQvhKro6HMis5mAanxMefgDhZJeu4RA=;
  b=ZoPM13nh9ODWRwjjd29HBffDJeXPMOxHpWDDWHtyikZYpFU3TVSl/pU8
   3ER+UqHkefFgACfZP5YEUBMLrQrKmxJNC5QakRJmYxkxpIFsamMdH3ooV
   nUaltPcQEgV3wmswoMeKVme/kz9cNVb14dv40GDaGneezWZKfhO4CAGwL
   U=;
X-IronPort-AV: E=Sophos;i="5.64,334,1559520000"; 
   d="scan'208";a="413415284"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 01 Aug 2019 13:10:29 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com (Postfix) with ESMTPS id CF733A227F;
        Thu,  1 Aug 2019 13:10:28 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 1 Aug 2019 13:10:28 +0000
Received: from ua9e4f3715fbc5f.ant.amazon.com (10.43.161.219) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 1 Aug 2019 13:10:19 +0000
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
Subject: [PATCH v4 1/4] dt-bindings: EDAC: Add Amazon's Annapurna Labs L1 EDAC
Date:   Thu, 1 Aug 2019 14:09:53 +0100
Message-ID: <20190801130956.26388-2-hhhawa@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801130956.26388-1-hhhawa@amazon.com>
References: <20190801130956.26388-1-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.219]
X-ClientProxiedBy: EX13D16UWC004.ant.amazon.com (10.43.162.72) To
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

