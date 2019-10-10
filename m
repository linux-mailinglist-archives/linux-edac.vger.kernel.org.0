Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56C72D283B
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2019 13:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfJJLlr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Oct 2019 07:41:47 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:51452 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfJJLlr (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 10 Oct 2019 07:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1570707706; x=1602243706;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=2DSaocwAOzaaaiAbHBOq5fL1dh7hvE7sGKm9Z+CsaXE=;
  b=scLb/OpxPrPUf5Mvpd1+MJuzgt3GvH2UporWwHPNfa8JA87uf0lg+Kq5
   sSsrp08ErZc/gP5KFpMKz7N+lCpKko5jdowrKHrdmFKumF8AaYI0vIBIe
   sE4AXXlZqAuHiJalRCfjQUsNe3D3+uzqrCrn2qiMGgYZS8788e3cxN8Cc
   w=;
X-IronPort-AV: E=Sophos;i="5.67,280,1566864000"; 
   d="scan'208";a="757199156"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-55156cd4.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 10 Oct 2019 11:41:43 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-55156cd4.us-west-2.amazon.com (Postfix) with ESMTPS id 6C3F0A255B;
        Thu, 10 Oct 2019 11:41:42 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 10 Oct 2019 11:41:41 +0000
Received: from udc4a3e82dbc15a031435.hfa15.amazon.com (10.43.160.153) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 10 Oct 2019 11:41:32 +0000
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
Subject: [PATCH v6 0/2] Amazon's Annapurna Labs POS Driver
Date:   Thu, 10 Oct 2019 14:41:19 +0300
Message-ID: <1570707681-865-1-git-send-email-talel@amazon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.153]
X-ClientProxiedBy: EX13D21UWA001.ant.amazon.com (10.43.160.154) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The Amazon's Annapurna Labs SoCs includes Point Of Serialization error
logging unit that reports an error in case of write error (e.g. attempt to
write to a read only register).

This patch series introduces the support for this unit.

Changes since v5:
=================
- added missing include to dt binding

Changes since v4:
================
- fixed dt binding according to new dt scheme
- added back the use of _relaxed accessors

Changes since v3:
=================
- ported to be edac device
- converted dt-bindings to new scheme
- added unit address to dt example

Changes since v2:
=================
- squashed left shifting fix to the driver

Changes since v1:
=================
- move MODULE_ to the end of the file
- simplified resource remapping devm_platform_ioremap_resource()
- use platform_get_irq() instead of irq_of_parse_and_map()
- removed the use of _relaxed accessor in favor to the regular ones
- removed driver selected based on arch
- added casting to u64 before left shifting (reported by kbuild test robot)


Talel Shenhar (2):
  dt-bindings: soc: al-pos: Amazon's Annapurna Labs POS
  soc: amazon: al-pos-edac: Introduce Amazon's Annapurna Labs POS EDAC
    driver

 .../bindings/edac/amazon,al-pos-edac.yaml          |  41 +++++
 MAINTAINERS                                        |   7 +
 drivers/edac/Kconfig                               |   6 +
 drivers/edac/Makefile                              |   1 +
 drivers/edac/al_pos_edac.c                         | 173 +++++++++++++++++++++
 5 files changed, 228 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/amazon,al-pos-edac.yaml
 create mode 100644 drivers/edac/al_pos_edac.c

-- 
2.7.4

