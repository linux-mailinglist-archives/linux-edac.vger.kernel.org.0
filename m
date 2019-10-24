Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFFB4E349B
	for <lists+linux-edac@lfdr.de>; Thu, 24 Oct 2019 15:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393752AbfJXNqQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 24 Oct 2019 09:46:16 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:52663 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393672AbfJXNqP (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 24 Oct 2019 09:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1571924774; x=1603460774;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=vkZQhzMWV/fyOBV+LDd85sbkFNcBkgjmi8yYaRFWN1c=;
  b=HqRzEDUvViqLaTnw84MGA2zw+ovupwGaJQbD8cpekEpbOlFwfy+VhTj9
   Nb3rveeV1cYfQ7C3gMhCgYJj4zjUe1I54Dg9rwB0wD/p0QBG6aDW37kPN
   eQoxWJ+AmuNno3xfHOdRCDxVgvxwTW0BsUdKZrelzqLTSXW0y7gJbHTqa
   M=;
X-IronPort-AV: E=Sophos;i="5.68,224,1569283200"; 
   d="scan'208";a="762792918"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1e-27fb8269.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 24 Oct 2019 13:46:12 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-27fb8269.us-east-1.amazon.com (Postfix) with ESMTPS id B6CC6A26BE;
        Thu, 24 Oct 2019 13:46:08 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 24 Oct 2019 13:46:07 +0000
Received: from udc4a3e82dbc15a031435.hfa15.amazon.com (10.43.161.34) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 24 Oct 2019 13:45:59 +0000
From:   Talel Shenhar <talel@amazon.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <james.morse@arm.com>, <talel@amazon.com>,
        <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <nicolas.ferre@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC:     <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <hhhawa@amazon.com>, <ronenk@amazon.com>, <jonnyc@amazon.com>,
        <hanochu@amazon.com>, <amirkl@amazon.com>, <barakw@amazon.com>
Subject: [PATCH v7 0/2] Amazon's Annapurna Labs POS Driver
Date:   Thu, 24 Oct 2019 16:45:44 +0300
Message-ID: <1571924746-8107-1-git-send-email-talel@amazon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.34]
X-ClientProxiedBy: EX13D21UWA004.ant.amazon.com (10.43.160.252) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Amazon's Annapurna Labs SoCs include a Point of Serialization error logging
unit that reports an error when a write error occurs (e.g. attempt to write
to a read only register).This error shall be reported via the EDAC
subsystem as uncorrectable-error.

This patch series introduces the support for this unit.

Changes since v6:
=================
- reworked the commit message for the driver patch
- dt-bindings: added -only to  GPL-2.0
- fixed filename in MAINTAINERS
- added driver managed unwind

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
 drivers/edac/al_pos_edac.c                         | 174 +++++++++++++++++++++
 5 files changed, 229 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/amazon,al-pos-edac.yaml
 create mode 100644 drivers/edac/al_pos_edac.c

-- 
2.7.4

