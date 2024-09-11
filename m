Return-Path: <linux-edac+bounces-1844-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 045E6974DEA
	for <lists+linux-edac@lfdr.de>; Wed, 11 Sep 2024 11:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 222CB1C20E96
	for <lists+linux-edac@lfdr.de>; Wed, 11 Sep 2024 09:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DC9175D26;
	Wed, 11 Sep 2024 09:07:09 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8681714A5;
	Wed, 11 Sep 2024 09:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726045628; cv=none; b=Yjkr7MGesw0Wuqm02HZqc5pG8SHgK/TMEyPIJJXCBpos8CiElIn8gsPnLttfEIFc1YhcC9g6wNRUfxPqeTGq75v7ZloG2T6xaoz9EfTe8fZK4hx2hUDXTPYD3quXtuTscy/3ZzBVuvBSYSE9DrUArjINbIELoM4WdGC28zuxKuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726045628; c=relaxed/simple;
	bh=+mQRHxNSRs9bt/U2KUm1bVt/V/v7CjNhmBWSZegB544=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DdWm2OanQ8h60JL8dm2V6athNRqxBT+2pXjdfqDribcBjQ+c7fdd9rqdq6BXFACn1iDNwciKOmdftvHCQOIRpD0oXuNlJStYNeUId4ZDLGlyjXlrXUc/v4XTiCchwJKaNi/e+3mIw7xaufbw1sd/HX+JR5Ikk4unR7zIofE9gKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X3ZMX6pGNz6K6Gc;
	Wed, 11 Sep 2024 17:02:16 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id D91AC140CB9;
	Wed, 11 Sep 2024 17:07:03 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.245.151) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Sep 2024 11:07:01 +0200
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
	<jgroves@micron.com>, <vsalve@micron.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <roberto.sassu@huawei.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v12 02/17] EDAC: Add EDAC scrub control driver
Date: Wed, 11 Sep 2024 10:04:31 +0100
Message-ID: <20240911090447.751-3-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240911090447.751-1-shiju.jose@huawei.com>
References: <20240911090447.751-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Add generic EDAC scrub control driver supports configuring the memory scrubbers
in the system. The device with scrub feature, get the scrub descriptor from the
EDAC scrub and registers with the EDAC RAS feature driver, which adds the sysfs
scrub control interface. The scrub control attributes for a scrub instance are
available to userspace in /sys/bus/edac/devices/<dev-name>/scrub*/.

Generic EDAC scrub driver and the common sysfs scrub interface promotes
unambiguous access from the userspace irrespective of the underlying scrub
devices.

The sysfs scrub attribute nodes would be present only if the client driver
has implemented the corresponding attribute callback function and pass in ops
to the EDAC RAS feature driver during registration.

Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 Documentation/ABI/testing/sysfs-edac-scrub |  69 ++++
 drivers/edac/Makefile                      |   1 +
 drivers/edac/edac_device.c                 |   6 +-
 drivers/edac/edac_scrub.c                  | 377 +++++++++++++++++++++
 include/linux/edac.h                       |  30 ++
 5 files changed, 482 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-edac-scrub
 create mode 100755 drivers/edac/edac_scrub.c

diff --git a/Documentation/ABI/testing/sysfs-edac-scrub b/Documentation/ABI/testing/sysfs-edac-scrub
new file mode 100644
index 000000000000..f465cc91423f
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-edac-scrub
@@ -0,0 +1,69 @@
+What:		/sys/bus/edac/devices/<dev-name>/scrub*
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		The sysfs EDAC bus devices /<dev-name>/scrub* subdirectory
+		belongs to an instance of memory scrub control feature,
+		where <dev-name> directory corresponds to a device/memory
+		region registered with the EDAC scrub driver and thus
+		registered with the generic EDAC RAS driver.
+		The sysfs scrub attr nodes would be present only if the
+		client driver has implemented the corresponding attr
+		callback function and pass in ops to the EDAC RAS feature
+		driver during registration.
+
+What:		/sys/bus/edac/devices/<dev-name>/scrub*/addr_range_base
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RW) The base of the address range of the memory region
+		to be scrubbed (on-demand scrubbing).
+
+What:		/sys/bus/edac/devices/<dev-name>/scrub*/addr_range_size
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RW) The size of the address range of the memory region
+		to be scrubbed (on-demand scrubbing).
+
+What:		/sys/bus/edac/devices/<dev-name>/scrub*/enable_background
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RW) Start/Stop background(patrol) scrubbing if supported.
+
+What:		/sys/bus/edac/devices/<dev-name>/scrub*/enable_on_demand
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RW) Start/Stop on-demand scrubbing the memory region
+		if supported.
+
+What:		/sys/bus/edac/devices/<dev-name>/scrub*/min_cycle_duration
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RO) Supported minimum scrub cycle duration in seconds
+		by the memory scrubber.
+
+What:		/sys/bus/edac/devices/<dev-name>/scrub*/max_cycle_duration
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RO) Supported maximum scrub cycle duration in seconds
+		by the memory scrubber.
+
+What:		/sys/bus/edac/devices/<dev-name>/scrub*/current_cycle_duration
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RW) The current scrub cycle duration in seconds and must be
+		within the supported range by the memory scrubber.
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 4edfb83ffbee..fbf0e39ec678 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_EDAC)			:= edac_core.o
 
 edac_core-y	:= edac_mc.o edac_device.o edac_mc_sysfs.o
 edac_core-y	+= edac_module.o edac_device_sysfs.o wq.o
+edac_core-y	+= edac_scrub.o
 
 edac_core-$(CONFIG_EDAC_DEBUG)		+= debugfs.o
 
diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
index e4a5d010ea2d..6381896b6424 100644
--- a/drivers/edac/edac_device.c
+++ b/drivers/edac/edac_device.c
@@ -608,12 +608,16 @@ static int edac_dev_feat_init(struct device *parent,
 			      const struct edac_dev_feature *ras_feat,
 			      const struct attribute_group **attr_groups)
 {
-	int num;
+	int num, ret;
 
 	switch (ras_feat->ft_type) {
 	case RAS_FEAT_SCRUB:
 		dev_data->scrub_ops = ras_feat->scrub_ops;
 		dev_data->private = ras_feat->ctx;
+		ret = edac_scrub_get_desc(parent, attr_groups,
+					  ras_feat->instance);
+		if (ret)
+			return ret;
 		return 1;
 	case RAS_FEAT_ECS:
 		num = ras_feat->ecs_info.num_media_frus;
diff --git a/drivers/edac/edac_scrub.c b/drivers/edac/edac_scrub.c
new file mode 100755
index 000000000000..3f8f37629acf
--- /dev/null
+++ b/drivers/edac/edac_scrub.c
@@ -0,0 +1,377 @@
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
+enum edac_scrub_attributes {
+	SCRUB_ADDR_RANGE_BASE,
+	SCRUB_ADDR_RANGE_SIZE,
+	SCRUB_ENABLE_BACKGROUND,
+	SCRUB_ENABLE_ON_DEMAND,
+	SCRUB_MIN_CYCLE_DURATION,
+	SCRUB_MAX_CYCLE_DURATION,
+	SCRUB_CURRENT_CYCLE_DURATION,
+	SCRUB_MAX_ATTRS
+};
+
+struct edac_scrub_dev_attr {
+	struct device_attribute dev_attr;
+	u8 instance;
+};
+
+struct edac_scrub_context {
+	char name[EDAC_FEAT_NAME_LEN];
+	struct edac_scrub_dev_attr scrub_dev_attr[SCRUB_MAX_ATTRS];
+	struct attribute *scrub_attrs[SCRUB_MAX_ATTRS + 1];
+	struct attribute_group group;
+};
+
+#define to_scrub_dev_attr(_dev_attr)      \
+		container_of(_dev_attr, struct edac_scrub_dev_attr, dev_attr)
+
+static ssize_t addr_range_base_show(struct device *ras_feat_dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	u8 inst = ((struct edac_scrub_dev_attr *)to_scrub_dev_attr(attr))->instance;
+	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_scrub_ops *ops = ctx->scrub[inst].scrub_ops;
+	u64 base, size;
+	int ret;
+
+	ret = ops->read_range(ras_feat_dev->parent, ctx->scrub[inst].private, &base, &size);
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
+	u8 inst = ((struct edac_scrub_dev_attr *)to_scrub_dev_attr(attr))->instance;
+	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_scrub_ops *ops = ctx->scrub[inst].scrub_ops;
+	u64 base, size;
+	int ret;
+
+	ret = ops->read_range(ras_feat_dev->parent, ctx->scrub[inst].private, &base, &size);
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
+	u8 inst = ((struct edac_scrub_dev_attr *)to_scrub_dev_attr(attr))->instance;
+	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_scrub_ops *ops = ctx->scrub[inst].scrub_ops;
+	u64 base, size;
+	int ret;
+
+	ret = ops->read_range(ras_feat_dev->parent, ctx->scrub[inst].private, &base, &size);
+	if (ret)
+		return ret;
+
+	ret = kstrtou64(buf, 0, &base);
+	if (ret < 0)
+		return ret;
+
+	ret = ops->write_range(ras_feat_dev->parent, ctx->scrub[inst].private, base, size);
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
+	u8 inst = ((struct edac_scrub_dev_attr *)to_scrub_dev_attr(attr))->instance;
+	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_scrub_ops *ops = ctx->scrub[inst].scrub_ops;
+	u64 base, size;
+	int ret;
+
+	ret = ops->read_range(ras_feat_dev->parent, ctx->scrub[inst].private, &base, &size);
+	if (ret)
+		return ret;
+
+	ret = kstrtou64(buf, 0, &size);
+	if (ret < 0)
+		return ret;
+
+	ret = ops->write_range(ras_feat_dev->parent, ctx->scrub[inst].private, base, size);
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
+	u8 inst = ((struct edac_scrub_dev_attr *)to_scrub_dev_attr(attr))->instance;
+	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_scrub_ops *ops = ctx->scrub[inst].scrub_ops;
+	bool enable;
+	int ret;
+
+	ret = kstrtobool(buf, &enable);
+	if (ret < 0)
+		return ret;
+
+	ret = ops->set_enabled_bg(ras_feat_dev->parent, ctx->scrub[inst].private, enable);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static ssize_t enable_background_show(struct device *ras_feat_dev,
+				      struct device_attribute *attr, char *buf)
+{
+	u8 inst = ((struct edac_scrub_dev_attr *)to_scrub_dev_attr(attr))->instance;
+	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_scrub_ops *ops = ctx->scrub[inst].scrub_ops;
+	bool enable;
+	int ret;
+
+	ret = ops->get_enabled_bg(ras_feat_dev->parent, ctx->scrub[inst].private, &enable);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%d\n", enable);
+}
+
+static ssize_t enable_on_demand_show(struct device *ras_feat_dev,
+				     struct device_attribute *attr, char *buf)
+{
+	u8 inst = ((struct edac_scrub_dev_attr *)to_scrub_dev_attr(attr))->instance;
+	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_scrub_ops *ops = ctx->scrub[inst].scrub_ops;
+	bool enable;
+	int ret;
+
+	ret = ops->get_enabled_od(ras_feat_dev->parent, ctx->scrub[inst].private, &enable);
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
+	u8 inst = ((struct edac_scrub_dev_attr *)to_scrub_dev_attr(attr))->instance;
+	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_scrub_ops *ops = ctx->scrub[inst].scrub_ops;
+	bool enable;
+	int ret;
+
+	ret = kstrtobool(buf, &enable);
+	if (ret < 0)
+		return ret;
+
+	ret = ops->set_enabled_od(ras_feat_dev->parent, ctx->scrub[inst].private, enable);
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
+	u8 inst = ((struct edac_scrub_dev_attr *)to_scrub_dev_attr(attr))->instance;
+	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_scrub_ops *ops = ctx->scrub[inst].scrub_ops;
+	u32 val;
+	int ret;
+
+	ret = ops->min_cycle_read(ras_feat_dev->parent, ctx->scrub[inst].private, &val);
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
+	u8 inst = ((struct edac_scrub_dev_attr *)to_scrub_dev_attr(attr))->instance;
+	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_scrub_ops *ops = ctx->scrub[inst].scrub_ops;
+	u32 val;
+	int ret;
+
+	ret = ops->max_cycle_read(ras_feat_dev->parent, ctx->scrub[inst].private, &val);
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
+	u8 inst = ((struct edac_scrub_dev_attr *)to_scrub_dev_attr(attr))->instance;
+	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_scrub_ops *ops = ctx->scrub[inst].scrub_ops;
+	u32 val;
+	int ret;
+
+	ret = ops->cycle_duration_read(ras_feat_dev->parent, ctx->scrub[inst].private, &val);
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
+	u8 inst = ((struct edac_scrub_dev_attr *)to_scrub_dev_attr(attr))->instance;
+	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_scrub_ops *ops = ctx->scrub[inst].scrub_ops;
+	long val;
+	int ret;
+
+	ret = kstrtol(buf, 0, &val);
+	if (ret < 0)
+		return ret;
+
+	ret = ops->cycle_duration_write(ras_feat_dev->parent, ctx->scrub[inst].private, val);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static umode_t scrub_attr_visible(struct kobject *kobj,
+				  struct attribute *a, int attr_id)
+{
+	struct device *ras_feat_dev = kobj_to_dev(kobj);
+	struct device_attribute *dev_attr =
+				container_of(a, struct device_attribute, attr);
+	u8 inst = ((struct edac_scrub_dev_attr *)to_scrub_dev_attr(dev_attr))->instance;
+	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_scrub_ops *ops = ctx->scrub[inst].scrub_ops;
+
+	switch (attr_id) {
+	case SCRUB_ADDR_RANGE_BASE:
+	case SCRUB_ADDR_RANGE_SIZE:
+		if (ops->read_range && ops->write_range)
+			return a->mode;
+		if (ops->read_range)
+			return 0444;
+		return 0;
+	case SCRUB_ENABLE_BACKGROUND:
+		if (ops->get_enabled_bg && ops->set_enabled_bg)
+			return a->mode;
+		if (ops->get_enabled_bg)
+			return 0444;
+		return 0;
+	case SCRUB_ENABLE_ON_DEMAND:
+		if (ops->get_enabled_od && ops->set_enabled_od)
+			return a->mode;
+		if (ops->get_enabled_od)
+			return 0444;
+		return 0;
+	case SCRUB_MIN_CYCLE_DURATION:
+		return ops->min_cycle_read ? a->mode : 0;
+	case SCRUB_MAX_CYCLE_DURATION:
+		return ops->max_cycle_read ? a->mode : 0;
+	case SCRUB_CURRENT_CYCLE_DURATION:
+		if (ops->cycle_duration_read && ops->cycle_duration_write)
+			return a->mode;
+		if (ops->cycle_duration_read)
+			return 0444;
+		return 0;
+	default:
+		return 0;
+	}
+}
+
+#define EDAC_SCRUB_ATTR_RO(_name, _instance)       \
+	((struct edac_scrub_dev_attr) { .dev_attr = __ATTR_RO(_name), \
+				     .instance = _instance })
+
+#define EDAC_SCRUB_ATTR_WO(_name, _instance)       \
+	((struct edac_scrub_dev_attr) { .dev_attr = __ATTR_WO(_name), \
+				     .instance = _instance })
+
+#define EDAC_SCRUB_ATTR_RW(_name, _instance)       \
+	((struct edac_scrub_dev_attr) { .dev_attr = __ATTR_RW(_name), \
+				     .instance = _instance })
+
+static int scrub_create_desc(struct device *scrub_dev,
+			     const struct attribute_group **attr_groups,
+			     u8 instance)
+{
+	struct edac_scrub_context *scrub_ctx;
+	struct attribute_group *group;
+	int i;
+
+	scrub_ctx = devm_kzalloc(scrub_dev, sizeof(*scrub_ctx), GFP_KERNEL);
+	if (!scrub_ctx)
+		return -ENOMEM;
+
+	group = &scrub_ctx->group;
+	scrub_ctx->scrub_dev_attr[0] = EDAC_SCRUB_ATTR_RW(addr_range_base, instance);
+	scrub_ctx->scrub_dev_attr[1] = EDAC_SCRUB_ATTR_RW(addr_range_size, instance);
+	scrub_ctx->scrub_dev_attr[2] = EDAC_SCRUB_ATTR_RW(enable_background, instance);
+	scrub_ctx->scrub_dev_attr[3] = EDAC_SCRUB_ATTR_RW(enable_on_demand, instance);
+	scrub_ctx->scrub_dev_attr[4] = EDAC_SCRUB_ATTR_RO(min_cycle_duration, instance);
+	scrub_ctx->scrub_dev_attr[5] = EDAC_SCRUB_ATTR_RO(max_cycle_duration, instance);
+	scrub_ctx->scrub_dev_attr[6] = EDAC_SCRUB_ATTR_RW(current_cycle_duration, instance);
+	for (i = 0; i < SCRUB_MAX_ATTRS; i++)
+		scrub_ctx->scrub_attrs[i] = &scrub_ctx->scrub_dev_attr[i].dev_attr.attr;
+
+	sprintf(scrub_ctx->name, "%s%d", "scrub", instance);
+	group->name = scrub_ctx->name;
+	group->attrs = scrub_ctx->scrub_attrs;
+	group->is_visible  = scrub_attr_visible;
+
+	attr_groups[0] = group;
+
+	return 0;
+}
+
+/**
+ * edac_scrub_get_desc - get EDAC scrub descriptors
+ * @scrub_dev: client device, with scrub support
+ * @attr_groups: pointer to attrribute group container
+ * @instance: device's scrub instance number.
+ *
+ * Returns 0 on success, error otherwise.
+ */
+int edac_scrub_get_desc(struct device *scrub_dev,
+			const struct attribute_group **attr_groups,
+			u8 instance)
+{
+	if (!scrub_dev || !attr_groups)
+		return -EINVAL;
+
+	return scrub_create_desc(scrub_dev, attr_groups, instance);
+}
diff --git a/include/linux/edac.h b/include/linux/edac.h
index b337254cf5b8..aae8262b9863 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -674,6 +674,36 @@ enum edac_dev_feat {
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
+int edac_scrub_get_desc(struct device *scrub_dev,
+			const struct attribute_group **attr_groups,
+			u8 instance);
+
 struct edac_ecs_ex_info {
 	u16 num_media_frus;
 };
-- 
2.34.1


