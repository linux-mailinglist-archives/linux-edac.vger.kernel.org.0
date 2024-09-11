Return-Path: <linux-edac+bounces-1848-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F01F974E01
	for <lists+linux-edac@lfdr.de>; Wed, 11 Sep 2024 11:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BCAB1F25749
	for <lists+linux-edac@lfdr.de>; Wed, 11 Sep 2024 09:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DB918660B;
	Wed, 11 Sep 2024 09:07:23 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3929185B6C;
	Wed, 11 Sep 2024 09:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726045643; cv=none; b=TEYdC/Mc2ZL0fpL85y+YeaTUTfzqTfiGxi26maqHWntFV01mN5QuxqLOy5tUgAptF9GcD3357gn/zZww0jBnH4nFB2fatb1qcC5mN3tQua53ewLYVfRI6B1rupGvMHDo3l2EGp7KEutsSEld8fYuqq4g2vgbNW9g9uv0lJUQiz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726045643; c=relaxed/simple;
	bh=qK2jw17CvXck5wiIZxMqijSItlL0VvjMJm68L2+alP4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LNwjN5YzVGmjH9TVrxEC2nVuyJo9hSqIpp4iX/m7tb4YGqaG4mv2zBvd8gtzD8l1RHlsKi5UkHgQKNDbCdHa3dWv6etBhFZtfuQT/FjhDVzk50yDtlo7zw7ymJ+EQJTA8SszOMtaE/+9nI0La/RrH2zm/Ephq9wEhDtOTuOTBx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X3ZNQ49NTz6K8gL;
	Wed, 11 Sep 2024 17:03:02 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 745DF140B55;
	Wed, 11 Sep 2024 17:07:00 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.245.151) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Sep 2024 11:06:57 +0200
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
Subject: [PATCH v12 01/17] EDAC: Add support for EDAC device features control
Date: Wed, 11 Sep 2024 10:04:30 +0100
Message-ID: <20240911090447.751-2-shiju.jose@huawei.com>
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

Add generic EDAC device features control supports registering
RAS features supported in the system. Driver exposes features
control attributes to userspace in
/sys/bus/edac/devices/<dev-name>/<ras-feature>/

Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/edac/edac_device.c | 202 +++++++++++++++++++++++++++++++++++++
 include/linux/edac.h       |  55 ++++++++++
 2 files changed, 257 insertions(+)

diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
index 621dc2a5d034..e4a5d010ea2d 100644
--- a/drivers/edac/edac_device.c
+++ b/drivers/edac/edac_device.c
@@ -570,3 +570,205 @@ void edac_device_handle_ue_count(struct edac_device_ctl_info *edac_dev,
 		      block ? block->name : "N/A", count, msg);
 }
 EXPORT_SYMBOL_GPL(edac_device_handle_ue_count);
+
+/* EDAC device feature */
+static void edac_dev_release(struct device *dev)
+{
+	struct edac_dev_feat_ctx *ctx = container_of(dev, struct edac_dev_feat_ctx, dev);
+
+	kfree(ctx->ppr);
+	kfree(ctx->scrub);
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
+ * edac_dev_feature_init - Init a RAS feature
+ * @parent: client device.
+ * @dev_data: pointer to the edac_dev_data structure, which contains
+ * client device specific info.
+ * @feat: pointer to struct edac_dev_feature.
+ * @attr_groups: pointer to attribute group's container.
+ *
+ * Returns number of scrub features attribute groups on success,
+ * error otherwise.
+ */
+static int edac_dev_feat_init(struct device *parent,
+			      struct edac_dev_data *dev_data,
+			      const struct edac_dev_feature *ras_feat,
+			      const struct attribute_group **attr_groups)
+{
+	int num;
+
+	switch (ras_feat->ft_type) {
+	case RAS_FEAT_SCRUB:
+		dev_data->scrub_ops = ras_feat->scrub_ops;
+		dev_data->private = ras_feat->ctx;
+		return 1;
+	case RAS_FEAT_ECS:
+		num = ras_feat->ecs_info.num_media_frus;
+		dev_data->ecs_ops = ras_feat->ecs_ops;
+		dev_data->private = ras_feat->ctx;
+		return num;
+	case RAS_FEAT_PPR:
+		dev_data->ppr_ops = ras_feat->ppr_ops;
+		dev_data->private = ras_feat->ctx;
+		return 1;
+	default:
+		return -EINVAL;
+	}
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
+ * Returns 0 on success, error otherwise.
+ * The new edac_dev_feat_ctx would be freed automatically.
+ */
+int edac_dev_register(struct device *parent, char *name,
+		      void *private, int num_features,
+		      const struct edac_dev_feature *ras_features)
+{
+	const struct attribute_group **ras_attr_groups;
+	struct edac_dev_data *dev_data;
+	struct edac_dev_feat_ctx *ctx;
+	int scrub_cnt = 0, scrub_inst = 0;
+	int ppr_cnt = 0, ppr_inst = 0;
+	int attr_gcnt = 0;
+	int ret, feat;
+
+	if (!parent || !name || !num_features || !ras_features)
+		return -EINVAL;
+
+	/* Double parse to make space for attributes */
+	for (feat = 0; feat < num_features; feat++) {
+		switch (ras_features[feat].ft_type) {
+		case RAS_FEAT_SCRUB:
+			attr_gcnt++;
+			scrub_cnt++;
+			break;
+		case RAS_FEAT_PPR:
+			attr_gcnt++;
+			ppr_cnt++;
+			break;
+		case RAS_FEAT_ECS:
+			attr_gcnt += ras_features[feat].ecs_info.num_media_frus;
+			break;
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
+	if (scrub_cnt) {
+		ctx->scrub = kcalloc(scrub_cnt, sizeof(*(ctx->scrub)), GFP_KERNEL);
+		if (!ctx->scrub) {
+			ret = -ENOMEM;
+			goto groups_free;
+		}
+	}
+
+	if (ppr_cnt) {
+		ctx->ppr = kcalloc(ppr_cnt, sizeof(*(ctx->ppr)), GFP_KERNEL);
+		if (!ctx->ppr) {
+			ret = -ENOMEM;
+			goto groups_free;
+		}
+	}
+
+	attr_gcnt = 0;
+	for (feat = 0; feat < num_features; feat++, ras_features++) {
+		switch (ras_features->ft_type) {
+		case RAS_FEAT_SCRUB:
+			if (!ras_features->scrub_ops)
+				continue;
+			if (scrub_inst != ras_features->instance)
+				goto data_mem_free;
+			dev_data = &ctx->scrub[scrub_inst];
+			dev_data->instance = scrub_inst;
+			scrub_inst++;
+			break;
+		case RAS_FEAT_ECS:
+			if (!ras_features->ecs_ops)
+				continue;
+			dev_data = &ctx->ecs;
+			break;
+		case RAS_FEAT_PPR:
+			if (!ras_features->ppr_ops)
+				continue;
+			if (ppr_inst != ras_features->instance)
+				goto data_mem_free;
+			dev_data = &ctx->ppr[ppr_inst];
+			dev_data->instance = ppr_inst;
+			ppr_inst++;
+			break;
+		default:
+			ret = -EINVAL;
+			goto data_mem_free;
+		}
+		ret = edac_dev_feat_init(parent, dev_data, ras_features,
+					 &ras_attr_groups[attr_gcnt]);
+		if (ret < 0)
+			goto data_mem_free;
+
+		attr_gcnt += ret;
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
+		goto data_mem_free;
+
+	ret = device_register(&ctx->dev);
+	if (ret) {
+		put_device(&ctx->dev);
+		goto data_mem_free;
+		return ret;
+	}
+
+	return devm_add_action_or_reset(parent, edac_dev_unreg, &ctx->dev);
+
+data_mem_free:
+	if (ppr_cnt)
+		kfree(ctx->ppr);
+	if (scrub_cnt)
+		kfree(ctx->scrub);
+groups_free:
+	kfree(ras_attr_groups);
+ctx_free:
+	kfree(ctx);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(edac_dev_register);
diff --git a/include/linux/edac.h b/include/linux/edac.h
index b4ee8961e623..b337254cf5b8 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -661,4 +661,59 @@ static inline struct dimm_info *edac_get_dimm(struct mem_ctl_info *mci,
 
 	return mci->dimms[index];
 }
+
+/* EDAC device features */
+
+#define EDAC_FEAT_NAME_LEN	128
+
+/* RAS feature type */
+enum edac_dev_feat {
+	RAS_FEAT_SCRUB,
+	RAS_FEAT_ECS,
+	RAS_FEAT_PPR,
+	RAS_FEAT_MAX
+};
+
+struct edac_ecs_ex_info {
+	u16 num_media_frus;
+};
+
+/*
+ * EDAC device feature information structure
+ */
+struct edac_dev_data {
+	union {
+		const struct edac_scrub_ops *scrub_ops;
+		const struct edac_ecs_ops *ecs_ops;
+		const struct edac_ppr_ops *ppr_ops;
+	};
+	u8 instance;
+	void *private;
+};
+
+struct device;
+
+struct edac_dev_feat_ctx {
+	struct device dev;
+	void *private;
+	struct edac_dev_data *scrub;
+	struct edac_dev_data ecs;
+	struct edac_dev_data *ppr;
+};
+
+struct edac_dev_feature {
+	enum edac_dev_feat ft_type;
+	u8 instance;
+	union {
+		const struct edac_scrub_ops *scrub_ops;
+		const struct edac_ecs_ops *ecs_ops;
+		const struct edac_ppr_ops *ppr_ops;
+	};
+	void *ctx;
+	struct edac_ecs_ex_info ecs_info;
+};
+
+int edac_dev_register(struct device *parent, char *dev_name,
+		      void *parent_pvt_data, int num_features,
+		      const struct edac_dev_feature *ras_features);
 #endif /* _LINUX_EDAC_H_ */
-- 
2.34.1


