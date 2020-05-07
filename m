Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3875E1C90A8
	for <lists+linux-edac@lfdr.de>; Thu,  7 May 2020 16:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgEGOug (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 7 May 2020 10:50:36 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:26085 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbgEGOug (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 7 May 2020 10:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1588863036; x=1620399036;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=cOjgL/jMx8rHyMgvqTEou7i+VZW8+Cxs08hf8UQgltw=;
  b=c0pBgE0VwNaiMuMry2ech0/S6on3kIdPvXk6m5kMQOaOSRnTrqzD++V4
   YTCvunpoTmLEzmXrhgHKbM9FXonyrPs38OqxaYlYNHOARZG5HhL/KB3Y4
   1Ykp/bKCDATLEkGArn1ehcv1+LdqPZ18DK75ZjMRNS84j6YBuFp3YikLV
   Y=;
IronPort-SDR: 0uVSjiXyhIU30m7upXEMtOp86557IdWtNGWxMKw2DZFI1UvuTbLePPijzkPL3WJCXPcu67T2jQ
 IbzhSx6RseXw==
X-IronPort-AV: E=Sophos;i="5.73,364,1583193600"; 
   d="scan'208";a="41896565"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 07 May 2020 14:50:34 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com (Postfix) with ESMTPS id 8C2CEA1B98;
        Thu,  7 May 2020 14:50:31 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 7 May 2020 14:50:31 +0000
Received: from uf25486d27d2d5b.ant.amazon.com (10.43.162.200) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 7 May 2020 14:50:21 +0000
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
Subject: [PATCH v7 0/2] Amazon's Annapurna Labs Memory Controller EDAC
Date:   Thu, 7 May 2020 17:50:00 +0300
Message-ID: <20200507145002.22010-1-talel@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.200]
X-ClientProxiedBy: EX13D25UWB003.ant.amazon.com (10.43.161.33) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This series introduces support for Amazon's Annapurna Labs Memory
Controller EDAC driver.

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

 .../bindings/edac/amazon,al-mc-edac.yaml      |  52 +++
 MAINTAINERS                                   |   7 +
 drivers/edac/Kconfig                          |   7 +
 drivers/edac/Makefile                         |   1 +
 drivers/edac/al_mc_edac.c                     | 354 ++++++++++++++++++
 5 files changed, 421 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml
 create mode 100644 drivers/edac/al_mc_edac.c

-- 
2.17.1

