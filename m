Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F59A614D5
	for <lists+linux-edac@lfdr.de>; Sun,  7 Jul 2019 13:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfGGL6t (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 7 Jul 2019 07:58:49 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:16746 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfGGL6t (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 7 Jul 2019 07:58:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1562500728; x=1594036728;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=yWeXvdPMqWivUu3ChX4I+dARF3bBaP4Hz9DeOsrWp2Q=;
  b=kYv53sO7VpWbRElCq2yOLmbtwK6F1tA5rT33dhEtiMqg5dNvB1mmw/i2
   ansWjMbcKVKp6bmj1ufcj7H/pInXNemX5aw3ZTkaxf41KqVnuWoOSxj58
   GBh0tbu1/rtwtoXFkY5CN/0NhUxT+y9zyM3L5hyqnniL0Rklk+fi/WrpE
   w=;
X-IronPort-AV: E=Sophos;i="5.62,462,1554768000"; 
   d="scan'208";a="740672469"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-baacba05.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 07 Jul 2019 11:58:46 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-baacba05.us-west-2.amazon.com (Postfix) with ESMTPS id 1FA5DA1C44;
        Sun,  7 Jul 2019 11:58:41 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 7 Jul 2019 11:58:41 +0000
Received: from ub6d44c9ce3e25c.ant.amazon.com (10.43.161.16) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 7 Jul 2019 11:58:32 +0000
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
Subject: [PATCH v2 3/4] dt-bindings: EDAC: Add Amazon's Annapurna Labs L2 EDAC
Date:   Sun, 7 Jul 2019 14:57:37 +0300
Message-ID: <1562500658-14717-4-git-send-email-hhhawa@amazon.com>
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

Document Amazon's Annapurna Labs L2 EDAC SoC binding.

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
---
 .../devicetree/bindings/edac/amazon,al-l2-edac.txt   | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/amazon,al-l2-edac.txt

diff --git a/Documentation/devicetree/bindings/edac/amazon,al-l2-edac.txt b/Documentation/devicetree/bindings/edac/amazon,al-l2-edac.txt
new file mode 100644
index 0000000..7b0b734
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/amazon,al-l2-edac.txt
@@ -0,0 +1,20 @@
+* Amazon's Annapurna Labs L2 EDAC
+
+Amazon's Annapurna Labs SoCs supports L2 single bit correction and
+two bits detection capability based on ARM implementation.
+
+Required properties:
+- compatible:
+	should be "amazon,al-l2-edac".
+- l2-cache:
+	Phandle to L2 cache handler.
+	This property is used to compare with the CPU node property
+	'next-level-cache' to create cpu-mask with all CPUs that
+	share same L2 cache.
+
+Example:
+
+	al_l2_edac {
+		compatible = "amazon,al-l2-edac";
+		l2-cache = <&cluster0_l2>;
+	};
-- 
2.7.4

