Return-Path: <linux-edac+bounces-1660-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C328954F17
	for <lists+linux-edac@lfdr.de>; Fri, 16 Aug 2024 18:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 184AA286CC2
	for <lists+linux-edac@lfdr.de>; Fri, 16 Aug 2024 16:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B731BF30B;
	Fri, 16 Aug 2024 16:43:36 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3B91BE235;
	Fri, 16 Aug 2024 16:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723826616; cv=none; b=DPW78QvnaXIZq8CVffo03gdG5QeIM2GsvvmwBNyXOEsJb1X3jvSl0pWhk4GtlOsdDM/GOFakTVKCU7OrNAAKzw4DgCCVY9zhaEJSGhTWPxJtkbFay7PYIpiSWXXbfGVz8EFiITqcoG9TGp8DUV0xlL3FpvPsGomuXKb2wTxdUdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723826616; c=relaxed/simple;
	bh=PKyTjq7W8rWj6rghzn04mMVbYNr2wElojEHwP/wuXQI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K5WREGZgWZzl0EJS3LrZJ/33KQlHN1cS9TdoNTXDqCPNIG6w3P0hl+QsrAWxngCY87Jwz1DdgTUPDAugpRd8CHra+Js2dLGABYRpKIoB2zpyAT97JXAG+h01URZvh1+LrwQ1PF/bqJb3ThHh//CWb0ilYPGSIumvmcOyWR8QQDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WlnmD5Bkzz67Cwc;
	Sat, 17 Aug 2024 00:40:28 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id 02100140A70;
	Sat, 17 Aug 2024 00:43:27 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.148.43) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 17:43:25 +0100
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
Subject: [PATCH v11 01/14] EDAC: Add support for EDAC device feature's control
Date: Fri, 16 Aug 2024 17:42:24 +0100
Message-ID: <20240816164238.1902-2-shiju.jose@huawei.com>
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

Add generic EDAC device feature's control supports registering
RAS features supported in the system. Driver exposes feature's
control attributes to the userspace in
/sys/bus/edac/devices/<dev-name>/<ras-feature>/

Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/edac/edac_device.c | 178 +++++++++++++++++++++++++++++++++++++
 include/linux/edac.h       |  60 +++++++++++++
 2 files changed, 238 insertions(+)

diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
index 621dc2a5d034..635a41db8b5a 100644
--- a/drivers/edac/edac_device.c
+++ b/drivers/edac/edac_device.c
@@ -570,3 +570,181 @@ void edac_device_handle_ue_count(struct edac_device_ctl_info *edac_dev,
 		      block ? block->name : "N/A", count, msg);
 }
 EXPORT_SYMBOL_GPL(edac_device_handle_ue_count);
+
+/* EDAC device feature */
+static void edac_dev_release(struct device *dev)
+{
+	struct edac_dev_feat_ctx *ctx =
+		container_of(dev, struct edac_dev_feat_ctx, dev);
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
+ * edac_dev_feature_init - Init a ras feature
+ * @parent: client device.
+ * @dev_data: pointer to struct edac_dev_data.
+ * @feat: pointer to struct edac_dev_feature.
+ * @attr_groups: pointer to attribute group's container.
+ *
+ * Returns number of scrub feature's attribute groups on success,
+ * error otherwise.
+ */
+static int edac_dev_feat_init(struct device *parent,
+			      struct edac_dev_data *dev_data,
+			      const struct edac_dev_feature *ras_feat,
+			      const struct attribute_group **attr_groups)
+{
+	int num;
+
+	switch (ras_feat->feat) {
+	case RAS_FEAT_SCRUB:
+		dev_data->scrub_ops = ras_feat->scrub_ops;
+		dev_data->private = ras_feat->scrub_ctx;
+		return 1;
+	case RAS_FEAT_ECS:
+		num = ras_feat->ecs_info.num_media_frus;
+		dev_data->ecs_ops = ras_feat->ecs_ops;
+		dev_data->private = ras_feat->ecs_ctx;
+		return num;
+	case RAS_FEAT_PPR:
+		dev_data->ppr_ops = ras_feat->ppr_ops;
+		dev_data->private = ras_feat->ppr_ctx;
+		return 1;
+	default:
+		return -EINVAL;
+	}
+}
+
+/**
+ * edac_dev_register - register device for ras features with edac
+ * @parent: client device.
+ * @name: client device's name.
+ * @private: parent driver's data to store in the context if any.
+ * @num_features: number of ras features to register.
+ * @ras_features: list of ras features to register.
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
+	int ppr_cnt = 0, ppr_inst = 0;
+	int attr_gcnt = 0;
+	int ret, feat;
+
+	if (!parent || !name || !num_features || !ras_features)
+		return -EINVAL;
+
+	/* Double parse so we can make space for attributes */
+	for (feat = 0; feat < num_features; feat++) {
+		switch (ras_features[feat].feat) {
+		case RAS_FEAT_SCRUB:
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
+		switch (ras_features->feat) {
+		case RAS_FEAT_SCRUB:
+			if (!ras_features->scrub_ops)
+				continue;
+			dev_data = &ctx->scrub;
+			break;
+		case RAS_FEAT_ECS:
+			if (!ras_features->ecs_ops)
+				continue;
+			dev_data = &ctx->ecs;
+			break;
+		case RAS_FEAT_PPR:
+			if (!ras_features->ppr_ops)
+				continue;
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
+	ras_attr_groups[attr_gcnt] = NULL;
+	ctx->dev.bus = edac_get_sysfs_subsys();
+	ctx->dev.type = &edac_dev_type;
+	ctx->dev.groups = ras_attr_groups;
+	dev_set_drvdata(&ctx->dev, ctx);
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
+groups_free:
+	kfree(ras_attr_groups);
+ctx_free:
+	kfree(ctx);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(edac_dev_register);
diff --git a/include/linux/edac.h b/include/linux/edac.h
index b4ee8961e623..cc96f55ac714 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -661,4 +661,64 @@ static inline struct dimm_info *edac_get_dimm(struct mem_ctl_info *mci,
 
 	return mci->dimms[index];
 }
+
+/* EDAC device features */
+
+#define EDAC_FEAT_NAME_LEN	128
+
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
+	struct edac_dev_data scrub;
+	struct edac_dev_data ecs;
+	struct edac_dev_data *ppr;
+};
+
+struct edac_dev_feature {
+	enum edac_dev_feat feat;
+	u8 instance;
+	union {
+		const struct edac_scrub_ops *scrub_ops;
+		const struct edac_ecs_ops *ecs_ops;
+		const struct edac_ppr_ops *ppr_ops;
+	};
+	union {
+		void *scrub_ctx;
+		void *ecs_ctx;
+		void *ppr_ctx;
+	};
+	union {
+		struct edac_ecs_ex_info ecs_info;
+	};
+};
+
+int edac_dev_register(struct device *parent, char *dev_name,
+		      void *parent_pvt_data, int num_features,
+		      const struct edac_dev_feature *ras_features);
 #endif /* _LINUX_EDAC_H_ */
-- 
2.34.1


