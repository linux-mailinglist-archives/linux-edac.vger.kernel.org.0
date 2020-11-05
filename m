Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4824C2A8582
	for <lists+linux-edac@lfdr.de>; Thu,  5 Nov 2020 19:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731350AbgKESBZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 5 Nov 2020 13:01:25 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2059 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKESBY (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 5 Nov 2020 13:01:24 -0500
X-Greylist: delayed 1129 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Nov 2020 13:01:24 EST
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CRrV52Pv0z67J5h;
        Fri,  6 Nov 2020 01:43:41 +0800 (CST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 5 Nov 2020 18:44:56 +0100
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.87.221) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 5 Nov 2020 17:44:55 +0000
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <james.morse@arm.com>,
        <bp@alien8.de>, <tony.luck@intel.com>, <rjw@rjwysocki.net>,
        <lenb@kernel.org>, <rrichter@marvell.com>
CC:     <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
        <shiju.jose@huawei.com>
Subject: [RFC PATCH 3/4] EDAC/ghes: Add EDAC device for the CPU caches
Date:   Thu, 5 Nov 2020 17:42:32 +0000
Message-ID: <20201105174233.1146-4-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20201105174233.1146-1-shiju.jose@huawei.com>
References: <20201105174233.1146-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.47.87.221]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml715-chm.china.huawei.com (10.201.108.66)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Find CPU caches in the ACPI PPTT and add CPU EDAC device
and EDAC device blocks for the caches found.

For the firmware-first error handling, add an interface in the
ghes_edac, enable to report the CPU corrected error count for
a CPU core to the user-space through the CPU EDAC device.

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/edac/Kconfig     |  10 +++
 drivers/edac/ghes_edac.c | 135 +++++++++++++++++++++++++++++++++++++++
 include/acpi/ghes.h      |  27 ++++++++
 3 files changed, 172 insertions(+)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 7a47680d6f07..3a0d8d134dcc 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -74,6 +74,16 @@ config EDAC_GHES
 
 	  In doubt, say 'Y'.
 
+config EDAC_GHES_CPU_ERROR
+	bool "EDAC device for reporting firmware-first BIOS detected CPU error count"
+	depends on EDAC_GHES && ACPI_PPTT
+	help
+	  EDAC device for the firmware-first BIOS detected CPU error count reported
+	  via ACPI APEI/GHES. By enabling this option, EDAC device for the CPU
+	  hierarchy and EDAC device blocks for caches hierarchy would be created.
+	  The cpu error count is shared with the userspace via the CPU EDAC
+	  device's sysfs interface.
+
 config EDAC_AMD64
 	tristate "AMD64 (Opteron, Athlon64)"
 	depends on AMD_NB && EDAC_DECODE_MCE
diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index a918ca93e4f7..96619483e5f3 100644
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
 
@@ -497,6 +500,130 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 	spin_unlock_irqrestore(&ghes_lock, flags);
 }
 
+#if defined(CONFIG_EDAC_GHES_CPU_ERROR)
+#define MAX_NUM_CACHES	20
+static struct ghes_edac_cpu_block {
+	int cpu;
+	u8 level;
+	u8 type;
+	int block_nr;
+} *cpu_edac_block_list;
+
+static struct edac_device_ctl_info *cpu_edac_dev;
+static int max_number_of_caches;
+
+void ghes_edac_report_cpu_error(struct ghes_einfo_cpu *einfo)
+{
+	struct ghes_edac_cpu_block *block;
+	int i;
+
+	if (!einfo || !(einfo->ce_count) || !max_number_of_caches)
+		return;
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
+
+static  int ghes_edac_add_cpu_device(struct device *dev)
+{
+	int rc;
+
+	cpu_edac_dev = edac_device_alloc_ctl_info(0, "cpu",  num_possible_cpus(),
+						  "cache", max_number_of_caches, 0, NULL,
+						  0, edac_device_alloc_index());
+	if (!cpu_edac_dev) {
+		pr_warn("edac_device_alloc_ctl_info for cpu_edac_dev failed\n");
+		return -ENOMEM;
+	}
+
+	cpu_edac_dev->dev = dev;
+	cpu_edac_dev->ctl_name = "cpu_edac_dev";
+	cpu_edac_dev->dev_name = "ghes";
+	cpu_edac_dev->mod_name = "ghes_edac.c";
+	rc = edac_device_add_device(cpu_edac_dev);
+	if (rc) {
+		pr_warn("edac_device_add_device failed\n");
+		edac_device_free_ctl_info(cpu_edac_dev);
+		return rc;
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
+static void ghes_edac_create_cpu_device(struct device *dev)
+{
+	int cpu, i;
+	struct ghes_edac_cpu_block *block;
+	int number_of_caches;
+	struct acpi_cacheinfo cacheinfo[MAX_NUM_CACHES];
+
+	/* Find the maximum number of caches present in the cpu heirarchy among the CPUs */
+	for_each_possible_cpu(cpu) {
+		number_of_caches = acpi_find_cache_info(cpu, &cacheinfo[0], MAX_NUM_CACHES);
+		if (number_of_caches <= 0)
+			return;
+
+		if (max_number_of_caches < number_of_caches)
+			max_number_of_caches = number_of_caches;
+	}
+	if (!max_number_of_caches)
+		return;
+
+	/*
+	 * EDAC device interface supports creating the CPU hierarchy for all the CPUs
+	 * together. Thus need to allocate cpu_edac_block_list for the max_number_of_caches
+	 * among all the CPU hierarchy irrespective of the number of caches per CPU might vary.
+	 */
+	cpu_edac_block_list = vzalloc(num_possible_cpus() * max_number_of_caches *
+				      sizeof(*cpu_edac_block_list));
+	if (!cpu_edac_block_list)
+		return;
+
+	if (ghes_edac_add_cpu_device(dev))
+		goto error;
+
+	for_each_possible_cpu(cpu) {
+		memset(cacheinfo, 0, MAX_NUM_CACHES * sizeof(struct acpi_cacheinfo));
+		number_of_caches = acpi_find_cache_info(cpu, &cacheinfo[0], MAX_NUM_CACHES);
+		if (number_of_caches <= 0)
+			goto error;
+		/*
+		 * The edac cpu cache device blocks entries in the sysfs should match with the cpu
+		 * cache structure in the sysfs so that the affected cpus for a shared cache
+		 * can be easily extracted in the userspace.
+		 */
+		for (i = 0; i < number_of_caches; i++) {
+			block = cpu_edac_block_list + (cpu * max_number_of_caches) + i;
+			block->cpu = cpu;
+			block->level = cacheinfo[i].level;
+			block->type = cacheinfo[i].type;
+			block->block_nr = i;
+		}
+	}
+
+	return;
+
+error:
+	ghes_edac_delete_cpu_device();
+}
+#endif
+
 /*
  * Known systems that are safe to enable this module.
  */
@@ -624,6 +751,10 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	ghes_pvt = pvt;
 	spin_unlock_irqrestore(&ghes_lock, flags);
 
+#if defined(CONFIG_EDAC_GHES_CPU_ERROR)
+	ghes_edac_create_cpu_device(dev);
+#endif
+
 	/* only set on success */
 	refcount_set(&ghes_refcount, 1);
 
@@ -654,6 +785,10 @@ void ghes_edac_unregister(struct ghes *ghes)
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
index 34fb3431a8f3..a9098daf53d4 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -73,6 +73,24 @@ void ghes_unregister_vendor_record_notifier(struct notifier_block *nb);
 
 int ghes_estatus_pool_init(int num_ghes);
 
+/*
+ * struct ghes_einfo_cpu  - structure to pass cpu error info to the edac
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

