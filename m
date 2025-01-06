Return-Path: <linux-edac+bounces-2800-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 093FFA024F3
	for <lists+linux-edac@lfdr.de>; Mon,  6 Jan 2025 13:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 596CB188630F
	for <lists+linux-edac@lfdr.de>; Mon,  6 Jan 2025 12:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80E51DE893;
	Mon,  6 Jan 2025 12:11:48 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A693A1DE4F0;
	Mon,  6 Jan 2025 12:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736165508; cv=none; b=RLmMNJi0GScIXyHzr/FebjRRaPI2sdzTSTYWuNEcO7SxAE8wHD+6QEda5A8KXh2w3iIgzwEQ7F3mg9hJ4WJFFrmHqh+HtsQKIcUPj9g8HYTGgJ/RH0DJQOJllwxcCQOHXGFv2yUf3OcFURTcUuK89NO7nn5sWtpw6cREYkGuhEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736165508; c=relaxed/simple;
	bh=hr48c2aKWn2sb79JlUxbmNm/QHwdNCQN5RcEgeJmvFA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MVBetiwQnjt7lLfNt1VhUVach4obK5/f7dbTi1Lsy3ZpnF16m8m0r7eIoJ1ibIcEAnrsi5/XN8CbvYlfkviFg7qxCWxJ0/kcuyNK66SL/qJ3b9dXx2nI8eTaElkDfh6fKqcVuTsJ7R5etwcaIKyXzNJKYc0g8RxQnivGQDO6DlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YRY0z2TW1z6FGmV;
	Mon,  6 Jan 2025 20:10:43 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id BD5F214022E;
	Mon,  6 Jan 2025 20:11:44 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.170.95) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 6 Jan 2025 13:11:42 +0100
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
	<duenwen@google.com>, <gthelen@google.com>, <wschwartz@amperecomputing.com>,
	<dferguson@amperecomputing.com>, <wbs@os.amperecomputing.com>,
	<nifan.cxl@gmail.com>, <yazen.ghannam@amd.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <roberto.sassu@huawei.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v18 08/19] cxl: Add skeletal features driver
Date: Mon, 6 Jan 2025 12:10:04 +0000
Message-ID: <20250106121017.1620-9-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250106121017.1620-1-shiju.jose@huawei.com>
References: <20250106121017.1620-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Dave Jiang <dave.jiang@intel.com>

Add the basic bits of a features driver to handle all CXL feature related
services.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/Kconfig         |  8 +++++
 drivers/cxl/Makefile        |  3 ++
 drivers/cxl/core/Makefile   |  1 +
 drivers/cxl/core/core.h     |  1 +
 drivers/cxl/core/features.c | 71 +++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/port.c     |  3 ++
 drivers/cxl/cxl.h           |  1 +
 drivers/cxl/features.c      | 44 +++++++++++++++++++++++
 drivers/cxl/pci.c           | 19 ++++++++++
 include/cxl/features.h      | 23 ++++++++++++
 include/cxl/mailbox.h       |  3 ++
 tools/testing/cxl/Kbuild    |  1 +
 12 files changed, 178 insertions(+)
 create mode 100644 drivers/cxl/core/features.c
 create mode 100644 drivers/cxl/features.c
 create mode 100644 include/cxl/features.h

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 876469e23f7a..0bc6a2cb8474 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -146,4 +146,12 @@ config CXL_REGION_INVALIDATION_TEST
 	  If unsure, or if this kernel is meant for production environments,
 	  say N.
 
+config CXL_FEATURES
+	tristate "CXL: Features support"
+	default CXL_BUS
+	help
+	  Enable CXL features support that are tied to a CXL mailbox.
+
+	  If unsure say 'y'.
+
 endif
diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index 2caa90fa4bf2..4696fc218df4 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -7,15 +7,18 @@
 # - 'mem' and 'pmem' before endpoint drivers so that memdevs are
 #   immediately enabled
 # - 'pci' last, also mirrors the hardware enumeration hierarchy
+# - 'features' comes after pci device is enumerated
 obj-y += core/
 obj-$(CONFIG_CXL_PORT) += cxl_port.o
 obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
 obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
 obj-$(CONFIG_CXL_MEM) += cxl_mem.o
 obj-$(CONFIG_CXL_PCI) += cxl_pci.o
+obj-$(CONFIG_CXL_FEATURES) += cxl_features.o
 
 cxl_port-y := port.o
 cxl_acpi-y := acpi.o
 cxl_pmem-y := pmem.o security.o
 cxl_mem-y := mem.o
 cxl_pci-y := pci.o
+cxl_features-y := features.o
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 9259bcc6773c..73b6348afd67 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -14,5 +14,6 @@ cxl_core-y += pci.o
 cxl_core-y += hdm.o
 cxl_core-y += pmu.o
 cxl_core-y += cdat.o
+cxl_core-y += features.o
 cxl_core-$(CONFIG_TRACING) += trace.o
 cxl_core-$(CONFIG_CXL_REGION) += region.o
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 23761340e65c..e8a3df226643 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -9,6 +9,7 @@
 extern const struct device_type cxl_nvdimm_bridge_type;
 extern const struct device_type cxl_nvdimm_type;
 extern const struct device_type cxl_pmu_type;
+extern const struct device_type cxl_features_type;
 
 extern struct attribute_group cxl_base_attribute_group;
 
diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
new file mode 100644
index 000000000000..eb6eb191a32e
--- /dev/null
+++ b/drivers/cxl/core/features.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2024-2025 Intel Corporation. All rights reserved. */
+#include <linux/device.h>
+#include "cxl.h"
+#include "core.h"
+
+#define CXL_FEATURE_MAX_DEVS 65536
+static DEFINE_IDA(cxl_features_ida);
+
+static void cxl_features_release(struct device *dev)
+{
+	struct cxl_features *features = to_cxl_features(dev);
+
+	ida_free(&cxl_features_ida, features->id);
+	kfree(features);
+}
+
+static void remove_features_dev(void *dev)
+{
+	device_unregister(dev);
+}
+
+const struct device_type cxl_features_type = {
+	.name = "features",
+	.release = cxl_features_release,
+};
+EXPORT_SYMBOL_NS_GPL(cxl_features_type, "CXL");
+
+struct cxl_features *cxl_features_alloc(struct cxl_mailbox *cxl_mbox,
+					struct device *parent)
+{
+	struct device *dev;
+	int rc;
+
+	struct cxl_features *features __free(kfree) =
+		kzalloc(sizeof(*features), GFP_KERNEL);
+	if (!features)
+		return ERR_PTR(-ENOMEM);
+
+	rc = ida_alloc_max(&cxl_features_ida, CXL_FEATURE_MAX_DEVS - 1,
+			   GFP_KERNEL);
+	if (rc < 0)
+		return ERR_PTR(rc);
+
+	features->id = rc;
+	features->cxl_mbox = cxl_mbox;
+	dev = &features->dev;
+	device_initialize(dev);
+	device_set_pm_not_required(dev);
+	dev->parent = parent;
+	dev->bus = &cxl_bus_type;
+	dev->type = &cxl_features_type;
+	rc = dev_set_name(dev, "features%d", features->id);
+	if (rc)
+		goto err;
+
+	rc = device_add(dev);
+	if (rc)
+		goto err;
+
+	rc = devm_add_action_or_reset(parent, remove_features_dev, dev);
+	if (rc)
+		goto err;
+
+	return no_free_ptr(features);
+
+err:
+	put_device(dev);
+	return ERR_PTR(rc);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_features_alloc, "CXL");
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 78a5c2c25982..cc53a597cae6 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -74,6 +74,9 @@ static int cxl_device_id(const struct device *dev)
 		return CXL_DEVICE_REGION;
 	if (dev->type == &cxl_pmu_type)
 		return CXL_DEVICE_PMU;
+	if (dev->type == &cxl_features_type)
+		return CXL_DEVICE_FEATURES;
+
 	return 0;
 }
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f6015f24ad38..ee29d1a1c8df 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -855,6 +855,7 @@ void cxl_driver_unregister(struct cxl_driver *cxl_drv);
 #define CXL_DEVICE_PMEM_REGION		7
 #define CXL_DEVICE_DAX_REGION		8
 #define CXL_DEVICE_PMU			9
+#define CXL_DEVICE_FEATURES		10
 
 #define MODULE_ALIAS_CXL(type) MODULE_ALIAS("cxl:t" __stringify(type) "*")
 #define CXL_MODALIAS_FMT "cxl:t%d"
diff --git a/drivers/cxl/features.c b/drivers/cxl/features.c
new file mode 100644
index 000000000000..93b16b5e2b68
--- /dev/null
+++ b/drivers/cxl/features.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2024,2025 Intel Corporation. All rights reserved. */
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <cxl/features.h>
+
+#include "cxl.h"
+
+static int cxl_features_probe(struct device *dev)
+{
+	struct cxl_features *features = to_cxl_features(dev);
+	struct cxl_features_state *cfs __free(kfree) =
+		kzalloc(sizeof(*cfs), GFP_KERNEL);
+
+	if (!cfs)
+		return -ENOMEM;
+
+	cfs->features = features;
+	dev_set_drvdata(dev, no_free_ptr(cfs));
+
+	return 0;
+}
+
+static void cxl_features_remove(struct device *dev)
+{
+	struct cxl_features_state *cfs = dev_get_drvdata(dev);
+
+	kfree(cfs);
+}
+
+static struct cxl_driver cxl_features_driver = {
+	.name = "cxl_features",
+	.probe = cxl_features_probe,
+	.remove = cxl_features_remove,
+	.id = CXL_DEVICE_FEATURES,
+};
+
+module_cxl_driver(cxl_features_driver);
+
+MODULE_DESCRIPTION("CXL: Features");
+MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS("CXL");
+MODULE_ALIAS_CXL(CXL_DEVICE_FEATURES);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 6d94ff4a4f1a..eb68dd3f8b21 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -386,6 +386,21 @@ static int cxl_pci_mbox_send(struct cxl_mailbox *cxl_mbox,
 	return rc;
 }
 
+static int cxl_pci_setup_features(struct cxl_memdev_state *mds)
+{
+	struct cxl_dev_state *cxlds = &mds->cxlds;
+	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
+	struct cxl_features *features;
+
+	features = cxl_features_alloc(cxl_mbox, cxlds->dev);
+	if (IS_ERR(features))
+		return PTR_ERR(features);
+
+	cxl_mbox->features = features;
+
+	return 0;
+}
+
 static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
 {
 	struct cxl_dev_state *cxlds = &mds->cxlds;
@@ -980,6 +995,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
+	rc = cxl_pci_setup_features(mds);
+	if (rc)
+		return rc;
+
 	rc = cxl_set_timestamp(mds);
 	if (rc)
 		return rc;
diff --git a/include/cxl/features.h b/include/cxl/features.h
new file mode 100644
index 000000000000..b92da1e92780
--- /dev/null
+++ b/include/cxl/features.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2024-2025 Intel Corporation. */
+#ifndef __CXL_FEATURES_H__
+#define __CXL_FEATURES_H__
+
+struct cxl_mailbox;
+
+struct cxl_features {
+	int id;
+	struct device dev;
+	struct cxl_mailbox *cxl_mbox;
+};
+#define to_cxl_features(dev) container_of(dev, struct cxl_features, dev)
+
+struct cxl_features_state {
+	struct cxl_features *features;
+	int num_features;
+};
+
+struct cxl_features *cxl_features_alloc(struct cxl_mailbox *cxl_mbox,
+					struct device *parent);
+
+#endif
diff --git a/include/cxl/mailbox.h b/include/cxl/mailbox.h
index cc894f07a435..6caab0d406ba 100644
--- a/include/cxl/mailbox.h
+++ b/include/cxl/mailbox.h
@@ -3,6 +3,7 @@
 #ifndef __CXL_MBOX_H__
 #define __CXL_MBOX_H__
 #include <linux/rcuwait.h>
+#include <cxl/features.h>
 #include <uapi/linux/cxl_mem.h>
 
 /**
@@ -50,6 +51,7 @@ struct cxl_mbox_cmd {
  *                (CXL 3.1 8.2.8.4.3 Mailbox Capabilities Register)
  * @mbox_mutex: mutex protects device mailbox and firmware
  * @mbox_wait: rcuwait for mailbox
+ * @features: pointer to cxl_features device
  * @mbox_send: @dev specific transport for transmitting mailbox commands
  */
 struct cxl_mailbox {
@@ -59,6 +61,7 @@ struct cxl_mailbox {
 	size_t payload_size;
 	struct mutex mbox_mutex; /* lock to protect mailbox context */
 	struct rcuwait mbox_wait;
+	struct cxl_features *features;
 	int (*mbox_send)(struct cxl_mailbox *cxl_mbox, struct cxl_mbox_cmd *cmd);
 };
 
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index b1256fee3567..79de943841f4 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -61,6 +61,7 @@ cxl_core-y += $(CXL_CORE_SRC)/pci.o
 cxl_core-y += $(CXL_CORE_SRC)/hdm.o
 cxl_core-y += $(CXL_CORE_SRC)/pmu.o
 cxl_core-y += $(CXL_CORE_SRC)/cdat.o
+cxl_core-y += $(CXL_CORE_SRC)/features.o
 cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
 cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
 cxl_core-y += config_check.o
-- 
2.43.0


