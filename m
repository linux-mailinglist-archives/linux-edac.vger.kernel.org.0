Return-Path: <linux-edac+bounces-1969-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EF1996A51
	for <lists+linux-edac@lfdr.de>; Wed,  9 Oct 2024 14:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BC9B1F2567D
	for <lists+linux-edac@lfdr.de>; Wed,  9 Oct 2024 12:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F21198A34;
	Wed,  9 Oct 2024 12:43:08 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B6A196C86;
	Wed,  9 Oct 2024 12:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728477787; cv=none; b=L6W/4cTrd1k2vJ0BsMepxIGod/xan1EIfndbrWMCvbiFRBMK1y27Ojfqe2C89nr5o1RNAhgKUdg2eVmVVJlHe01DyEO95p16lP4BzwV65LbT376r9pLszgLp4WDT6nIS9NZURSyCQ8hUjoCkQN9o5q/bRPivTjilvx4qKezCUxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728477787; c=relaxed/simple;
	bh=yrNCyx9yb9V6b5kQCIoAzFZlrNsJxIoLo6J5iJzf9fY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CCLQbAcOFzKPn0i4dhClRSS390obpKhGDIgf4iZ9+4t01WJbVAQoWkHPxYW9OQxVqsk+X5XrIJu136YIqhjRf7eg3T33rjxVtSaAzwS4iTJVS8yqB89RezGDoSJAYc1yrIyIxFj9dPZGq/weWesGmKmXBggiYL5oT5oQJzsZqyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XNsvs5Vs9z6K71q;
	Wed,  9 Oct 2024 20:41:45 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 6DFBA140133;
	Wed,  9 Oct 2024 20:43:03 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.152.209) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Oct 2024 14:43:01 +0200
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
Subject: [PATCH v13 01/18] EDAC: Add support for EDAC device features control
Date: Wed, 9 Oct 2024 13:41:02 +0100
Message-ID: <20241009124120.1124-2-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20241009124120.1124-1-shiju.jose@huawei.com>
References: <20241009124120.1124-1-shiju.jose@huawei.com>
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

Add generic EDAC device features control supports registering
RAS features supported in the system. Driver exposes features
control attributes to userspace in
/sys/bus/edac/devices/<dev-name>/<ras-feature>/

Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/edac/edac_device.c | 105 +++++++++++++++++++++++++++++++++++++
 include/linux/edac.h       |  32 +++++++++++
 2 files changed, 137 insertions(+)

diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
index 621dc2a5d034..0b8aa8150239 100644
--- a/drivers/edac/edac_device.c
+++ b/drivers/edac/edac_device.c
@@ -570,3 +570,108 @@ void edac_device_handle_ue_count(struct edac_device_ctl_info *edac_dev,
 		      block ? block->name : "N/A", count, msg);
 }
 EXPORT_SYMBOL_GPL(edac_device_handle_ue_count);
+
+/* EDAC device feature */
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
+ * @parent: client device.
+ * @name: client device's name.
+ * @private: parent driver's data to store in the context if any.
+ * @num_features: number of RAS features to register.
+ * @ras_features: list of RAS features to register.
+ *
+ * Return:
+ *  * %0       - Success.
+ *  * %-EINVAL - Invalid parameters passed.
+ *  * %-ENOMEM - Dynamic memory allocation failed.
+ *
+ * The new edac_dev_feat_ctx would be freed automatically.
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
+	ctx->dev.parent = parent;
+	ctx->private = private;
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
+	ras_attr_groups[attr_gcnt] = NULL;
+	ctx->dev.bus = edac_get_sysfs_subsys();
+	ctx->dev.type = &edac_dev_type;
+	ctx->dev.groups = ras_attr_groups;
+	dev_set_drvdata(&ctx->dev, ctx);
+
+	ret = dev_set_name(&ctx->dev, name);
+	if (ret)
+		goto groups_free;
+
+	ret = device_register(&ctx->dev);
+	if (ret) {
+		put_device(&ctx->dev);
+		goto groups_free;
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
index b4ee8961e623..1db008a82690 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -661,4 +661,36 @@ static inline struct dimm_info *edac_get_dimm(struct mem_ctl_info *mci,
 
 	return mci->dimms[index];
 }
+
+/* EDAC device features */
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
+struct device;
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
2.34.1


