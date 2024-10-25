Return-Path: <linux-edac+bounces-2295-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 335219B0AAF
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2024 19:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 566BF1C2331F
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2024 17:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9156620F3DE;
	Fri, 25 Oct 2024 17:14:41 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0178020D516;
	Fri, 25 Oct 2024 17:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729876481; cv=none; b=TjKJ2csssCapJjLMQRBGa6M8azehOnqr7opqqwSssVz/qWVgct0uLUE+XNWM1Z3IYZScIETp850xOGnD8jBq9Ebf6+sVTbGfkETH+ngymgdnSnr8z0T7OP87WXfol5CAaCyQjnVOlRPtO1Ln4igYVmV+rDAcuZzKlQ0LXuy6fb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729876481; c=relaxed/simple;
	bh=T0diDs86ukJqhLSAL3LG81GlyR5mN2AyD+BnHl6anJQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FkQxE1RO3uN94zcXbzd+ganh835vhDSX7XFyqWPpGwPy3WVAH1tAq/CkKN/epHC43eIoo3T8WmuGHm/qjTBUXeBl08aDECuHz6X9+c2+351f5oXG2rLuvLCPkH/b7rkmsY0AVn2mxoH4//iMGmkHfXxtP3eDi0ypUMZ37Z1500k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XZq5s2x2Cz67CxC;
	Sat, 26 Oct 2024 01:09:53 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id D7CFA140A70;
	Sat, 26 Oct 2024 01:14:36 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.151.104) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 19:14:34 +0200
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
Subject: [PATCH v14 05/14] cxl/mbox: Add GET_FEATURE mailbox command
Date: Fri, 25 Oct 2024 18:13:46 +0100
Message-ID: <20241025171356.1377-6-shiju.jose@huawei.com>
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

Add support for GET_FEATURE mailbox command.

CXL spec 3.1 section 8.2.9.6 describes optional device specific features.
The settings of a feature can be retrieved using Get Feature command.
CXL spec 3.1 section 8.2.9.6.2 describes Get Feature command.

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/core/mbox.c | 41 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h    | 26 ++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 5045960e3bfe..3cd4bce2872d 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -970,6 +970,47 @@ int cxl_get_supported_feature_entry(struct cxl_memdev_state *mds, const uuid_t *
 }
 EXPORT_SYMBOL_NS_GPL(cxl_get_supported_feature_entry, CXL);
 
+size_t cxl_get_feature(struct cxl_memdev_state *mds, const uuid_t feat_uuid,
+		       enum cxl_get_feat_selection selection,
+		       void *feat_out, size_t feat_out_size)
+{
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
+	size_t data_to_rd_size, size_out;
+	struct cxl_mbox_get_feat_in pi;
+	struct cxl_mbox_cmd mbox_cmd;
+	size_t data_rcvd_size = 0;
+	int rc;
+
+	if (!feat_out || !feat_out_size)
+		return 0;
+
+	size_out = min(feat_out_size, cxl_mbox->payload_size);
+	pi.uuid = feat_uuid;
+	pi.selection = selection;
+	do {
+		data_to_rd_size = min(feat_out_size - data_rcvd_size,
+				      cxl_mbox->payload_size);
+		pi.offset = cpu_to_le16(data_rcvd_size);
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
+		if (rc < 0 || !mbox_cmd.size_out)
+			return 0;
+		data_rcvd_size += mbox_cmd.size_out;
+	} while (data_rcvd_size < feat_out_size);
+
+	return data_rcvd_size;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_feature, CXL);
+
 /**
  * cxl_enumerate_cmds() - Enumerate commands for a device.
  * @mds: The driver data for the operation
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index f88b10188632..0c152719669a 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -531,6 +531,7 @@ enum cxl_opcode {
 	CXL_MBOX_OP_CLEAR_LOG           = 0x0403,
 	CXL_MBOX_OP_GET_SUP_LOG_SUBLIST = 0x0405,
 	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
+	CXL_MBOX_OP_GET_FEATURE		= 0x0501,
 	CXL_MBOX_OP_IDENTIFY		= 0x4000,
 	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
 	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
@@ -856,6 +857,28 @@ struct cxl_mbox_get_sup_feats_out {
 	struct cxl_feat_entry ents[] __counted_by_le(supported_feats);
 } __packed;
 
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
 int cxl_internal_send_cmd(struct cxl_mailbox *cxl_mbox,
 			  struct cxl_mbox_cmd *cmd);
 int cxl_dev_state_identify(struct cxl_memdev_state *mds);
@@ -919,4 +942,7 @@ void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
 int cxl_get_supported_features(struct cxl_memdev_state *mds);
 int cxl_get_supported_feature_entry(struct cxl_memdev_state *mds, const uuid_t *feat_uuid,
 				    struct cxl_feat_entry *feat_entry_out);
+size_t cxl_get_feature(struct cxl_memdev_state *mds, const uuid_t feat_uuid,
+		       enum cxl_get_feat_selection selection,
+		       void *feat_out, size_t feat_out_size);
 #endif /* __CXL_MEM_H__ */
-- 
2.34.1


