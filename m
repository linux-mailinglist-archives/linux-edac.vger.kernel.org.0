Return-Path: <linux-edac+bounces-2626-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5FD9D63EF
	for <lists+linux-edac@lfdr.de>; Fri, 22 Nov 2024 19:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 976CAB290F1
	for <lists+linux-edac@lfdr.de>; Fri, 22 Nov 2024 18:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0E61E3771;
	Fri, 22 Nov 2024 18:05:33 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6DA1E32D4;
	Fri, 22 Nov 2024 18:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732298732; cv=none; b=Cmxo82SmEa9hdw3vo6NaO5H1T2bP5g1GFBW1rWdiuO1CoG2QAUrL8ylge60/TUuxe6lDn9ysOohpVkrDRBWSoLER/8cPY0Yd+rIYncS/Y8YDdCeGGf69TREzgVenOcvRtt9aX0DDBnv4qRLQtDeqGgE0UPRzm6ZplyIRiYm8F58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732298732; c=relaxed/simple;
	bh=7IFj72F7N60UA5dnpHrTBaGy/3DM/RZoEDL+h3W5X/g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SMsZ3p/fUNh6rBNlhkjfvLQ1SYQhLPxjEi7+pOPBuIcf+DPBjwWXcloSv3MjQ71mPe4Cl6aoo1IqjKpUht374D2cDRL7bvO0rqIYBuwI592v0S7QSQojMC2t5NRD38oXAkM91dpHraSABuJunrN5fPaqFYBPRK6Oysbw52+7YhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xw2wr3j78z6K6NC;
	Sat, 23 Nov 2024 02:01:48 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id EA0171400CA;
	Sat, 23 Nov 2024 02:05:26 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.171.16) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 22 Nov 2024 19:05:24 +0100
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
Subject: [PATCH v17 18/18] cxl/memfeature: Add CXL memory device memory sparing control feature
Date: Fri, 22 Nov 2024 18:04:15 +0000
Message-ID: <20241122180416.1932-19-shiju.jose@huawei.com>
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
- may not retain data
- may not be able to process CXL.mem requests correctly.
These CXL memory device capabilities are specified by restriction flags
in the memory sparing feature readable attributes.

When a CXL device identifies error on a memory component, the device
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
userspace in a CXL generic or DRAM trace event with DPA and other
attributes of memory to repair such as channel, rank, nibble mask,
bank Group, bank, row, column, sub-channel.
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
 Documentation/edac/memory_repair.rst |  90 +++++
 drivers/cxl/core/memfeature.c        | 497 ++++++++++++++++++++++++++-
 2 files changed, 585 insertions(+), 2 deletions(-)

diff --git a/Documentation/edac/memory_repair.rst b/Documentation/edac/memory_repair.rst
index 0dd970f62a20..867ba0adbf8b 100644
--- a/Documentation/edac/memory_repair.rst
+++ b/Documentation/edac/memory_repair.rst
@@ -157,3 +157,93 @@ root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair0/nibble_mask
 # for the repair operation.
 
 root@localhost:~# echo 1 > /sys/bus/edac/devices/cxl_mem0/mem_repair0/repair
+
+1.2. CXL memory sparing
+
+# read capabilities
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair1/repair_function
+
+2
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair1/dpa_support
+
+1
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair1/persist_mode
+
+0
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair1/repair_safe_when_in_use
+
+1
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair1/min_dpa
+
+0x0
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair1/max_dpa
+
+0xfffffff
+
+#set and readback attributes
+
+root@localhost:~# echo 0x700000 > /sys/bus/edac/devices/cxl_mem0/mem_repair1/dpa
+
+root@localhost:~# echo 1 > /sys/bus/edac/devices/cxl_mem0/mem_repair1/bank_group
+
+root@localhost:~# echo 3 > /sys/bus/edac/devices/cxl_mem0/mem_repair1/bank
+
+root@localhost:~# echo 2 > /sys/bus/edac/devices/cxl_mem0/mem_repair1/channel
+
+root@localhost:~# echo  7 > /sys/bus/edac/devices/cxl_mem0/mem_repair1/rank
+
+root@localhost:~# echo 0x240a > /sys/bus/edac/devices/cxl_mem0/mem_repair1/row
+
+root@localhost:~# echo 5 > /sys/bus/edac/devices/cxl_mem0/mem_repair1/sub_channel
+
+root@localhost:~# echo 11 > /sys/bus/edac/devices/cxl_mem0/mem_repair1/column
+
+root@localhost:~# echo 0x85c2 > /sys/bus/edac/devices/cxl_mem0/mem_repair1/nibble_mask
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair1/bank_group
+
+1
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair1/bank
+
+3
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair1/channel
+
+2
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair1/rank
+
+7
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair1/row
+
+0x240a
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair1/sub_channel
+
+5
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair1/column
+
+11
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair1/nibble_mask
+
+0x85c2
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair1/dpa
+
+0x700000
+
+# issue repair operation
+# repair returns error if unsupported or resources are not available for the
+# repair operation.
+
+root@localhost:~# echo 1 > /sys/bus/edac/devices/cxl_mem0/mem_repair1/repair
diff --git a/drivers/cxl/core/memfeature.c b/drivers/cxl/core/memfeature.c
index 5f40e5211526..69b34eff79d3 100644
--- a/drivers/cxl/core/memfeature.c
+++ b/drivers/cxl/core/memfeature.c
@@ -20,7 +20,7 @@
 #include <cxlmem.h>
 #include "core.h"
 
-#define CXL_DEV_NUM_RAS_FEATURES	3
+#define CXL_DEV_NUM_RAS_FEATURES	7
 #define CXL_DEV_HOUR_IN_SECS	3600
 
 #define CXL_DEV_NAME_LEN	128
@@ -942,6 +942,438 @@ static const struct edac_mem_repair_ops cxl_sppr_ops = {
 	.do_repair = cxl_do_ppr,
 };
 
+/* CXL memory sparing control definitions */
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
+	u16 effects;
+	struct cxl_memdev *cxlmd;
+	enum edac_mem_repair_function repair_function;
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
+#define CXL_MEMDEV_SPARING_RD_CAP_SAFE_IN_USE_MASK	BIT(0)
+#define CXL_MEMDEV_SPARING_RD_CAP_HARD_SPARING_MASK	BIT(1)
+#define CXL_MEMDEV_SPARING_RD_CAP_SOFT_SPARING_MASK	BIT(2)
+
+#define CXL_MEMDEV_SPARING_WR_DEVICE_INITIATED_MASK	BIT(0)
+
+#define CXL_MEMDEV_SPARING_QUERY_RESOURCE_FLAG	BIT(0)
+#define CXL_MEMDEV_SET_HARD_SPARING_FLAG	BIT(1)
+#define CXL_MEMDEV_SPARING_SUB_CHANNEL_VALID_FLAG	BIT(2)
+#define CXL_MEMDEV_SPARING_NIB_MASK_VALID_FLAG	BIT(3)
+
+/* See CXL rev 3.1 @8.2.9.7.2.3 Table 8-119 Memory Sparing Feature Readable Attributes */
+struct cxl_memdev_sparing_rd_attrs {
+	struct cxl_memdev_repair_rd_attrs_hdr hdr;
+	u8 rsvd;
+	__le16 restriction_flags;
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
+	__le16 column;
+	u8 sub_channel;
+}  __packed;
+
+static int cxl_mem_sparing_get_attrs(struct device *dev,
+				     struct cxl_mem_sparing_context *cxl_sparing_ctx,
+				     struct cxl_memdev_sparing_params *params)
+{
+	struct cxl_memdev *cxlmd = cxl_sparing_ctx->cxlmd;
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	size_t rd_data_size = sizeof(struct cxl_memdev_sparing_rd_attrs);
+	u16 restriction_flags;
+	size_t data_size;
+	struct cxl_memdev_sparing_rd_attrs *rd_attrs __free(kfree) =
+				kmalloc(rd_data_size, GFP_KERNEL);
+	if (!rd_attrs)
+		return -ENOMEM;
+
+	data_size = cxl_get_feature(&mds->cxlds, cxl_sparing_ctx->repair_uuid,
+				    CXL_GET_FEAT_SEL_CURRENT_VALUE,
+				    rd_attrs, rd_data_size);
+	if (!data_size)
+		return -EIO;
+
+	params->op_class = rd_attrs->hdr.op_class;
+	params->op_subclass = rd_attrs->hdr.op_subclass;
+	restriction_flags = le16_to_cpu(rd_attrs->restriction_flags);
+	params->cap_safe_when_in_use = FIELD_GET(CXL_MEMDEV_SPARING_RD_CAP_SAFE_IN_USE_MASK,
+						 restriction_flags) ^ 1;
+	params->cap_hard_sparing = FIELD_GET(CXL_MEMDEV_SPARING_RD_CAP_HARD_SPARING_MASK,
+					     restriction_flags);
+	params->cap_soft_sparing = FIELD_GET(CXL_MEMDEV_SPARING_RD_CAP_SOFT_SPARING_MASK,
+					     restriction_flags);
+
+	return 0;
+}
+
+static int cxl_mem_do_sparing_op(struct device *dev,
+				 struct cxl_mem_sparing_context *cxl_sparing_ctx,
+				 struct cxl_memdev_sparing_params *rd_params,
+				 enum cxl_mem_sparing_param_type param_type)
+{
+	struct cxl_memdev_sparing_in_payload sparing_pi;
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
+	put_unaligned_le24(cxl_sparing_ctx->nibble_mask, sparing_pi.nibble_mask);
+
+	if (cxl_sparing_ctx->repair_function == EDAC_CACHELINE_MEM_SPARING ||
+	    cxl_sparing_ctx->repair_function == EDAC_ROW_MEM_SPARING ||
+	    cxl_sparing_ctx->repair_function == EDAC_BANK_MEM_SPARING) {
+		sparing_pi.bank_group = cxl_sparing_ctx->bank_group;
+		sparing_pi.bank = cxl_sparing_ctx->bank;
+	}
+	if (cxl_sparing_ctx->repair_function == EDAC_CACHELINE_MEM_SPARING ||
+	    cxl_sparing_ctx->repair_function == EDAC_ROW_MEM_SPARING)
+		put_unaligned_le24(cxl_sparing_ctx->row, sparing_pi.row);
+	if (cxl_sparing_ctx->repair_function == EDAC_CACHELINE_MEM_SPARING) {
+		sparing_pi.column = cpu_to_le16(cxl_sparing_ctx->column);
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
+static int cxl_mem_sparing_set_attrs(struct device *dev,
+				     struct cxl_mem_sparing_context *ctx,
+				     enum cxl_mem_sparing_param_type param_type)
+{
+	struct cxl_memdev_sparing_params rd_params;
+	int ret;
+
+	ret = cxl_mem_sparing_get_attrs(dev, ctx, &rd_params);
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
+		ret = cxl_mem_do_sparing_op(dev, ctx, &rd_params, param_type);
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
+CXL_SPARING_GET_ATTR(repair_function, u32)
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
+	struct cxl_mem_sparing_context *ctx = drv_data;
+	struct cxl_memdev_sparing_params params;
+	int ret;
+
+	ret = cxl_mem_sparing_get_attrs(dev, ctx, &params);
+	if (ret)
+		return ret;
+
+	*safe = params.cap_safe_when_in_use;
+
+	return 0;
+}
+
+static int cxl_mem_sparing_get_min_dpa(struct device *dev, void *drv_data,
+				       u64 *min_dpa)
+{
+	struct cxl_mem_sparing_context *ctx = drv_data;
+	struct cxl_memdev *cxlmd = ctx->cxlmd;
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+
+	*min_dpa = cxlds->dpa_res.start;
+
+	return 0;
+}
+
+static int cxl_mem_sparing_get_max_dpa(struct device *dev, void *drv_data,
+				       u64 *max_dpa)
+{
+	struct cxl_mem_sparing_context *ctx = drv_data;
+	struct cxl_memdev *cxlmd = ctx->cxlmd;
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+
+	*max_dpa = cxlds->dpa_res.end;
+
+	return 0;
+}
+
+static int cxl_mem_sparing_set_dpa(struct device *dev, void *drv_data, u64 dpa)
+{
+	struct cxl_mem_sparing_context *ctx = drv_data;
+	struct cxl_memdev *cxlmd = ctx->cxlmd;
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+
+	if (!dpa || dpa < cxlds->dpa_res.start || dpa > cxlds->dpa_res.end)
+		return -EINVAL;
+
+	ctx->dpa = dpa;
+
+	return 0;
+}
+
+static int cxl_do_mem_sparing(struct device *dev, void *drv_data, u32 val)
+{
+	struct cxl_mem_sparing_context *ctx = drv_data;
+
+	if (val != EDAC_DO_MEM_REPAIR)
+		return -EINVAL;
+
+	return cxl_mem_sparing_set_attrs(dev, ctx, CXL_MEM_SPARING_PARAM_DO_REPAIR);
+}
+
+#define RANK_OPS \
+	.get_repair_function = cxl_mem_sparing_get_repair_function, \
+	.get_persist_mode = cxl_mem_sparing_get_persist_mode, \
+	.set_persist_mode = cxl_mem_sparing_set_persist_mode, \
+	.get_repair_safe_when_in_use = cxl_get_mem_sparing_safe_when_in_use, \
+	.get_dpa_support = cxl_mem_sparing_get_dpa_support, \
+	.get_min_dpa = cxl_mem_sparing_get_min_dpa, \
+	.get_max_dpa = cxl_mem_sparing_get_max_dpa, \
+	.get_dpa = cxl_mem_sparing_get_dpa, \
+	.set_dpa = cxl_mem_sparing_set_dpa, \
+	.get_nibble_mask = cxl_mem_sparing_get_nibble_mask, \
+	.set_nibble_mask = cxl_mem_sparing_set_nibble_mask, \
+	.get_rank = cxl_mem_sparing_get_rank, \
+	.set_rank = cxl_mem_sparing_set_rank, \
+	.get_channel = cxl_mem_sparing_get_channel, \
+	.set_channel = cxl_mem_sparing_set_channel, \
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
+	enum edac_mem_repair_function repair_function;
+	enum edac_mem_repair_persist_mode persist_mode;
+	enum cxl_mem_sparing_granularity granularity;
+	const struct edac_mem_repair_ops *repair_ops;
+};
+
+static const struct cxl_mem_sparing_desc mem_sparing_desc[] = {
+	{
+		.repair_uuid = CXL_FEAT_CACHELINE_SPARING_UUID,
+		.repair_function = EDAC_CACHELINE_MEM_SPARING,
+		.persist_mode = EDAC_MEM_REPAIR_SOFT,
+		.granularity = CXL_MEM_SPARING_CACHELINE,
+		.repair_ops = &cxl_cacheline_sparing_ops,
+	},
+	{
+		.repair_uuid = CXL_FEAT_ROW_SPARING_UUID,
+		.repair_function = EDAC_ROW_MEM_SPARING,
+		.persist_mode = EDAC_MEM_REPAIR_SOFT,
+		.granularity = CXL_MEM_SPARING_ROW,
+		.repair_ops = &cxl_row_sparing_ops,
+	},
+	{
+		.repair_uuid = CXL_FEAT_BANK_SPARING_UUID,
+		.repair_function = EDAC_BANK_MEM_SPARING,
+		.persist_mode = EDAC_MEM_REPAIR_SOFT,
+		.granularity = CXL_MEM_SPARING_BANK,
+		.repair_ops = &cxl_bank_sparing_ops,
+	},
+	{
+		.repair_uuid = CXL_FEAT_RANK_SPARING_UUID,
+		.repair_function = EDAC_RANK_MEM_SPARING,
+		.persist_mode = EDAC_MEM_REPAIR_SOFT,
+		.granularity = CXL_MEM_SPARING_RANK,
+		.repair_ops = &cxl_rank_sparing_ops,
+	},
+};
+
 static int cxl_memdev_scrub_init(struct cxl_memdev *cxlmd, struct cxl_region *cxlr,
 				 struct edac_dev_feature *ras_feature, u8 scrub_inst)
 {
@@ -1104,6 +1536,55 @@ static int cxl_memdev_soft_ppr_init(struct cxl_memdev *cxlmd,
 	return -EOPNOTSUPP;
 }
 
+static int cxl_memdev_sparing_init(struct cxl_memdev *cxlmd,
+				   struct edac_dev_feature *ras_feature,
+				   const struct cxl_mem_sparing_desc *desc,
+				   u8 repair_inst)
+{
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	struct cxl_mem_sparing_context *cxl_sparing_ctx;
+	struct cxl_feat_entry feat_entry;
+	int rc;
+
+	rc = cxl_get_supported_feature_entry(&mds->cxlds, &desc->repair_uuid,
+					     &feat_entry);
+	if (rc < 0)
+		goto feat_unsupported;
+
+	if (!(le32_to_cpu(feat_entry.flags) & CXL_FEAT_ENTRY_FLAG_CHANGABLE))
+		goto feat_unsupported;
+
+	cxl_sparing_ctx = devm_kzalloc(&cxlmd->dev, sizeof(*cxl_sparing_ctx),
+				       GFP_KERNEL);
+	if (!cxl_sparing_ctx)
+		return -ENOMEM;
+
+	*cxl_sparing_ctx = (struct cxl_mem_sparing_context) {
+		.repair_uuid = desc->repair_uuid,
+		.get_feat_size = le16_to_cpu(feat_entry.get_feat_size),
+		.set_feat_size = le16_to_cpu(feat_entry.set_feat_size),
+		.get_version = feat_entry.get_feat_ver,
+		.set_version = feat_entry.set_feat_ver,
+		.effects = le16_to_cpu(feat_entry.effects),
+		.cxlmd = cxlmd,
+		.repair_function = desc->repair_function,
+		.persist_mode = desc->persist_mode,
+		.granularity = desc->granularity,
+		.dpa_support = true,
+		.instance = repair_inst++,
+	};
+	ras_feature->ft_type = RAS_FEAT_MEM_REPAIR;
+	ras_feature->instance = cxl_sparing_ctx->instance;
+	ras_feature->mem_repair_ops = desc->repair_ops;
+	ras_feature->ctx = cxl_sparing_ctx;
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
@@ -1111,7 +1592,7 @@ int cxl_mem_ras_features_init(struct cxl_memdev *cxlmd, struct cxl_region *cxlr)
 	int num_ras_features = 0;
 	u8 repair_inst = 0;
 	u8 scrub_inst = 0;
-	int rc;
+	int rc, i;
 
 	rc = cxl_memdev_scrub_init(cxlmd, cxlr, &ras_features[num_ras_features],
 				   scrub_inst);
@@ -1153,6 +1634,18 @@ int cxl_mem_ras_features_init(struct cxl_memdev *cxlmd, struct cxl_region *cxlr)
 	num_ras_features++;
 
 feat_soft_ppr_done:
+	for (i = 0; i < CXL_MEM_SPARING_MAX; i++) {
+		rc = cxl_memdev_sparing_init(cxlmd, &ras_features[num_ras_features],
+					     &mem_sparing_desc[i], repair_inst);
+		if (rc == -EOPNOTSUPP)
+			continue;
+		if (rc < 0)
+			return rc;
+
+		repair_inst++;
+		num_ras_features++;
+	}
+
 feat_register:
 	return edac_dev_register(&cxlmd->dev, cxl_dev_name, NULL,
 				 num_ras_features, ras_features);
-- 
2.43.0


