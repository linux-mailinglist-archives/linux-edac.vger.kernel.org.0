Return-Path: <linux-edac+bounces-2625-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EED749D63EC
	for <lists+linux-edac@lfdr.de>; Fri, 22 Nov 2024 19:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B95DB28D32
	for <lists+linux-edac@lfdr.de>; Fri, 22 Nov 2024 18:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6F51E32CE;
	Fri, 22 Nov 2024 18:05:28 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396931E284C;
	Fri, 22 Nov 2024 18:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732298728; cv=none; b=QhSnEJyWxaIYKb4hVa4vZNU/Y8DT8HA4rJ8iPeJYnRFt2n1Ng7VadtryEgvd7VHdJWTb9TfD8rMEFmsGD2efkIed7e7wqNM8VVOiQU553xLcI9BSb84NuLsxHM0aWfX0/RHC3sRvZo1kIDB8YwWp1i8A+LC6znqAE9+FO9mkHZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732298728; c=relaxed/simple;
	bh=FIZcXjFKkD/WGhmfhTIqXAWhwFKOdXqcBv/8kkodlxM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PmClxXW35Q8U+x/ZUVMMhvCgqvjxf9kXh3ytbjZyPY6sz0lVzNyQInUFYpFz3pePbGrP41lpwhSrPZEg92SSK0NXwGe/hXRC8Zb6PScnZ9pjNvOTlnzh+xEHohFeNOMaUFzufgRhHY63qmreZuRCCCJbhBuNUxFI6t6fMzPdXOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xw2yD5LFtz6K97p;
	Sat, 23 Nov 2024 02:03:00 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 13795140CB9;
	Sat, 23 Nov 2024 02:05:24 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.171.16) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 22 Nov 2024 19:05:21 +0100
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
	<duenwen@google.com>, <gthelen@google.com>, <wschwartz@amperecomputing.com>,
	<dferguson@amperecomputing.com>, <wbs@os.amperecomputing.com>,
	<nifan.cxl@gmail.com>, <yazen.ghannam@amd.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <roberto.sassu@huawei.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v17 17/18] cxl/memfeature: Add CXL memory device soft PPR control feature
Date: Fri, 22 Nov 2024 18:04:14 +0000
Message-ID: <20241122180416.1932-18-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20241122180416.1932-1-shiju.jose@huawei.com>
References: <20241122180416.1932-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Post Package Repair (PPR) maintenance operations may be supported by CXL
devices that implement CXL.mem protocol. A PPR maintenance operation
requests the CXL device to perform a repair operation on its media.
For example, a CXL device with DRAM components that support PPR features
may implement PPR Maintenance operations. DRAM components may support two
types of PPR, hard PPR (hPPR), for a permanent row repair, and Soft PPR
(sPPR), for a temporary row repair. Soft PPR is much faster than hPPR,
but the repair is lost with a power cycle.

During the execution of a PPR Maintenance operation, a CXL memory device:
- May or may not retain data
- May or may not be able to process CXL.mem requests correctly, including
the ones that target the DPA involved in the repair.
These CXL Memory Device capabilities are specified by Restriction Flags
in the sPPR Feature and hPPR Feature.

Soft PPR maintenance operation may be executed at runtime, if data is
retained and CXL.mem requests are correctly processed. For CXL devices with
DRAM components, hPPR maintenance operation may be executed only at boot
because data would not be retained.
When a CXL device identifies error on a memory component, the device
may inform the host about the need for a PPR maintenance operation by using
an Event Record, where the Maintenance Needed flag is set. The Event Record
specifies the DPA that should be repaired. A CXL device may not keep track
of the requests that have already been sent and the information on which
DPA should be repaired may be lost upon power cycle.
The userspace tool requests for maintenance operation if the number of
corrected error reported on a CXL.mem media exceeds error threshold.

CXL spec 3.1 section 8.2.9.7.1.2 describes the device's sPPR (soft PPR)
maintenance operation and section 8.2.9.7.1.3 describes the device's
hPPR (hard PPR) maintenance operation feature.

CXL spec 3.1 section 8.2.9.7.2.1 describes the sPPR feature discovery and
configuration.

CXL spec 3.1 section 8.2.9.7.2.2 describes the hPPR feature discovery and
configuration.

Add support for controlling CXL memory device sPPR feature.
Register with EDAC driver, which gets the memory repair attr descriptors
from the EDAC memory repair driver and exposes sysfs repair control
attributes for PRR to the userspace. For example CXL PPR control for the
CXL mem0 device is exposed in /sys/bus/edac/devices/cxl_mem0/mem_repairX/

Tested with QEMU patch for CXL PPR feature.
https://lore.kernel.org/all/20240730045722.71482-1-dave@stgolabs.net/

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 Documentation/edac/memory_repair.rst |  58 ++++
 drivers/cxl/core/memfeature.c        | 393 ++++++++++++++++++++++++++-
 2 files changed, 450 insertions(+), 1 deletion(-)

diff --git a/Documentation/edac/memory_repair.rst b/Documentation/edac/memory_repair.rst
index f22042ac3d91..0dd970f62a20 100644
--- a/Documentation/edac/memory_repair.rst
+++ b/Documentation/edac/memory_repair.rst
@@ -99,3 +99,61 @@ sysfs
 Sysfs files are documented in
 
 `Documentation/ABI/testing/sysfs-edac-memory-repair`.
+
+Example
+-------
+
+The usage takes the form shown in this example:
+
+1. CXL memory device Soft Post Package Repair (Soft PPR)
+
+# read capabilities
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair0/dpa_support
+
+1
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair0/nibble_mask
+
+0x0
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair0/persist_mode
+
+0
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair0/repair_function
+
+0
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair0/repair_safe_when_in_use
+
+1
+
+# set and readback attributes
+
+root@localhost:~# echo 0x8a2d > /sys/bus/edac/devices/cxl_mem0/mem_repair0/nibble_mask
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair0/min_dpa
+
+0x0
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair0/max_dpa
+
+0xfffffff
+
+root@localhost:~# echo 0x300000 >  /sys/bus/edac/devices/cxl_mem0/mem_repair0/dpa
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair0/dpa
+
+0x300000
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair0/nibble_mask
+
+0x8a2d
+
+# issue repair operations
+
+# reapir returns error if unsupported/resources are not available
+# for the repair operation.
+
+root@localhost:~# echo 1 > /sys/bus/edac/devices/cxl_mem0/mem_repair0/repair
diff --git a/drivers/cxl/core/memfeature.c b/drivers/cxl/core/memfeature.c
index c65606c4d0a5..5f40e5211526 100644
--- a/drivers/cxl/core/memfeature.c
+++ b/drivers/cxl/core/memfeature.c
@@ -14,11 +14,13 @@
 #include <linux/cleanup.h>
 #include <linux/edac.h>
 #include <linux/limits.h>
+#include <linux/unaligned.h>
 #include <cxl/features.h>
 #include <cxl.h>
 #include <cxlmem.h>
+#include "core.h"
 
-#define CXL_DEV_NUM_RAS_FEATURES	2
+#define CXL_DEV_NUM_RAS_FEATURES	3
 #define CXL_DEV_HOUR_IN_SECS	3600
 
 #define CXL_DEV_NAME_LEN	128
@@ -610,6 +612,336 @@ static const struct edac_ecs_ops cxl_ecs_ops = {
 	.set_threshold = cxl_ecs_set_threshold,
 };
 
+/* CXL memory soft PPR & hard PPR control definitions */
+struct cxl_ppr_context {
+	uuid_t repair_uuid;
+	u8 instance;
+	u16 get_feat_size;
+	u16 set_feat_size;
+	u8 get_version;
+	u8 set_version;
+	u16 effects;
+	struct cxl_memdev *cxlmd;
+	enum edac_mem_repair_function repair_function;
+	enum edac_mem_repair_persist_mode persist_mode;
+	u64 dpa;
+	u32 nibble_mask;
+};
+
+/**
+ * struct cxl_memdev_ppr_params - CXL memory PPR parameter data structure.
+ * @op_class: PPR operation class.
+ * @op_subclass: PPR operation subclass.
+ * @dpa_support: device physical address for PPR support.
+ * @media_accessible: memory media is accessible or not during PPR operation.
+ * @data_retained: data is retained or not during PPR operation.
+ * @dpa: device physical address.
+ */
+struct cxl_memdev_ppr_params {
+	u8 op_class;
+	u8 op_subclass;
+	bool dpa_support;
+	bool media_accessible;
+	bool data_retained;
+	u64 dpa;
+};
+
+enum cxl_ppr_param {
+	CXL_PPR_PARAM_DO_QUERY,
+	CXL_PPR_PARAM_DO_PPR,
+};
+
+/* See CXL rev 3.1 @8.2.9.7.2.1 Table 8-113 sPPR Feature Readable Attributes */
+/* See CXL rev 3.1 @8.2.9.7.2.2 Table 8-116 hPPR Feature Readable Attributes */
+#define CXL_MEMDEV_PPR_QUERY_RESOURCE_FLAG	BIT(0)
+
+#define CXL_MEMDEV_PPR_DEVICE_INITIATED_MASK	BIT(0)
+#define CXL_MEMDEV_PPR_FLAG_DPA_SUPPORT_MASK	BIT(0)
+#define CXL_MEMDEV_PPR_FLAG_NIBBLE_SUPPORT_MASK	BIT(1)
+#define CXL_MEMDEV_PPR_FLAG_MEM_SPARING_EV_REC_SUPPORT_MASK	BIT(2)
+
+#define CXL_MEMDEV_PPR_RESTRICTION_FLAG_MEDIA_ACCESSIBLE_MASK	BIT(0)
+#define CXL_MEMDEV_PPR_RESTRICTION_FLAG_DATA_RETAINED_MASK	BIT(2)
+
+#define CXL_MEMDEV_PPR_SPARING_EV_REC_EN_MASK	BIT(0)
+
+struct cxl_memdev_repair_rd_attrs_hdr {
+	u8 max_op_latency;
+	__le16 op_cap;
+	__le16 op_mode;
+	u8 op_class;
+	u8 op_subclass;
+	u8 rsvd[9];
+}  __packed;
+
+struct cxl_memdev_ppr_rd_attrs {
+	struct cxl_memdev_repair_rd_attrs_hdr hdr;
+	u8 ppr_flags;
+	__le16 restriction_flags;
+	u8 ppr_op_mode;
+}  __packed;
+
+/* See CXL rev 3.1 @8.2.9.7.1.2 Table 8-103 sPPR Maintenance Input Payload */
+/* See CXL rev 3.1 @8.2.9.7.1.3 Table 8-104 hPPR Maintenance Input Payload */
+struct cxl_memdev_ppr_maintenance_attrs {
+	u8 flags;
+	__le64 dpa;
+	u8 nibble_mask[3];
+}  __packed;
+
+static int cxl_mem_ppr_get_attrs(struct device *dev,
+				 struct cxl_ppr_context *cxl_ppr_ctx,
+				 struct cxl_memdev_ppr_params *params)
+{
+	struct cxl_memdev *cxlmd = cxl_ppr_ctx->cxlmd;
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	size_t rd_data_size = sizeof(struct cxl_memdev_ppr_rd_attrs);
+	u16 restriction_flags;
+	size_t data_size;
+
+	struct cxl_memdev_ppr_rd_attrs *rd_attrs __free(kfree) =
+				kmalloc(rd_data_size, GFP_KERNEL);
+	if (!rd_attrs)
+		return -ENOMEM;
+
+	data_size = cxl_get_feature(&mds->cxlds, cxl_ppr_ctx->repair_uuid,
+				    CXL_GET_FEAT_SEL_CURRENT_VALUE,
+				    rd_attrs, rd_data_size);
+	if (!data_size)
+		return -EIO;
+
+	params->op_class = rd_attrs->hdr.op_class;
+	params->op_subclass = rd_attrs->hdr.op_subclass;
+	params->dpa_support = FIELD_GET(CXL_MEMDEV_PPR_FLAG_DPA_SUPPORT_MASK,
+					rd_attrs->ppr_flags);
+	restriction_flags = le16_to_cpu(rd_attrs->restriction_flags);
+	params->media_accessible = FIELD_GET(CXL_MEMDEV_PPR_RESTRICTION_FLAG_MEDIA_ACCESSIBLE_MASK,
+					     restriction_flags) ^ 1;
+	params->data_retained = FIELD_GET(CXL_MEMDEV_PPR_RESTRICTION_FLAG_DATA_RETAINED_MASK,
+					  restriction_flags) ^ 1;
+
+	return 0;
+}
+
+static int cxl_mem_do_ppr_op(struct device *dev,
+			     struct cxl_ppr_context *cxl_ppr_ctx,
+			     struct cxl_memdev_ppr_params *rd_params,
+			     enum cxl_ppr_param param_type)
+{
+	struct cxl_memdev_ppr_maintenance_attrs maintenance_attrs;
+	struct cxl_memdev *cxlmd = cxl_ppr_ctx->cxlmd;
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	int ret;
+
+	if (!rd_params->media_accessible || !rd_params->data_retained) {
+		/* Check if DPA is mapped */
+		if (cxl_dpa_to_region(cxlmd, cxl_ppr_ctx->dpa)) {
+			dev_err(dev, "CXL can't do PPR as DPA is mapped\n");
+			return -EBUSY;
+		}
+	}
+	memset(&maintenance_attrs, 0, sizeof(maintenance_attrs));
+	if (param_type == CXL_PPR_PARAM_DO_QUERY)
+		maintenance_attrs.flags = CXL_MEMDEV_PPR_QUERY_RESOURCE_FLAG;
+	else
+		maintenance_attrs.flags = 0;
+	maintenance_attrs.dpa = cpu_to_le64(cxl_ppr_ctx->dpa);
+	put_unaligned_le24(cxl_ppr_ctx->nibble_mask, maintenance_attrs.nibble_mask);
+	ret = cxl_do_maintenance(mds, rd_params->op_class, rd_params->op_subclass,
+				 &maintenance_attrs, sizeof(maintenance_attrs));
+	if (ret) {
+		dev_err(dev, "CXL do PPR failed ret=%d\n", ret);
+		up_read(&cxl_region_rwsem);
+		cxl_ppr_ctx->nibble_mask = 0;
+		cxl_ppr_ctx->dpa = 0;
+		return ret;
+	}
+
+	return 0;
+}
+
+static int cxl_mem_ppr_set_attrs(struct device *dev,
+				 struct cxl_ppr_context *cxl_ppr_ctx,
+				 enum cxl_ppr_param param_type)
+{
+	struct cxl_memdev_ppr_params rd_params;
+	int ret;
+
+	ret = cxl_mem_ppr_get_attrs(dev, cxl_ppr_ctx, &rd_params);
+	if (ret) {
+		dev_err(dev, "Get cxlmemdev PPR params failed ret=%d\n",
+			ret);
+		return ret;
+	}
+
+	switch (param_type) {
+	case CXL_PPR_PARAM_DO_QUERY:
+	case CXL_PPR_PARAM_DO_PPR:
+		ret = down_read_interruptible(&cxl_region_rwsem);
+		if (ret)
+			return ret;
+		ret = down_read_interruptible(&cxl_dpa_rwsem);
+		if (ret) {
+			up_read(&cxl_region_rwsem);
+			return ret;
+		}
+		ret = cxl_mem_do_ppr_op(dev, cxl_ppr_ctx, &rd_params, param_type);
+		up_read(&cxl_dpa_rwsem);
+		up_read(&cxl_region_rwsem);
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int cxl_ppr_get_repair_function(struct device *dev, void *drv_data,
+				       u32 *repair_function)
+{
+	struct cxl_ppr_context *cxl_ppr_ctx = drv_data;
+
+	*repair_function = cxl_ppr_ctx->repair_function;
+
+	return 0;
+}
+
+static int cxl_ppr_get_persist_mode(struct device *dev, void *drv_data,
+				    u32 *persist_mode)
+{
+	struct cxl_ppr_context *cxl_ppr_ctx = drv_data;
+
+	*persist_mode = cxl_ppr_ctx->persist_mode;
+
+	return 0;
+}
+
+static int cxl_ppr_get_dpa_support(struct device *dev, void *drv_data,
+				   u32 *dpa_support)
+{
+	struct cxl_ppr_context *cxl_ppr_ctx = drv_data;
+	struct cxl_memdev_ppr_params params;
+	int ret;
+
+	ret = cxl_mem_ppr_get_attrs(dev, cxl_ppr_ctx, &params);
+	if (ret)
+		return ret;
+
+	*dpa_support = params.dpa_support;
+
+	return 0;
+}
+
+static int cxl_get_ppr_safe_when_in_use(struct device *dev, void *drv_data,
+					u32 *safe)
+{
+	struct cxl_ppr_context *cxl_ppr_ctx = drv_data;
+	struct cxl_memdev_ppr_params params;
+	int ret;
+
+	ret = cxl_mem_ppr_get_attrs(dev, cxl_ppr_ctx, &params);
+	if (ret)
+		return ret;
+
+	*safe = params.media_accessible & params.data_retained;
+
+	return 0;
+}
+
+static int cxl_ppr_get_min_dpa(struct device *dev, void *drv_data,
+			       u64 *min_dpa)
+{
+	struct cxl_ppr_context *cxl_ppr_ctx = drv_data;
+	struct cxl_memdev *cxlmd = cxl_ppr_ctx->cxlmd;
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+
+	*min_dpa = cxlds->dpa_res.start;
+
+	return 0;
+}
+
+static int cxl_ppr_get_max_dpa(struct device *dev, void *drv_data,
+			       u64 *max_dpa)
+{
+	struct cxl_ppr_context *cxl_ppr_ctx = drv_data;
+	struct cxl_memdev *cxlmd = cxl_ppr_ctx->cxlmd;
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+
+	*max_dpa = cxlds->dpa_res.end;
+
+	return 0;
+}
+
+static int cxl_ppr_get_dpa(struct device *dev, void *drv_data,
+			   u64 *dpa)
+{
+	struct cxl_ppr_context *cxl_ppr_ctx = drv_data;
+
+	*dpa = cxl_ppr_ctx->dpa;
+
+	return 0;
+}
+
+static int cxl_ppr_set_dpa(struct device *dev, void *drv_data, u64 dpa)
+{
+	struct cxl_ppr_context *cxl_ppr_ctx = drv_data;
+	struct cxl_memdev *cxlmd = cxl_ppr_ctx->cxlmd;
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+
+	if (!dpa || dpa < cxlds->dpa_res.start || dpa > cxlds->dpa_res.end)
+		return -EINVAL;
+
+	cxl_ppr_ctx->dpa = dpa;
+
+	return 0;
+}
+
+static int cxl_ppr_get_nibble_mask(struct device *dev, void *drv_data,
+				   u64 *nibble_mask)
+{
+	struct cxl_ppr_context *cxl_ppr_ctx = drv_data;
+
+	*nibble_mask = cxl_ppr_ctx->nibble_mask;
+
+	return 0;
+}
+
+static int cxl_ppr_set_nibble_mask(struct device *dev, void *drv_data, u64 nibble_mask)
+{
+	struct cxl_ppr_context *cxl_ppr_ctx = drv_data;
+
+	cxl_ppr_ctx->nibble_mask = nibble_mask;
+
+	return 0;
+}
+
+static int cxl_do_ppr(struct device *dev, void *drv_data, u32 val)
+{
+	struct cxl_ppr_context *cxl_ppr_ctx = drv_data;
+	int ret;
+
+	if (!cxl_ppr_ctx->dpa || val != EDAC_DO_MEM_REPAIR)
+		return -EINVAL;
+
+	ret = cxl_mem_ppr_set_attrs(dev, cxl_ppr_ctx, CXL_PPR_PARAM_DO_PPR);
+
+	return ret;
+}
+
+static const struct edac_mem_repair_ops cxl_sppr_ops = {
+	.get_repair_function = cxl_ppr_get_repair_function,
+	.get_persist_mode = cxl_ppr_get_persist_mode,
+	.get_dpa_support = cxl_ppr_get_dpa_support,
+	.get_repair_safe_when_in_use = cxl_get_ppr_safe_when_in_use,
+	.get_min_dpa = cxl_ppr_get_min_dpa,
+	.get_max_dpa = cxl_ppr_get_max_dpa,
+	.get_dpa = cxl_ppr_get_dpa,
+	.set_dpa = cxl_ppr_set_dpa,
+	.get_nibble_mask = cxl_ppr_get_nibble_mask,
+	.set_nibble_mask = cxl_ppr_set_nibble_mask,
+	.do_repair = cxl_do_ppr,
+};
+
 static int cxl_memdev_scrub_init(struct cxl_memdev *cxlmd, struct cxl_region *cxlr,
 				 struct edac_dev_feature *ras_feature, u8 scrub_inst)
 {
@@ -725,11 +1057,59 @@ static int cxl_memdev_ecs_init(struct cxl_memdev *cxlmd,
 	return -EOPNOTSUPP;
 }
 
+static int cxl_memdev_soft_ppr_init(struct cxl_memdev *cxlmd,
+				    struct edac_dev_feature *ras_feature,
+				    u8 repair_inst)
+{
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	struct cxl_ppr_context *cxl_sppr_ctx;
+	struct cxl_feat_entry feat_entry;
+	int rc;
+
+	rc = cxl_get_supported_feature_entry(&mds->cxlds, &CXL_FEAT_SPPR_UUID,
+					     &feat_entry);
+	if (rc < 0)
+		goto feat_unsupported;
+
+	if (!(le32_to_cpu(feat_entry.flags) & CXL_FEAT_ENTRY_FLAG_CHANGABLE))
+		goto feat_unsupported;
+
+	cxl_sppr_ctx = devm_kzalloc(&cxlmd->dev, sizeof(*cxl_sppr_ctx),
+				    GFP_KERNEL);
+	if (!cxl_sppr_ctx)
+		return -ENOMEM;
+
+	*cxl_sppr_ctx = (struct cxl_ppr_context) {
+		.repair_uuid = CXL_FEAT_SPPR_UUID,
+		.get_feat_size = le16_to_cpu(feat_entry.get_feat_size),
+		.set_feat_size = le16_to_cpu(feat_entry.set_feat_size),
+		.get_version = feat_entry.get_feat_ver,
+		.set_version = feat_entry.set_feat_ver,
+		.effects = le16_to_cpu(feat_entry.effects),
+		.cxlmd = cxlmd,
+		.repair_function = EDAC_SOFT_PPR,
+		.persist_mode = EDAC_MEM_REPAIR_SOFT,
+		.instance = repair_inst,
+	};
+
+	ras_feature->ft_type = RAS_FEAT_MEM_REPAIR;
+	ras_feature->instance = cxl_sppr_ctx->instance;
+	ras_feature->mem_repair_ops = &cxl_sppr_ops;
+	ras_feature->ctx = cxl_sppr_ctx;
+
+	return 0;
+
+feat_unsupported:
+	return -EOPNOTSUPP;
+}
+
 int cxl_mem_ras_features_init(struct cxl_memdev *cxlmd, struct cxl_region *cxlr)
 {
 	struct edac_dev_feature ras_features[CXL_DEV_NUM_RAS_FEATURES];
 	char cxl_dev_name[CXL_DEV_NAME_LEN];
 	int num_ras_features = 0;
+	u8 repair_inst = 0;
 	u8 scrub_inst = 0;
 	int rc;
 
@@ -762,6 +1142,17 @@ int cxl_mem_ras_features_init(struct cxl_memdev *cxlmd, struct cxl_region *cxlr)
 	num_ras_features++;
 
 feat_ecs_done:
+	rc = cxl_memdev_soft_ppr_init(cxlmd, &ras_features[num_ras_features],
+				      repair_inst);
+	if (rc == -EOPNOTSUPP)
+		goto feat_soft_ppr_done;
+	if (rc < 0)
+		return rc;
+
+	repair_inst++;
+	num_ras_features++;
+
+feat_soft_ppr_done:
 feat_register:
 	return edac_dev_register(&cxlmd->dev, cxl_dev_name, NULL,
 				 num_ras_features, ras_features);
-- 
2.43.0


