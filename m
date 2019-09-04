Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC26A8480
	for <lists+linux-edac@lfdr.de>; Wed,  4 Sep 2019 15:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730013AbfIDNdY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 4 Sep 2019 09:33:24 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:60094 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfIDNdX (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 4 Sep 2019 09:33:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1567604003; x=1599140003;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=n6d55kUkaBFlUJHXxH7iZa0vx52buK+arnIMuA4U1tY=;
  b=MCS5hxQRy5wGMNUYfO3uJ1RoB0OxFZfy/FfwjA7n9jPpHDMO4AlW8h98
   iBEfjX4FTtEkItneoekTdINo2uKvEBHm+9ZwCcuxD8VNA47xRxfMyjV20
   rsIdPi17PfB87kifpvcfBNEhzc2iSIqnczSTBumBnIXu0IrMXcW4YgP+j
   E=;
X-IronPort-AV: E=Sophos;i="5.64,467,1559520000"; 
   d="scan'208";a="413537122"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 04 Sep 2019 13:33:20 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com (Postfix) with ESMTPS id A2B9EA2834;
        Wed,  4 Sep 2019 13:33:16 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 4 Sep 2019 13:33:15 +0000
Received: from udc4a3e82dbc15a031435.hfa15.amazon.com (10.43.161.82) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 4 Sep 2019 13:33:07 +0000
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
Subject: [PATCH 3/3] arm64: alpine: select EDAC_AL_MC
Date:   Wed, 4 Sep 2019 16:32:23 +0300
Message-ID: <1567603943-25316-4-git-send-email-talel@amazon.com>
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

Amazon's Annapurna Labs SoCs supports memory error detection and
correction.

Signed-off-by: Talel Shenhar <talel@amazon.com>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 4778c77..d2809b9 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -25,6 +25,7 @@ config ARCH_SUNXI
 config ARCH_ALPINE
 	bool "Annapurna Labs Alpine platform"
 	select ALPINE_MSI if PCI
+	select EDAC_AL_MC
 	help
 	  This enables support for the Annapurna Labs Alpine
 	  Soc family.
-- 
2.7.4

