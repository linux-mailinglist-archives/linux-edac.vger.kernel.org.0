Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450BE2812BC
	for <lists+linux-edac@lfdr.de>; Fri,  2 Oct 2020 14:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387844AbgJBMbW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 2 Oct 2020 08:31:22 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2948 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726090AbgJBMbV (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 2 Oct 2020 08:31:21 -0400
Received: from lhreml715-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 4821A485866C963EC62F;
        Fri,  2 Oct 2020 13:31:20 +0100 (IST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.84.119) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 2 Oct 2020 13:31:19 +0100
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <tony.luck@intel.com>, <rjw@rjwysocki.net>, <james.morse@arm.com>,
        <lenb@kernel.org>
CC:     <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH 6/7] RAS/CEC: Add CPU Correctable Error Collector to isolate an erroneous CPU core
Date:   Fri, 2 Oct 2020 13:22:34 +0100
Message-ID: <20201002122235.1280-7-shiju.jose@huawei.com>
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

When the CPU correctable errors, for example L1/L2 cache errors,
reported on an ARM64 CPU core too often, it should be isolated.
Add the CPU correctable error collector to store the CPU correctable
error count.

When the correctable error count for a CPU exceed the threshold
value in a short time period, it will try to isolate the CPU core.

If disabling entire CPU core is not acceptable, Please suggest
method to disable L1 and L2 cache on ARM64 core?

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 arch/arm64/ras/Kconfig |  17 +++
 drivers/ras/Kconfig    |   1 +
 drivers/ras/cec.c      | 231 +++++++++++++++++++++++++++++++++++++++--
 include/linux/ras.h    |   9 ++
 4 files changed, 247 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm64/ras/Kconfig

diff --git a/arch/arm64/ras/Kconfig b/arch/arm64/ras/Kconfig
new file mode 100644
index 000000000000..bfa14157cd2e
--- /dev/null
+++ b/arch/arm64/ras/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0
+config RAS_CEC
+        bool "Correctable Errors Collector"
+        depends on ARM64 && HOTPLUG_CPU && DEBUG_FS
+        help
+          This is a small cache which collects correctable CPU errors and
+          counts their repeated occurrence. Once the counter for a CPU
+          overflows in a short time period, we try to offline that CPU
+          as we take it to mean that it has reached a relatively high error
+          count and would probably be best if we don't use it anymore.
+
+          Presently CPU error correction enabld for ARM64 platform only.
+
+config RAS_CEC_DEBUG
+        bool "CEC debugging machinery"
+        default n
+        depends on RAS_CEC
diff --git a/drivers/ras/Kconfig b/drivers/ras/Kconfig
index c2a236f2e846..d2f877e5f7ad 100644
--- a/drivers/ras/Kconfig
+++ b/drivers/ras/Kconfig
@@ -32,5 +32,6 @@ menuconfig RAS
 if RAS
 
 source "arch/x86/ras/Kconfig"
+source "arch/arm64/ras/Kconfig"
 
 endif
diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index ca52917d514c..408bf2ac2461 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -7,6 +7,8 @@
 #include <linux/ras.h>
 #include <linux/kernel.h>
 #include <linux/workqueue.h>
+#include <linux/cpu.h>
+#include <linux/slab.h>
 
 #if defined(CONFIG_X86_MCE)
 #include <asm/mce.h>
@@ -143,7 +145,7 @@ static struct ce_array {
 		};
 		__u32 flags;
 	};
-} ce_arr;
+} ce_arr, cpu_ce_arr;
 
 static u64 dfs_pfn;
 
@@ -156,6 +158,8 @@ static u64 action_threshold = COUNT_MASK;
 #define CEC_DECAY_MAX_INTERVAL	   30 *	24 * 60 * 60	/* one month */
 static u64 decay_interval = CEC_DECAY_DEFAULT_INTERVAL;
 
+static const char * const bins[] = { "00", "01", "10", "11" };
+
 /* Definitions for elements (for example CPU) for which
  * error count on shrot time period is checked with threshold.
  *
@@ -484,6 +488,172 @@ static int cec_add_elem(u64 pfn)
 	return ret;
 }
 
+struct cec_elem_offline {
+	struct work_struct work;
+	struct ce_array *ca;
+	int array_index;
+	int elem_id;
+};
+
+/*
+ * Work function to offline a cpu because the offlining to be done
+ * in the process context.
+ */
+static void cec_cpu_offline_work_fn(struct work_struct *work)
+{
+	int rc, cpu;
+	struct cec_elem_offline *elem;
+	struct ce_array *ca;
+
+	elem = container_of(work, struct cec_elem_offline, work);
+
+	cpu = elem->elem_id;
+	if (!cpu_online(cpu))
+		return;
+
+	rc = remove_cpu(cpu);
+	if (rc) {
+		pr_warn("Failed to offline CPU%d, error %d\n", cpu, rc);
+	} else {
+		ca = elem->ca;
+		ca->array[elem->array_index] |= ELEM_STATUS_BIT;
+	}
+
+	kfree(elem);
+}
+
+int cec_cpu_add_elem(int cpu, u64 ce_count)
+{
+	struct ce_array *ca = &cpu_ce_arr;
+	unsigned int to = 0;
+	int count, ret = 0;
+	unsigned long flags;
+	struct cec_elem_offline *elem;
+
+	/*
+	 * We can be called very early on the identify_cpu() path where we are
+	 * not initialized yet. We ignore the error for simplicity.
+	 */
+	if (!ca->array || ca->disabled || !cpu_online(cpu))
+		return -ENODEV;
+
+	spin_lock_irqsave(&ca->spin_lock, flags);
+
+	ca->ces_entered++;
+
+	ret = find_elem(ca, cpu, &to);
+	if (ret < 0) {
+		/*
+		 * Shift range [to-end] to make room for one more element.
+		 */
+		memmove((void *)&ca->array[to + 1],
+			(void *)&ca->array[to],
+			(ca->n - to) * sizeof(u64));
+
+		ca->array[to] = cpu << ca->id_shift;
+		ca->n++;
+	}
+
+	/* Error received for a previously CEC offlined CPU, which later online elsewhere.
+	 * reset array.
+	 */
+	if (ca->array[to] & ELEM_STATUS_BIT) {
+		ca->array[to] &= ~(ELEM_STATUS_BIT);
+		ca->array[to] &= ~(COUNT_MASK);
+	}
+
+	/* Add/refresh element generation and increment count */
+	ca->array[to] |= DECAY_MASK << COUNT_BITS;
+	ca->array[to] += ce_count;
+
+	/* Check action threshold and offline, if reached. */
+	count = COUNT(ca->array[to]);
+	if (count >= action_threshold) {
+		if (!cpu_online(cpu)) {
+			pr_warn("CEC: Invalid cpu: %d\n", cpu);
+		} else {
+			/* We have reached max count for this cpu, offline it. */
+			ca->elems_poisoned++;
+			/* schedule work function to offline the cpu */
+			elem = kmalloc(sizeof(*elem), GFP_NOWAIT);
+			if (elem) {
+				pr_info("CEC: offlining cpu: %d\n", cpu);
+				elem->ca = ca;
+				elem->array_index = to;
+				elem->elem_id = cpu;
+				INIT_WORK(&elem->work, cec_cpu_offline_work_fn);
+				schedule_work(&elem->work);
+			} else
+				pr_warn("CEC: offlining cpu: out of memory %d\n", cpu);
+		}
+
+		/*
+		 * Return a >0 value to callers, to denote that we've reached
+		 * the offlining threshold.
+		 */
+		ret = 1;
+
+		goto unlock;
+	}
+
+	ca->decay_count++;
+
+	/* Do we need to call spring cleaning for the modules(eg CPU) with
+	 * small number of elements?
+	 */
+	if (ca->decay_count >= (num_present_cpus() >> DECAY_BITS))
+		do_spring_cleaning(ca);
+
+	WARN_ON_ONCE(sanity_check(ca));
+
+unlock:
+	spin_unlock_irqrestore(&ca->spin_lock, flags);
+
+	return ret;
+}
+
+static int cec_cpu_stats_show(struct seq_file *seq, void *v)
+{
+	struct ce_array *ca = &cpu_ce_arr;
+	unsigned long flags;
+	int i;
+
+	spin_lock_irqsave(&cpu_ce_arr.spin_lock, flags);
+	seq_puts(seq, "CEC CPU Stats:\n");
+
+	seq_printf(seq, "{ n: %d\n", ca->n);
+	for (i = 0; i < ca->n; i++) {
+		int cpu = ELEM_NO(ca->array[i], ca->id_shift);
+
+	seq_printf(seq, "cpu=%d: %03llx\n",
+		   cpu, ca->array[i]);
+
+	seq_printf(seq, " %3d: [%d|%s|%03lld|%s]\n",
+		   i, cpu, bins[DECAY(ca->array[i])],
+		   COUNT(ca->array[i]),
+		   cpu_online(cpu) ? "online" :
+		   (ca->array[i] & ELEM_STATUS_BIT) ?
+		   "offlined-by-cec" : "offline");
+	}
+
+	seq_printf(seq, "}\n");
+
+	seq_printf(seq, "Stats:\nCEs: %llu\nofflined CPUs: %llu\n",
+		   ca->ces_entered, ca->elems_poisoned);
+
+	seq_printf(seq, "Flags: 0x%x\n", ca->flags);
+
+	seq_printf(seq, "Decay interval: %lld seconds\n", decay_interval);
+	seq_printf(seq, "Decays: %lld\n", ca->decays_done);
+
+	seq_printf(seq, "Action threshold: %lld\n", action_threshold);
+
+	spin_unlock_irqrestore(&cpu_ce_arr.spin_lock, flags);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(cec_cpu_stats);
+
 static int u64_get(void *data, u64 *val)
 {
 	*val = *(u64 *)data;
@@ -514,6 +684,7 @@ static int decay_interval_set(void *data, u64 val)
 	decay_interval = val;
 
 	cec_mod_work(&ce_arr.work, decay_interval);
+	cec_mod_work(&cpu_ce_arr.work, decay_interval/RAS_CEC_NUM_TIME_SLOTS);
 
 	return 0;
 }
@@ -532,8 +703,6 @@ static int action_threshold_set(void *data, u64 val)
 }
 DEFINE_DEBUGFS_ATTRIBUTE(action_threshold_ops, u64_get, action_threshold_set, "%lld\n");
 
-static const char * const bins[] = { "00", "01", "10", "11" };
-
 static int array_dump(struct seq_file *m, void *v)
 {
 	struct ce_array *ca = &ce_arr;
@@ -620,6 +789,14 @@ static int __init create_debugfs_nodes(void)
 	}
 #endif
 
+#if defined(CONFIG_ARM64)
+	array = debugfs_create_file("cpu_stats", 0400, d, NULL, &cec_cpu_stats_fops);
+	if (!array) {
+		pr_warn("Error creating cpu_stats debugfs node!\n");
+		goto err;
+	}
+#endif
+
 	return 0;
 
 err:
@@ -658,21 +835,26 @@ static struct notifier_block cec_nb = {
 
 static void __init cec_init(void)
 {
-	if (ce_arr.disabled)
+	if (ce_arr.disabled && cpu_ce_arr.disabled)
 		return;
 
 #if defined(CONFIG_X86_MCE)
 	ce_arr.array = (void *)get_zeroed_page(GFP_KERNEL);
 	if (!ce_arr.array) {
 		pr_err("Error allocating CE array page!\n");
-		return;
+		goto error;
 	}
 #endif
 
-	if (create_debugfs_nodes()) {
-		free_page((unsigned long)ce_arr.array);
-		return;
-	}
+#if defined(CONFIG_ARM64)
+	cpu_ce_arr.array = kcalloc(num_present_cpus(), sizeof(*(cpu_ce_arr.array)),
+				   GFP_KERNEL);
+	if (!cpu_ce_arr.array)
+		goto error;
+#endif
+
+	if (create_debugfs_nodes())
+		goto error;
 
 #if defined(CONFIG_X86_MCE)
 	ce_arr.id_shift = PAGE_SHIFT;
@@ -682,22 +864,49 @@ static void __init cec_init(void)
 	mce_register_decode_chain(&cec_nb);
 #endif
 
+#if defined(CONFIG_ARM64)
+	cpu_ce_arr.short_period = true;
+	cpu_ce_arr.id_shift = ELEM_ID_SHIFT;
+	spin_lock_init(&cpu_ce_arr.spin_lock);
+	INIT_DELAYED_WORK(&cpu_ce_arr.work, cec_work_fn);
+	schedule_delayed_work(&cpu_ce_arr.work, CEC_DECAY_DEFAULT_INTERVAL/RAS_CEC_NUM_TIME_SLOTS);
+#endif
+
 	pr_info("Correctable Errors collector initialized.\n");
+	return;
+error:
+#if defined(CONFIG_ARM64)
+	kfree(cpu_ce_arr.array);
+#endif
+	if (ce_arr.array)
+		free_page((unsigned long)ce_arr.array);
+
 }
 late_initcall(cec_init);
 
 int __init parse_cec_param(char *str)
 {
+	bool match = false;
+
 	if (!str)
 		return 0;
 
 	if (*str == '=')
 		str++;
 
-	if (!strcmp(str, "cec_disable"))
+	if (!strcmp(str, "cec_disable")) {
 		ce_arr.disabled = 1;
+		match = true;
+	}
+
+	if (!strcmp(str, "cec_cpu_disable")) {
+		cpu_ce_arr.disabled = 1;
+		match = true;
+	}
+
+	if (match)
+		return 1;
 	else
 		return 0;
 
-	return 1;
 }
diff --git a/include/linux/ras.h b/include/linux/ras.h
index 1f4048bf2674..43d91298f1e3 100644
--- a/include/linux/ras.h
+++ b/include/linux/ras.h
@@ -18,6 +18,15 @@ static inline int ras_add_daemon_trace(void) { return 0; }
 
 #ifdef CONFIG_RAS_CEC
 int __init parse_cec_param(char *str);
+/**
+ * cec_cpu_add_elem - add the count of CPU correctable errors to the
+ * CEC(correctable errors collector).
+ * @cpu: CPU index.
+ * @ce_count: CPU correctable errors count.
+ */
+int cec_cpu_add_elem(int cpu, u64 ce_count);
+#else
+static inline int cec_cpu_add_elem(int cpu, u64 ce_count) { return -ENODEV; }
 #endif
 
 #ifdef CONFIG_RAS
-- 
2.17.1


