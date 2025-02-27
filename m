Return-Path: <linux-edac+bounces-3224-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 468B5A48BB2
	for <lists+linux-edac@lfdr.de>; Thu, 27 Feb 2025 23:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E926188C052
	for <lists+linux-edac@lfdr.de>; Thu, 27 Feb 2025 22:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAAC23E34E;
	Thu, 27 Feb 2025 22:39:25 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA401B85DF;
	Thu, 27 Feb 2025 22:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740695965; cv=none; b=W/OHCRcOENI18R+muZAA4OzwIpw/+0esv96E3KTpBjAU5W2TAJQTYP3Dcc7gT7W3kCDve7LSezqwT96zXpwJ6wIrwCeJUGCDNRNngsuBgL2sd2wB0kSxhOHoz8xeSuCnqeopN+VCFIH2p95XuTEY9UR7N1AjFDXlNvNVU0HEXHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740695965; c=relaxed/simple;
	bh=lm2SPz45bSbs3XpcnjpSgAIpuSa6Fr3OJ4mS9VbqOoM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KSXuOGEUQbtTo3FNDFXkw+7PxezsJ1HaU3ba5o6Hz1kutHDUv1oNxDcjgi8z8WTleKLZCHRydqhUSqh3LM+Z58B4aVNY3pQaoYQVNBSt1eApaNW4L0cZ+iWrJzS7sBPfrCLCz9UxvxOyXuXLexHuai4i4UweG8Vo+wuNv2LcaTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z3mPt6F5sz6L53w;
	Fri, 28 Feb 2025 06:35:30 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id BEB5C1400DA;
	Fri, 28 Feb 2025 06:39:19 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.149.240) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Feb 2025 23:39:17 +0100
From: <shiju.jose@huawei.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <david@redhat.com>, <Vilas.Sridharan@amd.com>
CC: <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
	<tony.luck@intel.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<mchehab@kernel.org>, <leo.duran@amd.com>, <Yazen.Ghannam@amd.com>,
	<rientjes@google.com>, <jiaqiyan@google.com>, <Jon.Grimm@amd.com>,
	<dave.hansen@linux.intel.com>, <naoya.horiguchi@nec.com>,
	<james.morse@arm.com>, <jthoughton@google.com>, <somasundaram.a@hpe.com>,
	<erdemaktas@google.com>, <pgonda@google.com>, <duenwen@google.com>,
	<gthelen@google.com>, <wschwartz@amperecomputing.com>,
	<dferguson@amperecomputing.com>, <wbs@os.amperecomputing.com>,
	<nifan.cxl@gmail.com>, <yazen.ghannam@amd.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <roberto.sassu@huawei.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH 1/8] cxl: Add helper function to retrieve a feature entry
Date: Thu, 27 Feb 2025 22:38:08 +0000
Message-ID: <20250227223816.2036-2-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250227223816.2036-1-shiju.jose@huawei.com>
References: <20250227223816.2036-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Add helper function to retrieve a feature entry from the supported
features list, if supported.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/core/core.h     |  2 ++
 drivers/cxl/core/features.c | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 3d3b00835446..6c83f6f18122 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -120,6 +120,8 @@ int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
 int cxl_gpf_port_setup(struct device *dport_dev, struct cxl_port *port);
 
 #ifdef CONFIG_CXL_FEATURES
+struct cxl_feat_entry *cxl_get_feature_entry(struct cxl_dev_state *cxlds,
+					     const uuid_t *feat_uuid);
 size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 		       enum cxl_get_feat_selection selection,
 		       void *feat_out, size_t feat_out_size, u16 offset,
diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index 048ba4fc3538..c822fb4a8c33 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -203,6 +203,26 @@ int devm_cxl_setup_features(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_features, "CXL");
 
+struct cxl_feat_entry *cxl_get_feature_entry(struct cxl_dev_state *cxlds,
+					     const uuid_t *feat_uuid)
+{
+	struct cxl_features_state *cxlfs = to_cxlfs(cxlds);
+	struct cxl_feat_entry *feat_entry;
+	int count;
+
+	/*
+	 * Retrieve the feature entry from the supported features list,
+	 * if the feature is supported.
+	 */
+	feat_entry = cxlfs->entries->ent;
+	for (count = 0; count < cxlfs->entries->num_features; count++, feat_entry++) {
+		if (uuid_equal(&feat_entry->uuid, feat_uuid))
+			return feat_entry;
+	}
+
+	return ERR_PTR(-ENOENT);
+}
+
 size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 		       enum cxl_get_feat_selection selection,
 		       void *feat_out, size_t feat_out_size, u16 offset,
-- 
2.43.0


