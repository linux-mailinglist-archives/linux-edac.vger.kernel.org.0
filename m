Return-Path: <linux-edac+bounces-1578-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1C893D6AA
	for <lists+linux-edac@lfdr.de>; Fri, 26 Jul 2024 18:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0A6BB20F28
	for <lists+linux-edac@lfdr.de>; Fri, 26 Jul 2024 16:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F56717C7BD;
	Fri, 26 Jul 2024 16:07:14 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BA217E445;
	Fri, 26 Jul 2024 16:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722010034; cv=none; b=dUX0/eHH+oz7TY3UKaoniTHBOE8B6tPLGXNDCpTzaqJEY7ejXg+VMpsBLDTfBoRO6ocpmDNX7hrx6mTE9pjDr2giwziNeUWhYcKcCcm42Fib++Wr2aTag9BCzRYCUBaL8XYkpESoKu4AEYeOhSUUSBaaBIKbEnhyQeEpTrD+ylM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722010034; c=relaxed/simple;
	bh=Utqg93cDZfehd3GsDyDs7X36VPNWaxnssUK/88Xc0V0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rWglMhJW8D/lAeNNa5PK+7wLgp+TETqVMnJm7RR7Jp0PQ4v3R2U7r5/P3pznX2aUihS2AiqUGoqg1IiDG4w3FGoBQA0HtYyFgW0c+RtLNZY5pJ/tr9AaVfYIlkSt+rtilUmGn5tF+IJocP/JDcTtv0+fU8BIwW1YXqOwmccNLtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WVsyf3ft9z6K9KG;
	Sat, 27 Jul 2024 00:04:42 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id 32193140A30;
	Sat, 27 Jul 2024 00:07:10 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.173.33) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 26 Jul 2024 17:07:08 +0100
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
CC: <bp@alien8.de>, <tony.luck@intel.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <mchehab@kernel.org>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <david@redhat.com>, <Vilas.Sridharan@amd.com>,
	<leo.duran@amd.com>, <Yazen.Ghannam@amd.com>, <rientjes@google.com>,
	<jiaqiyan@google.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<naoya.horiguchi@nec.com>, <james.morse@arm.com>, <jthoughton@google.com>,
	<somasundaram.a@hpe.com>, <erdemaktas@google.com>, <pgonda@google.com>,
	<duenwen@google.com>, <mike.malvestuto@intel.com>, <gthelen@google.com>,
	<wschwartz@amperecomputing.com>, <dferguson@amperecomputing.com>,
	<wbs@os.amperecomputing.com>, <nifan.cxl@gmail.com>, <yazen.ghannam@amd.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>, <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v10 11/11] ras: scrub: ACPI RAS2: Add memory ACPI RAS2 driver
Date: Fri, 26 Jul 2024 17:05:55 +0100
Message-ID: <20240726160556.2079-12-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240726160556.2079-1-shiju.jose@huawei.com>
References: <20240726160556.2079-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500006.china.huawei.com (7.191.161.198)

From: Shiju Jose <shiju.jose@huawei.com>

Memory ACPI RAS2 driver binds to the platform device add by the
ACPI RAS2 table parser.

Driver uses a PCC subspace for communicating with the ACPI compliant
platform to provide control of memory scrub parameters to the userspace
via the edac scrub.

Get the scrub attr descriptors from the EDAC scrub and register with EDAC
RAS feature driver to expose sysfs scrub control attributes to the userspace.
For example scrub control for the RAS2 memory device is exposed in
/sys/bus/edac/devices/acpi_ras2_mem0/scrub/

Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 Documentation/scrub/edac-scrub.rst |  41 +++
 drivers/ras/Kconfig                |  10 +
 drivers/ras/Makefile               |   1 +
 drivers/ras/acpi_ras2.c            | 415 +++++++++++++++++++++++++++++
 4 files changed, 467 insertions(+)
 create mode 100644 drivers/ras/acpi_ras2.c

diff --git a/Documentation/scrub/edac-scrub.rst b/Documentation/scrub/edac-scrub.rst
index 7815d674f496..348f98091ac1 100644
--- a/Documentation/scrub/edac-scrub.rst
+++ b/Documentation/scrub/edac-scrub.rst
@@ -72,3 +72,44 @@ root@localhost:~# cat /sys/bus/edac/devices/cxl_region0/scrub/enable_background
 root@localhost:~# echo 0 > /sys/bus/edac/devices/cxl_region0/scrub/enable_background
 root@localhost:~# cat /sys/bus/edac/devices/cxl_region0/scrub/enable_background
 0
+
+2. RAS2
+2.1 On demand scrubbing for a specific memory region.
+root@localhost:~# echo 0x120000 > /sys/bus/edac/devices/acpi_ras2_mem0/scrub/addr_range_base
+root@localhost:~# echo 0x150000 > /sys/bus/edac/devices/acpi_ras2_mem0/scrub/addr_range_size
+root@localhost:~# cat /sys/bus/edac/devices/acpi_ras2_mem0/scrub/min_cycle_duration
+1
+root@localhost:~# cat /sys/bus/edac/devices/acpi_ras2_mem0/scrub/max_cycle_duration
+24
+root@localhost:~# cat /sys/bus/edac/devices/acpi_ras2_mem0/scrub/current_cycle_duration
+10
+root@localhost:~# echo 15 > /sys/bus/edac/devices/acpi_ras2_mem0/scrub/current_cycle_duration
+root@localhost:~# echo 1 > /sys/bus/edac/devices/acpi_ras2_mem0/scrub/enable_on_demand
+root@localhost:~# cat /sys/bus/edac/devices/acpi_ras2_mem0/scrub/enable_on_demand
+1
+root@localhost:~# cat /sys/bus/edac/devices/acpi_ras2_mem0/scrub/current_cycle_duration
+15
+root@localhost:~# cat /sys/bus/edac/devices/acpi_ras2_mem0/scrub/addr_range_base
+0x120000
+root@localhost:~# cat //sys/bus/edac/devices/acpi_ras2_mem0/scrub/addr_range_size
+0x150000
+root@localhost:~# echo 0 > /sys/bus/edac/devices/acpi_ras2_mem0/scrub/enable_on_demand
+root@localhost:~# cat /sys/bus/edac/devices/acpi_ras2_mem0/scrub/enable_on_demand
+0
+
+2.2 Background scrubbing the entire memory
+root@localhost:~# cat /sys/bus/edac/devices/acpi_ras2_mem0/scrub/min_cycle_duration
+1
+root@localhost:~# cat /sys/bus/edac/devices/acpi_ras2_mem0/scrub/max_cycle_duration
+24
+root@localhost:~# cat /sys/bus/edac/devices/acpi_ras2_mem0/scrub/current_cycle_duration
+10
+root@localhost:~# cat /sys/bus/edac/devices/acpi_ras2_mem0/enable_background
+0
+root@localhost:~# echo 3 > /sys/bus/edac/devices/acpi_ras2_mem0/scrub/current_cycle_duration
+root@localhost:~# echo 1 > /sys/bus/edac/devices/acpi_ras2_mem0/enable_background
+root@localhost:~# cat /sys/bus/edac/devices/acpi_ras2_mem0/enable_background
+1
+root@localhost:~# cat /sys/bus/edac/devices/acpi_ras2_mem0/scrub/current_cycle_duration
+3
+root@localhost:~# echo 0 > /sys/bus/edac/devices/acpi_ras2_mem0/enable_background
diff --git a/drivers/ras/Kconfig b/drivers/ras/Kconfig
index fc4f4bb94a4c..a2635017d80d 100644
--- a/drivers/ras/Kconfig
+++ b/drivers/ras/Kconfig
@@ -46,4 +46,14 @@ config RAS_FMPM
 	  Memory will be retired during boot time and run time depending on
 	  platform-specific policies.
 
+config MEM_ACPI_RAS2
+	tristate "Memory ACPI RAS2 driver"
+	depends on ACPI_RAS2
+	depends on EDAC
+	help
+	  The driver binds to the platform device added by the ACPI RAS2
+	  table parser. Use a PCC channel subspace for communicating with
+	  the ACPI compliant platform to provide control of memory scrub
+	  parameters to the user via the edac scrub.
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
index 000000000000..b2381d5b37d0
--- /dev/null
+++ b/drivers/ras/acpi_ras2.c
@@ -0,0 +1,415 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * ACPI RAS2 memory driver
+ *
+ * Copyright (c) 2024 HiSilicon Limited.
+ *
+ */
+
+#define pr_fmt(fmt)	"MEMORY ACPI RAS2: " fmt
+
+#include <linux/edac_ras_feature.h>
+#include <linux/platform_device.h>
+#include <acpi/ras2_acpi.h>
+
+#define RAS2_DEV_NUM_RAS_FEATURES	1
+
+#define RAS2_SUPPORT_HW_PARTOL_SCRUB	BIT(0)
+#define RAS2_TYPE_PATROL_SCRUB	0x0000
+
+#define RAS2_GET_PATROL_PARAMETERS	0x01
+#define	RAS2_START_PATROL_SCRUBBER	0x02
+#define	RAS2_STOP_PATROL_SCRUBBER	0x03
+
+#define RAS2_PATROL_SCRUB_SCHRS_IN_MASK	GENMASK(15, 8)
+#define RAS2_PATROL_SCRUB_EN_BACKGROUND	BIT(0)
+#define RAS2_PATROL_SCRUB_SCHRS_OUT_MASK	GENMASK(7, 0)
+#define RAS2_PATROL_SCRUB_MIN_SCHRS_OUT_MASK	GENMASK(15, 8)
+#define RAS2_PATROL_SCRUB_MAX_SCHRS_OUT_MASK	GENMASK(23, 16)
+#define RAS2_PATROL_SCRUB_FLAG_SCRUBBER_RUNNING	BIT(0)
+
+#define RAS2_SCRUB_NAME_LEN      128
+
+struct acpi_ras2_ps_shared_mem {
+	struct acpi_ras2_shared_memory common;
+	struct acpi_ras2_patrol_scrub_parameter params;
+};
+
+static int ras2_is_patrol_scrub_support(struct ras2_scrub_ctx *ras2_ctx)
+{
+	struct acpi_ras2_shared_memory __iomem *common = (void *)
+				ras2_ctx->pcc_subspace->pcc_comm_addr;
+
+	guard(mutex)(&ras2_ctx->lock);
+	common->set_capabilities[0] = 0;
+
+	return common->features[0] & RAS2_SUPPORT_HW_PARTOL_SCRUB;
+}
+
+static int ras2_update_patrol_scrub_params_cache(struct ras2_scrub_ctx *ras2_ctx)
+{
+	struct acpi_ras2_ps_shared_mem __iomem *ps_sm = (void *)
+					ras2_ctx->pcc_subspace->pcc_comm_addr;
+	int ret;
+
+	ps_sm->common.set_capabilities[0] = RAS2_SUPPORT_HW_PARTOL_SCRUB;
+	ps_sm->params.patrol_scrub_command = RAS2_GET_PATROL_PARAMETERS;
+
+	ret = ras2_send_pcc_cmd(ras2_ctx, RAS2_PCC_CMD_EXEC);
+	if (ret) {
+		dev_err(ras2_ctx->dev, "failed to read parameters\n");
+		return ret;
+	}
+
+	ras2_ctx->min_scrub_cycle = FIELD_GET(RAS2_PATROL_SCRUB_MIN_SCHRS_OUT_MASK,
+					      ps_sm->params.scrub_params_out);
+	ras2_ctx->max_scrub_cycle = FIELD_GET(RAS2_PATROL_SCRUB_MAX_SCHRS_OUT_MASK,
+					      ps_sm->params.scrub_params_out);
+	if (!ras2_ctx->bg) {
+		ras2_ctx->base = ps_sm->params.actual_address_range[0];
+		ras2_ctx->size = ps_sm->params.actual_address_range[1];
+	}
+	ras2_ctx->scrub_cycle_secs = FIELD_GET(RAS2_PATROL_SCRUB_SCHRS_OUT_MASK,
+					       ps_sm->params.scrub_params_out);
+
+	return 0;
+}
+
+/* Context - lock must be held */
+static int ras2_get_patrol_scrub_running(struct ras2_scrub_ctx *ras2_ctx,
+					 bool *running)
+{
+	struct acpi_ras2_ps_shared_mem __iomem *ps_sm = (void *)
+					ras2_ctx->pcc_subspace->pcc_comm_addr;
+	int ret;
+
+	ps_sm->common.set_capabilities[0] = RAS2_SUPPORT_HW_PARTOL_SCRUB;
+	ps_sm->params.patrol_scrub_command = RAS2_GET_PATROL_PARAMETERS;
+
+	ret = ras2_send_pcc_cmd(ras2_ctx, RAS2_PCC_CMD_EXEC);
+	if (ret) {
+		dev_err(ras2_ctx->dev, "failed to read parameters\n");
+		return ret;
+	}
+
+	*running = ps_sm->params.flags & RAS2_PATROL_SCRUB_FLAG_SCRUBBER_RUNNING;
+
+	return 0;
+}
+
+static int ras2_hw_scrub_read_min_scrub_cycle(struct device *dev, void *drv_data,
+					      u32 *min)
+{
+	struct ras2_scrub_ctx *ras2_ctx = drv_data;
+
+	*min = ras2_ctx->min_scrub_cycle;
+
+	return 0;
+}
+
+static int ras2_hw_scrub_read_max_scrub_cycle(struct device *dev, void *drv_data,
+					      u32 *max)
+{
+	struct ras2_scrub_ctx *ras2_ctx = drv_data;
+
+	*max = ras2_ctx->max_scrub_cycle;
+
+	return 0;
+}
+
+static int ras2_hw_scrub_cycle_read(struct device *dev, void *drv_data,
+				    u32 *scrub_cycle_secs)
+{
+	struct ras2_scrub_ctx *ras2_ctx = drv_data;
+
+	*scrub_cycle_secs = ras2_ctx->scrub_cycle_secs;
+
+	return 0;
+}
+
+static int ras2_hw_scrub_cycle_write(struct device *dev, void *drv_data,
+				     u32 scrub_cycle_secs)
+{
+	struct ras2_scrub_ctx *ras2_ctx = drv_data;
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
+	if (scrub_cycle_secs < ras2_ctx->min_scrub_cycle ||
+	    scrub_cycle_secs > ras2_ctx->max_scrub_cycle)
+		return -EINVAL;
+
+	ras2_ctx->scrub_cycle_secs = scrub_cycle_secs;
+
+	return 0;
+}
+
+static int ras2_hw_scrub_read_range(struct device *dev, void *drv_data, u64 *base, u64 *size)
+{
+	struct ras2_scrub_ctx *ras2_ctx = drv_data;
+
+	/*
+	 * When BG scrubbing is enabled the actual address range is not valid.
+	 * Return -EBUSY now unless findout a method to retrieve actual full PA range.
+	 */
+	if (ras2_ctx->bg)
+		return -EBUSY;
+
+	*base = ras2_ctx->base;
+	*size = ras2_ctx->size;
+
+	return 0;
+}
+
+static int ras2_hw_scrub_write_range(struct device *dev, void *drv_data, u64 base, u64 size)
+{
+	struct ras2_scrub_ctx *ras2_ctx = drv_data;
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
+	if (!base || !size) {
+		dev_warn(dev, "%s: Invalid address range, base=0x%llx size=0x%llx\n",
+			 __func__, base, size);
+		return -EINVAL;
+	}
+
+	ras2_ctx->base = base;
+	ras2_ctx->size = size;
+
+	return 0;
+}
+
+static int ras2_hw_scrub_set_enabled_bg(struct device *dev, void *drv_data, bool enable)
+{
+	struct ras2_scrub_ctx *ras2_ctx = drv_data;
+	struct acpi_ras2_ps_shared_mem __iomem *ps_sm = (void *)
+					ras2_ctx->pcc_subspace->pcc_comm_addr;
+	bool enabled;
+	int ret;
+
+	guard(mutex)(&ras2_ctx->lock);
+	ps_sm->common.set_capabilities[0] = RAS2_SUPPORT_HW_PARTOL_SCRUB;
+	ret = ras2_get_patrol_scrub_running(ras2_ctx, &enabled);
+	if (ret)
+		return ret;
+	if (enable) {
+		if (ras2_ctx->bg || enabled)
+			return -EBUSY;
+		ps_sm->params.requested_address_range[0] = 0;
+		ps_sm->params.requested_address_range[1] = 0;
+		ps_sm->params.scrub_params_in &= ~RAS2_PATROL_SCRUB_SCHRS_IN_MASK;
+		ps_sm->params.scrub_params_in |= FIELD_PREP(RAS2_PATROL_SCRUB_SCHRS_IN_MASK,
+							    ras2_ctx->scrub_cycle_secs);
+		ps_sm->params.patrol_scrub_command = RAS2_START_PATROL_SCRUBBER;
+	} else {
+		if (!ras2_ctx->bg)
+			return -EPERM;
+		if (!ras2_ctx->bg && enabled)
+			return -EBUSY;
+		ps_sm->params.patrol_scrub_command = RAS2_STOP_PATROL_SCRUBBER;
+	}
+	ps_sm->params.scrub_params_in &= ~RAS2_PATROL_SCRUB_EN_BACKGROUND;
+	ps_sm->params.scrub_params_in |= FIELD_PREP(RAS2_PATROL_SCRUB_EN_BACKGROUND,
+						    enable);
+	ret = ras2_send_pcc_cmd(ras2_ctx, RAS2_PCC_CMD_EXEC);
+	if (ret) {
+		dev_err(ras2_ctx->dev, "%s: failed to enable(%d) background scrubbing\n",
+			__func__, enable);
+		return ret;
+	}
+	if (enable) {
+		ras2_ctx->bg = true;
+		/* Update the cache to account for rounding of supplied parameters and similar */
+		ret = ras2_update_patrol_scrub_params_cache(ras2_ctx);
+	} else {
+		ret = ras2_update_patrol_scrub_params_cache(ras2_ctx);
+		ras2_ctx->bg = false;
+	}
+
+	return ret;
+}
+
+static int ras2_hw_scrub_get_enabled_bg(struct device *dev, void *drv_data, bool *enabled)
+{
+	struct ras2_scrub_ctx *ras2_ctx = drv_data;
+
+	*enabled = ras2_ctx->bg;
+
+	return 0;
+}
+
+static int ras2_hw_scrub_set_enabled_od(struct device *dev, void *drv_data, bool enable)
+{
+	struct ras2_scrub_ctx *ras2_ctx = drv_data;
+	struct acpi_ras2_ps_shared_mem __iomem *ps_sm = (void *)
+					ras2_ctx->pcc_subspace->pcc_comm_addr;
+	bool enabled;
+	int ret;
+
+	guard(mutex)(&ras2_ctx->lock);
+	ps_sm->common.set_capabilities[0] = RAS2_SUPPORT_HW_PARTOL_SCRUB;
+	if (ras2_ctx->bg)
+		return -EBUSY;
+	ret = ras2_get_patrol_scrub_running(ras2_ctx, &enabled);
+	if (ret)
+		return ret;
+	if (enable) {
+		if (!ras2_ctx->base || !ras2_ctx->size) {
+			dev_warn(ras2_ctx->dev,
+				 "%s: Invalid address range, base=0x%llx "
+				 "size=0x%llx\n", __func__,
+				 ras2_ctx->base, ras2_ctx->size);
+			return -ERANGE;
+		}
+		if (enabled)
+			return -EBUSY;
+		ps_sm->params.scrub_params_in &= ~RAS2_PATROL_SCRUB_SCHRS_IN_MASK;
+		ps_sm->params.scrub_params_in |= FIELD_PREP(RAS2_PATROL_SCRUB_SCHRS_IN_MASK,
+							    ras2_ctx->scrub_cycle_secs);
+		ps_sm->params.requested_address_range[0] = ras2_ctx->base;
+		ps_sm->params.requested_address_range[1] = ras2_ctx->size;
+		ps_sm->params.scrub_params_in &= ~RAS2_PATROL_SCRUB_EN_BACKGROUND;
+		ps_sm->params.patrol_scrub_command = RAS2_START_PATROL_SCRUBBER;
+	} else {
+		if (!enabled)
+			return 0;
+		ps_sm->params.patrol_scrub_command = RAS2_STOP_PATROL_SCRUBBER;
+	}
+
+	ret = ras2_send_pcc_cmd(ras2_ctx, RAS2_PCC_CMD_EXEC);
+	if (ret) {
+		dev_err(ras2_ctx->dev, "failed to enable(%d) the demand scrubbing\n", enable);
+		return ret;
+	}
+
+	return ras2_update_patrol_scrub_params_cache(ras2_ctx);
+}
+
+static int ras2_hw_scrub_get_enabled_od(struct device *dev, void *drv_data, bool *enabled)
+{
+	struct ras2_scrub_ctx *ras2_ctx = drv_data;
+
+	guard(mutex)(&ras2_ctx->lock);
+	if (ras2_ctx->bg) {
+		*enabled = false;
+		return 0;
+	}
+
+	return ras2_get_patrol_scrub_running(ras2_ctx, enabled);
+}
+
+static int ras2_hw_scrub_get_name(struct device *dev, void *drv_data, char *name)
+{
+	struct ras2_scrub_ctx *ras2_ctx = drv_data;
+
+	return sysfs_emit(name, "acpi_ras2_mem%d_scrub\n", ras2_ctx->id);
+}
+
+static const struct edac_scrub_ops ras2_scrub_ops = {
+	.read_range = ras2_hw_scrub_read_range,
+	.write_range = ras2_hw_scrub_write_range,
+	.get_enabled_bg = ras2_hw_scrub_get_enabled_bg,
+	.set_enabled_bg = ras2_hw_scrub_set_enabled_bg,
+	.get_enabled_od = ras2_hw_scrub_get_enabled_od,
+	.set_enabled_od = ras2_hw_scrub_set_enabled_od,
+	.get_name = ras2_hw_scrub_get_name,
+	.min_cycle_read = ras2_hw_scrub_read_min_scrub_cycle,
+	.max_cycle_read = ras2_hw_scrub_read_max_scrub_cycle,
+	.cycle_duration_read = ras2_hw_scrub_cycle_read,
+	.cycle_duration_write = ras2_hw_scrub_cycle_write,
+};
+
+static DEFINE_IDA(ras2_ida);
+
+static void ida_release(void *ctx)
+{
+	struct ras2_scrub_ctx *ras2_ctx = ctx;
+
+	ida_free(&ras2_ida, ras2_ctx->id);
+}
+
+static int ras2_probe(struct platform_device *pdev)
+{
+	struct edac_ras_feature ras_features[RAS2_DEV_NUM_RAS_FEATURES];
+	char scrub_name[RAS2_SCRUB_NAME_LEN];
+	struct ras2_scrub_ctx *ras2_ctx;
+	int num_ras_features = 0;
+	int ret, id;
+
+	/* RAS2 PCC Channel and Scrub specific context */
+	ras2_ctx = devm_kzalloc(&pdev->dev, sizeof(*ras2_ctx), GFP_KERNEL);
+	if (!ras2_ctx)
+		return -ENOMEM;
+
+	ras2_ctx->dev = &pdev->dev;
+	mutex_init(&ras2_ctx->lock);
+
+	ret = devm_ras2_register_pcc_channel(&pdev->dev, ras2_ctx,
+					     *((int *)dev_get_platdata(&pdev->dev)));
+	if (ret < 0) {
+		dev_dbg(ras2_ctx->dev,
+			"failed to register pcc channel ret=%d\n", ret);
+		return ret;
+	}
+	if (!ras2_is_patrol_scrub_support(ras2_ctx))
+		return -EOPNOTSUPP;
+
+	ret = ras2_update_patrol_scrub_params_cache(ras2_ctx);
+	if (ret)
+		return ret;
+
+	id = ida_alloc(&ras2_ida, GFP_KERNEL);
+	if (id < 0)
+		return id;
+
+	ras2_ctx->id = id;
+
+	ret = devm_add_action_or_reset(&pdev->dev, ida_release, ras2_ctx);
+	if (ret < 0)
+		return ret;
+
+	snprintf(scrub_name, sizeof(scrub_name), "acpi_ras2_mem%d",
+		 ras2_ctx->id);
+
+	ras_features[num_ras_features].feat = RAS_FEAT_SCRUB;
+	ras_features[num_ras_features].scrub_ops = &ras2_scrub_ops;
+	ras_features[num_ras_features].scrub_ctx = ras2_ctx;
+	num_ras_features++;
+
+	return edac_ras_dev_register(&pdev->dev, scrub_name, NULL,
+				     num_ras_features, ras_features);
+}
+
+static const struct platform_device_id ras2_id_table[] = {
+	{ .name = "acpi_ras2", },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, ras2_id_table);
+
+static struct platform_driver ras2_driver = {
+	.probe = ras2_probe,
+	.driver = {
+		.name = "acpi_ras2",
+	},
+	.id_table = ras2_id_table,
+};
+module_driver(ras2_driver, platform_driver_register, platform_driver_unregister);
+
+MODULE_IMPORT_NS(ACPI_RAS2);
+MODULE_DESCRIPTION("ACPI RAS2 memory driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1


