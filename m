Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF1D87DC4D
	for <lists+linux-edac@lfdr.de>; Thu,  1 Aug 2019 15:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfHANLT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 1 Aug 2019 09:11:19 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:56997 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731663AbfHANKy (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 1 Aug 2019 09:10:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1564665053; x=1596201053;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=GDxlgW2iIFv1GHLeEOVVxdcmyywibrFDiGbFKaCrd54=;
  b=asicFrWRcXGeTsJTdviV8mJf5rk9kRWxQ/AC1jr9+9pPsTFC2SOHa4qj
   qoGxydSQMpphh4j1/dm/VsFJxkaDgPUYAXfK2S/7V5SXaTVK8VbkofN2h
   h7VsIAUSbkGUqdcQGdlQfvy2EPdlT1LPndwL50TXbnSEnPvuvJJr6iDpB
   0=;
X-IronPort-AV: E=Sophos;i="5.64,334,1559520000"; 
   d="scan'208";a="407626862"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-53356bf6.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 01 Aug 2019 13:10:50 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-53356bf6.us-west-2.amazon.com (Postfix) with ESMTPS id 83534A21B6;
        Thu,  1 Aug 2019 13:10:46 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 1 Aug 2019 13:10:45 +0000
Received: from ua9e4f3715fbc5f.ant.amazon.com (10.43.161.219) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 1 Aug 2019 13:10:36 +0000
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
Subject: [PATCH v4 3/4] dt-bindings: EDAC: Add Amazon's Annapurna Labs L2 EDAC
Date:   Thu, 1 Aug 2019 14:09:55 +0100
Message-ID: <20190801130956.26388-4-hhhawa@amazon.com>
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

Document Amazon's Annapurna Labs L2 EDAC SoC binding.

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
---
 .../bindings/edac/amazon,al-l2-edac.txt       | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/amazon,al-l2-edac.txt

diff --git a/Documentation/devicetree/bindings/edac/amazon,al-l2-edac.txt b/Documentation/devicetree/bindings/edac/amazon,al-l2-edac.txt
new file mode 100644
index 000000000000..7b0b7347b711
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
2.17.1

