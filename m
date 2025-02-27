Return-Path: <linux-edac+bounces-3225-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44934A48BB7
	for <lists+linux-edac@lfdr.de>; Thu, 27 Feb 2025 23:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D70657A46CC
	for <lists+linux-edac@lfdr.de>; Thu, 27 Feb 2025 22:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A39270EC6;
	Thu, 27 Feb 2025 22:39:28 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E4723E356;
	Thu, 27 Feb 2025 22:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740695967; cv=none; b=mcBBBQHgoQ7AOU2F8S475hJ8TkdK/jI7QmRONRBR6VFps/mSHdB+QCOIKY4HXGApCvkYRKwUXqoGOlc/Im5PEguZXlx0689cGG1Zl8TYygL1djtDNwaBYGjw071lLHGDCjVjll0X0eHTd53dzttXqvrDOeNTL9HnTqWzeOz9GFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740695967; c=relaxed/simple;
	bh=Eu5GPMV5GwjsKxZne/JZJ1tltnpCTYvS40AuVLY5zAw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kgwAkJgufbNE39qPqdEJK47mUpbdigB7gOJsXfRLkGKUUG3ux5t4cUGBXxXztt9hm4WIxBR2ae7bLgERmb8KRX3ENbcyEeJlBVXPdEzzZwPmSY2L6sIba63DRqIdZezDzVg11j1+mp7lD6b+szpW9D2e0MxB9E0cV/PHvX8m7P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z3mPx6zCfz6L5Bl;
	Fri, 28 Feb 2025 06:35:33 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id D869D1400DA;
	Fri, 28 Feb 2025 06:39:22 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.149.240) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Feb 2025 23:39:20 +0100
From: <shiju.jose@huawei.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <david@redhat.com>, <Vilas.Sridharan@amd.com>
CC: <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
	<tony.luck@intel.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<mchehab@kernel.org>, <leo.duran@amd.com>, <Yazen.Ghannam@amd.com>,
	<rientjes@google.com>, <jiaqiyan@google.com>, <Jon.Grimm@amd.com>,
	<dave.hansen@linux.intel.com>, <naoya.horiguchi@nec.com>,
	<james.morse@arm.com>, <jthoughton@google.com>, <somasundaram.a@hpe.com>,
	<erdemaktas@google.com>, <pgonda@google.com>, <duenwen@google.com>,
	<gthelen@google.com>, <wschwartz@amperecomputing.com>,
	<dferguson@amperecomputing.com>, <wbs@os.amperecomputing.com>,
	<nifan.cxl@gmail.com>, <yazen.ghannam@amd.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <roberto.sassu@huawei.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH 2/8] cxl/memfeature: Add CXL memory device patrol scrub control feature
Date: Thu, 27 Feb 2025 22:38:09 +0000
Message-ID: <20250227223816.2036-3-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250227223816.2036-1-shiju.jose@huawei.com>
References: <20250227223816.2036-1-shiju.jose@huawei.com>
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
 Documentation/edac/scrub.rst   |  64 +++++
 drivers/cxl/Kconfig            |  18 ++
 drivers/cxl/core/Makefile      |   1 +
 drivers/cxl/core/memfeatures.c | 476 +++++++++++++++++++++++++++++++++
 drivers/cxl/core/region.c      |   5 +
 drivers/cxl/cxlmem.h           |  10 +
 drivers/cxl/mem.c              |   4 +
 7 files changed, 578 insertions(+)
 create mode 100644 drivers/cxl/core/memfeatures.c

diff --git a/Documentation/edac/scrub.rst b/Documentation/edac/scrub.rst
index daab929cdba1..788cf43188a4 100644
--- a/Documentation/edac/scrub.rst
+++ b/Documentation/edac/scrub.rst
@@ -264,3 +264,67 @@ Sysfs files are documented in
 `Documentation/ABI/testing/sysfs-edac-scrub`
 
 `Documentation/ABI/testing/sysfs-edac-ecs`
+
+Examples
+--------
+
+The usage takes the form shown in these examples:
+
+1. CXL memory device patrol scrubber
+
+1.1 Device based scrubbing
+
+1.1.1. Query what is device default/current scrub cycle setting.
+
+# cat /sys/bus/edac/devices/cxl_mem0/scrub0/current_cycle_duration
+
+43200
+
+1.1.2. Query the range of device supported scrub cycle.
+
+# cat /sys/bus/edac/devices/cxl_mem0/scrub0/min_cycle_duration
+
+3600
+
+# cat /sys/bus/edac/devices/cxl_mem0/scrub0/max_cycle_duration
+
+918000
+
+1.1.3. Program scrubbing for a device to repeat every 21600 seconds (quarter of a day).
+
+# echo 21600 > /sys/bus/edac/devices/cxl_mem0/scrub0/current_cycle_duration
+
+# echo 1 > /sys/bus/edac/devices/cxl_mem0/scrub0/enable_background
+
+1.2. Region based scrubbing
+
+CXL memory is exposed to memory management subsystem and ultimately userspace
+via CXL regions.  These can incorporate one or more parts of multiple CXL
+Type 3 devices with traffic interleaved across them. The user may want to
+control the scrub rate via this more abstract region instead of having to
+figure out the constituent devices and program them separately. The scrub
+rate for each device covers the whole device. Thus if multiple regions use
+parts of that device then requests for scrubbing of other regions may result
+in a higher scrub rate than requested for this specific region.
+
+1.2.1 Query what is device default/current scrub cycle setting for a CXL memory region.
+
+# cat /sys/bus/edac/devices/cxl_region0/scrub0/current_cycle_duration
+
+86400
+
+1.2.2 Query the range of device supported scrub cycle for a CXL memory region.
+
+# cat /sys/bus/edac/devices/cxl_region0/scrub0/min_cycle_duration
+
+3600
+
+# cat /sys/bus/edac/devices/cxl_region0/scrub0/max_cycle_duration
+
+918000
+
+1.2.3 Program scrubbing for a region to repeat every 43200 seconds (half a day)
+
+# echo  43200 > /sys/bus/edac/devices/cxl_region0/scrub0/current_cycle_duration
+
+# echo 1 > /sys/bus/edac/devices/cxl_region0/scrub0/enable_background
diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 205547e5543a..b83bdb30b702 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -113,6 +113,24 @@ config CXL_FEATURES
 
 	  If unsure say 'n'
 
+config CXL_RAS_FEATURES
+	bool "CXL: Memory RAS features"
+	depends on CXL_MEM
+	depends on CXL_FEATURES
+	depends on EDAC=y || (CXL_BUS=m && EDAC=m)
+	depends on EDAC_SCRUB
+	help
+	  The CXL memory RAS feature control is optional and allows host to
+	  control the RAS features configurations of CXL Type 3 devices.
+
+	  It registers with the EDAC device subsystem to expose control
+	  attributes of CXL memory device's RAS features to the user.
+	  It provides interface functions to support configuring the CXL
+	  memory device's RAS features.
+	  Say 'y/m' if you have an expert need to change default settings
+	  of a memory RAS feature established by the platform/device (eg.
+	  scrub rates for the patrol scrub feature). otherwise say 'n'.
+
 config CXL_PORT
 	default CXL_BUS
 	tristate
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index e1d591e52d4b..2f48845b86d7 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -18,4 +18,5 @@ cxl_core-y += acpi.o
 cxl_core-$(CONFIG_TRACING) += trace.o
 cxl_core-$(CONFIG_CXL_REGION) += region.o
 cxl_core-$(CONFIG_CXL_FEATURES) += features.o
+cxl_core-$(CONFIG_CXL_RAS_FEATURES) += memfeatures.o
 cxl_core-$(CONFIG_CXL_MCE) += mce.o
diff --git a/drivers/cxl/core/memfeatures.c b/drivers/cxl/core/memfeatures.c
new file mode 100644
index 000000000000..7a5c0645a07e
--- /dev/null
+++ b/drivers/cxl/core/memfeatures.c
@@ -0,0 +1,476 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * CXL memory RAS feature driver.
+ *
+ * Copyright (c) 2024-2025 HiSilicon Limited.
+ *
+ *  - Supports functions to configure RAS features of the
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
+#define CXL_DEV_NUM_RAS_FEATURES	1
+#define CXL_DEV_HOUR_IN_SECS	3600
+
+#define CXL_DEV_NAME_LEN	128
+
+static int cxl_hold_region_and_dpa(void)
+{
+	int rc;
+
+	rc = down_read_interruptible(&cxl_region_rwsem);
+	if (rc)
+		return rc;
+
+	rc = down_read_interruptible(&cxl_dpa_rwsem);
+	if (rc) {
+		up_read(&cxl_region_rwsem);
+		return rc;
+	}
+
+	return 0;
+}
+
+static void cxl_release_region_and_dpa(void)
+{
+	up_read(&cxl_dpa_rwsem);
+	up_read(&cxl_region_rwsem);
+}
+
+/*
+ * CXL memory patrol scrub control functions
+ */
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
+/**
+ * struct cxl_memdev_ps_params - CXL memory patrol scrub parameter data structure.
+ * @enable:     [IN & OUT] enable(1)/disable(0) patrol scrub.
+ * @scrub_cycle_changeable: [OUT] scrub cycle attribute of patrol scrub is changeable.
+ * @scrub_cycle_hrs:    [IN] Requested patrol scrub cycle in hours.
+ *                      [OUT] Current patrol scrub cycle in hours.
+ * @min_scrub_cycle_hrs:[OUT] minimum patrol scrub cycle in hours supported.
+ */
+struct cxl_memdev_ps_params {
+	bool enable;
+	bool scrub_cycle_changeable;
+	u8 scrub_cycle_hrs;
+	u8 min_scrub_cycle_hrs;
+};
+
+enum cxl_scrub_param {
+	CXL_PS_PARAM_ENABLE,
+	CXL_PS_PARAM_SCRUB_CYCLE,
+};
+
+#define CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_MASK	BIT(0)
+#define	CXL_MEMDEV_PS_SCRUB_CYCLE_REALTIME_REPORT_CAP_MASK	BIT(1)
+#define	CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK	GENMASK(7, 0)
+#define	CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_MASK	GENMASK(15, 8)
+#define	CXL_MEMDEV_PS_FLAG_ENABLED_MASK	BIT(0)
+
+/*
+ * See CXL spec rev 3.2 @8.2.10.9.11.1 Table 8-222 Device Patrol Scrub Control
+ * Feature Readable Attributes.
+ */
+struct cxl_memdev_ps_rd_attrs {
+	u8 scrub_cycle_cap;
+	__le16 scrub_cycle_hrs;
+	u8 scrub_flags;
+}  __packed;
+
+/*
+ * See CXL spec rev 3.2 @8.2.10.9.11.1 Table 8-223 Device Patrol Scrub Control
+ * Feature Writable Attributes.
+ */
+struct cxl_memdev_ps_wr_attrs {
+	u8 scrub_cycle_hrs;
+	u8 scrub_flags;
+}  __packed;
+
+static int cxl_mem_ps_get_attrs(struct cxl_mailbox *cxl_mbox,
+				struct cxl_memdev_ps_params *params)
+{
+	size_t rd_data_size = sizeof(struct cxl_memdev_ps_rd_attrs);
+	u16 scrub_cycle_hrs;
+	size_t data_size;
+	struct cxl_memdev_ps_rd_attrs *rd_attrs __free(kfree) =
+		kzalloc(rd_data_size, GFP_KERNEL);
+	if (!rd_attrs)
+		return -ENOMEM;
+
+	data_size = cxl_get_feature(cxl_mbox, &CXL_FEAT_PATROL_SCRUB_UUID,
+				    CXL_GET_FEAT_SEL_CURRENT_VALUE,
+				    rd_attrs, rd_data_size, 0, NULL);
+	if (!data_size)
+		return -EIO;
+
+	params->scrub_cycle_changeable = FIELD_GET(CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_MASK,
+						   rd_attrs->scrub_cycle_cap);
+	params->enable = FIELD_GET(CXL_MEMDEV_PS_FLAG_ENABLED_MASK,
+				   rd_attrs->scrub_flags);
+	scrub_cycle_hrs = le16_to_cpu(rd_attrs->scrub_cycle_hrs);
+	params->scrub_cycle_hrs = FIELD_GET(CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK,
+					    scrub_cycle_hrs);
+	params->min_scrub_cycle_hrs = FIELD_GET(CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_MASK,
+						scrub_cycle_hrs);
+
+	return 0;
+}
+
+static int cxl_ps_get_attrs(struct cxl_patrol_scrub_context *cxl_ps_ctx,
+			    struct cxl_memdev_ps_params *params)
+{
+	struct cxl_mailbox *cxl_mbox;
+	struct cxl_memdev *cxlmd;
+	u16 min_scrub_cycle = 0;
+	int i, ret;
+
+	if (cxl_ps_ctx->cxlr) {
+		struct cxl_region *cxlr = cxl_ps_ctx->cxlr;
+		struct cxl_region_params *p = &cxlr->params;
+
+		ret = cxl_hold_region_and_dpa();
+		if (ret)
+			return ret;
+		for (i = p->interleave_ways - 1; i >= 0; i--) {
+			struct cxl_endpoint_decoder *cxled = p->targets[i];
+
+			cxlmd = cxled_to_memdev(cxled);
+			cxl_mbox = &cxlmd->cxlds->cxl_mbox;
+			ret = cxl_mem_ps_get_attrs(cxl_mbox, params);
+			if (ret)
+				return ret;
+
+			if (params->min_scrub_cycle_hrs > min_scrub_cycle)
+				min_scrub_cycle = params->min_scrub_cycle_hrs;
+		}
+		cxl_release_region_and_dpa();
+
+		params->min_scrub_cycle_hrs = min_scrub_cycle;
+		return 0;
+	}
+	cxl_mbox = &cxl_ps_ctx->cxlmd->cxlds->cxl_mbox;
+
+	return cxl_mem_ps_get_attrs(cxl_mbox, params);
+}
+
+static int cxl_mem_ps_set_attrs(struct device *dev,
+				struct cxl_patrol_scrub_context *cxl_ps_ctx,
+				struct cxl_mailbox *cxl_mbox,
+				struct cxl_memdev_ps_params *params,
+				enum cxl_scrub_param param_type)
+{
+	struct cxl_memdev_ps_wr_attrs wr_attrs;
+	struct cxl_memdev_ps_params rd_params;
+	int ret;
+
+	ret = cxl_mem_ps_get_attrs(cxl_mbox, &rd_params);
+	if (ret) {
+		dev_dbg(dev, "Get cxlmemdev patrol scrub params failed ret=%d\n", ret);
+		return ret;
+	}
+
+	switch (param_type) {
+	case CXL_PS_PARAM_ENABLE:
+		wr_attrs.scrub_flags = FIELD_PREP(CXL_MEMDEV_PS_FLAG_ENABLED_MASK,
+						  params->enable);
+		wr_attrs.scrub_cycle_hrs = FIELD_PREP(CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK,
+						      rd_params.scrub_cycle_hrs);
+		break;
+	case CXL_PS_PARAM_SCRUB_CYCLE:
+		if (params->scrub_cycle_hrs < rd_params.min_scrub_cycle_hrs) {
+			dev_dbg(dev, "Invalid CXL patrol scrub cycle(%d) to set\n",
+				params->scrub_cycle_hrs);
+			dev_dbg(dev, "Minimum supported CXL patrol scrub cycle in hour %d\n",
+				rd_params.min_scrub_cycle_hrs);
+			return -EINVAL;
+		}
+		wr_attrs.scrub_cycle_hrs = FIELD_PREP(CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK,
+						      params->scrub_cycle_hrs);
+		wr_attrs.scrub_flags = FIELD_PREP(CXL_MEMDEV_PS_FLAG_ENABLED_MASK,
+						  rd_params.enable);
+		break;
+	}
+
+	ret = cxl_set_feature(cxl_mbox, &CXL_FEAT_PATROL_SCRUB_UUID,
+			      cxl_ps_ctx->set_version,
+			      &wr_attrs, sizeof(wr_attrs),
+			      CXL_SET_FEAT_FLAG_DATA_SAVED_ACROSS_RESET,
+			      0, NULL);
+	if (ret) {
+		dev_dbg(dev, "CXL patrol scrub set feature failed ret=%d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int cxl_ps_set_attrs(struct device *dev,
+			    struct cxl_patrol_scrub_context *cxl_ps_ctx,
+			    struct cxl_memdev_ps_params *params,
+			    enum cxl_scrub_param param_type)
+{
+	struct cxl_mailbox *cxl_mbox;
+	struct cxl_memdev *cxlmd;
+	int ret, i;
+
+	if (cxl_ps_ctx->cxlr) {
+		struct cxl_region *cxlr = cxl_ps_ctx->cxlr;
+		struct cxl_region_params *p = &cxlr->params;
+
+		ret = cxl_hold_region_and_dpa();
+		if (ret)
+			return ret;
+		for (i = p->interleave_ways - 1; i >= 0; i--) {
+			struct cxl_endpoint_decoder *cxled = p->targets[i];
+
+			cxlmd = cxled_to_memdev(cxled);
+			cxl_mbox = &cxlmd->cxlds->cxl_mbox;
+			ret = cxl_mem_ps_set_attrs(dev, cxl_ps_ctx, cxl_mbox,
+						   params, param_type);
+			if (ret)
+				return ret;
+		}
+		cxl_release_region_and_dpa();
+
+		return 0;
+	}
+	cxl_mbox = &cxl_ps_ctx->cxlmd->cxlds->cxl_mbox;
+
+	return cxl_mem_ps_set_attrs(dev, cxl_ps_ctx, cxl_mbox,
+				    params, param_type);
+}
+
+static int cxl_patrol_scrub_get_enabled_bg(struct device *dev, void *drv_data, bool *enabled)
+{
+	struct cxl_patrol_scrub_context *ctx = drv_data;
+	struct cxl_memdev_ps_params params;
+	int ret;
+
+	ret = cxl_ps_get_attrs(ctx, &params);
+	if (ret)
+		return ret;
+
+	*enabled = params.enable;
+
+	return 0;
+}
+
+static int cxl_patrol_scrub_set_enabled_bg(struct device *dev, void *drv_data, bool enable)
+{
+	struct cxl_patrol_scrub_context *ctx = drv_data;
+	struct cxl_memdev_ps_params params = {
+		.enable = enable,
+	};
+
+	return cxl_ps_set_attrs(dev, ctx, &params, CXL_PS_PARAM_ENABLE);
+}
+
+static int cxl_patrol_scrub_read_min_scrub_cycle(struct device *dev, void *drv_data,
+						 u32 *min)
+{
+	struct cxl_patrol_scrub_context *ctx = drv_data;
+	struct cxl_memdev_ps_params params;
+	int ret;
+
+	ret = cxl_ps_get_attrs(ctx, &params);
+	if (ret)
+		return ret;
+	*min = params.min_scrub_cycle_hrs * CXL_DEV_HOUR_IN_SECS;
+
+	return 0;
+}
+
+static int cxl_patrol_scrub_read_max_scrub_cycle(struct device *dev, void *drv_data,
+						 u32 *max)
+{
+	*max = U8_MAX * CXL_DEV_HOUR_IN_SECS; /* Max set by register size */
+
+	return 0;
+}
+
+static int cxl_patrol_scrub_read_scrub_cycle(struct device *dev, void *drv_data,
+					     u32 *scrub_cycle_secs)
+{
+	struct cxl_patrol_scrub_context *ctx = drv_data;
+	struct cxl_memdev_ps_params params;
+	int ret;
+
+	ret = cxl_ps_get_attrs(ctx, &params);
+	if (ret)
+		return ret;
+
+	*scrub_cycle_secs = params.scrub_cycle_hrs * CXL_DEV_HOUR_IN_SECS;
+
+	return 0;
+}
+
+static int cxl_patrol_scrub_write_scrub_cycle(struct device *dev, void *drv_data,
+					      u32 scrub_cycle_secs)
+{
+	struct cxl_patrol_scrub_context *ctx = drv_data;
+	struct cxl_memdev_ps_params params = {
+		.scrub_cycle_hrs = scrub_cycle_secs / CXL_DEV_HOUR_IN_SECS,
+	};
+
+	return cxl_ps_set_attrs(dev, ctx, &params, CXL_PS_PARAM_SCRUB_CYCLE);
+}
+
+static const struct edac_scrub_ops cxl_ps_scrub_ops = {
+	.get_enabled_bg = cxl_patrol_scrub_get_enabled_bg,
+	.set_enabled_bg = cxl_patrol_scrub_set_enabled_bg,
+	.get_min_cycle = cxl_patrol_scrub_read_min_scrub_cycle,
+	.get_max_cycle = cxl_patrol_scrub_read_max_scrub_cycle,
+	.get_cycle_duration = cxl_patrol_scrub_read_scrub_cycle,
+	.set_cycle_duration = cxl_patrol_scrub_write_scrub_cycle,
+};
+
+static int cxl_memdev_scrub_init(struct cxl_memdev *cxlmd,
+				 struct edac_dev_feature *ras_feature, u8 scrub_inst)
+{
+	struct cxl_patrol_scrub_context *cxl_ps_ctx;
+	struct cxl_feat_entry *feat_entry;
+
+	feat_entry = cxl_get_feature_entry(cxlmd->cxlds, &CXL_FEAT_PATROL_SCRUB_UUID);
+	if (IS_ERR(feat_entry))
+		return -EOPNOTSUPP;
+
+	if (!(le32_to_cpu(feat_entry->flags) & CXL_FEATURE_F_CHANGEABLE))
+		return -EOPNOTSUPP;
+
+	cxl_ps_ctx = devm_kzalloc(&cxlmd->dev, sizeof(*cxl_ps_ctx), GFP_KERNEL);
+	if (!cxl_ps_ctx)
+		return -ENOMEM;
+
+	*cxl_ps_ctx = (struct cxl_patrol_scrub_context) {
+		.get_feat_size = le16_to_cpu(feat_entry->get_feat_size),
+		.set_feat_size = le16_to_cpu(feat_entry->set_feat_size),
+		.get_version = feat_entry->get_feat_ver,
+		.set_version = feat_entry->set_feat_ver,
+		.effects = le16_to_cpu(feat_entry->effects),
+		.instance = scrub_inst,
+		.cxlmd = cxlmd,
+	};
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
+				 struct edac_dev_feature *ras_feature, u8 scrub_inst)
+{
+	struct cxl_patrol_scrub_context *cxl_ps_ctx;
+	struct cxl_region_params *p = &cxlr->params;
+	struct cxl_feat_entry *feat_entry = NULL;
+	struct cxl_memdev *cxlmd;
+	int i;
+
+	/*
+	 * The cxl_region_rwsem must be held if the code below is used in a context
+	 * other than when the region is in the probe state, as shown here.
+	 */
+	for (i = p->interleave_ways - 1; i >= 0; i--) {
+		struct cxl_endpoint_decoder *cxled = p->targets[i];
+
+		cxlmd = cxled_to_memdev(cxled);
+		feat_entry = cxl_get_feature_entry(cxlmd->cxlds, &CXL_FEAT_PATROL_SCRUB_UUID);
+		if (IS_ERR(feat_entry))
+			return -EOPNOTSUPP;
+
+		if (!(le32_to_cpu(feat_entry->flags) & CXL_FEATURE_F_CHANGEABLE))
+			return -EOPNOTSUPP;
+	}
+	if (!feat_entry)
+		return -EOPNOTSUPP;
+
+	cxl_ps_ctx = devm_kzalloc(&cxlr->dev, sizeof(*cxl_ps_ctx), GFP_KERNEL);
+	if (!cxl_ps_ctx)
+		return -ENOMEM;
+
+	*cxl_ps_ctx = (struct cxl_patrol_scrub_context) {
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
+
+int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd)
+{
+	struct edac_dev_feature ras_features[CXL_DEV_NUM_RAS_FEATURES];
+	char cxl_dev_name[CXL_DEV_NAME_LEN];
+	int num_ras_features = 0;
+	u8 scrub_inst = 0;
+	int rc;
+
+	rc = cxl_memdev_scrub_init(cxlmd, &ras_features[num_ras_features],
+				   scrub_inst);
+	if (rc < 0 && rc != -EOPNOTSUPP)
+		return rc;
+
+	if (rc != -EOPNOTSUPP)
+		num_ras_features++;
+
+	snprintf(cxl_dev_name, sizeof(cxl_dev_name), "%s_%s",
+		 "cxl", dev_name(&cxlmd->dev));
+
+	return edac_dev_register(&cxlmd->dev, cxl_dev_name, NULL,
+				 num_ras_features, ras_features);
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_memdev_edac_register, "CXL");
+
+int devm_cxl_region_edac_register(struct cxl_region *cxlr)
+{
+	struct edac_dev_feature ras_features[CXL_DEV_NUM_RAS_FEATURES];
+	char cxl_dev_name[CXL_DEV_NAME_LEN];
+	int num_ras_features = 0;
+	u8 scrub_inst = 0;
+	int rc;
+
+	rc = cxl_region_scrub_init(cxlr, &ras_features[num_ras_features],
+				   scrub_inst);
+	if (rc < 0)
+		return rc;
+
+	num_ras_features++;
+
+	snprintf(cxl_dev_name, sizeof(cxl_dev_name), "%s_%s",
+		 "cxl", dev_name(&cxlr->dev));
+
+	return edac_dev_register(&cxlr->dev, cxl_dev_name, NULL,
+				 num_ras_features, ras_features);
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_region_edac_register, "CXL");
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index a83301f24fa2..9e7b716296d7 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3545,6 +3545,11 @@ static int cxl_region_probe(struct device *dev)
 	case CXL_PARTMODE_PMEM:
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
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 3ec6b906371b..a08405f94a30 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -853,6 +853,16 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
 int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
 int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
 
+#if IS_ENABLED(CONFIG_CXL_RAS_FEATURES)
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


