Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753C7281298
	for <lists+linux-edac@lfdr.de>; Fri,  2 Oct 2020 14:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387491AbgJBM0y (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 2 Oct 2020 08:26:54 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2942 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726010AbgJBM0y (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 2 Oct 2020 08:26:54 -0400
Received: from lhreml715-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id D7B1D99435002D5B9B38;
        Fri,  2 Oct 2020 13:26:52 +0100 (IST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.84.119) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 2 Oct 2020 13:26:51 +0100
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <tony.luck@intel.com>, <rjw@rjwysocki.net>, <james.morse@arm.com>,
        <lenb@kernel.org>
CC:     <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH 0/7] RAS/CEC: Extend CEC for errors count check on short time period
Date:   Fri, 2 Oct 2020 13:22:28 +0100
Message-ID: <20201002122235.1280-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.47.84.119]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml715-chm.china.huawei.com (10.201.108.66)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

In ARM64 hardware platforms, for example our Kunpeng platforms, CPU L1/L2
cache corrected errors are reported in the ARM processor error section.
The situations the CPU CE errors are reported too often is not unlikely
and may need to isolate that CPU core to prevent leading to more 
serious faults. This is important for the early fault prediction.

Extend the existing RAS CEC to support the errors count check on short
time period with the threshold. The decay interval is divided into a
number of time slots for these elements. The CEC calculates the average
error count for each element at the end of each decay interval. Then the
average count would be subtracted from the total count in each of the
following time slots within the decay interval. The work function for
the decay interval would be set for a reduced time period = decay
interval/ number of time slots. When the new CE count for a CPU is added,
the element would try to offline when the sum of the most recent CEs
counts exceeded the CEs threshold value. More implementation details is
added in the file.

Add collection of CPU correctable errors, for example ARM64 L1/L2 cache
errors and isolation of the CPU core when the errors count in the short
time interval exceed the threshold value.

Open Questions based on the feedback from Boris,
1. ARM processor error types are cache/TLB/bus errors.
   [Reference N2.4.4.1 ARM Processor Error Information UEFI Spec v2.8]
Any of the above error types should not be consider for the
error collection and CPU core isolation?

2.If disabling entire CPU core is not acceptable,
please suggest method to disable L1 and L2 cache on ARM64 core?

Shiju Jose (7):
  RAS/CEC: Replace the macro PFN with ELEM_NO
  RAS/CEC: Replace pfns_poisoned with elems_poisoned
  RAS/CEC: Move X86 MCE specific code under CONFIG_X86_MCE
  RAS/CEC: Modify cec_mod_work() for common use
  RAS/CEC: Add support for errors count check on short time period
  RAS/CEC: Add CPU Correctable Error Collector to isolate an erroneous
    CPU core
  ACPI / APEI: Add reporting ARM64 CPU correctable errors to the CEC

 arch/arm64/ras/Kconfig   |  17 ++
 drivers/acpi/apei/ghes.c |  36 +++-
 drivers/ras/Kconfig      |   1 +
 drivers/ras/cec.c        | 399 +++++++++++++++++++++++++++++++++++----
 include/linux/ras.h      |   9 +
 5 files changed, 418 insertions(+), 44 deletions(-)
 create mode 100644 arch/arm64/ras/Kconfig

-- 
2.17.1


