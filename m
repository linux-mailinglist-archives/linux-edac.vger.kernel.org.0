Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2243088C7
	for <lists+linux-edac@lfdr.de>; Fri, 29 Jan 2021 13:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbhA2MB7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 29 Jan 2021 07:01:59 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2456 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbhA2L66 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 29 Jan 2021 06:58:58 -0500
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DRsts4L07z67gRx;
        Fri, 29 Jan 2021 17:47:01 +0800 (CST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 29 Jan 2021 10:50:24 +0100
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.27.74) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 29 Jan 2021 09:50:22 +0000
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <james.morse@arm.com>,
        <bp@alien8.de>, <tony.luck@intel.com>, <rjw@rjwysocki.net>,
        <lenb@kernel.org>, <rrichter@marvell.com>,
        <mchehab+huawei@kernel.org>
CC:     <linuxarm@openeuler.org>, <xuwei5@huawei.com>,
        <jonathan.cameron@huawei.com>, <john.garry@huawei.com>,
        <tanxiaofei@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
        <salil.mehta@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v2 1/2] EDAC/ghes: Add EDAC device for reporting the CPU cache errors
Date:   Fri, 29 Jan 2021 09:48:31 +0000
Message-ID: <20210129094832.2090-2-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210129094832.2090-1-shiju.jose@huawei.com>
References: <20210129094832.2090-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.47.27.74]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml715-chm.china.huawei.com (10.201.108.66)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

CPU L2 cache corrected errors are detected occasionally on
few of our ARM64 hardware boards. Though it is rare, the
probability of the CPU cache errors frequently occurring
can't be avoided. The earlier failure detection by monitoring
the cache corrected errors for the frequent occurrences and
taking preventive action could prevent more serious hardware
faults.

On Intel architectures, cache corrected errors are reported and
the affected cores are offlined in the architecture specific method.
http://www.mcelog.org/cache.html

However for the firmware-first error reporting, specifically on
ARM64 architectures, there is no provision present for reporting
the cache corrected error count to the user-space and taking
preventive action such as offline the affected cores.

For this purpose, it was suggested to create the CPU EDAC
device for the CPU caches for reporting the cache error count
for the firmware-first error reporting.
The EDAC device blocks for the CPU caches would be created
based on the cache information obtained from the cpu_cacheinfo.

User-space application could monitor the recorded corrected error
count for the earlier hardware failure detection and could take
preventive action, such as offline the corresponding CPU core/s.

Add an EDAC device and device blocks for the CPU caches
based on the cache information from the cpu_cacheinfo.
The cache's corrected error count would be stored in the
/sys/devices/system/edac/cpu/cpu*/cache*/ce_count.

Issues and possible solutions,
1.Cache info is not available for the CPUs offline.
 EDAC device interface requires creating EDAC device
 and device blocks together. It requires the number
 of caches per CPU as device blocks for the creation.
 However, this info is not available for the
 offlined CPUs.
Tested Solution: Find the max number of caches among
  online CPUs, create the EDAC device for CPUs caches
  and get and populate the cache info for an offline
  CPU later, when the error is reported on that CPU for
  the first time.

2. Reporting error count for the Shared caches.
   There are few possible solutions,
Tested Solution:
    Kernel would report a new error count for a shared cache
    through the EDAC device block for that CPU on which the error
	is reported. Then user-space application would sum the total
	error count from EDAC device block of all the CPUs in the
	shared CPU list of that shared cache.

For the firmware-first error reporting, add an interface in the
ghes_edac allow to report a CPU corrected error count.

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 Documentation/ABI/testing/sysfs-devices-edac |  15 ++
 drivers/acpi/apei/ghes.c                     |   8 +-
 drivers/edac/Kconfig                         |  12 ++
 drivers/edac/ghes_edac.c                     | 186 +++++++++++++++++++
 include/acpi/ghes.h                          |  27 +++
 5 files changed, 247 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-edac b/Documentation/ABI/testing/sysfs-devices-edac
index 256a9e990c0b..56a18b0af419 100644
--- a/Documentation/ABI/testing/sysfs-devices-edac
+++ b/Documentation/ABI/testing/sysfs-devices-edac
@@ -155,3 +155,18 @@ Description:	This attribute file displays the total count of uncorrectable
 		errors that have occurred on this DIMM. If panic_on_ue is set, this
 		counter will not have a chance to increment, since EDAC will panic the
 		system
+
+What:           /sys/devices/system/edac/cpu/cpu*/cache*/ce_count
+Date:           December 2020
+Contact:        linux-edac@vger.kernel.org
+Description:    This attribute file displays the total count of correctable
+                errors that have occurred on this CPU cache. This count is very important
+                to examine. CEs provide early indications that a cache is beginning
+                to fail. This count field should be monitored for non-zero values
+                and report such information to the system administrator.
+
+What:           /sys/devices/system/edac/cpu/cpu*/cache*/ue_count
+Date:           December 2020
+Contact:        linux-edac@vger.kernel.org
+Description:    This attribute file displays the total count of uncorrectable
+                errors that have occurred on this CPU cache.
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index fce7ade2aba9..139540f2c8f4 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1452,4 +1452,10 @@ static int __init ghes_init(void)
 err:
 	return rc;
 }
-device_initcall(ghes_init);
+
+/*
+ * device_initcall_sync() is added instead of the device_initcall()
+ * because the CPU cacheinfo should be populated and is required for
+ * adding the CPU cache edac device in the ghes_edac_register().
+ */
+device_initcall_sync(ghes_init);
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 81c42664f21b..39fb53aa9cd9 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -74,6 +74,18 @@ config EDAC_GHES
 
 	  In doubt, say 'Y'.
 
+config EDAC_GHES_CPU_CACHE_ERROR
+	bool "EDAC device for reporting firmware-first BIOS detected CPU cache error count"
+	depends on EDAC_GHES
+	depends on (ARM64 || COMPILE_TEST)
+	help
+	  EDAC device for the firmware-first BIOS detected CPU cache error count,
+	  reported via ACPI APEI/GHES. By enabling this option, EDAC device for
+	  the CPU hierarchy and edac device blocks for the caches would be created.
+	  The cache error count is shared with the userspace via the CPU EDAC
+	  device's sysfs interface. This option is architecure independent though
+	  currently it is tested and enabled for ARM64 only.
+
 config EDAC_AMD64
 	tristate "AMD64 (Opteron, Athlon64)"
 	depends on AMD_NB && EDAC_DECODE_MCE
diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 6d1ddecbf0da..400b50be0c33 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -12,6 +12,9 @@
 #include <acpi/ghes.h>
 #include <linux/edac.h>
 #include <linux/dmi.h>
+#if defined(CONFIG_EDAC_GHES_CPU_CACHE_ERROR)
+#include <linux/cacheinfo.h>
+#endif
 #include "edac_module.h"
 #include <ras/ras_event.h>
 
@@ -57,6 +60,21 @@ module_param(force_load, bool, 0);
 
 static bool system_scanned;
 
+#if defined(CONFIG_EDAC_GHES_CPU_CACHE_ERROR)
+struct ghes_edac_cpu_block {
+	int cpu;
+	u8 level;
+	u8 type;
+	int block_nr;
+	bool info_populated;
+};
+
+static struct ghes_edac_cpu_block __percpu *edac_cpu_block_list;
+
+static struct edac_device_ctl_info *cpu_edac_dev;
+static unsigned int num_caches_per_cpu;
+#endif
+
 /* Memory Device - Type 17 of SMBIOS spec */
 struct memdev_dmi_entry {
 	u8 type;
@@ -225,6 +243,164 @@ static void enumerate_dimms(const struct dmi_header *dh, void *arg)
 	hw->num_dimms++;
 }
 
+#if defined(CONFIG_EDAC_GHES_CPU_CACHE_ERROR)
+static void ghes_edac_get_cpu_cacheinfo(void)
+{
+	int cpu;
+	struct cpu_cacheinfo *this_cpu_ci;
+
+	/*
+	 * Find the maximum number of caches present in the CPU heirarchy
+	 * among the online CPUs.
+	 */
+	for_each_online_cpu(cpu) {
+		this_cpu_ci = get_cpu_cacheinfo(cpu);
+		if (!this_cpu_ci)
+			continue;
+		if (num_caches_per_cpu < this_cpu_ci->num_leaves)
+			num_caches_per_cpu = this_cpu_ci->num_leaves;
+	}
+}
+
+static  int ghes_edac_add_cpu_device(struct device *dev)
+{
+	int rc;
+
+	cpu_edac_dev = edac_device_alloc_ctl_info(0, "cpu",  num_possible_cpus(),
+						  "cache", num_caches_per_cpu, 0, NULL,
+						  0, edac_device_alloc_index());
+	if (!cpu_edac_dev) {
+		pr_warn("ghes-edac cpu edac device registration failed\n");
+		return -ENOMEM;
+	}
+
+	cpu_edac_dev->dev = dev;
+	cpu_edac_dev->ctl_name = "cpu_edac_dev";
+	cpu_edac_dev->dev_name = "ghes";
+	cpu_edac_dev->mod_name = "ghes_edac.c";
+	rc = edac_device_add_device(cpu_edac_dev);
+	if (rc > 0) {
+		pr_warn("edac_device_add_device failed\n");
+		edac_device_free_ctl_info(cpu_edac_dev);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static  void ghes_edac_delete_cpu_device(void)
+{
+	num_caches_per_cpu = 0;
+	if (cpu_edac_dev) {
+		edac_device_del_device(cpu_edac_dev->dev);
+		edac_device_free_ctl_info(cpu_edac_dev);
+	}
+	free_percpu(edac_cpu_block_list);
+}
+
+static int ghes_edac_populate_cache_info(int cpu)
+{
+	struct ghes_edac_cpu_block *block;
+	struct cpu_cacheinfo *this_cpu_ci;
+	struct cacheinfo *this_leaf;
+	int i, num_caches;
+
+	this_cpu_ci = get_cpu_cacheinfo(cpu);
+	if (!this_cpu_ci || !this_cpu_ci->info_list || !this_cpu_ci->num_leaves)
+		return	-EINVAL;
+
+	this_leaf = this_cpu_ci->info_list;
+	/*
+	 * Cache info would not be available for a CPU which is offline. However EDAC device
+	 * creation requires the number of device blocks (for example max number of caches
+	 * among CPUs). The cache info in the edac_cpu_block_list would be populated when
+	 * the first error is reported on that cpu. Thus we need to restrict the number
+	 * of caches if the CPU's num_leaves exceed the max number of caches per cpu
+	 * calculated in the init time.
+	 */
+	num_caches = min(num_caches_per_cpu, this_cpu_ci->num_leaves);
+
+	/*
+	 * The edac CPU cache device blocks entries in the sysfs should match with the
+	 * CPU cache structure in the sysfs so that the affected cpus for a shared cache
+	 * can be easily extracted in the userspace.
+	 */
+	block = per_cpu_ptr(edac_cpu_block_list, cpu);
+	for (i = 0; i < num_caches; i++) {
+		block->cpu = cpu;
+		block->level = this_leaf->level;
+		block->type = this_leaf->type;
+		block->block_nr = i;
+		block->info_populated = true;
+		this_leaf++;
+		block++;
+	}
+
+	return 0;
+}
+
+static void ghes_edac_create_cpu_device(struct device *dev)
+{
+	int cpu;
+
+	if (!num_caches_per_cpu)
+		return;
+
+	/*
+	 * Allocate EDAC CPU cache list.
+	 * EDAC device interface require creating the CPU cache hierarchy for all
+	 * the CPUs together. Thus need to allocate edac_cpu_block_list for the
+	 * maximum number of caches per cpu among all the CPUs irrespective of
+	 * the number of caches per CPU might vary.
+	 */
+	edac_cpu_block_list =  __alloc_percpu(sizeof(struct ghes_edac_cpu_block) * num_caches_per_cpu,
+					      __alignof__(u64));
+	if (!edac_cpu_block_list)
+		return;
+
+	if (ghes_edac_add_cpu_device(dev)) {
+		ghes_edac_delete_cpu_device();
+		return;
+	}
+
+	/*
+	 * Populate EDAC CPU cache list with cache's information.
+	 */
+	for_each_online_cpu(cpu)
+		ghes_edac_populate_cache_info(cpu);
+}
+
+void ghes_edac_report_cpu_error(struct ghes_einfo_cpu *einfo)
+{
+	struct ghes_edac_cpu_block *block;
+	int i;
+
+	if (!einfo || !(einfo->ce_count) || !num_caches_per_cpu)
+		return;
+
+	/*
+	 * EDAC device require the number of device blocks (for example max number of caches
+	 * among CPUs) during the creation. For the CPUs that were offline in the cpu edac
+	 * init and become online later, the cache info would be populated when the first
+	 * error is reported  on that cpu.
+	 */
+	block = per_cpu_ptr(edac_cpu_block_list, einfo->cpu);
+	if (!block->info_populated) {
+		if (ghes_edac_populate_cache_info(einfo->cpu))
+			return;
+	}
+
+	for (i = 0; i < num_caches_per_cpu; i++) {
+		if ((block->level == einfo->cache_level) && (block->type == einfo->cache_type)) {
+			edac_device_handle_ce_count(cpu_edac_dev, einfo->ce_count,
+						    einfo->cpu, block->block_nr, "");
+			break;
+		}
+		block++;
+	}
+}
+#endif
+
 static void ghes_scan_system(void)
 {
 	if (system_scanned)
@@ -232,6 +408,8 @@ static void ghes_scan_system(void)
 
 	dmi_walk(enumerate_dimms, &ghes_hw);
 
+	ghes_edac_get_cpu_cacheinfo();
+
 	system_scanned = true;
 }
 
@@ -620,6 +798,10 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 		goto unlock;
 	}
 
+#if defined(CONFIG_EDAC_GHES_CPU_CACHE_ERROR)
+	ghes_edac_create_cpu_device(dev);
+#endif
+
 	spin_lock_irqsave(&ghes_lock, flags);
 	ghes_pvt = pvt;
 	spin_unlock_irqrestore(&ghes_lock, flags);
@@ -669,6 +851,10 @@ void ghes_edac_unregister(struct ghes *ghes)
 	if (mci)
 		edac_mc_free(mci);
 
+#if defined(CONFIG_EDAC_GHES_CPU_CACHE_ERROR)
+	ghes_edac_delete_cpu_device();
+#endif
+
 unlock:
 	mutex_unlock(&ghes_reg_mutex);
 }
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index 34fb3431a8f3..e019ad88fdc3 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -73,6 +73,24 @@ void ghes_unregister_vendor_record_notifier(struct notifier_block *nb);
 
 int ghes_estatus_pool_init(int num_ghes);
 
+/**
+ * struct ghes_einfo_cpu  - structure to pass the CPU error info to the edac
+ * @cpu: CPU index.
+ * @error_type: error type, cache/TLB/bus/ etc.
+ * @cache_level: cache level.
+ * @cache_type: ACPI cache type.
+ * @ue_count: CPU uncorrectable error count.
+ * @ce_count: CPU correctable error count.
+ */
+struct ghes_einfo_cpu {
+	int cpu;
+	u8 error_type;
+	u8 cache_level;
+	u8 cache_type;
+	u16 ue_count;
+	u16 ce_count;
+};
+
 /* From drivers/edac/ghes_edac.c */
 
 #ifdef CONFIG_EDAC_GHES
@@ -98,6 +116,15 @@ static inline void ghes_edac_unregister(struct ghes *ghes)
 }
 #endif
 
+#ifdef CONFIG_EDAC_GHES_CPU_CACHE_ERROR
+void ghes_edac_report_cpu_error(struct ghes_einfo_cpu *einfo_cpu);
+
+#else
+static inline void ghes_edac_report_cpu_error(struct ghes_einfo_cpu *einfo_cpu)
+{
+}
+#endif
+
 static inline int acpi_hest_get_version(struct acpi_hest_generic_data *gdata)
 {
 	return gdata->revision >> 8;
-- 
2.17.1

