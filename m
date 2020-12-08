Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3DB22D311B
	for <lists+linux-edac@lfdr.de>; Tue,  8 Dec 2020 18:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgLHRbH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 8 Dec 2020 12:31:07 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2222 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgLHRbG (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 8 Dec 2020 12:31:06 -0500
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Cr6b76KMnz67NwN;
        Wed,  9 Dec 2020 01:28:19 +0800 (CST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 8 Dec 2020 18:30:24 +0100
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.26.232) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 8 Dec 2020 17:30:23 +0000
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <james.morse@arm.com>,
        <mchehab+huawei@kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>, <rrichter@marvell.com>
CC:     <linuxarm@huawei.com>, <xuwei5@huawei.com>,
        <jonathan.cameron@huawei.com>, <john.garry@huawei.com>,
        <tanxiaofei@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
        <salil.mehta@huawei.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH 0/2] EDAC/ghes: Add EDAC device for recording the CPU error count
Date:   Tue, 8 Dec 2020 17:29:57 +0000
Message-ID: <20201208172959.1249-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.47.26.232]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
 lhreml715-chm.china.huawei.com (10.201.108.66)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

For the firmware-first error handling on ARM64 hardware platforms,
CPU cache corrected error count is not recorded.
Create an CPU EDAC device and device blocks for the CPU caches
for this purpose. The EDAC device blocks are created based on the
cache information from the cpu_cacheinfo.

User-space application could monitor the recorded corrected error
count for the predictive failure analysis.

More information in the patch headers.

Shiju Jose (2):
  EDAC/ghes: Add EDAC device for the CPU caches
  ACPI / APEI: Add reporting ARM64 CPU cache corrected error count

 Documentation/ABI/testing/sysfs-devices-edac |  15 ++
 drivers/acpi/apei/ghes.c                     |  76 ++++++++-
 drivers/edac/Kconfig                         |  10 ++
 drivers/edac/ghes_edac.c                     | 171 +++++++++++++++++++
 include/acpi/ghes.h                          |  27 +++
 include/linux/cper.h                         |   4 +
 6 files changed, 299 insertions(+), 4 deletions(-)

-- 
2.17.1

