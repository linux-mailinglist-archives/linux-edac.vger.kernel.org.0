Return-Path: <linux-edac+bounces-2804-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D9EA024FF
	for <lists+linux-edac@lfdr.de>; Mon,  6 Jan 2025 13:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8E523A5625
	for <lists+linux-edac@lfdr.de>; Mon,  6 Jan 2025 12:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9931DEFFD;
	Mon,  6 Jan 2025 12:11:59 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2D81DD874;
	Mon,  6 Jan 2025 12:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736165519; cv=none; b=BF7TUuwwbYYnOzRU44wmr9TKIpv6kKenWGiqHKQEzeyPe9RQgZLCdsojdaAYlWu8D5YPp2E9dR4gfs5ipJtVm3R6ZMLKelLZ2vfqSDFaW879vuS33mBaIzlV939LkBC1RhP+BuAVc+ubu1LVWK3GKTZcXlUlBZ0UK4Gdl0gWJZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736165519; c=relaxed/simple;
	bh=+yx7xCnt0ZOemBGyckjkr4z6UlqXQFF3Ep1mw3tNee4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lait1fUb/7AC0d5R5WBV+D7ccR5LB5pRq4j3yRdqy8SPIPSPMEVbnTv1Kca8W/7yQY8csiVf+zAeg3NnZipE3HvTYBzaG+dYe2udTSYBwW8AwxZABqim6QKdtGr38Jr9PTysGuQG/EngIAh+VDWRyxQW1UH0j4nzuTiQND21/tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YRXxB43NLz6K8qh;
	Mon,  6 Jan 2025 20:07:26 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 26439140A08;
	Mon,  6 Jan 2025 20:11:56 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.170.95) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 6 Jan 2025 13:11:54 +0100
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
Subject: [PATCH v18 12/19] cxl/mbox: Add GET_FEATURE mailbox command
Date: Mon, 6 Jan 2025 12:10:08 +0000
Message-ID: <20250106121017.1620-13-shiju.jose@huawei.com>
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

From: Shiju Jose <shiju.jose@huawei.com>

Add support for GET_FEATURE mailbox command.

CXL spec 3.1 section 8.2.9.6 describes optional device specific features.
The settings of a feature can be retrieved using Get Feature command.
CXL spec 3.1 section 8.2.9.6.2 describes Get Feature command.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/features.c | 74 +++++++++++++++++++++++++++++++++++++
 drivers/cxl/features.c      |  6 +--
 include/cxl/features.h      | 27 ++++++++++++++
 3 files changed, 102 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index 66a4b82910e6..ab9386b53a95 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -4,6 +4,7 @@
 #include <cxl/mailbox.h>
 #include "cxl.h"
 #include "core.h"
+#include "cxlmem.h"
 
 #define CXL_FEATURE_MAX_DEVS 65536
 static DEFINE_IDA(cxl_features_ida);
@@ -97,3 +98,76 @@ cxl_get_supported_feature_entry(struct cxl_features *features,
 	return ERR_PTR(-ENOENT);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_get_supported_feature_entry, "CXL");
+
+bool cxl_feature_enabled(struct cxl_features_state *cfs, u16 opcode)
+{
+	struct cxl_mailbox *cxl_mbox = cfs->features->cxl_mbox;
+	struct cxl_mem_command *cmd;
+
+	cmd = cxl_find_feature_command(opcode);
+	if (!cmd)
+		return false;
+
+	return test_bit(cmd->info.id, cxl_mbox->feature_cmds);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_feature_enabled, "CXL");
+
+size_t cxl_get_feature(struct cxl_features *features, const uuid_t feat_uuid,
+		       enum cxl_get_feat_selection selection,
+		       void *feat_out, size_t feat_out_size, u16 offset,
+		       u16 *return_code)
+{
+	size_t data_to_rd_size, size_out;
+	struct cxl_features_state *cfs;
+	struct cxl_mbox_get_feat_in pi;
+	struct cxl_mailbox *cxl_mbox;
+	struct cxl_mbox_cmd mbox_cmd;
+	size_t data_rcvd_size = 0;
+	int rc;
+
+	if (return_code)
+		*return_code = CXL_MBOX_CMD_RC_INPUT;
+
+	cfs = dev_get_drvdata(&features->dev);
+	if (!cfs)
+		return 0;
+
+	if (!cxl_feature_enabled(cfs, CXL_MBOX_OP_GET_FEATURE))
+		return 0;
+
+	if (!feat_out || !feat_out_size)
+		return 0;
+
+	cxl_mbox = features->cxl_mbox;
+	size_out = min(feat_out_size, cxl_mbox->payload_size);
+	pi.uuid = feat_uuid;
+	pi.selection = selection;
+	do {
+		data_to_rd_size = min(feat_out_size - data_rcvd_size,
+				      cxl_mbox->payload_size);
+		pi.offset = cpu_to_le16(offset + data_rcvd_size);
+		pi.count = cpu_to_le16(data_to_rd_size);
+
+		mbox_cmd = (struct cxl_mbox_cmd) {
+			.opcode = CXL_MBOX_OP_GET_FEATURE,
+			.size_in = sizeof(pi),
+			.payload_in = &pi,
+			.size_out = size_out,
+			.payload_out = feat_out + data_rcvd_size,
+			.min_out = data_to_rd_size,
+		};
+		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
+		if (rc < 0 || !mbox_cmd.size_out) {
+			if (return_code)
+				*return_code = mbox_cmd.return_code;
+			return 0;
+		}
+		data_rcvd_size += mbox_cmd.size_out;
+	} while (data_rcvd_size < feat_out_size);
+
+	if (return_code)
+		*return_code = CXL_MBOX_CMD_RC_SUCCESS;
+
+	return data_rcvd_size;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_feature, "CXL");
diff --git a/drivers/cxl/features.c b/drivers/cxl/features.c
index 2f0fb072921e..2faa9e03a840 100644
--- a/drivers/cxl/features.c
+++ b/drivers/cxl/features.c
@@ -47,14 +47,10 @@ static int cxl_get_supported_features(struct cxl_features_state *cfs)
 	struct cxl_mbox_get_sup_feats_in mbox_in;
 	struct cxl_feat_entry *entry;
 	struct cxl_mbox_cmd mbox_cmd;
-	struct cxl_mem_command *cmd;
 	int count;
 
 	/* Get supported features is optional, need to check */
-	cmd = cxl_find_feature_command(CXL_MBOX_OP_GET_SUPPORTED_FEATURES);
-	if (!cmd)
-		return -EOPNOTSUPP;
-	if (!test_bit(cmd->info.id, cxl_mbox->feature_cmds))
+	if (!cxl_feature_enabled(cfs, CXL_MBOX_OP_GET_SUPPORTED_FEATURES))
 		return -EOPNOTSUPP;
 
 	count = cxl_get_supported_features_count(cxl_mbox);
diff --git a/include/cxl/features.h b/include/cxl/features.h
index 429b9782667c..582fb85da5b9 100644
--- a/include/cxl/features.h
+++ b/include/cxl/features.h
@@ -53,10 +53,37 @@ struct cxl_features_state {
 	struct cxl_feat_entry *entries;
 };
 
+/*
+ * Get Feature CXL 3.1 Spec 8.2.9.6.2
+ */
+
+/*
+ * Get Feature input payload
+ * CXL rev 3.1 section 8.2.9.6.2 Table 8-99
+ */
+enum cxl_get_feat_selection {
+	CXL_GET_FEAT_SEL_CURRENT_VALUE,
+	CXL_GET_FEAT_SEL_DEFAULT_VALUE,
+	CXL_GET_FEAT_SEL_SAVED_VALUE,
+	CXL_GET_FEAT_SEL_MAX
+};
+
+struct cxl_mbox_get_feat_in {
+	uuid_t uuid;
+	__le16 offset;
+	__le16 count;
+	u8 selection;
+}  __packed;
+
+bool cxl_feature_enabled(struct cxl_features_state *cfs, u16 opcode);
 struct cxl_features *cxl_features_alloc(struct cxl_mailbox *cxl_mbox,
 					struct device *parent);
 struct cxl_feat_entry *
 cxl_get_supported_feature_entry(struct cxl_features *features,
 				const uuid_t *feat_uuid);
+size_t cxl_get_feature(struct cxl_features *features, const uuid_t feat_uuid,
+		       enum cxl_get_feat_selection selection,
+		       void *feat_out, size_t feat_out_size, u16 offset,
+		       u16 *return_code);
 
 #endif
-- 
2.43.0


