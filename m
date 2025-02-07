Return-Path: <linux-edac+bounces-2984-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AACA2C5EF
	for <lists+linux-edac@lfdr.de>; Fri,  7 Feb 2025 15:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D63A67A6630
	for <lists+linux-edac@lfdr.de>; Fri,  7 Feb 2025 14:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59309246351;
	Fri,  7 Feb 2025 14:45:47 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BEE246330;
	Fri,  7 Feb 2025 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738939547; cv=none; b=tOj8Jc6szyzK31GW1PYOF7TKBwhxkFopkHDgcpk4EgHYtU9wWnAEbGj1hzMf3MdIrhbOgEh5QNFpoKXU1rDzl/seVkSrjvEvZ9csdBUXWXbpU0tjCCACavbKsHTQoElwTDIiJWEQXoXt/dbeoY5u7jXipnO2dwmqr7bA14nh2nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738939547; c=relaxed/simple;
	bh=oQ7fuAZBIj85NDfOv9DZDhQtioSnCc6Z0Wg+l6kRJbY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LC6jLleQJL+jfJYvJ3zrn6gy78HuG6tMywWM0gVSStmdA8nO+SRQ73tZOnw0ykUeSErTxZeL4e5CQCRT6la6GsjDah1epHKalfiNCSg8msoD6eqgDpI+8nWJF1cfB/JMA/Ys/ysGranR1sKAVcV09zX7E2QmoISx32tCR+Q97zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YqGvt3Tb8z6HJZN;
	Fri,  7 Feb 2025 22:44:42 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id CC3F21401F4;
	Fri,  7 Feb 2025 22:45:43 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.173.5) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Feb 2025 15:45:41 +0100
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
Subject: [PATCH v19 07/15] cxl: Add helper function to retrieve a feature entry
Date: Fri, 7 Feb 2025 14:44:36 +0000
Message-ID: <20250207144445.1879-8-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250207144445.1879-1-shiju.jose@huawei.com>
References: <20250207144445.1879-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Add helper function to retrieve a feature entry from the supported
features list, if supported.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/core/features.c | 21 +++++++++++++++++++++
 include/cxl/features.h      |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index 5f64185a5c7a..bf175e69cda1 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -43,6 +43,27 @@ bool is_cxl_feature_exclusive(struct cxl_feat_entry *entry)
 }
 EXPORT_SYMBOL_NS_GPL(is_cxl_feature_exclusive, "CXL");
 
+struct cxl_feat_entry *cxl_get_feature_entry(struct cxl_memdev *cxlmd,
+					     const uuid_t *feat_uuid)
+{
+	struct cxl_features_state *cxlfs = cxlmd->cxlfs;
+	struct cxl_feat_entry *feat_entry;
+	int count;
+
+	/*
+	 * Retrieve the feature entry from the supported features list,
+	 * if the feature is supported.
+	 */
+	feat_entry = cxlfs->entries;
+	for (count = 0; count < cxlfs->num_features; count++, feat_entry++) {
+		if (uuid_equal(&feat_entry->uuid, feat_uuid))
+			return feat_entry;
+	}
+
+	return ERR_PTR(-ENOENT);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_feature_entry, "CXL");
+
 size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 		       enum cxl_get_feat_selection selection,
 		       void *feat_out, size_t feat_out_size, u16 offset,
diff --git a/include/cxl/features.h b/include/cxl/features.h
index e52d0573f504..563d966beee5 100644
--- a/include/cxl/features.h
+++ b/include/cxl/features.h
@@ -68,6 +68,8 @@ struct cxl_features_state {
 };
 
 struct cxl_mailbox;
+struct cxl_feat_entry *cxl_get_feature_entry(struct cxl_memdev *cxlmd,
+					     const uuid_t *feat_uuid);
 size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 		       enum cxl_get_feat_selection selection,
 		       void *feat_out, size_t feat_out_size, u16 offset,
-- 
2.43.0


