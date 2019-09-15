Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDC01B2EAC
	for <lists+linux-edac@lfdr.de>; Sun, 15 Sep 2019 08:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfIOGoy (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 15 Sep 2019 02:44:54 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:25802 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbfIOGox (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 15 Sep 2019 02:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568529893; x=1600065893;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=PZF+Ih6YTTBl1IfP246ujgR5uVTK9ipJ13FVAV0UutM=;
  b=LWnl9UoG479O17XNQkpm9JwzlL5ORCDdmrhyiGjTTkARJIBoChk10je7
   YnOJVl5Gq0ZcQgdIXNlSWfvLno0US1ql1jfVzRG5tkNz3UsXqBAy6VJcE
   ngwSqjbgTPZBpLkRpiVkP65rFW9FOWYB7vugYJ+NId4MdZGtW2LdOOxnI
   4=;
X-IronPort-AV: E=Sophos;i="5.64,506,1559520000"; 
   d="scan'208";a="750759803"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 15 Sep 2019 06:44:32 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com (Postfix) with ESMTPS id 1729EA23A4;
        Sun, 15 Sep 2019 06:44:31 +0000 (UTC)
Received: from EX13D01EUB002.ant.amazon.com (10.43.166.113) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 15 Sep 2019 06:44:30 +0000
Received: from udc4a3e82dbc15a031435.hfa15.amazon.com (10.43.161.34) by
 EX13D01EUB002.ant.amazon.com (10.43.166.113) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 15 Sep 2019 06:44:21 +0000
From:   Talel Shenhar <talel@amazon.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <james.morse@arm.com>, <talel@amazon.com>,
        <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <nicolas.ferre@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC:     <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <hhhawa@amazon.com>, <ronenk@amazon.com>, <jonnyc@amazon.com>,
        <hanochu@amazon.com>, <amirkl@amazon.com>, <barakw@amazon.com>
Subject: [PATCH v2 0/2] Amazon's Annapurna Labs Memory Controller EDAC
Date:   Sun, 15 Sep 2019 09:43:53 +0300
Message-ID: <1568529835-15319-1-git-send-email-talel@amazon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.34]
X-ClientProxiedBy: EX13d09UWA002.ant.amazon.com (10.43.160.186) To
 EX13D01EUB002.ant.amazon.com (10.43.166.113)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This series introduces support for Amazon's Annapurna Labs Memory
Controller EDAC driver.

Changes since v1:
=================
- updated dt binding node name and added Rob Reviewed-By
- removed auto selecting of this driver


Talel Shenhar (2):
  dt-bindings: edac: al-mc-edac: Amazon's Annapurna Labs Memory
    Controller EDAC
  EDAC: al-mc-edac: Introduce Amazon's Annapurna Labs Memory Controller
    EDAC

 .../devicetree/bindings/edac/amazon,al-mc-edac.txt |  24 ++
 MAINTAINERS                                        |   7 +
 drivers/edac/Kconfig                               |   7 +
 drivers/edac/Makefile                              |   1 +
 drivers/edac/al_mc_edac.c                          | 382 +++++++++++++++++++++
 5 files changed, 421 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/amazon,al-mc-edac.txt
 create mode 100644 drivers/edac/al_mc_edac.c

-- 
2.7.4

