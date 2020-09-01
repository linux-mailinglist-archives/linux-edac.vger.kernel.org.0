Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A09025907D
	for <lists+linux-edac@lfdr.de>; Tue,  1 Sep 2020 16:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgIAOXx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 1 Sep 2020 10:23:53 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2727 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728386AbgIAOXd (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 1 Sep 2020 10:23:33 -0400
Received: from lhreml715-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 708B3A8D11F1BDFF4249;
        Tue,  1 Sep 2020 15:05:20 +0100 (IST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.85.84) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 1 Sep 2020 15:05:19 +0100
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <tony.luck@intel.com>, <rjw@rjwysocki.net>, <james.morse@arm.com>,
        <lenb@kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH 1/1] RAS: Add CPU Correctable Error Collector to isolate an erroneous CPU core
Date:   Tue, 1 Sep 2020 15:01:40 +0100
Message-ID: <20200901140140.1772-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.47.85.84]
X-ClientProxiedBy: lhreml727-chm.china.huawei.com (10.201.108.78) To
 lhreml715-chm.china.huawei.com (10.201.108.66)
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

When the CPU correctable errors reported on an ARM64 CPU core too often,
it should be isolated. Add the CPU correctable error collector to
store the CPU correctable error count.

When the correctable error count for a CPU exceed the threshold
value in a short time period, it will try to isolate the CPU core.
The threshold value, time period etc are configurable.

Implementation details is added in the file.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 Documentation/ABI/testing/debugfs-cpu-cec |  22 ++
 arch/arm64/ras/Kconfig                    |   8 +
 drivers/acpi/apei/ghes.c                  |  30 +-
 drivers/ras/Kconfig                       |   1 +
 drivers/ras/Makefile                      |   1 +
 drivers/ras/cpu_cec.c                     | 393 ++++++++++++++++++++++
 drivers/ras/ras.c                         |   3 +
 include/linux/ras.h                       |  16 +
 8 files changed, 471 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-cpu-cec
 create mode 100644 arch/arm64/ras/Kconfig
 create mode 100644 drivers/ras/cpu_cec.c

diff --git a/Documentation/ABI/testing/debugfs-cpu-cec b/Documentation/ABI/testing/debugfs-cpu-cec
new file mode 100644
index 000000000000..31f4e8c902e4
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-cpu-cec
@@ -0,0 +1,22 @@
+What:           /sys/kernel/debug/ras/cpu_cec/threshold
+Date:           Aug 2020
+Contact:        linux-edac@vger.kernel.org
+Description:    Threshold value for the CPU corrected errors to
+		offline a CPU core. Default value is 5000.
+
+What:           /sys/kernel/debug/ras/cpu_cec/disable
+Date:           Aug 2020
+Contact:        linux-edac@vger.kernel.org
+Description:    Disable the RAS CPU corrected errors collector.
+		1:disable, 0:enable. Enabled by default.
+
+What:           /sys/kernel/debug/ras/cpu_cec/stats
+Date:           Aug 2020
+Contact:        linux-edac@vger.kernel.org
+Description:    Dump the stats of the CPU correctable errors.
+
+What:           /sys/kernel/debug/ras/cpu_cec/time_period
+Date:           Aug 2020
+Contact:        linux-edac@vger.kernel.org
+Description:    Time period, in seconds, for the CPU CEs count
+		threshold check. Default value is 24hrs.
diff --git a/arch/arm64/ras/Kconfig b/arch/arm64/ras/Kconfig
new file mode 100644
index 000000000000..a892245193f0
--- /dev/null
+++ b/arch/arm64/ras/Kconfig
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+config RAS_CPU_CEC
+	bool "RAS CPU Correctable Error Collector"
+	depends on ARM64 && HOTPLUG_CPU && DEBUG_FS
+	help
+	  Collects the CPU correctable errors. When the CEs count for
+	  a CPU exceeds the threshold, try to isolate the CPU core.
+
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 81bf71b10d44..b6ff4866ca32 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -511,6 +511,32 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 #endif
 }
 
+static void ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata)
+{
+	struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
+	struct cper_arm_err_info *err_info;
+	int sec_sev;
+	int cpu, i, ret;
+
+	log_arm_hw_error(err);
+
+	sec_sev = ghes_severity(gdata->error_severity);
+	if (sec_sev != GHES_SEV_CORRECTED)
+		return;
+
+	cpu = get_logical_index(err->mpidr);
+	if (cpu == -EINVAL)
+		return;
+
+	err_info = (struct cper_arm_err_info *)(err + 1);
+	for (i = 0; i < err->err_info_num; i++) {
+		ret = cpu_cec_add_ce(cpu, err_info->multiple_error + 1);
+		if (ret)
+			break;
+		err_info += 1;
+	}
+}
+
 static bool ghes_do_proc(struct ghes *ghes,
 			 const struct acpi_hest_generic_status *estatus)
 {
@@ -543,9 +569,7 @@ static bool ghes_do_proc(struct ghes *ghes,
 			ghes_handle_aer(gdata);
 		}
 		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
-			struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
-
-			log_arm_hw_error(err);
+			ghes_handle_arm_hw_error(gdata);
 		} else {
 			void *err = acpi_hest_get_payload(gdata);
 
diff --git a/drivers/ras/Kconfig b/drivers/ras/Kconfig
index c2a236f2e846..d2f877e5f7ad 100644
--- a/drivers/ras/Kconfig
+++ b/drivers/ras/Kconfig
@@ -32,5 +32,6 @@ menuconfig RAS
 if RAS
 
 source "arch/x86/ras/Kconfig"
+source "arch/arm64/ras/Kconfig"
 
 endif
diff --git a/drivers/ras/Makefile b/drivers/ras/Makefile
index 6f0404f50107..d6e8c38be3cb 100644
--- a/drivers/ras/Makefile
+++ b/drivers/ras/Makefile
@@ -2,3 +2,4 @@
 obj-$(CONFIG_RAS)	+= ras.o
 obj-$(CONFIG_DEBUG_FS)	+= debugfs.o
 obj-$(CONFIG_RAS_CEC)	+= cec.o
+obj-$(CONFIG_RAS_CPU_CEC)	+= cpu_cec.o
diff --git a/drivers/ras/cpu_cec.c b/drivers/ras/cpu_cec.c
new file mode 100644
index 000000000000..7c4a566d7b30
--- /dev/null
+++ b/drivers/ras/cpu_cec.c
@@ -0,0 +1,393 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020 HiSilicon Limited.
+ */
+#include <linux/ras.h>
+#include <linux/workqueue.h>
+#include <linux/cpu.h>
+#include <linux/slab.h>
+#include <linux/ratelimit.h>
+
+#include "debugfs.h"
+
+/*
+ * RAS CPU correctable error collector.
+ *
+ * Collects the count of CPU correctable errors.
+ *
+ * We need to isolate a CPU core when large number of correctable errors
+ * are reported on that CPU core too often. This is done by calling remove_cpu()
+ * when the CEs count is exceeded the threshold value in a short time period.
+ *
+ * The ce collector maintains the sliding time window with equal time slots and
+ * the ce counts corresponding to each time slot are stored in a circular buffer.
+ * A periodically scheduled work function advances the circular buffer for the
+ * time slots and the period of this work function is total time period/ number
+ * of time slots. When the new ce count for a cpu is added, the sum of the most
+ * recent ce counts stored in the buffer would be checked whether it exceeded the
+ * ce threshold value, if so, a flag would be set to offline the cpu, kick a
+ * dedicated work function and the cpu would be offlined by that work function.
+ *
+ * The CE count threshold value and time period are configurable through the
+ * cpu_cec interface provided in the RAS debugfs.
+ *
+ * CPU CEC interface in the /sys/kernel/debug/ras/cpu_cec/
+ * @disable: Disable the CPU CE collector.
+ * @time_period: Time period, in seconds, for the CPU CE count threshold check.
+ * @threshold: Threshold value for the CPU CEs to offline the CPU core.
+ * @stats: Statistics of the CPU correctable errors.
+ */
+
+#undef pr_fmt
+#define pr_fmt(fmt) "RAS: " fmt
+
+/* Time period for the CPU CEs count threshold check, is 24hrs by default. */
+#define RAS_CPU_CEC_DEFAULT_TIME_PERIOD	(24 * 60 * 60)	/* 24 hrs */
+#define RAS_CPU_CEC_MIN_TIME_PERIOD	(1 * 60 * 60)	/* 1h */
+#define RAS_CPU_CEC_MAX_TIME_PERIOD	(30 * 24 * 60 * 60)	/* one month */
+
+/* Threshold value of the CPU corrected errors for isolating the CPU. */
+#define RAS_CPU_CE_THRESHOLD	5000
+#define RAS_CPU_CE_MIN_THRESHOLD	200
+#define RAS_CPU_CE_MAX_THRESHOLD	100000
+
+/* Flags indicates a cpu core to offline and has been offlined
+ * due to the cpu CEs exceed threshold.
+ */
+#define RAS_CEC_OFFLINE_CPU	BIT(0)
+#define RAS_CEC_CPU_OFFLINED	BIT(1)
+
+/* sub divisions of the sliding time window */
+#define RAS_CPU_CEC_NUM_TIME_SLOTS	10
+
+/**
+ * cpu_cec_list - Per CPU corrected error collector storage
+ * @work:	work structure to offline the cpu.
+ * @ces_count:	total number of correctable errors collected.
+ * @flag:	CEC flag.
+ * @buf_ce_count:	buffer to store the most recent ce counts in each
+ *			time slots of the sliding time window.
+ * @buf_index:	buffer index corresponding to the current time slot.
+ * @cpu:	cpu logical index.
+ */
+static struct cpu_cec_list {
+	struct work_struct work;
+	u64 ces_count;
+	u64 flag;
+	u64 buf_ce_count[RAS_CPU_CEC_NUM_TIME_SLOTS];
+	u32 buf_index;
+	u32 cpu;
+} *cpu_cec_list;
+
+static DEFINE_SPINLOCK(cpu_cec_lock);
+
+/* Disable the CPU correctable error collector, enabled by default */
+static u64 cpu_cec_disable;
+
+/* Number of errors after which we offline the CPU. */
+static u64 cpu_ce_threshold = RAS_CPU_CE_THRESHOLD;
+
+/* Time period for the CPU CE count threshold check. */
+static u64 cpu_cec_time_period = RAS_CPU_CEC_DEFAULT_TIME_PERIOD;
+
+static struct delayed_work cpu_cec_work;
+
+/*
+ * cpu_cec_mod_work: modify delay of the delayed cpu_cec_work.
+ * delay = time period / number of time slots.
+ * @time_period: time period in seconds.
+ */
+static void cpu_cec_mod_work(unsigned long time_period)
+{
+	unsigned long delay;
+
+	if (cpu_cec_disable)
+		return;
+
+	delay = (time_period / RAS_CPU_CEC_NUM_TIME_SLOTS) * HZ;
+	mod_delayed_work(system_wq, &cpu_cec_work, round_jiffies(delay));
+}
+
+static void cpu_cec_work_fn(struct work_struct *work)
+{
+	int cpu;
+	unsigned long flags;
+	struct cpu_cec_list *cpu_cec;
+
+	if (cpu_cec_disable)
+		return;
+
+	for_each_present_cpu(cpu) {
+		cpu_cec = &cpu_cec_list[cpu];
+		/* continue update buf index and clear corresponding ce count here for all
+		 * the cpus present because a cpu could be offlined elsewhere and back online soon.
+		 */
+		spin_lock_irqsave(&cpu_cec_lock, flags);
+		cpu_cec->buf_index = (cpu_cec->buf_index + 1) % RAS_CPU_CEC_NUM_TIME_SLOTS;
+		cpu_cec->buf_ce_count[cpu_cec->buf_index] = 0;
+		spin_unlock_irqrestore(&cpu_cec_lock, flags);
+	}
+
+	cpu_cec_mod_work(cpu_cec_time_period);
+}
+
+/*
+ * Work function to offline a cpu because the offlining to be done
+ * in the process context.
+ */
+static void cpu_cec_offline_work_fn(struct work_struct *work)
+{
+	int rc, i;
+	unsigned long flags;
+	struct cpu_cec_list *cpu_cec;
+
+	if (cpu_cec_disable)
+		return;
+
+	cpu_cec = container_of(work, struct cpu_cec_list, work);
+	if (!(cpu_cec->flag & RAS_CEC_OFFLINE_CPU))
+		return;
+
+	rc = remove_cpu(cpu_cec->cpu);
+	if (!rc) {
+		spin_lock_irqsave(&cpu_cec_lock, flags);
+		cpu_cec->buf_index = 0;
+		for (i = 0; i < RAS_CPU_CEC_NUM_TIME_SLOTS; i++)
+			cpu_cec->buf_ce_count[i] = 0;
+		cpu_cec->flag &= ~RAS_CEC_OFFLINE_CPU;
+		cpu_cec->flag |= RAS_CEC_CPU_OFFLINED;
+		spin_unlock_irqrestore(&cpu_cec_lock, flags);
+	} else
+		pr_warn_ratelimited("Failed to offline CPU%d, error %d\n", cpu_cec->cpu, rc);
+}
+
+static void cpu_cec_check_threshold(int cpu)
+{
+	int i;
+	u64 sum_ce_counts = 0;
+	struct cpu_cec_list *cpu_cec;
+
+	cpu_cec = &cpu_cec_list[cpu];
+	for (i = 0; i < RAS_CPU_CEC_NUM_TIME_SLOTS; i++)
+		sum_ce_counts += cpu_cec->buf_ce_count[i];
+
+	if (sum_ce_counts >= cpu_ce_threshold) {
+		cpu_cec->flag |= RAS_CEC_OFFLINE_CPU;
+		cpu_cec->cpu = cpu;
+
+		/* kick the work function to offline the cpu */
+		schedule_work(&cpu_cec->work);
+	}
+}
+
+/*
+ * cpu_cec_add_ce: add CPU correctable error count to the CPU
+ * correctable error collector.
+ * @cpu: CPU index.
+ * @ce_count: CPU correctable error count.
+ */
+int cpu_cec_add_ce(int cpu, u64 ce_count)
+{
+	unsigned long flags;
+	struct cpu_cec_list *cpu_cec;
+
+	if (!cpu_cec_list || !cpu_online(cpu) || cpu_cec_disable)
+		return -ENODEV;
+
+	cpu_cec = &cpu_cec_list[cpu];
+	if (cpu_cec->flag & RAS_CEC_OFFLINE_CPU)
+		return 0;
+
+	/* reset the flag and ce counts for an offlined cpu, which is online now */
+	if (cpu_cec->flag & RAS_CEC_CPU_OFFLINED) {
+		cpu_cec->ces_count = 0;
+		cpu_cec->flag = 0;
+	}
+
+	spin_lock_irqsave(&cpu_cec_lock, flags);
+	cpu_cec->ces_count += ce_count;
+	cpu_cec->buf_ce_count[cpu_cec->buf_index] += ce_count;
+	spin_unlock_irqrestore(&cpu_cec_lock, flags);
+	cpu_cec_check_threshold(cpu);
+
+	return 0;
+}
+
+static int u64_get(void *data, u64 *val)
+{
+	*val = *(u64 *)data;
+
+	return 0;
+}
+
+static int cpu_cec_disable_set(void *data, u64 val)
+{
+	int cpu, i;
+	unsigned long flags;
+	struct cpu_cec_list *cpu_cec;
+
+	if (val < 0 || val > 1)
+		return -EINVAL;
+
+	if (cpu_cec_disable == val)
+		return 0;
+
+	*(u64 *)data = val;
+
+	spin_lock_irqsave(&cpu_cec_lock, flags);
+	for_each_present_cpu(cpu) {
+		cpu_cec = &cpu_cec_list[cpu];
+		cpu_cec->ces_count = 0;
+		cpu_cec->buf_index = 0;
+		cpu_cec->flag = 0;
+		for (i = 0; i < RAS_CPU_CEC_NUM_TIME_SLOTS; i++)
+			cpu_cec->buf_ce_count[i] = 0;
+	}
+	spin_unlock_irqrestore(&cpu_cec_lock, flags);
+	cpu_cec_mod_work(cpu_cec_time_period);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(cpu_cec_disable_ops, u64_get,
+			 cpu_cec_disable_set, "%lld\n");
+
+static int cpu_cec_time_period_set(void *data, u64 val)
+{
+	if (val < RAS_CPU_CEC_MIN_TIME_PERIOD || val > RAS_CPU_CEC_MAX_TIME_PERIOD)
+		return -EINVAL;
+
+	*(u64 *)data   = val;
+
+	cpu_cec_mod_work(cpu_cec_time_period);
+
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(cpu_cec_time_period_ops, u64_get,
+			 cpu_cec_time_period_set, "%lld\n");
+
+static int cpu_ce_threshold_set(void *data, u64 val)
+{
+	*(u64 *)data = clamp_val(val, RAS_CPU_CE_MIN_THRESHOLD, RAS_CPU_CE_MAX_THRESHOLD);
+
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(cpu_ce_threshold_ops, u64_get,
+			 cpu_ce_threshold_set, "%lld\n");
+
+static int cpu_cec_stats_show(struct seq_file *seq, void *v)
+{
+	int cpu;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cpu_cec_lock, flags);
+	seq_puts(seq, "CPU CEC Stats:\n");
+
+	for_each_present_cpu(cpu)
+		seq_printf(seq, " [cpu%d | ce_count = %08lld | %s]\n", cpu,
+			   cpu_cec_list[cpu].ces_count, cpu_online(cpu) ? "online" :
+			   (cpu_cec_list[cpu].flag & RAS_CEC_CPU_OFFLINED) ?
+			   "offlined-by-cec" : "offline");
+
+	seq_printf(seq, "Time period: %lld seconds\n", cpu_cec_time_period);
+	seq_printf(seq, "Threshold: %lld\n", cpu_ce_threshold);
+	spin_unlock_irqrestore(&cpu_cec_lock, flags);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(cpu_cec_stats);
+
+static int __init create_debugfs_cpu_cec_nodes(void)
+{
+	struct dentry *dir, *off, *tp, *threshold, *stats;
+	int err;
+
+	dir = debugfs_create_dir("cpu_cec", ras_debugfs_dir);
+	if (IS_ERR_OR_NULL(dir)) {
+		err = dir ? PTR_ERR(dir) : -ENODEV;
+		pr_warn("Error creating RAS CPU CEC debugfs node, error %d\n", err);
+		return err;
+	}
+
+	off = debugfs_create_file("disable", 0600, dir, &cpu_cec_disable,
+				   &cpu_cec_disable_ops);
+	if (!off) {
+		pr_warn("Error creating cpu_cec_disable debugfs node.\n");
+		goto error;
+	}
+
+	tp = debugfs_create_file("time_period", 0600, dir, &cpu_cec_time_period,
+				 &cpu_cec_time_period_ops);
+	if (!tp) {
+		pr_warn("Error creating cpu_ce_time_period debugfs node.\n");
+		goto error;
+	}
+
+	threshold = debugfs_create_file("threshold",
+					0600, dir,
+					&cpu_ce_threshold,
+					&cpu_ce_threshold_ops);
+	if (!threshold) {
+		pr_warn("Error creating cpu_ce_threshold debugfs node.\n");
+		goto error;
+	}
+
+	stats = debugfs_create_file("stats", 0400, dir,
+				    NULL, &cpu_cec_stats_fops);
+	if (!stats) {
+		pr_warn("Error creating cpu cec stats debugfs node.\n");
+		goto error;
+	}
+
+	return 0;
+
+error:
+	debugfs_remove_recursive(dir);
+
+	return -ENODEV;
+}
+
+static int __init cpu_cec_init(void)
+{
+	int cpu;
+	int num_cpus = num_present_cpus();
+	unsigned long delay = (RAS_CPU_CEC_DEFAULT_TIME_PERIOD / RAS_CPU_CEC_NUM_TIME_SLOTS) * HZ;
+
+	cpu_cec_list = kcalloc(num_cpus, sizeof(*cpu_cec_list), GFP_KERNEL);
+	if (!cpu_cec_list) {
+		cpu_cec_disable = 1;
+		return -ENOMEM;
+	}
+
+	if (create_debugfs_cpu_cec_nodes()) {
+		kfree(cpu_cec_list);
+		cpu_cec_list = NULL;
+		return -ENODEV;
+	}
+
+	for_each_present_cpu(cpu)
+		INIT_WORK(&cpu_cec_list[cpu].work, cpu_cec_offline_work_fn);
+
+	INIT_DELAYED_WORK(&cpu_cec_work, cpu_cec_work_fn);
+	schedule_delayed_work(&cpu_cec_work, round_jiffies(delay));
+
+	return 0;
+}
+late_initcall(cpu_cec_init);
+
+int __init parse_cpu_cec_param(char *str)
+{
+	if (!str)
+		return 0;
+
+	if (*str == '=')
+		str++;
+
+	if (!strcmp(str, "cpu_cec_disable")) {
+		cpu_cec_disable = 1;
+		return 1;
+	} else {
+		return 0;
+	}
+}
+
diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
index 95540ea8dd9d..747bc6833b6b 100644
--- a/drivers/ras/ras.c
+++ b/drivers/ras/ras.c
@@ -49,6 +49,9 @@ static int __init parse_ras_param(char *str)
 #ifdef CONFIG_RAS_CEC
 	parse_cec_param(str);
 #endif
+#ifdef CONFIG_RAS_CPU_CEC
+	parse_cpu_cec_param(str);
+#endif
 
 	return 1;
 }
diff --git a/include/linux/ras.h b/include/linux/ras.h
index 1f4048bf2674..6d74ffe6d5aa 100644
--- a/include/linux/ras.h
+++ b/include/linux/ras.h
@@ -20,6 +20,10 @@ static inline int ras_add_daemon_trace(void) { return 0; }
 int __init parse_cec_param(char *str);
 #endif
 
+#ifdef CONFIG_RAS_CPU_CEC
+int __init parse_cpu_cec_param(char *str);
+#endif
+
 #ifdef CONFIG_RAS
 void log_non_standard_event(const guid_t *sec_type,
 			    const guid_t *fru_id, const char *fru_text,
@@ -35,4 +39,16 @@ static inline void
 log_arm_hw_error(struct cper_sec_proc_arm *err) { return; }
 #endif
 
+#ifdef CONFIG_RAS_CPU_CEC
+/**
+ * cpu_cec_add_ce - add the count of CPU correctable errors to the
+ * CPU correctable errors collector.
+ * @cpu: CPU index.
+ * @ce_count: CPU correctable errors count.
+ */
+int cpu_cec_add_ce(int cpu, u64 ce_count);
+#else
+static inline int cpu_cec_add_ce(int cpu, u64 ce_count) { return -ENODEV; }
+#endif
+
 #endif /* __RAS_H__ */
-- 
2.17.1


