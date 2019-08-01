Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD2D17DC35
	for <lists+linux-edac@lfdr.de>; Thu,  1 Aug 2019 15:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731544AbfHANK0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 1 Aug 2019 09:10:26 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:10573 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731449AbfHANK0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 1 Aug 2019 09:10:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1564665026; x=1596201026;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=Jbmbojz2/TychDJudnHb5FLoVy68HPFk3gyystNOymg=;
  b=IL+igxJQX9rmQrMXxEsW7CA1z8VPukyqADhANDOGGmF/ygLHJTaQj+Pq
   GXk/+LIhI8wKg0OyZ01LjpTIvs/CSSyDaY9tEBXADuIlEz8HGO4glnHjA
   yHrEDdGgT8hh22m0QReU42slZfnzBTZFqxyfWvm33yEM1wGHe4HXlM4Ln
   U=;
X-IronPort-AV: E=Sophos;i="5.64,334,1559520000"; 
   d="scan'208";a="407626797"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 01 Aug 2019 13:10:22 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com (Postfix) with ESMTPS id F1B14A27A3;
        Thu,  1 Aug 2019 13:10:21 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 1 Aug 2019 13:10:20 +0000
Received: from ua9e4f3715fbc5f.ant.amazon.com (10.43.161.219) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 1 Aug 2019 13:10:10 +0000
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
Subject: [PATCH v4 0/4] Add support for Amazon's Annapurna Labs EDAC for L1/L2
Date:   Thu, 1 Aug 2019 14:09:52 +0100
Message-ID: <20190801130956.26388-1-hhhawa@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.219]
X-ClientProxiedBy: EX13D16UWC004.ant.amazon.com (10.43.162.72) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This series adds L1 and L2 caches support for error detection and
correction for Amazon's Annapurna Labs SoCs.
Alpine SoCs supports L1 and L2 single bit correction and two bits detection
capability based on ARM implementation.

Changes since v3:
-----------------
- Added include for smp.h sysreg.h 
- Use scnprintf instead of snprintf
- Move write_sysreg_s after valid check to minimize the window between
read/write.
- Use IS_ERR_OR_NULL instead of IS_ERR, because
edac_device_alloc_ctl_info may return NULL.

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


*** BLURB HERE ***

Hanna Hawa (4):
  dt-bindings: EDAC: Add Amazon's Annapurna Labs L1 EDAC
  edac: Add support for Amazon's Annapurna Labs L1 EDAC
  dt-bindings: EDAC: Add Amazon's Annapurna Labs L2 EDAC
  edac: Add support for Amazon's Annapurna Labs L2 EDAC

 .../bindings/edac/amazon,al-l1-edac.txt       |  14 ++
 .../bindings/edac/amazon,al-l2-edac.txt       |  20 ++
 MAINTAINERS                                   |  12 ++
 drivers/edac/Kconfig                          |  16 ++
 drivers/edac/Makefile                         |   2 +
 drivers/edac/al_l1_edac.c                     | 158 +++++++++++++++
 drivers/edac/al_l2_edac.c                     | 189 ++++++++++++++++++
 7 files changed, 411 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/amazon,al-l1-edac.txt
 create mode 100644 Documentation/devicetree/bindings/edac/amazon,al-l2-edac.txt
 create mode 100644 drivers/edac/al_l1_edac.c
 create mode 100644 drivers/edac/al_l2_edac.c

-- 
2.17.1

