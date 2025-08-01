Return-Path: <linux-edac+bounces-4499-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA756B1867E
	for <lists+linux-edac@lfdr.de>; Fri,  1 Aug 2025 19:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F41E1AA1DCF
	for <lists+linux-edac@lfdr.de>; Fri,  1 Aug 2025 17:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F163E1E47A8;
	Fri,  1 Aug 2025 17:21:16 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1541F130A;
	Fri,  1 Aug 2025 17:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754068876; cv=none; b=K3QAwUOe4UBmBdnMOYvUDu9SlPQeMUJV86manKjBqkG8cn9oilTMiw8XZmQSgMXUCkC1zlJRRAyW2baU+PEPvGd+Es+Pr67pCBJk+MZGltOn9d1NGqK40BwKjBt7SRIforBonXwfb6K6PwLOvV1bqmeSpI/118HWSP38I+rkCrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754068876; c=relaxed/simple;
	bh=C1Syo13kVZVVT7NtwfvdmfvzSCo5Q4jRVF+F4cOA+QM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ioPvp8UhCfNjdfUPYSliYDQt03/s7xkp5Lu9DKcJE8uDs2AxZjV/Oavkn6Satvxm333CImJD7mXkhSOMvrQ1xw4TgctBsIqL4moh7VB/YhrGtLtOjTDx7jgNp4wvE2PePO6DHomlDghJDq/HZ2k48j+5WjDoN+5z+wxbexkcJ5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4btt0j136Sz6L4sn;
	Sat,  2 Aug 2025 01:16:53 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 43C2C1402EF;
	Sat,  2 Aug 2025 01:21:12 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.32.206) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Aug 2025 19:21:09 +0200
From: <shiju.jose@huawei.com>
To: <rafael@kernel.org>, <bp@alien8.de>, <akpm@linux-foundation.org>,
	<rppt@kernel.org>, <dferguson@amperecomputing.com>,
	<linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-doc@vger.kernel.org>, <tony.luck@intel.com>,
	<lenb@kernel.org>, <leo.duran@amd.com>, <Yazen.Ghannam@amd.com>,
	<mchehab@kernel.org>
CC: <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>,
	<rientjes@google.com>, <jiaqiyan@google.com>, <Jon.Grimm@amd.com>,
	<dave.hansen@linux.intel.com>, <naoya.horiguchi@nec.com>,
	<james.morse@arm.com>, <jthoughton@google.com>, <somasundaram.a@hpe.com>,
	<erdemaktas@google.com>, <pgonda@google.com>, <duenwen@google.com>,
	<gthelen@google.com>, <wschwartz@amperecomputing.com>,
	<wbs@os.amperecomputing.com>, <nifan.cxl@gmail.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <roberto.sassu@huawei.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
	<shiju.jose@huawei.com>
Subject: [PATCH v10 3/3] ras: mem: Add memory ACPI RAS2 driver
Date: Fri, 1 Aug 2025 18:20:29 +0100
Message-ID: <20250801172040.2175-4-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250801172040.2175-1-shiju.jose@huawei.com>
References: <20250801172040.2175-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Memory ACPI RAS2 auxiliary driver binds to the auxiliary device
add by the ACPI RAS2 table parser.

Driver uses a PCC subspace for communicating with the ACPI compliant
platform.

Device with ACPI RAS2 scrub feature registers with EDAC device driver,
which retrieves the scrub descriptor from EDAC scrub and exposes
the scrub control attributes for RAS2 scrub instance to userspace in
/sys/bus/edac/devices/acpi_ras_mem_id0/scrubX/.

According to the ACPI specification rev 6.5, section 5.2.21.1.1
RAS2 Platform Communication Channel Descriptor, “RAS2 supports multiple
PCC channels, where a channel is dedicated to a given component
instance.” However, a customer system was built non-compliant with the
specification and uses a single PCC channel for RAS2 scrubbers across all
NUMA domains. Workarounds have been implemented in the RAS2 drivers to
support systems that do not comply with the specification.
For systems that use a single PCC channel for RAS2 scrubbers across all
NUMA domains, the EDAC sysfs exposes scrub instances to userspace as
example,
/sys/bus/edac/devices/acpi_ras_mem_id0/scrub0
/sys/bus/edac/devices/acpi_ras_mem_id0/scrub1
/sys/bus/edac/devices/acpi_ras_mem_id0/scrub2
...

For systems that use an individual PCC channel per RAS2 scrubber in each
NUMA domain, the EDAC sysfs exposes scrub instances to userspace as
example,
/sys/bus/edac/devices/acpi_ras_mem_id0/scrub0
/sys/bus/edac/devices/acpi_ras_mem_id1/scrub0
/sys/bus/edac/devices/acpi_ras_mem_id2/scrub0
...

Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Tested-by: Daniel Ferguson <danielf@os.amperecomputing.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 Documentation/edac/scrub.rst |  79 ++++++
 drivers/ras/Kconfig          |  11 +
 drivers/ras/Makefile         |   1 +
 drivers/ras/acpi_ras2.c      | 464 +++++++++++++++++++++++++++++++++++
 include/acpi/ras2.h          |  14 ++
 5 files changed, 569 insertions(+)
 create mode 100644 drivers/ras/acpi_ras2.c

diff --git a/Documentation/edac/scrub.rst b/Documentation/edac/scrub.rst
index 2cfa74fa1ffd..d108cac64c61 100644
--- a/Documentation/edac/scrub.rst
+++ b/Documentation/edac/scrub.rst
@@ -340,3 +340,82 @@ controller or platform when unexpectedly high error rates are detected.
 
 Sysfs files for scrubbing are documented in
 `Documentation/ABI/testing/sysfs-edac-ecs`
+
+3. ACPI RAS2 Hardware-based Memory Scrubbing
+
+3.1. On demand scrubbing for a specific memory region.
+
+The EDAC sysfs attributes for RAS2 memory features are exposed in
+/sys/bus/edac/devices/acpi_ras_mem_idX/.
+Here, "acpi_ras_mem" indicates the ACPI RAS2 feature exposed is a feature
+of a memory system component associated with a NUMA domain, and "idX"
+corresponds to the index of RAS2 PCC channel used for PCC communication.
+
+3.1.1. Query the status of demand scrubbing
+
+Readback 'addr', non-zero - demand scrub is in progress, zero - scrub is finished.
+
+# cat /sys/bus/edac/devices/acpi_ras_mem_id0/scrub0/addr
+
+0
+
+3.1.2. Query what is device default/current scrub cycle setting.
+
+       Applicable to both on-demand and background scrubbing.
+
+# cat /sys/bus/edac/devices/acpi_ras_mem_id0/scrub0/current_cycle_duration
+
+36000
+
+3.1.3. Query the range of device supported scrub cycle for a memory region.
+
+# cat /sys/bus/edac/devices/acpi_ras_mem_id0/scrub0/min_cycle_duration
+
+3600
+
+# cat /sys/bus/edac/devices/acpi_ras_mem_id0/scrub0/max_cycle_duration
+
+86400
+
+3.1.4. Program scrubbing for the memory region in RAS2 device to repeat every
+43200 seconds (half a day).
+
+# echo 43200 > /sys/bus/edac/devices/acpi_ras_mem_id0/scrub0/current_cycle_duration
+
+3.1.5. Program address and size of the memory region to scrub
+
+Write 'size' of the memory region to scrub.
+
+# echo 0x3000000 > /sys/bus/edac/devices/acpi_ras_mem_id0/scrub0/size
+
+Write 'addr' starts demand scrubbing, please make sure other attributes are
+set prior to that.
+
+# echo 0x42000000 > /sys/bus/edac/devices/acpi_ras_mem_id0/scrub0/addr
+
+Readback 'addr', non-zero - demand scrub is in progress, zero - scrub is finished.
+
+# cat /sys/bus/edac/devices/acpi_ras_mem_id0/scrub0/addr
+
+0x42000000
+
+# cat /sys/bus/edac/devices/acpi_ras_mem_id0/scrub0/addr
+
+0
+
+3.2. Background scrubbing the entire memory
+
+3.2.1. Query the status of background scrubbing.
+
+# cat /sys/bus/edac/devices/acpi_ras_mem_id0/scrub0/enable_background
+
+0
+
+3.2.2. Program background scrubbing for RAS2 device to repeat in every 21600
+seconds (quarter of a day).
+
+# echo 21600 > /sys/bus/edac/devices/acpi_ras_mem_id0/scrub0/current_cycle_duration
+
+3.2.3. Start 'background scrubbing'.
+
+# echo 1 > /sys/bus/edac/devices/acpi_ras_mem_id0/scrub0/enable_background
diff --git a/drivers/ras/Kconfig b/drivers/ras/Kconfig
index fc4f4bb94a4c..a88002f1f462 100644
--- a/drivers/ras/Kconfig
+++ b/drivers/ras/Kconfig
@@ -46,4 +46,15 @@ config RAS_FMPM
 	  Memory will be retired during boot time and run time depending on
 	  platform-specific policies.
 
+config MEM_ACPI_RAS2
+	tristate "Memory ACPI RAS2 driver"
+	depends on ACPI_RAS2
+	depends on EDAC
+	depends on EDAC_SCRUB
+	help
+	  The driver binds to the platform device added by the ACPI RAS2
+	  table parser. Use a PCC channel subspace for communicating with
+	  the ACPI compliant platform to provide control of memory scrub
+	  parameters to the user via the EDAC scrub.
+
 endif
diff --git a/drivers/ras/Makefile b/drivers/ras/Makefile
index 11f95d59d397..a0e6e903d6b0 100644
--- a/drivers/ras/Makefile
+++ b/drivers/ras/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_RAS)	+= ras.o
 obj-$(CONFIG_DEBUG_FS)	+= debugfs.o
 obj-$(CONFIG_RAS_CEC)	+= cec.o
+obj-$(CONFIG_MEM_ACPI_RAS2)	+= acpi_ras2.o
 
 obj-$(CONFIG_RAS_FMPM)	+= amd/fmpm.o
 obj-y			+= amd/atl/
diff --git a/drivers/ras/acpi_ras2.c b/drivers/ras/acpi_ras2.c
new file mode 100644
index 000000000000..d5f8901be251
--- /dev/null
+++ b/drivers/ras/acpi_ras2.c
@@ -0,0 +1,464 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * ACPI RAS2 memory driver
+ *
+ * Copyright (c) 2024-2025 HiSilicon Limited.
+ *
+ */
+
+#define pr_fmt(fmt)	"ACPI RAS2 MEMORY: " fmt
+
+#include <linux/bitfield.h>
+#include <linux/edac.h>
+#include <linux/platform_device.h>
+#include <acpi/ras2.h>
+
+#define RAS2_SUPPORT_HW_PARTOL_SCRUB BIT(0)
+#define RAS2_TYPE_PATROL_SCRUB 0x0000
+
+#define RAS2_GET_PATROL_PARAMETERS 0x01
+#define RAS2_START_PATROL_SCRUBBER 0x02
+#define RAS2_STOP_PATROL_SCRUBBER 0x03
+
+/*
+ * RAS2 patrol scrub
+ */
+#define RAS2_PS_SC_HRS_IN_MASK GENMASK(15, 8)
+#define RAS2_PS_EN_BACKGROUND BIT(0)
+#define RAS2_PS_SC_HRS_OUT_MASK GENMASK(7, 0)
+#define RAS2_PS_MIN_SC_HRS_OUT_MASK GENMASK(15, 8)
+#define RAS2_PS_MAX_SC_HRS_OUT_MASK GENMASK(23, 16)
+#define RAS2_PS_FLAG_SCRUB_RUNNING BIT(0)
+
+#define RAS2_SCRUB_NAME_LEN 128
+#define RAS2_HOUR_IN_SECS 3600
+
+#define TO_RAS2_MEM_CTX(_pxm_domain, inst)	\
+	((struct ras2_mem_ctx *)((u64)(_pxm_domain) - \
+				((u64)((inst) * (u64)sizeof(struct ras2_pxm_domain)) \
+				 + (u64)sizeof(struct ras2_mem_ctx_hdr))))
+
+enum ras2_od_scrub_status {
+	OD_SCRUB_STS_IDLE,
+	OD_SCRUB_STS_INIT,
+	OD_SCRUB_STS_ACTIVE,
+};
+
+struct acpi_ras2_ps_shared_mem {
+	struct acpi_ras2_shmem common;
+	struct acpi_ras2_patrol_scrub_param params;
+};
+
+#define TO_ACPI_RAS2_PS_SHMEM(_addr) \
+	container_of(_addr, struct acpi_ras2_ps_shared_mem, common)
+
+static int ras2_is_patrol_scrub_support(struct ras2_mem_ctx_hdr *ras2_ctx_hdr)
+{
+	struct acpi_ras2_shmem __iomem *common = (void *)ras2_ctx_hdr->comm_addr;
+
+	guard(mutex)(ras2_ctx_hdr->pcc_lock);
+	common->set_caps[0] = 0;
+
+	return common->features[0] & RAS2_SUPPORT_HW_PARTOL_SCRUB;
+}
+
+static int ras2_update_patrol_scrub_params_cache(struct ras2_mem_ctx *ras2_ctx,
+						 u16 pxm_inst)
+{
+	struct ras2_pxm_domain *pxm_domain = &ras2_ctx->pxm_domains[pxm_inst];
+	struct acpi_ras2_ps_shared_mem __iomem *ps_sm =
+		TO_ACPI_RAS2_PS_SHMEM(ras2_ctx->hdr.comm_addr);
+	int ret;
+
+	ps_sm->common.set_caps[0] = RAS2_SUPPORT_HW_PARTOL_SCRUB;
+	ps_sm->params.command = RAS2_GET_PATROL_PARAMETERS;
+	ps_sm->params.req_addr_range[0] = pxm_domain->mem_base_addr;
+	ps_sm->params.req_addr_range[1] = pxm_domain->mem_size;
+	ret = ras2_send_pcc_cmd(ras2_ctx, PCC_CMD_EXEC_RAS2);
+	if (ret) {
+		dev_err(ras2_ctx->hdr.dev, "failed to read parameters\n");
+		return ret;
+	}
+
+	pxm_domain->min_scrub_cycle = FIELD_GET(RAS2_PS_MIN_SC_HRS_OUT_MASK,
+						ps_sm->params.scrub_params_out);
+	pxm_domain->max_scrub_cycle = FIELD_GET(RAS2_PS_MAX_SC_HRS_OUT_MASK,
+						ps_sm->params.scrub_params_out);
+	pxm_domain->scrub_cycle_hrs = FIELD_GET(RAS2_PS_SC_HRS_OUT_MASK,
+						ps_sm->params.scrub_params_out);
+	if (pxm_domain->bg_scrub) {
+		pxm_domain->base = 0;
+		pxm_domain->size = 0;
+		pxm_domain->od_scrub_sts = OD_SCRUB_STS_IDLE;
+		return 0;
+	}
+
+	if  (ps_sm->params.flags & RAS2_PS_FLAG_SCRUB_RUNNING) {
+		pxm_domain->base = ps_sm->params.actl_addr_range[0];
+		pxm_domain->size = ps_sm->params.actl_addr_range[1];
+	} else if (pxm_domain->od_scrub_sts != OD_SCRUB_STS_INIT) {
+		/*
+		 * When demand scrubbing is finished driver resets actual
+		 * address range to 0 when readback. Otherwise userspace
+		 * assumes demand scrubbing is in progress.
+		 */
+		pxm_domain->base = 0;
+		pxm_domain->size = 0;
+		pxm_domain->od_scrub_sts = OD_SCRUB_STS_IDLE;
+	}
+
+	return 0;
+}
+
+/* Context - PCC lock must be held */
+static int ras2_get_patrol_scrub_running(struct ras2_mem_ctx *ras2_ctx,
+					 u16 pxm_inst, bool *running)
+{
+	struct ras2_pxm_domain *pxm_domain = &ras2_ctx->pxm_domains[pxm_inst];
+	struct acpi_ras2_ps_shared_mem __iomem *ps_sm =
+		TO_ACPI_RAS2_PS_SHMEM(ras2_ctx->hdr.comm_addr);
+	int ret;
+
+	ps_sm->common.set_caps[0] = RAS2_SUPPORT_HW_PARTOL_SCRUB;
+	ps_sm->params.command = RAS2_GET_PATROL_PARAMETERS;
+	ps_sm->params.req_addr_range[0] = pxm_domain->mem_base_addr;
+	ps_sm->params.req_addr_range[1] = pxm_domain->mem_size;
+
+	ret = ras2_send_pcc_cmd(ras2_ctx, PCC_CMD_EXEC_RAS2);
+	if (ret) {
+		dev_err(ras2_ctx->hdr.dev, "failed to read parameters\n");
+		return ret;
+	}
+
+	*running = ps_sm->params.flags & RAS2_PS_FLAG_SCRUB_RUNNING;
+
+	return 0;
+}
+
+static int ras2_hw_scrub_read_min_scrub_cycle(struct device *dev, void *drv_data,
+					      u32 *min)
+{
+	struct ras2_pxm_domain *pxm_domain = drv_data;
+
+	*min = pxm_domain->min_scrub_cycle * RAS2_HOUR_IN_SECS;
+
+	return 0;
+}
+
+static int ras2_hw_scrub_read_max_scrub_cycle(struct device *dev, void *drv_data,
+					      u32 *max)
+{
+	struct ras2_pxm_domain *pxm_domain = drv_data;
+
+	*max = pxm_domain->max_scrub_cycle * RAS2_HOUR_IN_SECS;
+
+	return 0;
+}
+
+static int ras2_hw_scrub_cycle_read(struct device *dev, void *drv_data,
+				    u32 *scrub_cycle_secs)
+{
+	struct ras2_pxm_domain *pxm_domain = drv_data;
+
+	*scrub_cycle_secs = pxm_domain->scrub_cycle_hrs * RAS2_HOUR_IN_SECS;
+
+	return 0;
+}
+
+static int ras2_hw_scrub_cycle_write(struct device *dev, void *drv_data,
+				     u32 scrub_cycle_secs)
+{
+	u8 scrub_cycle_hrs = scrub_cycle_secs / RAS2_HOUR_IN_SECS;
+	struct ras2_pxm_domain *pxm_domain = drv_data;
+	struct ras2_mem_ctx *ras2_ctx = TO_RAS2_MEM_CTX(pxm_domain,
+							pxm_domain->feat_instance);
+	bool running;
+	int ret;
+
+	guard(mutex)(ras2_ctx->hdr.pcc_lock);
+	ret = ras2_get_patrol_scrub_running(ras2_ctx, pxm_domain->feat_instance,
+					    &running);
+	if (ret)
+		return ret;
+
+	if (running)
+		return -EBUSY;
+
+	if (scrub_cycle_hrs < pxm_domain->min_scrub_cycle ||
+	    scrub_cycle_hrs > pxm_domain->max_scrub_cycle)
+		return -EINVAL;
+
+	pxm_domain->scrub_cycle_hrs = scrub_cycle_hrs;
+
+	return 0;
+}
+
+static int ras2_hw_scrub_read_addr(struct device *dev, void *drv_data, u64 *base)
+{
+	struct ras2_pxm_domain *pxm_domain = drv_data;
+	struct ras2_mem_ctx *ras2_ctx = TO_RAS2_MEM_CTX(pxm_domain,
+							pxm_domain->feat_instance);
+	int ret;
+
+	/*
+	 * When BG scrubbing is enabled the actual address range is not valid.
+	 * Return -EBUSY now unless find out a method to retrieve actual
+	 * full PA range.
+	 */
+	if (pxm_domain->bg_scrub)
+		return -EBUSY;
+
+	ret = ras2_update_patrol_scrub_params_cache(ras2_ctx,
+						    pxm_domain->feat_instance);
+	if (ret)
+		return ret;
+
+	*base = pxm_domain->base;
+
+	return 0;
+}
+
+static int ras2_hw_scrub_read_size(struct device *dev, void *drv_data, u64 *size)
+{
+	struct ras2_pxm_domain *pxm_domain = drv_data;
+	struct ras2_mem_ctx *ras2_ctx = TO_RAS2_MEM_CTX(pxm_domain,
+							pxm_domain->feat_instance);
+	int ret;
+
+	if (pxm_domain->bg_scrub)
+		return -EBUSY;
+
+	ret = ras2_update_patrol_scrub_params_cache(ras2_ctx,
+						    pxm_domain->feat_instance);
+	if (ret)
+		return ret;
+
+	*size = pxm_domain->size;
+
+	return 0;
+}
+
+static int ras2_hw_scrub_write_addr(struct device *dev, void *drv_data, u64 base)
+{
+	struct ras2_pxm_domain *pxm_domain = drv_data;
+	struct ras2_mem_ctx *ras2_ctx = TO_RAS2_MEM_CTX(pxm_domain,
+							pxm_domain->feat_instance);
+	struct ras2_mem_ctx_hdr *ras2_ctx_hdr = &ras2_ctx->hdr;
+	struct acpi_ras2_ps_shared_mem __iomem *ps_sm =
+		TO_ACPI_RAS2_PS_SHMEM(ras2_ctx_hdr->comm_addr);
+	bool running;
+	int ret;
+
+	if (pxm_domain->bg_scrub)
+		return -EBUSY;
+
+	guard(mutex)(ras2_ctx_hdr->pcc_lock);
+	ps_sm->common.set_caps[0] = RAS2_SUPPORT_HW_PARTOL_SCRUB;
+
+	if (!pxm_domain->size || pxm_domain->size > pxm_domain->mem_size ||
+	    base < pxm_domain->mem_base_addr ||
+	    (base + pxm_domain->size) >
+		(pxm_domain->mem_base_addr + pxm_domain->mem_size)) {
+		dev_warn(dev,
+			 "%s: Invalid address range, base=0x%llx size=0x%llx\n",
+			 __func__, base, pxm_domain->size);
+		pxm_domain->size = 0;
+		return -ERANGE;
+	}
+
+	ret = ras2_get_patrol_scrub_running(ras2_ctx, pxm_domain->feat_instance,
+					    &running);
+	if (ret)
+		return ret;
+
+	if (running)
+		return -EBUSY;
+
+	pxm_domain->base = base;
+	ps_sm->params.scrub_params_in &= ~RAS2_PS_SC_HRS_IN_MASK;
+	ps_sm->params.scrub_params_in |= FIELD_PREP(RAS2_PS_SC_HRS_IN_MASK,
+						    pxm_domain->scrub_cycle_hrs);
+	ps_sm->params.req_addr_range[0] = pxm_domain->base;
+	ps_sm->params.req_addr_range[1] = pxm_domain->size;
+	ps_sm->params.scrub_params_in &= ~RAS2_PS_EN_BACKGROUND;
+	ps_sm->params.command = RAS2_START_PATROL_SCRUBBER;
+
+	ret = ras2_send_pcc_cmd(ras2_ctx, PCC_CMD_EXEC_RAS2);
+	if (ret) {
+		dev_err(dev, "Failed to start demand scrubbing rc(%d)\n", ret);
+		if (ret != -EBUSY) {
+			pxm_domain->base = 0;
+			pxm_domain->size = 0;
+			pxm_domain->od_scrub_sts = OD_SCRUB_STS_IDLE;
+		}
+		return ret;
+	}
+	pxm_domain->od_scrub_sts = OD_SCRUB_STS_ACTIVE;
+
+	return ras2_update_patrol_scrub_params_cache(ras2_ctx,
+						     pxm_domain->feat_instance);
+}
+
+static int ras2_hw_scrub_write_size(struct device *dev, void *drv_data, u64 size)
+{
+	struct ras2_pxm_domain *pxm_domain = drv_data;
+	struct ras2_mem_ctx *ras2_ctx = TO_RAS2_MEM_CTX(pxm_domain,
+							pxm_domain->feat_instance);
+	bool running;
+	int ret;
+
+	if (!size) {
+		dev_warn(dev, "%s: Invalid address range size=0x%llx\n",
+			 __func__, size);
+		return -EINVAL;
+	}
+
+	if (pxm_domain->bg_scrub)
+		return -EBUSY;
+
+	guard(mutex)(ras2_ctx->hdr.pcc_lock);
+	ret = ras2_get_patrol_scrub_running(ras2_ctx, pxm_domain->feat_instance,
+					    &running);
+	if (ret)
+		return ret;
+
+	if (running)
+		return -EBUSY;
+
+	pxm_domain->size = size;
+	pxm_domain->od_scrub_sts = OD_SCRUB_STS_INIT;
+
+	return 0;
+}
+
+static int ras2_hw_scrub_set_enabled_bg(struct device *dev, void *drv_data, bool enable)
+{
+	struct ras2_pxm_domain *pxm_domain = drv_data;
+	struct ras2_mem_ctx *ras2_ctx = TO_RAS2_MEM_CTX(pxm_domain,
+							pxm_domain->feat_instance);
+	struct ras2_mem_ctx_hdr *ras2_ctx_hdr = &ras2_ctx->hdr;
+	struct acpi_ras2_ps_shared_mem __iomem *ps_sm =
+		TO_ACPI_RAS2_PS_SHMEM(ras2_ctx_hdr->comm_addr);
+	bool running;
+	int ret;
+
+	guard(mutex)(ras2_ctx_hdr->pcc_lock);
+	ps_sm->common.set_caps[0] = RAS2_SUPPORT_HW_PARTOL_SCRUB;
+	ret = ras2_get_patrol_scrub_running(ras2_ctx, pxm_domain->feat_instance,
+					    &running);
+	if (ret)
+		return ret;
+
+	if (enable) {
+		if (pxm_domain->bg_scrub || running)
+			return -EBUSY;
+		ps_sm->params.req_addr_range[0] = 0;
+		ps_sm->params.req_addr_range[1] = 0;
+		ps_sm->params.scrub_params_in &= ~RAS2_PS_SC_HRS_IN_MASK;
+		ps_sm->params.scrub_params_in |= FIELD_PREP(RAS2_PS_SC_HRS_IN_MASK,
+							    pxm_domain->scrub_cycle_hrs);
+		ps_sm->params.command = RAS2_START_PATROL_SCRUBBER;
+	} else {
+		if (!pxm_domain->bg_scrub)
+			return -EPERM;
+		ps_sm->params.command = RAS2_STOP_PATROL_SCRUBBER;
+	}
+
+	ps_sm->params.scrub_params_in &= ~RAS2_PS_EN_BACKGROUND;
+	ps_sm->params.scrub_params_in |= FIELD_PREP(RAS2_PS_EN_BACKGROUND,
+						    enable);
+	ret = ras2_send_pcc_cmd(ras2_ctx, PCC_CMD_EXEC_RAS2);
+	if (ret) {
+		dev_err(dev, "Failed to %s background scrubbing\n",
+			str_enable_disable(enable));
+		return ret;
+	}
+
+	if (enable) {
+		pxm_domain->bg_scrub = true;
+		/* Update the cache to account for rounding of supplied parameters and similar */
+		ret = ras2_update_patrol_scrub_params_cache(ras2_ctx,
+							    pxm_domain->feat_instance);
+	} else {
+		ret = ras2_update_patrol_scrub_params_cache(ras2_ctx,
+							    pxm_domain->feat_instance);
+		pxm_domain->bg_scrub = false;
+	}
+
+	return ret;
+}
+
+static int ras2_hw_scrub_get_enabled_bg(struct device *dev, void *drv_data, bool *enabled)
+{
+	struct ras2_pxm_domain *pxm_domain = drv_data;
+
+	*enabled = pxm_domain->bg_scrub;
+
+	return 0;
+}
+
+static const struct edac_scrub_ops ras2_scrub_ops = {
+	.read_addr = ras2_hw_scrub_read_addr,
+	.read_size = ras2_hw_scrub_read_size,
+	.write_addr = ras2_hw_scrub_write_addr,
+	.write_size = ras2_hw_scrub_write_size,
+	.get_enabled_bg = ras2_hw_scrub_get_enabled_bg,
+	.set_enabled_bg = ras2_hw_scrub_set_enabled_bg,
+	.get_min_cycle = ras2_hw_scrub_read_min_scrub_cycle,
+	.get_max_cycle = ras2_hw_scrub_read_max_scrub_cycle,
+	.get_cycle_duration = ras2_hw_scrub_cycle_read,
+	.set_cycle_duration = ras2_hw_scrub_cycle_write,
+};
+
+static int ras2_probe(struct auxiliary_device *auxdev,
+		      const struct auxiliary_device_id *id)
+{
+	struct ras2_mem_ctx_hdr *ras2_ctx_hdr = container_of(auxdev, struct ras2_mem_ctx_hdr, adev);
+	struct ras2_mem_ctx *ras2_ctx = container_of(ras2_ctx_hdr, struct ras2_mem_ctx, hdr);
+	struct edac_dev_feature *ras_features;
+	char scrub_name[RAS2_SCRUB_NAME_LEN];
+	u16 i;
+	int ret;
+
+	if (!ras2_is_patrol_scrub_support(ras2_ctx_hdr))
+		return -EOPNOTSUPP;
+
+	sprintf(scrub_name, "acpi_ras_mem_id%d", ras2_ctx_hdr->id);
+
+	ras_features = kzalloc(ras2_ctx_hdr->num_pxm_domains *
+			       sizeof(*ras_features), GFP_KERNEL);
+	if (!ras_features)
+		return -ENOMEM;
+
+	for (i = 0; i < ras2_ctx_hdr->num_pxm_domains; i++) {
+		ras_features[i].ft_type	= RAS_FEAT_SCRUB;
+		ras_features[i].instance = i;
+		ras_features[i].scrub_ops = &ras2_scrub_ops;
+		ras_features[i].ctx = &ras2_ctx->pxm_domains[i];
+		ret = ras2_update_patrol_scrub_params_cache(ras2_ctx, i);
+		if (ret)
+			return ret;
+	}
+
+	return edac_dev_register(&auxdev->dev, scrub_name, NULL,
+				 ras2_ctx_hdr->num_pxm_domains,
+				 ras_features);
+}
+
+static const struct auxiliary_device_id ras2_mem_dev_id_table[] = {
+	{ .name = RAS2_AUX_DEV_NAME "." RAS2_MEM_DEV_ID_NAME, },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(auxiliary, ras2_mem_dev_id_table);
+
+static struct auxiliary_driver ras2_mem_driver = {
+	.name = RAS2_MEM_DEV_ID_NAME,
+	.probe = ras2_probe,
+	.id_table = ras2_mem_dev_id_table,
+};
+module_auxiliary_driver(ras2_mem_driver);
+
+MODULE_IMPORT_NS("ACPI_RAS2");
+MODULE_DESCRIPTION("ACPI RAS2 memory driver");
+MODULE_LICENSE("GPL");
diff --git a/include/acpi/ras2.h b/include/acpi/ras2.h
index fc4d5ee64dad..76f047d93aaf 100644
--- a/include/acpi/ras2.h
+++ b/include/acpi/ras2.h
@@ -36,12 +36,26 @@ struct device;
  *			of the memory associated with the NUMA domain
  * @mem_size		Size of the lowest physical continuous memory range
  *			of the memory associated with the NUMA domain
+ * @base:		Base address of the memory region to scrub
+ * @size:		Size of the memory region to scrub
+ * @scrub_cycle_hrs:	Current scrub rate in hours
+ * @min_scrub_cycle:	Minimum scrub rate supported
+ * @max_scrub_cycle:	Maximum scrub rate supported
+ * @od_scrub_sts:	Status of demand scrubbing (memory region)
+ * @bg_scrub:		Status of background patrol scrubbing
  */
 struct ras2_pxm_domain {
 	u32	sys_comp_nid;
 	u8	feat_instance;
 	u64	mem_base_addr;
 	u64	mem_size;
+	u64	base;
+	u64	size;
+	u8	scrub_cycle_hrs;
+	u8	min_scrub_cycle;
+	u8	max_scrub_cycle;
+	u8	od_scrub_sts;
+	bool	bg_scrub;
 };
 
 /**
-- 
2.43.0


