Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E664D2875
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2019 13:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfJJLzV (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Oct 2019 07:55:21 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:54114 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727737AbfJJLzV (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 10 Oct 2019 07:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1570708520; x=1602244520;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=oSbuvIYumFWNPpwNonXBRmIndHA8dfEq+3FqeaVrFIs=;
  b=tBKLJWTdGKNEjyJS2DnflsaM/JgY+PjBiFKi14/utkx/f3Mqj1QDgwAw
   VGEyQhUFf/7H7SSMEZH5CyG8Oaapn6AuzsOEepSvRJfGP3+FM88aw8Mr6
   m6iR06nwtVo1tMl/CSuFgrq7e2+IIskg/96sHLyEQjfWGT8BFDW0feyso
   0=;
X-IronPort-AV: E=Sophos;i="5.67,280,1566864000"; 
   d="scan'208";a="427554805"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-a70de69e.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 10 Oct 2019 11:55:18 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-a70de69e.us-east-1.amazon.com (Postfix) with ESMTPS id 1019AA18FA;
        Thu, 10 Oct 2019 11:55:04 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 10 Oct 2019 11:55:04 +0000
Received: from udc4a3e82dbc15a031435.hfa15.amazon.com (10.43.160.48) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 10 Oct 2019 11:54:54 +0000
From:   Talel Shenhar <talel@amazon.com>
To:     <robh+dt@kernel.org>, <maz@kernel.org>, <mark.rutland@arm.com>,
        <arnd@arndb.de>, <bp@alien8.de>, <mchehab@kernel.org>,
        <james.morse@arm.com>, <davem@davemloft.net>,
        <gregkh@linuxfoundation.org>, <paulmck@linux.ibm.com>,
        <talel@amazon.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC:     <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <hhhawa@amazon.com>, <ronenk@amazon.com>, <jonnyc@amazon.com>,
        <hanochu@amazon.com>, <amirkl@amazon.com>, <barakw@amazon.com>
Subject: [PATCH v4 0/2] Amazon's Annapurna Labs Memory Controller EDAC
Date:   Thu, 10 Oct 2019 14:54:12 +0300
Message-ID: <1570708454-10784-1-git-send-email-talel@amazon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.48]
X-ClientProxiedBy: EX13D13UWA002.ant.amazon.com (10.43.160.172) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This series introduces support for Amazon's Annapurna Labs Memory
Controller EDAC driver.

Changes since v3:
=================
- removed quotation marks and hyphen from compatible
- added interrupts and interrupt-names description
- added missing include to dt binding

Changes since v2:
=================
- added missing includes
- aggregated variables to same line
- removed ranks read
- added spinlock to mc reporting
- made irq handler clearer
- freed irq before freeing device memory
- changed Kconfig to tristate
- added COMPILE_TEST to Kconfig
- converted dt binding to new scheme
- used devm_platform_ioremap_resource instead of get&ioremap

Changes since v1:
=================
- updated dt binding node name and added Rob Reviewed-By
- removed auto selecting of this driver


Talel Shenhar (2):
  dt-bindings: edac: al-mc-edac: Amazon's Annapurna Labs Memory
    Controller EDAC
  EDAC: al-mc-edac: Introduce Amazon's Annapurna Labs Memory Controller
    EDAC

 .../bindings/edac/amazon,al-mc-edac.yaml           |  50 +++
 MAINTAINERS                                        |   7 +
 drivers/edac/Kconfig                               |   7 +
 drivers/edac/Makefile                              |   1 +
 drivers/edac/al_mc_edac.c                          | 358 +++++++++++++++++++++
 5 files changed, 423 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml
 create mode 100644 drivers/edac/al_mc_edac.c

-- 
2.7.4

