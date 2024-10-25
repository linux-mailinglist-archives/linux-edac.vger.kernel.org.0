Return-Path: <linux-edac+bounces-2304-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCB69B0AF7
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2024 19:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F0B028762B
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2024 17:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D40B21E605;
	Fri, 25 Oct 2024 17:15:12 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA67921B87C;
	Fri, 25 Oct 2024 17:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729876512; cv=none; b=fPFaRcwKteQ6yfJaP8IwJoDSFNf5rCpVKycTFpSrJ/pPIASU9Mv9iNIfsmoywEUPwr4O1FAVuCKnNkHG0BhIEICUEAJ/SYq+P/jhI1ghv7gUhNHHPjFGCZ8QLHla8tXixha6JP9CrYZqAX+uuHdgzUX83lCI6qge8UZoY92FMP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729876512; c=relaxed/simple;
	bh=gtjC+qvidR7l9TFS1nYFcbK1xDux3ZhB7bWSaw3o/Iw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aUoIjQvM/vYsmgobGt2hn0UHu4HQn00JTXABRL6x2M8e0aL12HLlMuBk6jMpnJVPv/wSvp4Kt+XD8EOPcXlmtWyvTAvRckgNmORihxgd7GqqtOzSlJh/7fYdoimNYEvga8/5I+QK8UJx6Lo79yals5X7JkMckQSxH1tS/zsILKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XZqBf6Bytz67CtB;
	Sat, 26 Oct 2024 01:14:02 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id EDAB5140A70;
	Sat, 26 Oct 2024 01:15:06 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.151.104) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 19:15:04 +0200
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
CC: <bp@alien8.de>, <tony.luck@intel.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <mchehab@kernel.org>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<gregkh@linuxfoundation.org>, <sudeep.holla@arm.com>,
	<jassisinghbrar@gmail.com>, <dave.jiang@intel.com>,
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
Subject: [PATCH v14 14/14] cxl/memfeature: Add CXL memory device memory sparing control feature
Date: Fri, 25 Oct 2024 18:13:55 +0100
Message-ID: <20241025171356.1377-15-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20241025171356.1377-1-shiju.jose@huawei.com>
References: <20241025171356.1377-1-shiju.jose@huawei.com>
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

Memory sparing is defined as a repair function that replaces a portion of
memory with a portion of functional memory at that same DPA. The subclasses
for this operation vary in terms of the scope of the sparing being
performed. The cacheline sparing subclass refers to a sparing action that
can replace a full cacheline. Row sparing is provided as an alternative to
PPR sparing functions and its scope is that of a single DDR row. Bank
sparing allows an entire bank to be replaced. Rank sparing is defined as
an operation in which an entire DDR rank is replaced.

Memory sparing maintenance operations may be supported by CXL devices
that implement CXL.mem protocol. A sparing maintenance operation requests
the CXL device to perform a repair operation on its media.
For example, a CXL device with DRAM components that support memory sparing
features may implement sparing maintenance operations.

The host may issue a query command by setting query resources flag in the
input payload (CXL spec 3.1 Table 8-105) to determine availability of
sparing resources for a given address. In response to a query request,
the device shall report the resource availability by producing the memory
sparing event record (CXL spec 3.1 Table 8-48) in which the Channel, Rank,
Nibble Mask, Bank Group, Bank, Row, Column, Sub-Channel fields are a copy
of the values specified in the request.

During the execution of a sparing maintenance operation, a CXL memory
device:
- May or may not retain data
- May or may not be able to process CXL.mem requests correctly.
These CXL memory device capabilities are specified by restriction flags
in the memory sparing feature readable attributes.

When a CXL device identifies a failure on a memory component, the device
may inform the host about the need for a memory sparing maintenance
operation by using an Event Record, where the maintenance needed flag may
set. The event record specifies some of the DPA, Channel, Rank, Nibble
Mask, Bank Group, Bank, Row, Column, Sub-Channel fields that should be
repaired. The userspace tool requests for maintenance operation if the
number of corrected error reported on a CXL.mem media exceeds error
threshold.

CXL spec 3.1 section 8.2.9.7.1.4 describes the device's memory sparing
maintenance operation feature.

CXL spec 3.1 section 8.2.9.7.2.3 describes the memory sparing feature
discovery and configuration.

Add support for controlling CXL memory device memory sparing feature.
Register with EDAC driver, which gets the memory repair attr descriptors
from the EDAC memory repair driver and exposes sysfs repair control
attributes for memory sparing to the userspace. For example CXL memory
sparing control for the CXL mem0 device is exposed in
/sys/bus/edac/devices/cxl_mem0/mem_repairX/

Use case
========
1. CXL device identifies a failure in a memory component, report to
   userspace in a CXL generic/DRAM trace event.
2. Rasdaemon process the trace event and issue query request in sysfs to
check resources available for memory sparing if either of the following
conditions met.
 - number of corrected error reported on a CXL.mem media exceeds error
threshold
 - maintenance needed flag set in the event record.
3. CXL device shall report the resource availability by producing the
memory sparing event record in which the channel, rank, nibble mask, bank
Group, bank, row, column, sub-channel fields are a copy of the values
specified in the request. The query resource command shall return error
(invalid input) if the controller does not support reporting resource is
available.
4. Rasdaemon process the memory sparing trace event and issue repair
request for memory sparing.

Kernel CXL driver shall report memory sparing event record to the userspace
with the resource availability in order rasdaemon to process the event
record and issue a repair request in sysfs for the memory sparing operation
in the CXL device.

Tested for memory sparing control feature with
   "hw/cxl: Add memory sparing control feature"
   Repository: "https://gitlab.com/shiju.jose/qemu.git"
   Branch: cxl-ras-features-2024-10-24

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/core/memfeature.c | 478 +++++++++++++++++++++++++++++++++-
 1 file changed, 477 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/memfeature.c b/drivers/cxl/core/memfeature.c
index 00635e709c9d..d044518de3b6 100644
--- a/drivers/cxl/core/memfeature.c
+++ b/drivers/cxl/core/memfeature.c
@@ -20,7 +20,7 @@
 #include <cxlmem.h>
 #include "core.h"
 
-#define CXL_DEV_NUM_RAS_FEATURES	3
+#define CXL_DEV_NUM_RAS_FEATURES	7
 #define CXL_DEV_HOUR_IN_SECS	3600
 
 #define CXL_SCRUB_NAME_LEN	128
@@ -958,9 +958,447 @@ static const struct edac_mem_repair_ops cxl_sppr_ops = {
 	.do_repair = cxl_do_ppr,
 };
 
+/* CXL memory sparing control definitions */
+/* See CXL rev 3.1 @8.2.9.7.2 Table 8-110 Maintenance Operation */
+#define CXL_CACHELINE_SPARING_UUID UUID_INIT(0x96C33386, 0x91dd, 0x44c7, 0x9e, 0xcb,    \
+		  0xfd, 0xaf, 0x65, 0x03, 0xba, 0xc4)
+#define CXL_ROW_SPARING_UUID UUID_INIT(0x450ebf67, 0xb135, 0x4f97, 0xa4, 0x98,    \
+		  0xc2, 0xd5, 0x7f, 0x27, 0x9b, 0xed)
+#define CXL_BANK_SPARING_UUID UUID_INIT(0x78b79636, 0x90ac, 0x4b64, 0xa4, 0xef,    \
+		  0xfa, 0xac, 0x5d, 0x18, 0xa8, 0x63)
+#define CXL_RANK_SPARING_UUID  UUID_INIT(0x34dbaff5, 0x0552, 0x4281, 0x8f, 0x76,    \
+		  0xda, 0x0b, 0x5e, 0x7a, 0x76, 0xa7)
+
+enum cxl_mem_sparing_granularity {
+	CXL_MEM_SPARING_CACHELINE,
+	CXL_MEM_SPARING_ROW,
+	CXL_MEM_SPARING_BANK,
+	CXL_MEM_SPARING_RANK,
+	CXL_MEM_SPARING_MAX
+};
+
+struct cxl_mem_sparing_context {
+	uuid_t repair_uuid;
+	u8 instance;
+	u16 get_feat_size;
+	u16 set_feat_size;
+	u8 get_version;
+	u8 set_version;
+	u16 set_effects;
+	struct cxl_memdev *cxlmd;
+	enum edac_mem_repair_type repair_type;
+	enum edac_mem_repair_persist_mode persist_mode;
+	enum cxl_mem_sparing_granularity granularity;
+	bool dpa_support;
+	u64 dpa;
+	u8 channel;
+	u8 rank;
+	u32 nibble_mask;
+	u8 bank_group;
+	u8 bank;
+	u32 row;
+	u16 column;
+	u8 sub_channel;
+};
+
+struct cxl_memdev_sparing_params {
+	u8 op_class;
+	u8 op_subclass;
+	bool cap_safe_when_in_use;
+	bool cap_hard_sparing;
+	bool cap_soft_sparing;
+};
+
+enum cxl_mem_sparing_param_type {
+	CXL_MEM_SPARING_PARAM_DO_QUERY,
+	CXL_MEM_SPARING_PARAM_DO_REPAIR,
+};
+
+#define CXL_MEMDEV_SPARING_RD_CAP_SAFE_IN_USE_MASK BIT(0)
+#define CXL_MEMDEV_SPARING_RD_CAP_HARD_SPARING_MASK BIT(1)
+#define CXL_MEMDEV_SPARING_RD_CAP_SOFT_SPARING_MASK BIT(2)
+
+#define CXL_MEMDEV_SPARING_WR_DEVICE_INITIATED_MASK BIT(0)
+
+#define CXL_MEMDEV_SPARING_QUERY_RESOURCE_FLAG BIT(0)
+#define CXL_MEMDEV_SET_HARD_SPARING_FLAG BIT(1)
+#define CXL_MEMDEV_SPARING_SUB_CHANNEL_VALID_FLAG BIT(2)
+#define CXL_MEMDEV_SPARING_NIB_MASK_VALID_FLAG BIT(3)
+
+/* See CXL rev 3.1 @8.2.9.7.2.3 Table 8-119 Memory Sparing Feature Readable Attributes */
+struct cxl_memdev_sparing_rd_attrs {
+	struct cxl_memdev_repair_rd_attrs_hdr hdr;
+	u8 rsvd;
+	__le16 restriction_flags;
+}  __packed;
+
+/* See CXL rev 3.1 @8.2.9.7.2.3 Table 8-120 Memory Sparing Feature Writable Attributes */
+struct cxl_memdev_sparing_wr_attrs {
+	__le16 op_mode;
+}  __packed;
+
+/* See CXL rev 3.1 @8.2.9.7.1.4 Table 8-105 Memory Sparing Input Payload */
+struct cxl_memdev_sparing_in_payload {
+	u8 flags;
+	u8 channel;
+	u8 rank;
+	u8 nibble_mask[3];
+	u8 bank_group;
+	u8 bank;
+	u8 row[3];
+	u16 column;
+	u8 sub_channel;
+}  __packed;
+
+static int cxl_mem_sparing_get_attrs(struct device *dev, void *drv_data,
+				     struct cxl_memdev_sparing_params *params)
+{
+	struct cxl_mem_sparing_context *cxl_sparing_ctx = drv_data;
+	struct cxl_memdev *cxlmd = cxl_sparing_ctx->cxlmd;
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	size_t rd_data_size = sizeof(struct cxl_memdev_sparing_rd_attrs);
+	size_t data_size;
+	struct cxl_memdev_sparing_rd_attrs *rd_attrs __free(kfree) =
+				kmalloc(rd_data_size, GFP_KERNEL);
+	if (!rd_attrs)
+		return -ENOMEM;
+
+	data_size = cxl_get_feature(mds, cxl_sparing_ctx->repair_uuid,
+				    CXL_GET_FEAT_SEL_CURRENT_VALUE,
+				    rd_attrs, rd_data_size);
+	if (!data_size)
+		return -EIO;
+
+	params->op_class = rd_attrs->hdr.op_class;
+	params->op_subclass = rd_attrs->hdr.op_subclass;
+	params->cap_safe_when_in_use = FIELD_GET(CXL_MEMDEV_SPARING_RD_CAP_SAFE_IN_USE_MASK,
+						 rd_attrs->restriction_flags) ^ 1;
+	params->cap_hard_sparing = FIELD_GET(CXL_MEMDEV_SPARING_RD_CAP_HARD_SPARING_MASK,
+					     rd_attrs->restriction_flags);
+	params->cap_soft_sparing = FIELD_GET(CXL_MEMDEV_SPARING_RD_CAP_SOFT_SPARING_MASK,
+					     rd_attrs->restriction_flags);
+
+	return 0;
+}
+
+static int cxl_mem_do_sparing_op(struct device *dev, void *drv_data,
+				 struct cxl_memdev_sparing_params *rd_params,
+				 enum cxl_mem_sparing_param_type param_type)
+{
+	struct cxl_memdev_sparing_in_payload sparing_pi;
+	struct cxl_mem_sparing_context *cxl_sparing_ctx = drv_data;
+	struct cxl_memdev *cxlmd = cxl_sparing_ctx->cxlmd;
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	int ret;
+
+	if (!rd_params->cap_safe_when_in_use && cxl_sparing_ctx->dpa) {
+		/* Check if DPA is mapped */
+		if (cxl_dpa_to_region(cxlmd, cxl_sparing_ctx->dpa)) {
+			dev_err(dev, "CXL can't do sparing as DPA is mapped\n");
+			return -EBUSY;
+		}
+	}
+	memset(&sparing_pi, 0, sizeof(sparing_pi));
+	if (param_type == CXL_MEM_SPARING_PARAM_DO_QUERY) {
+		sparing_pi.flags = CXL_MEMDEV_SPARING_QUERY_RESOURCE_FLAG;
+	} else {
+		sparing_pi.flags =
+			FIELD_PREP(CXL_MEMDEV_SPARING_QUERY_RESOURCE_FLAG, 0);
+		/* Do need set hard sparing, sub-channel & nb mask flags for query? */
+		if (cxl_sparing_ctx->persist_mode == EDAC_MEM_REPAIR_HARD)
+			sparing_pi.flags |=
+				FIELD_PREP(CXL_MEMDEV_SET_HARD_SPARING_FLAG, 1);
+		if (cxl_sparing_ctx->sub_channel)
+			sparing_pi.flags |=
+				FIELD_PREP(CXL_MEMDEV_SPARING_SUB_CHANNEL_VALID_FLAG, 1);
+		if (cxl_sparing_ctx->nibble_mask)
+			sparing_pi.flags |=
+				FIELD_PREP(CXL_MEMDEV_SPARING_NIB_MASK_VALID_FLAG, 1);
+	}
+	/* Common atts for all memory sparing types */
+	sparing_pi.channel = cxl_sparing_ctx->channel;
+	sparing_pi.rank = cxl_sparing_ctx->rank;
+	*((u32 *)&sparing_pi.nibble_mask[0]) = cxl_sparing_ctx->nibble_mask;
+
+	if (cxl_sparing_ctx->repair_type == EDAC_TYPE_CACHELINE_MEM_SPARING ||
+	    cxl_sparing_ctx->repair_type == EDAC_TYPE_ROW_MEM_SPARING ||
+	    cxl_sparing_ctx->repair_type == EDAC_TYPE_BANK_MEM_SPARING) {
+		sparing_pi.bank_group = cxl_sparing_ctx->bank_group;
+		sparing_pi.bank = cxl_sparing_ctx->bank;
+	}
+	if (cxl_sparing_ctx->repair_type == EDAC_TYPE_CACHELINE_MEM_SPARING ||
+	    cxl_sparing_ctx->repair_type == EDAC_TYPE_ROW_MEM_SPARING)
+		*((u32 *)&sparing_pi.row[0]) = cxl_sparing_ctx->row;
+	if (cxl_sparing_ctx->repair_type == EDAC_TYPE_CACHELINE_MEM_SPARING) {
+		sparing_pi.column = cxl_sparing_ctx->column;
+		sparing_pi.sub_channel = cxl_sparing_ctx->sub_channel;
+	}
+
+	ret = cxl_do_maintenance(mds, rd_params->op_class, rd_params->op_subclass,
+				 &sparing_pi, sizeof(sparing_pi));
+	if (ret) {
+		dev_err(dev, "CXL do mem sparing failed ret=%d\n", ret);
+		cxl_sparing_ctx->dpa = 0;
+		cxl_sparing_ctx->nibble_mask = 0;
+		cxl_sparing_ctx->bank_group = 0;
+		cxl_sparing_ctx->bank = 0;
+		cxl_sparing_ctx->rank = 0;
+		cxl_sparing_ctx->row = 0;
+		cxl_sparing_ctx->column = 0;
+		cxl_sparing_ctx->channel = 0;
+		cxl_sparing_ctx->sub_channel = 0;
+		return ret;
+	}
+
+	return 0;
+}
+
+static int cxl_mem_sparing_set_attrs(struct device *dev, void *drv_data,
+				     enum cxl_mem_sparing_param_type param_type)
+{
+	struct cxl_memdev_sparing_params rd_params;
+	int ret;
+
+	ret = cxl_mem_sparing_get_attrs(dev, drv_data, &rd_params);
+	if (ret) {
+		dev_err(dev, "Get cxlmemdev sparing params failed ret=%d\n",
+			ret);
+		return ret;
+	}
+
+	switch (param_type) {
+	case CXL_MEM_SPARING_PARAM_DO_QUERY:
+	case CXL_MEM_SPARING_PARAM_DO_REPAIR:
+		ret = down_read_interruptible(&cxl_region_rwsem);
+		if (ret)
+			return ret;
+		ret = down_read_interruptible(&cxl_dpa_rwsem);
+		if (ret) {
+			up_read(&cxl_region_rwsem);
+			return ret;
+		}
+		ret = cxl_mem_do_sparing_op(dev, drv_data, &rd_params, param_type);
+		up_read(&cxl_dpa_rwsem);
+		up_read(&cxl_region_rwsem);
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+#define CXL_SPARING_GET_ATTR(attrib, data_type)					\
+static int cxl_mem_sparing_get_##attrib(struct device *dev, void *drv_data,	\
+					data_type *val)				\
+{										\
+	struct cxl_mem_sparing_context *ctx = drv_data;				\
+										\
+	*val = ctx->attrib;							\
+										\
+	return 0;								\
+}
+CXL_SPARING_GET_ATTR(repair_type, u32)
+CXL_SPARING_GET_ATTR(persist_mode, u32)
+CXL_SPARING_GET_ATTR(dpa_support, u32)
+CXL_SPARING_GET_ATTR(dpa, u64)
+CXL_SPARING_GET_ATTR(nibble_mask, u64)
+CXL_SPARING_GET_ATTR(bank_group, u32)
+CXL_SPARING_GET_ATTR(bank, u32)
+CXL_SPARING_GET_ATTR(rank, u32)
+CXL_SPARING_GET_ATTR(row, u64)
+CXL_SPARING_GET_ATTR(column, u32)
+CXL_SPARING_GET_ATTR(channel, u32)
+CXL_SPARING_GET_ATTR(sub_channel, u32)
+
+#define CXL_SPARING_SET_ATTR(attrib, data_type)					\
+static int cxl_mem_sparing_set_##attrib(struct device *dev, void *drv_data,	\
+					data_type val)				\
+{										\
+	struct cxl_mem_sparing_context *ctx = drv_data;				\
+										\
+	ctx->attrib = val;							\
+										\
+	return 0;								\
+}
+CXL_SPARING_SET_ATTR(nibble_mask, u64)
+CXL_SPARING_SET_ATTR(bank_group, u32)
+CXL_SPARING_SET_ATTR(bank, u32)
+CXL_SPARING_SET_ATTR(rank, u32)
+CXL_SPARING_SET_ATTR(row, u64)
+CXL_SPARING_SET_ATTR(column, u32)
+CXL_SPARING_SET_ATTR(channel, u32)
+CXL_SPARING_SET_ATTR(sub_channel, u32)
+
+static int cxl_mem_sparing_get_persist_mode_avail(struct device *dev, void *drv_data,
+						  char *buf)
+{
+struct cxl_memdev_sparing_params params;
+	int ret;
+
+	ret = cxl_mem_sparing_get_attrs(dev, drv_data, &params);
+	if (ret)
+		return ret;
+
+	if (params.cap_soft_sparing && params.cap_hard_sparing)
+		return sysfs_emit(buf, "%u,%u\n", EDAC_MEM_REPAIR_SOFT, EDAC_MEM_REPAIR_HARD);
+	else if (params.cap_soft_sparing)
+		return sysfs_emit(buf, "%u\n", EDAC_MEM_REPAIR_SOFT);
+	else if (params.cap_hard_sparing)
+		return sysfs_emit(buf, "%u\n", EDAC_MEM_REPAIR_HARD);
+	else
+		return sysfs_emit(buf, "Not Supported\n");
+}
+
+static int cxl_mem_sparing_set_persist_mode(struct device *dev, void *drv_data, u32 persist_mode)
+{
+	struct cxl_mem_sparing_context *ctx = drv_data;
+
+	switch (persist_mode) {
+	case EDAC_MEM_REPAIR_SOFT:
+		ctx->persist_mode = EDAC_MEM_REPAIR_SOFT;
+		return 0;
+	case EDAC_MEM_REPAIR_HARD:
+		ctx->persist_mode = EDAC_MEM_REPAIR_HARD;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int cxl_get_mem_sparing_safe_when_in_use(struct device *dev, void *drv_data,
+						u32 *safe)
+{
+	struct cxl_memdev_sparing_params params;
+	int ret;
+
+	ret = cxl_mem_sparing_get_attrs(dev, drv_data, &params);
+	if (ret)
+		return ret;
+
+	*safe = params.cap_safe_when_in_use;
+
+	return 0;
+}
+
+static int cxl_mem_sparing_set_dpa(struct device *dev, void *drv_data, u64 dpa)
+{
+	struct cxl_mem_sparing_context *ctx = drv_data;
+
+	if (!dpa)
+		return -EINVAL;
+
+	ctx->dpa = dpa;
+
+	return 0;
+}
+
+static int cxl_do_query_mem_sparing(struct device *dev, void *drv_data)
+{
+	return cxl_mem_sparing_set_attrs(dev, drv_data, CXL_MEM_SPARING_PARAM_DO_QUERY);
+}
+
+static int cxl_do_mem_sparing(struct device *dev, void *drv_data)
+{
+	return cxl_mem_sparing_set_attrs(dev, drv_data, CXL_MEM_SPARING_PARAM_DO_REPAIR);
+}
+
+#define RANK_OPS \
+	.get_repair_type = cxl_mem_sparing_get_repair_type, \
+	.get_persist_mode_avail = cxl_mem_sparing_get_persist_mode_avail, \
+	.get_persist_mode = cxl_mem_sparing_get_persist_mode, \
+	.set_persist_mode = cxl_mem_sparing_set_persist_mode, \
+	.get_repair_safe_when_in_use = cxl_get_mem_sparing_safe_when_in_use, \
+	.get_dpa_support = cxl_mem_sparing_get_dpa_support, \
+	.get_dpa = cxl_mem_sparing_get_dpa, \
+	.set_dpa = cxl_mem_sparing_set_dpa, \
+	.get_nibble_mask = cxl_mem_sparing_get_nibble_mask, \
+	.set_nibble_mask = cxl_mem_sparing_set_nibble_mask, \
+	.get_rank = cxl_mem_sparing_get_rank, \
+	.set_rank = cxl_mem_sparing_set_rank, \
+	.get_channel = cxl_mem_sparing_get_channel, \
+	.set_channel = cxl_mem_sparing_set_channel, \
+	.do_query = cxl_do_query_mem_sparing, \
+	.do_repair = cxl_do_mem_sparing
+
+#define BANK_OPS \
+	RANK_OPS, \
+	.get_bank_group = cxl_mem_sparing_get_bank_group, \
+	.set_bank_group = cxl_mem_sparing_set_bank_group, \
+	.get_bank = cxl_mem_sparing_get_bank, \
+	.set_bank = cxl_mem_sparing_set_bank
+
+#define ROW_OPS \
+	BANK_OPS, \
+	.get_row = cxl_mem_sparing_get_row, \
+	.set_row = cxl_mem_sparing_set_row
+
+#define CACHELINE_OPS \
+	ROW_OPS, \
+	.get_column = cxl_mem_sparing_get_column, \
+	.set_column = cxl_mem_sparing_set_column, \
+	.get_sub_channel = cxl_mem_sparing_get_sub_channel, \
+	.set_sub_channel = cxl_mem_sparing_set_sub_channel
+
+static const struct edac_mem_repair_ops cxl_rank_sparing_ops = {
+	RANK_OPS,
+};
+
+static const struct edac_mem_repair_ops cxl_bank_sparing_ops = {
+	BANK_OPS,
+};
+
+static const struct edac_mem_repair_ops cxl_row_sparing_ops = {
+	ROW_OPS,
+};
+
+static const struct edac_mem_repair_ops cxl_cacheline_sparing_ops = {
+	CACHELINE_OPS,
+};
+
+struct cxl_mem_sparing_desc {
+	const uuid_t repair_uuid;
+	enum edac_mem_repair_type repair_type;
+	enum edac_mem_repair_persist_mode persist_mode;
+	enum cxl_mem_sparing_granularity granularity;
+	const struct edac_mem_repair_ops *repair_ops;
+};
+
+static const struct cxl_mem_sparing_desc mem_sparing_desc[] = {
+	{
+		.repair_uuid = CXL_CACHELINE_SPARING_UUID,
+		.repair_type = EDAC_TYPE_CACHELINE_MEM_SPARING,
+		.persist_mode = EDAC_MEM_REPAIR_SOFT,
+		.granularity = CXL_MEM_SPARING_CACHELINE,
+		.repair_ops = &cxl_cacheline_sparing_ops,
+	},
+	{
+		.repair_uuid = CXL_ROW_SPARING_UUID,
+		.repair_type = EDAC_TYPE_ROW_MEM_SPARING,
+		.persist_mode = EDAC_MEM_REPAIR_SOFT,
+		.granularity = CXL_MEM_SPARING_ROW,
+		.repair_ops = &cxl_row_sparing_ops,
+	},
+	{
+		.repair_uuid = CXL_BANK_SPARING_UUID,
+		.repair_type = EDAC_TYPE_BANK_MEM_SPARING,
+		.persist_mode = EDAC_MEM_REPAIR_SOFT,
+		.granularity = CXL_MEM_SPARING_BANK,
+		.repair_ops = &cxl_bank_sparing_ops,
+	},
+	{
+		.repair_uuid = CXL_RANK_SPARING_UUID,
+		.repair_type = EDAC_TYPE_RANK_MEM_SPARING,
+		.persist_mode = EDAC_MEM_REPAIR_SOFT,
+		.granularity = CXL_MEM_SPARING_RANK,
+		.repair_ops = &cxl_rank_sparing_ops,
+	},
+};
+
 int cxl_mem_ras_features_init(struct cxl_memdev *cxlmd, struct cxl_region *cxlr)
 {
 	struct edac_dev_feature ras_features[CXL_DEV_NUM_RAS_FEATURES];
+	struct cxl_mem_sparing_context *cxl_sparing_ctx;
 	struct cxl_patrol_scrub_context *cxl_ps_ctx;
 	char cxl_dev_name[CXL_SCRUB_NAME_LEN];
 	struct cxl_ppr_context *cxl_sppr_ctx;
@@ -1101,6 +1539,44 @@ int cxl_mem_ras_features_init(struct cxl_memdev *cxlmd, struct cxl_region *cxlr)
 	num_ras_features++;
 
 feat_sppr_done:
+	/* CXL memory sparing */
+	for (i = 0; i < CXL_MEM_SPARING_MAX; i++) {
+		rc = cxl_get_supported_feature_entry(mds, &mem_sparing_desc[i].repair_uuid,
+						     &feat_entry);
+		if (rc < 0)
+			continue;
+
+		if (!(feat_entry.attr_flags & CXL_FEAT_ENTRY_FLAG_CHANGABLE))
+			continue;
+
+		cxl_sparing_ctx = devm_kzalloc(&cxlmd->dev, sizeof(*cxl_sparing_ctx),
+					       GFP_KERNEL);
+		if (!cxl_sparing_ctx)
+			goto feat_sparing_done;
+
+		*cxl_sparing_ctx = (struct cxl_mem_sparing_context) {
+			.repair_uuid = mem_sparing_desc[i].repair_uuid,
+			.get_feat_size = feat_entry.get_feat_size,
+			.set_feat_size = feat_entry.set_feat_size,
+			.get_version = feat_entry.get_feat_ver,
+			.set_version = feat_entry.set_feat_ver,
+			.set_effects = feat_entry.set_effects,
+			.cxlmd = cxlmd,
+			.repair_type = mem_sparing_desc[i].repair_type,
+			.persist_mode = mem_sparing_desc[i].persist_mode,
+			.granularity = mem_sparing_desc[i].granularity,
+			.dpa_support = true,
+			.instance = repair_inst++,
+		};
+		ras_features[num_ras_features].ft_type = RAS_FEAT_MEM_REPAIR;
+		ras_features[num_ras_features].instance = cxl_sparing_ctx->instance;
+		ras_features[num_ras_features].mem_repair_ops =
+						mem_sparing_desc[i].repair_ops;
+		ras_features[num_ras_features].ctx = cxl_sparing_ctx;
+		num_ras_features++;
+	}
+
+feat_sparing_done:
 	return edac_dev_register(&cxlmd->dev, cxl_dev_name, NULL,
 				 num_ras_features, ras_features);
 }
-- 
2.34.1


