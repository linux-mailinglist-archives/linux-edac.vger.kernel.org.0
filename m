Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173322D3123
	for <lists+linux-edac@lfdr.de>; Tue,  8 Dec 2020 18:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbgLHRbl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 8 Dec 2020 12:31:41 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2223 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727463AbgLHRbl (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 8 Dec 2020 12:31:41 -0500
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Cr6bn1917z67Ny3;
        Wed,  9 Dec 2020 01:28:53 +0800 (CST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 8 Dec 2020 18:30:57 +0100
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.26.232) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 8 Dec 2020 17:30:56 +0000
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <james.morse@arm.com>,
        <mchehab+huawei@kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>, <rrichter@marvell.com>
CC:     <linuxarm@huawei.com>, <xuwei5@huawei.com>,
        <jonathan.cameron@huawei.com>, <john.garry@huawei.com>,
        <tanxiaofei@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
        <salil.mehta@huawei.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH 1/2] EDAC/ghes: Add EDAC device for the CPU caches
Date:   Tue, 8 Dec 2020 17:29:58 +0000
Message-ID: <20201208172959.1249-2-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20201208172959.1249-1-shiju.jose@huawei.com>
References: <20201208172959.1249-1-shiju.jose@huawei.com>
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

The corrected error count on the CPU caches required
reporting to the user-space for the predictive failure
analysis. For this purpose, add an EDAC device and device
blocks for the CPU caches found.
The cache's corrected error count would be stored in the
/sys/devices/system/edac/cpu/cpu*/cache*/ce_count.

Issues and possible solutions,
1.Cache info is not available for the CPUs offline.
 EDAC device interface supports only creating EDAC device
 and device blocks for the all the CPU caches together.
 It requires the number of caches as device blocks for
 the creation. However, this info is not available for
 the CPUs which offline and may become online later.

Tested Solution: Find the max number of caches among
  online CPUs, create the EDAC device for CPUs caches
  and get and populate the cache info for an offline
  CPU later, when the error is reported on that CPU for
  the first time.

2. Reporting error count for the Shared caches.
   There are few possible solutions,
2.1 Kernel would report a new error count for a shared cache
    per CPU through the EDAC device block for that CPU.
    Then user-space application sums the total error count
    for a shared cache from EDAC device blocks of all the
    CPUs in the shared CPU list of that shared cache.
2.2 Kernel would report a new error count for a shared cache
    through the EDAC device blocks for all the CPUs in the
    shared CPU list of that shared cache.

Tested Solution: The current implementation used the solution 2.1

For the firmware-first error handling, add an interface in the
ghes_edac for reporting the CPU corrected error count for
a CPU core to the user-space through the CPU EDAC device.

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 Documentation/ABI/testing/sysfs-devices-edac |  15 ++
 drivers/acpi/apei/ghes.c                     |   8 +-
 drivers/edac/Kconfig                         |  10 ++
 drivers/edac/ghes_edac.c                     | 171 +++++++++++++++++++
 include/acpi/ghes.h                          |  27 +++
 5 files changed, 230 insertions(+), 1 deletion(-)

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
index fce7ade2aba9..e7b0edbda0f8 100644
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
+ * because the CPU cacheinfo should be populated and needed for
+ * adding the CPU cache edac device blocks in the ghes_edac_register().
+ */
+device_initcall_sync(ghes_init);
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 7a47680d6f07..c73eeab27ac9 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -74,6 +74,16 @@ config EDAC_GHES
 
 	  In doubt, say 'Y'.
 
+config EDAC_GHES_CPU_ERROR
+	bool "EDAC device for reporting firmware-first BIOS detected CPU error count"
+	depends on EDAC_GHES
+	help
+	  EDAC device for the firmware-first BIOS detected CPU error count reported
+	  via ACPI APEI/GHES. By enabling this option, EDAC device for the CPU
+	  hierarchy and edac device blocks for caches would be created.
+	  The cpu error count is shared with the userspace via the CPU EDAC
+	  device's sysfs interface.
+
 config EDAC_AMD64
 	tristate "AMD64 (Opteron, Athlon64)"
 	depends on AMD_NB && EDAC_DECODE_MCE
diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index a918ca93e4f7..e6a73a413b33 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -12,6 +12,9 @@
 #include <acpi/ghes.h>
 #include <linux/edac.h>
 #include <linux/dmi.h>
+#if defined(CONFIG_EDAC_GHES_CPU_ERROR)
+#include <linux/cacheinfo.h>
+#endif
 #include "edac_module.h"
 #include <ras/ras_event.h>
 
@@ -497,6 +500,166 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 	spin_unlock_irqrestore(&ghes_lock, flags);
 }
 
+#if defined(CONFIG_EDAC_GHES_CPU_ERROR)
+static struct ghes_edac_cpu_block {
+	int cpu;
+	u8 level;
+	u8 type;
+	int block_nr;
+	bool info_populated;
+} *cpu_edac_block_list;
+
+static struct edac_device_ctl_info *cpu_edac_dev;
+static unsigned int max_number_of_caches;
+
+static  int ghes_edac_add_cpu_device(struct device *dev)
+{
+	int rc;
+
+	cpu_edac_dev = edac_device_alloc_ctl_info(0, "cpu",  num_possible_cpus(),
+						  "cache", max_number_of_caches, 0, NULL,
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
+	max_number_of_caches = 0;
+	if (cpu_edac_dev) {
+		edac_device_del_device(cpu_edac_dev->dev);
+		edac_device_free_ctl_info(cpu_edac_dev);
+	}
+	vfree(cpu_edac_block_list);
+}
+
+static int ghes_edac_get_cache_info(int cpu)
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
+	 * among CPUs). Thus cache info in the cpu_edac_block_list would be populated when
+	 * the error is reported on that cpu. Thus we need to restrict the number of caches
+	 * if the CPU's num_leaves exceed the max_number_of_caches.
+	 */
+	num_caches = min(max_number_of_caches, this_cpu_ci->num_leaves);
+
+	/*
+	 * The edac CPU cache device blocks entries in the sysfs should match with the
+	 * CPU cache structure in the sysfs so that the affected cpus for a shared cache
+	 * can be easily extracted in the userspace.
+	 */
+	for (i = 0; i < num_caches; i++) {
+		block = cpu_edac_block_list + (cpu * max_number_of_caches) + i;
+		block->cpu = cpu;
+		block->level = this_leaf->level;
+		block->type = this_leaf->type;
+		block->block_nr = i;
+		block->info_populated = true;
+		this_leaf++;
+	}
+
+	return 0;
+}
+
+static void ghes_edac_create_cpu_device(struct device *dev)
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
+		if (max_number_of_caches < this_cpu_ci->num_leaves)
+			max_number_of_caches = this_cpu_ci->num_leaves;
+	}
+	if (!max_number_of_caches)
+		return;
+
+	/*
+	 * EDAC device interface only supports creating the CPU cache hierarchy for alls
+	 * the CPUs together. Thus need to allocate cpu_edac_block_list for the
+	 * max_number_of_caches among all the CPUs irrespective of the number of caches
+	 * per CPU might vary.
+	 */
+	cpu_edac_block_list = vzalloc(num_possible_cpus() * max_number_of_caches *
+				      sizeof(*cpu_edac_block_list));
+	if (!cpu_edac_block_list)
+		return;
+
+	if (ghes_edac_add_cpu_device(dev))
+		goto error;
+
+	for_each_online_cpu(cpu)
+		ghes_edac_get_cache_info(cpu);
+
+	return;
+
+error:
+	ghes_edac_delete_cpu_device();
+}
+
+void ghes_edac_report_cpu_error(struct ghes_einfo_cpu *einfo)
+{
+	struct ghes_edac_cpu_block *block;
+	int i;
+
+	if (!einfo || !(einfo->ce_count) || !max_number_of_caches)
+		return;
+
+	/*
+	 * EDAC device require the number of device blocks (for example max number of caches
+	 * among CPUs) during the creation. For the CPUs that were offline in the cpu edac
+	 * init and become online later, the cache info would be populated when the error is
+	 * reported  on that cpu.
+	 */
+	block = cpu_edac_block_list + (einfo->cpu * max_number_of_caches);
+	if (!block->info_populated) {
+		if (ghes_edac_get_cache_info(einfo->cpu))
+			return;
+	}
+
+	for (i = 0; i < max_number_of_caches; i++) {
+		block = cpu_edac_block_list + (einfo->cpu * max_number_of_caches) + i;
+		if ((block->level == einfo->cache_level) && (block->type == einfo->cache_type)) {
+			edac_device_handle_ce_count(cpu_edac_dev, einfo->ce_count,
+						    einfo->cpu, block->block_nr, "");
+			break;
+		}
+	}
+}
+#endif
+
 /*
  * Known systems that are safe to enable this module.
  */
@@ -624,6 +787,10 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	ghes_pvt = pvt;
 	spin_unlock_irqrestore(&ghes_lock, flags);
 
+#if defined(CONFIG_EDAC_GHES_CPU_ERROR)
+	ghes_edac_create_cpu_device(dev);
+#endif
+
 	/* only set on success */
 	refcount_set(&ghes_refcount, 1);
 
@@ -654,6 +821,10 @@ void ghes_edac_unregister(struct ghes *ghes)
 	if (!refcount_dec_and_test(&ghes_refcount))
 		goto unlock;
 
+#if defined(CONFIG_EDAC_GHES_CPU_ERROR)
+	ghes_edac_delete_cpu_device();
+#endif
+
 	/*
 	 * Wait for the irq handler being finished.
 	 */
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index 34fb3431a8f3..8702eba26afc 100644
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
 
+#ifdef CONFIG_EDAC_GHES_CPU_ERROR
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

