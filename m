Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3EECE729
	for <lists+linux-edac@lfdr.de>; Mon,  7 Oct 2019 17:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbfJGPSB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 7 Oct 2019 11:18:01 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:44849 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbfJGPSB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 7 Oct 2019 11:18:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1570461480; x=1601997480;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=dUiabn5+4m2UPQhv0R2C4bPeirmU2fuRBGUPhMjm7KQ=;
  b=ZBMH2wAy8+3X3FtuR3236WBL09C1lmSbGp2L7eh3cepjdZeYy3zJo/1s
   ZBpUBjynIWkCJ12g/kMSbD/4E4Dx5gjxWgNEs2HbOqV8N/i7s8BfTsHcL
   V4rnKlX3Dt+IahRMsoTfO/gH6pj7Tck/tDwMQXyhhVKyFvqZAo75/vx2k
   w=;
X-IronPort-AV: E=Sophos;i="5.67,268,1566864000"; 
   d="scan'208";a="420554456"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 07 Oct 2019 15:17:59 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com (Postfix) with ESMTPS id DAF07A2352;
        Mon,  7 Oct 2019 15:17:54 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 7 Oct 2019 15:17:54 +0000
Received: from ua9e4f3715fbc5f.ant.amazon.com (10.43.162.116) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 7 Oct 2019 15:17:44 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <bp@alien8.de>, <mchehab@kernel.org>, <mark.rutland@arm.com>,
        <james.morse@arm.com>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>, <davem@davemloft.net>,
        <gregkh@linuxfoundation.org>, <linus.walleij@linaro.org>,
        <daniel@iogearbox.net>, <paulmck@linux.ibm.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <dwmw@amazon.co.uk>,
        <benh@amazon.com>, <ronenk@amazon.com>, <talel@amazon.com>,
        <jonnyc@amazon.com>, <hanochu@amazon.com>, <hhhawa@amazon.com>
Subject: [PATCH v6 0/3] Add support for Amazon's Annapurna Labs EDAC for L1/L2
Date:   Mon, 7 Oct 2019 16:17:27 +0100
Message-ID: <20191007151730.7705-1-hhhawa@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.116]
X-ClientProxiedBy: EX13D03UWC002.ant.amazon.com (10.43.162.160) To
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
 drivers/edac/al_l1_edac.c | 190 +++++++++++++++++++++++++++++
 drivers/edac/al_l2_edac.c | 251 ++++++++++++++++++++++++++++++++++++++
 drivers/of/base.c         |   1 +
 6 files changed, 470 insertions(+)
 create mode 100644 drivers/edac/al_l1_edac.c
 create mode 100644 drivers/edac/al_l2_edac.c

-- 
2.17.1

