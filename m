Return-Path: <linux-edac+bounces-3274-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE52A50812
	for <lists+linux-edac@lfdr.de>; Wed,  5 Mar 2025 19:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4789B1894236
	for <lists+linux-edac@lfdr.de>; Wed,  5 Mar 2025 18:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D9825334A;
	Wed,  5 Mar 2025 18:03:07 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10071253335;
	Wed,  5 Mar 2025 18:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197787; cv=none; b=S2bX78TZc7vu1Vy4x3DXktyRv4r9lc0Vzt+HOaAEKP3DRHyVWr4vp2WWV1fYJAnJxPK/09zdAQsC89V0UNoWxNyTCfvHBkDR/h8sROIXosOxpf5Yc8QmqUU99Aw/zvstVgzGPHkhlfGzmuu1GsRUI6tvCDF68G0I5zMZjFCULfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197787; c=relaxed/simple;
	bh=UDPInAg9JFnYLfRjh8WZE8y03Go2lzAjJ/UmHCUjPjY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hUccHOrW8TNjhe1gy2gTIOAqZf1hx6QAdKeg8KfipuOBlLbV4S1VjS4p5N7Ip4g11cl/RghTb31nyb80KqTUru3rSSDYnf1tUR9C4bc0sEUNPc6xSPsVYrXJwNN7YG/2ZucoQ/WaAjtJPjhpk5g6Cu5fHnngiBaSSzmgqEIvH3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z7Kzz5RN4z6L57s;
	Thu,  6 Mar 2025 01:58:55 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id B7660140CB1;
	Thu,  6 Mar 2025 02:03:02 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.145.140) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Mar 2025 19:03:00 +0100
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<bp@alien8.de>, <tony.luck@intel.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <mchehab@kernel.org>, <leo.duran@amd.com>,
	<Yazen.Ghannam@amd.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <david@redhat.com>, <Vilas.Sridharan@amd.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <rientjes@google.com>,
	<jiaqiyan@google.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<naoya.horiguchi@nec.com>, <james.morse@arm.com>, <jthoughton@google.com>,
	<somasundaram.a@hpe.com>, <erdemaktas@google.com>, <pgonda@google.com>,
	<duenwen@google.com>, <gthelen@google.com>, <wschwartz@amperecomputing.com>,
	<dferguson@amperecomputing.com>, <wbs@os.amperecomputing.com>,
	<nifan.cxl@gmail.com>, <yazen.ghannam@amd.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <roberto.sassu@huawei.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v2 3/3] ras: mem: Add memory ACPI RAS2 driver
Date: Wed, 5 Mar 2025 18:02:24 +0000
Message-ID: <20250305180225.1226-4-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250305180225.1226-1-shiju.jose@huawei.com>
References: <20250305180225.1226-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Memory ACPI RAS2 auxiliary driver binds to the auxiliary device
add by the ACPI RAS2 table parser.

Driver uses a PCC subspace for communicating with the ACPI compliant
platform.

Device with ACPI RAS2 scrub feature registers with EDAC device driver,
which retrieves the scrub descriptor from EDAC scrub and exposes
the scrub control attributes for RAS2 scrub instance to userspace in
/sys/bus/edac/devices/acpi_ras_mem0/scrubX/.

Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Tested-by: Daniel Ferguson <danielf@os.amperecomputing.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 Documentation/edac/scrub.rst |  73 +++++++
 drivers/ras/Kconfig          |  11 +
 drivers/ras/Makefile         |   1 +
 drivers/ras/acpi_ras2.c      | 391 +++++++++++++++++++++++++++++++++++
 include/acpi/ras2.h          |   6 +
 5 files changed, 482 insertions(+)
 create mode 100644 drivers/ras/acpi_ras2.c

diff --git a/Documentation/edac/scrub.rst b/Documentation/edac/scrub.rst
index daab929cdba1..fc8dcbd13f91 100644
--- a/Documentation/edac/scrub.rst
+++ b/Documentation/edac/scrub.rst
@@ -264,3 +264,76 @@ Sysfs files are documented in
 `Documentation/ABI/testing/sysfs-edac-scrub`
 
 `Documentation/ABI/testing/sysfs-edac-ecs`
+
+Examples
+--------
+
+The usage takes the form shown in these examples:
+
+1. ACPI RAS2
+
+1.1 On demand scrubbing for a specific memory region.
+
+1.1.1. Query what is device default/current scrub cycle setting.
+
+       Applicable to both on-demand and background scrubbing.
+
+# cat /sys/bus/edac/devices/acpi_ras_mem0/scrub0/current_cycle_duration
+
+36000
+
+1.1.2 Query the range of device supported scrub cycle for a memory region.
+
+# cat /sys/bus/edac/devices/acpi_ras_mem0/scrub0/min_cycle_duration
+
+3600
+
+# cat /sys/bus/edac/devices/acpi_ras_mem0/scrub0/max_cycle_duration
+
+86400
+
+1.1.3. Program scrubbing for the memory region in RAS2 device to repeat every 43200 seconds (half a day).
+
+# echo 43200 > /sys/bus/edac/devices/acpi_ras_mem0/scrub0/current_cycle_duration
+
+1.1.4. Program address and size of the memory region to scrub
+
+Readback 'addr', non-zero - demand scrub is in progress, zero - scrub is finished.
+
+# cat /sys/bus/edac/devices/acpi_ras_mem0/scrub0/addr
+
+0
+
+Write 'size' of the memory region to scrub.
+
+# echo 0x300000 > /sys/bus/edac/devices/acpi_ras_mem0/scrub0/size
+
+Write 'addr' starts demand scrubbing, please make sure other attributes are set prior to that.
+
+# echo 0x200000 > /sys/bus/edac/devices/acpi_ras_mem0/scrub0/addr
+
+Readback 'addr', non-zero - demand scrub is in progress, zero - scrub is finished.
+
+# cat /sys/bus/edac/devices/acpi_ras_mem0/scrub0/addr
+
+0x200000
+
+# cat /sys/bus/edac/devices/acpi_ras_mem0/scrub0/addr
+
+0
+
+1.2 Background scrubbing the entire memory
+
+1.2.3 Query the status of background scrubbing.
+
+# cat /sys/bus/edac/devices/acpi_ras_mem0/scrub0/enable_background
+
+0
+
+1.2.4. Program background scrubbing for RAS2 device to repeat in every 21600 seconds (quarter of a day).
+
+# echo 21600 > /sys/bus/edac/devices/acpi_ras_mem0/scrub0/current_cycle_duration
+
+1.2.5. Start 'background scrubbing'.
+
+# echo 1 > /sys/bus/edac/devices/acpi_ras_mem0/scrub0/enable_background
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
index 000000000000..2f9317aa7b81
--- /dev/null
+++ b/drivers/ras/acpi_ras2.c
@@ -0,0 +1,391 @@
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
+#define RAS2_DEV_NUM_RAS_FEATURES	1
+
+#define RAS2_SUPPORT_HW_PARTOL_SCRUB	BIT(0)
+#define RAS2_TYPE_PATROL_SCRUB	0x0000
+
+#define RAS2_GET_PATROL_PARAMETERS	0x01
+#define RAS2_START_PATROL_SCRUBBER	0x02
+#define RAS2_STOP_PATROL_SCRUBBER	0x03
+
+/*
+ * RAS2 patrol scrub
+ */
+#define RAS2_PS_SC_HRS_IN_MASK	GENMASK(15, 8)
+#define RAS2_PS_EN_BACKGROUND	BIT(0)
+#define RAS2_PS_SC_HRS_OUT_MASK	GENMASK(7, 0)
+#define RAS2_PS_MIN_SC_HRS_OUT_MASK	GENMASK(15, 8)
+#define RAS2_PS_MAX_SC_HRS_OUT_MASK	GENMASK(23, 16)
+#define RAS2_PS_FLAG_SCRUB_RUNNING	BIT(0)
+
+#define RAS2_SCRUB_NAME_LEN      128
+#define RAS2_HOUR_IN_SECS    3600
+
+struct acpi_ras2_ps_shared_mem {
+	struct acpi_ras2_shmem common;
+	struct acpi_ras2_patrol_scrub_param params;
+};
+
+static int ras2_is_patrol_scrub_support(struct ras2_mem_ctx *ras2_ctx)
+{
+	struct acpi_ras2_shmem __iomem *common = (void *)ras2_ctx->comm_addr;
+
+	guard(mutex)(&ras2_ctx->lock);
+	common->set_caps[0] = 0;
+
+	return common->features[0] & RAS2_SUPPORT_HW_PARTOL_SCRUB;
+}
+
+static int ras2_update_patrol_scrub_params_cache(struct ras2_mem_ctx *ras2_ctx)
+{
+	struct acpi_ras2_ps_shared_mem __iomem *ps_sm =
+		(void *)ras2_ctx->comm_addr;
+	int ret;
+
+	ps_sm->common.set_caps[0] = RAS2_SUPPORT_HW_PARTOL_SCRUB;
+	ps_sm->params.cmd = RAS2_GET_PATROL_PARAMETERS;
+
+	ret = ras2_send_pcc_cmd(ras2_ctx, RAS2_PCC_CMD_EXEC);
+	if (ret) {
+		dev_err(ras2_ctx->dev, "failed to read parameters\n");
+		return ret;
+	}
+
+	ras2_ctx->min_scrub_cycle = FIELD_GET(RAS2_PS_MIN_SC_HRS_OUT_MASK,
+					      ps_sm->params.scrub_params_out);
+	ras2_ctx->max_scrub_cycle = FIELD_GET(RAS2_PS_MAX_SC_HRS_OUT_MASK,
+					      ps_sm->params.scrub_params_out);
+	if (!ras2_ctx->bg_scrub) {
+		ras2_ctx->base = ps_sm->params.actl_addr_range[0];
+		ras2_ctx->size = ps_sm->params.actl_addr_range[1];
+	}
+
+	ras2_ctx->scrub_cycle_hrs = FIELD_GET(RAS2_PS_SC_HRS_OUT_MASK,
+					      ps_sm->params.scrub_params_out);
+
+	return 0;
+}
+
+/* Context - lock must be held */
+static int ras2_get_patrol_scrub_running(struct ras2_mem_ctx *ras2_ctx,
+					 bool *running)
+{
+	struct acpi_ras2_ps_shared_mem __iomem *ps_sm =
+		(void *)ras2_ctx->comm_addr;
+	int ret;
+
+	ps_sm->common.set_caps[0] = RAS2_SUPPORT_HW_PARTOL_SCRUB;
+	ps_sm->params.cmd = RAS2_GET_PATROL_PARAMETERS;
+
+	ret = ras2_send_pcc_cmd(ras2_ctx, RAS2_PCC_CMD_EXEC);
+	if (ret) {
+		dev_err(ras2_ctx->dev, "failed to read parameters\n");
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
+	struct ras2_mem_ctx *ras2_ctx = drv_data;
+
+	*min = ras2_ctx->min_scrub_cycle * RAS2_HOUR_IN_SECS;
+
+	return 0;
+}
+
+static int ras2_hw_scrub_read_max_scrub_cycle(struct device *dev, void *drv_data,
+					      u32 *max)
+{
+	struct ras2_mem_ctx *ras2_ctx = drv_data;
+
+	*max = ras2_ctx->max_scrub_cycle * RAS2_HOUR_IN_SECS;
+
+	return 0;
+}
+
+static int ras2_hw_scrub_cycle_read(struct device *dev, void *drv_data,
+				    u32 *scrub_cycle_secs)
+{
+	struct ras2_mem_ctx *ras2_ctx = drv_data;
+
+	*scrub_cycle_secs = ras2_ctx->scrub_cycle_hrs * RAS2_HOUR_IN_SECS;
+
+	return 0;
+}
+
+static int ras2_hw_scrub_cycle_write(struct device *dev, void *drv_data,
+				     u32 scrub_cycle_secs)
+{
+	u8 scrub_cycle_hrs = scrub_cycle_secs / RAS2_HOUR_IN_SECS;
+	struct ras2_mem_ctx *ras2_ctx = drv_data;
+	bool running;
+	int ret;
+
+	guard(mutex)(&ras2_ctx->lock);
+	ret = ras2_get_patrol_scrub_running(ras2_ctx, &running);
+	if (ret)
+		return ret;
+
+	if (running)
+		return -EBUSY;
+
+	if (scrub_cycle_hrs < ras2_ctx->min_scrub_cycle ||
+	    scrub_cycle_hrs > ras2_ctx->max_scrub_cycle)
+		return -EINVAL;
+
+	ras2_ctx->scrub_cycle_hrs = scrub_cycle_hrs;
+
+	return 0;
+}
+
+static int ras2_hw_scrub_read_addr(struct device *dev, void *drv_data, u64 *base)
+{
+	struct ras2_mem_ctx *ras2_ctx = drv_data;
+	int ret;
+
+	/*
+	 * When BG scrubbing is enabled the actual address range is not valid.
+	 * Return -EBUSY now unless find out a method to retrieve actual full PA range.
+	 */
+	if (ras2_ctx->bg_scrub)
+		return -EBUSY;
+
+	/*
+	 * When demand scrubbing is finished firmware must reset actual
+	 * address range to 0. Otherwise userspace assumes demand scrubbing
+	 * is in progress.
+	 */
+	ret = ras2_update_patrol_scrub_params_cache(ras2_ctx);
+	if (ret)
+		return ret;
+
+	*base = ras2_ctx->base;
+
+	return 0;
+}
+
+static int ras2_hw_scrub_read_size(struct device *dev, void *drv_data, u64 *size)
+{
+	struct ras2_mem_ctx *ras2_ctx = drv_data;
+	int ret;
+
+	if (ras2_ctx->bg_scrub)
+		return -EBUSY;
+
+	ret = ras2_update_patrol_scrub_params_cache(ras2_ctx);
+	if (ret)
+		return ret;
+
+	*size = ras2_ctx->size;
+
+	return 0;
+}
+
+static int ras2_hw_scrub_write_addr(struct device *dev, void *drv_data, u64 base)
+{
+	struct ras2_mem_ctx *ras2_ctx = drv_data;
+	struct acpi_ras2_ps_shared_mem __iomem *ps_sm =
+		(void *)ras2_ctx->comm_addr;
+	bool running;
+	int ret;
+
+	guard(mutex)(&ras2_ctx->lock);
+	ps_sm->common.set_caps[0] = RAS2_SUPPORT_HW_PARTOL_SCRUB;
+	if (ras2_ctx->bg_scrub)
+		return -EBUSY;
+
+	if (!base || !ras2_ctx->size) {
+		dev_warn(ras2_ctx->dev,
+			 "%s: Invalid address range, base=0x%llx "
+			 "size=0x%llx\n", __func__,
+			 base, ras2_ctx->size);
+		return -ERANGE;
+	}
+
+	ret = ras2_get_patrol_scrub_running(ras2_ctx, &running);
+	if (ret)
+		return ret;
+
+	if (running)
+		return -EBUSY;
+
+	ps_sm->params.scrub_params_in &= ~RAS2_PS_SC_HRS_IN_MASK;
+	ps_sm->params.scrub_params_in |= FIELD_PREP(RAS2_PS_SC_HRS_IN_MASK,
+						    ras2_ctx->scrub_cycle_hrs);
+	ps_sm->params.req_addr_range[0] = base;
+	ps_sm->params.req_addr_range[1] = ras2_ctx->size;
+	ps_sm->params.scrub_params_in &= ~RAS2_PS_EN_BACKGROUND;
+	ps_sm->params.cmd = RAS2_START_PATROL_SCRUBBER;
+
+	ret = ras2_send_pcc_cmd(ras2_ctx, RAS2_PCC_CMD_EXEC);
+	if (ret) {
+		dev_err(ras2_ctx->dev, "Failed to start demand scrubbing\n");
+		return ret;
+	}
+
+	return ras2_update_patrol_scrub_params_cache(ras2_ctx);
+}
+
+static int ras2_hw_scrub_write_size(struct device *dev, void *drv_data, u64 size)
+{
+	struct ras2_mem_ctx *ras2_ctx = drv_data;
+	bool running;
+	int ret;
+
+	guard(mutex)(&ras2_ctx->lock);
+	ret = ras2_get_patrol_scrub_running(ras2_ctx, &running);
+	if (ret)
+		return ret;
+
+	if (running)
+		return -EBUSY;
+
+	if (!size) {
+		dev_warn(dev, "%s: Invalid address range size=0x%llx\n",
+			 __func__, size);
+		return -EINVAL;
+	}
+
+	ras2_ctx->size = size;
+
+	return 0;
+}
+
+static int ras2_hw_scrub_set_enabled_bg(struct device *dev, void *drv_data, bool enable)
+{
+	struct ras2_mem_ctx *ras2_ctx = drv_data;
+	struct acpi_ras2_ps_shared_mem __iomem *ps_sm =
+		(void *)ras2_ctx->comm_addr;
+	bool running;
+	int ret;
+
+	guard(mutex)(&ras2_ctx->lock);
+	ps_sm->common.set_caps[0] = RAS2_SUPPORT_HW_PARTOL_SCRUB;
+	ret = ras2_get_patrol_scrub_running(ras2_ctx, &running);
+	if (ret)
+		return ret;
+
+	if (enable) {
+		if (ras2_ctx->bg_scrub || running)
+			return -EBUSY;
+		ps_sm->params.req_addr_range[0] = 0;
+		ps_sm->params.req_addr_range[1] = 0;
+		ps_sm->params.scrub_params_in &= ~RAS2_PS_SC_HRS_IN_MASK;
+		ps_sm->params.scrub_params_in |= FIELD_PREP(RAS2_PS_SC_HRS_IN_MASK,
+							    ras2_ctx->scrub_cycle_hrs);
+		ps_sm->params.cmd = RAS2_START_PATROL_SCRUBBER;
+	} else {
+		if (!ras2_ctx->bg_scrub)
+			return -EPERM;
+		ps_sm->params.cmd = RAS2_STOP_PATROL_SCRUBBER;
+	}
+
+	ps_sm->params.scrub_params_in &= ~RAS2_PS_EN_BACKGROUND;
+	ps_sm->params.scrub_params_in |= FIELD_PREP(RAS2_PS_EN_BACKGROUND,
+						    enable);
+	ret = ras2_send_pcc_cmd(ras2_ctx, RAS2_PCC_CMD_EXEC);
+	if (ret) {
+		dev_err(ras2_ctx->dev, "Failed to %s background scrubbing\n",
+			str_enable_disable(enable));
+		return ret;
+	}
+
+	if (enable) {
+		ras2_ctx->bg_scrub = true;
+		/* Update the cache to account for rounding of supplied parameters and similar */
+		ret = ras2_update_patrol_scrub_params_cache(ras2_ctx);
+	} else {
+		ret = ras2_update_patrol_scrub_params_cache(ras2_ctx);
+		ras2_ctx->bg_scrub = false;
+	}
+
+	return ret;
+}
+
+static int ras2_hw_scrub_get_enabled_bg(struct device *dev, void *drv_data, bool *enabled)
+{
+	struct ras2_mem_ctx *ras2_ctx = drv_data;
+
+	*enabled = ras2_ctx->bg_scrub;
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
+	struct ras2_mem_ctx *ras2_ctx = container_of(auxdev, struct ras2_mem_ctx, adev);
+	struct edac_dev_feature ras_features[RAS2_DEV_NUM_RAS_FEATURES];
+	char scrub_name[RAS2_SCRUB_NAME_LEN];
+	int num_ras_features = 0;
+	int ret;
+
+	if (!ras2_is_patrol_scrub_support(ras2_ctx))
+		return -EOPNOTSUPP;
+
+	ret = ras2_update_patrol_scrub_params_cache(ras2_ctx);
+	if (ret)
+		return ret;
+
+	snprintf(scrub_name, sizeof(scrub_name), "acpi_ras_mem%d",
+		 ras2_ctx->id);
+
+	ras_features[num_ras_features].ft_type = RAS_FEAT_SCRUB;
+	ras_features[num_ras_features].instance = ras2_ctx->instance;
+	ras_features[num_ras_features].scrub_ops = &ras2_scrub_ops;
+	ras_features[num_ras_features].ctx = ras2_ctx;
+	num_ras_features++;
+
+	return edac_dev_register(&auxdev->dev, scrub_name, NULL,
+				 num_ras_features, ras_features);
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
index 5b27c1f30096..c9a6b63745dc 100644
--- a/include/acpi/ras2.h
+++ b/include/acpi/ras2.h
@@ -31,7 +31,13 @@ struct ras2_mem_ctx {
 	struct device *dev;
 	struct acpi_ras2_shmem __iomem *comm_addr;
 	void *pcc_subspace;
+	u64 base, size;
 	int id;
+	u8 instance;
+	u8 scrub_cycle_hrs;
+	u8 min_scrub_cycle;
+	u8 max_scrub_cycle;
+	bool bg_scrub;
 };
 
 #ifdef CONFIG_ACPI_RAS2
-- 
2.43.0


