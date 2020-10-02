Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331982812A1
	for <lists+linux-edac@lfdr.de>; Fri,  2 Oct 2020 14:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387717AbgJBM2J (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 2 Oct 2020 08:28:09 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2944 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726010AbgJBM2I (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 2 Oct 2020 08:28:08 -0400
Received: from lhreml715-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 2E84F37E9A5E1E12C15D;
        Fri,  2 Oct 2020 13:28:07 +0100 (IST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.84.119) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 2 Oct 2020 13:28:06 +0100
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <tony.luck@intel.com>, <rjw@rjwysocki.net>, <james.morse@arm.com>,
        <lenb@kernel.org>
CC:     <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH 2/7] RAS/CEC: Replace pfns_poisoned with elems_poisoned
Date:   Fri, 2 Oct 2020 13:22:30 +0100
Message-ID: <20201002122235.1280-3-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20201002122235.1280-1-shiju.jose@huawei.com>
References: <20201002122235.1280-1-shiju.jose@huawei.com>
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

Replace the variable pfns_poisoned with elems_poisoned
for the common use.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/ras/cec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index 22d11c66c266..f20da1103f27 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -100,8 +100,8 @@ static struct ce_array {
 					 * since the last spring cleaning.
 					 */
 
-	u64 pfns_poisoned;		/*
-					 * number of PFNs which got poisoned.
+	u64 elems_poisoned;		/*
+					 * number of elements which got poisoned.
 					 */
 
 	u64 ces_entered;		/*
@@ -362,7 +362,7 @@ static int cec_add_elem(u64 pfn)
 			/* We have reached max count for this page, soft-offline it. */
 			pr_err("Soft-offlining pfn: 0x%llx\n", pfn);
 			memory_failure_queue(pfn, MF_SOFT_OFFLINE);
-			ca->pfns_poisoned++;
+			ca->elems_poisoned++;
 		}
 
 		del_elem(ca, to);
@@ -457,7 +457,7 @@ static int array_dump(struct seq_file *m, void *v)
 	seq_printf(m, "}\n");
 
 	seq_printf(m, "Stats:\nCEs: %llu\nofflined pages: %llu\n",
-		   ca->ces_entered, ca->pfns_poisoned);
+		   ca->ces_entered, ca->elems_poisoned);
 
 	seq_printf(m, "Flags: 0x%x\n", ca->flags);
 
-- 
2.17.1


