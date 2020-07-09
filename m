Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88651219AC9
	for <lists+linux-edac@lfdr.de>; Thu,  9 Jul 2020 10:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgGII2k (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 9 Jul 2020 04:28:40 -0400
Received: from inva020.nxp.com ([92.121.34.13]:38046 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbgGII2j (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 9 Jul 2020 04:28:39 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E0A7D1A10FE;
        Thu,  9 Jul 2020 10:28:33 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 165B21A1111;
        Thu,  9 Jul 2020 10:28:30 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 4F628402D3;
        Thu,  9 Jul 2020 16:28:25 +0800 (SGT)
From:   Alison Wang <alison.wang@nxp.com>
To:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rrichter@marvell.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alison Wang <alison.wang@nxp.com>
Subject: [PATCH] edac: nxp: Add L1 and L2 error detection for A53 and A72 cores
Date:   Thu,  9 Jul 2020 16:22:15 +0800
Message-Id: <20200709082215.12829-1-alison.wang@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add error detection for A53 and A72 cores. Hardware error injection is
supported on A53. Software error injection is supported on both.
For hardware error injection on A53 to work, proper access to
L2ACTLR_EL1, CPUACTLR_EL1 needs to be granted by EL3 firmware. This is
done by making an SMC call in the driver. Failure to enable access
disables hardware error injection. For error detection to work, another
SMC call enables access to L2ECTLR_EL1.

It is for NXP's Layerscape family LS1043A, LS1046A, LS2088A and LX2160A.

Signed-off-by: York Sun <york.sun@nxp.com>
Signed-off-by: Alison Wang <alison.wang@nxp.com>
---
 .../bindings/edac/cortex-arm64-edac.txt       |  40 +
 drivers/edac/Kconfig                          |   7 +
 drivers/edac/Makefile                         |   1 +
 drivers/edac/cortex_arm64_l1_l2.c             | 738 ++++++++++++++++++
 drivers/edac/cortex_arm64_l1_l2.h             |  54 ++
 5 files changed, 840 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/cortex-arm64-edac.txt
 create mode 100644 drivers/edac/cortex_arm64_l1_l2.c
 create mode 100644 drivers/edac/cortex_arm64_l1_l2.h

diff --git a/Documentation/devicetree/bindings/edac/cortex-arm64-edac.txt b/Documentation/devicetree/bindings/edac/cortex-arm64-edac.txt
new file mode 100644
index 000000000000..41c840993814
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/cortex-arm64-edac.txt
@@ -0,0 +1,40 @@
+ARM Cortex A53 and A72 L1/L2 cache error reporting
+
+CPU Memory Error Syndrome and L2 Memory Error Syndrome registers can be
+used for checking L1 and L2 memory errors. However, only A53 supports
+double-bit error injection to L1 and L2 memory. This driver uses the
+hardware error injection when available, but also provides a way to
+inject errors by software.
+
+To use hardware error injection and the interrupt, proper access needs
+to be granted in ACTLR_EL3 (and/or ACTLR_EL2) register by EL3 firmware SMC call.
+
+Correctable errors do not trigger such interrupt. This driver uses
+dynamic polling internal to check for errors. The more errors detected,
+the more frequently it polls. Combining with interrupt, this driver can
+detect correctable and uncorrectable errors. However, if the
+uncorrectable errors cause system abort exception, this driver is not able to
+report errors in time.
+
+The SIP-specific SMC calls are only for NXP's Layerscape family LS1043A,
+LS1046A, LS2088A and LX2160A.
+
+The following section describes the Cortex A53/A72 EDAC DT node binding.
+
+Required properties:
+- compatible: Should be "arm,cortex-a53-edac" or "arm,cortex-a72-edac"
+- cpus: Should be a list of compatible cores
+
+Optional properties:
+- interrupts: Interrupt number if supported
+
+Example:
+	edac {
+		compatible = "arm,cortex-a53-edac";
+		cpus = <&cpu0>,
+		       <&cpu1>,
+		       <&cpu2>,
+		       <&cpu3>;
+		interrupts = <0 108 0x4>;
+
+	};
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 7b6ec3014ba2..6317cebf0a95 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -530,4 +530,11 @@ config EDAC_DMC520
 	  Support for error detection and correction on the
 	  SoCs with ARM DMC-520 DRAM controller.
 
+config EDAC_CORTEX_ARM64_L1_L2
+	tristate "ARM Cortex A53/A72"
+	depends on ARM64 && ARCH_LAYERSCAPE
+	help
+	  Support for error detection on ARM Cortex A53 and A72 with Layerscape
+	  SoC family LS1043A, LS1046A, LS2088A and LX2160A.
+
 endif # EDAC
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 269e15118cea..3edba6bea350 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -88,3 +88,4 @@ obj-$(CONFIG_EDAC_QCOM)			+= qcom_edac.o
 obj-$(CONFIG_EDAC_ASPEED)		+= aspeed_edac.o
 obj-$(CONFIG_EDAC_BLUEFIELD)		+= bluefield_edac.o
 obj-$(CONFIG_EDAC_DMC520)		+= dmc520_edac.o
+obj-$(CONFIG_EDAC_CORTEX_ARM64_L1_L2)	+= cortex_arm64_l1_l2.o
diff --git a/drivers/edac/cortex_arm64_l1_l2.c b/drivers/edac/cortex_arm64_l1_l2.c
new file mode 100644
index 000000000000..0443384bd656
--- /dev/null
+++ b/drivers/edac/cortex_arm64_l1_l2.c
@@ -0,0 +1,738 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cortex A53 and A72 EDAC L1 and L2 cache error detection
+ *
+ * Copyright 2018-2020 NXP
+ * Author: York Sun <york.sun@nxp.com>
+ *
+ * Partially take from a similar driver by
+ * Brijesh Singh <brijeshkumar.singh@amd.com>
+ * Copyright (c) 2015, Advanced Micro Devices
+ */
+
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/of_device.h>
+#include <linux/arm-smccc.h>
+#include <asm/barrier.h>
+#include <asm/cacheflush.h>
+#include <asm/smp_plat.h>
+
+#include "edac_module.h"
+#include "cortex_arm64_l1_l2.h"
+
+static int poll_msec = 1024;
+static long l1_ce_sw_inject_count, l1_ue_sw_inject_count;
+static long l2_ce_sw_inject_count, l2_ue_sw_inject_count;
+static struct cpumask compat_mask;
+static struct cpumask l1_ce_cpu_mask, l1_ue_cpu_mask;
+static struct cpumask l2_ce_cpu_mask, l2_ue_cpu_mask;
+static DEFINE_PER_CPU(unsigned long, actlr_en);
+static DEFINE_PER_CPU(unsigned long, l2ectlr_en);
+static DEFINE_PER_CPU(u64, cpumerr);
+static DEFINE_PER_CPU(u64, cpuactlr);
+static DEFINE_PER_CPU(u64, l2actlr);
+static DEFINE_PER_CPU(u64, l2merr);
+static DEFINE_PER_CPU(call_single_data_t, csd_check);
+static DEFINE_SPINLOCK(cortex_edac_lock);
+
+static inline void read_cpuactlr(void *info)
+{
+	u64 val;
+	int cpu = smp_processor_id();
+
+	asm volatile("mrs %0, S3_1_C15_C2_0" : "=r" (val));
+	per_cpu(cpuactlr, cpu) = val;
+}
+
+static inline void write_cpuactlr(int *mem)
+{
+	u64 val;
+	int cpu;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cortex_edac_lock, flags);
+	cpu = smp_processor_id();
+
+	__flush_dcache_area(mem, 8);
+	asm volatile("mrs %0, S3_1_C15_C2_0" : "=r" (val));
+	val |= L1_ERR_INJ_EN;
+	asm volatile("dsb sy");
+	asm volatile("msr S3_1_C15_C2_0, %0" :: "r" (val));
+	asm volatile("isb sy");
+	/* make cache dirty */
+	*mem = 0xDEADBEEF;	/* write to L1 data causes error right away */
+	__flush_dcache_area(mem, 8);
+	val &= ~L1_ERR_INJ_EN;
+	asm volatile("dsb sy");
+	asm volatile("msr S3_1_C15_C2_0, %0" :: "r" (val));
+	asm volatile("isb sy");
+	spin_unlock_irqrestore(&cortex_edac_lock, flags);
+}
+
+static inline void read_l2actlr(void *info)
+{
+	u64 val;
+	int cpu = smp_processor_id();
+
+	asm volatile("mrs %0, S3_1_C15_C0_0" : "=r" (val));
+	per_cpu(l2actlr, cpu) = val;
+}
+
+static inline void write_l2actlr(int *mem)
+{
+	u64 val;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cortex_edac_lock, flags);
+	__flush_dcache_area(mem, 8);
+	asm volatile("mrs %0, S3_1_C15_C0_0" : "=r" (val));
+	val |= L2D_ERR_INJ_EN;
+	asm volatile("dsb sy");
+	asm volatile("msr S3_1_C15_C0_0, %0" :: "r" (val));
+	asm volatile("isb sy");
+	/* make cache dirty */
+	*mem = 0xDEADBEEF;	/* Error will be reported when L2 is accessed. */
+	__flush_dcache_area(mem, 8);
+	val &= ~L2D_ERR_INJ_EN;
+	asm volatile("dsb sy");
+	asm volatile("msr S3_1_C15_C0_0, %0" :: "r" (val));
+	asm volatile("isb sy");
+	spin_unlock_irqrestore(&cortex_edac_lock, flags);
+}
+
+static inline void write_l2ectlr_el1(void *info)
+{
+	u64 val;
+	int cpu = smp_processor_id();
+
+	asm volatile("mrs %0, S3_1_C11_C0_3" : "=r" (val));
+	if (val & L2_ERR_INT) {
+		pr_debug("l2ectlr_el1 on cpu %d reads 0x%llx\n", cpu, val);
+		val &= ~L2_ERR_INT;
+		asm volatile("msr S3_1_C11_C0_3, %0" :: "r" (val));
+	}
+}
+
+static inline void write_cpumerrsr_el1(u64 val)
+{
+	asm volatile("msr s3_1_c15_c2_2, %0" :: "r" (val));
+}
+
+static void a53_allow_l1l2_err_inj(void *info)
+{
+	int cpu = smp_processor_id();
+	struct arm_smccc_res res;
+	unsigned long flags;
+
+	pr_debug("%s: cpu is %d\n", __func__, cpu);
+	spin_lock_irqsave(&cortex_edac_lock, flags);
+	arm_smccc_smc(NXP_SIP_SVC_ALLOW_L1L2_ERR, 0, 0, 0, 0, 0, 0, 0, &res);
+	per_cpu(actlr_en, cpu) = res.a0;
+	spin_unlock_irqrestore(&cortex_edac_lock, flags);
+	pr_debug("%s: return is %ld\n", __func__, res.a0);
+}
+
+static void a53_allow_l1l2_err_irq_clr(void *info)
+{
+	int cpu = smp_processor_id();
+	struct arm_smccc_res res;
+	unsigned long flags;
+
+	pr_debug("%s: cpu is %d\n", __func__, cpu);
+	spin_lock_irqsave(&cortex_edac_lock, flags);
+	arm_smccc_smc(NXP_SIP_SVC_ALLOW_L2_CLR, 0, 0, 0, 0, 0, 0, 0, &res);
+	per_cpu(l2ectlr_en, cpu) = res.a0;
+	spin_unlock_irqrestore(&cortex_edac_lock, flags);
+	pr_debug("%s: return is %ld\n", __func__, res.a0);
+}
+
+static inline void read_cpumerrsr_el1(void *info)
+{
+	u64 val;
+	int cpu = smp_processor_id();
+
+	asm volatile("mrs %0, s3_1_c15_c2_2" : "=r" (val));
+	per_cpu(cpumerr, cpu) = val;
+	if (val & ~CPUMERRSR_RAMID_MASK) {	/* Skip RAMID */
+		pr_debug("cpu %d reads cpumerrsr_el1 0x%llx\n", cpu, val);
+		/* clear the register since we already stored it */
+		write_cpumerrsr_el1(0);
+	} else if (l1_ce_sw_inject_count > 0) {
+		l1_ce_sw_inject_count--;
+		pr_debug("inject correctable errors to cpu %d\n", cpu);
+		per_cpu(cpumerr, cpu) = (1UL << 31);	/* valid bit */
+	} else if (l1_ue_sw_inject_count > 0) {
+		l1_ue_sw_inject_count--;
+		pr_debug("inject Uncorrectable errors to cpu %d\n", cpu);
+		per_cpu(cpumerr, cpu) = (1UL << 63) | (1UL << 31);
+	}
+}
+
+static inline void write_l2merrsr_el1(u64 val)
+{
+	asm volatile("msr s3_1_c15_c2_3, %0" :: "r" (val));
+}
+
+static inline void read_l2merrsr_el1(void *info)
+{
+	u64 val;
+	int cpu = smp_processor_id();
+
+	asm volatile("mrs %0, s3_1_c15_c2_3" : "=r" (val));
+	per_cpu(l2merr, cpu) = val;
+	if (val & ~L2MERRSR_RAMID_MASK) {	/* Skip RAMID */
+		pr_debug("cpu %d reads l2merrsr_el1 0x%llx\n", cpu, val);
+		/* clear the register since we already stored it */
+		write_l2merrsr_el1(0);
+	} else if (l2_ce_sw_inject_count > 0) {
+		l2_ce_sw_inject_count--;
+		pr_debug("inject correctable errors to L2 on cpu %d\n", cpu);
+		per_cpu(l2merr, cpu) = (1UL << 31);	/* valid bit */
+	} else if (l2_ue_sw_inject_count > 0) {
+		l2_ue_sw_inject_count--;
+		pr_debug("inject Uncorrectable errors to L2 on cpu %d\n", cpu);
+		per_cpu(l2merr, cpu) = (1UL << 63) | (1UL << 31);
+	}
+}
+
+static void read_errors(void *info)
+{
+	read_cpumerrsr_el1(info);
+	read_l2merrsr_el1(info);
+	write_l2ectlr_el1(info);
+}
+
+/* Returns 0 for no error
+ *	  -1 for uncorrectable error(s)
+ *	   1 for correctable error(s)
+ */
+static int parse_cpumerrsr(unsigned int cpu)
+{
+	u64 val = per_cpu(cpumerr, cpu);
+
+	/* check if we have valid error before continuing */
+	if (!CPUMERRSR_EL1_VALID(val))
+		return 0;
+
+	cortex_printk(KERN_INFO, "CPU %d ", cpu);
+
+	switch (CPUMERRSR_EL1_RAMID(val)) {
+	case L1_I_TAG_RAM:
+		pr_cont("L1-I Tag RAM");
+		break;
+	case L1_I_DATA_RAM:
+		pr_cont("L1-I Data RAM");
+		break;
+	case L1_D_TAG_RAM:
+		pr_cont("L1-D Tag RAM");
+		break;
+	case L1_D_DATA_RAM:
+		pr_cont("L1-D Data RAM");
+		break;
+	case L1_D_DIRTY_RAM:
+		pr_cont("L1 Dirty RAM");
+		break;
+	case TLB_RAM:
+		pr_cont("TLB RAM");
+		break;
+	default:
+		pr_cont("unknown");
+		break;
+	}
+	pr_cont(" error(s) detected\n");
+
+	if (CPUMERRSR_EL1_FATAL(val)) {
+		cortex_printk(KERN_INFO,
+			      "CPU %d L1 fatal error(s) detected (0x%llx)\n",
+			      cpu, val);
+		return -1;
+	}
+
+	return 1;
+}
+
+static int parse_l2merrsr(unsigned int cpu)
+{
+	u64 val = per_cpu(l2merr, cpu);
+
+	/* check if we have valid error before continuing */
+	if (!L2MERRSR_EL1_VALID(val))
+		return 0;
+
+	cortex_printk(KERN_INFO, "CPU %d L2 %s error(s) detected (0x%llx)\n",
+		      cpu, L2MERRSR_EL1_FATAL(val) ? "fatal" : "", val);
+
+	return L2MERRSR_EL1_FATAL(val) ? -1 : 1;
+}
+
+#define MESSAGE_SIZE 40
+static void cortex_arm64_edac_check(struct edac_device_ctl_info *edac_ctl)
+{
+	int cpu;
+	char msg[MESSAGE_SIZE];
+	call_single_data_t *csd;
+
+	get_online_cpus();
+	for_each_cpu_and(cpu, cpu_online_mask, &compat_mask) {
+		csd = &per_cpu(csd_check, cpu);
+		csd->func = read_errors;
+		csd->info = NULL;
+		csd->flags = 0;
+		/* Read CPU L1 error */
+		smp_call_function_single_async(cpu, csd);
+		/* Wait until flags cleared */
+		smp_cond_load_acquire(&csd->flags, !VAL);
+	}
+	put_online_cpus();
+
+	cpumask_clear(&l1_ce_cpu_mask);
+	cpumask_clear(&l1_ue_cpu_mask);
+	cpumask_clear(&l2_ce_cpu_mask);
+	cpumask_clear(&l2_ue_cpu_mask);
+	for_each_cpu_and(cpu, cpu_online_mask, &compat_mask) {
+		switch (parse_cpumerrsr(cpu)) {
+		case -1:
+			/* fatal error */
+			cpumask_set_cpu(cpu, &l1_ue_cpu_mask);
+			break;
+		case 1:
+			/* correctable error(s) */
+			cpumask_set_cpu(cpu, &l1_ce_cpu_mask);
+			break;
+		default:
+			break;
+		}
+		switch (parse_l2merrsr(cpu)) {
+		case -1:
+			/* fatal error */
+			cpumask_set_cpu(cpu, &l2_ue_cpu_mask);
+			break;
+		case 1:
+			/* correctable error(s) */
+			cpumask_set_cpu(cpu, &l2_ce_cpu_mask);
+			break;
+		default:
+			break;
+		}
+	}
+
+	for_each_cpu(cpu, &l1_ue_cpu_mask) {
+		snprintf(msg, MESSAGE_SIZE, "Fatal error(s) on CPU %d\n", cpu);
+		edac_device_handle_ue(edac_ctl, 0, 0, msg);
+	}
+
+	for_each_cpu(cpu, &l1_ce_cpu_mask) {
+		snprintf(msg, MESSAGE_SIZE, "Correctable error(s) on CPU %d\n", cpu);
+		edac_device_handle_ce(edac_ctl, 0, 0, msg);
+	}
+
+	for_each_cpu(cpu, &l2_ue_cpu_mask) {
+		snprintf(msg, MESSAGE_SIZE, "Fatal error(s) on CPU %d\n", cpu);
+		edac_device_handle_ue(edac_ctl, 0, 1, msg);
+	}
+
+	for_each_cpu(cpu, &l2_ce_cpu_mask) {
+		snprintf(msg, MESSAGE_SIZE, "Correctable error(s) on CPU %d\n", cpu);
+		edac_device_handle_ce(edac_ctl, 0, 1, msg);
+	}
+
+	if (!cpumask_empty(&l1_ce_cpu_mask) ||
+	    !cpumask_empty(&l2_ce_cpu_mask) ||
+	    !cpumask_empty(&l1_ue_cpu_mask) ||
+	    !cpumask_empty(&l2_ue_cpu_mask)) {
+		if (poll_msec > MIN_POLL_MSEC) {
+			poll_msec >>= 1;
+			edac_device_reset_delay_period(edac_ctl, poll_msec);
+		} else {
+			cortex_printk(KERN_CRIT,
+				      "Excessive correctable errors\n");
+		}
+	} else {
+		if (poll_msec < MAX_POLL_MSEC) {
+			poll_msec <<= 1;
+			edac_device_reset_delay_period(edac_ctl, poll_msec);
+		}
+	}
+}
+
+static ssize_t l1_ce_sw_inject_show(struct edac_device_ctl_info *edac_ctl,
+				    char *data)
+{
+	return sprintf(data, "%ld\t Number of errors to be injected\n",
+		       l1_ce_sw_inject_count);
+}
+
+static ssize_t l1_ce_sw_inject_store(struct edac_device_ctl_info *edac_ctl,
+				     const char *data, size_t count)
+{
+	int ret;
+
+	ret = kstrtol(data, 0, &l1_ce_sw_inject_count);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t l1_ue_sw_inject_show(struct edac_device_ctl_info *edac_ctl,
+				    char *data)
+{
+	return sprintf(data, "%ld\t Number of errors to be injected\n",
+		       l1_ue_sw_inject_count);
+}
+
+static ssize_t l1_ue_sw_inject_store(struct edac_device_ctl_info *edac_ctl,
+				     const char *data, size_t count)
+{
+	int ret;
+
+	ret = kstrtol(data, 0, &l1_ue_sw_inject_count);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t l2_ce_sw_inject_show(struct edac_device_ctl_info *edac_ctl,
+				    char *data)
+{
+	return sprintf(data, "%ld\t Number of errors to be injected\n",
+		       l2_ce_sw_inject_count);
+}
+
+static ssize_t l2_ce_sw_inject_store(struct edac_device_ctl_info *edac_ctl,
+				     const char *data, size_t count)
+{
+	int ret;
+
+	ret = kstrtol(data, 0, &l2_ce_sw_inject_count);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t l2_ue_sw_inject_show(struct edac_device_ctl_info *edac_ctl,
+				    char *data)
+{
+	return sprintf(data, "%ld\t Number of errors to be injected\n",
+		       l2_ue_sw_inject_count);
+}
+
+static ssize_t l2_ue_sw_inject_store(struct edac_device_ctl_info *edac_ctl,
+				     const char *data, size_t count)
+{
+	int ret;
+
+	ret = kstrtol(data, 0, &l2_ue_sw_inject_count);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t l1_ue_hw_inject_show(struct edac_device_ctl_info *edac_ctl,
+				    char *data)
+{
+	u64 val;
+	int cpu;
+	int len = 0;
+	size_t size = PAGE_SIZE;
+
+	get_online_cpus();
+	for_each_cpu_and(cpu, cpu_online_mask, &compat_mask) {
+		/* Read CPU actlr */
+		smp_call_function_single(cpu, read_cpuactlr, NULL, 1);
+	}
+	put_online_cpus();
+	for_each_cpu_and(cpu, cpu_online_mask, &compat_mask) {
+		val = per_cpu(cpuactlr, cpu);
+		len += scnprintf(data + len, size,
+				 "%d\t %s CPU %d (CPUACTLR_EL1 = 0x%llx)\n",
+				 val & L1_ERR_INJ_EN ? 1 : 0,
+				 val & L1_ERR_INJ_EN ? "Enabled" : "Disabled",
+				 cpu, val);
+		size -= len;
+	}
+
+	return len;
+}
+
+/* We don't care which CPU we inject error to. No need to inject to every CPU */
+static ssize_t l1_ue_hw_inject_store(struct edac_device_ctl_info *edac_ctl,
+				     const char *data, size_t count)
+{
+	int ret;
+	long en;
+	struct cortex_pdata *pdata = edac_ctl->pvt_info;
+
+	ret = kstrtol(data, 0, &en);
+	if (ret)
+		return ret;
+
+	if (en)
+		write_cpuactlr(pdata->mem);
+
+	return count;
+}
+
+static ssize_t l2_ue_hw_inject_show(struct edac_device_ctl_info *edac_ctl,
+				    char *data)
+{
+	u64 val;
+	int cpu;
+	int len = 0;
+	size_t size = PAGE_SIZE;
+
+	get_online_cpus();
+	for_each_cpu_and(cpu, cpu_online_mask, &compat_mask) {
+		/* Read L2 actlr */
+		smp_call_function_single(cpu, read_l2actlr, NULL, 1);
+	}
+	put_online_cpus();
+	for_each_cpu_and(cpu, cpu_online_mask, &compat_mask) {
+		val = per_cpu(l2actlr, cpu);
+		len += scnprintf(data + len, size,
+				 "%d\t %s CPU %d (L2ACTLR_EL1 = 0x%llx)\n",
+				 val & L1_ERR_INJ_EN ? 1 : 0,
+				 val & L1_ERR_INJ_EN ? "Enabled" : "Disabled",
+				 cpu, val);
+		size -= len;
+	}
+
+	return len;
+}
+
+/* We don't care which CPU we inject error to. No need to inject to every CPU */
+static ssize_t l2_ue_hw_inject_store(struct edac_device_ctl_info *edac_ctl,
+				     const char *data, size_t count)
+{
+	int ret;
+	long en;
+	struct cortex_pdata *pdata = edac_ctl->pvt_info;
+
+	ret = kstrtol(data, 0, &en);
+	if (ret)
+		return ret;
+
+	if (en)
+		write_l2actlr(pdata->mem);
+
+	return count;
+}
+
+static struct edac_dev_sysfs_attribute device_sysfs_attr[] = {
+	{
+		.attr = {
+			.name = "l1_ce_sw_inject",
+			.mode = 0644,
+		},
+		.show = l1_ce_sw_inject_show,
+		.store = l1_ce_sw_inject_store,
+	},
+	{
+		.attr = {
+			.name = "l1_ue_sw_inject",
+			.mode = 0644,
+		},
+		.show = l1_ue_sw_inject_show,
+		.store = l1_ue_sw_inject_store,
+	},
+	{
+		.attr = {
+			.name = "l2_ce_sw_inject",
+			.mode = 0644,
+		},
+		.show = l2_ce_sw_inject_show,
+		.store = l2_ce_sw_inject_store,
+	},
+	{
+		.attr = {
+			.name = "l2_ue_sw_inject",
+			.mode = 0644,
+		},
+		.show = l2_ue_sw_inject_show,
+		.store = l2_ue_sw_inject_store,
+	},
+	{
+		.attr = {
+			.name = "l1_ue_hw_inject",
+			.mode = 0644,
+		},
+		.show = l1_ue_hw_inject_show,
+		.store = l1_ue_hw_inject_store,
+	},
+	{
+		.attr = {
+			.name = "l2_ue_hw_inject",
+			.mode = 0644,
+		},
+		.show = l2_ue_hw_inject_show,
+		.store = l2_ue_hw_inject_store,
+	},
+	{},
+};
+
+static irqreturn_t cortex_edac_isr(int irq, void *dev_id)
+{
+	struct edac_device_ctl_info *edac_ctl = dev_id;
+
+	pr_debug("Got IRQ\n");
+	cortex_arm64_edac_check(edac_ctl);
+
+	return IRQ_HANDLED;
+}
+
+static int cortex_arm64_edac_probe(struct platform_device *pdev)
+{
+	int i, rc, cpu, num_attr;
+	struct edac_device_ctl_info *edac_ctl;
+	struct device *dev = &pdev->dev;
+	struct cortex_pdata *pdata;
+	struct device_node *np, *dn = pdev->dev.of_node;
+	struct of_phandle_iterator it;
+	struct edac_dev_sysfs_attribute *attr;
+
+	cpumask_clear(&compat_mask);
+	of_for_each_phandle(&it, rc, dn, "cpus", NULL, 0) {
+		np = it.node;
+		cpu = of_cpu_node_to_id(np);
+		cpumask_set_cpu(cpu, &compat_mask);
+	}
+
+	pr_debug("compat_mask is %*pbl\n", cpumask_pr_args(&compat_mask));
+
+	if (of_device_is_compatible(dn, "arm,cortex-a53-edac")) {
+		num_attr = ARRAY_SIZE(device_sysfs_attr);
+		get_online_cpus();
+		for_each_cpu_and(cpu, cpu_online_mask, &compat_mask) {
+			smp_call_function_single(cpu, a53_allow_l1l2_err_inj, NULL, 1);
+			if (per_cpu(actlr_en, cpu)) {
+				pr_err("Failed to enable hardware error injection (%ld)\n",
+				       per_cpu(actlr_en, cpu));
+				num_attr -= 2;
+				break;
+			}
+		}
+		put_online_cpus();
+
+		pdata->irq = platform_get_irq(pdev, 0);
+		pr_debug("irq is %d\n", pdata->irq);
+
+		rc = devm_request_irq(dev, pdata->irq, cortex_edac_isr,
+				      0, "cortex_edac error", edac_ctl);
+		if (rc < 0) {
+			pr_err("%s: Unable to request irq %d for cortex edac error\n",
+			       __func__, pdata->irq);
+			goto out_irq;
+		}
+	} else {
+		num_attr = ARRAY_SIZE(device_sysfs_attr) - 2;
+	}
+
+	/* POLL mode is used to detect correctable errors */
+	edac_op_state = EDAC_OPSTATE_POLL;
+
+	edac_ctl = edac_device_alloc_ctl_info(sizeof(*pdata), "cpu_cache",
+					      1, "L", 2, 1, NULL, 0,
+					      edac_device_alloc_index());
+	if (IS_ERR(edac_ctl))
+		return -ENOMEM;
+
+	pdata = edac_ctl->pvt_info;
+	attr = devm_kzalloc(dev,
+			    sizeof(struct edac_dev_sysfs_attribute) * num_attr,
+			    GFP_KERNEL);
+	if (!attr) {
+		rc = -ENOMEM;
+		goto out_dev;
+	}
+
+	for (i = 0; i < num_attr - 1; i++) {
+		attr[i].attr.name = device_sysfs_attr[i].attr.name;
+		attr[i].attr.mode = device_sysfs_attr[i].attr.mode;
+		attr[i].show = device_sysfs_attr[i].show;
+		attr[i].store = device_sysfs_attr[i].store;
+	}
+	edac_ctl->sysfs_attributes = attr;
+
+	rc = of_count_phandle_with_args(dn, "cpus", NULL);
+	if (rc <= 0) {
+		pr_err("Invalid number of phandles in 'cpus'\n");
+		rc = -EINVAL;
+		goto out_dev;
+	}
+
+	edac_ctl->poll_msec = poll_msec;
+	edac_ctl->edac_check = cortex_arm64_edac_check;
+	edac_ctl->dev = dev;
+	edac_ctl->mod_name = dev_name(dev);
+	edac_ctl->dev_name = dev_name(dev);
+	edac_ctl->ctl_name = EDAC_MOD_STR;
+	dev_set_drvdata(dev, edac_ctl);
+
+	rc = edac_device_add_device(edac_ctl);
+	if (rc)
+		goto out_dev;
+
+	pdata->mem = devm_kzalloc(dev, PAGE_SIZE, GFP_KERNEL);
+	if (!pdata->mem)
+		goto out_mem;
+
+	get_online_cpus();
+	for_each_cpu_and(cpu, cpu_online_mask, &compat_mask) {
+		smp_call_function_single(cpu,
+					 a53_allow_l1l2_err_irq_clr,
+					 NULL,
+					 1);
+		if (per_cpu(l2ectlr_en, cpu)) {
+			pr_err("Failed to enable error clearing (%ld)\n",
+			       per_cpu(l2ectlr_en, cpu));
+			rc = -EACCES;
+			break;
+		}
+	}
+	put_online_cpus();
+
+	return 0;
+
+out_mem:
+out_irq:
+	edac_device_del_device(edac_ctl->dev);
+
+out_dev:
+	edac_device_free_ctl_info(edac_ctl);
+
+	return rc;
+}
+
+static int cortex_arm64_edac_remove(struct platform_device *pdev)
+{
+	struct edac_device_ctl_info *edac_ctl = dev_get_drvdata(&pdev->dev);
+
+	edac_device_del_device(edac_ctl->dev);
+	edac_device_free_ctl_info(edac_ctl);
+
+	return 0;
+}
+
+static const struct of_device_id cortex_arm64_edac_of_match[] = {
+	{ .compatible = "arm,cortex-a53-edac" },
+	{ .compatible = "arm,cortex-a72-edac" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, cortex_arm64_edac_of_match);
+
+static struct platform_driver cortex_arm64_edac_driver = {
+	.probe = cortex_arm64_edac_probe,
+	.remove = cortex_arm64_edac_remove,
+	.driver = {
+		.name = EDAC_MOD_STR,
+		.of_match_table = cortex_arm64_edac_of_match,
+	},
+};
+module_platform_driver(cortex_arm64_edac_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("York Sun <york.sun@nxp.com>");
diff --git a/drivers/edac/cortex_arm64_l1_l2.h b/drivers/edac/cortex_arm64_l1_l2.h
new file mode 100644
index 000000000000..f6e24755d64c
--- /dev/null
+++ b/drivers/edac/cortex_arm64_l1_l2.h
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cortex A53 and A72 EDAC L1 and L2 cache error detection
+ *
+ * Copyright 2018-2020 NXP
+ * Author: York Sun <york.sun@nxp.com>
+ *
+ * Partially take from a similar driver by
+ * Brijesh Singh <brijeshkumar.singh@amd.com>
+ * Copyright (c) 2015, Advanced Micro Devices
+ */
+
+#ifndef __CORTEX_ARM64_L1_L2_H
+#define __CORTEX_ARM64_L1_L2_H
+
+#define NXP_SIP_SVC_ALLOW_L1L2_ERR	0xc200ff15
+#define NXP_SIP_SVC_ALLOW_L2_CLR	0xc200ff16
+
+#define EDAC_MOD_STR			"cortex_edac_l1_l2"
+
+#define cortex_printk(level, fmt, arg...) \
+	edac_printk(level, EDAC_MOD_STR, fmt, ##arg)
+
+#define CPUMERRSR_EL1_RAMID(x)		(((x) >> 24) & 0x7f)
+#define CPUMERRSR_EL1_VALID(x)		((x) & (1 << 31))
+#define CPUMERRSR_EL1_FATAL(x)		((x) & (1UL << 63))
+#define CPUMERRSR_RAMID_MASK		(0x7f << 24)
+#define L1_I_TAG_RAM			0x00
+#define L1_I_DATA_RAM			0x01
+#define L1_D_TAG_RAM			0x08
+#define L1_D_DATA_RAM			0x09
+#define L1_D_DIRTY_RAM			0x14
+#define TLB_RAM				0x18
+
+#define L2MERRSR_EL1_VALID(x)		((x) & (1 << 31))
+#define L2MERRSR_EL1_FATAL(x)		((x) & (1UL << 63))
+#define L2MERRSR_RAMID_MASK		(0x7f << 24)
+
+#define MAX_POLL_MSEC 16384
+#define MIN_POLL_MSEC 64
+
+/* Error injection bit in CPUACTLR_EL1 */
+#define L1_ERR_INJ_EN			(1 << 6)
+/* Error injection bit in L2ACTLR_EL1 */
+#define L2D_ERR_INJ_EN			(1 << 29)
+/* L2 ERR interrupt */
+#define L2_ERR_INT			(1 << 30)
+
+struct cortex_pdata {
+	int irq;
+	void *mem;
+};
+
+#endif /* __CORTEX_ARM64_L1_L2_H */
-- 
2.17.1

