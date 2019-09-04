Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3F69A847B
	for <lists+linux-edac@lfdr.de>; Wed,  4 Sep 2019 15:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbfIDNdC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 4 Sep 2019 09:33:02 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:39436 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfIDNdB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 4 Sep 2019 09:33:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1567603980; x=1599139980;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=qlKsodcmfNKYiMWPcqYzq1OagWLl5xOf0xTmXZZw4PA=;
  b=EAxNEVdA+4P6jBd6/NvLLbDH8LuCQBuBIysSACuFp7Xzhbe1qCrlP7qt
   /Ncz5bpKUi2OpVegJj6NUYIex7AorkNu4nZZrKw9o73Cw1vNdsp6eooHa
   oJaFucwUMRxH1Ak8iha4WsBCiqzBtj6O2IrtkrduKTB1xSBmSocAKbfZZ
   w=;
X-IronPort-AV: E=Sophos;i="5.64,467,1559520000"; 
   d="scan'208";a="827206391"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 04 Sep 2019 13:32:51 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (Postfix) with ESMTPS id 8019BA2831;
        Wed,  4 Sep 2019 13:32:50 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 4 Sep 2019 13:32:50 +0000
Received: from udc4a3e82dbc15a031435.hfa15.amazon.com (10.43.161.82) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 4 Sep 2019 13:32:41 +0000
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
Subject: [PATCH 0/3] Amazon's Annapurna Labs Memory Controller EDAC
Date:   Wed, 4 Sep 2019 16:32:20 +0300
Message-ID: <1567603943-25316-1-git-send-email-talel@amazon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.82]
X-ClientProxiedBy: EX13D10UWA001.ant.amazon.com (10.43.160.216) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This series introduces support for Amazon's Annapurna Labs Memory
Controller EDAC driver.



Talel Shenhar (3):
  dt-bindings: edac: al-mc-edac: Amazon's Annapurna Labs Memory
    Controller EDAC
  EDAC: al-mc-edac: Introduce Amazon's Annapurna Labs Memory Controller
    EDAC
  arm64: alpine: select EDAC_AL_MC

 .../devicetree/bindings/edac/amazon,al-mc-edac.txt |  24 ++
 MAINTAINERS                                        |   6 +
 arch/arm64/Kconfig.platforms                       |   1 +
 drivers/edac/Kconfig                               |   7 +
 drivers/edac/Makefile                              |   1 +
 drivers/edac/al_mc_edac.c                          | 382 +++++++++++++++++++++
 6 files changed, 421 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/amazon,al-mc-edac.txt
 create mode 100644 drivers/edac/al_mc_edac.c

-- 
2.7.4

