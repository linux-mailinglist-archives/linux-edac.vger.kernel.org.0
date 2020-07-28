Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F5723070C
	for <lists+linux-edac@lfdr.de>; Tue, 28 Jul 2020 11:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgG1Jwl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 28 Jul 2020 05:52:41 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:6031 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbgG1Jwk (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 28 Jul 2020 05:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1595929960; x=1627465960;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=lD6zfUc60R832pir/a+PG9I7SOgBDc1RGjG/M7AaRkg=;
  b=g/sxF58GpFnk/I1l2QIGeaNQuq0f9BndUQSpwIa7VJa56xc0Po1hAeO8
   nZDx5ob6S5CNRAldu3QFSdh+yqzmllgtGB7l6+mvis5vxIDWu7d8+Ejzk
   xeTkbz1yOROhNkRs2bmPgIk9hzlfD3FVtF2bAWOU6ywQRyU4PUrJ6YQcJ
   8=;
IronPort-SDR: 7d+qg/gJSzVffrMVHDKuA5jB2YfUmeCbEJh9tMLZJcfKYe9h0BLJiqdCOMUFOammVVv0sPsu/L
 MMbzpX9vQgzw==
X-IronPort-AV: E=Sophos;i="5.75,405,1589241600"; 
   d="scan'208";a="62276090"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-55156cd4.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 28 Jul 2020 09:52:23 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-55156cd4.us-west-2.amazon.com (Postfix) with ESMTPS id 559E0A21D1;
        Tue, 28 Jul 2020 09:52:22 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 28 Jul 2020 09:52:21 +0000
Received: from uf25486d27d2d5b.ant.amazon.com (10.43.161.71) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 28 Jul 2020 09:52:12 +0000
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
        <hanochu@amazon.com>, <eitan@amazon.com>
Subject: [PATCH v9 0/2] Amazon's Annapurna Labs Memory Controller EDAC
Date:   Tue, 28 Jul 2020 12:51:53 +0300
Message-ID: <20200728095155.18506-1-talel@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.71]
X-ClientProxiedBy: EX13D34UWC002.ant.amazon.com (10.43.162.137) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This series introduces support for Amazon's Annapurna Labs Memory
Controller EDAC driver.

Changes since v8:
================
- added cells address and size description to dt-binding yaml doc

Changes since v7:
=================
- rebased and retested for tag Linux 5.8-rc1

Changes since v6:
=================
- removed unused defines
- user-visible strings changed to capital
- removed static function names prefix from internal functions (external
  used function, such as devm/interrupts-handlers/probe, left with the
  prefix to allow stack trace visibility)
- sorted function local variables declaration in a reverse Christmas tree order
- fixed use of wrong syndrome defines
- added a comment to interrupts handling (polling mode with interrupt mode)
- added grain definition
- appended "or BSD-2-Clause" to dt binding SPDX

Changes since v5:
=================
- rebased and retested for tag Linux 5.6-rc2
- added Reviewed-By for dt-binding (Rob Herring <robh@kernel.org>)
- added Reviewed-By for driver (James Morse <james.morse@arm.com>)

Changes since v4:
=================
- fixed dt-binding interrupt to have min of 1
- updated dt-binding GPL-2.0 to GPL-2.0-only
- changed writel to relaxed flavor
- added managed device driver unwind

Changes since v3:
=================
- removed quotation marks and hyphen from compatible dt-binding
- added interrupts and interrupt-names description to dt-binding
- added missing include to dt-binding

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

 .../bindings/edac/amazon,al-mc-edac.yaml      |  67 ++++
 MAINTAINERS                                   |   7 +
 drivers/edac/Kconfig                          |   7 +
 drivers/edac/Makefile                         |   1 +
 drivers/edac/al_mc_edac.c                     | 354 ++++++++++++++++++
 5 files changed, 436 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml
 create mode 100644 drivers/edac/al_mc_edac.c

-- 
2.17.1

