Return-Path: <linux-edac+bounces-1665-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D309A954F24
	for <lists+linux-edac@lfdr.de>; Fri, 16 Aug 2024 18:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03C371C209F4
	for <lists+linux-edac@lfdr.de>; Fri, 16 Aug 2024 16:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61A11C378A;
	Fri, 16 Aug 2024 16:43:40 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25661C0DF0;
	Fri, 16 Aug 2024 16:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723826620; cv=none; b=SVkOLDXEZFxGVo3mvj8uFfKZE/P0D5YywyS0OU9xdHxXjBTnqUqoOns48xTPH1nBjTwbQmSDPkXCak4Tj7RWd4x3m+tnmK1Jcs2gALuX+RFwjTxa04iApJvFxIftqjBu84E218XZr0uG3p/lCRIppuY2fAcB07jrkmUJ5AoB+rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723826620; c=relaxed/simple;
	bh=1nc1cZtrVFvWfArs+ZnkaUF3OGoEmThE6S18ZXf8ZP4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mS/c7xCz0ML1PkEbJST1iCUfzRlqbdRON/1ctv0OurIEZQyyJsB3CmDR6UnrbDb//ky/sYORxIya+/h3P6bryfFP6wPy7Q7qnB9Ix6j2yb1LbTSKbkUBlKh8+ie/gSokAa8c94Q9O0MhOIuwCQIwM/EV97bUo53NBIM8JEY5GZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WlnmX5lTHz6K98p;
	Sat, 17 Aug 2024 00:40:44 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id 21FFA1400C9;
	Sat, 17 Aug 2024 00:43:29 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.148.43) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 17:43:27 +0100
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
	<wbs@os.amperecomputing.com>, <nifan.cxl@gmail.com>, <jgroves@micron.com>,
	<vsalve@micron.com>, <yazen.ghannam@amd.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <roberto.sassu@huawei.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v11 02/14] EDAC: Add EDAC scrub control driver
Date: Fri, 16 Aug 2024 17:42:25 +0100
Message-ID: <20240816164238.1902-3-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240816164238.1902-1-shiju.jose@huawei.com>
References: <20240816164238.1902-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
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

The sysfs scrub attribute nodes would be present only if the client driver
has implemented the corresponding attribute callback function and pass in ops
to the EDAC RAS feature driver during registration.

Question: Does EDAC scrub control driver need supporting multiple scrub
instances per device like EDAC ECS and EDAC PPR?

Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 Documentation/ABI/testing/sysfs-edac-scrub |  69 +++++
 drivers/edac/Makefile                      |   1 +
 drivers/edac/edac_device.c                 |   1 +
 drivers/edac/edac_scrub.c                  | 315 +++++++++++++++++++++
 include/linux/edac.h                       |  28 ++
 5 files changed, 414 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-edac-scrub
 create mode 100755 drivers/edac/edac_scrub.c

diff --git a/Documentation/ABI/testing/sysfs-edac-scrub b/Documentation/ABI/testing/sysfs-edac-scrub
new file mode 100644
index 000000000000..c8b552cfcb17
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-edac-scrub
@@ -0,0 +1,69 @@
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
+		The sysfs scrub attr nodes would be present only if the
+		client driver has implemented the corresponding attr
+		callback function and pass in ops to the EDAC RAS feature
+		driver during registration.
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
+What:		/sys/bus/edac/devices/<dev-name>/scrub/min_cycle_duration
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RO) Supported minimum scrub cycle duration in seconds
+		by the memory scrubber.
+
+What:		/sys/bus/edac/devices/<dev-name>/scrub/max_cycle_duration
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RO) Supported maximum scrub cycle duration in seconds
+		by the memory scrubber.
+
+What:		/sys/bus/edac/devices/<dev-name>/scrub/current_cycle_duration
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RW) The current scrub cycle duration in seconds and must be
+		within the supported range by the memory scrubber.
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 9c09893695b7..06047c7ba14e 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_EDAC)			:= edac_core.o
 
 edac_core-y	:= edac_mc.o edac_device.o edac_mc_sysfs.o
 edac_core-y	+= edac_module.o edac_device_sysfs.o wq.o
+edac_core-y	+= edac_scrub.o
 
 edac_core-$(CONFIG_EDAC_DEBUG)		+= debugfs.o
 
diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
index 635a41db8b5a..0363f55e39d1 100644
--- a/drivers/edac/edac_device.c
+++ b/drivers/edac/edac_device.c
@@ -612,6 +612,7 @@ static int edac_dev_feat_init(struct device *parent,
 	case RAS_FEAT_SCRUB:
 		dev_data->scrub_ops = ras_feat->scrub_ops;
 		dev_data->private = ras_feat->scrub_ctx;
+		attr_groups[0] = edac_scrub_get_desc();
 		return 1;
 	case RAS_FEAT_ECS:
 		num = ras_feat->ecs_info.num_media_frus;
diff --git a/drivers/edac/edac_scrub.c b/drivers/edac/edac_scrub.c
new file mode 100755
index 000000000000..1b994933826b
--- /dev/null
+++ b/drivers/edac/edac_scrub.c
@@ -0,0 +1,315 @@
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
+#include <linux/edac.h>
+
+static ssize_t addr_range_base_show(struct device *ras_feat_dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_scrub_ops *ops = ctx->scrub.scrub_ops;
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
+	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_scrub_ops *ops = ctx->scrub.scrub_ops;
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
+	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_scrub_ops *ops = ctx->scrub.scrub_ops;
+	u64 base, size;
+	int ret;
+
+	ret = ops->read_range(ras_feat_dev->parent, ctx->scrub.private, &base, &size);
+	if (ret)
+		return ret;
+
+	ret = kstrtou64(buf, 0, &base);
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
+	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_scrub_ops *ops = ctx->scrub.scrub_ops;
+	u64 base, size;
+	int ret;
+
+	ret = ops->read_range(ras_feat_dev->parent, ctx->scrub.private, &base, &size);
+	if (ret)
+		return ret;
+
+	ret = kstrtou64(buf, 0, &size);
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
+	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_scrub_ops *ops = ctx->scrub.scrub_ops;
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
+	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_scrub_ops *ops = ctx->scrub.scrub_ops;
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
+	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_scrub_ops *ops = ctx->scrub.scrub_ops;
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
+	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_scrub_ops *ops = ctx->scrub.scrub_ops;
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
+static ssize_t min_cycle_duration_show(struct device *ras_feat_dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_scrub_ops *ops = ctx->scrub.scrub_ops;
+	u32 val;
+	int ret;
+
+	ret = ops->min_cycle_read(ras_feat_dev->parent, ctx->scrub.private, &val);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%u\n", val);
+}
+
+static ssize_t max_cycle_duration_show(struct device *ras_feat_dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_scrub_ops *ops = ctx->scrub.scrub_ops;
+	u32 val;
+	int ret;
+
+	ret = ops->max_cycle_read(ras_feat_dev->parent, ctx->scrub.private, &val);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%u\n", val);
+}
+
+static ssize_t current_cycle_duration_show(struct device *ras_feat_dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_scrub_ops *ops = ctx->scrub.scrub_ops;
+	u32 val;
+	int ret;
+
+	ret = ops->cycle_duration_read(ras_feat_dev->parent, ctx->scrub.private, &val);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%u\n", val);
+}
+
+static ssize_t current_cycle_duration_store(struct device *ras_feat_dev,
+					    struct device_attribute *attr,
+					    const char *buf, size_t len)
+{
+	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_scrub_ops *ops = ctx->scrub.scrub_ops;
+	long val;
+	int ret;
+
+	ret = kstrtol(buf, 0, &val);
+	if (ret < 0)
+		return ret;
+
+	ret = ops->cycle_duration_write(ras_feat_dev->parent, ctx->scrub.private, val);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static DEVICE_ATTR_RW(addr_range_base);
+static DEVICE_ATTR_RW(addr_range_size);
+static DEVICE_ATTR_RW(enable_background);
+static DEVICE_ATTR_RW(enable_on_demand);
+static DEVICE_ATTR_RO(min_cycle_duration);
+static DEVICE_ATTR_RO(max_cycle_duration);
+static DEVICE_ATTR_RW(current_cycle_duration);
+
+static struct attribute *scrub_attrs[] = {
+	&dev_attr_addr_range_base.attr,
+	&dev_attr_addr_range_size.attr,
+	&dev_attr_enable_background.attr,
+	&dev_attr_enable_on_demand.attr,
+	&dev_attr_min_cycle_duration.attr,
+	&dev_attr_max_cycle_duration.attr,
+	&dev_attr_current_cycle_duration.attr,
+	NULL
+};
+
+static umode_t scrub_attr_visible(struct kobject *kobj,
+				  struct attribute *a, int attr_id)
+{
+	struct device *ras_feat_dev = kobj_to_dev(kobj);
+	struct edac_dev_feat_ctx *ctx;
+	const struct edac_scrub_ops *ops;
+
+	ctx = dev_get_drvdata(ras_feat_dev);
+	if (!ctx)
+		return 0;
+
+	ops = ctx->scrub.scrub_ops;
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
+	if (a == &dev_attr_min_cycle_duration.attr)
+		return ops->min_cycle_read ? a->mode : 0;
+	if (a == &dev_attr_max_cycle_duration.attr)
+		return ops->max_cycle_read ? a->mode : 0;
+	if (a == &dev_attr_current_cycle_duration.attr) {
+		if (ops->cycle_duration_read && ops->cycle_duration_write)
+			return a->mode;
+		if (ops->cycle_duration_read)
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
diff --git a/include/linux/edac.h b/include/linux/edac.h
index cc96f55ac714..48e535db19d2 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -673,6 +673,34 @@ enum edac_dev_feat {
 	RAS_FEAT_MAX
 };
 
+/**
+ * struct scrub_ops - scrub device operations (all elements optional)
+ * @read_range: read base and offset of scrubbing range.
+ * @write_range: set the base and offset of the scrubbing range.
+ * @get_enabled_bg: check if currently performing background scrub.
+ * @set_enabled_bg: start or stop a bg-scrub.
+ * @get_enabled_od: check if currently performing on-demand scrub.
+ * @set_enabled_od: start or stop an on-demand scrub.
+ * @min_cycle_read: minimum supported scrub cycle duration in seconds.
+ * @max_cycle_read: maximum supported scrub cycle duration in seconds.
+ * @cycle_duration_read: get the scrub cycle duration in seconds.
+ * @cycle_duration_write: set the scrub cycle duration in seconds.
+ */
+struct edac_scrub_ops {
+	int (*read_range)(struct device *dev, void *drv_data, u64 *base, u64 *size);
+	int (*write_range)(struct device *dev, void *drv_data, u64 base, u64 size);
+	int (*get_enabled_bg)(struct device *dev, void *drv_data, bool *enable);
+	int (*set_enabled_bg)(struct device *dev, void *drv_data, bool enable);
+	int (*get_enabled_od)(struct device *dev, void *drv_data, bool *enable);
+	int (*set_enabled_od)(struct device *dev, void *drv_data, bool enable);
+	int (*min_cycle_read)(struct device *dev, void *drv_data,  u32 *min);
+	int (*max_cycle_read)(struct device *dev, void *drv_data,  u32 *max);
+	int (*cycle_duration_read)(struct device *dev, void *drv_data, u32 *cycle);
+	int (*cycle_duration_write)(struct device *dev, void *drv_data, u32 cycle);
+};
+
+const struct attribute_group *edac_scrub_get_desc(void);
+
 struct edac_ecs_ex_info {
 	u16 num_media_frus;
 };
-- 
2.34.1


