Return-Path: <linux-edac+bounces-1673-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8BD954F3E
	for <lists+linux-edac@lfdr.de>; Fri, 16 Aug 2024 18:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28F111F27E4F
	for <lists+linux-edac@lfdr.de>; Fri, 16 Aug 2024 16:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D941C7B85;
	Fri, 16 Aug 2024 16:43:58 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2EF1C68B9;
	Fri, 16 Aug 2024 16:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723826638; cv=none; b=sBONySZ6Uc+f14ay5lbFrxPTMgrA9N7TQ6fkqJPXea5BNHQYD47sjCyOvH/jYRQ+PgQv8LvuyrI3Deorurb8T+DknXgyARtFjP8U3VaPaRmhprBvIc5E/Xi9itmKtW3BmuAHeGSs6fjnUd/yWMOZqQGKk1v6fbg0Nc2s1FwAtZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723826638; c=relaxed/simple;
	bh=1uPdspUH7KkOy9kqMDljjGCRmbr8cq4qFugjulrGnDo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qNHhcDCIbQUMrSFQSeSLioAzv14EIjXJKlVUfJ9drb1A6AATA1d2eg2HM1y4c/j5gxOL2w+MiL7xaeApJ9Vy+ENnJnGFAi8gE8R4Ysza85Hnl65pNfYWhvXnwgS/9JT4uONPbUIM3uj8P/7c5yVf7Msr6m6OUO6XU+sJmJJkWoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wlnml4kNZz6K95v;
	Sat, 17 Aug 2024 00:40:55 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id E7E63140680;
	Sat, 17 Aug 2024 00:43:53 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.148.43) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 17:43:52 +0100
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
Subject: [PATCH v11 13/14] cxl/mbox: Add support for PERFORM_MAINTENANCE mailbox command
Date: Fri, 16 Aug 2024 17:42:36 +0100
Message-ID: <20240816164238.1902-14-shiju.jose@huawei.com>
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

Add support for PERFORM_MAINTENANCE mailbox command.

CXL spec 3.1 section 8.2.9.7.1 describes the Perform Maintenance command.
This command requests the device to execute the maintenance operation
specified by the maintenance operation class and the maintenance operation
subclass.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/core/mbox.c | 39 +++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h    | 17 +++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index f79269add159..1665365a1e26 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1504,6 +1504,45 @@ int cxl_set_feature(struct cxl_memdev_state *mds,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_set_feature, CXL);
 
+int cxl_do_maintenance(struct cxl_memdev_state *mds,
+		       u8 class, u8 subclass,
+		       void *data_in, size_t data_in_size)
+{
+	struct cxl_memdev_maintenance_pi {
+		struct cxl_mbox_do_maintenance_hdr hdr;
+		u8 data[];
+	}  __packed;
+	struct cxl_mbox_cmd mbox_cmd;
+	size_t hdr_size;
+	int rc = 0;
+
+	struct cxl_memdev_maintenance_pi *pi __free(kfree) =
+					kmalloc(mds->payload_size, GFP_KERNEL);
+	pi->hdr.op_class = class;
+	pi->hdr.op_subclass = subclass;
+	hdr_size = sizeof(pi->hdr);
+	/*
+	 * Check minimum mbox payload size is available for
+	 * the maintenance data transfer.
+	 */
+	if (hdr_size + data_in_size > mds->payload_size)
+		return -ENOMEM;
+
+	memcpy(pi->data, data_in, data_in_size);
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_DO_MAINTENANCE,
+		.size_in = hdr_size + data_in_size,
+		.payload_in = pi,
+	};
+
+	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	if (rc < 0)
+		return rc;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_do_maintenance, CXL);
+
 int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 		       struct cxl_region *cxlr)
 {
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index c6f6e38bdbcb..f525eb330dea 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -534,6 +534,7 @@ enum cxl_opcode {
 	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
 	CXL_MBOX_OP_GET_FEATURE		= 0x0501,
 	CXL_MBOX_OP_SET_FEATURE		= 0x0502,
+	CXL_MBOX_OP_DO_MAINTENANCE	= 0x0600,
 	CXL_MBOX_OP_IDENTIFY		= 0x4000,
 	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
 	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
@@ -811,6 +812,19 @@ struct cxl_mbox_set_feat_hdr {
 	u8 rsvd[9];
 }  __packed;
 
+/*
+ * Perform Maintenance CXL 3.1 Spec 8.2.9.7.1
+ */
+
+/*
+ * Perform Maintenance input payload
+ * CXL rev 3.1 section 8.2.9.7.1 Table 8-102
+ */
+struct cxl_mbox_do_maintenance_hdr {
+	u8 op_class;
+	u8 op_subclass;
+}  __packed;
+
 /* Get Poison List  CXL 3.0 Spec 8.2.9.8.4.1 */
 struct cxl_mbox_poison_in {
 	__le64 offset;
@@ -955,6 +969,9 @@ int cxl_set_feature(struct cxl_memdev_state *mds,
 		    const uuid_t feat_uuid, u8 feat_version,
 		    void *feat_data, size_t feat_data_size,
 		    u8 feat_flag);
+int cxl_do_maintenance(struct cxl_memdev_state *mds,
+		       u8 class, u8 subclass,
+		       void *data_in, size_t data_in_size);
 int cxl_poison_state_init(struct cxl_memdev_state *mds);
 int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 		       struct cxl_region *cxlr);
-- 
2.34.1


