Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21885254677
	for <lists+linux-edac@lfdr.de>; Thu, 27 Aug 2020 16:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgH0OJi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 27 Aug 2020 10:09:38 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2701 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728021AbgH0OJC (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 27 Aug 2020 10:09:02 -0400
Received: from lhreml715-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id D1E6A212A5BB64F42505;
        Thu, 27 Aug 2020 15:08:36 +0100 (IST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.87.119) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 27 Aug 2020 15:08:36 +0100
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bp@alien8.de>, <mchehab@kernel.org>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <rrichter@marvell.com>
CC:     <linuxarm@huawei.com>, Borislav Petkov <bp@suse.de>
Subject: [PATCH v2 1/1] EDAC/ghes: Fix for NULL pointer dereference in ghes_edac_register()
Date:   Thu, 27 Aug 2020 15:04:50 +0100
Message-ID: <20200827140450.1620-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.47.87.119]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml715-chm.china.huawei.com (10.201.108.66)
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

After the 'commit b9cae27728d1 ("EDAC/ghes: Scan the system once on driver init")'
applied, following error has occurred in the ghes_edac_register() when
CONFIG_DEBUG_TEST_DRIVER_REMOVE is enabled. The null ghes_hw.dimms pointer
in the mci_for_each_dimm() of ghes_edac_register() caused the error.

The error occurs when all the previously initialized ghes instances are
removed and then probe a new ghes instance. In this case, the ghes_refcount
would be 0, ghes_hw.dimms and mci already freed. The ghes_hw.dimms would
be null because ghes_scan_system() would not call enumerate_dimms() again.

Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/edac/ghes_edac.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index da60c29468a7..54ebc8afc6b1 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -55,6 +55,8 @@ static DEFINE_SPINLOCK(ghes_lock);
 static bool __read_mostly force_load;
 module_param(force_load, bool, 0);
 
+static bool system_scanned;
+
 /* Memory Device - Type 17 of SMBIOS spec */
 struct memdev_dmi_entry {
 	u8 type;
@@ -225,14 +227,12 @@ static void enumerate_dimms(const struct dmi_header *dh, void *arg)
 
 static void ghes_scan_system(void)
 {
-	static bool scanned;
-
-	if (scanned)
+	if (system_scanned)
 		return;
 
 	dmi_walk(enumerate_dimms, &ghes_hw);
 
-	scanned = true;
+	system_scanned = true;
 }
 
 void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
@@ -631,6 +631,8 @@ void ghes_edac_unregister(struct ghes *ghes)
 
 	mutex_lock(&ghes_reg_mutex);
 
+	system_scanned = false;
+
 	if (!refcount_dec_and_test(&ghes_refcount))
 		goto unlock;
 
-- 
2.17.1


