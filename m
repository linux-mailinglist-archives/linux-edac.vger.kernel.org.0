Return-Path: <linux-edac+bounces-1523-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D01419329F7
	for <lists+linux-edac@lfdr.de>; Tue, 16 Jul 2024 17:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59C2E1F2165E
	for <lists+linux-edac@lfdr.de>; Tue, 16 Jul 2024 15:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C6319E7EB;
	Tue, 16 Jul 2024 15:04:36 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB03A19DF7B;
	Tue, 16 Jul 2024 15:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721142276; cv=none; b=mh7N9WjHt9uCHT92nqpOwbzp8vHEdwICEQReNHaOCOK7m5h1fFBGjcVFiS5ozrjk3PREzEO6p5r01TdmSwoR4vLu5/Y86Bw1gSKWN2XvPM1zSq6EfDcELcH8rqwqcvmOoWDoqT05EWBEUbcd6PQqACKcr/I4XN1E5nwzdQ30Ijk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721142276; c=relaxed/simple;
	bh=l/o1Fs6EwTSDL2TrrpCaGzivSyFOeqYE2dHnttjrwK4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AuqVch9G9Yn2/OTOe37Y2Ll1fC0WYv+X3yccLJABKhRIuPYpfUMeVKElTRQAwJQp4bbwTMg47aBNMbdh2vy4A/gXXR1MyNaCw3rTERGIMPgPWWF1CQPJH8up3qRifqfee8iFtIit+3CYr47nfMsZo76nAvX4tEtkAsfCfUN5n5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WNj3h3dCwz6H6pv;
	Tue, 16 Jul 2024 23:02:40 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id 61717140B38;
	Tue, 16 Jul 2024 23:04:25 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.159.153) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 16 Jul 2024 16:04:23 +0100
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
Subject: [RFC PATCH v9 01/11] EDAC: Add generic EDAC RAS feature driver
Date: Tue, 16 Jul 2024 16:03:25 +0100
Message-ID: <20240716150336.2042-2-shiju.jose@huawei.com>
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

Add generic EDAC driver supports registering RAS features supported
in the system. The driver exposes feature's control attributes to the
userspace in /sys/bus/edac/devices/<dev-name>/<ras-feature>/

Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/edac/Makefile            |   1 +
 drivers/edac/edac_ras_feature.c  | 155 +++++++++++++++++++++++++++++++
 include/linux/edac_ras_feature.h |  66 +++++++++++++
 3 files changed, 222 insertions(+)
 create mode 100755 drivers/edac/edac_ras_feature.c
 create mode 100755 include/linux/edac_ras_feature.h

diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 9c09893695b7..c532b57a6d8a 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_EDAC)			:= edac_core.o
 
 edac_core-y	:= edac_mc.o edac_device.o edac_mc_sysfs.o
 edac_core-y	+= edac_module.o edac_device_sysfs.o wq.o
+edac_core-y	+= edac_ras_feature.o
 
 edac_core-$(CONFIG_EDAC_DEBUG)		+= debugfs.o
 
diff --git a/drivers/edac/edac_ras_feature.c b/drivers/edac/edac_ras_feature.c
new file mode 100755
index 000000000000..24a729fea66f
--- /dev/null
+++ b/drivers/edac/edac_ras_feature.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * EDAC RAS control feature driver supports registering RAS
+ * features with the EDAC and exposes the feature's control
+ * attributes to the userspace in sysfs.
+ *
+ * Copyright (c) 2024 HiSilicon Limited.
+ */
+
+#define pr_fmt(fmt)     "EDAC RAS CONTROL FEAT: " fmt
+
+#include <linux/edac_ras_feature.h>
+
+static void edac_ras_dev_release(struct device *dev)
+{
+	struct edac_ras_feat_ctx *ctx =
+		container_of(dev, struct edac_ras_feat_ctx, dev);
+
+	kfree(ctx);
+}
+
+const struct device_type edac_ras_dev_type = {
+	.name = "edac_ras_dev",
+	.release = edac_ras_dev_release,
+};
+
+static void edac_ras_dev_unreg(void *data)
+{
+	device_unregister(data);
+}
+
+static int edac_ras_feat_scrub_init(struct device *parent,
+				    struct edac_scrub_data *sdata,
+				    const struct edac_ras_feature *sfeat,
+				    const struct attribute_group **attr_groups)
+{
+	sdata->ops = sfeat->scrub_ops;
+	sdata->private = sfeat->scrub_ctx;
+
+	return 1;
+}
+
+static int edac_ras_feat_ecs_init(struct device *parent,
+				  struct edac_ecs_data *edata,
+				  const struct edac_ras_feature *efeat,
+				  const struct attribute_group **attr_groups)
+{
+	int num = efeat->ecs_info.num_media_frus;
+
+	edata->ops = efeat->ecs_ops;
+	edata->private = efeat->ecs_ctx;
+
+	return num;
+}
+
+/**
+ * edac_ras_dev_register - register device for ras features with edac
+ * @parent: client device.
+ * @name: client device's name.
+ * @private: parent driver's data to store in the context if any.
+ * @num_features: number of ras features to register.
+ * @ras_features: list of ras features to register.
+ *
+ * Returns 0 on success, error otherwise.
+ * The new edac_ras_feat_ctx would be freed automatically.
+ */
+int edac_ras_dev_register(struct device *parent, char *name,
+			  void *private, int num_features,
+			  const struct edac_ras_feature *ras_features)
+{
+	const struct attribute_group **ras_attr_groups;
+	struct edac_ras_feat_ctx *ctx;
+	int attr_gcnt = 0;
+	int ret, feat;
+
+	if (!parent || !name || !num_features || !ras_features)
+		return -EINVAL;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->dev.parent = parent;
+	ctx->private = private;
+
+	/* Double parse so we can make space for attributes */
+	for (feat = 0; feat < num_features; feat++) {
+		switch (ras_features[feat].feat) {
+		case ras_feat_scrub:
+			attr_gcnt++;
+			break;
+		case ras_feat_ecs:
+			attr_gcnt += ras_features[feat].ecs_info.num_media_frus;
+			break;
+		default:
+			ret = -EINVAL;
+			goto ctx_free;
+		}
+	}
+
+	ras_attr_groups = devm_kzalloc(parent,
+				       (attr_gcnt + 1) * sizeof(*ras_attr_groups),
+				       GFP_KERNEL);
+	if (!ras_attr_groups) {
+		ret = -ENOMEM;
+		goto ctx_free;
+	}
+
+	attr_gcnt = 0;
+	for (feat = 0; feat < num_features; feat++, ras_features++) {
+		if (ras_features->feat == ras_feat_scrub) {
+			if (!ras_features->scrub_ops)
+				continue;
+			ret = edac_ras_feat_scrub_init(parent, &ctx->scrub,
+						       ras_features, &ras_attr_groups[attr_gcnt]);
+			if (ret < 0)
+				goto ctx_free;
+
+			attr_gcnt += ret;
+		} else if (ras_features->feat == ras_feat_ecs) {
+			if (!ras_features->ecs_ops)
+				continue;
+			ret = edac_ras_feat_ecs_init(parent, &ctx->ecs,
+						     ras_features, &ras_attr_groups[attr_gcnt]);
+			if (ret < 0)
+				goto ctx_free;
+
+			attr_gcnt += ret;
+		} else {
+			ret = -EINVAL;
+			goto ctx_free;
+		}
+	}
+	ras_attr_groups[attr_gcnt] = NULL;
+	ctx->dev.bus = edac_get_sysfs_subsys();
+	ctx->dev.type = &edac_ras_dev_type;
+	ctx->dev.groups = ras_attr_groups;
+	dev_set_drvdata(&ctx->dev, ctx);
+	ret = dev_set_name(&ctx->dev, name);
+	if (ret)
+		goto ctx_free;
+
+	ret = device_register(&ctx->dev);
+	if (ret) {
+		put_device(&ctx->dev);
+		return ret;
+	}
+
+	return devm_add_action_or_reset(parent, edac_ras_dev_unreg, &ctx->dev);
+
+ctx_free:
+	kfree(ctx);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(edac_ras_dev_register);
diff --git a/include/linux/edac_ras_feature.h b/include/linux/edac_ras_feature.h
new file mode 100755
index 000000000000..000e99141023
--- /dev/null
+++ b/include/linux/edac_ras_feature.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * EDAC RAS control features.
+ *
+ * Copyright (c) 2024 HiSilicon Limited.
+ */
+
+#ifndef __EDAC_RAS_FEAT_H
+#define __EDAC_RAS_FEAT_H
+
+#include <linux/types.h>
+#include <linux/edac.h>
+
+#define EDAC_RAS_NAME_LEN	128
+
+enum edac_ras_feat {
+	ras_feat_scrub,
+	ras_feat_ecs,
+	ras_feat_max
+};
+
+struct edac_ecs_ex_info {
+	u16 num_media_frus;
+};
+
+/*
+ * EDAC RAS feature information structure
+ */
+struct edac_scrub_data {
+	const struct edac_scrub_ops *ops;
+	void *private;
+};
+
+struct edac_ecs_data {
+	const struct edac_ecs_ops *ops;
+	void *private;
+};
+
+struct device;
+
+struct edac_ras_feat_ctx {
+	struct device dev;
+	void *private;
+	struct edac_scrub_data scrub;
+	struct edac_ecs_data ecs;
+};
+
+struct edac_ras_feature {
+	enum edac_ras_feat feat;
+	union {
+		const struct edac_scrub_ops *scrub_ops;
+		const struct edac_ecs_ops *ecs_ops;
+	};
+	union {
+		struct edac_ecs_ex_info ecs_info;
+	};
+	union {
+		void *scrub_ctx;
+		void *ecs_ctx;
+	};
+};
+
+int edac_ras_dev_register(struct device *parent, char *dev_name,
+			  void *parent_pvt_data, int num_features,
+			  const struct edac_ras_feature *ras_features);
+#endif /* __EDAC_RAS_FEAT_H */
-- 
2.34.1


