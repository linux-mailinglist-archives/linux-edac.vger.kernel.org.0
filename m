Return-Path: <linux-edac+bounces-2991-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5C6A2C612
	for <lists+linux-edac@lfdr.de>; Fri,  7 Feb 2025 15:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B1E116CA19
	for <lists+linux-edac@lfdr.de>; Fri,  7 Feb 2025 14:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B81D2594B4;
	Fri,  7 Feb 2025 14:46:12 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022422594AB;
	Fri,  7 Feb 2025 14:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738939572; cv=none; b=kSDtbadfu5pU0G2r2/RlRPLkJKnLm0DNbKVKU1F1irlJOxKNhkv8Hzx8acydP+DlmO433jBNhE15+GMdqx823K1dhP/crAaBwVpzKNoqY+fMRjerXGhAkWHG2yJwKBxM95mvDTSBP5JdgCjXoW65wM5S0WtVnLdD0hHr91ulJS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738939572; c=relaxed/simple;
	bh=/7Pz1bo3nG/Q6h30z+CAxTKoCwVikFDtoN1mQ9ijMzw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GTIH1/fkgTXMjCuU0g7x34zmzP32FjZWELv/Lo8DHtPQxk/FEhFw2CPGAKumOV/GiDefzWbUIEDA8N8wi7GR0KeZlKypqsdYX2xZEmx3tGuU0uXqZEGO3xbF8x5RspsXMxjaeOzQlBrO5dsESCD1NEPgJwoQm6rD889hjvA9i4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YqGts2VF8z6H7dJ;
	Fri,  7 Feb 2025 22:43:49 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 163881408F9;
	Fri,  7 Feb 2025 22:46:08 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.173.5) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Feb 2025 15:46:02 +0100
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
CC: <linux-doc@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <mchehab@kernel.org>,
	<dan.j.williams@intel.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
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
Subject: [PATCH v19 14/15] EDAC: Update memory repair control interface for memory sparing feature
Date: Fri, 7 Feb 2025 14:44:43 +0000
Message-ID: <20250207144445.1879-15-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250207144445.1879-1-shiju.jose@huawei.com>
References: <20250207144445.1879-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Update memory repair control interface for memory sparing feature.
Examples are CXL memory sparing features.

CXL memory device may support soft and hard memory sparing at cacheline,
row, bank and rank granularities. Memory sparing is defined as
a repair function that replaces a portion of memory with a portion of
functional memory at that same granularity.

When a CXL device detects an error in a memory, it may report the host of
the need for a repair maintenance operation by using an event record where
the "maintenance needed" flag is set. The event records contains the device
physical address(DPA) and other attributes of the memory to repair (such as
bank group, bank, rank, row, column, channel etc). The kernel
will report the corresponding CXL general media or DRAM trace event to
userspace, and userspace tools (e.g. rasdaemon) will initiate a repair
operation in response to the device request via the sysfs repair control.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 .../ABI/testing/sysfs-edac-memory-repair      | 57 +++++++++++++
 drivers/edac/mem_repair.c                     | 85 +++++++++++++++++++
 include/linux/edac.h                          | 28 ++++++
 3 files changed, 170 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-edac-memory-repair b/Documentation/ABI/testing/sysfs-edac-memory-repair
index c54f59e4497b..d0d70b094651 100644
--- a/Documentation/ABI/testing/sysfs-edac-memory-repair
+++ b/Documentation/ABI/testing/sysfs-edac-memory-repair
@@ -42,6 +42,14 @@ Description:
 
 		- ppr - Post package repair.
 
+		- cacheline-sparing
+
+		- row-sparing
+
+		- bank-sparing
+
+		- rank-sparing
+
 		- All other values are reserved.
 
 What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/persist_mode
@@ -134,6 +142,55 @@ Description:
 		related error records and trace events, for eg. CXL DRAM
 		and CXL general media error records in CXL memory devices.
 
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/bank_group
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/bank
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/rank
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/row
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/column
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/channel
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/sub_channel
+Date:		March 2025
+KernelVersion:	6.15
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RW) The control attributes for the  memory to be repaired.
+		The specific value of attributes to use depends on the
+		portion of memory to repair and will be reported to host
+		in related error records and may be available to userspace
+		in trace events, such as CXL DRAM and CXL general media
+		error records of CXL memory devices.
+
+		When readng back these attributes, it returns the current
+		value of memory requested to be repaired.
+
+		bank_group - The bank group of the memory to repair.
+
+		bank - The bank number of the memory to repair.
+
+		rank - The rank of the memory to repair. Rank is defined as a
+		set of memory devices on a channel that together execute a
+		transaction.
+
+		row - The row number of the memory to repair.
+
+		column - The column number of the memory to repair.
+
+		channel - The channel of the memory to repair. Channel is
+		defined as an interface that can be independently accessed
+		for a transaction.
+
+		sub_channel - The subchannel of the memory to repair.
+
+		The requirement to set these attributes varies based on the
+		repair function. The attributes in sysfs are not present
+		unless required for a repair function.
+
+		For example, CXL spec ver 3.1, Section 8.2.9.7.1.2 Table 8-103
+		soft PPR and Section 8.2.9.7.1.3 Table 8-104 hard PPR operations,
+		these attributes are not required to set. CXL spec ver 3.1,
+		Section 8.2.9.7.1.4 Table 8-105 memory sparing, these attributes
+		are required to set based on memory sparing granularity.
+
 What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/repair
 Date:		March 2025
 KernelVersion:	6.15
diff --git a/drivers/edac/mem_repair.c b/drivers/edac/mem_repair.c
index 9fe310050464..47ed5edffc61 100755
--- a/drivers/edac/mem_repair.c
+++ b/drivers/edac/mem_repair.c
@@ -22,6 +22,13 @@ enum edac_mem_repair_attributes {
 	MEM_REPAIR_MIN_DPA,
 	MEM_REPAIR_MAX_DPA,
 	MEM_REPAIR_NIBBLE_MASK,
+	MEM_REPAIR_BANK_GROUP,
+	MEM_REPAIR_BANK,
+	MEM_REPAIR_RANK,
+	MEM_REPAIR_ROW,
+	MEM_REPAIR_COLUMN,
+	MEM_REPAIR_CHANNEL,
+	MEM_REPAIR_SUB_CHANNEL,
 	MEM_DO_REPAIR,
 	MEM_REPAIR_MAX_ATTRS
 };
@@ -70,6 +77,13 @@ EDAC_MEM_REPAIR_ATTR_SHOW(dpa, get_dpa, u64, "0x%llx\n")
 EDAC_MEM_REPAIR_ATTR_SHOW(min_dpa, get_min_dpa, u64, "0x%llx\n")
 EDAC_MEM_REPAIR_ATTR_SHOW(max_dpa, get_max_dpa, u64, "0x%llx\n")
 EDAC_MEM_REPAIR_ATTR_SHOW(nibble_mask, get_nibble_mask, u32, "0x%x\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(bank_group, get_bank_group, u32, "%u\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(bank, get_bank, u32, "%u\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(rank, get_rank, u32, "%u\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(row, get_row, u32, "0x%x\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(column, get_column, u32, "%u\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(channel, get_channel, u32, "%u\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(sub_channel, get_sub_channel, u32, "%u\n")
 
 #define EDAC_MEM_REPAIR_ATTR_STORE(attrib, cb, type, conv_func)			\
 static ssize_t attrib##_store(struct device *ras_feat_dev,			\
@@ -99,6 +113,13 @@ EDAC_MEM_REPAIR_ATTR_STORE(persist_mode, set_persist_mode, unsigned long, kstrto
 EDAC_MEM_REPAIR_ATTR_STORE(hpa, set_hpa, u64, kstrtou64)
 EDAC_MEM_REPAIR_ATTR_STORE(dpa, set_dpa, u64, kstrtou64)
 EDAC_MEM_REPAIR_ATTR_STORE(nibble_mask, set_nibble_mask, unsigned long, kstrtoul)
+EDAC_MEM_REPAIR_ATTR_STORE(bank_group, set_bank_group, unsigned long, kstrtoul)
+EDAC_MEM_REPAIR_ATTR_STORE(bank, set_bank, unsigned long, kstrtoul)
+EDAC_MEM_REPAIR_ATTR_STORE(rank, set_rank, unsigned long, kstrtoul)
+EDAC_MEM_REPAIR_ATTR_STORE(row, set_row, unsigned long, kstrtoul)
+EDAC_MEM_REPAIR_ATTR_STORE(column, set_column, unsigned long, kstrtoul)
+EDAC_MEM_REPAIR_ATTR_STORE(channel, set_channel, unsigned long, kstrtoul)
+EDAC_MEM_REPAIR_ATTR_STORE(sub_channel, set_sub_channel, unsigned long, kstrtoul)
 
 #define EDAC_MEM_REPAIR_DO_OP(attrib, cb)						\
 static ssize_t attrib##_store(struct device *ras_feat_dev,				\
@@ -189,6 +210,62 @@ static umode_t mem_repair_attr_visible(struct kobject *kobj, struct attribute *a
 				return 0444;
 		}
 		break;
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
 	case MEM_DO_REPAIR:
 		if (ops->do_repair)
 			return a->mode;
@@ -235,6 +312,14 @@ static int mem_repair_create_desc(struct device *dev,
 		[MEM_REPAIR_MAX_DPA] = EDAC_MEM_REPAIR_ATTR_RO(max_dpa, instance),
 		[MEM_REPAIR_NIBBLE_MASK] =
 				EDAC_MEM_REPAIR_ATTR_RW(nibble_mask, instance),
+		[MEM_REPAIR_BANK_GROUP] =
+				EDAC_MEM_REPAIR_ATTR_RW(bank_group, instance),
+		[MEM_REPAIR_BANK] = EDAC_MEM_REPAIR_ATTR_RW(bank, instance),
+		[MEM_REPAIR_RANK] = EDAC_MEM_REPAIR_ATTR_RW(rank, instance),
+		[MEM_REPAIR_ROW] = EDAC_MEM_REPAIR_ATTR_RW(row, instance),
+		[MEM_REPAIR_COLUMN] = EDAC_MEM_REPAIR_ATTR_RW(column, instance),
+		[MEM_REPAIR_CHANNEL] = EDAC_MEM_REPAIR_ATTR_RW(channel, instance),
+		[MEM_REPAIR_SUB_CHANNEL] = EDAC_MEM_REPAIR_ATTR_RW(sub_channel, instance),
 		[MEM_DO_REPAIR] = EDAC_MEM_REPAIR_ATTR_WO(repair, instance)
 	};
 
diff --git a/include/linux/edac.h b/include/linux/edac.h
index 060f79a7f72a..a8fd01271582 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -785,6 +785,20 @@ enum edac_mem_repair_cmd {
  * @get_max_dpa: get the maximum supported device physical address (DPA).
  * @get_nibble_mask: get current nibble mask of memory to repair.
  * @set_nibble_mask: set nibble mask of memory to repair.
+ * @get_bank_group: get current bank group of memory to repair.
+ * @set_bank_group: set bank group of memory to repair.
+ * @get_bank: get current bank of memory to repair.
+ * @set_bank: set bank of memory to repair.
+ * @get_rank: get current rank of memory to repair.
+ * @set_rank: set rank of memory to repair.
+ * @get_row: get current row of memory to repair.
+ * @set_row: set row of memory to repair.
+ * @get_column: get current column of memory to repair.
+ * @set_column: set column of memory to repair.
+ * @get_channel: get current channel of memory to repair.
+ * @set_channel: set channel of memory to repair.
+ * @get_sub_channel: get current subchannel of memory to repair.
+ * @set_sub_channel: set subchannel of memory to repair.
  * @do_repair: Issue memory repair operation for the HPA/DPA and
  *	       other control attributes set for the memory to repair.
  *
@@ -805,6 +819,20 @@ struct edac_mem_repair_ops {
 	int (*get_max_dpa)(struct device *dev, void *drv_data, u64 *dpa);
 	int (*get_nibble_mask)(struct device *dev, void *drv_data, u32 *val);
 	int (*set_nibble_mask)(struct device *dev, void *drv_data, u32 val);
+	int (*get_bank_group)(struct device *dev, void *drv_data, u32 *val);
+	int (*set_bank_group)(struct device *dev, void *drv_data, u32 val);
+	int (*get_bank)(struct device *dev, void *drv_data, u32 *val);
+	int (*set_bank)(struct device *dev, void *drv_data, u32 val);
+	int (*get_rank)(struct device *dev, void *drv_data, u32 *val);
+	int (*set_rank)(struct device *dev, void *drv_data, u32 val);
+	int (*get_row)(struct device *dev, void *drv_data, u32 *val);
+	int (*set_row)(struct device *dev, void *drv_data, u32 val);
+	int (*get_column)(struct device *dev, void *drv_data, u32 *val);
+	int (*set_column)(struct device *dev, void *drv_data, u32 val);
+	int (*get_channel)(struct device *dev, void *drv_data, u32 *val);
+	int (*set_channel)(struct device *dev, void *drv_data, u32 val);
+	int (*get_sub_channel)(struct device *dev, void *drv_data, u32 *val);
+	int (*set_sub_channel)(struct device *dev, void *drv_data, u32 val);
 	int (*do_repair)(struct device *dev, void *drv_data, u32 val);
 };
 
-- 
2.43.0


