Return-Path: <linux-edac+bounces-1572-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEF393D697
	for <lists+linux-edac@lfdr.de>; Fri, 26 Jul 2024 18:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 750621F24ED5
	for <lists+linux-edac@lfdr.de>; Fri, 26 Jul 2024 16:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3E217C9FF;
	Fri, 26 Jul 2024 16:06:57 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20A417C7B9;
	Fri, 26 Jul 2024 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722010017; cv=none; b=XM3OjG/gHk/9ah0uWAWu75BR6yUAHFH6kIVahbBz1duAMJhLFRJ2HIfmiIoxrMauW6ufqPyMbes0ZdWEz4xijiqzBmYFkCJcjIAjeVvmlgQ4KTd4/7ynnQh9sIsCiZxbl3sWjqzbjbkBAWExHAObdteHT6sewng1jYL6ffrGFXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722010017; c=relaxed/simple;
	bh=uXlzYHNBkJC7EYyZxBefzhknZ7whHWVW6ehiqlpPGz0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qWjy2nn0fmGLCGFFUfCSDgNC76J5UGDulhBnqLeXkf5m8T+0JK/HcoyEOg2CWpNQxwdPVGn7fg4ME1UMknwA74H6HhMj2/AVZsktk7vxNuZyT6pE2mvA3rNQ5MRZWVasswLrcoySTX3vE+CmZDxSadVPezWaeA+wklSHnaG7Lis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WVsz82sDgz6K97v;
	Sat, 27 Jul 2024 00:05:08 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id C1ADA140A30;
	Sat, 27 Jul 2024 00:06:52 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.173.33) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 26 Jul 2024 17:06:51 +0100
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
Subject: [PATCH v10 03/11] EDAC: Add EDAC ECS control driver
Date: Fri, 26 Jul 2024 17:05:47 +0100
Message-ID: <20240726160556.2079-4-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240726160556.2079-1-shiju.jose@huawei.com>
References: <20240726160556.2079-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500006.china.huawei.com (7.191.161.198)

From: Shiju Jose <shiju.jose@huawei.com>

Add EDAC ECS (Error Check Scrub) control driver supports configuring
the memory device's ECS feature.

The Error Check Scrub (ECS) is a feature defined in JEDEC DDR5 SDRAM
Specification (JESD79-5) and allows the DRAM to internally read, correct
single-bit errors, and write back corrected data bits to the DRAM array
while providing transparency to error counts.

The DDR5 device contains number of memory media FRUs per device. The
DDR5 ECS feature and thus the ECS control driver supports configuring
the ECS parameters per FRU.

The memory devices support ECS feature register with the EDAC ECS driver
and thus with the generic EDAC RAS feature driver, which adds the sysfs
ECS control interface. The ECS control attributes are exposed to the
userspace in /sys/bus/edac/devices/<dev-name>/ecs_fruX/.

Generic EDAC ECS driver and the common sysfs ECS interface promotes
unambiguous control from the userspace irrespective of the underlying
devices, support ECS feature.

The support for ECS feature is added separately because the DDR5 ECS
feature's control attributes are dissimilar from those of the scrub
feature.

The sysfs ECS attr nodes would be present only if the client driver
has implemented the corresponding attr callback function and pass
in ops to the EDAC RAS feature driver during registration.

Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 Documentation/ABI/testing/sysfs-edac-ecs |  85 +++++
 drivers/edac/Makefile                    |   2 +-
 drivers/edac/edac_ecs.c                  | 396 +++++++++++++++++++++++
 drivers/edac/edac_ras_feature.c          |   5 +
 include/linux/edac_ras_feature.h         |  36 +++
 5 files changed, 523 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-edac-ecs
 create mode 100755 drivers/edac/edac_ecs.c

diff --git a/Documentation/ABI/testing/sysfs-edac-ecs b/Documentation/ABI/testing/sysfs-edac-ecs
new file mode 100644
index 000000000000..fe639b923a04
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-edac-ecs
@@ -0,0 +1,85 @@
+What:		/sys/bus/edac/devices/<dev-name>/ecs_fru*
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		The sysfs edac bus devices /<dev-name>/ecs_fru* subdirectory
+		belongs to the memory media ECS (Error Check Scrub) control
+		feature, where <dev-name> directory corresponds to a device
+		registered with the EDAC ECS driver and thus registered with
+		the generic edac ras driver too.
+		/ecs_fru* belongs to the media FRUs (Field replaceable unit)
+		under the memory device.
+		The sysfs ECS attr nodes would be present only if the client
+		driver has implemented the corresponding attr callback
+		function and pass in ops to the EDAC RAS feature driver
+		during registration.
+
+What:		/sys/bus/edac/devices/<dev-name>/ecs_fru*/log_entry_type
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RW) The log entry type of how the DDR5 ECS log is reported.
+		00b - per DRAM.
+		01b - per memory media FRU.
+
+What:		/sys/bus/edac/devices/<dev-name>/ecs_fru*/log_entry_type_per_dram
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RO) True if current log entry type is per DRAM.
+
+What:		/sys/bus/edac/devices/<dev-name>/ecs_fru*/log_entry_type_per_memory_media
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RO) True if current log entry type is per memory media FRU.
+
+What:		/sys/bus/edac/devices/<dev-name>/ecs_fru*/mode
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RW) The mode of how the DDR5 ECS counts the errors.
+		0 - ECS counts rows with errors.
+		1 - ECS counts codewords with errors.
+
+What:		/sys/bus/edac/devices/<dev-name>/ecs_fru*/mode_counts_rows
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RO) True if current mode is ECS counts rows with errors.
+
+What:		/sys/bus/edac/devices/<dev-name>/ecs_fru*/mode_counts_codewords
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RO) True if current mode is ECS counts codewords with errors.
+
+What:		/sys/bus/edac/devices/<dev-name>/ecs_fru*/name
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RO) name of the memory media FRU ECS.
+
+What:		/sys/bus/edac/devices/<dev-name>/ecs_fru*/reset
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(WO) ECS reset ECC counter.
+		0 - normal, ECC counter running actively.
+		1 - reset ECC counter to the default value.
+
+What:		/sys/bus/edac/devices/<dev-name>/ecs_fru*/threshold
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RW) ECS threshold count per GB of memory cells.
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index de56cbd039eb..c1412c7d3efb 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -10,7 +10,7 @@ obj-$(CONFIG_EDAC)			:= edac_core.o
 
 edac_core-y	:= edac_mc.o edac_device.o edac_mc_sysfs.o
 edac_core-y	+= edac_module.o edac_device_sysfs.o wq.o
-edac_core-y	+= edac_ras_feature.o edac_scrub.o
+edac_core-y	+= edac_ras_feature.o edac_scrub.o edac_ecs.o
 
 edac_core-$(CONFIG_EDAC_DEBUG)		+= debugfs.o
 
diff --git a/drivers/edac/edac_ecs.c b/drivers/edac/edac_ecs.c
new file mode 100755
index 000000000000..d35159fa9463
--- /dev/null
+++ b/drivers/edac/edac_ecs.c
@@ -0,0 +1,396 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ECS driver supporting controlling on die error check scrub
+ * (e.g. DDR5 ECS). The common sysfs ECS interface promotes
+ * unambiguous access from the userspace.
+ *
+ * Copyright (c) 2024 HiSilicon Limited.
+ */
+
+#define pr_fmt(fmt)     "EDAC ECS: " fmt
+
+#include <linux/edac_ras_feature.h>
+
+#define EDAC_ECS_FRU_NAME "ecs_fru"
+
+enum edac_ecs_attributes {
+	ECS_LOG_ENTRY_TYPE,
+	ECS_LOG_ENTRY_TYPE_PER_DRAM,
+	ECS_LOG_ENTRY_TYPE_PER_MEMORY_MEDIA,
+	ECS_MODE,
+	ECS_MODE_COUNTS_ROWS,
+	ECS_MODE_COUNTS_CODEWORDS,
+	ECS_RESET,
+	ECS_NAME,
+	ECS_THRESHOLD,
+	ECS_MAX_ATTRS
+};
+
+struct edac_ecs_dev_attr {
+	struct device_attribute dev_attr;
+	int fru_id;
+};
+
+struct edac_ecs_fru_context {
+	char name[EDAC_RAS_NAME_LEN];
+	struct edac_ecs_dev_attr ecs_dev_attr[ECS_MAX_ATTRS];
+	struct attribute *ecs_attrs[ECS_MAX_ATTRS + 1];
+	struct attribute_group group;
+};
+
+struct edac_ecs_context {
+	u16 num_media_frus;
+	struct edac_ecs_fru_context *fru_ctxs;
+};
+
+#define to_ecs_dev_attr(_dev_attr)	\
+	container_of(_dev_attr, struct edac_ecs_dev_attr, dev_attr)
+
+static ssize_t log_entry_type_show(struct device *ras_feat_dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	struct edac_ecs_dev_attr *ecs_dev_attr = to_ecs_dev_attr(attr);
+	struct edac_ras_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_ecs_ops *ops = ctx->ecs.ops;
+	u32 val;
+	int ret;
+
+	ret = ops->get_log_entry_type(ras_feat_dev->parent, ctx->ecs.private,
+				      ecs_dev_attr->fru_id, &val);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%u\n", val);
+}
+
+static ssize_t log_entry_type_store(struct device *ras_feat_dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t len)
+{
+	struct edac_ecs_dev_attr *ecs_dev_attr = to_ecs_dev_attr(attr);
+	struct edac_ras_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_ecs_ops *ops = ctx->ecs.ops;
+	long val;
+	int ret;
+
+	ret = kstrtol(buf, 0, &val);
+	if (ret < 0)
+		return ret;
+
+	ret = ops->set_log_entry_type(ras_feat_dev->parent, ctx->ecs.private,
+				      ecs_dev_attr->fru_id, val);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static ssize_t log_entry_type_per_dram_show(struct device *ras_feat_dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	struct edac_ecs_dev_attr *ecs_dev_attr = to_ecs_dev_attr(attr);
+	struct edac_ras_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_ecs_ops *ops = ctx->ecs.ops;
+	u32 val;
+	int ret;
+
+	ret = ops->get_log_entry_type_per_dram(ras_feat_dev->parent, ctx->ecs.private,
+					       ecs_dev_attr->fru_id, &val);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%u\n", val);
+}
+
+static ssize_t log_entry_type_per_memory_media_show(struct device *ras_feat_dev,
+						    struct device_attribute *attr,
+						    char *buf)
+{
+	struct edac_ecs_dev_attr *ecs_dev_attr = to_ecs_dev_attr(attr);
+	struct edac_ras_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_ecs_ops *ops = ctx->ecs.ops;
+	u32 val;
+	int ret;
+
+	ret = ops->get_log_entry_type_per_memory_media(ras_feat_dev->parent,
+						       ctx->ecs.private,
+						       ecs_dev_attr->fru_id, &val);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%u\n", val);
+}
+
+static ssize_t mode_show(struct device *ras_feat_dev,
+			 struct device_attribute *attr,
+			 char *buf)
+{
+	struct edac_ecs_dev_attr *ecs_dev_attr = to_ecs_dev_attr(attr);
+	struct edac_ras_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_ecs_ops *ops = ctx->ecs.ops;
+	u32 val;
+	int ret;
+
+	ret = ops->get_mode(ras_feat_dev->parent, ctx->ecs.private,
+			    ecs_dev_attr->fru_id, &val);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%u\n", val);
+}
+
+static ssize_t mode_store(struct device *ras_feat_dev,
+			  struct device_attribute *attr,
+			  const char *buf, size_t len)
+{
+	struct edac_ecs_dev_attr *ecs_dev_attr = to_ecs_dev_attr(attr);
+	struct edac_ras_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_ecs_ops *ops = ctx->ecs.ops;
+	long val;
+	int ret;
+
+	ret = kstrtol(buf, 0, &val);
+	if (ret < 0)
+		return ret;
+
+	ret = ops->set_mode(ras_feat_dev->parent, ctx->ecs.private,
+			    ecs_dev_attr->fru_id, val);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static ssize_t mode_counts_rows_show(struct device *ras_feat_dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct edac_ecs_dev_attr *ecs_dev_attr = to_ecs_dev_attr(attr);
+	struct edac_ras_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_ecs_ops *ops = ctx->ecs.ops;
+	u32 val;
+	int ret;
+
+	ret = ops->get_mode_counts_rows(ras_feat_dev->parent, ctx->ecs.private,
+					ecs_dev_attr->fru_id, &val);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%u\n", val);
+}
+
+static ssize_t mode_counts_codewords_show(struct device *ras_feat_dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct edac_ecs_dev_attr *ecs_dev_attr = to_ecs_dev_attr(attr);
+	struct edac_ras_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_ecs_ops *ops = ctx->ecs.ops;
+	u32 val;
+	int ret;
+
+	ret = ops->get_mode_counts_codewords(ras_feat_dev->parent, ctx->ecs.private,
+					     ecs_dev_attr->fru_id, &val);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%u\n", val);
+}
+
+static ssize_t reset_store(struct device *ras_feat_dev,
+			   struct device_attribute *attr,
+			   const char *buf, size_t len)
+{
+	struct edac_ecs_dev_attr *ecs_dev_attr = to_ecs_dev_attr(attr);
+	struct edac_ras_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_ecs_ops *ops = ctx->ecs.ops;
+	long val;
+	int ret;
+
+	ret = kstrtol(buf, 0, &val);
+	if (ret < 0)
+		return ret;
+
+	ret = ops->reset(ras_feat_dev->parent, ctx->ecs.private,
+			 ecs_dev_attr->fru_id, val);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static ssize_t name_show(struct device *ras_feat_dev,
+			 struct device_attribute *attr, char *buf)
+{
+	struct edac_ecs_dev_attr *ecs_dev_attr = to_ecs_dev_attr(attr);
+	struct edac_ras_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_ecs_ops *ops = ctx->ecs.ops;
+	int ret;
+
+	ret = ops->get_name(ras_feat_dev->parent, ctx->ecs.private,
+			    ecs_dev_attr->fru_id, buf);
+	if (ret)
+		return ret;
+
+	return strlen(buf);
+}
+
+static ssize_t threshold_show(struct device *ras_feat_dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct edac_ecs_dev_attr *ecs_dev_attr = to_ecs_dev_attr(attr);
+	struct edac_ras_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_ecs_ops *ops = ctx->ecs.ops;
+	int ret;
+	u32 val;
+
+	ret = ops->get_threshold(ras_feat_dev->parent, ctx->ecs.private,
+				 ecs_dev_attr->fru_id, &val);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%u\n", val);
+}
+
+static ssize_t threshold_store(struct device *ras_feat_dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t len)
+{
+	struct edac_ecs_dev_attr *ecs_dev_attr = to_ecs_dev_attr(attr);
+	struct edac_ras_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_ecs_ops *ops = ctx->ecs.ops;
+	long val;
+	int ret;
+
+	ret = kstrtol(buf, 0, &val);
+	if (ret < 0)
+		return ret;
+
+	ret = ops->set_threshold(ras_feat_dev->parent, ctx->ecs.private,
+				 ecs_dev_attr->fru_id, val);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static umode_t ecs_attr_visible(struct kobject *kobj,
+				struct attribute *a, int attr_id)
+{
+	struct device *ras_feat_dev = kobj_to_dev(kobj);
+	struct edac_ras_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_ecs_ops *ops = ctx->ecs.ops;
+
+	switch (attr_id) {
+	case ECS_LOG_ENTRY_TYPE:
+		if (ops->get_log_entry_type && ops->set_log_entry_type)
+			return a->mode;
+		if (ops->get_log_entry_type)
+			return 0444;
+		return 0;
+	case ECS_LOG_ENTRY_TYPE_PER_DRAM:
+		return ops->get_log_entry_type_per_dram ? a->mode : 0;
+	case ECS_LOG_ENTRY_TYPE_PER_MEMORY_MEDIA:
+		return ops->get_log_entry_type_per_memory_media ? a->mode : 0;
+	case ECS_MODE:
+		if (ops->get_mode && ops->set_mode)
+			return a->mode;
+		if (ops->get_mode)
+			return 0444;
+		return 0;
+	case ECS_MODE_COUNTS_ROWS:
+		return ops->get_mode_counts_rows ? a->mode : 0;
+	case ECS_MODE_COUNTS_CODEWORDS:
+		return ops->get_mode_counts_codewords ? a->mode : 0;
+	case ECS_RESET:
+		return ops->reset ? a->mode : 0;
+	case ECS_NAME:
+		return ops->get_name ? a->mode : 0;
+	case ECS_THRESHOLD:
+		if (ops->get_threshold && ops->set_threshold)
+			return a->mode;
+		if (ops->get_threshold)
+			return 0444;
+		return 0;
+	default:
+		return 0;
+	}
+}
+
+#define EDAC_ECS_ATTR_RO(_name, _fru_id)       \
+	((struct edac_ecs_dev_attr) { .dev_attr = __ATTR_RO(_name), \
+				     .fru_id = _fru_id })
+
+#define EDAC_ECS_ATTR_WO(_name, _fru_id)       \
+	((struct edac_ecs_dev_attr) { .dev_attr = __ATTR_WO(_name), \
+				     .fru_id = _fru_id })
+
+#define EDAC_ECS_ATTR_RW(_name, _fru_id)       \
+	((struct edac_ecs_dev_attr) { .dev_attr = __ATTR_RW(_name), \
+				     .fru_id = _fru_id })
+
+static int ecs_create_desc(struct device *ecs_dev,
+			   const struct attribute_group **attr_groups,
+			   u16 num_media_frus)
+{
+	struct edac_ecs_context *ecs_ctx;
+	u32 fru;
+
+	ecs_ctx = devm_kzalloc(ecs_dev, sizeof(*ecs_ctx), GFP_KERNEL);
+	if (!ecs_ctx)
+		return -ENOMEM;
+
+	ecs_ctx->num_media_frus = num_media_frus;
+	ecs_ctx->fru_ctxs = devm_kcalloc(ecs_dev, num_media_frus,
+					 sizeof(*ecs_ctx->fru_ctxs),
+					 GFP_KERNEL);
+	if (!ecs_ctx->fru_ctxs)
+		return -ENOMEM;
+
+	for (fru = 0; fru < num_media_frus; fru++) {
+		struct edac_ecs_fru_context *fru_ctx = &ecs_ctx->fru_ctxs[fru];
+		struct attribute_group *group = &fru_ctx->group;
+		int i;
+
+		fru_ctx->ecs_dev_attr[0] = EDAC_ECS_ATTR_RW(log_entry_type, fru);
+		fru_ctx->ecs_dev_attr[1] = EDAC_ECS_ATTR_RO(log_entry_type_per_dram, fru);
+		fru_ctx->ecs_dev_attr[2] = EDAC_ECS_ATTR_RO(log_entry_type_per_memory_media, fru);
+		fru_ctx->ecs_dev_attr[3] = EDAC_ECS_ATTR_RW(mode, fru);
+		fru_ctx->ecs_dev_attr[4] = EDAC_ECS_ATTR_RO(mode_counts_rows, fru);
+		fru_ctx->ecs_dev_attr[5] = EDAC_ECS_ATTR_RO(mode_counts_codewords, fru);
+		fru_ctx->ecs_dev_attr[6] = EDAC_ECS_ATTR_WO(reset, fru);
+		fru_ctx->ecs_dev_attr[7] = EDAC_ECS_ATTR_RO(name, fru);
+		fru_ctx->ecs_dev_attr[8] = EDAC_ECS_ATTR_RW(threshold, fru);
+		for (i = 0; i < ECS_MAX_ATTRS; i++)
+			fru_ctx->ecs_attrs[i] = &fru_ctx->ecs_dev_attr[i].dev_attr.attr;
+
+		sprintf(fru_ctx->name, "%s%d", EDAC_ECS_FRU_NAME, fru);
+		group->name = fru_ctx->name;
+		group->attrs = fru_ctx->ecs_attrs;
+		group->is_visible  = ecs_attr_visible;
+
+		attr_groups[fru] = group;
+	}
+
+	return 0;
+}
+
+/**
+ * edac_ecs_get_desc - get edac ecs descriptors
+ * @ecs_dev: client ecs device
+ * @attr_groups: pointer to attrribute group container
+ * @num_media_frus: number of media FRUs in the device
+ *
+ * Returns 0 on success, error otherwise.
+ */
+int edac_ecs_get_desc(struct device *ecs_dev,
+		      const struct attribute_group **attr_groups,
+		      u16 num_media_frus)
+{
+	if (!ecs_dev || !attr_groups || !num_media_frus)
+		return -EINVAL;
+
+	return ecs_create_desc(ecs_dev, attr_groups, num_media_frus);
+}
diff --git a/drivers/edac/edac_ras_feature.c b/drivers/edac/edac_ras_feature.c
index b65a4c0b8e3e..509aedcd938c 100755
--- a/drivers/edac/edac_ras_feature.c
+++ b/drivers/edac/edac_ras_feature.c
@@ -68,10 +68,15 @@ static int edac_ras_feat_ecs_init(struct device *parent,
 				  const struct attribute_group **attr_groups)
 {
 	int num = efeat->ecs_info.num_media_frus;
+	int ret;
 
 	edata->ops = efeat->ecs_ops;
 	edata->private = efeat->ecs_ctx;
 
+	ret = edac_ecs_get_desc(parent, attr_groups, num);
+	if (ret)
+		return ret;
+
 	return num;
 }
 
diff --git a/include/linux/edac_ras_feature.h b/include/linux/edac_ras_feature.h
index 89cb5a756ebe..9d2281667435 100755
--- a/include/linux/edac_ras_feature.h
+++ b/include/linux/edac_ras_feature.h
@@ -49,10 +49,46 @@ struct edac_scrub_ops {
 
 const struct attribute_group *edac_scrub_get_desc(void);
 
+/**
+ * struct ecs_ops - ECS device operations (all elements optional)
+ * @get_log_entry_type: read the log entry type value.
+ * @set_log_entry_type: set the log entry type value.
+ * @get_log_entry_type_per_dram: read the log entry type per dram value.
+ * @get_log_entry_type_memory_media: read the log entry type per memory media value.
+ * @get_mode: read the mode value.
+ * @set_mode: set the mode value.
+ * @get_mode_counts_rows: read the mode counts rows value.
+ * @get_mode_counts_codewords: read the mode counts codewords value.
+ * @reset: reset the ECS counter.
+ * @get_threshold: read the threshold value.
+ * @set_threshold: set the threshold value.
+ * @get_name: get the ECS's name.
+ */
+struct edac_ecs_ops {
+	int (*get_log_entry_type)(struct device *dev, void *drv_data, int fru_id, u32 *val);
+	int (*set_log_entry_type)(struct device *dev, void *drv_data, int fru_id, u32 val);
+	int (*get_log_entry_type_per_dram)(struct device *dev, void *drv_data,
+					   int fru_id, u32 *val);
+	int (*get_log_entry_type_per_memory_media)(struct device *dev, void *drv_data,
+						   int fru_id, u32 *val);
+	int (*get_mode)(struct device *dev, void *drv_data, int fru_id, u32 *val);
+	int (*set_mode)(struct device *dev, void *drv_data, int fru_id, u32 val);
+	int (*get_mode_counts_rows)(struct device *dev, void *drv_data, int fru_id, u32 *val);
+	int (*get_mode_counts_codewords)(struct device *dev, void *drv_data, int fru_id, u32 *val);
+	int (*reset)(struct device *dev, void *drv_data, int fru_id, u32 val);
+	int (*get_threshold)(struct device *dev, void *drv_data, int fru_id, u32 *threshold);
+	int (*set_threshold)(struct device *dev, void *drv_data, int fru_id, u32 threshold);
+	int (*get_name)(struct device *dev, void *drv_data, int fru_id, char *buf);
+};
+
 struct edac_ecs_ex_info {
 	u16 num_media_frus;
 };
 
+int edac_ecs_get_desc(struct device *ecs_dev,
+		      const struct attribute_group **attr_groups,
+		      u16 num_media_frus);
+
 /*
  * EDAC RAS feature information structure
  */
-- 
2.34.1


