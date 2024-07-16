Return-Path: <linux-edac+bounces-1526-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F0C932A02
	for <lists+linux-edac@lfdr.de>; Tue, 16 Jul 2024 17:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A435A1C23520
	for <lists+linux-edac@lfdr.de>; Tue, 16 Jul 2024 15:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1967A1A0734;
	Tue, 16 Jul 2024 15:04:44 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27B61A0710;
	Tue, 16 Jul 2024 15:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721142284; cv=none; b=CyLnasdvMOMqBy1W+6y5Heq9Oui9wC+xU5riSwOjm0HYdYsAyvCR0BCpN9YYMfhUl/7RAJHKm3x1wUJ9QsJ+47966vx82H4FbkFDTcgXPyk+ZrF9U8FyXvo0GkuF89BIyLO19n0AHVDTKXIF26RS7M6d4PySxijKPPouGSLYLW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721142284; c=relaxed/simple;
	bh=33CYDBRjSDsb2iRE5xZkwW/WFpfHeWQhhLvI03J3t70=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AQJRAH+Mt/7KDCWl7vccNpViYVwKOnF6XGPl/GQ7IRlWcG6pqMJhMI8TSqBp5wC0S3pfhr5p00iYy6DD0MB2X1TR1nqIW9uhDZMSl82CFAOKReNn+UG5n6xVnVbadkboEwrVtOiTqKJiU3Nf6nAhX5bNbvEBarW2UFrz5bTqQS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WNj4W37Xzz6JB5G;
	Tue, 16 Jul 2024 23:03:23 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id 35F2D1400DB;
	Tue, 16 Jul 2024 23:04:39 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.159.153) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 16 Jul 2024 16:04:37 +0100
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
Subject: [RFC PATCH v9 07/11] cxl/memscrub: Add CXL memory device patrol scrub control feature
Date: Tue, 16 Jul 2024 16:03:31 +0100
Message-ID: <20240716150336.2042-8-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240716150336.2042-1-shiju.jose@huawei.com>
References: <20240716150336.2042-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500006.china.huawei.com (7.191.161.198)

From: Shiju Jose <shiju.jose@huawei.com>

CXL spec 3.1 section 8.2.9.9.11.1 describes the device patrol scrub control
feature. The device patrol scrub proactively locates and makes corrections
to errors in regular cycle.

Allow specifying the number of hours within which the patrol scrub must be
completed, subject to minimum and maximum limits reported by the device.
Also allow disabling scrub allowing trade-off error rates against
performance.

Add support for CXL memory device based patrol scrub control.
Register with EDAC RAS control feature driver, which gets the scrub attr
descriptors from the EDAC scrub and expose sysfs scrub control attributes
to the userspace.
For example CXL device based scrub control for the CXL mem0 device is exposed
in /sys/bus/edac/devices/cxl_mem0/scrub/

Also add support for region based CXL memory patrol scrub control.
CXL memory region may be interleaved across one or more CXL memory devices.
For example region based scrub control for CXL region1 is exposed in
/sys/bus/edac/devices/cxl_region1/scrub/

Open Questions:
Q1: CXL 3.1 spec defined patrol scrub control feature at CXL memory devices with
supporting set scrub cycle and enable/disable scrub. but not based on HPA range.
Thus presently scrub control for a region is implemented based on all associated
CXL memory devices.
What is the exact use case for the CXL region based scrub control?
How the HPA range, which Dan asked for region based scrubbing is used?
Does spec change is required for patrol scrub control feature with support
for setting the HPA range?

Q2: Both CXL device based and CXL region based scrub control would be enabled
      at the same time in a system?

Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 Documentation/scrub/edac-scrub.rst |  70 +++++
 drivers/cxl/Kconfig                |  19 ++
 drivers/cxl/core/Makefile          |   1 +
 drivers/cxl/core/memscrub.c        | 413 +++++++++++++++++++++++++++++
 drivers/cxl/core/region.c          |   6 +
 drivers/cxl/cxlmem.h               |   8 +
 drivers/cxl/mem.c                  |   4 +
 7 files changed, 521 insertions(+)
 create mode 100644 Documentation/scrub/edac-scrub.rst
 create mode 100644 drivers/cxl/core/memscrub.c

diff --git a/Documentation/scrub/edac-scrub.rst b/Documentation/scrub/edac-scrub.rst
new file mode 100644
index 000000000000..cf7d8b130204
--- /dev/null
+++ b/Documentation/scrub/edac-scrub.rst
@@ -0,0 +1,70 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===================
+EDAC Scrub control
+===================
+
+Copyright (c) 2024 HiSilicon Limited.
+
+:Author:   Shiju Jose <shiju.jose@huawei.com>
+:License:  The GNU Free Documentation License, Version 1.2
+          (dual licensed under the GPL v2)
+:Original Reviewers:
+
+- Written for: 6.12
+- Updated for:
+
+Introduction
+------------
+The edac scrub driver provides interfaces for controlling the
+memory scrubbers in the system. The scrub device drivers in the
+system register with the edac scrub. The driver exposes the
+scrub controls to the user in the sysfs.
+
+The File System
+---------------
+
+The control attributes of the registered scrubbers could be
+accessed in the /sys/bus/edac/devices/<dev-name>/scrub/
+
+sysfs
+-----
+
+Sysfs files are documented in
+`Documentation/ABI/testing/sysfs-edac-scrub-control`.
+
+Example
+-------
+
+The usage takes the form shown in this example::
+
+1. CXL memory device patrol scrubber
+1.1 device based
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/scrub/cycle_in_hours_range
+0x1-0xff
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/scrub/cycle_in_hours
+0xc
+root@localhost:~# echo 30 > /sys/bus/edac/devices/cxl_mem0/scrub/cycle_in_hours
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/scrub/cycle_in_hours
+0x1e
+root@localhost:~# echo 1 > /sys/bus/edac/devices/cxl_mem0/scrub/enable_background
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/scrub/enable_background
+1
+root@localhost:~# echo 0 > /sys/bus/edac/devices/cxl_mem0/scrub/enable_background
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/scrub/enable_background
+0
+
+1.2. region based
+root@localhost:~# cat /sys/bus/edac/devices/cxl_region0/scrub/cycle_in_hours_range
+0x1-0xff
+root@localhost:~# cat /sys/bus/edac/devices/cxl_region0/scrub/cycle_in_hours
+0xc
+root@localhost:~# echo 30 > /sys/bus/edac/devices/cxl_region0/scrub/cycle_in_hours
+root@localhost:~# cat /sys/bus/edac/devices/cxl_region0/scrub/cycle_in_hours
+0x1e
+root@localhost:~# echo 1 > /sys/bus/edac/devices/cxl_region0/scrub/enable_background
+root@localhost:~# cat /sys/bus/edac/devices/cxl_region0/scrub/enable_background
+1
+root@localhost:~# echo 0 > /sys/bus/edac/devices/cxl_region0/scrub/enable_background
+root@localhost:~# cat /sys/bus/edac/devices/cxl_region0/scrub/enable_background
+0
diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 99b5c25be079..7da70685a2db 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -145,4 +145,23 @@ config CXL_REGION_INVALIDATION_TEST
 	  If unsure, or if this kernel is meant for production environments,
 	  say N.
 
+config CXL_SCRUB
+	bool "CXL: Memory scrub feature"
+	depends on CXL_PCI
+	depends on CXL_MEM
+	depends on EDAC
+	help
+	  The CXL memory scrub control is an optional feature allows host to
+	  control the scrub configurations of CXL Type 3 devices, which
+	  supports patrol scrubbing.
+
+	  Registers with the scrub subsystem to provide control attributes
+	  of CXL memory device scrubber to the user.
+	  Provides interface functions to support configuring the CXL memory
+	  device patrol scrubber.
+
+	  Say 'y/n' to enable/disable control of memory scrub parameters for
+	  CXL.mem devices. See section 8.2.9.9.11.1 of CXL 3.1 specification
+	  for detailed description of CXL memory patrol scrub control feature.
+
 endif
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 9259bcc6773c..e0fc814c3983 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -16,3 +16,4 @@ cxl_core-y += pmu.o
 cxl_core-y += cdat.o
 cxl_core-$(CONFIG_TRACING) += trace.o
 cxl_core-$(CONFIG_CXL_REGION) += region.o
+cxl_core-$(CONFIG_CXL_SCRUB) += memscrub.o
diff --git a/drivers/cxl/core/memscrub.c b/drivers/cxl/core/memscrub.c
new file mode 100644
index 000000000000..430f85b01f6c
--- /dev/null
+++ b/drivers/cxl/core/memscrub.c
@@ -0,0 +1,413 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * CXL memory scrub driver.
+ *
+ * Copyright (c) 2024 HiSilicon Limited.
+ *
+ *  - Provides functions to configure patrol scrub feature of the
+ *    CXL memory devices.
+ *  - Registers with the scrub subsystem driver to expose the sysfs attributes
+ *    to the user for configuring the CXL memory patrol scrub feature.
+ */
+
+#define pr_fmt(fmt)	"CXL_MEM_SCRUB: " fmt
+
+#include <cxlmem.h>
+#include <linux/cleanup.h>
+#include <linux/limits.h>
+#include <cxl.h>
+#include <linux/edac_ras_feature.h>
+
+#define CXL_DEV_NUM_RAS_FEATURES	2
+
+/*ToDo: This reusable function will be moved to a common file */
+static int cxl_mem_get_supported_feature_entry(struct cxl_memdev *cxlmd, const uuid_t *feat_uuid,
+					       struct cxl_mbox_supp_feat_entry *feat_entry_out)
+{
+	struct cxl_mbox_supp_feat_entry *feat_entry;
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	int feat_index, feats_out_size;
+	int nentries, count;
+	int ret;
+
+	feat_index = 0;
+	feats_out_size = sizeof(struct cxl_mbox_get_supp_feats_out) +
+			  sizeof(struct cxl_mbox_supp_feat_entry);
+	struct cxl_mbox_get_supp_feats_out *feats_out __free(kfree) =
+					kmalloc(feats_out_size, GFP_KERNEL);
+	if (!feats_out)
+		return -ENOMEM;
+
+	while (true) {
+		memset(feats_out, 0, feats_out_size);
+		ret = cxl_get_supported_features(mds, feats_out_size,
+						 feat_index, feats_out);
+		if (ret)
+			return ret;
+
+		nentries = feats_out->nr_entries;
+		if (!nentries)
+			return -EOPNOTSUPP;
+
+		/* Check CXL memdev supports the feature */
+		feat_entry = feats_out->feat_entries;
+		for (count = 0; count < nentries; count++, feat_entry++) {
+			if (uuid_equal(&feat_entry->uuid, feat_uuid)) {
+				memcpy(feat_entry_out, feat_entry,
+				       sizeof(*feat_entry_out));
+				return 0;
+			}
+		}
+		feat_index += nentries;
+	}
+}
+
+#define CXL_SCRUB_NAME_LEN	128
+
+/* CXL memory patrol scrub control definitions */
+#define CXL_MEMDEV_PS_GET_FEAT_VERSION	0x01
+#define CXL_MEMDEV_PS_SET_FEAT_VERSION	0x01
+
+static const uuid_t cxl_patrol_scrub_uuid =
+	UUID_INIT(0x96dad7d6, 0xfde8, 0x482b, 0xa7, 0x33, 0x75, 0x77, 0x4e,     \
+		  0x06, 0xdb, 0x8a);
+
+/* CXL memory patrol scrub control functions */
+struct cxl_patrol_scrub_context {
+	u16 get_feat_size;
+	u16 set_feat_size;
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
+	u16 scrub_cycle_hrs;
+	u16 min_scrub_cycle_hrs;
+};
+
+enum cxl_scrub_param {
+	cxl_ps_param_enable,
+	cxl_ps_param_scrub_cycle,
+};
+
+#define	CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_MASK	BIT(0)
+#define	CXL_MEMDEV_PS_SCRUB_CYCLE_REALTIME_REPORT_CAP_MASK	BIT(1)
+#define	CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK	GENMASK(7, 0)
+#define	CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_MASK	GENMASK(15, 8)
+#define	CXL_MEMDEV_PS_FLAG_ENABLED_MASK	BIT(0)
+
+struct cxl_memdev_ps_rd_attrs {
+	u8 scrub_cycle_cap;
+	__le16 scrub_cycle_hrs;
+	u8 scrub_flags;
+}  __packed;
+
+struct cxl_memdev_ps_wr_attrs {
+	u8 scrub_cycle_hrs;
+	u8 scrub_flags;
+}  __packed;
+
+static int cxl_mem_ps_get_attrs(struct cxl_memdev_state *mds,
+				struct cxl_memdev_ps_params *params)
+{
+	size_t rd_data_size = sizeof(struct cxl_memdev_ps_rd_attrs);
+	size_t data_size;
+	struct cxl_memdev_ps_rd_attrs *rd_attrs __free(kfree) =
+						kmalloc(rd_data_size, GFP_KERNEL);
+	if (!rd_attrs)
+		return -ENOMEM;
+
+	data_size = cxl_get_feature(mds, cxl_patrol_scrub_uuid, rd_attrs,
+				    rd_data_size, CXL_GET_FEAT_SEL_CURRENT_VALUE);
+	if (!data_size)
+		return -EIO;
+
+	params->scrub_cycle_changeable = FIELD_GET(CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_MASK,
+						   rd_attrs->scrub_cycle_cap);
+	params->enable = FIELD_GET(CXL_MEMDEV_PS_FLAG_ENABLED_MASK,
+				   rd_attrs->scrub_flags);
+	params->scrub_cycle_hrs = FIELD_GET(CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK,
+					    rd_attrs->scrub_cycle_hrs);
+	params->min_scrub_cycle_hrs = FIELD_GET(CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_MASK,
+						rd_attrs->scrub_cycle_hrs);
+
+	return 0;
+}
+
+static int cxl_ps_get_attrs(struct device *dev, void *drv_data,
+			    struct cxl_memdev_ps_params *params)
+{
+	struct cxl_patrol_scrub_context *cxl_ps_ctx = drv_data;
+	struct cxl_memdev *cxlmd;
+	struct cxl_dev_state *cxlds;
+	struct cxl_memdev_state *mds;
+	u16 min_scrub_cycle = 0;
+	int i, ret;
+
+	if (cxl_ps_ctx->cxlr) {
+		struct cxl_region *cxlr = cxl_ps_ctx->cxlr;
+		struct cxl_region_params *p = &cxlr->params;
+
+		for (i = p->interleave_ways - 1; i >= 0; i--) {
+			struct cxl_endpoint_decoder *cxled = p->targets[i];
+
+			cxlmd = cxled_to_memdev(cxled);
+			cxlds = cxlmd->cxlds;
+			mds = to_cxl_memdev_state(cxlds);
+			ret = cxl_mem_ps_get_attrs(mds, params);
+			if (ret)
+				return ret;
+
+			if (params->min_scrub_cycle_hrs > min_scrub_cycle)
+				min_scrub_cycle = params->min_scrub_cycle_hrs;
+		}
+		params->min_scrub_cycle_hrs = min_scrub_cycle;
+		return 0;
+	}
+	cxlmd = cxl_ps_ctx->cxlmd;
+	cxlds = cxlmd->cxlds;
+	mds = to_cxl_memdev_state(cxlds);
+
+	return cxl_mem_ps_get_attrs(mds, params);
+}
+
+static int cxl_mem_ps_set_attrs(struct device *dev, struct cxl_memdev_state *mds,
+				struct cxl_memdev_ps_params *params,
+				enum cxl_scrub_param param_type)
+{
+	struct cxl_memdev_ps_wr_attrs wr_attrs;
+	struct cxl_memdev_ps_params rd_params;
+	int ret;
+
+	ret = cxl_mem_ps_get_attrs(mds, &rd_params);
+	if (ret) {
+		dev_err(dev, "Get cxlmemdev patrol scrub params failed ret=%d\n",
+			ret);
+		return ret;
+	}
+
+	switch (param_type) {
+	case cxl_ps_param_enable:
+		wr_attrs.scrub_flags = FIELD_PREP(CXL_MEMDEV_PS_FLAG_ENABLED_MASK,
+						   params->enable);
+		wr_attrs.scrub_cycle_hrs = FIELD_PREP(CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK,
+						      rd_params.scrub_cycle_hrs);
+		break;
+	case cxl_ps_param_scrub_cycle:
+		if (params->scrub_cycle_hrs < rd_params.min_scrub_cycle_hrs) {
+			dev_err(dev, "Invalid CXL patrol scrub cycle(%d) to set\n",
+				params->scrub_cycle_hrs);
+			dev_err(dev, "Minimum supported CXL patrol scrub cycle in hour %d\n",
+			       params->min_scrub_cycle_hrs);
+			return -EINVAL;
+		}
+		wr_attrs.scrub_cycle_hrs = FIELD_PREP(CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK,
+						      params->scrub_cycle_hrs);
+		wr_attrs.scrub_flags = FIELD_PREP(CXL_MEMDEV_PS_FLAG_ENABLED_MASK,
+						  rd_params.enable);
+		break;
+	}
+
+	ret = cxl_set_feature(mds, cxl_patrol_scrub_uuid, CXL_MEMDEV_PS_SET_FEAT_VERSION,
+			      &wr_attrs, sizeof(wr_attrs),
+			      CXL_SET_FEAT_FLAG_DATA_SAVED_ACROSS_RESET);
+	if (ret) {
+		dev_err(dev, "CXL patrol scrub set feature failed ret=%d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int cxl_ps_set_attrs(struct device *dev, void *drv_data,
+			    struct cxl_memdev_ps_params *params,
+			    enum cxl_scrub_param param_type)
+{
+	struct cxl_patrol_scrub_context *cxl_ps_ctx = drv_data;
+	struct cxl_memdev *cxlmd;
+	struct cxl_dev_state *cxlds;
+	struct cxl_memdev_state *mds;
+	int ret, i;
+
+	if (cxl_ps_ctx->cxlr) {
+		struct cxl_region *cxlr = cxl_ps_ctx->cxlr;
+		struct cxl_region_params *p = &cxlr->params;
+
+		for (i = p->interleave_ways - 1; i >= 0; i--) {
+			struct cxl_endpoint_decoder *cxled = p->targets[i];
+
+			cxlmd = cxled_to_memdev(cxled);
+			cxlds = cxlmd->cxlds;
+			mds = to_cxl_memdev_state(cxlds);
+			ret = cxl_mem_ps_set_attrs(dev, mds, params, param_type);
+			if (ret)
+				return ret;
+		}
+	} else {
+		cxlmd = cxl_ps_ctx->cxlmd;
+		cxlds = cxlmd->cxlds;
+		mds = to_cxl_memdev_state(cxlds);
+
+		return cxl_mem_ps_set_attrs(dev, mds, params, param_type);
+	}
+
+	return 0;
+}
+
+static int cxl_patrol_scrub_get_enabled_bg(struct device *dev, void *drv_data, bool *enabled)
+{
+	struct cxl_memdev_ps_params params;
+	int ret;
+
+	ret = cxl_ps_get_attrs(dev, drv_data, &params);
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
+	struct cxl_memdev_ps_params params = {
+		.enable = enable,
+	};
+
+	return cxl_ps_set_attrs(dev, drv_data, &params, cxl_ps_param_enable);
+}
+
+static int cxl_patrol_scrub_get_name(struct device *dev, void *drv_data, char *name)
+{
+	struct cxl_patrol_scrub_context *cxl_ps_ctx = drv_data;
+	struct cxl_memdev *cxlmd = cxl_ps_ctx->cxlmd;
+
+	if (cxl_ps_ctx->cxlr) {
+		struct cxl_region *cxlr = cxl_ps_ctx->cxlr;
+
+		return sysfs_emit(name, "cxl_region%d_patrol_scrub\n", cxlr->id);
+	}
+
+	return sysfs_emit(name, "cxl_%s_patrol_scrub\n", dev_name(&cxlmd->dev));
+}
+
+static int cxl_patrol_scrub_write_scrub_cycle_hrs(struct device *dev, void *drv_data,
+						  u64 scrub_cycle_hrs)
+{
+	struct cxl_memdev_ps_params params = {
+		.scrub_cycle_hrs = scrub_cycle_hrs,
+	};
+
+	return cxl_ps_set_attrs(dev, drv_data, &params, cxl_ps_param_scrub_cycle);
+}
+
+static int cxl_patrol_scrub_read_scrub_cycle_hrs(struct device *dev, void *drv_data,
+						 u64 *scrub_cycle_hrs)
+{
+	struct cxl_memdev_ps_params params;
+	int ret;
+
+	ret = cxl_ps_get_attrs(dev, drv_data, &params);
+	if (ret)
+		return ret;
+
+	*scrub_cycle_hrs = params.scrub_cycle_hrs;
+
+	return 0;
+}
+
+static int cxl_patrol_scrub_read_scrub_cycle_hrs_range(struct device *dev, void *drv_data,
+						       u64 *min, u64 *max)
+{
+	struct cxl_memdev_ps_params params;
+	int ret;
+
+	ret = cxl_ps_get_attrs(dev, drv_data, &params);
+	if (ret)
+		return ret;
+	*min = params.min_scrub_cycle_hrs;
+	*max = U8_MAX; /* Max set by register size */
+
+	return 0;
+}
+
+static const struct edac_scrub_ops cxl_ps_scrub_ops = {
+	.get_enabled_bg = cxl_patrol_scrub_get_enabled_bg,
+	.set_enabled_bg = cxl_patrol_scrub_set_enabled_bg,
+	.get_name = cxl_patrol_scrub_get_name,
+	.cycle_in_hours_read = cxl_patrol_scrub_read_scrub_cycle_hrs,
+	.cycle_in_hours_write = cxl_patrol_scrub_write_scrub_cycle_hrs,
+	.cycle_in_hours_range = cxl_patrol_scrub_read_scrub_cycle_hrs_range,
+};
+
+int cxl_mem_ras_features_init(struct cxl_memdev *cxlmd, struct cxl_region *cxlr)
+{
+	struct edac_ras_feature ras_features[CXL_DEV_NUM_RAS_FEATURES];
+	struct cxl_patrol_scrub_context *cxl_ps_ctx;
+	struct cxl_mbox_supp_feat_entry feat_entry;
+	char cxl_dev_name[CXL_SCRUB_NAME_LEN];
+	int rc, i, num_ras_features = 0;
+
+	if (cxlr) {
+		struct cxl_region_params *p = &cxlr->params;
+
+		for (i = p->interleave_ways - 1; i >= 0; i--) {
+			struct cxl_endpoint_decoder *cxled = p->targets[i];
+
+			cxlmd = cxled_to_memdev(cxled);
+			memset(&feat_entry, 0, sizeof(feat_entry));
+			rc = cxl_mem_get_supported_feature_entry(cxlmd, &cxl_patrol_scrub_uuid,
+								 &feat_entry);
+			if (rc < 0)
+				return rc;
+			if (!(feat_entry.attr_flags & CXL_FEAT_ENTRY_FLAG_CHANGABLE))
+				return -EOPNOTSUPP;
+		}
+	} else {
+		rc = cxl_mem_get_supported_feature_entry(cxlmd, &cxl_patrol_scrub_uuid,
+						 &feat_entry);
+		if (rc < 0)
+			return rc;
+
+		if (!(feat_entry.attr_flags & CXL_FEAT_ENTRY_FLAG_CHANGABLE))
+			return -EOPNOTSUPP;
+	}
+
+	cxl_ps_ctx = devm_kzalloc(&cxlmd->dev, sizeof(*cxl_ps_ctx), GFP_KERNEL);
+	if (!cxl_ps_ctx)
+		return -ENOMEM;
+
+	*cxl_ps_ctx = (struct cxl_patrol_scrub_context) {
+		.get_feat_size = feat_entry.get_size,
+		.set_feat_size = feat_entry.set_size,
+	};
+	if (cxlr) {
+		snprintf(cxl_dev_name, sizeof(cxl_dev_name),
+			 "cxl_region%d", cxlr->id);
+		cxl_ps_ctx->cxlr = cxlr;
+	} else {
+		snprintf(cxl_dev_name, sizeof(cxl_dev_name),
+			 "%s_%s", "cxl", dev_name(&cxlmd->dev));
+		cxl_ps_ctx->cxlmd = cxlmd;
+	}
+
+	ras_features[num_ras_features].feat = ras_feat_scrub;
+	ras_features[num_ras_features].scrub_ops = &cxl_ps_scrub_ops;
+	ras_features[num_ras_features].scrub_ctx = cxl_ps_ctx;
+	num_ras_features++;
+
+	return edac_ras_dev_register(&cxlmd->dev, cxl_dev_name, NULL,
+				     num_ras_features, ras_features);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_mem_ras_features_init, CXL);
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 3c2b6144be23..14db9d301747 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3304,6 +3304,12 @@ static int cxl_region_probe(struct device *dev)
 					p->res->start, p->res->end, cxlr,
 					is_system_ram) > 0)
 			return 0;
+
+		rc = cxl_mem_ras_features_init(NULL, cxlr);
+		if (rc)
+			dev_warn(&cxlr->dev, "CXL ras features init for region_id=%d failed\n",
+				 cxlr->id);
+
 		return devm_cxl_add_dax_region(cxlr);
 	default:
 		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index c3cb8e2736b5..9a0eb41e5997 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -958,6 +958,14 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
 int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
 int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
 
+/* cxl memory scrub functions */
+#ifdef CONFIG_CXL_SCRUB
+int cxl_mem_ras_features_init(struct cxl_memdev *cxlmd, struct cxl_region *cxlr);
+#else
+static inline int cxl_mem_ras_features_init(struct cxl_memdev *cxlmd, struct cxl_region *cxlr)
+{ return 0; }
+#endif
+
 #ifdef CONFIG_CXL_SUSPEND
 void cxl_mem_active_inc(void);
 void cxl_mem_active_dec(void);
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 0c79d9ce877c..7c8360e2e09b 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -117,6 +117,10 @@ static int cxl_mem_probe(struct device *dev)
 	if (!cxlds->media_ready)
 		return -EBUSY;
 
+	rc = cxl_mem_ras_features_init(cxlmd, NULL);
+	if (rc)
+		dev_warn(&cxlmd->dev, "CXL ras features init failed\n");
+
 	/*
 	 * Someone is trying to reattach this device after it lost its port
 	 * connection (an endpoint port previously registered by this memdev was
-- 
2.34.1


