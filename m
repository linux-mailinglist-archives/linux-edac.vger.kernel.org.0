Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1030814D15F
	for <lists+linux-edac@lfdr.de>; Wed, 29 Jan 2020 20:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbgA2Tu5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 29 Jan 2020 14:50:57 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:10289 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbgA2Tu5 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 29 Jan 2020 14:50:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1580327456; x=1611863456;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=ijxUrXIF7H+a2bNsO7mjxKNb71oEKOuUI/xmMiqxAYM=;
  b=uMy78X9wdCVFgy02ai57vWLt23+5x9lJSwl5s7NBAFi6UsUwouVH8p3O
   S0wYG9g+0OySChWOWMf8NRybrCf2aVsU8ZMc9GxkS9zU9qzGUhddIYBXB
   Z3QAQh58v+Jtt0uwwb01j5dSfwpGlqiqeDqzfyDMVq7HIctWHtkoWDcFk
   k=;
IronPort-SDR: YlgQNb0oj/cvTZnYjD3rxSSd4pgvKyZrGNpg9h93ywzZGIuMc+9hwSZB6OSy6Cb9EA0qbVLGtb
 l9sOUaNsqG8Q==
X-IronPort-AV: E=Sophos;i="5.70,379,1574121600"; 
   d="scan'208";a="14824234"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-e7be2041.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 29 Jan 2020 19:50:53 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-e7be2041.us-west-2.amazon.com (Postfix) with ESMTPS id 8A585A1805;
        Wed, 29 Jan 2020 19:50:52 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Wed, 29 Jan 2020 19:50:52 +0000
Received: from u8a88181e7b2355.ant.amazon.com (10.43.162.50) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 29 Jan 2020 19:50:41 +0000
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
Subject: [PATCH v9 0/3] Add support for Amazon's Annapurna Labs EDAC for L1/L2
Date:   Wed, 29 Jan 2020 21:50:13 +0200
Message-ID: <20200129195016.956-1-hhhawa@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.50]
X-ClientProxiedBy: EX13D13UWB003.ant.amazon.com (10.43.161.233) To
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

