Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3142A8581
	for <lists+linux-edac@lfdr.de>; Thu,  5 Nov 2020 19:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730862AbgKESBZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 5 Nov 2020 13:01:25 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2058 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbgKESBY (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 5 Nov 2020 13:01:24 -0500
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CRrRK75P1z67Htg;
        Fri,  6 Nov 2020 01:41:17 +0800 (CST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 5 Nov 2020 18:42:33 +0100
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.87.221) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 5 Nov 2020 17:42:32 +0000
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <james.morse@arm.com>,
        <bp@alien8.de>, <tony.luck@intel.com>, <rjw@rjwysocki.net>,
        <lenb@kernel.org>, <rrichter@marvell.com>
CC:     <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
        <shiju.jose@huawei.com>
Subject: [RFC PATCH 0/4] EDAC/ghes: Add EDAC device for recording the CPU error count
Date:   Thu, 5 Nov 2020 17:42:29 +0000
Message-ID: <20201105174233.1146-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.87.221]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml715-chm.china.huawei.com (10.201.108.66)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

For the firmware-first error handling on ARM64 hardware platforms,
CPU cache corrected error count is not recorded.
Create an CPU EDAC device and device blocks for the CPU caches
for this purpose. The EDAC device blocks  are created based on the
CPU caches information represented in the ACPI PPTT.

User-space application could monitor the recorded corrected error
count for the early fault detection.

Jonathan Cameron (1):
  ACPI: PPTT: Fix for a high level cache node detected in the low level

Shiju Jose (3):
  ACPI: PPTT: Add function acpi_find_cache_info
  EDAC/ghes: Add EDAC device for the CPU caches
  ACPI / APEI: Add reporting ARM64 CPU cache corrected error count

 drivers/acpi/apei/ghes.c  |  79 +++++++++++++++++++++-
 drivers/acpi/pptt.c       | 123 +++++++++++++++++++++++++++++++++-
 drivers/edac/Kconfig      |  10 +++
 drivers/edac/ghes_edac.c  | 135 ++++++++++++++++++++++++++++++++++++++
 include/acpi/ghes.h       |  27 ++++++++
 include/linux/cacheinfo.h |  12 ++++
 include/linux/cper.h      |   4 ++
 7 files changed, 386 insertions(+), 4 deletions(-)

-- 
2.17.1

