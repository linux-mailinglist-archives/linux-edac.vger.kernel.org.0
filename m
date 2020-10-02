Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15B002812B6
	for <lists+linux-edac@lfdr.de>; Fri,  2 Oct 2020 14:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387823AbgJBMa2 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 2 Oct 2020 08:30:28 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2947 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726090AbgJBMa2 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 2 Oct 2020 08:30:28 -0400
Received: from lhreml715-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id B99506BA6F7C194C561B;
        Fri,  2 Oct 2020 13:30:26 +0100 (IST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.84.119) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 2 Oct 2020 13:30:26 +0100
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <tony.luck@intel.com>, <rjw@rjwysocki.net>, <james.morse@arm.com>,
        <lenb@kernel.org>
CC:     <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH 5/7] RAS/CEC: Add support for errors count check on short time period
Date:   Fri, 2 Oct 2020 13:22:33 +0100
Message-ID: <20201002122235.1280-6-shiju.jose@huawei.com>
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

Some types of elements, for example CPU core, should be isolated
when the corrected errors reported too often. This is used for the
early fault prediction and would help to prevent serious faults
by taking corrective actions.
Modify CEC to support for the errors count check on short
time period. Implementation details is added in the file.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/ras/cec.c | 125 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 109 insertions(+), 16 deletions(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index f869e7a270b8..ca52917d514c 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -119,6 +119,23 @@ static struct ce_array {
 					 * shift for element id.
 					 */
 
+	struct delayed_work work;	/*
+					 * delayed work.
+					 */
+
+	bool short_period;		/* Indicates threshold check for the error count
+					 * over short time period.
+					 */
+
+	u8 time_slot;			/*
+					 * time slot's number within the decay interval.
+					 */
+
+	union {
+		struct mutex	mutex;
+		spinlock_t	spin_lock;
+	};
+
 	union {
 		struct {
 			__u32	disabled : 1,	/* cmdline disabled */
@@ -128,7 +145,6 @@ static struct ce_array {
 	};
 } ce_arr;
 
-static DEFINE_MUTEX(ce_mutex);
 static u64 dfs_pfn;
 
 /* Amount of errors after which we offline */
@@ -138,9 +154,35 @@ static u64 action_threshold = COUNT_MASK;
 #define CEC_DECAY_DEFAULT_INTERVAL	24 * 60 * 60	/* 24 hrs */
 #define CEC_DECAY_MIN_INTERVAL		 1 * 60 * 60	/* 1h */
 #define CEC_DECAY_MAX_INTERVAL	   30 *	24 * 60 * 60	/* one month */
-static struct delayed_work cec_work;
 static u64 decay_interval = CEC_DECAY_DEFAULT_INTERVAL;
 
+/* Definitions for elements (for example CPU) for which
+ * error count on shrot time period is checked with threshold.
+ *
+ * An element such as a CPU core may need to isolate when large number of
+ * correctable errors are reported on that element too often. When the
+ * CEs count is exceeded the threshold value in a short time period.
+ *
+ * The decay interval is divided into a number of time slots. The CE collector
+ * calculates the average error count at the end of each decay interval. Then
+ * the average count would be subtracted from the total count in each following
+ * time slots. The work function for the decay interval would be set  for the
+ * reduced time period = decay interval/ number of time slots. When the new
+ * CE count for a cpu is added, the element would be offlined when the sum of
+ * the most recent CEs counts exceeded the CE threshold value.
+ */
+
+/*
+ * u64: [ 63 ELEM ID 23 | ELEM_STATUS_BIT 22 | 21 AVG_COUNT_BITS 12 | 11 DECAY_BITS 10 | 9 COUNT_BITS 0]
+ */
+
+/* Number of time slots in the decay interval */
+#define RAS_CEC_NUM_TIME_SLOTS	10
+
+#define AVG_COUNT_SHIFT	(DECAY_BITS + COUNT_BITS)
+#define ELEM_STATUS_BIT	BIT(22)	/* Indicates an element offlined by CEC */
+#define ELEM_ID_SHIFT	(1 + AVG_COUNT_SHIFT + COUNT_BITS)
+
 /*
  * Decrement decay value. We're using DECAY_BITS bits to denote decay of an
  * element in the array. On insertion and any access, it gets reset to max.
@@ -177,11 +219,62 @@ static void cec_mod_work(struct delayed_work *dwork, unsigned long interval)
 
 static void cec_work_fn(struct work_struct *work)
 {
-	mutex_lock(&ce_mutex);
-	do_spring_cleaning(&ce_arr);
-	mutex_unlock(&ce_mutex);
+	struct ce_array *ca;
+	unsigned long flags;
+	u64 avg_count;
+	int i, time_slots = 1;
+	struct delayed_work *d_work = container_of(work, struct delayed_work, work);
+
+	if (!d_work)
+		return;
+
+	ca = container_of(d_work, struct ce_array, work);
+	if (!ca->array || ca->disabled)
+		return;
 
-	cec_mod_work(&cec_work, decay_interval);
+	if (!ca->short_period) {
+		mutex_lock(&ca->mutex);
+		do_spring_cleaning(ca);
+		mutex_unlock(&ca->mutex);
+	} else {
+		time_slots = RAS_CEC_NUM_TIME_SLOTS;
+		spin_lock_irqsave(&ca->spin_lock, flags);
+		ca->time_slot = (ca->time_slot + 1) % RAS_CEC_NUM_TIME_SLOTS;
+
+		for (i = 0; i < ca->n; i++) {
+			if (ca->array[i] & ELEM_STATUS_BIT)
+				continue;
+
+			/* clear old errors count approximately by subtracting the avg count
+			 * from the total errors count.
+			 */
+			avg_count = (ca->array[i] >> AVG_COUNT_SHIFT) & COUNT_MASK;
+			ca->array[i] -= avg_count;
+		}
+
+		if (ca->time_slot) {
+			spin_unlock_irqrestore(&ca->spin_lock, flags);
+			goto exit;
+		}
+
+		for (i = 0; i < ca->n; i++) {
+			if (ca->array[i] & ELEM_STATUS_BIT)
+				continue;
+
+			/* calculate average error count for the completed time period */
+			avg_count = COUNT(ca->array[i]) / RAS_CEC_NUM_TIME_SLOTS;
+			ca->array[i] -= (COUNT(ca->array[i]) % RAS_CEC_NUM_TIME_SLOTS);
+			/* store average error count */
+			ca->array[i] &= ~(COUNT_MASK << AVG_COUNT_SHIFT);
+			ca->array[i] |= (avg_count << AVG_COUNT_SHIFT);
+		}
+
+		do_spring_cleaning(ca);
+		spin_unlock_irqrestore(&ca->spin_lock, flags);
+	}
+
+exit:
+	cec_mod_work(&ca->work, decay_interval/time_slots);
 }
 
 /*
@@ -279,9 +372,9 @@ static u64 __maybe_unused del_lru_elem(void)
 	if (!ca->n)
 		return 0;
 
-	mutex_lock(&ce_mutex);
+	mutex_lock(&ca->mutex);
 	pfn = del_lru_elem_unlocked(ca);
-	mutex_unlock(&ce_mutex);
+	mutex_unlock(&ca->mutex);
 
 	return pfn;
 }
@@ -328,7 +421,7 @@ static int cec_add_elem(u64 pfn)
 	if (!ce_arr.array || ce_arr.disabled)
 		return -ENODEV;
 
-	mutex_lock(&ce_mutex);
+	mutex_lock(&ca->mutex);
 
 	ca->ces_entered++;
 
@@ -386,7 +479,7 @@ static int cec_add_elem(u64 pfn)
 	WARN_ON_ONCE(sanity_check(ca));
 
 unlock:
-	mutex_unlock(&ce_mutex);
+	mutex_unlock(&ca->mutex);
 
 	return ret;
 }
@@ -420,7 +513,7 @@ static int decay_interval_set(void *data, u64 val)
 	*(u64 *)data   = val;
 	decay_interval = val;
 
-	cec_mod_work(&cec_work, decay_interval);
+	cec_mod_work(&ce_arr.work, decay_interval);
 
 	return 0;
 }
@@ -446,7 +539,7 @@ static int array_dump(struct seq_file *m, void *v)
 	struct ce_array *ca = &ce_arr;
 	int i;
 
-	mutex_lock(&ce_mutex);
+	mutex_lock(&ca->mutex);
 
 	seq_printf(m, "{ n: %d\n", ca->n);
 	for (i = 0; i < ca->n; i++) {
@@ -468,7 +561,7 @@ static int array_dump(struct seq_file *m, void *v)
 
 	seq_printf(m, "Action threshold: %lld\n", action_threshold);
 
-	mutex_unlock(&ce_mutex);
+	mutex_unlock(&ca->mutex);
 
 	return 0;
 }
@@ -583,9 +676,9 @@ static void __init cec_init(void)
 
 #if defined(CONFIG_X86_MCE)
 	ce_arr.id_shift = PAGE_SHIFT;
-	INIT_DELAYED_WORK(&cec_work, cec_work_fn);
-	schedule_delayed_work(&cec_work, CEC_DECAY_DEFAULT_INTERVAL);
-
+	mutex_init(&ce_arr.mutex);
+	INIT_DELAYED_WORK(&ce_arr.work, cec_work_fn);
+	schedule_delayed_work(&ce_arr.work, CEC_DECAY_DEFAULT_INTERVAL);
 	mce_register_decode_chain(&cec_nb);
 #endif
 
-- 
2.17.1


