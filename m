Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D17242FA17
	for <lists+linux-edac@lfdr.de>; Thu, 30 May 2019 12:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbfE3KQF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 30 May 2019 06:16:05 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:30793 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728040AbfE3KQF (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 30 May 2019 06:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1559211364; x=1590747364;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=DL/rcsCbqNcAByuzqgScaFGxl1h2gE50EKedW9vARvQ=;
  b=o0yzqznumIYjv3w2i9cRCw2zyzOFW5hZXxNUqyLHP+tnxn1EW/yaFefo
   iE6gm1MuoCCrHPszUy7uSH60GbEUL1M4GdFfFf5F1H8WTzTSTDI/UZeg5
   Qg+CaQB6AuqxuETuLJSqVapGDaDPV0mQhRQ2CU7U3BtAole7+zim2CjIO
   k=;
X-IronPort-AV: E=Sophos;i="5.60,530,1549929600"; 
   d="scan'208";a="404315198"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-a70de69e.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 30 May 2019 10:16:03 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-a70de69e.us-east-1.amazon.com (Postfix) with ESMTPS id DBCBDA20F3;
        Thu, 30 May 2019 10:15:59 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 30 May 2019 10:15:58 +0000
Received: from ub6d44c9ce3e25c.ant.amazon.com (10.43.160.237) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 30 May 2019 10:15:50 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <james.morse@arm.com>, <davem@davemloft.net>,
        <gregkh@linuxfoundation.org>, <nicolas.ferre@microchip.com>,
        <paulmck@linux.ibm.com>, <dwmw@amazon.co.uk>, <benh@amazon.com>
CC:     <ronenk@amazon.com>, <talel@amazon.com>, <jonnyc@amazon.com>,
        <hanochu@amazon.com>, <hhhawa@amazon.com>,
        <linux-edac@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: EDAC: add Amazon Annapurna Labs EDAC binding
Date:   Thu, 30 May 2019 13:15:28 +0300
Message-ID: <1559211329-13098-2-git-send-email-hhhawa@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559211329-13098-1-git-send-email-hhhawa@amazon.com>
References: <1559211329-13098-1-git-send-email-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.237]
X-ClientProxiedBy: EX13D23UWC001.ant.amazon.com (10.43.162.196) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
---
 .../devicetree/bindings/edac/amazon-al-edac.txt          | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/amazon-al-edac.txt

diff --git a/Documentation/devicetree/bindings/edac/amazon-al-edac.txt b/Documentation/devicetree/bindings/edac/amazon-al-edac.txt
new file mode 100644
index 0000000..76165a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/amazon-al-edac.txt
@@ -0,0 +1,16 @@
+* Amazon Annapurna Labs EDAC
+
+Amazon Annapurna Labs Alpine V2 SoC is based on ARM Cortex-A57, and Alpine V3 SoC is
+based on ARM Cortex-A72.
+Alpine SoCs support L1 and L2 error correction check based on ARM implementation.
+
+Required properties:
+- compatible:
+	should be "amazon,al-cortex-a57-edac" for Alpine V2.
+	should be "amazon,al-cortex-a72-edac" for Alpine V3.
+
+Example:
+
+	edac_l1_l2 {
+		compatible = "amazon,al-cortex-a57-edac";
+	};
-- 
2.7.4

