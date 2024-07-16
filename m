Return-Path: <linux-edac+bounces-1519-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B7D9329EE
	for <lists+linux-edac@lfdr.de>; Tue, 16 Jul 2024 17:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E09C1F2173D
	for <lists+linux-edac@lfdr.de>; Tue, 16 Jul 2024 15:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1DE19DF8D;
	Tue, 16 Jul 2024 15:04:35 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B8F19DF6C;
	Tue, 16 Jul 2024 15:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721142275; cv=none; b=PF7gqpxnZRC5x4AWeo8FM7/Kd/5wFlEOe+egRKsZXWP9WEiXZlJS66NcjtQrvN0lMdxF2OMZoAOc41KFw7ZsS3iNsu117/YBZo2U32xbTb986Egpq0jZoNYTwLII318eFEeh/swtIJ8HzxhdkUnuOvQsnt48F5J48iJ+mfhrXV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721142275; c=relaxed/simple;
	bh=j0KRwBTmoEy+RsUTNT9SvF0faQ1GrYai8zw0rbjmeIc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qPAAA2/rMvq8Yq4Sd0uo0pWmRSOC9WCbBjjzY+onbXuv/QMVshJ3VR4I/ox+/bfr29gzyJfpxESbwZUSrF5NN8pXLDto/Xe0c/0TB/05W6xq0cE3/UJ3CjUYApi3+l3NYW616aGmZT3dKVa1N8Umd8CoZVEpRglLoJpt/Rmr7vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WNj4H5PQ5z6JB50;
	Tue, 16 Jul 2024 23:03:11 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id 8BF76140A70;
	Tue, 16 Jul 2024 23:04:27 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.159.153) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 16 Jul 2024 16:04:26 +0100
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
Subject: [RFC PATCH v9 02/11] EDAC: Add EDAC scrub control driver
Date: Tue, 16 Jul 2024 16:03:26 +0100
Message-ID: <20240716150336.2042-3-shiju.jose@huawei.com>
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

Add generic EDAC scrub control driver supports configuring the memory scrubbers
in the system. The device with scrub feature, get the scrub descriptor from the
EDAC scrub and registers with the EDAC RAS feature driver, which adds the sysfs
scrub control interface. The scrub control attributes are available to the
userspace in /sys/bus/edac/devices/<dev-name>/scrub/.

Generic EDAC scrub driver and the common sysfs scrub interface promotes
unambiguous access from the userspace irrespective of the underlying scrub
devices.

Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 Documentation/ABI/testing/sysfs-edac-scrub |  64 +++++
 drivers/edac/Makefile                      |   2 +-
 drivers/edac/edac_ras_feature.c            |   1 +
 drivers/edac/edac_scrub.c                  | 312 +++++++++++++++++++++
 include/linux/edac_ras_feature.h           |  28 ++
 5 files changed, 406 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-edac-scrub
 create mode 100755 drivers/edac/edac_scrub.c

diff --git a/Documentation/ABI/testing/sysfs-edac-scrub b/Documentation/ABI/testing/sysfs-edac-scrub
new file mode 100644
index 000000000000..dd19afd5e165
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-edac-scrub
@@ -0,0 +1,64 @@
+What:		/sys/bus/edac/devices/<dev-name>/scrub
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		The sysfs edac bus devices /<dev-name>/scrub subdirectory
+		belongs to the memory scrub control feature, where <dev-name>
+		directory corresponds to a device/memory region registered
+		with the edac scrub driver and thus registered with the
+		generic edac ras driver too.
+
+What:		/sys/bus/edac/devices/<dev-name>/scrub/addr_range_base
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RW) The base of the address range of the memory region
+		to be scrubbed (on-demand scrubbing).
+
+What:		/sys/bus/edac/devices/<dev-name>/scrub/addr_range_size
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RW) The size of the address range of the memory region
+		to be scrubbed (on-demand scrubbing).
+
+What:		/sys/bus/edac/devices/<dev-name>/scrub/enable_background
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RW) Start/Stop background(patrol) scrubbing if supported.
+
+What:		/sys/bus/edac/devices/<dev-name>/scrub/enable_on_demand
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RW) Start/Stop on-demand scrubbing the memory region
+		if supported.
+
+What:		/sys/bus/edac/devices/<dev-name>/scrub/name
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RO) name of the memory scrubber
+
+What:		/sys/bus/edac/devices/<dev-name>/scrub/cycle_in_hours_available
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RO) Supported range for the scrub cycle in hours by the
+		memory scrubber.
+
+What:		/sys/bus/edac/devices/<dev-name>/scrub/cycle_in_hours
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RW) The scrub cycle in hours specified and it must be with in the
+		supported range by the memory scrubber.
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index c532b57a6d8a..de56cbd039eb 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -10,7 +10,7 @@ obj-$(CONFIG_EDAC)			:= edac_core.o
 
 edac_core-y	:= edac_mc.o edac_device.o edac_mc_sysfs.o
 edac_core-y	+= edac_module.o edac_device_sysfs.o wq.o
-edac_core-y	+= edac_ras_feature.o
+edac_core-y	+= edac_ras_feature.o edac_scrub.o
 
 edac_core-$(CONFIG_EDAC_DEBUG)		+= debugfs.o
 
diff --git a/drivers/edac/edac_ras_feature.c b/drivers/edac/edac_ras_feature.c
index 24a729fea66f..48927f868372 100755
--- a/drivers/edac/edac_ras_feature.c
+++ b/drivers/edac/edac_ras_feature.c
@@ -36,6 +36,7 @@ static int edac_ras_feat_scrub_init(struct device *parent,
 {
 	sdata->ops = sfeat->scrub_ops;
 	sdata->private = sfeat->scrub_ctx;
+	attr_groups[0] = edac_scrub_get_desc();
 
 	return 1;
 }
diff --git a/drivers/edac/edac_scrub.c b/drivers/edac/edac_scrub.c
new file mode 100755
index 000000000000..0b07eafd3551
--- /dev/null
+++ b/drivers/edac/edac_scrub.c
@@ -0,0 +1,312 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Generic EDAC scrub driver supports controlling the memory
+ * scrubbers in the system and the common sysfs scrub interface
+ * promotes unambiguous access from the userspace.
+ *
+ * Copyright (c) 2024 HiSilicon Limited.
+ */
+
+#define pr_fmt(fmt)     "EDAC SCRUB: " fmt
+
+#include <linux/edac_ras_feature.h>
+
+static ssize_t addr_range_base_show(struct device *ras_feat_dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	struct edac_ras_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_scrub_ops *ops = ctx->scrub.ops;
+	u64 base, size;
+	int ret;
+
+	ret = ops->read_range(ras_feat_dev->parent, ctx->scrub.private, &base, &size);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "0x%llx\n", base);
+}
+
+static ssize_t addr_range_size_show(struct device *ras_feat_dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	struct edac_ras_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_scrub_ops *ops = ctx->scrub.ops;
+	u64 base, size;
+	int ret;
+
+	ret = ops->read_range(ras_feat_dev->parent, ctx->scrub.private, &base, &size);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "0x%llx\n", size);
+}
+
+static ssize_t addr_range_base_store(struct device *ras_feat_dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t len)
+{
+	struct edac_ras_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_scrub_ops *ops = ctx->scrub.ops;
+	u64 base, size;
+	int ret;
+
+	ret = ops->read_range(ras_feat_dev->parent, ctx->scrub.private, &base, &size);
+	if (ret)
+		return ret;
+
+	ret = kstrtou64(buf, 16, &base);
+	if (ret < 0)
+		return ret;
+
+	ret = ops->write_range(ras_feat_dev->parent, ctx->scrub.private, base, size);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static ssize_t addr_range_size_store(struct device *ras_feat_dev,
+				     struct device_attribute *attr,
+				     const char *buf,
+				     size_t len)
+{
+	struct edac_ras_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_scrub_ops *ops = ctx->scrub.ops;
+	u64 base, size;
+	int ret;
+
+	ret = ops->read_range(ras_feat_dev->parent, ctx->scrub.private, &base, &size);
+	if (ret)
+		return ret;
+
+	ret = kstrtou64(buf, 16, &size);
+	if (ret < 0)
+		return ret;
+
+	ret = ops->write_range(ras_feat_dev->parent, ctx->scrub.private, base, size);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static ssize_t enable_background_store(struct device *ras_feat_dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t len)
+{
+	struct edac_ras_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_scrub_ops *ops = ctx->scrub.ops;
+	bool enable;
+	int ret;
+
+	ret = kstrtobool(buf, &enable);
+	if (ret < 0)
+		return ret;
+
+	ret = ops->set_enabled_bg(ras_feat_dev->parent, ctx->scrub.private, enable);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static ssize_t enable_background_show(struct device *ras_feat_dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct edac_ras_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_scrub_ops *ops = ctx->scrub.ops;
+	bool enable;
+	int ret;
+
+	ret = ops->get_enabled_bg(ras_feat_dev->parent, ctx->scrub.private, &enable);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%d\n", enable);
+}
+
+static ssize_t enable_on_demand_show(struct device *ras_feat_dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct edac_ras_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_scrub_ops *ops = ctx->scrub.ops;
+	bool enable;
+	int ret;
+
+	ret = ops->get_enabled_od(ras_feat_dev->parent, ctx->scrub.private, &enable);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%d\n", enable);
+}
+
+static ssize_t enable_on_demand_store(struct device *ras_feat_dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t len)
+{
+	struct edac_ras_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_scrub_ops *ops = ctx->scrub.ops;
+	bool enable;
+	int ret;
+
+	ret = kstrtobool(buf, &enable);
+	if (ret < 0)
+		return ret;
+
+	ret = ops->set_enabled_od(ras_feat_dev->parent, ctx->scrub.private, enable);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static ssize_t name_show(struct device *ras_feat_dev,
+			 struct device_attribute *attr, char *buf)
+{
+	struct edac_ras_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_scrub_ops *ops = ctx->scrub.ops;
+	int ret;
+
+	ret = ops->get_name(ras_feat_dev->parent, ctx->scrub.private, buf);
+	if (ret)
+		return ret;
+
+	return strlen(buf);
+}
+
+static ssize_t cycle_in_hours_show(struct device *ras_feat_dev, struct device_attribute *attr,
+				   char *buf)
+{
+	struct edac_ras_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_scrub_ops *ops = ctx->scrub.ops;
+	u64 val;
+	int ret;
+
+	ret = ops->cycle_in_hours_read(ras_feat_dev->parent, ctx->scrub.private, &val);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "0x%llx\n", val);
+}
+
+static ssize_t cycle_in_hours_store(struct device *ras_feat_dev, struct device_attribute *attr,
+				    const char *buf, size_t len)
+{
+	struct edac_ras_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_scrub_ops *ops = ctx->scrub.ops;
+	long val;
+	int ret;
+
+	ret = kstrtol(buf, 10, &val);
+	if (ret < 0)
+		return ret;
+
+	ret = ops->cycle_in_hours_write(ras_feat_dev->parent, ctx->scrub.private, val);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static ssize_t cycle_in_hours_range_show(struct device *ras_feat_dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct edac_ras_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_scrub_ops *ops = ctx->scrub.ops;
+	u64 min_schrs, max_schrs;
+	int ret;
+
+	ret = ops->cycle_in_hours_range(ras_feat_dev->parent, ctx->scrub.private,
+					&min_schrs, &max_schrs);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "0x%llx-0x%llx\n", min_schrs, max_schrs);
+}
+
+static DEVICE_ATTR_RW(addr_range_base);
+static DEVICE_ATTR_RW(addr_range_size);
+static DEVICE_ATTR_RW(enable_background);
+static DEVICE_ATTR_RW(enable_on_demand);
+static DEVICE_ATTR_RO(name);
+static DEVICE_ATTR_RW(cycle_in_hours);
+static DEVICE_ATTR_RO(cycle_in_hours_range);
+
+static struct attribute *scrub_attrs[] = {
+	&dev_attr_addr_range_base.attr,
+	&dev_attr_addr_range_size.attr,
+	&dev_attr_enable_background.attr,
+	&dev_attr_enable_on_demand.attr,
+	&dev_attr_name.attr,
+	&dev_attr_cycle_in_hours.attr,
+	&dev_attr_cycle_in_hours_range.attr,
+	NULL
+};
+
+static umode_t scrub_attr_visible(struct kobject *kobj,
+				  struct attribute *a, int attr_id)
+{
+	struct device *ras_feat_dev = kobj_to_dev(kobj);
+	struct edac_ras_feat_ctx *ctx;
+	const struct edac_scrub_ops *ops;
+
+	ctx = dev_get_drvdata(ras_feat_dev);
+	if (!ctx)
+		return 0;
+
+	ops = ctx->scrub.ops;
+	if (a == &dev_attr_addr_range_base.attr ||
+	    a == &dev_attr_addr_range_size.attr) {
+		if (ops->read_range && ops->write_range)
+			return a->mode;
+		if (ops->read_range)
+			return 0444;
+		return 0;
+	}
+	if (a == &dev_attr_enable_background.attr) {
+		if (ops->set_enabled_bg && ops->get_enabled_bg)
+			return a->mode;
+		if (ops->get_enabled_bg)
+			return 0444;
+		return 0;
+	}
+	if (a == &dev_attr_enable_on_demand.attr) {
+		if (ops->set_enabled_od && ops->get_enabled_od)
+			return a->mode;
+		if (ops->get_enabled_od)
+			return 0444;
+		return 0;
+	}
+	if (a == &dev_attr_name.attr)
+		return ops->get_name ? a->mode : 0;
+	if (a == &dev_attr_cycle_in_hours_range.attr)
+		return ops->cycle_in_hours_range ? a->mode : 0;
+	if (a == &dev_attr_cycle_in_hours.attr) { /* Write only makes little sense */
+		if (ops->cycle_in_hours_read && ops->cycle_in_hours_write)
+			return a->mode;
+		if (ops->cycle_in_hours_read)
+			return 0444;
+		return 0;
+	}
+
+	return 0;
+}
+
+static const struct attribute_group scrub_attr_group = {
+	.name		= "scrub",
+	.attrs		= scrub_attrs,
+	.is_visible	= scrub_attr_visible,
+};
+
+/**
+ * edac_scrub_get_desc - get edac scrub's attr descriptor
+ *
+ * Returns attribute_group for the scrub feature.
+ */
+const struct attribute_group *edac_scrub_get_desc(void)
+{
+	return &scrub_attr_group;
+}
diff --git a/include/linux/edac_ras_feature.h b/include/linux/edac_ras_feature.h
index 000e99141023..462f9ecbf9d4 100755
--- a/include/linux/edac_ras_feature.h
+++ b/include/linux/edac_ras_feature.h
@@ -19,6 +19,34 @@ enum edac_ras_feat {
 	ras_feat_max
 };
 
+/**
+ * struct scrub_ops - scrub device operations (all elements optional)
+ * @read_range: read base and offset of scrubbing range.
+ * @write_range: set the base and offset of the scrubbing range.
+ * @get_enabled_bg: check if currently performing background scrub.
+ * @set_enabled_bg: start or stop a bg-scrub.
+ * @get_enabled_od: check if currently performing on-demand scrub.
+ * @set_enabled_od: start or stop an on-demand scrub.
+ * @cycle_in_hours_range: retrieve limits on supported cycle in hours.
+ * @cycle_in_hours_read: read the scrub cycle in hours.
+ * @cycle_in_hours_write: set the scrub cycle in hours.
+ * @get_name: get the memory scrubber's name.
+ */
+struct edac_scrub_ops {
+	int (*read_range)(struct device *dev, void *drv_data, u64 *base, u64 *size);
+	int (*write_range)(struct device *dev, void *drv_data, u64 base, u64 size);
+	int (*get_enabled_bg)(struct device *dev, void *drv_data, bool *enable);
+	int (*set_enabled_bg)(struct device *dev, void *drv_data, bool enable);
+	int (*get_enabled_od)(struct device *dev, void *drv_data, bool *enable);
+	int (*set_enabled_od)(struct device *dev, void *drv_data, bool enable);
+	int (*cycle_in_hours_range)(struct device *dev, void *drv_data,  u64 *min, u64 *max);
+	int (*cycle_in_hours_read)(struct device *dev, void *drv_data, u64 *schrs);
+	int (*cycle_in_hours_write)(struct device *dev, void *drv_data, u64 schrs);
+	int (*get_name)(struct device *dev, void *drv_data, char *buf);
+};
+
+const struct attribute_group *edac_scrub_get_desc(void);
+
 struct edac_ecs_ex_info {
 	u16 num_media_frus;
 };
-- 
2.34.1


