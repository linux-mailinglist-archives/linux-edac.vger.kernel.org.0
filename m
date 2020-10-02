Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4560C28129B
	for <lists+linux-edac@lfdr.de>; Fri,  2 Oct 2020 14:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbgJBM1f (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 2 Oct 2020 08:27:35 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2943 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726176AbgJBM1f (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 2 Oct 2020 08:27:35 -0400
Received: from lhreml715-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 9466F8D17E98730A081B;
        Fri,  2 Oct 2020 13:27:33 +0100 (IST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.84.119) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 2 Oct 2020 13:27:33 +0100
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <tony.luck@intel.com>, <rjw@rjwysocki.net>, <james.morse@arm.com>,
        <lenb@kernel.org>
CC:     <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH 1/7] RAS/CEC: Replace the macro PFN with ELEM_NO
Date:   Fri, 2 Oct 2020 13:22:29 +0100
Message-ID: <20201002122235.1280-2-shiju.jose@huawei.com>
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

Replace the macro PFN with ELEM_NO for common use.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/ras/cec.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index 569d9ad2c594..22d11c66c266 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -86,7 +86,7 @@
  * u64: [ 63 ... 12 | DECAY_BITS | COUNT_BITS ]
  */
 
-#define PFN(e)			((e) >> PAGE_SHIFT)
+#define ELEM_NO(e, shift)	((e) >> (shift))
 #define DECAY(e)		(((e) >> COUNT_BITS) & DECAY_MASK)
 #define COUNT(e)		((unsigned int)(e) & COUNT_MASK)
 #define FULL_COUNT(e)		((e) & (PAGE_SIZE - 1))
@@ -113,6 +113,10 @@ static struct ce_array {
 					 * Times we did spring cleaning.
 					 */
 
+	u8 id_shift;			/*
+					 * shift for element id.
+					 */
+
 	union {
 		struct {
 			__u32	disabled : 1,	/* cmdline disabled */
@@ -191,7 +195,7 @@ static int __find_elem(struct ce_array *ca, u64 pfn, unsigned int *to)
 	while (min <= max) {
 		int i = (min + max) >> 1;
 
-		this_pfn = PFN(ca->array[i]);
+		this_pfn = ELEM_NO(ca->array[i], ca->id_shift);
 
 		if (this_pfn < pfn)
 			min = i + 1;
@@ -258,7 +262,7 @@ static u64 del_lru_elem_unlocked(struct ce_array *ca)
 
 	del_elem(ca, min_idx);
 
-	return PFN(ca->array[min_idx]);
+	return ELEM_NO(ca->array[min_idx], ca->id_shift);
 }
 
 /*
@@ -287,7 +291,7 @@ static bool sanity_check(struct ce_array *ca)
 	int i;
 
 	for (i = 0; i < ca->n; i++) {
-		u64 this = PFN(ca->array[i]);
+		u64 this = ELEM_NO(ca->array[i], ca->id_shift);
 
 		if (WARN(prev > this, "prev: 0x%016llx <-> this: 0x%016llx\n", prev, this))
 			ret = true;
@@ -300,7 +304,7 @@ static bool sanity_check(struct ce_array *ca)
 
 	pr_info("Sanity check dump:\n{ n: %d\n", ca->n);
 	for (i = 0; i < ca->n; i++) {
-		u64 this = PFN(ca->array[i]);
+		u64 this = ELEM_NO(ca->array[i], ca->id_shift);
 
 		pr_info(" %03d: [%016llx|%03llx]\n", i, this, FULL_COUNT(ca->array[i]));
 	}
@@ -444,7 +448,7 @@ static int array_dump(struct seq_file *m, void *v)
 
 	seq_printf(m, "{ n: %d\n", ca->n);
 	for (i = 0; i < ca->n; i++) {
-		u64 this = PFN(ca->array[i]);
+		u64 this = ELEM_NO(ca->array[i], ca->id_shift);
 
 		seq_printf(m, " %3d: [%016llx|%s|%03llx]\n",
 			   i, this, bins[DECAY(ca->array[i])], COUNT(ca->array[i]));
@@ -569,6 +573,7 @@ static void __init cec_init(void)
 		return;
 	}
 
+	ce_arr.id_shift = PAGE_SHIFT;
 	INIT_DELAYED_WORK(&cec_work, cec_work_fn);
 	schedule_delayed_work(&cec_work, CEC_DECAY_DEFAULT_INTERVAL);
 
-- 
2.17.1


