Return-Path: <linux-edac+bounces-664-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4AE861422
	for <lists+linux-edac@lfdr.de>; Fri, 23 Feb 2024 15:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CAE91F23F6A
	for <lists+linux-edac@lfdr.de>; Fri, 23 Feb 2024 14:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DC18174C;
	Fri, 23 Feb 2024 14:37:48 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE783224CE;
	Fri, 23 Feb 2024 14:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699068; cv=none; b=o71kfP3xvwVPbjZgYWwffPIDBLel68PbGEyGGbUtOd08MZeL6khGDYMidFoy3gz6XYI74mAOys9BqA45vlO/FXiEN8k58Fg8Un1p5zYAS5nlAkzMXCHxzZjqQRnsle3/42DSL5jRtAvh+/lhWXB4teGz66x4T1O1oZJt6N7yO0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699068; c=relaxed/simple;
	bh=XVi0maVuiogDBDfKVbIQ89BIxmQt5lblSNwWWLxTDH8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MSaGRLHEKUXGnGD7p1zTwA98Te5IoQtgUkLzUpc+lxz8XbxD/kCVqE6/26pvN5Z/O8CpwSKNJ3i05I1uAeLNnQDokWVxKkPAKAp84uYQWYji0vGmPvc4iCRyKFcBlKf0HcmsmgnIg5PqjPvwwmst1vNBmismUp5ZJoNO7E1H2bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ThCDG0Hlcz6JB0V;
	Fri, 23 Feb 2024 22:33:18 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id AA539140B33;
	Fri, 23 Feb 2024 22:37:43 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 14:37:42 +0000
From: <shiju.jose@huawei.com>
To: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-mm@kvack.org>, <dan.j.williams@intel.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>
CC: <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<david@redhat.com>, <Vilas.Sridharan@amd.com>, <leo.duran@amd.com>,
	<Yazen.Ghannam@amd.com>, <rientjes@google.com>, <jiaqiyan@google.com>,
	<tony.luck@intel.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <naoya.horiguchi@nec.com>,
	<james.morse@arm.com>, <jthoughton@google.com>, <somasundaram.a@hpe.com>,
	<erdemaktas@google.com>, <pgonda@google.com>, <duenwen@google.com>,
	<mike.malvestuto@intel.com>, <gthelen@google.com>,
	<wschwartz@amperecomputing.com>, <dferguson@amperecomputing.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH v7 06/12] memory: scrub: Add scrub subsystem driver supports configuring memory scrubs in the system
Date: Fri, 23 Feb 2024 22:37:17 +0800
Message-ID: <20240223143723.1574-7-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20240223143723.1574-1-shiju.jose@huawei.com>
References: <20240223143723.1574-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500006.china.huawei.com (7.191.161.198)

From: Shiju Jose <shiju.jose@huawei.com>

Add scrub driver supports configuring the memory scrubs in the system.
The scrub driver provides the interface for registering the scrub devices
and supports configuring memory scrubs in the system.
Driver exposes the sysfs scrub control attributes to the user in
/sys/class/scrub/scrubX/regionN/

ToDo: The unit of the scrub rate may vary depends on the scrub
      devices, feedback is to either standardise it or provide
      an interface for it to the userspace. 

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 .../ABI/testing/sysfs-class-scrub-configure   |  91 +++++
 drivers/memory/Kconfig                        |   1 +
 drivers/memory/Makefile                       |   1 +
 drivers/memory/scrub/Kconfig                  |  11 +
 drivers/memory/scrub/Makefile                 |   6 +
 drivers/memory/scrub/memory-scrub.c           | 369 ++++++++++++++++++
 include/memory/memory-scrub.h                 |  79 ++++
 7 files changed, 558 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-scrub-configure
 create mode 100644 drivers/memory/scrub/Kconfig
 create mode 100644 drivers/memory/scrub/Makefile
 create mode 100755 drivers/memory/scrub/memory-scrub.c
 create mode 100755 include/memory/memory-scrub.h

diff --git a/Documentation/ABI/testing/sysfs-class-scrub-configure b/Documentation/ABI/testing/sysfs-class-scrub-configure
new file mode 100644
index 000000000000..d2d422b667cf
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-scrub-configure
@@ -0,0 +1,91 @@
+What:		/sys/class/scrub/
+Date:		January 2024
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		The scrub/ class subdirectory belongs to the
+		scrubber subsystem.
+
+What:		/sys/class/scrub/scrubX/
+Date:		January 2024
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		The /sys/class/scrub/scrub{0,1,2,3,...} directories
+		correspond to each scrub device.
+
+What:		/sys/class/scrub/scrubX/name
+Date:		January 2024
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RO) name of the memory scrub device
+
+What:		/sys/class/scrub/scrubX/regionN/
+Date:		January 2024
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		The /sys/class/scrub/scrubX/region{0,1,2,3,...}
+		directories correspond to each scrub region under a scrub device.
+		Scrub region is a physical address range for which scrub may be
+		separately controlled. Regions may overlap in which case the
+		scrubbing rate of the overlapped memory will be at least that
+		expected due to each overlapping region.
+
+What:		/sys/class/scrub/scrubX/regionN/addr_base
+Date:		January 2024
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RW) The base of the address range of the memory region
+		to be scrubbed.
+		On reading, returns the base of the memory region for
+		the actual address range(The platform calculates
+		the nearest patrol scrub boundary address from where
+		it can start scrub).
+
+What:		/sys/class/scrub/scrubX/regionN/addr_size
+Date:		January 2024
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RW) The size of the address range to be scrubbed.
+		On reading, returns the size of the memory region for
+		the actual address range.
+
+What:		/sys/class/scrub/scrubX/regionN/enable
+Date:		January 2024
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(WO) Enable/Disable scrub the memory region.
+		1 - enable the memory scrub.
+		0 - disable the memory scrub.
+
+What:		/sys/class/scrub/scrubX/regionN/enable_background_scrub
+Date:		January 2024
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(WO) Enable/Disable background scrubbing if supported.
+		1 - enable background scrubbing.
+		0 - disable background scrubbing.
+
+What:		/sys/class/scrub/scrubX/regionN/rate_available
+Date:		January 2024
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RO) Supported range for the scrub rate)
+		by the scrubber for a memory region.
+		The unit of the scrub rate vary depends on the scrub.
+
+What:		/sys/class/scrub/scrubX/regionN/rate
+Date:		January 2024
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RW) The scrub rate in the memory region specified
+		and it must be with in the supported range by the scrub.
+		The unit of the scrub rate vary depends on the scrub.
diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index 8efdd1f97139..d2e015c09d83 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -227,5 +227,6 @@ config STM32_FMC2_EBI
 
 source "drivers/memory/samsung/Kconfig"
 source "drivers/memory/tegra/Kconfig"
+source "drivers/memory/scrub/Kconfig"
 
 endif
diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
index d2e6ca9abbe0..4b37312cb342 100644
--- a/drivers/memory/Makefile
+++ b/drivers/memory/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_STM32_FMC2_EBI)	+= stm32-fmc2-ebi.o
 
 obj-$(CONFIG_SAMSUNG_MC)	+= samsung/
 obj-$(CONFIG_TEGRA_MC)		+= tegra/
+obj-$(CONFIG_SCRUB)		+= scrub/
 obj-$(CONFIG_TI_EMIF_SRAM)	+= ti-emif-sram.o
 obj-$(CONFIG_FPGA_DFL_EMIF)	+= dfl-emif.o
 
diff --git a/drivers/memory/scrub/Kconfig b/drivers/memory/scrub/Kconfig
new file mode 100644
index 000000000000..fa7d68f53a69
--- /dev/null
+++ b/drivers/memory/scrub/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Memory scrub driver configurations
+#
+
+config SCRUB
+	bool "Memory scrub driver"
+	help
+	  This option selects the memory scrub subsystem, supports
+	  configuring the parameters of underlying scrubbers in the
+	  system for the DRAM memories.
diff --git a/drivers/memory/scrub/Makefile b/drivers/memory/scrub/Makefile
new file mode 100644
index 000000000000..1b677132ca13
--- /dev/null
+++ b/drivers/memory/scrub/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for memory scrub drivers
+#
+
+obj-$(CONFIG_SCRUB)		+= memory-scrub.o
diff --git a/drivers/memory/scrub/memory-scrub.c b/drivers/memory/scrub/memory-scrub.c
new file mode 100755
index 000000000000..99ecc784baa1
--- /dev/null
+++ b/drivers/memory/scrub/memory-scrub.c
@@ -0,0 +1,369 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Memory scrub driver supports configuring
+ * the memory scrubs.
+ *
+ * Copyright (c) 2023 HiSilicon Limited.
+ */
+
+#define pr_fmt(fmt)     "MEM SCRUB: " fmt
+
+#include <linux/acpi.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/kfifo.h>
+#include <linux/spinlock.h>
+#include <memory/memory-scrub.h>
+
+/* memory scrubber config definitions */
+#define SCRUB_ID_PREFIX "scrub"
+#define SCRUB_ID_FORMAT SCRUB_ID_PREFIX "%d"
+#define SCRUB_DEV_MAX_NAME_LENGTH	128
+#define SCRUB_MAX_SYSFS_ATTR_NAME_LENGTH	64
+
+static DEFINE_IDA(scrub_ida);
+
+struct scrub_device {
+	char name[SCRUB_DEV_MAX_NAME_LENGTH];
+	int id;
+	struct device dev;
+	char region_name[SCRUB_MAX_SYSFS_ATTR_NAME_LENGTH];
+	int region_id;
+	struct attribute_group group;
+	const struct attribute_group *groups[2];
+	const struct scrub_ops *ops;
+};
+
+#define to_scrub_device(d) container_of(d, struct scrub_device, dev)
+
+static ssize_t name_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%s\n", to_scrub_device(dev)->name);
+}
+static DEVICE_ATTR_RO(name);
+
+static struct attribute *scrub_dev_attrs[] = {
+	&dev_attr_name.attr,
+	NULL
+};
+
+static umode_t scrub_dev_attr_is_visible(struct kobject *kobj,
+					 struct attribute *attr, int n)
+{
+	if (attr != &dev_attr_name.attr)
+		return 0;
+
+	return attr->mode;
+}
+
+static const struct attribute_group scrub_dev_attr_group = {
+	.attrs		= scrub_dev_attrs,
+	.is_visible	= scrub_dev_attr_is_visible,
+};
+
+static const struct attribute_group *scrub_dev_attr_groups[] = {
+	&scrub_dev_attr_group,
+	NULL
+};
+
+static void scrub_dev_release(struct device *dev)
+{
+	struct scrub_device *scrub_dev = to_scrub_device(dev);
+
+	ida_free(&scrub_ida, scrub_dev->id);
+	kfree(scrub_dev);
+}
+
+static struct class scrub_class = {
+	.name = "scrub",
+	.dev_groups = scrub_dev_attr_groups,
+	.dev_release = scrub_dev_release,
+};
+
+static umode_t scrub_attr_visible(struct kobject *kobj,
+				  struct attribute *a, int attr_id)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct scrub_device *scrub_dev = to_scrub_device(dev);
+	int region_id = scrub_dev->region_id;
+
+	if (!scrub_dev->ops)
+		return 0;
+
+	return scrub_dev->ops->is_visible(dev, attr_id, a->mode, region_id);
+}
+
+static ssize_t scrub_attr_show(struct device *dev, int attr_id,
+			       char *buf)
+{
+	struct scrub_device *scrub_dev = to_scrub_device(dev);
+	int region_id = scrub_dev->region_id;
+	int ret;
+	u64 val;
+
+	ret = scrub_dev->ops->read(dev, attr_id, region_id, &val);
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buf, "%lld\n", val);
+}
+
+static ssize_t scrub_attr_show_hex(struct device *dev, int attr_id,
+				   char *buf)
+{
+	struct scrub_device *scrub_dev = to_scrub_device(dev);
+	int region_id = scrub_dev->region_id;
+	int ret;
+	u64 val;
+
+	ret = scrub_dev->ops->read(dev, attr_id, region_id, &val);
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buf, "0x%llx\n", val);
+}
+
+static ssize_t scrub_attr_show_string(struct device *dev, int attr_id,
+				      char *buf)
+{
+	struct scrub_device *scrub_dev = to_scrub_device(dev);
+	int region_id = scrub_dev->region_id;
+	int ret;
+
+	ret = scrub_dev->ops->read_string(dev, attr_id, region_id, buf);
+	if (ret < 0)
+		return ret;
+
+	return strlen(buf);
+}
+
+static ssize_t scrub_attr_store(struct device *dev, int attr_id,
+				const char *buf, size_t count)
+{
+	struct scrub_device *scrub_dev = to_scrub_device(dev);
+	int region_id = scrub_dev->region_id;
+	long val;
+	int ret;
+
+	ret = kstrtol(buf, 10, &val);
+	if (ret < 0)
+		return ret;
+
+	ret = scrub_dev->ops->write(dev, attr_id, region_id, val);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static ssize_t scrub_attr_store_hex(struct device *dev, int attr_id,
+				    const char *buf, size_t count)
+{
+	struct scrub_device *scrub_dev = to_scrub_device(dev);
+	int region_id = scrub_dev->region_id;
+	int ret;
+	u64 val;
+
+	ret = kstrtou64(buf, 16, &val);
+	if (ret < 0)
+		return ret;
+
+	ret = scrub_dev->ops->write(dev, attr_id, region_id, val);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static ssize_t show_scrub_attr(struct device *dev, char *buf, int attr_id)
+{
+	switch (attr_id) {
+	case scrub_addr_base:
+	case scrub_addr_size:
+		return scrub_attr_show_hex(dev, attr_id, buf);
+	case scrub_enable:
+	case scrub_rate:
+		return scrub_attr_show(dev, attr_id, buf);
+	case scrub_rate_available:
+		return scrub_attr_show_string(dev, attr_id, buf);
+	}
+
+	return -EOPNOTSUPP;
+}
+
+static ssize_t store_scrub_attr(struct device *dev, const char *buf,
+				size_t count, int attr_id)
+{
+	switch (attr_id) {
+	case scrub_addr_base:
+	case scrub_addr_size:
+		return scrub_attr_store_hex(dev, attr_id, buf, count);
+	case scrub_enable:
+	case scrub_enable_background_scrub:
+	case scrub_rate:
+		return scrub_attr_store(dev, attr_id, buf, count);
+	}
+
+	return -EOPNOTSUPP;
+}
+
+#define SCRUB_ATTR_RW(attr)						\
+static ssize_t attr##_show(struct device *dev,				\
+			   struct device_attribute *attr, char *buf)	\
+{									\
+	return show_scrub_attr(dev, buf, (scrub_##attr));	\
+}									\
+static ssize_t attr##_store(struct device *dev,			\
+			    struct device_attribute *attr,		\
+			    const char *buf, size_t count)		\
+{									\
+	return store_scrub_attr(dev, buf, count, (scrub_##attr));\
+}									\
+static DEVICE_ATTR_RW(attr)
+
+#define SCRUB_ATTR_RO(attr)						\
+static ssize_t attr##_show(struct device *dev,				\
+			   struct device_attribute *attr, char *buf)	\
+{									\
+	return show_scrub_attr(dev, buf, (scrub_##attr));	\
+}									\
+static DEVICE_ATTR_RO(attr)
+
+#define SCRUB_ATTR_WO(attr)						\
+static ssize_t attr##_store(struct device *dev,			\
+			    struct device_attribute *attr,		\
+			    const char *buf, size_t count)		\
+{									\
+	return store_scrub_attr(dev, buf, count, (scrub_##attr));\
+}									\
+static DEVICE_ATTR_WO(attr)
+
+SCRUB_ATTR_RW(addr_base);
+SCRUB_ATTR_RW(addr_size);
+SCRUB_ATTR_RW(enable);
+SCRUB_ATTR_RW(enable_background_scrub);
+SCRUB_ATTR_RW(rate);
+SCRUB_ATTR_RO(rate_available);
+
+static struct attribute *scrub_attrs[] = {
+	&dev_attr_addr_base.attr,
+	&dev_attr_addr_size.attr,
+	&dev_attr_enable.attr,
+	&dev_attr_enable_background_scrub.attr,
+	&dev_attr_rate.attr,
+	&dev_attr_rate_available.attr,
+	NULL
+};
+
+static struct device *
+scrub_device_register(struct device *dev, const char *name, void *drvdata,
+		      const struct scrub_ops *ops,
+		      int region_id,
+		      struct attribute_group *attr_group)
+{
+	struct scrub_device *scrub_dev;
+	struct device *hdev;
+	int err;
+
+	scrub_dev = kzalloc(sizeof(*scrub_dev), GFP_KERNEL);
+	if (!scrub_dev)
+		return ERR_PTR(-ENOMEM);
+	hdev = &scrub_dev->dev;
+
+	scrub_dev->id = ida_alloc(&scrub_ida, GFP_KERNEL);
+	if (scrub_dev->id < 0) {
+		kfree(scrub_dev);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	snprintf((char *)scrub_dev->region_name, SCRUB_MAX_SYSFS_ATTR_NAME_LENGTH,
+		 "region%d", region_id);
+
+	/* attr_group - external scrub attribute group if the scrub control
+	 * attributes of the scrub device are different from the common
+	 * 'scrub_attrs' defined here.
+	 */
+	if (attr_group) {
+		attr_group->name = (char *)scrub_dev->region_name;
+		scrub_dev->groups[0] = attr_group;
+	} else {
+		scrub_dev->group.name = (char *)scrub_dev->region_name;
+		scrub_dev->group.attrs = scrub_attrs;
+		scrub_dev->group.is_visible = scrub_attr_visible;
+		scrub_dev->groups[0] = &scrub_dev->group;
+		scrub_dev->ops = ops;
+	}
+	scrub_dev->region_id = region_id;
+
+	hdev->groups = scrub_dev->groups;
+	hdev->class = &scrub_class;
+	hdev->parent = dev;
+	dev_set_drvdata(hdev, drvdata);
+	dev_set_name(hdev, SCRUB_ID_FORMAT, scrub_dev->id);
+	snprintf(scrub_dev->name, SCRUB_DEV_MAX_NAME_LENGTH, "%s", name);
+	err = device_register(hdev);
+	if (err) {
+		put_device(hdev);
+		return ERR_PTR(err);
+	}
+
+	return hdev;
+}
+
+static void devm_scrub_release(void *dev)
+{
+	device_unregister(dev);
+}
+
+/**
+ * devm_scrub_device_register - register hw scrubber device
+ * @dev: the parent device
+ * @name: hw scrubber name attribute
+ * @drvdata: driver data to attach to created device
+ * @ops: pointer to scrub_ops structure (optional)
+ * @region_id: region ID
+ * @attr_group: input attribute group (optional)
+ *
+ * Returns the pointer to the new device. The new device is automatically
+ * unregistered with the parent device.
+ */
+struct device *
+devm_scrub_device_register(struct device *dev, const char *name,
+			   void *drvdata,
+			   const struct scrub_ops *ops,
+			   int region_id,
+			   struct attribute_group *attr_group)
+{
+	struct device *hdev;
+	int ret;
+
+	if (!dev || !name)
+		return ERR_PTR(-EINVAL);
+
+	hdev = scrub_device_register(dev, name, drvdata, ops,
+				     region_id, attr_group);
+	if (IS_ERR(hdev))
+		return hdev;
+
+	ret = devm_add_action_or_reset(dev, devm_scrub_release, hdev);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return hdev;
+}
+EXPORT_SYMBOL_GPL(devm_scrub_device_register);
+
+static int __init memory_scrub_control_init(void)
+{
+	int err;
+
+	err = class_register(&scrub_class);
+	if (err) {
+		pr_err("couldn't register memory scrub control sysfs class\n");
+		return err;
+	}
+
+	return 0;
+}
+subsys_initcall(memory_scrub_control_init);
diff --git a/include/memory/memory-scrub.h b/include/memory/memory-scrub.h
new file mode 100755
index 000000000000..1bb139d16042
--- /dev/null
+++ b/include/memory/memory-scrub.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Memory scrub controller driver support to configure
+ * the controls of the memory scrub and enable.
+ *
+ * Copyright (c) 2023 HiSilicon Limited.
+ */
+
+#ifndef __MEMORY_SCRUB_H
+#define __MEMORY_SCRUB_H
+
+#include <linux/types.h>
+
+enum scrub_types {
+	scrub_common,
+	scrub_max
+};
+
+enum scrub_attributes {
+	scrub_addr_base,
+	scrub_addr_size,
+	scrub_enable,
+	scrub_enable_background_scrub,
+	scrub_rate,
+	scrub_rate_available,
+	max_attrs
+};
+
+/**
+ * struct scrub_ops - scrub device operations
+ * @is_visible: Callback to return attribute visibility. Mandatory.
+ *		Parameters are:
+ *		@dev:	pointer to hardware scrub device
+ *		@attr:	scrub attribute
+ *		@mode:  default attr mode
+ *		@region_id: memory region id
+ *		The function returns the file permissions.
+ *		If the return value is 0, no attribute will be created.
+ * @read:	Read callback for data attributes. Mandatory if readable
+ *		data attributes are present.
+ *		Parameters are:
+ *		@dev:	pointer to hardware scrub device
+ *		@attr:	scrub attribute
+ *		@region_id:
+ *			memory region id
+ *		@val:	pointer to returned value
+ *		The function returns 0 on success or a negative error number.
+ * @read_string: Read callback for string attributes. Mandatory if string
+ *		attributes are present.
+ *		Parameters are:
+ *		@dev:	pointer to hardware scrub device
+ *		@attr:	scrub attribute
+ *		@region_id:
+ *			memory region id
+ *		@buf:	pointer to buffer to copy string
+ *		The function returns 0 on success or a negative error number.
+ * @write:	Write callback for data attributes. Mandatory if writeable
+ *		data attributes are present.
+ *		Parameters are:
+ *		@dev:	pointer to hardware scrub device
+ *		@attr:	scrub attribute
+ *		@region_id:
+ *			memory region id
+ *		@val:	value to write
+ *		The function returns 0 on success or a negative error number.
+ */
+struct scrub_ops {
+	umode_t (*is_visible)(struct device *dev, u32 attr, umode_t mode, int region_id);
+	int (*read)(struct device *dev, u32 attr, int region_id, u64 *val);
+	int (*read_string)(struct device *dev, u32 attr, int region_id, char *buf);
+	int (*write)(struct device *dev, u32 attr, int region_id, u64 val);
+};
+
+struct device *
+devm_scrub_device_register(struct device *dev, const char *name,
+			   void *drvdata, const struct scrub_ops *ops,
+			   int region_id,
+			   struct attribute_group *attr_group);
+#endif /* __MEMORY_SCRUB_H */
-- 
2.34.1


