Return-Path: <linux-edac+bounces-2794-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DEBA024DD
	for <lists+linux-edac@lfdr.de>; Mon,  6 Jan 2025 13:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 120BA1885D60
	for <lists+linux-edac@lfdr.de>; Mon,  6 Jan 2025 12:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C281DDC1C;
	Mon,  6 Jan 2025 12:11:36 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A711DBB38;
	Mon,  6 Jan 2025 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736165496; cv=none; b=I04Qo9S6F384zWK090DmSG4tjNQNxEKBGIxPLjFfKWapAQIDud0BwuGcz5nSZerd7ezmuCSetkg+W69ctCZ5t8zmiXe+tyUxFLgfygrsYd8DEZfafe8yKpmoTeLbkFqk/cU/6BV+VMOGg6ie6duPkHlzbsig+IerfS/6esSKId8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736165496; c=relaxed/simple;
	bh=AeJE/aFbvOs/tf9pBoWbwcBF7oA1ie224ZdA/zPupGs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uhRlIJrNul2a1O2Zz2JE8vVhOOEF3C3y1iUtKv5KTq74bcX1DmG4mOgkY/ddQzWCCUFTspb5++l+whEmRJ6xwoJ4qx9dzYYazYEFw7q5aEqBkz1t7uBIhMhpdWqJp1UH3/4gE47AJ6aq8qjm2j0n6zo+0TQZ/NFVj6yC15UFHAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YRY011nDdz6LD7n;
	Mon,  6 Jan 2025 20:09:53 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 093691408F9;
	Mon,  6 Jan 2025 20:11:25 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.170.95) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 6 Jan 2025 13:11:22 +0100
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
Subject: [PATCH v18 01/19] EDAC: Add support for EDAC device features control
Date: Mon, 6 Jan 2025 12:09:57 +0000
Message-ID: <20250106121017.1620-2-shiju.jose@huawei.com>
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

From: Shiju Jose <shiju.jose@huawei.com>

Add generic EDAC device feature controls supporting the registration
of RAS features available in the system. The driver exposes control
attributes for these features to userspace in
/sys/bus/edac/devices/<dev-name>/<ras-feature>/

Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 Documentation/edac/features.rst |  94 ++++++++++++++++++++++++++++++
 Documentation/edac/index.rst    |  10 ++++
 drivers/edac/edac_device.c      | 100 ++++++++++++++++++++++++++++++++
 include/linux/edac.h            |  28 +++++++++
 4 files changed, 232 insertions(+)
 create mode 100644 Documentation/edac/features.rst
 create mode 100644 Documentation/edac/index.rst

diff --git a/Documentation/edac/features.rst b/Documentation/edac/features.rst
new file mode 100644
index 000000000000..f32f259ce04d
--- /dev/null
+++ b/Documentation/edac/features.rst
@@ -0,0 +1,94 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============================================
+Augmenting EDAC for controlling RAS features
+============================================
+
+Copyright (c) 2024 HiSilicon Limited.
+
+:Author:   Shiju Jose <shiju.jose@huawei.com>
+:License:  The GNU Free Documentation License, Version 1.2
+          (dual licensed under the GPL v2)
+:Original Reviewers:
+
+- Written for: 6.14
+
+Introduction
+------------
+The expansion of EDAC for controlling RAS features and exposing features
+control attributes to userspace via sysfs. Some Examples:
+
+* Scrub control
+
+* Error Check Scrub (ECS) control
+
+* ACPI RAS2 features
+
+* Post Package Repair (PPR) control
+
+* Memory Sparing Repair control etc.
+
+High level design is illustrated in the following diagram::
+
+         _______________________________________________
+        |   Userspace - Rasdaemon                       |
+        |  _____________                                |
+        | | RAS CXL mem |      _______________          |
+        | |error handler|---->|               |         |
+        | |_____________|     | RAS dynamic   |         |
+        |  _____________      | scrub, memory |         |
+        | | RAS memory  |---->| repair control|         |
+        | |error handler|     |_______________|         |
+        | |_____________|          |                    |
+        |__________________________|____________________|
+                                   |
+                                   |
+    _______________________________|______________________________
+   |     Kernel EDAC extension for | controlling RAS Features     |
+   | ______________________________|____________________________  |
+   || EDAC Core          Sysfs EDAC| Bus                        | |
+   ||    __________________________|_________     _____________ | |
+   ||   |/sys/bus/edac/devices/<dev>/scrubX/ |   | EDAC device || |
+   ||   |/sys/bus/edac/devices/<dev>/ecsX/   |<->| EDAC MC     || |
+   ||   |/sys/bus/edac/devices/<dev>/repairX |   | EDAC sysfs  || |
+   ||   |____________________________________|   |_____________|| |
+   ||                           EDAC|Bus                        | |
+   ||                               |                           | |
+   ||    __________ Get feature     |      Get feature          | |
+   ||   |          |desc   _________|______ desc  __________    | |
+   ||   |EDAC scrub|<-----| EDAC device    |     |          |   | |
+   ||   |__________|      | driver- RAS    |---->| EDAC mem |   | |
+   ||    __________       | feature control|     | repair   |   | |
+   ||   |          |<-----|________________|     |__________|   | |
+   ||   |EDAC ECS  |    Register RAS|features                   | |
+   ||   |__________|                |                           | |
+   ||         ______________________|_____________              | |
+   ||_________|_______________|__________________|______________| |
+   |   _______|____    _______|_______       ____|__________      |
+   |  |            |  | CXL mem driver|     | Client driver |     |
+   |  | ACPI RAS2  |  | scrub, ECS,   |     | memory repair |     |
+   |  | driver     |  | sparing, PPR  |     | features      |     |
+   |  |____________|  |_______________|     |_______________|     |
+   |        |                 |                    |              |
+   |________|_________________|____________________|______________|
+            |                 |                    |
+    ________|_________________|____________________|______________
+   |     ___|_________________|____________________|_______       |
+   |    |                                                  |      |
+   |    |            Platform HW and Firmware              |      |
+   |    |__________________________________________________|      |
+   |______________________________________________________________|
+
+
+1. EDAC Features components - Create feature specific descriptors.
+For example, EDAC scrub, EDAC ECS, EDAC memory repair in the above
+diagram.
+
+2. EDAC device driver for controlling RAS Features - Get feature's attribute
+descriptors from EDAC RAS feature component and registers device's RAS
+features with EDAC bus and exposes the features control attributes via
+the sysfs EDAC bus. For example, /sys/bus/edac/devices/<dev-name>/<feature>X/
+
+3. RAS dynamic feature controller - Userspace sample modules in rasdaemon for
+dynamic scrub/repair control to issue scrubbing/repair when excess number
+of corrected memory errors are reported in a short span of time.
diff --git a/Documentation/edac/index.rst b/Documentation/edac/index.rst
new file mode 100644
index 000000000000..b6c265a4cffb
--- /dev/null
+++ b/Documentation/edac/index.rst
@@ -0,0 +1,10 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============
+EDAC Subsystem
+==============
+
+.. toctree::
+   :maxdepth: 1
+
+   features
diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
index 621dc2a5d034..9fce46dd7405 100644
--- a/drivers/edac/edac_device.c
+++ b/drivers/edac/edac_device.c
@@ -570,3 +570,103 @@ void edac_device_handle_ue_count(struct edac_device_ctl_info *edac_dev,
 		      block ? block->name : "N/A", count, msg);
 }
 EXPORT_SYMBOL_GPL(edac_device_handle_ue_count);
+
+static void edac_dev_release(struct device *dev)
+{
+	struct edac_dev_feat_ctx *ctx = container_of(dev, struct edac_dev_feat_ctx, dev);
+
+	kfree(ctx->dev.groups);
+	kfree(ctx);
+}
+
+const struct device_type edac_dev_type = {
+	.name = "edac_dev",
+	.release = edac_dev_release,
+};
+
+static void edac_dev_unreg(void *data)
+{
+	device_unregister(data);
+}
+
+/**
+ * edac_dev_register - register device for RAS features with EDAC
+ * @parent: parent device.
+ * @name: parent device's name.
+ * @private: parent driver's data to store in the context if any.
+ * @num_features: number of RAS features to register.
+ * @ras_features: list of RAS features to register.
+ *
+ * Return:
+ *  * %0       - Success.
+ *  * %-EINVAL - Invalid parameters passed.
+ *  * %-ENOMEM - Dynamic memory allocation failed.
+ *
+ */
+int edac_dev_register(struct device *parent, char *name,
+		      void *private, int num_features,
+		      const struct edac_dev_feature *ras_features)
+{
+	const struct attribute_group **ras_attr_groups;
+	struct edac_dev_feat_ctx *ctx;
+	int attr_gcnt = 0;
+	int ret, feat;
+
+	if (!parent || !name || !num_features || !ras_features)
+		return -EINVAL;
+
+	/* Double parse to make space for attributes */
+	for (feat = 0; feat < num_features; feat++) {
+		switch (ras_features[feat].ft_type) {
+		/* Add feature specific code */
+		default:
+			return -EINVAL;
+		}
+	}
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ras_attr_groups = kcalloc(attr_gcnt + 1, sizeof(*ras_attr_groups), GFP_KERNEL);
+	if (!ras_attr_groups) {
+		ret = -ENOMEM;
+		goto ctx_free;
+	}
+
+	attr_gcnt = 0;
+	for (feat = 0; feat < num_features; feat++, ras_features++) {
+		switch (ras_features->ft_type) {
+		/* Add feature specific code */
+		default:
+			ret = -EINVAL;
+			goto groups_free;
+		}
+	}
+
+	ctx->dev.parent = parent;
+	ctx->dev.bus = edac_get_sysfs_subsys();
+	ctx->dev.type = &edac_dev_type;
+	ctx->dev.groups = ras_attr_groups;
+	ctx->private = private;
+	dev_set_drvdata(&ctx->dev, ctx);
+
+	ret = dev_set_name(&ctx->dev, name);
+	if (ret)
+		goto groups_free;
+
+	ret = device_register(&ctx->dev);
+	if (ret) {
+		put_device(&ctx->dev);
+		return ret;
+	}
+
+	return devm_add_action_or_reset(parent, edac_dev_unreg, &ctx->dev);
+
+groups_free:
+	kfree(ras_attr_groups);
+ctx_free:
+	kfree(ctx);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(edac_dev_register);
diff --git a/include/linux/edac.h b/include/linux/edac.h
index b4ee8961e623..521b17113d4d 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -661,4 +661,32 @@ static inline struct dimm_info *edac_get_dimm(struct mem_ctl_info *mci,
 
 	return mci->dimms[index];
 }
+
+#define EDAC_FEAT_NAME_LEN	128
+
+/* RAS feature type */
+enum edac_dev_feat {
+	RAS_FEAT_MAX
+};
+
+/* EDAC device feature information structure */
+struct edac_dev_data {
+	u8 instance;
+	void *private;
+};
+
+struct edac_dev_feat_ctx {
+	struct device dev;
+	void *private;
+};
+
+struct edac_dev_feature {
+	enum edac_dev_feat ft_type;
+	u8 instance;
+	void *ctx;
+};
+
+int edac_dev_register(struct device *parent, char *dev_name,
+		      void *parent_pvt_data, int num_features,
+		      const struct edac_dev_feature *ras_features);
 #endif /* _LINUX_EDAC_H_ */
-- 
2.43.0


