Return-Path: <linux-edac+bounces-2292-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D99B9B0AA3
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2024 19:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71D1F1C22488
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2024 17:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D4120A5D5;
	Fri, 25 Oct 2024 17:14:34 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395AE18C01A;
	Fri, 25 Oct 2024 17:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729876473; cv=none; b=DAbXcVQCWdi5vuTOBfrJ8t+ctW8WWJH0YX+bunY2dGoNvKIR9U9/TZTcffiWH/cb1s1UNjl09xiWRdj4OaypCy/I8hJMx7BHWTExznFfEuR888tfSLmyRvDBIzOHy0zPR/OjCDts38HFi+SPbSGNfOMG53BRaOSs2dmU3s4kHsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729876473; c=relaxed/simple;
	bh=hrpJyw9+3n15pBc1Ept7Dz8NqBT1q0ckDGJO4LtdMRs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ahJNtYfWwgW86hiG3Du+iAAoNEmGui+LjnrpWPZacdC5FiZ2hdBH726h2/h/B4udEtZdflheLHsjXinPljBRFo9C+yi18zNaQF9tsi73iZBQ34nhd782iLoc1+jHp+l/dnjTICN0kpONr/7GdsX7D2hFoWktRE1veC32at+jDOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XZq5c67TLz6LCgg;
	Sat, 26 Oct 2024 01:09:40 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 50864140A86;
	Sat, 26 Oct 2024 01:14:24 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.151.104) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 19:14:22 +0200
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
Subject: [PATCH v14 01/14] EDAC: Add support for EDAC device features control
Date: Fri, 25 Oct 2024 18:13:42 +0100
Message-ID: <20241025171356.1377-2-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20241025171356.1377-1-shiju.jose@huawei.com>
References: <20241025171356.1377-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
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
 drivers/edac/edac_device.c | 101 +++++++++++++++++++++++++++++++++++++
 include/linux/edac.h       |  30 +++++++++++
 2 files changed, 131 insertions(+)

diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
index 621dc2a5d034..e9229b5f8afe 100644
--- a/drivers/edac/edac_device.c
+++ b/drivers/edac/edac_device.c
@@ -570,3 +570,104 @@ void edac_device_handle_ue_count(struct edac_device_ctl_info *edac_dev,
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
index b4ee8961e623..e19706311ec0 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -661,4 +661,34 @@ static inline struct dimm_info *edac_get_dimm(struct mem_ctl_info *mci,
 
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


