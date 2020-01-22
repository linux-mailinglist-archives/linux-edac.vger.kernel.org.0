Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA47145283
	for <lists+linux-edac@lfdr.de>; Wed, 22 Jan 2020 11:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbgAVKZq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 22 Jan 2020 05:25:46 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:37458 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728931AbgAVKZq (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 22 Jan 2020 05:25:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1579688745; x=1611224745;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=1KJZAONR2f4vzhQZ6N7RXsck77ezyTVdrw12qtzAkSo=;
  b=GfWKJ722UpU4KuSzGA7U8aNOqdKufUjvPv2f9rWz6sJSXtAixKZ8CQ0L
   iAOT2Np85V19nt/dYgWAHn7BW2h9nm7iLnQiaEJLKcCdm8ZFUeZ6n3TjZ
   5hGHZXLtu/6/2PCV2w+Otanrd+6DWL/iiMuoY0bs7TgqirHhDeVrgv3q/
   E=;
IronPort-SDR: xYRfSNNzHC4uX30gzo5bMIderXlYO3FSZCB1bMz3O1hg25h/1B8AQzcgHUpsr4fYVvl8p3Y6f1
 Js3q0hX/4VxA==
X-IronPort-AV: E=Sophos;i="5.70,349,1574121600"; 
   d="scan'208";a="13581595"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 22 Jan 2020 10:25:44 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (Postfix) with ESMTPS id ED8F6A23D4;
        Wed, 22 Jan 2020 10:25:38 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Wed, 22 Jan 2020 10:25:38 +0000
Received: from u8a88181e7b2355.ant.amazon.com (10.43.161.78) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 22 Jan 2020 10:25:28 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <bp@alien8.de>, <mchehab@kernel.org>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <rrichter@marvell.com>, <hhhawa@amazon.com>,
        <robh+dt@kernel.org>, <frowand.list@gmail.com>,
        <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <Jonathan.Cameron@huawei.com>, <arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <dwmw@amazon.co.uk>,
        <benh@amazon.com>, <ronenk@amazon.com>, <talel@amazon.com>,
        <jonnyc@amazon.com>, <hanochu@amazon.com>, <barakw@amazon.com>
Subject: [PATCH v8 0/3] Add support for Amazon's Annapurna Labs EDAC for L1/L2
Date:   Wed, 22 Jan 2020 12:25:10 +0200
Message-ID: <20200122102513.31132-1-hhhawa@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.78]
X-ClientProxiedBy: EX13D28UWB004.ant.amazon.com (10.43.161.56) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This series adds L1 cache and L2 cache error detection and correction support
for Amazon's Annapurna Labs SoCs.

Alpine SoCs supports L1 and L2 single bit correction and two bits detection
capability based on ARM implementation.

The CPU cores in the SoC are the same and all of them support ECC.

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

ubject: [PATCH v7 0/3] Add support for Amazon's Annapurna Labs EDAC for L1/L2

This series adds L1 cache and L2 cache error detection and correction support
for Amazon's Annapurna Labs SoCs.

Alpine SoCs supports L1 and L2 single bit correction and two bits detection
capability based on ARM implementation.

The CPU cores in the SoC are the same and all of them support ECC.

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
  edac: Add support for Amazon's Annapurna Labs L1 EDAC
  of: EXPORT_SYMBOL_GPL of_find_next_cache_node
  edac: Add support for Amazon's Annapurna Labs L2 EDAC

 MAINTAINERS               |  10 ++
 drivers/edac/Kconfig      |  16 +++
 drivers/edac/Makefile     |   2 +
 drivers/edac/al_l1_edac.c | 207 +++++++++++++++++++++++++++++
 drivers/edac/al_l2_edac.c | 270 ++++++++++++++++++++++++++++++++++++++
 drivers/of/base.c         |   1 +
 6 files changed, 506 insertions(+)
 create mode 100644 drivers/edac/al_l1_edac.c
 create mode 100644 drivers/edac/al_l2_edac.c

-- 
2.17.1

