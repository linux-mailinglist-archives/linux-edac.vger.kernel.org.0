Return-Path: <linux-edac+bounces-3230-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D342BA48BC8
	for <lists+linux-edac@lfdr.de>; Thu, 27 Feb 2025 23:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB6023B7A05
	for <lists+linux-edac@lfdr.de>; Thu, 27 Feb 2025 22:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B7E275613;
	Thu, 27 Feb 2025 22:39:43 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD34F27427D;
	Thu, 27 Feb 2025 22:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740695983; cv=none; b=EEKrXJz/SDno34KmwJfAuVn3C6hFvdaJaGI7/qPksLjEkQkPVRNzhwhfsCbnvrMHK2mrZEhvf5Mu+j9XQX7fIQ9KQ8vxFhstBoTyXkdQ6z604fdNcHHEn+pGHGc+4FmTjUVoY3KKhvIPSH8WJewUVUvV1tT+RqFT+Ic1IYWxHkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740695983; c=relaxed/simple;
	bh=YG6WLD91nKzy6pCUP+6cNle+MDDVIEM4Sn7umClRDnM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r3prjoetCKySnrt3XPbGXW3RrswK9iSqLwxbWvnxzpIib8cUVtXtGyGzCHp6GptLj3hM01JVqmZfjriR9fu3ntdw+BLjRCyZuuSw/6I1RS1zDu2cLcpDuIWhejZfNVJKw9UA/JSaDYE5hOF2kY5c4opYeEL3W6UuOmI+NiHqnpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z3mSM13Y0z6K5mZ;
	Fri, 28 Feb 2025 06:37:39 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 96177140B55;
	Fri, 28 Feb 2025 06:39:38 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.149.240) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Feb 2025 23:39:36 +0100
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
Subject: [PATCH 7/8] cxl/memfeature: Add CXL memory device soft PPR control feature
Date: Thu, 27 Feb 2025 22:38:14 +0000
Message-ID: <20250227223816.2036-8-shiju.jose@huawei.com>
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
because typically data may not be retained with hPPR maintenance operation.

When a CXL device identifies error on a memory component, the device
may inform the host about the need for a PPR maintenance operation by using
an Event Record, where the Maintenance Needed flag is set. The Event Record
specifies the DPA that should be repaired. A CXL device may not keep track
of the requests that have already been sent and the information on which
DPA should be repaired may be lost upon power cycle.
The userspace tool requests for maintenance operation if the number of
corrected error reported on a CXL.mem media exceeds error threshold.

CXL spec 3.2 section 8.2.10.7.1.2 describes the device's sPPR (soft PPR)
maintenance operation and section 8.2.10.7.1.3 describes the device's
hPPR (hard PPR) maintenance operation feature.

CXL spec 3.2 section 8.2.10.7.2.1 describes the sPPR feature discovery and
configuration.

CXL spec 3.2 section 8.2.10.7.2.2 describes the hPPR feature discovery and
configuration.

Add support for controlling CXL memory device soft PPR (sPPR) feature.
Register with EDAC driver, which gets the memory repair attr descriptors
from the EDAC memory repair driver and exposes sysfs repair control
attributes for PRR to the userspace. For example CXL PPR control for the
CXL mem0 device is exposed in /sys/bus/edac/devices/cxl_mem0/mem_repairX/

Add checks to ensure the memory to be repaired is offline and originates
from a CXL DRAM or CXL gen_media error record reported in the current boot,
before requesting a PPR operation on the device.

Tested with QEMU patch for CXL PPR feature.
https://lore.kernel.org/all/20240730045722.71482-1-dave@stgolabs.net/

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 Documentation/edac/memory_repair.rst |  46 ++++
 drivers/cxl/Kconfig                  |   1 +
 drivers/cxl/core/memfeatures.c       | 348 ++++++++++++++++++++++++++-
 drivers/edac/mem_repair.c            |   5 +
 include/linux/edac.h                 |   3 +
 5 files changed, 402 insertions(+), 1 deletion(-)

diff --git a/Documentation/edac/memory_repair.rst b/Documentation/edac/memory_repair.rst
index 52162a422864..b698921628b5 100644
--- a/Documentation/edac/memory_repair.rst
+++ b/Documentation/edac/memory_repair.rst
@@ -119,3 +119,49 @@ sysfs
 
 Sysfs files are documented in
 `Documentation/ABI/testing/sysfs-edac-memory-repair`.
+
+Examples
+--------
+
+The memory repair usage takes the form shown in this example:
+
+1. CXL memory device Soft Post Package Repair (Soft PPR)
+
+1.1. Read device supported capabilities for the Soft PPR.
+
+# cat /sys/bus/edac/devices/cxl_mem0/mem_repair0/persist_mode
+
+0
+
+# cat /sys/bus/edac/devices/cxl_mem0/mem_repair0/repair_type
+
+ppr
+
+# cat /sys/bus/edac/devices/cxl_mem0/mem_repair0/repair_safe_when_in_use
+
+1
+
+# cat /sys/bus/edac/devices/cxl_mem0/mem_repair0/min_dpa
+
+0x0
+
+# cat /sys/bus/edac/devices/cxl_mem0/mem_repair0/max_dpa
+
+0xfffffff
+
+ Soft PPR that is safe to use with ongoing accesses to the memory
+
+ and applies to 4GiB of DPA space.
+
+1.2. Set attributes for a soft PPR for a DPA=0x300000
+
+# echo 0x8a2d > /sys/bus/edac/devices/cxl_mem0/mem_repair0/nibble_mask
+
+# echo 0x300000 >  /sys/bus/edac/devices/cxl_mem0/mem_repair0/dpa
+
+1.3. Start soft PPR operation for the DPA=0x300000
+
+Note: Repair command returns error if unsupported/resources are not
+available for the repair operation.
+
+# echo 1 > /sys/bus/edac/devices/cxl_mem0/mem_repair0/repair
diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 94321f5bed77..1e994534f0ad 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -120,6 +120,7 @@ config CXL_RAS_FEATURES
 	depends on EDAC=y || (CXL_BUS=m && EDAC=m)
 	depends on EDAC_SCRUB
 	depends on EDAC_ECS
+	depends on EDAC_MEM_REPAIR
 	help
 	  The CXL memory RAS feature control is optional and allows host to
 	  control the RAS features configurations of CXL Type 3 devices.
diff --git a/drivers/cxl/core/memfeatures.c b/drivers/cxl/core/memfeatures.c
index 253930051e87..8d5a57a0c154 100644
--- a/drivers/cxl/core/memfeatures.c
+++ b/drivers/cxl/core/memfeatures.c
@@ -14,12 +14,13 @@
 #include <linux/cleanup.h>
 #include <linux/edac.h>
 #include <linux/limits.h>
+#include <linux/unaligned.h>
 #include <cxl/features.h>
 #include <cxl.h>
 #include <cxlmem.h>
 #include "core.h"
 
-#define CXL_DEV_NUM_RAS_FEATURES	2
+#define CXL_DEV_NUM_RAS_FEATURES	3
 #define CXL_DEV_HOUR_IN_SECS	3600
 
 #define CXL_DEV_NAME_LEN	128
@@ -774,12 +775,347 @@ static int cxl_memdev_ecs_init(struct cxl_memdev *cxlmd,
 	return 0;
 }
 
+/*
+ * CXL memory soft PPR & hard PPR control definitions
+ */
+struct cxl_ppr_context {
+	uuid_t repair_uuid;
+	u8 instance;
+	u16 get_feat_size;
+	u16 set_feat_size;
+	u8 get_version;
+	u8 set_version;
+	u16 effects;
+	struct cxl_memdev *cxlmd;
+	enum edac_mem_repair_type repair_type;
+	bool persist_mode;
+	u64 dpa;
+	u32 nibble_mask;
+};
+
+/**
+ * struct cxl_memdev_ppr_params - CXL memory PPR parameter data structure.
+ * @dpa: device physical address.
+ * @op_class: PPR operation class.
+ * @op_subclass: PPR operation subclass.
+ * @media_accessible: memory media is accessible or not during PPR operation.
+ * @data_retained: data is retained or not during PPR operation.
+ */
+struct cxl_memdev_ppr_params {
+	u64 dpa;
+	u8 op_class;
+	u8 op_subclass;
+	bool media_accessible;
+	bool data_retained;
+};
+
+/*
+ * See CXL rev 3.2 @8.2.10.7.2.1 Table 8-128 sPPR Feature Readable Attributes
+ *
+ * See CXL rev 3.2 @8.2.10.7.2.2 Table 8-131 hPPR Feature Readable Attributes
+ */
+#define CXL_MEMDEV_PPR_QUERY_RESOURCE_FLAG	BIT(0)
+
+#define CXL_MEMDEV_PPR_DEVICE_INITIATED_MASK	BIT(0)
+
+#define CXL_MEMDEV_PPR_FLAG_DPA_SUPPORT_MASK	BIT(0)
+#define CXL_MEMDEV_PPR_FLAG_NIBBLE_SUPPORT_MASK	BIT(1)
+#define CXL_MEMDEV_PPR_FLAG_MEM_SPARING_EV_REC_SUPPORT_MASK	BIT(2)
+#define CXL_MEMDEV_PPR_FLAG_DEV_INITED_PPR_AT_BOOT_CAP_MASK	BIT(3)
+
+#define CXL_MEMDEV_PPR_RESTRICTION_FLAG_MEDIA_ACCESSIBLE_MASK	BIT(0)
+#define CXL_MEMDEV_PPR_RESTRICTION_FLAG_DATA_RETAINED_MASK	BIT(2)
+
+#define CXL_MEMDEV_PPR_SPARING_EV_REC_EN_MASK	BIT(0)
+#define CXL_MEMDEV_PPR_DEV_INITED_PPR_AT_BOOT_EN_MASK	BIT(1)
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
+/*
+ * See CXL rev 3.2 @8.2.10.7.1.2 Table 8-118 sPPR Maintenance Input Payload
+ *
+ * See CXL rev 3.2 @8.2.10.7.1.3 Table 8-119 hPPR Maintenance Input Payload
+ */
+struct cxl_memdev_ppr_maintenance_attrs {
+	u8 flags;
+	__le64 dpa;
+	u8 nibble_mask[3];
+}  __packed;
+
+static int cxl_mem_ppr_get_attrs(struct cxl_ppr_context *cxl_ppr_ctx,
+				 struct cxl_memdev_ppr_params *params)
+{
+	size_t rd_data_size = sizeof(struct cxl_memdev_ppr_rd_attrs);
+	struct cxl_memdev *cxlmd = cxl_ppr_ctx->cxlmd;
+	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
+	u16 restriction_flags;
+	size_t data_size;
+	u16 return_code;
+
+	struct cxl_memdev_ppr_rd_attrs *rd_attrs __free(kfree) =
+				kmalloc(rd_data_size, GFP_KERNEL);
+	if (!rd_attrs)
+		return -ENOMEM;
+
+	data_size = cxl_get_feature(cxl_mbox, &cxl_ppr_ctx->repair_uuid,
+				    CXL_GET_FEAT_SEL_CURRENT_VALUE,
+				    rd_attrs, rd_data_size, 0, &return_code);
+	if (!data_size)
+		return -EIO;
+
+	params->op_class = rd_attrs->hdr.op_class;
+	params->op_subclass = rd_attrs->hdr.op_subclass;
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
+			     struct cxl_memdev_ppr_params *rd_params)
+{
+	struct cxl_memdev_ppr_maintenance_attrs maintenance_attrs;
+	struct cxl_memdev *cxlmd = cxl_ppr_ctx->cxlmd;
+	struct cxl_mem_repair_attrbs attrbs = { 0 };
+
+	if (!rd_params->media_accessible || !rd_params->data_retained) {
+		/* Memory to repair must be offline */
+		if (cxl_are_decoders_committed(cxlmd))
+			return -EBUSY;
+		/* offline, so good for repair */
+	} else {
+		/* If offline all good, otherwise check for match with record */
+		if (cxl_are_decoders_committed(cxlmd)) {
+			/* Check memory to repair is from the current boot */
+			attrbs.repair_type = CXL_PPR;
+			attrbs.dpa = cxl_ppr_ctx->dpa;
+			attrbs.nibble_mask = cxl_ppr_ctx->nibble_mask;
+			if (!cxl_find_rec_dram(cxlmd, &attrbs) &&
+			    !cxl_find_rec_gen_media(cxlmd, &attrbs))
+				return -EINVAL;
+			/* Record matched, so even though online good for repair */
+		}
+	}
+
+	memset(&maintenance_attrs, 0, sizeof(maintenance_attrs));
+	maintenance_attrs.flags = 0;
+	maintenance_attrs.dpa = cpu_to_le64(cxl_ppr_ctx->dpa);
+	put_unaligned_le24(cxl_ppr_ctx->nibble_mask, maintenance_attrs.nibble_mask);
+
+	return cxl_do_maintenance(&cxlmd->cxlds->cxl_mbox, rd_params->op_class,
+				  rd_params->op_subclass, &maintenance_attrs,
+				  sizeof(maintenance_attrs));
+}
+
+static int cxl_mem_ppr_set_attrs(struct device *dev,
+				 struct cxl_ppr_context *cxl_ppr_ctx)
+{
+	struct cxl_memdev_ppr_params rd_params;
+	int ret;
+
+	ret = cxl_mem_ppr_get_attrs(cxl_ppr_ctx, &rd_params);
+	if (ret)
+		return ret;
+
+	ret = cxl_hold_region_and_dpa();
+	if (ret)
+		return ret;
+
+	ret = cxl_mem_do_ppr_op(dev, cxl_ppr_ctx, &rd_params);
+	cxl_release_region_and_dpa();
+
+	return ret;
+}
+
+static int cxl_ppr_get_repair_type(struct device *dev, void *drv_data,
+				   const char **repair_type)
+{
+	*repair_type = edac_repair_type[EDAC_PPR];
+
+	return 0;
+}
+
+static int cxl_ppr_get_persist_mode(struct device *dev, void *drv_data,
+				    bool *persist_mode)
+{
+	struct cxl_ppr_context *cxl_ppr_ctx = drv_data;
+
+	*persist_mode = cxl_ppr_ctx->persist_mode;
+
+	return 0;
+}
+
+static int cxl_get_ppr_safe_when_in_use(struct device *dev, void *drv_data,
+					bool *safe)
+{
+	struct cxl_ppr_context *cxl_ppr_ctx = drv_data;
+	struct cxl_memdev_ppr_params params;
+	int ret;
+
+	ret = cxl_mem_ppr_get_attrs(cxl_ppr_ctx, &params);
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
+	if (dpa < cxlds->dpa_res.start || dpa > cxlds->dpa_res.end)
+		return -EINVAL;
+
+	cxl_ppr_ctx->dpa = dpa;
+
+	return 0;
+}
+
+static int cxl_ppr_get_nibble_mask(struct device *dev, void *drv_data,
+				   u32 *nibble_mask)
+{
+	struct cxl_ppr_context *cxl_ppr_ctx = drv_data;
+
+	*nibble_mask = cxl_ppr_ctx->nibble_mask;
+
+	return 0;
+}
+
+static int cxl_ppr_set_nibble_mask(struct device *dev, void *drv_data, u32 nibble_mask)
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
+
+	if (!cxl_ppr_ctx->dpa || val != EDAC_DO_MEM_REPAIR)
+		return -EINVAL;
+
+	return cxl_mem_ppr_set_attrs(dev, cxl_ppr_ctx);
+}
+
+static const struct edac_mem_repair_ops cxl_sppr_ops = {
+	.get_repair_type = cxl_ppr_get_repair_type,
+	.get_persist_mode = cxl_ppr_get_persist_mode,
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
+static int cxl_memdev_soft_ppr_init(struct cxl_memdev *cxlmd,
+				    struct edac_dev_feature *ras_feature,
+				    u8 repair_inst)
+{
+	struct cxl_ppr_context *cxl_sppr_ctx;
+	struct cxl_feat_entry *feat_entry;
+
+	feat_entry = cxl_get_feature_entry(cxlmd->cxlds, &CXL_FEAT_SPPR_UUID);
+	if (IS_ERR(feat_entry))
+		return -EOPNOTSUPP;
+
+	if (!(le32_to_cpu(feat_entry->flags) & CXL_FEATURE_F_CHANGEABLE))
+		return -EOPNOTSUPP;
+
+	cxl_sppr_ctx = devm_kzalloc(&cxlmd->dev, sizeof(*cxl_sppr_ctx),
+				    GFP_KERNEL);
+	if (!cxl_sppr_ctx)
+		return -ENOMEM;
+
+	*cxl_sppr_ctx = (struct cxl_ppr_context) {
+		.get_feat_size = le16_to_cpu(feat_entry->get_feat_size),
+		.set_feat_size = le16_to_cpu(feat_entry->set_feat_size),
+		.get_version = feat_entry->get_feat_ver,
+		.set_version = feat_entry->set_feat_ver,
+		.effects = le16_to_cpu(feat_entry->effects),
+		.cxlmd = cxlmd,
+		.repair_type = EDAC_PPR,
+		.persist_mode = 0,
+		.instance = repair_inst,
+	};
+	uuid_copy(&cxl_sppr_ctx->repair_uuid, &CXL_FEAT_SPPR_UUID);
+
+	ras_feature->ft_type = RAS_FEAT_MEM_REPAIR;
+	ras_feature->instance = cxl_sppr_ctx->instance;
+	ras_feature->mem_repair_ops = &cxl_sppr_ops;
+	ras_feature->ctx = cxl_sppr_ctx;
+
+	return 0;
+}
+
 int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd)
 {
 	struct edac_dev_feature ras_features[CXL_DEV_NUM_RAS_FEATURES];
 	char cxl_dev_name[CXL_DEV_NAME_LEN];
 	int num_ras_features = 0;
 	u8 scrub_inst = 0;
+	u8 repair_inst = 0;
 	int rc;
 
 	rc = cxl_memdev_scrub_init(cxlmd, &ras_features[num_ras_features],
@@ -797,6 +1133,16 @@ int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd)
 	if (rc != -EOPNOTSUPP)
 		num_ras_features++;
 
+	rc = cxl_memdev_soft_ppr_init(cxlmd, &ras_features[num_ras_features],
+				      repair_inst);
+	if (rc < 0 && rc != -EOPNOTSUPP)
+		return rc;
+
+	if (rc != -EOPNOTSUPP) {
+		repair_inst++;
+		num_ras_features++;
+	}
+
 	snprintf(cxl_dev_name, sizeof(cxl_dev_name), "%s_%s",
 		 "cxl", dev_name(&cxlmd->dev));
 
diff --git a/drivers/edac/mem_repair.c b/drivers/edac/mem_repair.c
index 3b1a845457b0..bf7e01a8b4dd 100755
--- a/drivers/edac/mem_repair.c
+++ b/drivers/edac/mem_repair.c
@@ -45,6 +45,11 @@ struct edac_mem_repair_context {
 	struct attribute_group group;
 };
 
+const char * const edac_repair_type[] = {
+	[EDAC_PPR] = "ppr",
+};
+EXPORT_SYMBOL_GPL(edac_repair_type);
+
 #define TO_MR_DEV_ATTR(_dev_attr)      \
 	container_of(_dev_attr, struct edac_mem_repair_dev_attr, dev_attr)
 
diff --git a/include/linux/edac.h b/include/linux/edac.h
index 451f9c152c99..5669d8d2509a 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -745,9 +745,12 @@ static inline int edac_ecs_get_desc(struct device *ecs_dev,
 #endif /* CONFIG_EDAC_ECS */
 
 enum edac_mem_repair_type {
+	EDAC_PPR,
 	EDAC_REPAIR_MAX
 };
 
+extern const char * const edac_repair_type[];
+
 enum edac_mem_repair_cmd {
 	EDAC_DO_MEM_REPAIR = 1,
 };
-- 
2.43.0


