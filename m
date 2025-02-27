Return-Path: <linux-edac+bounces-3231-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 470C4A48BCE
	for <lists+linux-edac@lfdr.de>; Thu, 27 Feb 2025 23:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23F8B1891048
	for <lists+linux-edac@lfdr.de>; Thu, 27 Feb 2025 22:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACB927FE74;
	Thu, 27 Feb 2025 22:39:47 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D1C23E347;
	Thu, 27 Feb 2025 22:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740695987; cv=none; b=OEPrQC9+QCouj+fabOvzVRTg7XICbfwDYIolr/IfzvO/6OGZ95kv9w2WXAZs1u/XA85/Gx5CpGxbS7TCNVL6in+60Jww7tI3l8Bwpj/EZSz79VuoGli8cAZXNYKHWw3dvDH8nRGd+scf6EbE5Q8+AkfDwJBVMUMRnmyht5mh8zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740695987; c=relaxed/simple;
	bh=iuUs0MfJqb2vU47ECQXS59OT5iTW4qEVoa1pMehu+Uc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uVbv39Dz88uwRdw5azYZG+m9XEom5XuDMVbi8gf1+o27sCEy2OPMXetxuP4+osRdejJFQjo7UCqB5V8EHrJ/UTjMIkr3FshgYAXSPgTY7SzlJPWekHLK/85KVQOW5r3kzdq2t/g1l/Sy63XTcqWG/DB2sKajQSMPm0pLqp8Mo/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z3mQJ5hmwz6L5Bw;
	Fri, 28 Feb 2025 06:35:52 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id AC7A7140CF4;
	Fri, 28 Feb 2025 06:39:41 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.149.240) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Feb 2025 23:39:39 +0100
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
Subject: [PATCH 8/8] cxl/memfeature: Add CXL memory device memory sparing control feature
Date: Thu, 27 Feb 2025 22:38:15 +0000
Message-ID: <20250227223816.2036-9-shiju.jose@huawei.com>
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

Memory sparing is defined as a repair function that replaces a portion of
memory with a portion of functional memory at that same DPA. The subclasses
for this operation vary in terms of the scope of the sparing being
performed. The cacheline sparing subclass refers to a sparing action that
can replace a full cacheline. Row sparing is provided as an alternative to
PPR sparing functions and its scope is that of a single DDR row.
As per CXL r3.2 Table 8-125 foot note 1. Memory sparing is preferred over
PPR when possible.
Bank sparing allows an entire bank to be replaced. Rank sparing is defined
as an operation in which an entire DDR rank is replaced.

Memory sparing maintenance operations may be supported by CXL devices
that implement CXL.mem protocol. A sparing maintenance operation requests
the CXL device to perform a repair operation on its media.
For example, a CXL device with DRAM components that support memory sparing
features may implement sparing maintenance operations.

The host may issue a query command by setting query resources flag in the
input payload (CXL spec 3.2 Table 8-120) to determine availability of
sparing resources for a given address. In response to a query request,
the device shall report the resource availability by producing the memory
sparing event record (CXL spec 3.2 Table 8-60) in which the Channel, Rank,
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
operation by using DRAM event record, where the 'maintenance needed' flag
may set. The event record contains some of the DPA, Channel, Rank,
Nibble Mask, Bank Group, Bank, Row, Column, Sub-Channel fields that
should be repaired. The userspace tool requests for maintenance operation
if the 'maintenance needed' flag set in the CXL DRAM error record.

CXL spec 3.2 section 8.2.10.7.1.4 describes the device's memory sparing
maintenance operation feature.

CXL spec 3.2 section 8.2.10.7.2.3 describes the memory sparing feature
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
   userspace in a CXL DRAM trace event with DPA and other attributes of
   memory to repair such as channel, rank, nibble mask, bank Group,
   bank, row, column, sub-channel.

2. Rasdaemon process the trace event and may issue query request in sysfs
check resources available for memory sparing if either of the following
conditions met.
 - 'maintenance needed' flag set in the event record.
 - 'threshold event' flag set for CVME threshold feature.
 - If the previous case is not enough, may be when the number of corrected
   error reported on a CXL.mem media to the user space exceeds an error
   threshold set in the userspace policy.

3. Rasdaemon process the memory sparing trace event and issue repair
   request for memory sparing.

Kernel CXL driver shall report memory sparing event record to the userspace
with the resource availability in order rasdaemon to process the event
record and issue a repair request in sysfs for the memory sparing operation
in the CXL device.

Note: Based on the feedbacks from the community 'query' sysfs attribute is
removed and reporting memory sparing error record to the userspace are not
supported. Instead userspace issues sparing operation and kernel does the
same to the CXL memory device, when 'maintenance needed' flag set in the
DRAM event record.

Add checks to ensure the memory to be repaired is offline and if online,
then originates from a CXL DRAM error record reported in the current boot
before requesting a memory sparing operation on the device.

Tested for memory sparing control feature with
   "hw/cxl: Add memory sparing control feature"
   Repository: "https://gitlab.com/shiju.jose/qemu.git"
   Branch: cxl-ras-features-2024-10-24

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 Documentation/edac/memory_repair.rst |  57 +++
 drivers/cxl/core/memfeatures.c       | 557 ++++++++++++++++++++++++++-
 drivers/edac/mem_repair.c            |   4 +
 include/linux/edac.h                 |   4 +
 4 files changed, 620 insertions(+), 2 deletions(-)

diff --git a/Documentation/edac/memory_repair.rst b/Documentation/edac/memory_repair.rst
index b698921628b5..22aec58bb459 100644
--- a/Documentation/edac/memory_repair.rst
+++ b/Documentation/edac/memory_repair.rst
@@ -165,3 +165,60 @@ Note: Repair command returns error if unsupported/resources are not
 available for the repair operation.
 
 # echo 1 > /sys/bus/edac/devices/cxl_mem0/mem_repair0/repair
+
+2. CXL memory sparing
+
+2.1. Read device supported capabilities for the cacheline sparing.
+
+# cat /sys/bus/edac/devices/cxl_mem0/mem_repair1/repair_type
+
+cacheline-sparing
+
+# cat /sys/bus/edac/devices/cxl_mem0/mem_repair1/persist_mode
+
+0
+
+# cat /sys/bus/edac/devices/cxl_mem0/mem_repair1/repair_safe_when_in_use
+
+1
+
+# cat /sys/bus/edac/devices/cxl_mem0/mem_repair1/min_dpa
+
+0x0
+
+# cat /sys/bus/edac/devices/cxl_mem0/mem_repair1/max_dpa
+
+0xfffffff
+
+Sparing that is safe to use with ongoing accesses to the memory
+
+and applies to 4GiB of DPA space.
+
+2.2. Set attributes for cacheline sparing operation for a DPA=0x700000,
+     where device reported the attributes in CXL DRAM error event record.
+
+# echo 0x700000 > /sys/bus/edac/devices/cxl_mem0/mem_repair1/dpa
+
+# echo 2 > /sys/bus/edac/devices/cxl_mem0/mem_repair1/bank_group
+
+# echo 4 > /sys/bus/edac/devices/cxl_mem0/mem_repair1/bank
+
+# echo 7 > /sys/bus/edac/devices/cxl_mem0/mem_repair1/channel
+
+# echo 5 > /sys/bus/edac/devices/cxl_mem0/mem_repair1/sub_channel
+
+# echo 9 > /sys/bus/edac/devices/cxl_mem0/mem_repair1/rank
+
+# echo 0x240a > /sys/bus/edac/devices/cxl_mem0/mem_repair1/row
+
+# echo 11 > /sys/bus/edac/devices/cxl_mem0/mem_repair1/column
+
+# echo 0x0FF > /sys/bus/edac/devices/cxl_mem0/mem_repair1/nibble_mask
+
+2.3. Start cacheline sparing operation
+
+Note: Repair command returns error if unsupported, resources are not
+available for the sparing operation or if memory to repair is online
+and attributes are reported from the previous boot etc.
+
+# echo 1 > /sys/bus/edac/devices/cxl_mem0/mem_repair1/repair
diff --git a/drivers/cxl/core/memfeatures.c b/drivers/cxl/core/memfeatures.c
index 8d5a57a0c154..14d3960504a2 100644
--- a/drivers/cxl/core/memfeatures.c
+++ b/drivers/cxl/core/memfeatures.c
@@ -19,8 +19,9 @@
 #include <cxl.h>
 #include <cxlmem.h>
 #include "core.h"
+#include "trace.h"
 
-#define CXL_DEV_NUM_RAS_FEATURES	3
+#define CXL_DEV_NUM_RAS_FEATURES	7
 #define CXL_DEV_HOUR_IN_SECS	3600
 
 #define CXL_DEV_NAME_LEN	128
@@ -1109,6 +1110,546 @@ static int cxl_memdev_soft_ppr_init(struct cxl_memdev *cxlmd,
 	return 0;
 }
 
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
+	struct cxl_memdev *cxlmd;
+	uuid_t repair_uuid;
+	u16 get_feat_size;
+	u16 set_feat_size;
+	u16 effects;
+	u8 instance;
+	u8 get_version;
+	u8 set_version;
+	u8 channel;
+	u8 rank;
+	u8 bank_group;
+	u32 nibble_mask;
+	u64 dpa;
+	u32 row;
+	u16 column;
+	u8 bank;
+	u8 sub_channel;
+	enum edac_mem_repair_type repair_type;
+	bool persist_mode;
+	enum cxl_mem_sparing_granularity granularity;
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
+/*
+ * See CXL spec rev 3.2 @8.2.10.7.2.3 Table 8-134 Memory Sparing Feature
+ * Readable Attributes.
+ */
+struct cxl_memdev_sparing_rd_attrs {
+	struct cxl_memdev_repair_rd_attrs_hdr hdr;
+	u8 rsvd;
+	__le16 restriction_flags;
+}  __packed;
+
+/*
+ * See CXL spec rev 3.2 @8.2.10.7.1.4 Table 8-120 Memory Sparing Input Payload.
+ */
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
+static int cxl_mem_sparing_get_attrs(struct cxl_mem_sparing_context *cxl_sparing_ctx,
+				     struct cxl_memdev_sparing_params *params)
+{
+	size_t rd_data_size = sizeof(struct cxl_memdev_sparing_rd_attrs);
+	struct cxl_memdev *cxlmd = cxl_sparing_ctx->cxlmd;
+	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
+	u16 restriction_flags;
+	size_t data_size;
+	u16 return_code;
+	struct cxl_memdev_sparing_rd_attrs *rd_attrs __free(kfree) =
+				kzalloc(rd_data_size, GFP_KERNEL);
+	if (!rd_attrs)
+		return -ENOMEM;
+
+	data_size = cxl_get_feature(cxl_mbox, &cxl_sparing_ctx->repair_uuid,
+				    CXL_GET_FEAT_SEL_CURRENT_VALUE,
+				    rd_attrs, rd_data_size, 0, &return_code);
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
+static struct cxl_event_dram *
+cxl_mem_get_rec_dram(struct cxl_memdev *cxlmd, struct cxl_mem_sparing_context *ctx)
+{
+	struct cxl_mem_repair_attrbs attrbs = { 0 };
+
+	attrbs.dpa = ctx->dpa;
+	attrbs.channel = ctx->channel;
+	attrbs.rank = ctx->rank;
+	attrbs.nibble_mask = ctx->nibble_mask;
+	switch (ctx->repair_type) {
+	case EDAC_CACHELINE_SPARING:
+		attrbs.repair_type = CXL_CACHELINE_SPARING;
+		attrbs.bank_group = ctx->bank_group;
+		attrbs.bank = ctx->bank;
+		attrbs.row = ctx->row;
+		attrbs.column = ctx->column;
+		attrbs.sub_channel = ctx->sub_channel;
+		break;
+	case EDAC_ROW_SPARING:
+		attrbs.repair_type = CXL_ROW_SPARING;
+		attrbs.bank_group = ctx->bank_group;
+		attrbs.bank = ctx->bank;
+		attrbs.row = ctx->row;
+		break;
+	case EDAC_BANK_SPARING:
+		attrbs.repair_type = CXL_BANK_SPARING;
+		attrbs.bank_group = ctx->bank_group;
+		attrbs.bank = ctx->bank;
+		break;
+	case EDAC_RANK_SPARING:
+		attrbs.repair_type = CXL_BANK_SPARING;
+		break;
+	default:
+		return NULL;
+	}
+
+	/*
+	 * Check memory to repair is from the current boot
+	 */
+	return cxl_find_rec_dram(cxlmd, &attrbs);
+}
+
+static int cxl_mem_do_sparing_op(struct device *dev,
+				 struct cxl_mem_sparing_context *cxl_sparing_ctx,
+				 struct cxl_memdev_sparing_params *rd_params)
+{
+	struct cxl_memdev *cxlmd = cxl_sparing_ctx->cxlmd;
+	struct cxl_memdev_sparing_in_payload sparing_pi;
+	struct cxl_event_dram *rec = NULL;
+	u16 validity_flags = 0;
+
+	if (!rd_params->cap_safe_when_in_use) {
+		/*
+		 * Memory to repair must be offline
+		 */
+		if (cxl_are_decoders_committed(cxlmd))
+			return -EBUSY;
+		/*
+		 * offline, so good for repair
+		 */
+	} else {
+		/*
+		 * If offline all good, otherwise check for match with record
+		 */
+		if (cxl_are_decoders_committed(cxlmd)) {
+			rec = cxl_mem_get_rec_dram(cxlmd, cxl_sparing_ctx);
+			if (!rec)
+				return -EINVAL;
+			/*
+			 * Record matched, so even though online good for repair
+			 */
+			validity_flags = get_unaligned_le16(rec->media_hdr.validity_flags);
+			if (!validity_flags)
+				return -EINVAL;
+		}
+	}
+
+	memset(&sparing_pi, 0, sizeof(sparing_pi));
+	sparing_pi.flags = FIELD_PREP(CXL_MEMDEV_SPARING_QUERY_RESOURCE_FLAG, 0);
+	if (cxl_sparing_ctx->persist_mode)
+		sparing_pi.flags |=
+			FIELD_PREP(CXL_MEMDEV_SET_HARD_SPARING_FLAG, 1);
+
+	switch (cxl_sparing_ctx->repair_type) {
+	case EDAC_CACHELINE_SPARING:
+		sparing_pi.column = cpu_to_le16(cxl_sparing_ctx->column);
+		/*
+		 * Sub-channel is an optional attribute.
+		 */
+		if (!rec || (validity_flags & CXL_DER_VALID_SUB_CHANNEL)) {
+			sparing_pi.flags |=
+				FIELD_PREP(CXL_MEMDEV_SPARING_SUB_CHANNEL_VALID_FLAG, 1);
+			sparing_pi.sub_channel = cxl_sparing_ctx->sub_channel;
+		}
+		fallthrough;
+	case EDAC_ROW_SPARING:
+		put_unaligned_le24(cxl_sparing_ctx->row, sparing_pi.row);
+		fallthrough;
+	case EDAC_BANK_SPARING:
+		sparing_pi.bank_group = cxl_sparing_ctx->bank_group;
+		sparing_pi.bank = cxl_sparing_ctx->bank;
+		fallthrough;
+	case EDAC_RANK_SPARING:
+		sparing_pi.rank = cxl_sparing_ctx->rank;
+		fallthrough;
+	default:
+		sparing_pi.channel = cxl_sparing_ctx->channel;
+		if ((rec && (validity_flags & CXL_DER_VALID_NIBBLE)) ||
+		    (!rec && (!cxl_sparing_ctx->nibble_mask ||
+			     (cxl_sparing_ctx->nibble_mask & 0xFFFFFF)))) {
+			sparing_pi.flags |=
+				FIELD_PREP(CXL_MEMDEV_SPARING_NIB_MASK_VALID_FLAG, 1);
+			put_unaligned_le24(cxl_sparing_ctx->nibble_mask,
+					   sparing_pi.nibble_mask);
+		}
+		break;
+	}
+
+	return cxl_do_maintenance(&cxlmd->cxlds->cxl_mbox, rd_params->op_class,
+				  rd_params->op_subclass, &sparing_pi, sizeof(sparing_pi));
+}
+
+static int cxl_mem_sparing_set_attrs(struct device *dev,
+				     struct cxl_mem_sparing_context *ctx)
+{
+	struct cxl_memdev_sparing_params rd_params;
+	int ret;
+
+	ret = cxl_mem_sparing_get_attrs(ctx, &rd_params);
+	if (ret)
+		return ret;
+
+	ret = cxl_hold_region_and_dpa();
+	if (ret)
+		return ret;
+	ret = cxl_mem_do_sparing_op(dev, ctx, &rd_params);
+	cxl_release_region_and_dpa();
+
+	return ret;
+}
+
+static int cxl_mem_sparing_get_repair_type(struct device *dev, void *drv_data,
+					   const char **repair_type)
+{
+	struct cxl_mem_sparing_context *ctx = drv_data;
+
+	switch (ctx->repair_type) {
+	case EDAC_CACHELINE_SPARING:
+	case EDAC_ROW_SPARING:
+	case EDAC_BANK_SPARING:
+	case EDAC_RANK_SPARING:
+		*repair_type = edac_repair_type[ctx->repair_type];
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
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
+CXL_SPARING_GET_ATTR(persist_mode, bool)
+CXL_SPARING_GET_ATTR(dpa, u64)
+CXL_SPARING_GET_ATTR(nibble_mask, u32)
+CXL_SPARING_GET_ATTR(bank_group, u32)
+CXL_SPARING_GET_ATTR(bank, u32)
+CXL_SPARING_GET_ATTR(rank, u32)
+CXL_SPARING_GET_ATTR(row, u32)
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
+CXL_SPARING_SET_ATTR(nibble_mask, u32)
+CXL_SPARING_SET_ATTR(bank_group, u32)
+CXL_SPARING_SET_ATTR(bank, u32)
+CXL_SPARING_SET_ATTR(rank, u32)
+CXL_SPARING_SET_ATTR(row, u32)
+CXL_SPARING_SET_ATTR(column, u32)
+CXL_SPARING_SET_ATTR(channel, u32)
+CXL_SPARING_SET_ATTR(sub_channel, u32)
+
+static int cxl_mem_sparing_set_persist_mode(struct device *dev, void *drv_data,
+					    bool persist_mode)
+{
+	struct cxl_mem_sparing_context *ctx = drv_data;
+	struct cxl_memdev_sparing_params params;
+	int ret;
+
+	ret = cxl_mem_sparing_get_attrs(ctx, &params);
+	if (ret)
+		return ret;
+
+	if ((persist_mode && params.cap_hard_sparing) ||
+	    (!persist_mode && params.cap_soft_sparing))
+		ctx->persist_mode = persist_mode;
+	else
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static int cxl_get_mem_sparing_safe_when_in_use(struct device *dev, void *drv_data,
+						bool *safe)
+{
+	struct cxl_mem_sparing_context *ctx = drv_data;
+	struct cxl_memdev_sparing_params params;
+	int ret;
+
+	ret = cxl_mem_sparing_get_attrs(ctx, &params);
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
+	if (dpa < cxlds->dpa_res.start || dpa > cxlds->dpa_res.end)
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
+	return cxl_mem_sparing_set_attrs(dev, ctx);
+}
+
+#define RANK_OPS \
+	.get_repair_type = cxl_mem_sparing_get_repair_type, \
+	.get_persist_mode = cxl_mem_sparing_get_persist_mode, \
+	.set_persist_mode = cxl_mem_sparing_set_persist_mode, \
+	.get_repair_safe_when_in_use = cxl_get_mem_sparing_safe_when_in_use, \
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
+	enum edac_mem_repair_type repair_type;
+	enum cxl_mem_sparing_granularity granularity;
+	const struct edac_mem_repair_ops *repair_ops;
+};
+
+static const struct cxl_mem_sparing_desc mem_sparing_desc[] = {
+	{
+		.repair_uuid = CXL_FEAT_CACHELINE_SPARING_UUID,
+		.repair_type = EDAC_CACHELINE_SPARING,
+		.granularity = CXL_MEM_SPARING_CACHELINE,
+		.repair_ops = &cxl_cacheline_sparing_ops,
+	},
+	{
+		.repair_uuid = CXL_FEAT_ROW_SPARING_UUID,
+		.repair_type = EDAC_ROW_SPARING,
+		.granularity = CXL_MEM_SPARING_ROW,
+		.repair_ops = &cxl_row_sparing_ops,
+	},
+	{
+		.repair_uuid = CXL_FEAT_BANK_SPARING_UUID,
+		.repair_type = EDAC_BANK_SPARING,
+		.granularity = CXL_MEM_SPARING_BANK,
+		.repair_ops = &cxl_bank_sparing_ops,
+	},
+	{
+		.repair_uuid = CXL_FEAT_RANK_SPARING_UUID,
+		.repair_type = EDAC_RANK_SPARING,
+		.granularity = CXL_MEM_SPARING_RANK,
+		.repair_ops = &cxl_rank_sparing_ops,
+	},
+};
+
+static int cxl_memdev_sparing_init(struct cxl_memdev *cxlmd,
+				   struct edac_dev_feature *ras_feature,
+				   const struct cxl_mem_sparing_desc *desc,
+				   u8 repair_inst)
+{
+	struct cxl_mem_sparing_context *cxl_sparing_ctx;
+	struct cxl_memdev_sparing_params rd_params;
+	struct cxl_feat_entry *feat_entry;
+	int ret;
+
+	feat_entry = cxl_get_feature_entry(cxlmd->cxlds, &desc->repair_uuid);
+	if (IS_ERR(feat_entry))
+		return -EOPNOTSUPP;
+
+	if (!(le32_to_cpu(feat_entry->flags) & CXL_FEATURE_F_CHANGEABLE))
+		return -EOPNOTSUPP;
+
+	cxl_sparing_ctx = devm_kzalloc(&cxlmd->dev, sizeof(*cxl_sparing_ctx),
+				       GFP_KERNEL);
+	if (!cxl_sparing_ctx)
+		return -ENOMEM;
+
+	*cxl_sparing_ctx = (struct cxl_mem_sparing_context) {
+		.get_feat_size = le16_to_cpu(feat_entry->get_feat_size),
+		.set_feat_size = le16_to_cpu(feat_entry->set_feat_size),
+		.get_version = feat_entry->get_feat_ver,
+		.set_version = feat_entry->set_feat_ver,
+		.effects = le16_to_cpu(feat_entry->effects),
+		.cxlmd = cxlmd,
+		.repair_type = desc->repair_type,
+		.granularity = desc->granularity,
+		.instance = repair_inst++,
+	};
+	uuid_copy(&cxl_sparing_ctx->repair_uuid, &desc->repair_uuid);
+
+	/*
+	 * Read CXL device's sparing capabilities.
+	 */
+	ret = cxl_mem_sparing_get_attrs(cxl_sparing_ctx, &rd_params);
+	if (ret)
+		return ret;
+
+	/*
+	 * Set default value for persist_mode.
+	 */
+	if ((rd_params.cap_soft_sparing && rd_params.cap_hard_sparing) ||
+	    rd_params.cap_soft_sparing)
+		cxl_sparing_ctx->persist_mode = 0;
+	else if (rd_params.cap_hard_sparing)
+		cxl_sparing_ctx->persist_mode = 1;
+	else
+		return -EOPNOTSUPP;
+
+	ras_feature->ft_type = RAS_FEAT_MEM_REPAIR;
+	ras_feature->instance = cxl_sparing_ctx->instance;
+	ras_feature->mem_repair_ops = desc->repair_ops;
+	ras_feature->ctx = cxl_sparing_ctx;
+
+	return 0;
+}
+
 int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd)
 {
 	struct edac_dev_feature ras_features[CXL_DEV_NUM_RAS_FEATURES];
@@ -1116,7 +1657,7 @@ int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd)
 	int num_ras_features = 0;
 	u8 scrub_inst = 0;
 	u8 repair_inst = 0;
-	int rc;
+	int rc, i;
 
 	rc = cxl_memdev_scrub_init(cxlmd, &ras_features[num_ras_features],
 				   scrub_inst);
@@ -1143,6 +1684,18 @@ int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd)
 		num_ras_features++;
 	}
 
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
 	snprintf(cxl_dev_name, sizeof(cxl_dev_name), "%s_%s",
 		 "cxl", dev_name(&cxlmd->dev));
 
diff --git a/drivers/edac/mem_repair.c b/drivers/edac/mem_repair.c
index bf7e01a8b4dd..c4a2e99c9355 100755
--- a/drivers/edac/mem_repair.c
+++ b/drivers/edac/mem_repair.c
@@ -47,6 +47,10 @@ struct edac_mem_repair_context {
 
 const char * const edac_repair_type[] = {
 	[EDAC_PPR] = "ppr",
+	[EDAC_CACHELINE_SPARING] = "cacheline-sparing",
+	[EDAC_ROW_SPARING] = "row-sparing",
+	[EDAC_BANK_SPARING] = "bank-sparing",
+	[EDAC_RANK_SPARING] = "rank-sparing",
 };
 EXPORT_SYMBOL_GPL(edac_repair_type);
 
diff --git a/include/linux/edac.h b/include/linux/edac.h
index 5669d8d2509a..57c9856a6bd9 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -746,6 +746,10 @@ static inline int edac_ecs_get_desc(struct device *ecs_dev,
 
 enum edac_mem_repair_type {
 	EDAC_PPR,
+	EDAC_CACHELINE_SPARING,
+	EDAC_ROW_SPARING,
+	EDAC_BANK_SPARING,
+	EDAC_RANK_SPARING,
 	EDAC_REPAIR_MAX
 };
 
-- 
2.43.0


