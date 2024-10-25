Return-Path: <linux-edac+bounces-2302-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFBF9B0AF0
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2024 19:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E9271C246B4
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2024 17:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D75B20BB44;
	Fri, 25 Oct 2024 17:15:04 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360A421894D;
	Fri, 25 Oct 2024 17:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729876504; cv=none; b=BPA4j+9QLyvumB9QH/AniGXZ88bMspYMRlTz/StedxcN9QSQbIWuQAOVKQFwQWTMWzcApUbONgI6QPpnAdoI/7PsefIIH/Volg7ATdy/+Xuu4prbtmsw6AEj1jz9hl+qtFz2R93B7FuAKGD0ic9SPcY3T8507dCqDw8jJoYLRz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729876504; c=relaxed/simple;
	bh=FupnhxuSjahKCHkNg3MJ8k+3g63VZ9cU9new3PiUbkM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rz2rAhjbmGZh0UaXQSyyKI2tY2ItE8W6zd1opbe2FEdEC4Xci6kY80aj6ZNX6bh9lVMbd7gciBdy91FNQ94mT2ocT4EEHtSVZol6UMrIAZma9Tvd7o9AUh5X5lKXyK76DTJfIItA6nfJ2ALRWDacBx2ugJ+Dd5z7YTXMtMZvuUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XZq6J4zZcz6LDDh;
	Sat, 26 Oct 2024 01:10:16 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 29D8B1402C7;
	Sat, 26 Oct 2024 01:15:00 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.151.104) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 19:14:57 +0200
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
Subject: [PATCH v14 12/14] cxl/mbox: Add support for PERFORM_MAINTENANCE mailbox command
Date: Fri, 25 Oct 2024 18:13:53 +0100
Message-ID: <20241025171356.1377-13-shiju.jose@huawei.com>
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

Add support for PERFORM_MAINTENANCE mailbox command.

CXL spec 3.1 section 8.2.9.7.1 describes the Perform Maintenance command.
This command requests the device to execute the maintenance operation
specified by the maintenance operation class and the maintenance operation
subclass.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/core/mbox.c | 35 +++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h    | 17 +++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 4b9e62de164b..381cf9d61c85 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1084,6 +1084,41 @@ int cxl_set_feature(struct cxl_memdev_state *mds,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_set_feature, CXL);
 
+int cxl_do_maintenance(struct cxl_memdev_state *mds,
+		       u8 class, u8 subclass,
+		       void *data_in, size_t data_in_size)
+{
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
+	struct cxl_memdev_maintenance_pi {
+		struct cxl_mbox_do_maintenance_hdr hdr;
+		u8 data[];
+	}  __packed;
+	struct cxl_mbox_cmd mbox_cmd;
+	size_t hdr_size;
+
+	struct cxl_memdev_maintenance_pi *pi __free(kfree) =
+					kmalloc(cxl_mbox->payload_size, GFP_KERNEL);
+	pi->hdr.op_class = class;
+	pi->hdr.op_subclass = subclass;
+	hdr_size = sizeof(pi->hdr);
+	/*
+	 * Check minimum mbox payload size is available for
+	 * the maintenance data transfer.
+	 */
+	if (hdr_size + data_in_size > cxl_mbox->payload_size)
+		return -ENOMEM;
+
+	memcpy(pi->data, data_in, data_in_size);
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_DO_MAINTENANCE,
+		.size_in = hdr_size + data_in_size,
+		.payload_in = pi,
+	};
+
+	return cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_do_maintenance, CXL);
+
 /**
  * cxl_enumerate_cmds() - Enumerate commands for a device.
  * @mds: The driver data for the operation
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 9259c5d70a65..28290f7c89f7 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -533,6 +533,7 @@ enum cxl_opcode {
 	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
 	CXL_MBOX_OP_GET_FEATURE		= 0x0501,
 	CXL_MBOX_OP_SET_FEATURE		= 0x0502,
+	CXL_MBOX_OP_DO_MAINTENANCE	= 0x0600,
 	CXL_MBOX_OP_IDENTIFY		= 0x4000,
 	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
 	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
@@ -909,6 +910,19 @@ struct cxl_mbox_set_feat_hdr {
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
 int cxl_internal_send_cmd(struct cxl_mailbox *cxl_mbox,
 			  struct cxl_mbox_cmd *cmd);
 int cxl_dev_state_identify(struct cxl_memdev_state *mds);
@@ -986,4 +1000,7 @@ int cxl_set_feature(struct cxl_memdev_state *mds,
 		    const uuid_t feat_uuid, u8 feat_version,
 		    void *feat_data, size_t feat_data_size,
 		    u8 feat_flag);
+int cxl_do_maintenance(struct cxl_memdev_state *mds,
+		       u8 class, u8 subclass,
+		       void *data_in, size_t data_in_size);
 #endif /* __CXL_MEM_H__ */
-- 
2.34.1


