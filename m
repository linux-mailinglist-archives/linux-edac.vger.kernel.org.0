Return-Path: <linux-edac+bounces-3914-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A56B2AB857D
	for <lists+linux-edac@lfdr.de>; Thu, 15 May 2025 14:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64F349E0342
	for <lists+linux-edac@lfdr.de>; Thu, 15 May 2025 11:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76521298C21;
	Thu, 15 May 2025 12:00:00 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A57D298C03;
	Thu, 15 May 2025 11:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747310400; cv=none; b=UcWQiASnFCDm5Ota11RNHrHk+ablka9zI5xvcidRGtEMoTa2OYW2jV34oVkKwmml9wFdWSn+MnfWHdliMpB7kXi3ozpd6NWviHHpTCSLU4aIZL5NrIqKFe9USEHdHiroawAj8yBpNHNKDk6P/p3DciPrGPr2cho1oyBSa+RiJIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747310400; c=relaxed/simple;
	bh=qtOP9AgUXmSTXdo50XiuZihlAkspnNvk4R36bN4wIrg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aXm6K9HPvD/bVGTsSrjmj6oN73/8J+Jf8skay851JR2EpxJGLFydx5rRmIv3oUdFnQKUf8tOJqC9RJf1gpinTQysATRbEDpBqa/vtPxOq5iNI9ERobdOoSHVss2FaA95xBWVfh5xIrWNazZWyi9ONXUFsKdA7yAsQeL8BeIVQ2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZypbZ3d0xz6L57H;
	Thu, 15 May 2025 19:56:58 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id F292014010C;
	Thu, 15 May 2025 19:59:50 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.152.208) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 May 2025 13:59:49 +0200
From: <shiju.jose@huawei.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>
CC: <linux-edac@vger.kernel.org>, <linux-doc@vger.kernel.org>, <bp@alien8.de>,
	<tony.luck@intel.com>, <lenb@kernel.org>, <Yazen.Ghannam@amd.com>,
	<mchehab@kernel.org>, <nifan.cxl@gmail.com>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v5 2/8] cxl: Update prototype of function get_support_feature_info()
Date: Thu, 15 May 2025 12:59:18 +0100
Message-ID: <20250515115927.772-3-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250515115927.772-1-shiju.jose@huawei.com>
References: <20250515115927.772-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Add following changes to function get_support_feature_info()
1. Make generic to share between cxl-fwctl and cxl-edac paths.
2. Rename get_support_feature_info() to cxl_feature_info()
3. Change parameter const struct fwctl_rpc_cxl *rpc_in to
   const uuid_t *uuid.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/core/core.h     |  2 ++
 drivers/cxl/core/features.c | 17 +++++++----------
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 17b692eb3257..613cce5c4f7b 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -124,6 +124,8 @@ int cxl_acpi_get_extended_linear_cache_size(struct resource *backing_res,
 					    int nid, resource_size_t *size);
 
 #ifdef CONFIG_CXL_FEATURES
+struct cxl_feat_entry *
+cxl_feature_info(struct cxl_features_state *cxlfs, const uuid_t *uuid);
 size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 		       enum cxl_get_feat_selection selection,
 		       void *feat_out, size_t feat_out_size, u16 offset,
diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index 1498e2369c37..a83a2214a136 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -355,17 +355,11 @@ static void cxlctl_close_uctx(struct fwctl_uctx *uctx)
 {
 }
 
-static struct cxl_feat_entry *
-get_support_feature_info(struct cxl_features_state *cxlfs,
-			 const struct fwctl_rpc_cxl *rpc_in)
+struct cxl_feat_entry *
+cxl_feature_info(struct cxl_features_state *cxlfs,
+		 const uuid_t *uuid)
 {
 	struct cxl_feat_entry *feat;
-	const uuid_t *uuid;
-
-	if (rpc_in->op_size < sizeof(uuid))
-		return ERR_PTR(-EINVAL);
-
-	uuid = &rpc_in->set_feat_in.uuid;
 
 	for (int i = 0; i < cxlfs->entries->num_features; i++) {
 		feat = &cxlfs->entries->ent[i];
@@ -547,7 +541,10 @@ static bool cxlctl_validate_set_features(struct cxl_features_state *cxlfs,
 	struct cxl_feat_entry *feat;
 	u32 flags;
 
-	feat = get_support_feature_info(cxlfs, rpc_in);
+	if (rpc_in->op_size < sizeof(uuid_t))
+		return ERR_PTR(-EINVAL);
+
+	feat = cxl_feature_info(cxlfs, &rpc_in->set_feat_in.uuid);
 	if (IS_ERR(feat))
 		return false;
 
-- 
2.43.0


