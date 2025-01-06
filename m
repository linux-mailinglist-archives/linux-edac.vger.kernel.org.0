Return-Path: <linux-edac+bounces-2803-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90045A024FC
	for <lists+linux-edac@lfdr.de>; Mon,  6 Jan 2025 13:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76EC0164EBF
	for <lists+linux-edac@lfdr.de>; Mon,  6 Jan 2025 12:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58581DEFC6;
	Mon,  6 Jan 2025 12:11:56 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3854B1DED73;
	Mon,  6 Jan 2025 12:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736165516; cv=none; b=DohWX/hs6r89x3wkOv7XRYeBRFiw/UWhlvV/kOmW/5LMNVE0LadRsRr+c01DzwvNQTkD0t/MNt5itd7KtYF1TIMhQNk74f59mVvbA7kLVuAqPpaNagGHzq4TNjNjdzsHfvsAev4KRLZNzXRS20RSKiwDMQHksj4VevfotzAJi8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736165516; c=relaxed/simple;
	bh=+jiSMEn3Ni98zd2BctWZt0Q/VbLlOYbv7m8GQ8pkAII=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ll9yfXG80TQ1WUwI8D8wca0MGZhAuOPHwIh/FQ2V71A1vQAFS9auwiVYNCHWJqiyPkvzp9fCh9aUAFevnvNoo1AEk4cqkd+jVSmv6JGpprLuMrfqfsidvQ6dCkolP13JmYq00lc7R8QzbbO3jX1uiCv4gbv8mW0BfMaSgOXkTXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YRY176FsMz6FGp1;
	Mon,  6 Jan 2025 20:10:51 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 4BEBB14022E;
	Mon,  6 Jan 2025 20:11:53 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.170.95) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 6 Jan 2025 13:11:51 +0100
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
Subject: [PATCH v18 11/19] cxl: Add features driver attribute to emit number of features supported
Date: Mon, 6 Jan 2025 12:10:07 +0000
Message-ID: <20250106121017.1620-12-shiju.jose@huawei.com>
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

Enable sysfs attribute emission of the number of features supported by the
driver/device. This is useful for userspace to determine the number of features
to query for.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/features.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/cxl/features.c b/drivers/cxl/features.c
index 2cdf5ed0a771..2f0fb072921e 100644
--- a/drivers/cxl/features.c
+++ b/drivers/cxl/features.c
@@ -173,11 +173,38 @@ static void cxl_features_remove(struct device *dev)
 	kfree(cfs);
 }
 
+static ssize_t features_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	struct cxl_features_state *cfs = dev_get_drvdata(dev);
+
+	if (!cfs)
+		return -ENOENT;
+
+	return sysfs_emit(buf, "%d\n", cfs->num_features);
+}
+
+static DEVICE_ATTR_RO(features);
+
+static struct attribute *cxl_features_attrs[] = {
+	&dev_attr_features.attr,
+	NULL
+};
+
+static struct attribute_group cxl_features_group = {
+	.attrs = cxl_features_attrs,
+};
+
+__ATTRIBUTE_GROUPS(cxl_features);
+
 static struct cxl_driver cxl_features_driver = {
 	.name = "cxl_features",
 	.probe = cxl_features_probe,
 	.remove = cxl_features_remove,
 	.id = CXL_DEVICE_FEATURES,
+	.drv = {
+		.dev_groups = cxl_features_groups,
+	},
 };
 
 module_cxl_driver(cxl_features_driver);
-- 
2.43.0


