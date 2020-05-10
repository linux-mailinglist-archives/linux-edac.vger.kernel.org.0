Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D86C1CCBD4
	for <lists+linux-edac@lfdr.de>; Sun, 10 May 2020 17:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbgEJPNp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 10 May 2020 11:13:45 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:43639 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbgEJPNo (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 10 May 2020 11:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1589123624; x=1620659624;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=/lx9IMGD8OSpcKaP41yqeupdgWSyQSZIGmwGMoAhdCg=;
  b=oQl+AW3YH3ZBWLLp4npDWf1UrBmcxvmsll5muXZafEvZ2GS6CZLiHa6Y
   dZiFj3VDou7s6t9U7WCiAh4lNpq5ifawp3/zmtTXjsufnY/rfn72qcxcr
   +ys88e0FMwnC0G+ibEKL9yc7CDfUyU0JkMF0KMowzoeBDd54YNTx7Snyo
   0=;
IronPort-SDR: +W8UwZhm0Fx7/mRtYUUkxX8eD4DLs/LEYmrt/nZnrm+KmWQQFDAzSIO3mf/bD+mmJUIXwbsaU0
 WNegxKNnJ/GA==
X-IronPort-AV: E=Sophos;i="5.73,376,1583193600"; 
   d="scan'208";a="43758773"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-53356bf6.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 10 May 2020 15:13:42 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-53356bf6.us-west-2.amazon.com (Postfix) with ESMTPS id EF549A17F0;
        Sun, 10 May 2020 15:13:41 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 10 May 2020 15:13:41 +0000
Received: from u8a88181e7b2355.ant.amazon.com (10.43.161.174) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 10 May 2020 15:13:32 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <bp@alien8.de>, <mchehab@kernel.org>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <rrichter@marvell.com>, <hhhawa@amazon.com>,
        <robh+dt@kernel.org>, <frowand.list@gmail.com>,
        <davem@davemloft.net>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <dwmw@amazon.co.uk>,
        <benh@amazon.com>, <ronenk@amazon.com>, <talel@amazon.com>,
        <jonnyc@amazon.com>, <hanochu@amazon.com>, <eitan@amazon.com>
Subject: [PATCH v10 0/3] Introduce Amazon's Annapurna Labs L1/L2 EDAC drivers
Date:   Sun, 10 May 2020 18:13:07 +0300
Message-ID: <20200510151310.17372-1-hhhawa@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.174]
X-ClientProxiedBy: EX13D27UWB002.ant.amazon.com (10.43.161.167) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This series introduce Amazon's Annapurna Labs L1/L2 EDAC drivers.

Alpine SoCs supports L1 and L2 single bit correction and two bits detection
capability based on ARM implementation.

The CPU cores in the SoC are the same and all of them support ECC.

Changes since v9:
-----------------
- Fix include order (asm/ includes after linux/)
- Update local variables declaration order
- Use private structure in al_l1_edac driver.
- Add missing platform_driver_unregister(), in init() function.
- Commit message updates.

Changes since v8:
-----------------
- Fix Kconfig dependency, to be depends ARM64 in any case (for compile
  test also), as the driver use arm64 sysreg functions.
  Reported-by: kbuild test robot <lkp@intel.com>

Changes since v7:
-----------------
- Add missing <linux/platform_device.h> include
- Use new APIs edac_device_handle_{ue/ce}_count
- Add lock around edac_device_handle_{ue/ce}_count
- Check retrun value of of_find_node_by_path
- Remove the goto with single usage and restructuring the code
- Add of_node_put for L2 cache of_node

Changes since v6:
-----------------
- Add ARM64 dependency
- Add COMPILE_TEST

Changes since v5:
-----------------
- Use top-level machine compatible to bind the EDAC device
- Remove DT bindings
- Add initcall to create platform device and register the edac driver
- follow 'next-level-cache' phandle to create CPU topology for L2 driver
- Change the driver to be tristate
- Move register read to function flow
- EXPORT_SYMBOL_GPL of_find_next_cache_node

Changes since v4:
-----------------
- Added include for cpumask.h in al_l2_edac.c
- Fix RAMID error print according to ARM TRM
- Use for_each_possible_cpu() to parse information for DT.
- Add missing of_node_put() call.

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


Hanna Hawa (3):
  edac: Introduce Amazon's Annapurna Labs L1 EDAC driver
  of: EXPORT_SYMBOL_GPL of_find_next_cache_node
  edac: Introduce Amazon's Annapurna Labs L2 EDAC driver

 MAINTAINERS               |  10 ++
 drivers/edac/Kconfig      |  16 +++
 drivers/edac/Makefile     |   2 +
 drivers/edac/al_l1_edac.c | 213 +++++++++++++++++++++++++++++
 drivers/edac/al_l2_edac.c | 273 ++++++++++++++++++++++++++++++++++++++
 drivers/of/base.c         |   1 +
 6 files changed, 515 insertions(+)
 create mode 100644 drivers/edac/al_l1_edac.c
 create mode 100644 drivers/edac/al_l2_edac.c

-- 
2.17.1

