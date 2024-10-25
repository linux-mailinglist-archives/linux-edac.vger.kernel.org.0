Return-Path: <linux-edac+bounces-2301-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B869B0AEE
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2024 19:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 868991F25DC3
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2024 17:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FEC21895A;
	Fri, 25 Oct 2024 17:15:03 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1399217474;
	Fri, 25 Oct 2024 17:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729876503; cv=none; b=SVUEWZ1FT0GY/4qT7ix6J3HbHfDzOV/ubc9RpvfatHQnQzIwr4x8v6pMVWawfnUxELa3pbCmKzgoczpZz6MXQ/eyb9LGglT1dvH1O1kUaMxjk0RTCl9g0Sp1t8dS6XnJrirlyiH01iL20ah2UY0GZ3gYGU0cjxr7SPCm6kYidZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729876503; c=relaxed/simple;
	bh=hz4/C4fPvMbvF8gsYqrD2aKfScoxJf5Y62qDhcVRb6A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KwRDCNfttmkGVnpX4oepHZdfqOM5SXqQ8bhKhpG6e0+MHh0nvrErDSMJmGa8CPGjgbFbLVBbKgAxVtjS3xUCfx1/EfLznX2fsvBdzx9r4AjazP9TnqKorz+nWg3BPa/2YLCWuUu/8nSntxEF9WED3wLwrf+UoeZaBzikdzXFQmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XZq6F311Kz6LCgg;
	Sat, 26 Oct 2024 01:10:13 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id D85DE1402C7;
	Sat, 26 Oct 2024 01:14:56 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.151.104) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 19:14:54 +0200
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
Subject: [PATCH v14 11/14] EDAC: Add memory repair control feature
Date: Fri, 25 Oct 2024 18:13:52 +0100
Message-ID: <20241025171356.1377-12-shiju.jose@huawei.com>
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

Add generic EDAC memory repair control, eg. PPR(Post Package Repair),
memory sparing etc, control driver in order to control memory repairs
in the system. Supports sPPR(soft PPR), hPPR(hard PPR), soft/hard memory
sparing, memory sparing at cacheline/row/bank/rank granularity etc.
Device with memory repair features registers with EDAC device driver,
which retrieves memory repair descriptor from EDAC memory repair driver and
exposes the sysfs repair control attributes to userspace in
/sys/bus/edac/devices/<dev-name>/mem_repairX/.

The common memory repair control interface abstracts the control of an
arbitrary memory repair functionality to a common set of functions.
The sysfs memory repair attribute nodes are only present if the client
driver has implemented the corresponding attribute callback function and
passed in ops to the EDAC device driver during registration.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 .../ABI/testing/sysfs-edac-mem-repair         | 152 ++++++++
 drivers/edac/Makefile                         |   2 +-
 drivers/edac/edac_device.c                    |  31 ++
 drivers/edac/mem_repair.c                     | 358 ++++++++++++++++++
 include/linux/edac.h                          |  87 +++++
 5 files changed, 629 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-edac-mem-repair
 create mode 100755 drivers/edac/mem_repair.c

diff --git a/Documentation/ABI/testing/sysfs-edac-mem-repair b/Documentation/ABI/testing/sysfs-edac-mem-repair
new file mode 100644
index 000000000000..b2882f5f5a84
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-edac-mem-repair
@@ -0,0 +1,152 @@
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		The sysfs EDAC bus devices /<dev-name>/mem_repairX subdirectory
+		belongs to the memory media repair features control, such as
+		PPR (Post Package Repair), memory sparing etc, where<dev-name>
+		directory corresponds to a device registered with the EDAC
+		device driver for the memory repair features.
+		Memory sparing is a repair function that replaces a portion
+		of memory (spared memory) with a portion of functional memory.
+		Memory sparing has cacheline/row/bank/rank sparing
+		granularities. The sysfs memory repair attr nodes are only
+		present if a memory repair feature is supported.
+
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/repair_type
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RO) Type of the repair instance. For eg. sPPR, hPPR, cacheline/
+		row/bank/rank memory sparing etc.
+
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/persist_mode_avail
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RO) Persist repair modes supported in the device.
+		0 - Soft PPR(sPPR)/soft memory sparing (temporary repair).
+		1 - Hard PPR(hPPR)/hard memory sparing (permanent repair).
+
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/persist_mode
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RW) Current persist repair mode.
+		0 - Soft PPR(sPPR)/soft memory sparing (temporary repair).
+		1 - Hard PPR(hPPR)/hard memory sparing (permanent repair).
+
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/dpa_support
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RO) True if supports DPA for repair(PPR, memory sparing, ...)
+		maintenance operation.
+
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/repair_safe_when_in_use
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RO) True if memory media is accessible and data is retained
+		during the memory repair operation.
+
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/hpa
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RW) HPA (Host Physical Address) for memory repair.
+
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/dpa
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RW) DPA (Device Physical Address) for memory repair.
+
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/nibble_mask
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RW) Nibble mask for memory repair.
+
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/bank_group
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RW) Memory bank group for repair.
+
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/bank
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RW) Memory bank for memory repair.
+
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/rank
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RW) Memory rank for repair.
+
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/row
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RW) Row for memory repair.
+
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/column
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RW) Column for memory repair.
+
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/channel
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RW) Channel for memory repair.
+
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/sub_channel
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RW) Sub-channel for memory repair.
+
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/query
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(WO) Query whether the repair operation is supported for the
+		memory attributes set. Return failure if resources are
+		not available to perform repair.
+
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/repair
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(WO) Start the memory repair operation for the memory attributes
+		set. Return failure if resources are not available to
+		perform repair.
+		In some states of system configuration (e.g. before address
+		decoders have been configured), memory devices (e.g. CXL)
+		may not have an active mapping in the main host address
+		physical address map. As such, the memory to repair must be
+		identified by a device specific physical addressing scheme
+		using a DPA. The DPA to use will be presented in related
+		error records.
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index b24c2c112d9c..d037bce88487 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -10,7 +10,7 @@ obj-$(CONFIG_EDAC)			:= edac_core.o
 
 edac_core-y	:= edac_mc.o edac_device.o edac_mc_sysfs.o
 edac_core-y	+= edac_module.o edac_device_sysfs.o wq.o
-edac_core-y	+= scrub.o ecs.o
+edac_core-y	+= scrub.o ecs.o mem_repair.o
 
 edac_core-$(CONFIG_EDAC_DEBUG)		+= debugfs.o
 
diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
index 5fc3ec7f25eb..f4c6f3a4a747 100644
--- a/drivers/edac/edac_device.c
+++ b/drivers/edac/edac_device.c
@@ -576,6 +576,7 @@ static void edac_dev_release(struct device *dev)
 {
 	struct edac_dev_feat_ctx *ctx = container_of(dev, struct edac_dev_feat_ctx, dev);
 
+	kfree(ctx->mem_repair);
 	kfree(ctx->scrub);
 	kfree(ctx->dev.groups);
 	kfree(ctx);
@@ -610,6 +611,7 @@ int edac_dev_register(struct device *parent, char *name,
 		      const struct edac_dev_feature *ras_features)
 {
 	const struct attribute_group **ras_attr_groups;
+	int mem_repair_cnt = 0, mem_repair_inst = 0;
 	int scrub_cnt = 0, scrub_inst = 0;
 	struct edac_dev_data *dev_data;
 	struct edac_dev_feat_ctx *ctx;
@@ -626,6 +628,10 @@ int edac_dev_register(struct device *parent, char *name,
 			attr_gcnt++;
 			scrub_cnt++;
 			break;
+		case RAS_FEAT_MEM_REPAIR:
+			attr_gcnt++;
+			mem_repair_cnt++;
+			break;
 		case RAS_FEAT_ECS:
 			attr_gcnt += ras_features[feat].ecs_info.num_media_frus;
 			break;
@@ -652,6 +658,14 @@ int edac_dev_register(struct device *parent, char *name,
 		}
 	}
 
+	if (mem_repair_cnt) {
+		ctx->mem_repair = kcalloc(mem_repair_cnt, sizeof(*ctx->mem_repair), GFP_KERNEL);
+		if (!ctx->mem_repair) {
+			ret = -ENOMEM;
+			goto groups_free;
+		}
+	}
+
 	attr_gcnt = 0;
 	for (feat = 0; feat < num_features; feat++, ras_features++) {
 		switch (ras_features->ft_type) {
@@ -682,6 +696,21 @@ int edac_dev_register(struct device *parent, char *name,
 				goto data_mem_free;
 			attr_gcnt += ras_features->ecs_info.num_media_frus;
 			break;
+		case RAS_FEAT_MEM_REPAIR:
+			if (!ras_features->mem_repair_ops ||
+			    mem_repair_inst != ras_features->instance)
+				goto data_mem_free;
+			dev_data = &ctx->mem_repair[mem_repair_inst];
+			dev_data->instance = mem_repair_inst;
+			dev_data->mem_repair_ops = ras_features->mem_repair_ops;
+			dev_data->private = ras_features->ctx;
+			ret = edac_mem_repair_get_desc(parent, &ras_attr_groups[attr_gcnt],
+						       ras_features->instance);
+			if (ret)
+				goto data_mem_free;
+			mem_repair_inst++;
+			attr_gcnt++;
+			break;
 		default:
 			ret = -EINVAL;
 			goto data_mem_free;
@@ -708,6 +738,7 @@ int edac_dev_register(struct device *parent, char *name,
 	return devm_add_action_or_reset(parent, edac_dev_unreg, &ctx->dev);
 
 data_mem_free:
+	kfree(ctx->mem_repair);
 	kfree(ctx->scrub);
 groups_free:
 	kfree(ras_attr_groups);
diff --git a/drivers/edac/mem_repair.c b/drivers/edac/mem_repair.c
new file mode 100755
index 000000000000..87e328a35306
--- /dev/null
+++ b/drivers/edac/mem_repair.c
@@ -0,0 +1,358 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Generic EDAC memory repair driver in order to control the memory
+ * device with memory repair features, such as Post Package Repair (PPR),
+ * memory sparing features etc in the system.
+ * The common sysfs memory repair interface abstracts the control of an
+ * arbitrary memory repair functionality to a common set of functions.
+ *
+ * Copyright (c) 2024 HiSilicon Limited.
+ */
+
+#define pr_fmt(fmt)     "EDAC MEM REPAIR: " fmt
+
+#include <linux/edac.h>
+
+enum edac_mem_repair_attributes {
+	MEM_REPAIR_TYPE,
+	MEM_REPAIR_PERSIST_MODE_AVAIL,
+	MEM_REPAIR_PERSIST_MODE,
+	MEM_REPAIR_DPA_SUPPORT,
+	MEM_REPAIR_SAFE_IN_USE,
+	MEM_REPAIR_HPA,
+	MEM_REPAIR_DPA,
+	MEM_REPAIR_NIBBLE_MASK,
+	MEM_REPAIR_BANK_GROUP,
+	MEM_REPAIR_BANK,
+	MEM_REPAIR_RANK,
+	MEM_REPAIR_ROW,
+	MEM_REPAIR_COLUMN,
+	MEM_REPAIR_CHANNEL,
+	MEM_REPAIR_SUB_CHANNEL,
+	MEM_REPAIR_QUERY,
+	MEM_DO_REPAIR,
+	MEM_REPAIR_MAX_ATTRS
+};
+
+struct edac_mem_repair_dev_attr {
+	struct device_attribute dev_attr;
+	u8 instance;
+};
+
+struct edac_mem_repair_context {
+	char name[EDAC_FEAT_NAME_LEN];
+	struct edac_mem_repair_dev_attr mem_repair_dev_attr[MEM_REPAIR_MAX_ATTRS];
+	struct attribute *mem_repair_attrs[MEM_REPAIR_MAX_ATTRS + 1];
+	struct attribute_group group;
+};
+
+#define TO_MEM_REPAIR_DEV_ATTR(_dev_attr)      \
+		container_of(_dev_attr, struct edac_mem_repair_dev_attr, dev_attr)
+
+#define EDAC_MEM_REPAIR_ATTR_SHOW(attrib, cb, type, format)			\
+static ssize_t attrib##_show(struct device *ras_feat_dev,			\
+			     struct device_attribute *attr, char *buf)		\
+{										\
+	u8 inst = TO_MEM_REPAIR_DEV_ATTR(attr)->instance;			\
+	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);		\
+	const struct edac_mem_repair_ops *ops =					\
+				ctx->mem_repair[inst].mem_repair_ops;		\
+	type data;								\
+	int ret;								\
+										\
+	ret = ops->cb(ras_feat_dev->parent, ctx->mem_repair[inst].private,	\
+		      &data);							\
+	if (ret)								\
+		return ret;							\
+										\
+	return sysfs_emit(buf, format, data);					\
+}
+
+EDAC_MEM_REPAIR_ATTR_SHOW(repair_type, get_repair_type, u32, "%u\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(persist_mode, get_persist_mode, u32, "%u\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(dpa_support, get_dpa_support, u32, "%u\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(repair_safe_when_in_use, get_repair_safe_when_in_use, u32, "%u\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(hpa, get_hpa, u64, "0x%llx\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(dpa, get_dpa, u64, "0x%llx\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(nibble_mask, get_nibble_mask, u64, "0x%llx\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(bank_group, get_bank_group, u32, "%u\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(bank, get_bank, u32, "%u\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(rank, get_rank, u32, "%u\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(row, get_row, u64, "0x%llx\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(column, get_column, u32, "%u\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(channel, get_channel, u32, "%u\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(sub_channel, get_sub_channel, u32, "%u\n")
+
+#define EDAC_MEM_REPAIR_ATTR_STORE(attrib, cb, type, conv_func)			\
+static ssize_t attrib##_store(struct device *ras_feat_dev,			\
+			      struct device_attribute *attr,			\
+			      const char *buf, size_t len)			\
+{										\
+	u8 inst = TO_MEM_REPAIR_DEV_ATTR(attr)->instance;			\
+	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);		\
+	const struct edac_mem_repair_ops *ops =					\
+				ctx->mem_repair[inst].mem_repair_ops;		\
+	type data;								\
+	int ret;								\
+										\
+	ret = conv_func(buf, 0, &data);						\
+	if (ret < 0)								\
+		return ret;							\
+										\
+	ret = ops->cb(ras_feat_dev->parent, ctx->mem_repair[inst].private,	\
+		      data);							\
+	if (ret)								\
+		return ret;							\
+										\
+	return len;								\
+}
+
+EDAC_MEM_REPAIR_ATTR_STORE(persist_mode, set_persist_mode, unsigned long, kstrtoul)
+EDAC_MEM_REPAIR_ATTR_STORE(hpa, set_hpa, u64, kstrtou64)
+EDAC_MEM_REPAIR_ATTR_STORE(dpa, set_dpa, u64, kstrtou64)
+EDAC_MEM_REPAIR_ATTR_STORE(nibble_mask, set_nibble_mask, u64, kstrtou64)
+EDAC_MEM_REPAIR_ATTR_STORE(bank_group, set_bank_group, unsigned long, kstrtoul)
+EDAC_MEM_REPAIR_ATTR_STORE(bank, set_bank, unsigned long, kstrtoul)
+EDAC_MEM_REPAIR_ATTR_STORE(rank, set_rank, unsigned long, kstrtoul)
+EDAC_MEM_REPAIR_ATTR_STORE(row, set_row, u64, kstrtou64)
+EDAC_MEM_REPAIR_ATTR_STORE(column, set_column, unsigned long, kstrtoul)
+EDAC_MEM_REPAIR_ATTR_STORE(channel, set_channel, unsigned long, kstrtoul)
+EDAC_MEM_REPAIR_ATTR_STORE(sub_channel, set_sub_channel, unsigned long, kstrtoul)
+
+#define EDAC_MEM_REPAIR_DO_OP(attrib, cb)						\
+static ssize_t attrib##_store(struct device *ras_feat_dev,				\
+			      struct device_attribute *attr,				\
+			      const char *buf, size_t len)				\
+{											\
+	u8 inst = TO_MEM_REPAIR_DEV_ATTR(attr)->instance;				\
+	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);			\
+	const struct edac_mem_repair_ops *ops = ctx->mem_repair[inst].mem_repair_ops;	\
+	int ret;									\
+											\
+	ret = ops->cb(ras_feat_dev->parent, ctx->mem_repair[inst].private);		\
+	if (ret)									\
+		return ret;								\
+											\
+	return len;									\
+}
+
+EDAC_MEM_REPAIR_DO_OP(query, do_query)
+EDAC_MEM_REPAIR_DO_OP(repair, do_repair)
+
+static ssize_t persist_mode_avail_show(struct device *ras_feat_dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	u8 inst = TO_MEM_REPAIR_DEV_ATTR(attr)->instance;
+	const struct edac_mem_repair_ops *ops = ctx->mem_repair[inst].mem_repair_ops;
+
+	return ops->get_persist_mode_avail(ras_feat_dev->parent,
+					   ctx->mem_repair[inst].private, buf);
+}
+
+static umode_t mem_repair_attr_visible(struct kobject *kobj, struct attribute *a, int attr_id)
+{
+	struct device *ras_feat_dev = kobj_to_dev(kobj);
+	struct device_attribute *dev_attr = container_of(a, struct device_attribute, attr);
+	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	u8 inst = TO_MEM_REPAIR_DEV_ATTR(dev_attr)->instance;
+	const struct edac_mem_repair_ops *ops = ctx->mem_repair[inst].mem_repair_ops;
+
+	switch (attr_id) {
+	case MEM_REPAIR_TYPE:
+		if (ops->get_repair_type)
+			return a->mode;
+		break;
+	case MEM_REPAIR_PERSIST_MODE_AVAIL:
+		if (ops->get_persist_mode_avail)
+			return a->mode;
+		break;
+	case MEM_REPAIR_PERSIST_MODE:
+		if (ops->get_persist_mode) {
+			if (ops->set_persist_mode)
+				return a->mode;
+			else
+				return 0444;
+		}
+		break;
+	case MEM_REPAIR_DPA_SUPPORT:
+		if (ops->get_dpa_support)
+			return a->mode;
+		break;
+	case MEM_REPAIR_SAFE_IN_USE:
+		if (ops->get_repair_safe_when_in_use)
+			return a->mode;
+		break;
+	case MEM_REPAIR_HPA:
+		if (ops->get_hpa) {
+			if (ops->set_hpa)
+				return a->mode;
+			else
+				return 0444;
+		}
+		break;
+	case MEM_REPAIR_DPA:
+		if (ops->get_dpa) {
+			if (ops->set_dpa)
+				return a->mode;
+			else
+				return 0444;
+		}
+		break;
+	case MEM_REPAIR_NIBBLE_MASK:
+		if (ops->get_nibble_mask) {
+			if (ops->set_nibble_mask)
+				return a->mode;
+			else
+				return 0444;
+		}
+		break;
+	case MEM_REPAIR_BANK_GROUP:
+		if (ops->get_bank_group) {
+			if (ops->set_bank_group)
+				return a->mode;
+			else
+				return 0444;
+		}
+		break;
+	case MEM_REPAIR_BANK:
+		if (ops->get_bank) {
+			if (ops->set_bank)
+				return a->mode;
+			else
+				return 0444;
+		}
+		break;
+	case MEM_REPAIR_RANK:
+		if (ops->get_rank) {
+			if (ops->set_rank)
+				return a->mode;
+			else
+				return 0444;
+		}
+		break;
+	case MEM_REPAIR_ROW:
+		if (ops->get_row) {
+			if (ops->set_row)
+				return a->mode;
+			else
+				return 0444;
+		}
+		break;
+	case MEM_REPAIR_COLUMN:
+		if (ops->get_column) {
+			if (ops->set_column)
+				return a->mode;
+			else
+				return 0444;
+		}
+		break;
+	case MEM_REPAIR_CHANNEL:
+		if (ops->get_channel) {
+			if (ops->set_channel)
+				return a->mode;
+			else
+				return 0444;
+		}
+		break;
+	case MEM_REPAIR_SUB_CHANNEL:
+		if (ops->get_sub_channel) {
+			if (ops->set_sub_channel)
+				return a->mode;
+			else
+				return 0444;
+		}
+		break;
+	case MEM_REPAIR_QUERY:
+		if (ops->do_query)
+			return a->mode;
+		break;
+	case MEM_DO_REPAIR:
+		if (ops->do_repair)
+			return a->mode;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+#define EDAC_MEM_REPAIR_ATTR_RO(_name, _instance)       \
+	((struct edac_mem_repair_dev_attr) { .dev_attr = __ATTR_RO(_name), \
+					     .instance = _instance })
+
+#define EDAC_MEM_REPAIR_ATTR_WO(_name, _instance)       \
+	((struct edac_mem_repair_dev_attr) { .dev_attr = __ATTR_WO(_name), \
+					     .instance = _instance })
+
+#define EDAC_MEM_REPAIR_ATTR_RW(_name, _instance)       \
+	((struct edac_mem_repair_dev_attr) { .dev_attr = __ATTR_RW(_name), \
+					     .instance = _instance })
+
+static int mem_repair_create_desc(struct device *dev,
+				  const struct attribute_group **attr_groups, u8 instance)
+{
+	struct edac_mem_repair_context *ctx;
+	struct attribute_group *group;
+	int i;
+	struct edac_mem_repair_dev_attr dev_attr[] = {
+		[MEM_REPAIR_TYPE] = EDAC_MEM_REPAIR_ATTR_RO(repair_type, instance),
+		[MEM_REPAIR_PERSIST_MODE_AVAIL] =
+				EDAC_MEM_REPAIR_ATTR_RO(persist_mode_avail, instance),
+		[MEM_REPAIR_PERSIST_MODE] = EDAC_MEM_REPAIR_ATTR_RW(persist_mode, instance),
+		[MEM_REPAIR_DPA_SUPPORT] = EDAC_MEM_REPAIR_ATTR_RO(dpa_support, instance),
+		[MEM_REPAIR_SAFE_IN_USE] =
+				EDAC_MEM_REPAIR_ATTR_RO(repair_safe_when_in_use, instance),
+		[MEM_REPAIR_HPA] = EDAC_MEM_REPAIR_ATTR_RW(hpa, instance),
+		[MEM_REPAIR_DPA] = EDAC_MEM_REPAIR_ATTR_RW(dpa, instance),
+		[MEM_REPAIR_NIBBLE_MASK] = EDAC_MEM_REPAIR_ATTR_RW(nibble_mask, instance),
+		[MEM_REPAIR_BANK_GROUP] = EDAC_MEM_REPAIR_ATTR_RW(bank_group, instance),
+		[MEM_REPAIR_BANK] = EDAC_MEM_REPAIR_ATTR_RW(bank, instance),
+		[MEM_REPAIR_RANK] = EDAC_MEM_REPAIR_ATTR_RW(rank, instance),
+		[MEM_REPAIR_ROW] = EDAC_MEM_REPAIR_ATTR_RW(row, instance),
+		[MEM_REPAIR_COLUMN] = EDAC_MEM_REPAIR_ATTR_RW(column, instance),
+		[MEM_REPAIR_CHANNEL] = EDAC_MEM_REPAIR_ATTR_RW(channel, instance),
+		[MEM_REPAIR_SUB_CHANNEL] = EDAC_MEM_REPAIR_ATTR_RW(sub_channel, instance),
+		[MEM_REPAIR_QUERY] = EDAC_MEM_REPAIR_ATTR_WO(query, instance),
+		[MEM_DO_REPAIR] = EDAC_MEM_REPAIR_ATTR_WO(repair, instance)
+	};
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	for (i = 0; i < MEM_REPAIR_MAX_ATTRS; i++) {
+		memcpy(&ctx->mem_repair_dev_attr[i].dev_attr, &dev_attr[i], sizeof(dev_attr[i]));
+		ctx->mem_repair_attrs[i] = &ctx->mem_repair_dev_attr[i].dev_attr.attr;
+	}
+	sprintf(ctx->name, "%s%d", "mem_repair", instance);
+	group = &ctx->group;
+	group->name = ctx->name;
+	group->attrs = ctx->mem_repair_attrs;
+	group->is_visible  = mem_repair_attr_visible;
+
+	attr_groups[0] = group;
+
+	return 0;
+}
+
+/**
+ * edac_mem_repair_get_desc - get EDAC memory repair descriptors
+ * @dev: client device with memory repair feature
+ * @attr_groups: pointer to attribute group container
+ * @instance: device's memory repair instance number.
+ *
+ * Return:
+ *  * %0	- Success.
+ *  * %-EINVAL	- Invalid parameters passed.
+ *  * %-ENOMEM	- Dynamic memory allocation failed.
+ */
+int edac_mem_repair_get_desc(struct device *dev,
+			     const struct attribute_group **attr_groups, u8 instance)
+{
+	if (!dev || !attr_groups)
+		return -EINVAL;
+
+	return mem_repair_create_desc(dev, attr_groups, instance);
+}
diff --git a/include/linux/edac.h b/include/linux/edac.h
index 077d3c252e99..7d037bb18904 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -670,6 +670,7 @@ static inline struct dimm_info *edac_get_dimm(struct mem_ctl_info *mci,
 enum edac_dev_feat {
 	RAS_FEAT_SCRUB,
 	RAS_FEAT_ECS,
+	RAS_FEAT_MEM_REPAIR,
 	RAS_FEAT_MAX
 };
 
@@ -741,11 +742,95 @@ int edac_ecs_get_desc(struct device *ecs_dev,
 		      const struct attribute_group **attr_groups,
 		      u16 num_media_frus);
 
+enum edac_mem_repair_type {
+	EDAC_TYPE_SPPR,
+	EDAC_TYPE_HPPR,
+	EDAC_TYPE_CACHELINE_MEM_SPARING,
+	EDAC_TYPE_ROW_MEM_SPARING,
+	EDAC_TYPE_BANK_MEM_SPARING,
+	EDAC_TYPE_RANK_MEM_SPARING,
+};
+
+enum edac_mem_repair_persist_mode {
+	EDAC_MEM_REPAIR_SOFT, /* soft memory repair */
+	EDAC_MEM_REPAIR_HARD, /* hard memory repair */
+};
+
+/**
+ * struct edac_mem_repair_ops - memory repair device operations
+ * (all elements optional)
+ * @get_repair_type: get the memory repair type, listed in enum edac_mem_repair_type.
+ * @get_persist_mode_avail: get the persist modes supported in the device.
+ * @get_persist_mode: get the persist mode of the memory repair instance.
+ * @set_persist_mode: set the persist mode for the memory repair instance.
+ * @get_dpa_support: get dpa support flag.
+ * @get_repair_safe_when_in_use: get whether memory media is accessible and
+ *			       data is retained during repair operation.
+ * @get_hpa: get HPA for memory repair.
+ * @set_hpa: set HPA for memory repair.
+ * @get_dpa: get DPA for memory repair.
+ * @set_dpa: set DPA for memory repair.
+ * @get_nibble_mask: get nibble mask for memory repair.
+ * @set_nibble_mask: set nibble mask for memory repair.
+ * @get_bank_group: get bank group for memory repair.
+ * @set_bank_group: set bank group for memory repair.
+ * @get_bank: get bank for memory repair.
+ * @set_bank: set bank for memory repair.
+ * @get_rank: get rank for memory repair.
+ * @set_rank: set rank for memory repair.
+ * @get_row: get row for memory repair.
+ * @set_row: set row for memory repair.
+ * @get_column: get column for memory repair.
+ * @set_column: set column for memory repair.
+ * @get_channel: get channel for memory repair.
+ * @set_channel: set channel for memory repair.
+ * @get_sub_channel: get sub channel for memory repair.
+ * @set_sub_channel: set sub channel for memory repair.
+ * @do_query: Query memory repair operation for the HPA/DPA/other attrs set
+ *	      is supported or not.
+ * @do_repair: start memory repair operation for the HPA/DPA/other attrs set.
+ */
+struct edac_mem_repair_ops {
+	int (*get_repair_type)(struct device *dev, void *drv_data, u32 *val);
+	int (*get_persist_mode_avail)(struct device *dev, void *drv_data, char *buf);
+	int (*get_persist_mode)(struct device *dev, void *drv_data, u32 *mode);
+	int (*set_persist_mode)(struct device *dev, void *drv_data, u32 mode);
+	int (*get_dpa_support)(struct device *dev, void *drv_data, u32 *val);
+	int (*get_repair_safe_when_in_use)(struct device *dev, void *drv_data, u32 *val);
+	int (*get_hpa)(struct device *dev, void *drv_data, u64 *hpa);
+	int (*set_hpa)(struct device *dev, void *drv_data, u64 hpa);
+	int (*get_dpa)(struct device *dev, void *drv_data, u64 *dpa);
+	int (*set_dpa)(struct device *dev, void *drv_data, u64 dpa);
+	int (*get_nibble_mask)(struct device *dev, void *drv_data, u64 *val);
+	int (*set_nibble_mask)(struct device *dev, void *drv_data, u64 val);
+	int (*get_bank_group)(struct device *dev, void *drv_data, u32 *val);
+	int (*set_bank_group)(struct device *dev, void *drv_data, u32 val);
+	int (*get_bank)(struct device *dev, void *drv_data, u32 *val);
+	int (*set_bank)(struct device *dev, void *drv_data, u32 val);
+	int (*get_rank)(struct device *dev, void *drv_data, u32 *val);
+	int (*set_rank)(struct device *dev, void *drv_data, u32 val);
+	int (*get_row)(struct device *dev, void *drv_data, u64 *val);
+	int (*set_row)(struct device *dev, void *drv_data, u64 val);
+	int (*get_column)(struct device *dev, void *drv_data, u32 *val);
+	int (*set_column)(struct device *dev, void *drv_data, u32 val);
+	int (*get_channel)(struct device *dev, void *drv_data, u32 *val);
+	int (*set_channel)(struct device *dev, void *drv_data, u32 val);
+	int (*get_sub_channel)(struct device *dev, void *drv_data, u32 *val);
+	int (*set_sub_channel)(struct device *dev, void *drv_data, u32 val);
+	int (*do_query)(struct device *dev, void *drv_data);
+	int (*do_repair)(struct device *dev, void *drv_data);
+};
+
+int edac_mem_repair_get_desc(struct device *dev,
+			     const struct attribute_group **attr_groups,
+			     u8 instance);
+
 /* EDAC device feature information structure */
 struct edac_dev_data {
 	union {
 		const struct edac_scrub_ops *scrub_ops;
 		const struct edac_ecs_ops *ecs_ops;
+		const struct edac_mem_repair_ops *mem_repair_ops;
 	};
 	u8 instance;
 	void *private;
@@ -756,6 +841,7 @@ struct edac_dev_feat_ctx {
 	void *private;
 	struct edac_dev_data *scrub;
 	struct edac_dev_data ecs;
+	struct edac_dev_data *mem_repair;
 };
 
 struct edac_dev_feature {
@@ -764,6 +850,7 @@ struct edac_dev_feature {
 	union {
 		const struct edac_scrub_ops *scrub_ops;
 		const struct edac_ecs_ops *ecs_ops;
+		const struct edac_mem_repair_ops *mem_repair_ops;
 	};
 	void *ctx;
 	struct edac_ecs_ex_info ecs_info;
-- 
2.34.1


