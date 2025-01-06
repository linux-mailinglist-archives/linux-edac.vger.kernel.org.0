Return-Path: <linux-edac+bounces-2806-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E5EA02505
	for <lists+linux-edac@lfdr.de>; Mon,  6 Jan 2025 13:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61B753A5A9A
	for <lists+linux-edac@lfdr.de>; Mon,  6 Jan 2025 12:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BF21DDC3F;
	Mon,  6 Jan 2025 12:12:06 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D55B1DF276;
	Mon,  6 Jan 2025 12:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736165525; cv=none; b=Pg46VjN8qdaafdyT83G8RKpGI8JaodITAxV6JScgCdoJHIa/p2DmgpKkilbPksX48MWW6snVOByD5wAhh2TCLjueTk3zPg2wnXAejXyXelq2zk7WgDLAsYPlZ6p71HNp0fmRmxV4/eFBscnb2wxJbeXEwCZzhLObMmOg+OyrqTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736165525; c=relaxed/simple;
	bh=2jsJ/3Uh0qcWryNe8UCGcy+iRFjQus0nqIlSzXULFBc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nl3QiLmYCtat+/oRoajLQtQvlfxIIK5JPJgP0zKKWCrrJq2z08FpbLSruQ96fl/9NddtK9OJBp6r5biNF8vQU02M8jrXDdciHfORF2yoMabiJOJn224tXtEnfi+80KtbbaKVrOEEmZ//l8MHM9YT+x7skWcT5zuZJbm9DA3GThE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YRY0k0gFwz6LD8T;
	Mon,  6 Jan 2025 20:10:30 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id D897C1408F9;
	Mon,  6 Jan 2025 20:12:01 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.170.95) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 6 Jan 2025 13:11:59 +0100
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
Subject: [PATCH v18 14/19] cxl: Setup exclusive CXL features that are reserved for the kernel
Date: Mon, 6 Jan 2025 12:10:10 +0000
Message-ID: <20250106121017.1620-15-shiju.jose@huawei.com>
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

Certain features will be exclusively used by components such as in
kernel RAS driver. Setup an exclusion list that can be later filtered
out before exposing to user space.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/features.c | 22 ++++++++++++++++++++++
 drivers/cxl/features.c      |  6 +++++-
 include/cxl/features.h      | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index 932e82b52f90..c836b3a64561 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -6,6 +6,17 @@
 #include "core.h"
 #include "cxlmem.h"
 
+static const uuid_t cxl_exclusive_feats[] = {
+	CXL_FEAT_PATROL_SCRUB_UUID,
+	CXL_FEAT_ECS_UUID,
+	CXL_FEAT_SPPR_UUID,
+	CXL_FEAT_HPPR_UUID,
+	CXL_FEAT_CACHELINE_SPARING_UUID,
+	CXL_FEAT_ROW_SPARING_UUID,
+	CXL_FEAT_BANK_SPARING_UUID,
+	CXL_FEAT_RANK_SPARING_UUID,
+};
+
 #define CXL_FEATURE_MAX_DEVS 65536
 static DEFINE_IDA(cxl_features_ida);
 
@@ -263,3 +274,14 @@ int cxl_set_feature(struct cxl_features *features,
 	} while (true);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_set_feature, "CXL");
+
+bool is_cxl_feature_exclusive(struct cxl_feat_entry *entry)
+{
+	for (int i = 0; i < ARRAY_SIZE(cxl_exclusive_feats); i++) {
+		if (uuid_equal(&entry->uuid, &cxl_exclusive_feats[i]))
+			return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_NS_GPL(is_cxl_feature_exclusive, "CXL");
diff --git a/drivers/cxl/features.c b/drivers/cxl/features.c
index 2faa9e03a840..3388bce5943a 100644
--- a/drivers/cxl/features.c
+++ b/drivers/cxl/features.c
@@ -47,6 +47,7 @@ static int cxl_get_supported_features(struct cxl_features_state *cfs)
 	struct cxl_mbox_get_sup_feats_in mbox_in;
 	struct cxl_feat_entry *entry;
 	struct cxl_mbox_cmd mbox_cmd;
+	int user_feats = 0;
 	int count;
 
 	/* Get supported features is optional, need to check */
@@ -127,6 +128,8 @@ static int cxl_get_supported_features(struct cxl_features_state *cfs)
 			return -ENXIO;
 
 		memcpy(entry, mbox_out->ents, retrieved);
+		if (!is_cxl_feature_exclusive(entry))
+			user_feats++;
 		entry++;
 		/*
 		 * If the number of output entries is less than expected, add the
@@ -138,6 +141,7 @@ static int cxl_get_supported_features(struct cxl_features_state *cfs)
 
 	cfs->num_features = count;
 	cfs->entries = no_free_ptr(entries);
+	cfs->num_user_features = user_feats;
 	return devm_add_action_or_reset(&cfs->features->dev,
 					cxl_free_feature_entries, cfs->entries);
 }
@@ -177,7 +181,7 @@ static ssize_t features_show(struct device *dev, struct device_attribute *attr,
 	if (!cfs)
 		return -ENOENT;
 
-	return sysfs_emit(buf, "%d\n", cfs->num_features);
+	return sysfs_emit(buf, "%d\n", cfs->num_user_features);
 }
 
 static DEVICE_ATTR_RO(features);
diff --git a/include/cxl/features.h b/include/cxl/features.h
index 41d3602b186c..adff3496b4be 100644
--- a/include/cxl/features.h
+++ b/include/cxl/features.h
@@ -5,6 +5,38 @@
 
 #include <linux/uuid.h>
 
+#define CXL_FEAT_PATROL_SCRUB_UUID						\
+	UUID_INIT(0x96dad7d6, 0xfde8, 0x482b, 0xa7, 0x33, 0x75, 0x77, 0x4e,	\
+		  0x06, 0xdb, 0x8a)
+
+#define CXL_FEAT_ECS_UUID							\
+	UUID_INIT(0xe5b13f22, 0x2328, 0x4a14, 0xb8, 0xba, 0xb9, 0x69, 0x1e,	\
+		  0x89, 0x33, 0x86)
+
+#define CXL_FEAT_SPPR_UUID							\
+	UUID_INIT(0x892ba475, 0xfad8, 0x474e, 0x9d, 0x3e, 0x69, 0x2c, 0x91,	\
+		  0x75, 0x68, 0xbb)
+
+#define CXL_FEAT_HPPR_UUID							\
+	UUID_INIT(0x80ea4521, 0x786f, 0x4127, 0xaf, 0xb1, 0xec, 0x74, 0x59,	\
+		  0xfb, 0x0e, 0x24)
+
+#define CXL_FEAT_CACHELINE_SPARING_UUID						\
+	UUID_INIT(0x96C33386, 0x91dd, 0x44c7, 0x9e, 0xcb, 0xfd, 0xaf, 0x65,	\
+		  0x03, 0xba, 0xc4)
+
+#define CXL_FEAT_ROW_SPARING_UUID						\
+	UUID_INIT(0x450ebf67, 0xb135, 0x4f97, 0xa4, 0x98, 0xc2, 0xd5, 0x7f,	\
+		  0x27, 0x9b, 0xed)
+
+#define CXL_FEAT_BANK_SPARING_UUID						\
+	UUID_INIT(0x78b79636, 0x90ac, 0x4b64, 0xa4, 0xef, 0xfa, 0xac, 0x5d,	\
+		  0x18, 0xa8, 0x63)
+
+#define CXL_FEAT_RANK_SPARING_UUID						\
+	UUID_INIT(0x34dbaff5, 0x0552, 0x4281, 0x8f, 0x76, 0xda, 0x0b, 0x5e,	\
+		  0x7a, 0x76, 0xa7)
+
 struct cxl_mailbox;
 
 enum feature_cmds {
@@ -50,6 +82,7 @@ struct cxl_mbox_get_sup_feats_out {
 struct cxl_features_state {
 	struct cxl_features *features;
 	int num_features;
+	int num_user_features;
 	struct cxl_feat_entry *entries;
 };
 
@@ -117,5 +150,6 @@ size_t cxl_get_feature(struct cxl_features *features, const uuid_t feat_uuid,
 int cxl_set_feature(struct cxl_features *features, const uuid_t feat_uuid,
 		    u8 feat_version, void *feat_data, size_t feat_data_size,
 		    u32 feat_flag, u16 offset, u16 *return_code);
+bool is_cxl_feature_exclusive(struct cxl_feat_entry *entry);
 
 #endif
-- 
2.43.0


