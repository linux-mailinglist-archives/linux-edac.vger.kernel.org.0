Return-Path: <linux-edac+bounces-3484-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BE1A7E920
	for <lists+linux-edac@lfdr.de>; Mon,  7 Apr 2025 19:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEC7D188D895
	for <lists+linux-edac@lfdr.de>; Mon,  7 Apr 2025 17:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B72A217737;
	Mon,  7 Apr 2025 17:50:17 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528E71C68A6;
	Mon,  7 Apr 2025 17:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744048217; cv=none; b=tuXq15pq0UETFRohir9YLOGBA3JqFws50FY4of3SEWJSsI46dGMYVEHVcTYRg1JWvfqViNsvx8Q7zMoNlHX8kmyQP4UpY6ZvHwzTdemf9oSsziMBGfcvn0heY2LpLvMjvPTrjovCfukMxUG/FH+t2rPLyL/vB2RZcsSLJEFpUds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744048217; c=relaxed/simple;
	bh=VklG+ATp49cWREQGHrPQMacwRg6CTC1ksnt16g5hIUg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dEc3Esl6kx+A2zNSbyW8I7AwPa5n7/9EFib9W/URYIrULghkFLv4SdcuiDiQTZjLcfIm2eZ+05MSSAQcN/V1CDG22W6pmSRVSnDpeO0hNF8nV5CiAmoQp/VCbgZNsIhUkgxqW4VezRbYoxAx1qemaJhdSA+M5aZkslAc7E0Nm1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZWc8J0p83z6K9H8;
	Tue,  8 Apr 2025 01:46:24 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 5CC42140159;
	Tue,  8 Apr 2025 01:50:13 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.154.56) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 7 Apr 2025 19:50:11 +0200
From: <shiju.jose@huawei.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>
CC: <linux-edac@vger.kernel.org>, <linux-doc@vger.kernel.org>, <bp@alien8.de>,
	<tony.luck@intel.com>, <lenb@kernel.org>, <leo.duran@amd.com>,
	<Yazen.Ghannam@amd.com>, <mchehab@kernel.org>, <nifan.cxl@gmail.com>,
	<linuxarm@huawei.com>, <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v3 8/8] cxl/edac: Add CXL memory device soft PPR control feature
Date: Mon, 7 Apr 2025 18:49:19 +0100
Message-ID: <20250407174920.625-9-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250407174920.625-1-shiju.jose@huawei.com>
References: <20250407174920.625-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
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

Note: Tested with QEMU patch for CXL PPR feature.
https://lore.kernel.org/all/20240730045722.71482-1-dave@stgolabs.net/

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 Documentation/edac/memory_repair.rst |  10 +
 drivers/cxl/core/edac.c              | 328 ++++++++++++++++++++++++++-
 2 files changed, 337 insertions(+), 1 deletion(-)

diff --git a/Documentation/edac/memory_repair.rst b/Documentation/edac/memory_repair.rst
index 5b1cd8297442..3a3fc11b8fea 100644
--- a/Documentation/edac/memory_repair.rst
+++ b/Documentation/edac/memory_repair.rst
@@ -138,5 +138,15 @@ CXL device to perform a repair operation on its media. For example, a CXL
 device with DRAM components that support memory sparing features may
 implement sparing maintenance operations.
 
+2. CXL memory Soft Post Package Repair (sPPR)
+
+Post Package Repair (PPR) maintenance operations may be supported by CXL
+devices that implement CXL.mem protocol. A PPR maintenance operation
+requests the CXL device to perform a repair operation on its media.
+For example, a CXL device with DRAM components that support PPR features
+may implement PPR Maintenance operations. Soft PPR (sPPR), is a temporary
+row repair. Soft PPR may be faster, but the repair is lost with a power
+cycle.
+
 Sysfs files for memory repair are documented in
 `Documentation/ABI/testing/sysfs-edac-memory-repair`
diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
index 4538752fb0b9..562c39a95399 100644
--- a/drivers/cxl/core/edac.c
+++ b/drivers/cxl/core/edac.c
@@ -14,6 +14,7 @@
 #include <linux/cleanup.h>
 #include <linux/edac.h>
 #include <linux/limits.h>
+#include <linux/unaligned.h>
 #include <linux/xarray.h>
 #include <cxl/features.h>
 #include <cxl.h>
@@ -21,7 +22,7 @@
 #include "core.h"
 #include "trace.h"
 
-#define CXL_NR_EDAC_DEV_FEATURES 6
+#define CXL_NR_EDAC_DEV_FEATURES 7
 
 static bool cxl_is_memdev_memory_online(const struct cxl_memdev *cxlmd)
 {
@@ -1642,6 +1643,321 @@ static int cxl_memdev_sparing_init(struct cxl_memdev *cxlmd,
 
 	return 0;
 }
+
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
+	u8 op_class;
+	u8 op_subclass;
+	bool cap_dpa;
+	bool cap_nib_mask;
+	bool media_accessible;
+	bool data_retained;
+	struct cxl_memdev *cxlmd;
+	enum edac_mem_repair_type repair_type;
+	bool persist_mode;
+	u64 dpa;
+	u32 nibble_mask;
+};
+
+/*
+ * See CXL rev 3.2 @8.2.10.7.2.1 Table 8-128 sPPR Feature Readable Attributes
+ *
+ * See CXL rev 3.2 @8.2.10.7.2.2 Table 8-131 hPPR Feature Readable Attributes
+ */
+
+#define CXL_PPR_OP_CAP_DEVICE_INITIATED BIT(0)
+#define CXL_PPR_OP_MODE_DEV_INITIATED BIT(0)
+
+#define CXL_PPR_FLAG_DPA_SUPPORT_MASK BIT(0)
+#define CXL_PPR_FLAG_NIB_SUPPORT_MASK BIT(1)
+#define CXL_PPR_FLAG_MEM_SPARING_EV_REC_SUPPORT_MASK BIT(2)
+#define CXL_PPR_FLAG_DEV_INITED_PPR_AT_BOOT_CAP_MASK BIT(3)
+
+#define CXL_PPR_RESTRICTION_FLAG_MEDIA_ACCESSIBLE_MASK BIT(0)
+#define CXL_PPR_RESTRICTION_FLAG_DATA_RETAINED_MASK BIT(2)
+
+#define CXL_PPR_SPARING_EV_REC_EN_MASK BIT(0)
+#define CXL_PPR_DEV_INITED_PPR_AT_BOOT_EN_MASK BIT(1)
+
+#define CXL_PPR_GET_CAP_DPA(flags) \
+	FIELD_GET(CXL_PPR_FLAG_DPA_SUPPORT_MASK, flags)
+#define CXL_PPR_GET_CAP_NIB_MASK(flags) \
+	FIELD_GET(CXL_PPR_FLAG_NIB_SUPPORT_MASK, flags)
+#define CXL_PPR_GET_MEDIA_ACCESSIBLE(restriction_flags) \
+	(FIELD_GET(CXL_PPR_RESTRICTION_FLAG_MEDIA_ACCESSIBLE_MASK, \
+		   restriction_flags) ^ 1)
+#define CXL_PPR_GET_DATA_RETAINED(restriction_flags) \
+	(FIELD_GET(CXL_PPR_RESTRICTION_FLAG_DATA_RETAINED_MASK, \
+		   restriction_flags) ^ 1)
+
+struct cxl_memdev_ppr_rd_attrbs {
+	struct cxl_memdev_repair_rd_attrbs_hdr hdr;
+	u8 ppr_flags;
+	__le16 restriction_flags;
+	u8 ppr_op_mode;
+} __packed;
+
+/*
+ * See CXL rev 3.2 @8.2.10.7.1.2 Table 8-118 sPPR Maintenance Input Payload
+ *
+ * See CXL rev 3.2 @8.2.10.7.1.3 Table 8-119 hPPR Maintenance Input Payload
+ */
+struct cxl_memdev_ppr_maintenance_attrbs {
+	u8 flags;
+	__le64 dpa;
+	u8 nibble_mask[3];
+} __packed;
+
+static int cxl_mem_ppr_get_attrbs(struct cxl_ppr_context *cxl_ppr_ctx)
+{
+	size_t rd_data_size = sizeof(struct cxl_memdev_ppr_rd_attrbs);
+	struct cxl_memdev *cxlmd = cxl_ppr_ctx->cxlmd;
+	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
+	u16 restriction_flags;
+	size_t data_size;
+	u16 return_code;
+
+	struct cxl_memdev_ppr_rd_attrbs *rd_attrbs __free(kfree) =
+		kmalloc(rd_data_size, GFP_KERNEL);
+	if (!rd_attrbs)
+		return -ENOMEM;
+
+	data_size = cxl_get_feature(cxl_mbox, &cxl_ppr_ctx->repair_uuid,
+				    CXL_GET_FEAT_SEL_CURRENT_VALUE, rd_attrbs,
+				    rd_data_size, 0, &return_code);
+	if (!data_size)
+		return -EIO;
+
+	cxl_ppr_ctx->op_class = rd_attrbs->hdr.op_class;
+	cxl_ppr_ctx->op_subclass = rd_attrbs->hdr.op_subclass;
+	cxl_ppr_ctx->cap_dpa = CXL_PPR_GET_CAP_DPA(rd_attrbs->ppr_flags);
+	cxl_ppr_ctx->cap_nib_mask =
+		CXL_PPR_GET_CAP_NIB_MASK(rd_attrbs->ppr_flags);
+
+	restriction_flags = le16_to_cpu(rd_attrbs->restriction_flags);
+	cxl_ppr_ctx->media_accessible =
+		CXL_PPR_GET_MEDIA_ACCESSIBLE(restriction_flags);
+	cxl_ppr_ctx->data_retained =
+		CXL_PPR_GET_DATA_RETAINED(restriction_flags);
+
+	return 0;
+}
+
+static int cxl_mem_perform_ppr(struct cxl_ppr_context *cxl_ppr_ctx)
+{
+	struct cxl_memdev_ppr_maintenance_attrbs maintenance_attrbs;
+	struct cxl_memdev *cxlmd = cxl_ppr_ctx->cxlmd;
+	struct cxl_mem_repair_attrbs attrbs = { 0 };
+
+	struct rw_semaphore *region_lock __free(rwsem_read_release) =
+		rwsem_read_intr_acquire(&cxl_region_rwsem);
+	if (!region_lock)
+		return -EINTR;
+
+	struct rw_semaphore *dpa_lock __free(rwsem_read_release) =
+		rwsem_read_intr_acquire(&cxl_dpa_rwsem);
+	if (!dpa_lock)
+		return -EINTR;
+
+	if (!cxl_ppr_ctx->media_accessible || !cxl_ppr_ctx->data_retained) {
+		/* Memory to repair must be offline */
+		if (cxl_is_memdev_memory_online(cxlmd))
+			return -EBUSY;
+	} else {
+		if (cxl_is_memdev_memory_online(cxlmd)) {
+			/* Check memory to repair is from the current boot */
+			attrbs.repair_type = CXL_PPR;
+			attrbs.dpa = cxl_ppr_ctx->dpa;
+			attrbs.nibble_mask = cxl_ppr_ctx->nibble_mask;
+			if (!cxl_find_rec_dram(cxlmd, &attrbs) &&
+			    !cxl_find_rec_gen_media(cxlmd, &attrbs))
+				return -EINVAL;
+		}
+	}
+
+	memset(&maintenance_attrbs, 0, sizeof(maintenance_attrbs));
+	maintenance_attrbs.flags = 0;
+	maintenance_attrbs.dpa = cpu_to_le64(cxl_ppr_ctx->dpa);
+	put_unaligned_le24(cxl_ppr_ctx->nibble_mask,
+			   maintenance_attrbs.nibble_mask);
+
+	return cxl_perform_maintenance(&cxlmd->cxlds->cxl_mbox,
+				       cxl_ppr_ctx->op_class,
+				       cxl_ppr_ctx->op_subclass,
+				       &maintenance_attrbs,
+				       sizeof(maintenance_attrbs));
+}
+
+static int cxl_ppr_get_repair_type(struct device *dev, void *drv_data,
+				   const char **repair_type)
+{
+	*repair_type = edac_repair_type[EDAC_REPAIR_PPR];
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
+
+	*safe = cxl_ppr_ctx->media_accessible & cxl_ppr_ctx->data_retained;
+
+	return 0;
+}
+
+static int cxl_ppr_get_min_dpa(struct device *dev, void *drv_data, u64 *min_dpa)
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
+static int cxl_ppr_get_max_dpa(struct device *dev, void *drv_data, u64 *max_dpa)
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
+static int cxl_ppr_get_dpa(struct device *dev, void *drv_data, u64 *dpa)
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
+static int cxl_ppr_set_nibble_mask(struct device *dev, void *drv_data,
+				   u32 nibble_mask)
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
+	return cxl_mem_perform_ppr(cxl_ppr_ctx);
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
+	int ret;
+
+	feat_entry = cxl_feature_info(to_cxlfs(cxlmd->cxlds),
+				      &CXL_FEAT_SPPR_UUID);
+	if (!feat_entry)
+		return -EOPNOTSUPP;
+
+	if (!(le32_to_cpu(feat_entry->flags) & CXL_FEATURE_F_CHANGEABLE))
+		return -EOPNOTSUPP;
+
+	cxl_sppr_ctx =
+		devm_kzalloc(&cxlmd->dev, sizeof(*cxl_sppr_ctx), GFP_KERNEL);
+	if (!cxl_sppr_ctx)
+		return -ENOMEM;
+
+	*cxl_sppr_ctx = (struct cxl_ppr_context){
+		.get_feat_size = le16_to_cpu(feat_entry->get_feat_size),
+		.set_feat_size = le16_to_cpu(feat_entry->set_feat_size),
+		.get_version = feat_entry->get_feat_ver,
+		.set_version = feat_entry->set_feat_ver,
+		.effects = le16_to_cpu(feat_entry->effects),
+		.cxlmd = cxlmd,
+		.repair_type = EDAC_REPAIR_PPR,
+		.persist_mode = 0,
+		.instance = repair_inst,
+	};
+	uuid_copy(&cxl_sppr_ctx->repair_uuid, &CXL_FEAT_SPPR_UUID);
+
+	ret = cxl_mem_ppr_get_attrbs(cxl_sppr_ctx);
+	if (ret)
+		return ret;
+
+	ras_feature->ft_type = RAS_FEAT_MEM_REPAIR;
+	ras_feature->instance = cxl_sppr_ctx->instance;
+	ras_feature->mem_repair_ops = &cxl_sppr_ops;
+	ras_feature->ctx = cxl_sppr_ctx;
+
+	return 0;
+}
 #endif /* CONFIG_CXL_EDAC_MEM_REPAIR */
 
 int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd)
@@ -1696,6 +2012,16 @@ int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd)
 		repair_inst++;
 		num_ras_features++;
 	}
+
+	rc = cxl_memdev_soft_ppr_init(cxlmd, &ras_features[num_ras_features],
+				      repair_inst);
+	if (rc < 0 && rc != -EOPNOTSUPP)
+		return rc;
+
+	if (rc != -EOPNOTSUPP) {
+		repair_inst++;
+		num_ras_features++;
+	}
 #endif
 	char *cxl_dev_name __free(kfree) =
 		kasprintf(GFP_KERNEL, "cxl_%s", dev_name(&cxlmd->dev));
-- 
2.43.0


