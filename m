Return-Path: <linux-edac+bounces-3809-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4ADAA6CC5
	for <lists+linux-edac@lfdr.de>; Fri,  2 May 2025 10:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D265E17E1E1
	for <lists+linux-edac@lfdr.de>; Fri,  2 May 2025 08:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF7222B5BC;
	Fri,  2 May 2025 08:45:53 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D6822AE7A;
	Fri,  2 May 2025 08:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746175553; cv=none; b=Cd7hftcji0rfxWyf612wjHhPY6+TPEGlvFhS3H5f05MbXwmSEkChP/iM89YYlsJT2N8FdySzhPO+Op17YKi3sflmHTN4XunWH4/NH3s5xA5ECdx9J45T6V8jzbnns/SOJa3FiNP4uZk3dMQfEZ9s8byKfgaWkhyeFL+O31RlIxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746175553; c=relaxed/simple;
	bh=3RWqxWQ/Fdfm8npy7zRIYLMMd4gNbi8kE0QSES4bG38=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FEbW2Fawvf5wHBEFFwf+Cidm00wWGfJZCNnNf3a6FtcqE5EMSB0uvyTOIwogJXZi2B6bMkw+Uz3vJjqpcqO3rCgZDZ15krEQxPJb/DZiaZpqmAXwGEwAsWIQ2Y9qma555WKdQpWz5p75/bq2lS3enqy7+jkd0Ud+Sjf/dIhPDq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Zpksx72Bxz6M4M8;
	Fri,  2 May 2025 16:41:25 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id B73CB1402FE;
	Fri,  2 May 2025 16:45:48 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.168.187) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 2 May 2025 10:45:47 +0200
From: <shiju.jose@huawei.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>
CC: <linux-edac@vger.kernel.org>, <linux-doc@vger.kernel.org>, <bp@alien8.de>,
	<tony.luck@intel.com>, <lenb@kernel.org>, <Yazen.Ghannam@amd.com>,
	<mchehab@kernel.org>, <nifan.cxl@gmail.com>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v4 3/8] cxl/edac: Add CXL memory device patrol scrub control feature
Date: Fri, 2 May 2025 09:45:11 +0100
Message-ID: <20250502084517.680-4-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250502084517.680-1-shiju.jose@huawei.com>
References: <20250502084517.680-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

CXL spec 3.2 section 8.2.10.9.11.1 describes the device patrol scrub
control feature. The device patrol scrub proactively locates and makes
corrections to errors in regular cycle.

Allow specifying the number of hours within which the patrol scrub must be
completed, subject to minimum and maximum limits reported by the device.
Also allow disabling scrub allowing trade-off error rates against
performance.

Add support for patrol scrub control on CXL memory devices.
Register with the EDAC device driver, which retrieves the scrub attribute
descriptors from EDAC scrub and exposes the sysfs scrub control attributes
to userspace. For example, scrub control for the CXL memory device
"cxl_mem0" is exposed in /sys/bus/edac/devices/cxl_mem0/scrubX/.

Additionally, add support for region-based CXL memory patrol scrub control.
CXL memory regions may be interleaved across one or more CXL memory
devices. For example, region-based scrub control for "cxl_region1" is
exposed in /sys/bus/edac/devices/cxl_region1/scrubX/.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/Kconfig       |  33 +++
 drivers/cxl/core/Makefile |   1 +
 drivers/cxl/core/edac.c   | 495 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/region.c |  10 +
 drivers/cxl/cxl.h         |  10 +
 drivers/cxl/cxlmem.h      |  16 ++
 drivers/cxl/mem.c         |   4 +
 7 files changed, 569 insertions(+)
 create mode 100644 drivers/cxl/core/edac.c

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index cf1ba673b8c2..af72416edcd4 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -114,6 +114,39 @@ config CXL_FEATURES
 
 	  If unsure say 'n'
 
+config CXL_EDAC_MEM_FEATURES
+	bool "CXL: EDAC Memory Features"
+	depends on EXPERT
+	depends on CXL_MEM
+	depends on CXL_FEATURES
+	depends on EDAC >= CXL_BUS
+	help
+	  The CXL EDAC memory feature is optional and allows host to
+	  control the EDAC memory features configurations of CXL memory
+	  expander devices.
+
+	  Say 'y' if you have an expert need to change default settings
+	  of a memory RAS feature established by the platform/device.
+	  Otherwise say 'n'.
+
+config CXL_EDAC_SCRUB
+	bool "Enable CXL Patrol Scrub Control (Patrol Read)"
+	depends on CXL_EDAC_MEM_FEATURES
+	depends on EDAC_SCRUB
+	help
+	  The CXL EDAC scrub control is optional and allows host to
+	  control the scrub feature configurations of CXL memory expander
+	  devices.
+
+	  When enabled 'cxl_mem' and 'cxl_region' EDAC devices are
+	  published with memory scrub control attributes as described by
+	  Documentation/ABI/testing/sysfs-edac-scrub.
+
+	  Say 'y' if you have an expert need to change default settings
+	  of a memory scrub feature established by the platform/device
+	  (e.g. scrub rates for the patrol scrub feature).
+	  Otherwise say 'n'.
+
 config CXL_PORT
 	default CXL_BUS
 	tristate
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 086df97a0fcf..79e2ef81fde8 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -20,3 +20,4 @@ cxl_core-$(CONFIG_TRACING) += trace.o
 cxl_core-$(CONFIG_CXL_REGION) += region.o
 cxl_core-$(CONFIG_CXL_MCE) += mce.o
 cxl_core-$(CONFIG_CXL_FEATURES) += features.o
+cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
new file mode 100644
index 000000000000..3a4f9ed726d3
--- /dev/null
+++ b/drivers/cxl/core/edac.c
@@ -0,0 +1,495 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * CXL EDAC memory feature driver.
+ *
+ * Copyright (c) 2024-2025 HiSilicon Limited.
+ *
+ *  - Supports functions to configure EDAC features of the
+ *    CXL memory devices.
+ *  - Registers with the EDAC device subsystem driver to expose
+ *    the features sysfs attributes to the user for configuring
+ *    CXL memory RAS feature.
+ */
+
+#include <linux/cleanup.h>
+#include <linux/edac.h>
+#include <linux/limits.h>
+#include <cxl/features.h>
+#include <cxl.h>
+#include <cxlmem.h>
+#include "core.h"
+
+#define CXL_NR_EDAC_DEV_FEATURES 1
+
+#ifdef CONFIG_CXL_EDAC_SCRUB
+struct cxl_patrol_scrub_context {
+	u8 instance;
+	u16 get_feat_size;
+	u16 set_feat_size;
+	u8 get_version;
+	u8 set_version;
+	u16 effects;
+	struct cxl_memdev *cxlmd;
+	struct cxl_region *cxlr;
+};
+
+/*
+ * See CXL spec rev 3.2 @8.2.10.9.11.1 Table 8-222 Device Patrol Scrub Control
+ * Feature Readable Attributes.
+ */
+struct cxl_scrub_rd_attrbs {
+	u8 scrub_cycle_cap;
+	__le16 scrub_cycle_hours;
+	u8 scrub_flags;
+} __packed;
+
+/*
+ * See CXL spec rev 3.2 @8.2.10.9.11.1 Table 8-223 Device Patrol Scrub Control
+ * Feature Writable Attributes.
+ */
+struct cxl_scrub_wr_attrbs {
+	u8 scrub_cycle_hours;
+	u8 scrub_flags;
+} __packed;
+
+#define CXL_SCRUB_CONTROL_CHANGEABLE BIT(0)
+#define CXL_SCRUB_CONTROL_REALTIME BIT(1)
+#define CXL_SCRUB_CONTROL_CYCLE_MASK GENMASK(7, 0)
+#define CXL_SCRUB_CONTROL_MIN_CYCLE_MASK GENMASK(15, 8)
+#define CXL_SCRUB_CONTROL_ENABLE BIT(0)
+
+#define CXL_GET_SCRUB_CYCLE_CHANGEABLE(cap) \
+	FIELD_GET(CXL_SCRUB_CONTROL_CHANGEABLE, cap)
+#define CXL_GET_SCRUB_CYCLE(cycle) \
+	FIELD_GET(CXL_SCRUB_CONTROL_CYCLE_MASK, cycle)
+#define CXL_GET_SCRUB_MIN_CYCLE(cycle) \
+	FIELD_GET(CXL_SCRUB_CONTROL_MIN_CYCLE_MASK, cycle)
+#define CXL_GET_SCRUB_EN_STS(flags) FIELD_GET(CXL_SCRUB_CONTROL_ENABLE, flags)
+
+#define CXL_SET_SCRUB_CYCLE(cycle) \
+	FIELD_PREP(CXL_SCRUB_CONTROL_CYCLE_MASK, cycle)
+#define CXL_SET_SCRUB_EN(en) FIELD_PREP(CXL_SCRUB_CONTROL_ENABLE, en)
+
+static int cxl_mem_scrub_get_attrbs(struct cxl_mailbox *cxl_mbox, u8 *cap,
+				    u16 *cycle, u8 *flags, u8 *min_cycle)
+{
+	size_t rd_data_size = sizeof(struct cxl_scrub_rd_attrbs);
+	size_t data_size;
+	struct cxl_scrub_rd_attrbs *rd_attrbs __free(kfree) =
+		kzalloc(rd_data_size, GFP_KERNEL);
+	if (!rd_attrbs)
+		return -ENOMEM;
+
+	data_size = cxl_get_feature(cxl_mbox, &CXL_FEAT_PATROL_SCRUB_UUID,
+				    CXL_GET_FEAT_SEL_CURRENT_VALUE, rd_attrbs,
+				    rd_data_size, 0, NULL);
+	if (!data_size)
+		return -EIO;
+
+	*cap = rd_attrbs->scrub_cycle_cap;
+	*cycle = le16_to_cpu(rd_attrbs->scrub_cycle_hours);
+	*flags = rd_attrbs->scrub_flags;
+	if (min_cycle)
+		*min_cycle = CXL_GET_SCRUB_MIN_CYCLE(*cycle);
+
+	return 0;
+}
+
+static int cxl_scrub_get_attrbs(struct cxl_patrol_scrub_context *cxl_ps_ctx,
+				u8 *cap, u16 *cycle, u8 *flags, u8 *min_cycle)
+{
+	struct cxl_mailbox *cxl_mbox;
+	u8 min_scrub_cycle = U8_MAX;
+	struct cxl_memdev *cxlmd;
+	int i, ret;
+
+	if (cxl_ps_ctx->cxlr) {
+		struct cxl_region *cxlr = cxl_ps_ctx->cxlr;
+		struct cxl_region_params *p = &cxlr->params;
+
+		struct rw_semaphore *region_lock __free(rwsem_read_release) =
+			rwsem_read_intr_acquire(&cxl_region_rwsem);
+		if (!region_lock)
+			return -EINTR;
+
+		for (i = 0; i < p->nr_targets; i++) {
+			struct cxl_endpoint_decoder *cxled = p->targets[i];
+
+			cxlmd = cxled_to_memdev(cxled);
+			cxl_mbox = &cxlmd->cxlds->cxl_mbox;
+			ret = cxl_mem_scrub_get_attrbs(cxl_mbox, cap, cycle,
+						       flags, min_cycle);
+			if (ret)
+				return ret;
+
+			if (min_cycle)
+				min_scrub_cycle =
+					min(*min_cycle, min_scrub_cycle);
+		}
+
+		if (min_cycle)
+			*min_cycle = min_scrub_cycle;
+
+		return 0;
+	}
+	cxl_mbox = &cxl_ps_ctx->cxlmd->cxlds->cxl_mbox;
+
+	return cxl_mem_scrub_get_attrbs(cxl_mbox, cap, cycle, flags, min_cycle);
+}
+
+static int cxl_scrub_set_attrbs(struct device *dev,
+				struct cxl_patrol_scrub_context *cxl_ps_ctx,
+				u8 cycle, u8 flags)
+{
+	struct cxl_scrub_wr_attrbs wr_attrbs;
+	struct cxl_mailbox *cxl_mbox;
+	struct cxl_memdev *cxlmd;
+	int ret, i;
+
+	wr_attrbs.scrub_cycle_hours = cycle;
+	wr_attrbs.scrub_flags = flags;
+
+	if (cxl_ps_ctx->cxlr) {
+		struct cxl_region *cxlr = cxl_ps_ctx->cxlr;
+		struct cxl_region_params *p = &cxlr->params;
+
+		struct rw_semaphore *region_lock __free(rwsem_read_release) =
+			rwsem_read_intr_acquire(&cxl_region_rwsem);
+		if (!region_lock)
+			return -EINTR;
+
+		for (i = 0; i < p->nr_targets; i++) {
+			struct cxl_endpoint_decoder *cxled = p->targets[i];
+
+			cxlmd = cxled_to_memdev(cxled);
+			cxl_mbox = &cxlmd->cxlds->cxl_mbox;
+			ret = cxl_set_feature(cxl_mbox, &CXL_FEAT_PATROL_SCRUB_UUID,
+					      cxl_ps_ctx->set_version, &wr_attrbs,
+					      sizeof(wr_attrbs),
+					      CXL_SET_FEAT_FLAG_DATA_SAVED_ACROSS_RESET,
+					      0, NULL);
+			if (ret)
+				return ret;
+
+			if (cycle != cxlmd->cur_scrub_cycle) {
+				if (cxlmd->cur_region_id != -1)
+					dev_info(dev,
+						 "device scrub rate(%d) set by region%d rate overwritten by region%d scrub rate(%d)\n",
+						 cxlmd->cur_scrub_cycle,
+						 cxlmd->cur_region_id, cxlr->id,
+						 cycle);
+
+				cxlmd->cur_scrub_cycle = cycle;
+				cxlmd->cur_region_id = cxlr->id;
+			}
+		}
+
+		return 0;
+	}
+
+	cxlmd = cxl_ps_ctx->cxlmd;
+	cxl_mbox = &cxlmd->cxlds->cxl_mbox;
+	ret = cxl_set_feature(cxl_mbox, &CXL_FEAT_PATROL_SCRUB_UUID,
+			      cxl_ps_ctx->set_version, &wr_attrbs,
+			      sizeof(wr_attrbs),
+			      CXL_SET_FEAT_FLAG_DATA_SAVED_ACROSS_RESET, 0,
+			      NULL);
+	if (ret)
+		return ret;
+
+	if (cycle != cxlmd->cur_scrub_cycle) {
+		if (cxlmd->cur_region_id != -1)
+			dev_info(dev,
+				 "device scrub rate(%d) set by region%d rate overwritten with device local scrub rate(%d)\n",
+				 cxlmd->cur_scrub_cycle, cxlmd->cur_region_id,
+				 cycle);
+
+		cxlmd->cur_scrub_cycle = cycle;
+		cxlmd->cur_region_id = -1;
+	}
+
+	return 0;
+}
+
+static int cxl_patrol_scrub_get_enabled_bg(struct device *dev, void *drv_data,
+					   bool *enabled)
+{
+	struct cxl_patrol_scrub_context *ctx = drv_data;
+	u8 cap, flags;
+	u16 cycle;
+	int ret;
+
+	ret = cxl_scrub_get_attrbs(ctx, &cap, &cycle, &flags, NULL);
+	if (ret)
+		return ret;
+
+	*enabled = CXL_GET_SCRUB_EN_STS(flags);
+
+	return 0;
+}
+
+static int cxl_patrol_scrub_set_enabled_bg(struct device *dev, void *drv_data,
+					   bool enable)
+{
+	struct cxl_patrol_scrub_context *ctx = drv_data;
+	u8 cap, flags, wr_cycle;
+	u16 rd_cycle;
+	int ret;
+
+	if (!capable(CAP_SYS_RAWIO))
+		return -EPERM;
+
+	ret = cxl_scrub_get_attrbs(ctx, &cap, &rd_cycle, &flags, NULL);
+	if (ret)
+		return ret;
+
+	wr_cycle = CXL_GET_SCRUB_CYCLE(rd_cycle);
+	flags = CXL_SET_SCRUB_EN(enable);
+
+	return cxl_scrub_set_attrbs(dev, ctx, wr_cycle, flags);
+}
+
+static int cxl_patrol_scrub_get_min_scrub_cycle(struct device *dev,
+						void *drv_data, u32 *min)
+{
+	struct cxl_patrol_scrub_context *ctx = drv_data;
+	u8 cap, flags, min_cycle;
+	u16 cycle;
+	int ret;
+
+	ret = cxl_scrub_get_attrbs(ctx, &cap, &cycle, &flags, &min_cycle);
+	if (ret)
+		return ret;
+
+	*min = min_cycle * 3600;
+
+	return 0;
+}
+
+static int cxl_patrol_scrub_get_max_scrub_cycle(struct device *dev,
+						void *drv_data, u32 *max)
+{
+	*max = U8_MAX * 3600; /* Max set by register size */
+
+	return 0;
+}
+
+static int cxl_patrol_scrub_get_scrub_cycle(struct device *dev, void *drv_data,
+					    u32 *scrub_cycle_secs)
+{
+	struct cxl_patrol_scrub_context *ctx = drv_data;
+	u8 cap, flags;
+	u16 cycle;
+	int ret;
+
+	ret = cxl_scrub_get_attrbs(ctx, &cap, &cycle, &flags, NULL);
+	if (ret)
+		return ret;
+
+	*scrub_cycle_secs = CXL_GET_SCRUB_CYCLE(cycle) * 3600;
+
+	return 0;
+}
+
+static int cxl_patrol_scrub_set_scrub_cycle(struct device *dev, void *drv_data,
+					    u32 scrub_cycle_secs)
+{
+	struct cxl_patrol_scrub_context *ctx = drv_data;
+	u8 scrub_cycle_hours = scrub_cycle_secs / 3600;
+	u8 cap, wr_cycle, flags, min_cycle;
+	u16 rd_cycle;
+	int ret;
+
+	if (!capable(CAP_SYS_RAWIO))
+		return -EPERM;
+
+	ret = cxl_scrub_get_attrbs(ctx, &cap, &rd_cycle, &flags, &min_cycle);
+	if (ret)
+		return ret;
+
+	if (!CXL_GET_SCRUB_CYCLE_CHANGEABLE(cap))
+		return -EOPNOTSUPP;
+
+	if (scrub_cycle_hours < min_cycle) {
+		dev_dbg(dev, "Invalid CXL patrol scrub cycle(%d) to set\n",
+			scrub_cycle_hours);
+		dev_dbg(dev,
+			"Minimum supported CXL patrol scrub cycle in hour %d\n",
+			min_cycle);
+		return -EINVAL;
+	}
+	wr_cycle = CXL_SET_SCRUB_CYCLE(scrub_cycle_hours);
+
+	return cxl_scrub_set_attrbs(dev, ctx, wr_cycle, flags);
+}
+
+static const struct edac_scrub_ops cxl_ps_scrub_ops = {
+	.get_enabled_bg = cxl_patrol_scrub_get_enabled_bg,
+	.set_enabled_bg = cxl_patrol_scrub_set_enabled_bg,
+	.get_min_cycle = cxl_patrol_scrub_get_min_scrub_cycle,
+	.get_max_cycle = cxl_patrol_scrub_get_max_scrub_cycle,
+	.get_cycle_duration = cxl_patrol_scrub_get_scrub_cycle,
+	.set_cycle_duration = cxl_patrol_scrub_set_scrub_cycle,
+};
+
+static int cxl_memdev_scrub_init(struct cxl_memdev *cxlmd,
+				 struct edac_dev_feature *ras_feature,
+				 u8 scrub_inst)
+{
+	struct cxl_patrol_scrub_context *cxl_ps_ctx;
+	struct cxl_feat_entry *feat_entry;
+	u8 cap, flags;
+	u16 cycle;
+	int rc;
+
+	feat_entry = cxl_feature_info(to_cxlfs(cxlmd->cxlds),
+				      &CXL_FEAT_PATROL_SCRUB_UUID);
+	if (!feat_entry)
+		return -EOPNOTSUPP;
+
+	if (!(le32_to_cpu(feat_entry->flags) & CXL_FEATURE_F_CHANGEABLE))
+		return -EOPNOTSUPP;
+
+	cxl_ps_ctx = devm_kzalloc(&cxlmd->dev, sizeof(*cxl_ps_ctx), GFP_KERNEL);
+	if (!cxl_ps_ctx)
+		return -ENOMEM;
+
+	*cxl_ps_ctx = (struct cxl_patrol_scrub_context){
+		.get_feat_size = le16_to_cpu(feat_entry->get_feat_size),
+		.set_feat_size = le16_to_cpu(feat_entry->set_feat_size),
+		.get_version = feat_entry->get_feat_ver,
+		.set_version = feat_entry->set_feat_ver,
+		.effects = le16_to_cpu(feat_entry->effects),
+		.instance = scrub_inst,
+		.cxlmd = cxlmd,
+	};
+
+	rc = cxl_mem_scrub_get_attrbs(&cxlmd->cxlds->cxl_mbox, &cap, &cycle,
+				      &flags, NULL);
+	if (rc)
+		return rc;
+
+	cxlmd->cur_scrub_cycle = CXL_GET_SCRUB_CYCLE(cycle);
+	cxlmd->cur_region_id = -1;
+
+	ras_feature->ft_type = RAS_FEAT_SCRUB;
+	ras_feature->instance = cxl_ps_ctx->instance;
+	ras_feature->scrub_ops = &cxl_ps_scrub_ops;
+	ras_feature->ctx = cxl_ps_ctx;
+
+	return 0;
+}
+
+static int cxl_region_scrub_init(struct cxl_region *cxlr,
+				 struct edac_dev_feature *ras_feature,
+				 u8 scrub_inst)
+{
+	struct cxl_patrol_scrub_context *cxl_ps_ctx;
+	struct cxl_region_params *p = &cxlr->params;
+	struct cxl_feat_entry *feat_entry = NULL;
+	struct cxl_memdev *cxlmd;
+	u8 cap, flags;
+	u16 cycle;
+	int i, rc;
+
+	/*
+	 * The cxl_region_rwsem must be held if the code below is used in a context
+	 * other than when the region is in the probe state, as shown here.
+	 */
+	for (i = 0; i < p->nr_targets; i++) {
+		struct cxl_endpoint_decoder *cxled = p->targets[i];
+
+		cxlmd = cxled_to_memdev(cxled);
+		feat_entry = cxl_feature_info(to_cxlfs(cxlmd->cxlds),
+					      &CXL_FEAT_PATROL_SCRUB_UUID);
+		if (!feat_entry)
+			return -EOPNOTSUPP;
+
+		if (!(le32_to_cpu(feat_entry->flags) &
+		      CXL_FEATURE_F_CHANGEABLE))
+			return -EOPNOTSUPP;
+
+		rc = cxl_mem_scrub_get_attrbs(&cxlmd->cxlds->cxl_mbox, &cap,
+					      &cycle, &flags, NULL);
+		if (rc)
+			return rc;
+
+		cxlmd->cur_scrub_cycle = CXL_GET_SCRUB_CYCLE(cycle);
+		cxlmd->cur_region_id = -1;
+	}
+
+	cxl_ps_ctx = devm_kzalloc(&cxlr->dev, sizeof(*cxl_ps_ctx), GFP_KERNEL);
+	if (!cxl_ps_ctx)
+		return -ENOMEM;
+
+	*cxl_ps_ctx = (struct cxl_patrol_scrub_context){
+		.get_feat_size = le16_to_cpu(feat_entry->get_feat_size),
+		.set_feat_size = le16_to_cpu(feat_entry->set_feat_size),
+		.get_version = feat_entry->get_feat_ver,
+		.set_version = feat_entry->set_feat_ver,
+		.effects = le16_to_cpu(feat_entry->effects),
+		.instance = scrub_inst,
+		.cxlr = cxlr,
+	};
+
+	ras_feature->ft_type = RAS_FEAT_SCRUB;
+	ras_feature->instance = cxl_ps_ctx->instance;
+	ras_feature->scrub_ops = &cxl_ps_scrub_ops;
+	ras_feature->ctx = cxl_ps_ctx;
+
+	return 0;
+}
+#endif /* CONFIG_CXL_EDAC_SCRUB */
+
+int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd)
+{
+	struct edac_dev_feature ras_features[CXL_NR_EDAC_DEV_FEATURES];
+	int num_ras_features = 0;
+#if defined(CONFIG_CXL_EDAC_SCRUB)
+	int rc;
+#endif
+
+#ifdef CONFIG_CXL_EDAC_SCRUB
+	rc = cxl_memdev_scrub_init(cxlmd, &ras_features[num_ras_features], 0);
+	if (rc < 0 && rc != -EOPNOTSUPP)
+		return rc;
+
+	if (rc != -EOPNOTSUPP)
+		num_ras_features++;
+#endif
+
+	char *cxl_dev_name __free(kfree) =
+		kasprintf(GFP_KERNEL, "cxl_%s", dev_name(&cxlmd->dev));
+	if (!cxl_dev_name)
+		return -ENOMEM;
+
+	return edac_dev_register(&cxlmd->dev, cxl_dev_name, NULL,
+				 num_ras_features, ras_features);
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_memdev_edac_register, "CXL");
+
+int devm_cxl_region_edac_register(struct cxl_region *cxlr)
+{
+#ifdef CONFIG_CXL_EDAC_SCRUB
+	struct edac_dev_feature ras_features[CXL_NR_EDAC_DEV_FEATURES];
+	int num_ras_features = 0;
+	int rc;
+
+	rc = cxl_region_scrub_init(cxlr, &ras_features[num_ras_features], 0);
+	if (rc < 0)
+		return rc;
+
+	num_ras_features++;
+
+	char *cxl_dev_name __free(kfree) =
+		kasprintf(GFP_KERNEL, "cxl_%s", dev_name(&cxlr->dev));
+	if (!cxl_dev_name)
+		return -ENOMEM;
+
+	return edac_dev_register(&cxlr->dev, cxl_dev_name, NULL,
+				 num_ras_features, ras_features);
+#else
+	return 0;
+#endif
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_region_edac_register, "CXL");
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index c3f4dc244df7..d5b8108c4a6d 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3537,8 +3537,18 @@ static int cxl_region_probe(struct device *dev)
 
 	switch (cxlr->mode) {
 	case CXL_PARTMODE_PMEM:
+		rc = devm_cxl_region_edac_register(cxlr);
+		if (rc)
+			dev_dbg(&cxlr->dev, "CXL EDAC registration for region_id=%d failed\n",
+				cxlr->id);
+
 		return devm_cxl_add_pmem_region(cxlr);
 	case CXL_PARTMODE_RAM:
+		rc = devm_cxl_region_edac_register(cxlr);
+		if (rc)
+			dev_dbg(&cxlr->dev, "CXL EDAC registration for region_id=%d failed\n",
+				cxlr->id);
+
 		/*
 		 * The region can not be manged by CXL if any portion of
 		 * it is already online as 'System RAM'
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index a9ab46eb0610..8a252f8483f7 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -912,4 +912,14 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
 
 u16 cxl_gpf_get_dvsec(struct device *dev);
 
+static inline struct rw_semaphore *rwsem_read_intr_acquire(struct rw_semaphore *rwsem)
+{
+	if (down_read_interruptible(rwsem))
+		return NULL;
+
+	return rwsem;
+}
+
+DEFINE_FREE(rwsem_read_release, struct rw_semaphore *, if (_T) up_read(_T))
+
 #endif /* __CXL_H__ */
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 3ec6b906371b..685957b312ea 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -45,6 +45,8 @@
  * @endpoint: connection to the CXL port topology for this memory device
  * @id: id number of this memdev instance.
  * @depth: endpoint port depth
+ * @cur_scrub_cycle: current scrub cycle set for this device
+ * @cur_region_id: id number of a backed region (if any) for which current scrub cycle set
  */
 struct cxl_memdev {
 	struct device dev;
@@ -56,6 +58,10 @@ struct cxl_memdev {
 	struct cxl_port *endpoint;
 	int id;
 	int depth;
+#ifdef CONFIG_CXL_EDAC_SCRUB
+	u8 cur_scrub_cycle;
+	int cur_region_id;
+#endif
 };
 
 static inline struct cxl_memdev *to_cxl_memdev(struct device *dev)
@@ -853,6 +859,16 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
 int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
 int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
 
+#if IS_ENABLED(CONFIG_CXL_EDAC_MEM_FEATURES)
+int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd);
+int devm_cxl_region_edac_register(struct cxl_region *cxlr);
+#else
+static inline int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd)
+{ return 0; }
+static inline int devm_cxl_region_edac_register(struct cxl_region *cxlr)
+{ return 0; }
+#endif
+
 #ifdef CONFIG_CXL_SUSPEND
 void cxl_mem_active_inc(void);
 void cxl_mem_active_dec(void);
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 9675243bd05b..6e6777b7bafb 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -180,6 +180,10 @@ static int cxl_mem_probe(struct device *dev)
 			return rc;
 	}
 
+	rc = devm_cxl_memdev_edac_register(cxlmd);
+	if (rc)
+		dev_dbg(dev, "CXL memdev EDAC registration failed rc=%d\n", rc);
+
 	/*
 	 * The kernel may be operating out of CXL memory on this device,
 	 * there is no spec defined way to determine whether this device
-- 
2.43.0


