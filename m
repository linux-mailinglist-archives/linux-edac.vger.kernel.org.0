Return-Path: <linux-edac+bounces-1672-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5593954F3B
	for <lists+linux-edac@lfdr.de>; Fri, 16 Aug 2024 18:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D939288EB0
	for <lists+linux-edac@lfdr.de>; Fri, 16 Aug 2024 16:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7522D1C7B62;
	Fri, 16 Aug 2024 16:43:56 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F34E1C6895;
	Fri, 16 Aug 2024 16:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723826636; cv=none; b=TB0zdi8vAlouDrSWyUmPxCGo38I5vThwnQ9EbXDOZ7rCgTlyiyn9CzjmtVyWJwuSFRjagWEppVoMmKzoy6kbsF9OiarGunSn9oe+Wm+m4+PT6GEq080cBRTPW4RlvI9JVxTD8Uw8tSbAZWVGrPDewiIYGFbn4dTiWEMJoDMrdCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723826636; c=relaxed/simple;
	bh=sVzXcrXp5WhJqqWZkOgPFyZ05P9iQTRzoYJNjvMnsZE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lK3pgCE82gCZTnVhicunTj8FQYwnRIfzA35YWzRJYA2NGzZ/3llrrJzokOIDuoyH6xmffMNI3jH+fyWpCoLBUUVc+vvnrcy8QzQd34Rw/+c28j5KDdxnM0bE9IJqRy+xILCMSiqtiDrIp4OgRzyHTkqHvm4q0CJYn+J4n56QOWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wlnmj2wm4z6K9P3;
	Sat, 17 Aug 2024 00:40:53 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id A40081400C9;
	Sat, 17 Aug 2024 00:43:51 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.148.43) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 17:43:50 +0100
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
Subject: [PATCH v11 12/14] EDAC: Add EDAC PPR control driver
Date: Fri, 16 Aug 2024 17:42:35 +0100
Message-ID: <20240816164238.1902-13-shiju.jose@huawei.com>
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

Add generic EDAC PPR(Post Package Repair) control driver supports configuring
the memory PPR feature in the system. Supports both sPPR(soft PPR) and
hPPR(hard PPR). The device with PPR feature, get the PPR descriptor from the
EDAC PPR and registers with the EDAC, which adds the sysfs PPR control attributes.
The PPR control attributes are available to the userspace in
/sys/bus/edac/devices/<dev-name>/pprX/

Generic EDAC PPR driver and the common sysfs PPR interface promotes
unambiguous access from the userspace irrespective of the underlying memory
devices with PPR feature supported.

The sysfs PPR attribute nodes would be present only if the client driver
has implemented the corresponding attribute callback functions and pass in ops
to the EDAC during registration.

Note: There are other PPR drivers to come apart from the CXL PPR in this series.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 Documentation/ABI/testing/sysfs-edac-ppr |  69 ++++++
 drivers/edac/Makefile                    |   2 +-
 drivers/edac/edac_device.c               |   6 +
 drivers/edac/edac_ppr.c                  | 255 +++++++++++++++++++++++
 include/linux/edac.h                     |  29 +++
 5 files changed, 360 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-edac-ppr
 create mode 100755 drivers/edac/edac_ppr.c

diff --git a/Documentation/ABI/testing/sysfs-edac-ppr b/Documentation/ABI/testing/sysfs-edac-ppr
new file mode 100644
index 000000000000..af6ccef9661b
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-edac-ppr
@@ -0,0 +1,69 @@
+What:		/sys/bus/edac/devices/<dev-name>/ppr*
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		The sysfs edac bus devices /<dev-name>/ppr* subdirectory
+		belongs to the memory media PPR (Post Package Repair) control
+		feature, where <dev-name> directory corresponds to a device
+		registered with the EDAC PPR driver and thus registered with
+		the generic edac device driver.
+		/ppr* belongs to either sPPR (Soft PPR) or hPPR (Hard PPR)
+		feature for the memory device.
+		The sysfs PPR attr nodes would be only present if PPR is
+		supported.
+
+What:		/sys/bus/edac/devices/<dev-name>/ppr*/persist_mode_avail
+Date:		Oct 2024
+KernelVersion:	6.12For e.g. HBM, DDR.
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RO) persist PPR modes supported in the device.
+		For e.g. Hard PPR(hPPR) for a permanent row repair,
+		Soft PPR(sPPR) for a temporary row repair.
+
+What:		/sys/bus/edac/devices/<dev-name>/ppr*/persist_mode
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RW) Current persist PPR mode.
+
+What:		/sys/bus/edac/devices/<dev-name>/ppr*/dpa_support
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RO) True if supports DPA for PPR maintenance operation.
+
+What:		/sys/bus/edac/devices/<dev-name>/ppr*/ppr_safe_when_in_use
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RO) True if memory media is accessible and data is retained
+		during the PPR operation.
+
+What:		/sys/bus/edac/devices/<dev-name>/ppr*/repair_hpa
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(WO) Start the PPR operation for the HPA (host physical
+		address) set. Return failure if resources are not available
+		to perform repair.
+
+What:		/sys/bus/edac/devices/<dev-name>/ppr*/repair_dpa
+Date:		Oct 2024
+KernelVersion:	6.12
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(WO) Starts the PPR operation for the DPA(device physical
+		address) set. Return failure if resources are not available
+                to perform repair.
+		In some states of system configuration (e.g. before address decoders
+		have been configured), memory devices (e.g. CXL) may not have an
+		active mapping in the main host address physical address map.
+		As such, the memory to repair must be identified by a device
+		specific physical addressing scheme using a DPA. The DPA to use
+		will be presented in related error records.
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 4645e4032523..4e8e94fbea6a 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -10,7 +10,7 @@ obj-$(CONFIG_EDAC)			:= edac_core.o
 
 edac_core-y	:= edac_mc.o edac_device.o edac_mc_sysfs.o
 edac_core-y	+= edac_module.o edac_device_sysfs.o wq.o
-edac_core-y	+= edac_scrub.o edac_ecs.o
+edac_core-y	+= edac_scrub.o edac_ecs.o edac_ppr.o
 
 edac_core-$(CONFIG_EDAC_DEBUG)		+= debugfs.o
 
diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
index 17e7ded01b22..6d6599c0659d 100644
--- a/drivers/edac/edac_device.c
+++ b/drivers/edac/edac_device.c
@@ -626,6 +626,12 @@ static int edac_dev_feat_init(struct device *parent,
 	case RAS_FEAT_PPR:
 		dev_data->ppr_ops = ras_feat->ppr_ops;
 		dev_data->private = ras_feat->ppr_ctx;
+
+		ret = edac_ppr_get_desc(parent, attr_groups,
+					ras_feat->instance);
+		if (ret)
+			return ret;
+
 		return 1;
 	default:
 		return -EINVAL;
diff --git a/drivers/edac/edac_ppr.c b/drivers/edac/edac_ppr.c
new file mode 100755
index 000000000000..dab2ba0a8145
--- /dev/null
+++ b/drivers/edac/edac_ppr.c
@@ -0,0 +1,255 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Generic EDAC PPR driver supports controlling the memory
+ * device with Post Package Repair (PPR) feature in the system
+ * and the common sysfs PPR control interface promotes unambiguous
+ * access from the userspace.
+ *
+ * Copyright (c) 2024 HiSilicon Limited.
+ */
+
+#define pr_fmt(fmt)     "EDAC PPR: " fmt
+
+#include <linux/edac.h>
+
+enum edac_ppr_attributes {
+	PPR_PERSIST_MODE_AVAIL,
+	PPR_PERSIST_MODE,
+	PPR_DPA_SUPPORT,
+	PPR_SAFE_IN_USE,
+	PPR_HPA,
+	PPR_DPA,
+	PPR_MAX_ATTRS
+};
+
+struct edac_ppr_dev_attr {
+	struct device_attribute dev_attr;
+	u8 instance;
+};
+
+struct edac_ppr_context {
+	char name[EDAC_FEAT_NAME_LEN];
+	struct edac_ppr_dev_attr ppr_dev_attr[PPR_MAX_ATTRS];
+	struct attribute *ppr_attrs[PPR_MAX_ATTRS + 1];
+	struct attribute_group group;
+};
+
+#define to_ppr_dev_attr(_dev_attr)      \
+		container_of(_dev_attr, struct edac_ppr_dev_attr, dev_attr)
+
+static ssize_t persist_mode_avail_show(struct device *ras_feat_dev,
+				       struct device_attribute *attr, char *buf)
+{
+	u8 inst = ((struct edac_ppr_dev_attr *)to_ppr_dev_attr(attr))->instance;
+	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_ppr_ops *ops = ctx->ppr[inst].ppr_ops;
+
+	return ops->get_persist_mode_avail(ras_feat_dev->parent,
+					   ctx->ppr[inst].private, buf);
+}
+
+static ssize_t persist_mode_show(struct device *ras_feat_dev,
+				 struct device_attribute *attr, char *buf)
+{
+	u8 inst = ((struct edac_ppr_dev_attr *)to_ppr_dev_attr(attr))->instance;
+	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_ppr_ops *ops = ctx->ppr[inst].ppr_ops;
+	u32 mode;
+	int ret;
+
+	ret = ops->get_persist_mode(ras_feat_dev->parent, ctx->ppr[inst].private, &mode);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%u\n", mode);
+}
+
+static ssize_t persist_mode_store(struct device *ras_feat_dev,
+				  struct device_attribute *attr,
+				  const char *buf,
+				  size_t len)
+{
+	u8 inst = ((struct edac_ppr_dev_attr *)to_ppr_dev_attr(attr))->instance;
+	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_ppr_ops *ops = ctx->ppr[inst].ppr_ops;
+	long mode;
+	int ret;
+
+	ret = kstrtol(buf, 0, &mode);
+	if (ret < 0)
+		return ret;
+
+	ret = ops->set_persist_mode(ras_feat_dev->parent, ctx->ppr[inst].private, mode);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static ssize_t dpa_support_show(struct device *ras_feat_dev,
+				struct device_attribute *attr, char *buf)
+{
+	u8 inst = ((struct edac_ppr_dev_attr *)to_ppr_dev_attr(attr))->instance;
+	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_ppr_ops *ops = ctx->ppr[inst].ppr_ops;
+	int ret;
+	u32 val;
+
+	ret = ops->get_dpa_support(ras_feat_dev->parent, ctx->ppr[inst].private, &val);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%u\n", val);
+}
+
+static ssize_t ppr_safe_when_in_use_show(struct device *ras_feat_dev,
+					 struct device_attribute *attr, char *buf)
+{
+	u8 inst = ((struct edac_ppr_dev_attr *)to_ppr_dev_attr(attr))->instance;
+	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_ppr_ops *ops = ctx->ppr[inst].ppr_ops;
+	int ret;
+	u32 val;
+
+	ret = ops->get_ppr_safe_when_in_use(ras_feat_dev->parent,
+					    ctx->ppr[inst].private, &val);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%u\n", val);
+}
+
+static ssize_t repair_hpa_store(struct device *ras_feat_dev,
+				struct device_attribute *attr,
+				const char *buf, size_t len)
+{
+	u8 inst = ((struct edac_ppr_dev_attr *)to_ppr_dev_attr(attr))->instance;
+	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_ppr_ops *ops = ctx->ppr[inst].ppr_ops;
+	u64 hpa;
+	int ret;
+
+	ret = kstrtou64(buf, 0, &hpa);
+	if (ret < 0)
+		return ret;
+
+	ret = ops->do_ppr(ras_feat_dev->parent, ctx->ppr[inst].private, true, hpa);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static ssize_t repair_dpa_store(struct device *ras_feat_dev,
+				struct device_attribute *attr,
+				const char *buf, size_t len)
+{
+	u8 inst = ((struct edac_ppr_dev_attr *)to_ppr_dev_attr(attr))->instance;
+	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_ppr_ops *ops = ctx->ppr[inst].ppr_ops;
+	u64 dpa;
+	int ret;
+
+	ret = kstrtou64(buf, 0, &dpa);
+	if (ret < 0)
+		return ret;
+
+	ret = ops->do_ppr(ras_feat_dev->parent, ctx->ppr[inst].private, 0, dpa);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static umode_t ppr_attr_visible(struct kobject *kobj,
+				struct attribute *a, int attr_id)
+{
+	struct device *ras_feat_dev = kobj_to_dev(kobj);
+	struct device_attribute *dev_attr =
+				container_of(a, struct device_attribute, attr);
+	u8 inst = ((struct edac_ppr_dev_attr *)to_ppr_dev_attr(dev_attr))->instance;
+	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	const struct edac_ppr_ops *ops = ctx->ppr[inst].ppr_ops;
+
+	switch (attr_id) {
+	case PPR_PERSIST_MODE_AVAIL:
+		return ops->get_persist_mode_avail ? a->mode : 0;
+	case PPR_PERSIST_MODE:
+		if (ops->get_persist_mode && ops->set_persist_mode)
+			return a->mode;
+		if (ops->get_persist_mode)
+			return 0444;
+		return 0;
+	case PPR_DPA_SUPPORT:
+		return ops->get_dpa_support ? a->mode : 0;
+	case PPR_SAFE_IN_USE:
+		return ops->get_ppr_safe_when_in_use ? a->mode : 0;
+	case PPR_HPA:
+	case PPR_DPA:
+		return ops->do_ppr ? a->mode : 0;
+	default:
+		return 0;
+	}
+}
+
+#define EDAC_PPR_ATTR_RO(_name, _instance)       \
+	((struct edac_ppr_dev_attr) { .dev_attr = __ATTR_RO(_name), \
+				     .instance = _instance })
+
+#define EDAC_PPR_ATTR_WO(_name, _instance)       \
+	((struct edac_ppr_dev_attr) { .dev_attr = __ATTR_WO(_name), \
+				     .instance = _instance })
+
+#define EDAC_PPR_ATTR_RW(_name, _instance)       \
+	((struct edac_ppr_dev_attr) { .dev_attr = __ATTR_RW(_name), \
+				     .instance = _instance })
+
+static int ppr_create_desc(struct device *ppr_dev,
+			   const struct attribute_group **attr_groups,
+			   u8 instance)
+{
+	struct edac_ppr_context *ppr_ctx;
+	struct attribute_group *group;
+	int i;
+
+	ppr_ctx = devm_kzalloc(ppr_dev, sizeof(*ppr_ctx), GFP_KERNEL);
+	if (!ppr_ctx)
+		return -ENOMEM;
+
+	group = &ppr_ctx->group;
+	ppr_ctx->ppr_dev_attr[0] = EDAC_PPR_ATTR_RO(persist_mode_avail, instance);
+	ppr_ctx->ppr_dev_attr[1] = EDAC_PPR_ATTR_RW(persist_mode, instance);
+	ppr_ctx->ppr_dev_attr[2] = EDAC_PPR_ATTR_RO(dpa_support, instance);
+	ppr_ctx->ppr_dev_attr[3] = EDAC_PPR_ATTR_RO(ppr_safe_when_in_use, instance);
+	ppr_ctx->ppr_dev_attr[4] = EDAC_PPR_ATTR_WO(repair_hpa, instance);
+	ppr_ctx->ppr_dev_attr[5] = EDAC_PPR_ATTR_WO(repair_dpa, instance);
+	for (i = 0; i < PPR_MAX_ATTRS; i++)
+		ppr_ctx->ppr_attrs[i] = &ppr_ctx->ppr_dev_attr[i].dev_attr.attr;
+
+	sprintf(ppr_ctx->name, "%s%d", "ppr", instance);
+	group->name = ppr_ctx->name;
+	group->attrs = ppr_ctx->ppr_attrs;
+	group->is_visible  = ppr_attr_visible;
+
+	attr_groups[0] = group;
+
+	return 0;
+}
+
+/**
+ * edac_ppr_get_desc - get edac PPR descriptors
+ * @ppr_dev: client PPR device
+ * @attr_groups: pointer to attrribute group container
+ * @instance: device's PPR instance number.
+ *
+ * Returns 0 on success, error otherwise.
+ */
+int edac_ppr_get_desc(struct device *ppr_dev,
+		      const struct attribute_group **attr_groups,
+		      u8 instance)
+{
+	if (!ppr_dev || !attr_groups)
+		return -EINVAL;
+
+	return ppr_create_desc(ppr_dev, attr_groups, instance);
+}
diff --git a/include/linux/edac.h b/include/linux/edac.h
index 86fc4ee97f20..9154fa64eb67 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -739,6 +739,35 @@ int edac_ecs_get_desc(struct device *ecs_dev,
 		      const struct attribute_group **attr_groups,
 		      u16 num_media_frus);
 
+enum edac_ppr_type {
+	EDAC_TYPE_SPPR, /* soft PPR */
+	EDAC_TYPE_HPPR, /* hard PPR */
+};
+
+/**
+ * struct edac_ppr_ops - PPR(Post Package Repair) device operations
+ * (all elements optional)
+ * @get_persist_mode_avail: get the persist modes supported in the device.
+ * @get_persist_mode: get the persist mode of the PPR instance.
+ * @set_persist_mode: set the persist mode for the PPR instance.
+ * @get_dpa_support: get dpa support flag.
+ * @get_ppr_safe_when_in_use: get whether memory media is accessible and
+ *			       data is retained during PPR operation.
+ * @do_ppr: start PPR operation for the HPA/DPA set.
+ */
+struct edac_ppr_ops {
+	int (*get_persist_mode_avail)(struct device *dev, void *drv_data, char *buf);
+	int (*get_persist_mode)(struct device *dev, void *drv_data, u32 *mode);
+	int (*set_persist_mode)(struct device *dev, void *drv_data, u32 mode);
+	int (*get_dpa_support)(struct device *dev, void *drv_data, u32 *val);
+	int (*get_ppr_safe_when_in_use)(struct device *dev, void *drv_data, u32 *val);
+	int (*do_ppr)(struct device *dev, void *drv_data, bool hpa, u64 pa);
+};
+
+int edac_ppr_get_desc(struct device *ppr_dev,
+		      const struct attribute_group **attr_groups,
+		      u8 instance);
+
 /*
  * EDAC device feature information structure
  */
-- 
2.34.1


