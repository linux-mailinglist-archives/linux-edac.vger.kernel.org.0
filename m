Return-Path: <linux-edac+bounces-3039-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B2CA32891
	for <lists+linux-edac@lfdr.de>; Wed, 12 Feb 2025 15:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD52F1884DE7
	for <lists+linux-edac@lfdr.de>; Wed, 12 Feb 2025 14:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBCC210F65;
	Wed, 12 Feb 2025 14:37:20 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F3020F092;
	Wed, 12 Feb 2025 14:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739371040; cv=none; b=MEAajJ+d79a7Gw2RSo52JH7hzVAAjgBsgiTWfsaJdUFyYks4SyXg5dLaL7d7bXnggdsZYlnCRjBh/j5y/xq758Ext4CzQnxPIUhve+9FgRIuYnkX5xFBIJwOj03vlBTotcFbBT8e/jI0womJ4iVpwhZgeMrLQB4psTE8sp4CO3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739371040; c=relaxed/simple;
	bh=HvjrvFow89eoXG/4FaHsGNn+cFr/jhjduCYFd/WQOUg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sWnwS1PNen0wxXPSSgjdPRx938OEV49n9snZDoqt+UwlaTjLIPcFjv4cVPk7Yo4x44aWNI808ZaKyLGpw2CDQ55HXYBeRanThUxcj6W8uozcrr8Uap3i02QfIM+rgvdjGXyaQl+THITyPv75kIEczp98zEubPdoFjoaPtR1P7Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YtLRV2Jxsz6L5QC;
	Wed, 12 Feb 2025 22:34:14 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id A0E05140AA7;
	Wed, 12 Feb 2025 22:37:14 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.169.206) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 12 Feb 2025 15:37:12 +0100
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
Subject: [PATCH v20 01/15] EDAC: Add support for EDAC device features control
Date: Wed, 12 Feb 2025 14:36:39 +0000
Message-ID: <20250212143654.1893-2-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250212143654.1893-1-shiju.jose@huawei.com>
References: <20250212143654.1893-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Add generic EDAC device feature controls supporting the registration
of RAS features available in the system. The driver exposes control
attributes for these features to userspace in
/sys/bus/edac/devices/<dev-name>/<ras-feature>/

Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Tested-by: Daniel Ferguson <danielf@os.amperecomputing.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 Documentation/edac/features.rst |  94 +++++++++++++++++++++++++++++
 Documentation/edac/index.rst    |  10 ++++
 drivers/edac/edac_device.c      | 102 ++++++++++++++++++++++++++++++++
 include/linux/edac.h            |  26 ++++++++
 4 files changed, 232 insertions(+)
 create mode 100644 Documentation/edac/features.rst
 create mode 100644 Documentation/edac/index.rst

diff --git a/Documentation/edac/features.rst b/Documentation/edac/features.rst
new file mode 100644
index 000000000000..6b0fdc6f5d6e
--- /dev/null
+++ b/Documentation/edac/features.rst
@@ -0,0 +1,94 @@
+.. SPDX-License-Identifier: GPL-2.0 OR GFDL-1.2-no-invariants-or-later
+
+============================================
+Augmenting EDAC for controlling RAS features
+============================================
+
+Copyright (c) 2024-2025 HiSilicon Limited.
+
+:Author:   Shiju Jose <shiju.jose@huawei.com>
+:License:  The GNU Free Documentation License, Version 1.2 without
+           Invariant Sections, Front-Cover Texts nor Back-Cover Texts.
+           (dual licensed under the GPL v2)
+
+- Written for: 6.15
+
+Introduction
+------------
+The expansion of EDAC for controlling RAS features and exposing features
+control attributes to userspace via sysfs. Some Examples:
+
+1. Scrub control
+
+2. Error Check Scrub (ECS) control
+
+3. ACPI RAS2 features
+
+4. Post Package Repair (PPR) control
+
+5. Memory Sparing Repair control etc.
+
+High level design is illustrated in the following diagram::
+
+        +-----------------------------------------------+
+        |   Userspace - Rasdaemon                       |
+        | +-------------+                               |
+        | | RAS CXL mem |     +---------------+         |
+        | |error handler|---->|               |         |
+        | +-------------+     | RAS dynamic   |         |
+        | +-------------+     | scrub, memory |         |
+        | | RAS memory  |---->| repair control|         |
+        | |error handler|     +----|----------+         |
+        | +-------------+          |                    |
+        +--------------------------|--------------------+
+                                   |
+                                   |
+   +-------------------------------|------------------------------+
+   |     Kernel EDAC extension for | controlling RAS Features     |
+   |+------------------------------|----------------------------+ |
+   || EDAC Core          Sysfs EDAC| Bus                        | |
+   ||   +--------------------------|---------------------------+| |
+   ||   |/sys/bus/edac/devices/<dev>/scrubX/ |   | EDAC device || |
+   ||   |/sys/bus/edac/devices/<dev>/ecsX/   |<->| EDAC MC     || |
+   ||   |/sys/bus/edac/devices/<dev>/repairX |   | EDAC sysfs  || |
+   ||   +---------------------------|--------------------------+| |
+   ||                           EDAC|Bus                        | |
+   ||                               |                           | |
+   ||   +----------+ Get feature    |      Get feature          | |
+   ||   |          | desc +---------|------+ desc +----------+  | |
+   ||   |EDAC scrub|<-----| EDAC device    |      |          |  | |
+   ||   +----------+      | driver- RAS    |----->| EDAC mem |  | |
+   ||   +----------+      | feature control|      | repair   |  | |
+   ||   |          |<-----|                |      +----------+  | |
+   ||   |EDAC ECS  |      +---------|------+                    | |
+   ||   +----------+    Register RAS|features                   | |
+   ||         ______________________|_____________              | |
+   |+---------|---------------|------------------|--------------+ |
+   |  +-------|----+  +-------|-------+     +----|----------+     |
+   |  |            |  | CXL mem driver|     | Client driver |     |
+   |  | ACPI RAS2  |  | scrub, ECS,   |     | memory repair |     |
+   |  | driver     |  | sparing, PPR  |     | features      |     |
+   |  +-----|------+  +-------|-------+     +------|--------+     |
+   |        |                 |                    |              |
+   +--------|-----------------|--------------------|--------------+
+            |                 |                    |
+   +--------|-----------------|--------------------|--------------+
+   |    +---|-----------------|--------------------|-------+      |
+   |    |                                                  |      |
+   |    |            Platform HW and Firmware              |      |
+   |    +--------------------------------------------------+      |
+   +--------------------------------------------------------------+
+
+
+1. EDAC Features components - Create feature specific descriptors.
+   For example, EDAC scrub, EDAC ECS, EDAC memory repair in the above
+   diagram.
+
+2. EDAC device driver for controlling RAS Features - Get feature's attribute
+   descriptors from EDAC RAS feature component and registers device's RAS
+   features with EDAC bus and exposes the features control attributes via
+   the sysfs EDAC bus. For example, /sys/bus/edac/devices/<dev-name>/<feature>X/
+
+3. RAS dynamic feature controller - Userspace sample modules in rasdaemon for
+   dynamic scrub/repair control to issue scrubbing/repair when excess number
+   of corrected memory errors are reported in a short span of time.
diff --git a/Documentation/edac/index.rst b/Documentation/edac/index.rst
new file mode 100644
index 000000000000..de4a3aa452cb
--- /dev/null
+++ b/Documentation/edac/index.rst
@@ -0,0 +1,10 @@
+.. SPDX-License-Identifier: GPL-2.0 OR GFDL-1.2-no-invariants-or-later
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
index 621dc2a5d034..142a661ff543 100644
--- a/drivers/edac/edac_device.c
+++ b/drivers/edac/edac_device.c
@@ -570,3 +570,105 @@ void edac_device_handle_ue_count(struct edac_device_ctl_info *edac_dev,
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
+ * @name: name for the folder in the /sys/bus/edac/devices/,
+ *	  which is derived from the parent device.
+ *	  For eg. /sys/bus/edac/devices/cxl_mem0/
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
index b4ee8961e623..8c4b6ca2a994 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -661,4 +661,30 @@ static inline struct dimm_info *edac_get_dimm(struct mem_ctl_info *mci,
 
 	return mci->dimms[index];
 }
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


