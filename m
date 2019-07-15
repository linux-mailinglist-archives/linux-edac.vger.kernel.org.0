Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B745968A65
	for <lists+linux-edac@lfdr.de>; Mon, 15 Jul 2019 15:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbfGONYk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 15 Jul 2019 09:24:40 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:6220 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730093AbfGONYj (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 15 Jul 2019 09:24:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1563197079; x=1594733079;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=jLT/6elo+nK0L5GVh/S6r9+jX5YDnfWgKIzyGhZRn9Q=;
  b=iaCvS/wmrBFPXhq5mW827ggdq1yZSxpLYPXxLJJTjj5EvfxCmo6OZYn4
   PFv71Z9oQs6QFAy2Mvgsc8rTqq8E4NyinwCeK5NhFQ6MTWbbturkB6yBK
   ivabI12cv++t7i0ic+4Xx5LcTVUzdar2+svhdVwWBPdL2y1HJPDw9Yy8K
   Q=;
X-IronPort-AV: E=Sophos;i="5.62,493,1554768000"; 
   d="scan'208";a="685555044"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 15 Jul 2019 13:24:32 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com (Postfix) with ESMTPS id 5B75BA21FA;
        Mon, 15 Jul 2019 13:24:28 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 15 Jul 2019 13:24:27 +0000
Received: from ub6d44c9ce3e25c.ant.amazon.com (10.43.162.137) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 15 Jul 2019 13:24:18 +0000
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
Subject: [PATCH v3 0/4] Add support for Amazon's Annapurna Labs EDAC for L1/L2
Date:   Mon, 15 Jul 2019 16:24:05 +0300
Message-ID: <1563197049-12679-1-git-send-email-hhhawa@amazon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.137]
X-ClientProxiedBy: EX13D05UWC003.ant.amazon.com (10.43.162.226) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This series adds L1 and L2 caches support for error detection and
correction for Amazon's Annapurna Labs SoCs.
Alpine SoCs supports L1 and L2 single bit correction and two bits detection
capability based on ARM implementation.

Changes since v2:
-----------------
- Use BIT for single bit instead of GENMASK
- Use BIT_ULL and GENMASK_ULL for 64bit vector
- Fix the mod_name/ctrl_name.

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
 drivers/edac/al_l1_edac.c                          | 156 +++++++++++++++++
 drivers/edac/al_l2_edac.c                          | 187 +++++++++++++++++++++
 7 files changed, 407 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/amazon,al-l1-edac.txt
 create mode 100644 Documentation/devicetree/bindings/edac/amazon,al-l2-edac.txt
 create mode 100644 drivers/edac/al_l1_edac.c
 create mode 100644 drivers/edac/al_l2_edac.c

-- 
2.7.4

