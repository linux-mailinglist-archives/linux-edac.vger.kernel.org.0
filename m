Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C63ECE221
	for <lists+linux-edac@lfdr.de>; Mon,  7 Oct 2019 14:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbfJGMrr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 7 Oct 2019 08:47:47 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:43852 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbfJGMrm (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 7 Oct 2019 08:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1570452462; x=1601988462;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=WHN2qFt3WC0FVXmEsHcs1L/28VmtQuL9zGs4wBK91oc=;
  b=Uk8N3CoVAywA8pogInppja0dN3hDaB2aLDlLkXXdDHeMOBhoQOgv+j0q
   5LUem2gLFv/e2qX3dLtQiYsZLHSuAmKWtCqytQorFgUceH0rXzvI3xzUY
   YcVe2tase9W/cngR2rFDrdaeZTx3NEzJlh1yeq2sIrHPX1SKOf7IUEhQB
   A=;
X-IronPort-AV: E=Sophos;i="5.67,268,1566864000"; 
   d="scan'208";a="756171403"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-81e76b79.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 07 Oct 2019 12:47:39 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-81e76b79.us-west-2.amazon.com (Postfix) with ESMTPS id 3AF5AA1C50;
        Mon,  7 Oct 2019 12:47:38 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 7 Oct 2019 12:47:37 +0000
Received: from udc4a3e82dbc15a031435.hfa15.amazon.com (10.43.162.245) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 7 Oct 2019 12:47:27 +0000
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
Subject: [PATCH v5 0/2] Amazon's Annapurna Labs POS Driver
Date:   Mon, 7 Oct 2019 15:47:13 +0300
Message-ID: <1570452435-8505-1-git-send-email-talel@amazon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.245]
X-ClientProxiedBy: EX13D05UWB004.ant.amazon.com (10.43.161.208) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The Amazon's Annapurna Labs SoCs includes Point Of Serialization error
logging unit that reports an error in case of write error (e.g. attempt to
write to a read only register).

This patch series introduces the support for this unit.

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

 .../bindings/edac/amazon,al-pos-edac.yaml          |  40 +++++
 MAINTAINERS                                        |   7 +
 drivers/edac/Kconfig                               |   6 +
 drivers/edac/Makefile                              |   1 +
 drivers/edac/al_pos_edac.c                         | 173 +++++++++++++++++++++
 5 files changed, 227 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/amazon,al-pos-edac.yaml
 create mode 100644 drivers/edac/al_pos_edac.c

-- 
2.7.4

