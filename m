Return-Path: <linux-edac+bounces-3384-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0D0A6ACC0
	for <lists+linux-edac@lfdr.de>; Thu, 20 Mar 2025 19:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F225A487E8F
	for <lists+linux-edac@lfdr.de>; Thu, 20 Mar 2025 18:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30D3229B1F;
	Thu, 20 Mar 2025 18:05:46 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5E0226CE5;
	Thu, 20 Mar 2025 18:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742493946; cv=none; b=c1Z55ZRnPT4AXQFVeSFXPN8IBnDN0f9eGStu7j/y8b4z/mbWAKOaYXgciL1WtN3QG1KIs7oMQuxQc9mXDizGQeI8WtlvV2ibpHhGBazRfL3ug7/35EoVh9Ykj0f486zuk3ZvPPo82MpCkCan90K4TPi78TdfEHx3ZdaLoF/Ir/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742493946; c=relaxed/simple;
	bh=o+yL9tkFoVdL13trPIrqDxF2bvZz2EoXjvJ1ME/Cw84=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YPiSqhQgdaJASaZht4B9SmDc6VUCvQFeIPPX9PrqfNw0PUCf1T+Dlyb+9wWSK7SVZFgvI+EI1dIuwizqcy6Nj5YBEGH8sJWVJrlEx9vPod1R+a1frsIhGtNgrhRxmYQZS63QmCXmBP5RrNe0vnYFFK6nk8kI12n+6k6V45yC6rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZJYMR6rbcz6K9Lg;
	Fri, 21 Mar 2025 02:02:43 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 794921405A0;
	Fri, 21 Mar 2025 02:05:42 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.156.145) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Mar 2025 19:05:40 +0100
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
Subject: [PATCH v2 5/8] cxl/mbox: Add support for PERFORM_MAINTENANCE mailbox command
Date: Thu, 20 Mar 2025 18:04:42 +0000
Message-ID: <20250320180450.539-6-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250320180450.539-1-shiju.jose@huawei.com>
References: <20250320180450.539-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Add support for PERFORM_MAINTENANCE mailbox command.

CXL spec 3.2 section 8.2.10.7.1 describes the Perform Maintenance command.
This command requests the device to execute the maintenance operation
specified by the maintenance operation class and the maintenance operation
subclass.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/core/mbox.c | 34 ++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h    | 17 +++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index d72764056ce6..19d46a284650 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -824,6 +824,40 @@ static const uuid_t log_uuid[] = {
 	[VENDOR_DEBUG_UUID] = DEFINE_CXL_VENDOR_DEBUG_UUID,
 };
 
+int cxl_do_maintenance(struct cxl_mailbox *cxl_mbox,
+		       u8 class, u8 subclass,
+		       void *data_in, size_t data_in_size)
+{
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
+EXPORT_SYMBOL_NS_GPL(cxl_do_maintenance, "CXL");
+
 /**
  * cxl_enumerate_cmds() - Enumerate commands for a device.
  * @mds: The driver data for the operation
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 11fa98cc4d9c..7ab257e0c85e 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -527,6 +527,7 @@ enum cxl_opcode {
 	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
 	CXL_MBOX_OP_GET_FEATURE		= 0x0501,
 	CXL_MBOX_OP_SET_FEATURE		= 0x0502,
+	CXL_MBOX_OP_DO_MAINTENANCE	= 0x0600,
 	CXL_MBOX_OP_IDENTIFY		= 0x4000,
 	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
 	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
@@ -827,6 +828,19 @@ enum {
 	CXL_PMEM_SEC_PASS_USER,
 };
 
+/*
+ * Perform Maintenance CXL 3.2 Spec 8.2.10.7.1
+ */
+
+/*
+ * Perform Maintenance input payload
+ * CXL rev 3.2 section 8.2.10.7.1 Table 8-117
+ */
+struct cxl_mbox_do_maintenance_hdr {
+	u8 op_class;
+	u8 op_subclass;
+}  __packed;
+
 int cxl_internal_send_cmd(struct cxl_mailbox *cxl_mbox,
 			  struct cxl_mbox_cmd *cmd);
 int cxl_dev_state_identify(struct cxl_memdev_state *mds);
@@ -898,4 +912,7 @@ struct cxl_hdm {
 struct seq_file;
 struct dentry *cxl_debugfs_create_dir(const char *dir);
 void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
+int cxl_do_maintenance(struct cxl_mailbox *cxl_mbox,
+		       u8 class, u8 subclass,
+		       void *data_in, size_t data_in_size);
 #endif /* __CXL_MEM_H__ */
-- 
2.43.0


