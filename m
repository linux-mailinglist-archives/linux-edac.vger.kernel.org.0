Return-Path: <linux-edac+bounces-2389-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B81899B8D85
	for <lists+linux-edac@lfdr.de>; Fri,  1 Nov 2024 10:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 774192834A9
	for <lists+linux-edac@lfdr.de>; Fri,  1 Nov 2024 09:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAAC15B122;
	Fri,  1 Nov 2024 09:18:00 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBE2155CBF;
	Fri,  1 Nov 2024 09:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730452680; cv=none; b=O9FDoWIKdCTSy34qIN9MtNFQid51sxIqTrp1TRQ/1viEpqbtwPBchn0i1DMZNSwhc58/p2M65Ynlur+HJ65ztCKt6tAPxtMEq12HLM/CM0gwW3PTZXwU3zBWIx9WSN5a98PlhZeTmt4IbRuOKTkZppRUaByhmzoMIsPsFWEjDtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730452680; c=relaxed/simple;
	bh=0RyB3jB13rhyVCQ4K2OaA478+YPalRz4vmTgmBY/DnA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=reJto9UD9FFROoV8lNHhZcJdN3Rt9HBmOTHogNVYivG/ZFZWzgg/eMItP4t6DEpeeVMw7LSnZgN/yB0IarWLHhw830mp+FpsFncGdD15mEW2aoChYDFoqtLXFr2k2aohpNpnfFLiOlsqbeAz9lDwUp4M9TbwFPuA373m2AgJA3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XfwBN6VWHz6L71V;
	Fri,  1 Nov 2024 17:13:00 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id B3BF41404FC;
	Fri,  1 Nov 2024 17:17:54 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.171.129) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 10:17:52 +0100
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
Subject: [PATCH v15 02/15] EDAC: Add scrub control feature
Date: Fri, 1 Nov 2024 09:17:20 +0000
Message-ID: <20241101091735.1465-3-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20241101091735.1465-1-shiju.jose@huawei.com>
References: <20241101091735.1465-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Add a generic EDAC scrub control to manage memory scrubbers in the system.
Devices with a scrub feature register with the EDAC device driver, which
retrieves the scrub descriptor from the EDAC scrub driver and exposes the
sysfs scrub control attributes for a scrub instance to userspace at
/sys/bus/edac/devices/<dev-name>/scrubX/.

The common sysfs scrub control interface abstracts the control of
arbitrary scrubbing functionality into a common set of functions. The
sysfs scrub attribute nodes are only present if the client driver has
implemented the corresponding attribute callback function and passed the
operations(ops) to the EDAC device driver during registration.

Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 Documentation/ABI/testing/sysfs-edac-scrub |  74 ++++++++
 drivers/edac/Makefile                      |   1 +
 drivers/edac/edac_device.c                 |  40 +++-
 drivers/edac/scrub.c                       | 209 +++++++++++++++++++++
 include/linux/edac.h                       |  34 ++++
 5 files changed, 354 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-edac-scrub
 create mode 100755 drivers/edac/scrub.c

diff --git a/Documentation/ABI/testing/sysfs-edac-scrub b/Documentation/ABI/testing/sysfs-edac-scrub
new file mode 100644
index 000000000000..d8d11165ff2a
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-edac-scrub
@@ -0,0 +1,74 @@
+What:		/sys/bus/edac/devices/<dev-name>/scrubX
+Date:		Jan 2025
+KernelVersion:	6.13
+Contact:	linux-edac@vger.kernel.org
+Description:
+		The sysfs EDAC bus devices /<dev-name>/scrubX subdirectory
+		belongs to an instance of memory scrub control feature,
+		where <dev-name> directory corresponds to a device/memory
+		region registered with the EDAC device driver for the
+		scrub control feature.
+		The sysfs scrub attr nodes are only present if the parent
+		driver has implemented the corresponding attr callback
+		function and provided the necessary operations to the EDAC
+		device driver during registration.
+
+What:		/sys/bus/edac/devices/<dev-name>/scrubX/addr
+Date:		Jan 2025
+KernelVersion:	6.13
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RW) The base address of the memory region to be scrubbed
+		for on-demand scrubbing. Setting address would start
+		scrubbing. The size must be set before that.
+		The readback addr value would be non-zero if the requested
+		on-demand scrubbing is in progress, zero otherwise.
+
+What:		/sys/bus/edac/devices/<dev-name>/scrubX/size
+Date:		Jan 2025
+KernelVersion:	6.13
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RW) The size of the memory region to be scrubbed
+		(on-demand scrubbing).
+
+What:		/sys/bus/edac/devices/<dev-name>/scrubX/enable_background
+Date:		Jan 2025
+KernelVersion:	6.13
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RW) Start/Stop background(patrol) scrubbing if supported.
+
+What:		/sys/bus/edac/devices/<dev-name>/scrubX/enable_on_demand
+Date:		Jan 2025
+KernelVersion:	6.13
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RW) Start/Stop on-demand scrubbing the memory region
+		if supported.
+
+What:		/sys/bus/edac/devices/<dev-name>/scrubX/min_cycle_duration
+Date:		Jan 2025
+KernelVersion:	6.13
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RO) Supported minimum scrub cycle duration in seconds
+		by the memory scrubber.
+
+What:		/sys/bus/edac/devices/<dev-name>/scrubX/max_cycle_duration
+Date:		Jan 2025
+KernelVersion:	6.13
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RO) Supported maximum scrub cycle duration in seconds
+		by the memory scrubber.
+
+What:		/sys/bus/edac/devices/<dev-name>/scrubX/current_cycle_duration
+Date:		Jan 2025
+KernelVersion:	6.13
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RW) The current scrub cycle duration in seconds and must be
+		within the supported range by the memory scrubber.
+		Scrub has an overhead when running and that may want to be
+		reduced by taking longer to do it.
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index faf310eec4a6..188501e676c7 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_EDAC)			:= edac_core.o
 
 edac_core-y	:= edac_mc.o edac_device.o edac_mc_sysfs.o
 edac_core-y	+= edac_module.o edac_device_sysfs.o wq.o
+edac_core-y	+= scrub.o
 
 edac_core-$(CONFIG_EDAC_DEBUG)		+= debugfs.o
 
diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
index e9229b5f8afe..cd700a64406e 100644
--- a/drivers/edac/edac_device.c
+++ b/drivers/edac/edac_device.c
@@ -576,6 +576,7 @@ static void edac_dev_release(struct device *dev)
 {
 	struct edac_dev_feat_ctx *ctx = container_of(dev, struct edac_dev_feat_ctx, dev);
 
+	kfree(ctx->scrub);
 	kfree(ctx->dev.groups);
 	kfree(ctx);
 }
@@ -609,6 +610,8 @@ int edac_dev_register(struct device *parent, char *name,
 		      const struct edac_dev_feature *ras_features)
 {
 	const struct attribute_group **ras_attr_groups;
+	int scrub_cnt = 0, scrub_inst = 0;
+	struct edac_dev_data *dev_data;
 	struct edac_dev_feat_ctx *ctx;
 	int attr_gcnt = 0;
 	int ret, feat;
@@ -619,7 +622,10 @@ int edac_dev_register(struct device *parent, char *name,
 	/* Double parse to make space for attributes */
 	for (feat = 0; feat < num_features; feat++) {
 		switch (ras_features[feat].ft_type) {
-		/* Add feature specific code */
+		case RAS_FEAT_SCRUB:
+			attr_gcnt++;
+			scrub_cnt++;
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -635,13 +641,37 @@ int edac_dev_register(struct device *parent, char *name,
 		goto ctx_free;
 	}
 
+	if (scrub_cnt) {
+		ctx->scrub = kcalloc(scrub_cnt, sizeof(*ctx->scrub), GFP_KERNEL);
+		if (!ctx->scrub) {
+			ret = -ENOMEM;
+			goto groups_free;
+		}
+	}
+
 	attr_gcnt = 0;
 	for (feat = 0; feat < num_features; feat++, ras_features++) {
 		switch (ras_features->ft_type) {
-		/* Add feature specific code */
+		case RAS_FEAT_SCRUB:
+			if (!ras_features->scrub_ops ||
+			    scrub_inst != ras_features->instance)
+				goto data_mem_free;
+
+			dev_data = &ctx->scrub[scrub_inst];
+			dev_data->instance = scrub_inst;
+			dev_data->scrub_ops = ras_features->scrub_ops;
+			dev_data->private = ras_features->ctx;
+			ret = edac_scrub_get_desc(parent, &ras_attr_groups[attr_gcnt],
+						  ras_features->instance);
+			if (ret)
+				goto data_mem_free;
+
+			scrub_inst++;
+			attr_gcnt++;
+			break;
 		default:
 			ret = -EINVAL;
-			goto groups_free;
+			goto data_mem_free;
 		}
 	}
 
@@ -654,7 +684,7 @@ int edac_dev_register(struct device *parent, char *name,
 
 	ret = dev_set_name(&ctx->dev, name);
 	if (ret)
-		goto groups_free;
+		goto data_mem_free;
 
 	ret = device_register(&ctx->dev);
 	if (ret) {
@@ -664,6 +694,8 @@ int edac_dev_register(struct device *parent, char *name,
 
 	return devm_add_action_or_reset(parent, edac_dev_unreg, &ctx->dev);
 
+data_mem_free:
+	kfree(ctx->scrub);
 groups_free:
 	kfree(ras_attr_groups);
 ctx_free:
diff --git a/drivers/edac/scrub.c b/drivers/edac/scrub.c
new file mode 100755
index 000000000000..3978201c4bfc
--- /dev/null
+++ b/drivers/edac/scrub.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * The generic EDAC scrub driver controls the memory scrubbers in the
+ * system. The common sysfs scrub interface abstracts the control of
+ * various arbitrary scrubbing functionalities into a unified set of
+ * functions.
+ *
+ * Copyright (c) 2024 HiSilicon Limited.
+ */
+
+#include <linux/edac.h>
+
+enum edac_scrub_attributes {
+	SCRUB_ADDRESS,
+	SCRUB_SIZE,
+	SCRUB_ENABLE_BACKGROUND,
+	SCRUB_MIN_CYCLE_DURATION,
+	SCRUB_MAX_CYCLE_DURATION,
+	SCRUB_CUR_CYCLE_DURATION,
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
+#define TO_SCRUB_DEV_ATTR(_dev_attr)      \
+		container_of(_dev_attr, struct edac_scrub_dev_attr, dev_attr)
+
+#define EDAC_SCRUB_ATTR_SHOW(attrib, cb, type, format)				\
+static ssize_t attrib##_show(struct device *ras_feat_dev,			\
+			     struct device_attribute *attr, char *buf)		\
+{										\
+	u8 inst = TO_SCRUB_DEV_ATTR(attr)->instance;				\
+	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);		\
+	const struct edac_scrub_ops *ops = ctx->scrub[inst].scrub_ops;		\
+	type data;								\
+	int ret;								\
+										\
+	ret = ops->cb(ras_feat_dev->parent, ctx->scrub[inst].private, &data);	\
+	if (ret)								\
+		return ret;							\
+										\
+	return sysfs_emit(buf, format, data);					\
+}
+
+EDAC_SCRUB_ATTR_SHOW(addr, read_addr, u64, "0x%llx\n")
+EDAC_SCRUB_ATTR_SHOW(size, read_size, u64, "0x%llx\n")
+EDAC_SCRUB_ATTR_SHOW(enable_background, get_enabled_bg, bool, "%u\n")
+EDAC_SCRUB_ATTR_SHOW(min_cycle_duration, get_min_cycle, u32, "%u\n")
+EDAC_SCRUB_ATTR_SHOW(max_cycle_duration, get_max_cycle, u32, "%u\n")
+EDAC_SCRUB_ATTR_SHOW(current_cycle_duration, get_cycle_duration, u32, "%u\n")
+
+#define EDAC_SCRUB_ATTR_STORE(attrib, cb, type, conv_func)			\
+static ssize_t attrib##_store(struct device *ras_feat_dev,			\
+			      struct device_attribute *attr,			\
+			      const char *buf, size_t len)			\
+{										\
+	u8 inst = TO_SCRUB_DEV_ATTR(attr)->instance;				\
+	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);		\
+	const struct edac_scrub_ops *ops = ctx->scrub[inst].scrub_ops;		\
+	type data;								\
+	int ret;								\
+										\
+	ret = conv_func(buf, 0, &data);						\
+	if (ret < 0)								\
+		return ret;							\
+										\
+	ret = ops->cb(ras_feat_dev->parent, ctx->scrub[inst].private, data);	\
+	if (ret)								\
+		return ret;							\
+										\
+	return len;								\
+}
+
+EDAC_SCRUB_ATTR_STORE(addr, write_addr, u64, kstrtou64)
+EDAC_SCRUB_ATTR_STORE(size, write_size, u64, kstrtou64)
+EDAC_SCRUB_ATTR_STORE(enable_background, set_enabled_bg, unsigned long, kstrtoul)
+EDAC_SCRUB_ATTR_STORE(current_cycle_duration, set_cycle_duration, unsigned long, kstrtoul)
+
+static umode_t scrub_attr_visible(struct kobject *kobj, struct attribute *a, int attr_id)
+{
+	struct device *ras_feat_dev = kobj_to_dev(kobj);
+	struct device_attribute *dev_attr = container_of(a, struct device_attribute, attr);
+	u8 inst = TO_SCRUB_DEV_ATTR(dev_attr)->instance;
+	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_scrub_ops *ops = ctx->scrub[inst].scrub_ops;
+
+	switch (attr_id) {
+	case SCRUB_ADDRESS:
+		if (ops->read_addr) {
+			if (ops->write_addr)
+				return a->mode;
+			else
+				return 0444;
+		}
+		break;
+	case SCRUB_SIZE:
+		if (ops->read_size) {
+			if (ops->write_size)
+				return a->mode;
+			else
+				return 0444;
+		}
+		break;
+	case SCRUB_ENABLE_BACKGROUND:
+		if (ops->get_enabled_bg) {
+			if (ops->set_enabled_bg)
+				return a->mode;
+			else
+				return 0444;
+		}
+		break;
+	case SCRUB_MIN_CYCLE_DURATION:
+		if (ops->get_min_cycle)
+			return a->mode;
+		break;
+	case SCRUB_MAX_CYCLE_DURATION:
+		if (ops->get_max_cycle)
+			return a->mode;
+		break;
+	case SCRUB_CUR_CYCLE_DURATION:
+		if (ops->get_cycle_duration) {
+			if (ops->set_cycle_duration)
+				return a->mode;
+			else
+				return 0444;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+#define EDAC_SCRUB_ATTR_RO(_name, _instance)       \
+	((struct edac_scrub_dev_attr) { .dev_attr = __ATTR_RO(_name), \
+					.instance = _instance })
+
+#define EDAC_SCRUB_ATTR_WO(_name, _instance)       \
+	((struct edac_scrub_dev_attr) { .dev_attr = __ATTR_WO(_name), \
+					.instance = _instance })
+
+#define EDAC_SCRUB_ATTR_RW(_name, _instance)       \
+	((struct edac_scrub_dev_attr) { .dev_attr = __ATTR_RW(_name), \
+					.instance = _instance })
+
+static int scrub_create_desc(struct device *scrub_dev,
+			     const struct attribute_group **attr_groups, u8 instance)
+{
+	struct edac_scrub_context *scrub_ctx;
+	struct attribute_group *group;
+	int i;
+	struct edac_scrub_dev_attr dev_attr[] = {
+		[SCRUB_ADDRESS] = EDAC_SCRUB_ATTR_RW(addr, instance),
+		[SCRUB_SIZE] = EDAC_SCRUB_ATTR_RW(size, instance),
+		[SCRUB_ENABLE_BACKGROUND] = EDAC_SCRUB_ATTR_RW(enable_background, instance),
+		[SCRUB_MIN_CYCLE_DURATION] = EDAC_SCRUB_ATTR_RO(min_cycle_duration, instance),
+		[SCRUB_MAX_CYCLE_DURATION] = EDAC_SCRUB_ATTR_RO(max_cycle_duration, instance),
+		[SCRUB_CUR_CYCLE_DURATION] = EDAC_SCRUB_ATTR_RW(current_cycle_duration, instance)
+	};
+
+	scrub_ctx = devm_kzalloc(scrub_dev, sizeof(*scrub_ctx), GFP_KERNEL);
+	if (!scrub_ctx)
+		return -ENOMEM;
+
+	group = &scrub_ctx->group;
+	for (i = 0; i < SCRUB_MAX_ATTRS; i++) {
+		memcpy(&scrub_ctx->scrub_dev_attr[i], &dev_attr[i], sizeof(dev_attr[i]));
+		scrub_ctx->scrub_attrs[i] = &scrub_ctx->scrub_dev_attr[i].dev_attr.attr;
+	}
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
+ * @attr_groups: pointer to attribute group container
+ * @instance: device's scrub instance number.
+ *
+ * Return:
+ *  * %0	- Success.
+ *  * %-EINVAL	- Invalid parameters passed.
+ *  * %-ENOMEM	- Dynamic memory allocation failed.
+ */
+int edac_scrub_get_desc(struct device *scrub_dev,
+			const struct attribute_group **attr_groups, u8 instance)
+{
+	if (!scrub_dev || !attr_groups)
+		return -EINVAL;
+
+	return scrub_create_desc(scrub_dev, attr_groups, instance);
+}
diff --git a/include/linux/edac.h b/include/linux/edac.h
index e19706311ec0..3620a09c0476 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -668,11 +668,43 @@ static inline struct dimm_info *edac_get_dimm(struct mem_ctl_info *mci,
 
 /* RAS feature type */
 enum edac_dev_feat {
+	RAS_FEAT_SCRUB,
 	RAS_FEAT_MAX
 };
 
+/**
+ * struct edac_scrub_ops - scrub device operations (all elements optional)
+ * @read_addr: read base address of scrubbing range.
+ * @read_size: read offset of scrubbing range.
+ * @write_addr: set base address of the scrubbing range.
+ * @write_size: set offset of the scrubbing range.
+ * @get_enabled_bg: check if currently performing background scrub.
+ * @set_enabled_bg: start or stop a bg-scrub.
+ * @get_min_cycle: get minimum supported scrub cycle duration in seconds.
+ * @get_max_cycle: get maximum supported scrub cycle duration in seconds.
+ * @get_cycle_duration: get current scrub cycle duration in seconds.
+ * @set_cycle_duration: set current scrub cycle duration in seconds.
+ */
+struct edac_scrub_ops {
+	int (*read_addr)(struct device *dev, void *drv_data, u64 *base);
+	int (*read_size)(struct device *dev, void *drv_data, u64 *size);
+	int (*write_addr)(struct device *dev, void *drv_data, u64 base);
+	int (*write_size)(struct device *dev, void *drv_data, u64 size);
+	int (*get_enabled_bg)(struct device *dev, void *drv_data, bool *enable);
+	int (*set_enabled_bg)(struct device *dev, void *drv_data, bool enable);
+	int (*get_min_cycle)(struct device *dev, void *drv_data,  u32 *min);
+	int (*get_max_cycle)(struct device *dev, void *drv_data,  u32 *max);
+	int (*get_cycle_duration)(struct device *dev, void *drv_data, u32 *cycle);
+	int (*set_cycle_duration)(struct device *dev, void *drv_data, u32 cycle);
+};
+
+int edac_scrub_get_desc(struct device *scrub_dev,
+			const struct attribute_group **attr_groups,
+			u8 instance);
+
 /* EDAC device feature information structure */
 struct edac_dev_data {
+	const struct edac_scrub_ops *scrub_ops;
 	u8 instance;
 	void *private;
 };
@@ -680,11 +712,13 @@ struct edac_dev_data {
 struct edac_dev_feat_ctx {
 	struct device dev;
 	void *private;
+	struct edac_dev_data *scrub;
 };
 
 struct edac_dev_feature {
 	enum edac_dev_feat ft_type;
 	u8 instance;
+	const struct edac_scrub_ops *scrub_ops;
 	void *ctx;
 };
 
-- 
2.34.1


