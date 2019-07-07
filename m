Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9B13614CD
	for <lists+linux-edac@lfdr.de>; Sun,  7 Jul 2019 13:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfGGL6V (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 7 Jul 2019 07:58:21 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:4688 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfGGL6V (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 7 Jul 2019 07:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1562500698; x=1594036698;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=AzRAD81nU2MwlCqn0AU1evNVTd1zGcE1O6MmxMHhUbc=;
  b=GFC9qHnyD7oytVt8NNIq0OZ9KzASQKyzbCEPBow8lcxylNWJIZRR3+Lg
   ydYRouHrvTGm6Lbw9CMjyJGhB0y/SmepzuPpEti5Gl+ddNO1vMfp27bB3
   q8ecW/Bv7QOpOJP2mghfnk4pDZ9VH5kyjyjfJSbIkSEaCGb/JKFqyWQSY
   c=;
X-IronPort-AV: E=Sophos;i="5.62,462,1554768000"; 
   d="scan'208";a="773526810"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 07 Jul 2019 11:58:15 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com (Postfix) with ESMTPS id D2DE8A230C;
        Sun,  7 Jul 2019 11:58:15 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 7 Jul 2019 11:58:15 +0000
Received: from ub6d44c9ce3e25c.ant.amazon.com (10.43.161.16) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 7 Jul 2019 11:58:06 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <james.morse@arm.com>, <davem@davemloft.net>,
        <gregkh@linuxfoundation.org>, <linus.walleij@linaro.org>,
        <Jonathan.Cameron@huawei.com>, <nicolas.ferre@microchip.com>,
        <paulmck@linux.ibm.com>
CC:     <dwmw@amazon.co.uk>, <benh@amazon.com>, <ronenk@amazon.com>,
        <talel@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-edac@vger.kernel.org>, <hhhawa@amazon.com>
Subject: [PATCH v2 0/4] Add support for Amazon's Annapurna Labs EDAC for L1/L2
Date:   Sun, 7 Jul 2019 14:57:34 +0300
Message-ID: <1562500658-14717-1-git-send-email-hhhawa@amazon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.16]
X-ClientProxiedBy: EX13D12UWC004.ant.amazon.com (10.43.162.182) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This series adds L1 and L2 caches support for error detection and
correction for Amazon's Annapurna Labs SoCs.
Alpine SoCs support L1 and L2 single bit correction and two bits detection
capability based on ARM implementation.

Changes since v1:
-----------------
- Split into two drivers
- Get cpu-mask according to l2-cache handler from devicetree
- Remove parameter casting
- Use GENMASK() in bit mask
- Use FIELD_GET()
- Update define description PLRU_RAM -> PF_RAM
- Use sys_reg() and read_sysreg_s()
- Remove all write/read wrappers
- Check fatal field to set if the error correctable or not
- Remove un-relevant information from error prints.
- Update smp_call_function_single() call function to wait
- remove usage of get_online_cpus/put_online_cpus
- Use on_each_cpu() and smp_call_function_any() instead of loop with for_each_cpu.
- use buffer for error prints and pass to edac API
- Remove edac_op_state set
- Add for loop to report on repeated errors of the same type
- Fix error name of the TLB to be L2_TLB as written in ARM TRM
- Minor change in Kconfig
- Minor changes in commit message

Hanna Hawa (4):
  dt-bindings: EDAC: Add Amazon's Annapurna Labs L1 EDAC
  edac: Add support for Amazon's Annapurna Labs L1 EDAC
  dt-bindings: EDAC: Add Amazon's Annapurna Labs L2 EDAC
  edac: Add support for Amazon's Annapurna Labs L2 EDAC

 .../devicetree/bindings/edac/amazon,al-l1-edac.txt |  14 ++
 .../devicetree/bindings/edac/amazon,al-l2-edac.txt |  20 +++
 MAINTAINERS                                        |  12 ++
 drivers/edac/Kconfig                               |  16 ++
 drivers/edac/Makefile                              |   2 +
 drivers/edac/al_l1_edac.c                          | 154 +++++++++++++++++
 drivers/edac/al_l2_edac.c                          | 185 +++++++++++++++++++++
 7 files changed, 403 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/amazon,al-l1-edac.txt
 create mode 100644 Documentation/devicetree/bindings/edac/amazon,al-l2-edac.txt
 create mode 100644 drivers/edac/al_l1_edac.c
 create mode 100644 drivers/edac/al_l2_edac.c

-- 
2.7.4

