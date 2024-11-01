Return-Path: <linux-edac+bounces-2393-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B43669B8D93
	for <lists+linux-edac@lfdr.de>; Fri,  1 Nov 2024 10:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3886E1F22C26
	for <lists+linux-edac@lfdr.de>; Fri,  1 Nov 2024 09:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F056219755A;
	Fri,  1 Nov 2024 09:18:11 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463F71925A9;
	Fri,  1 Nov 2024 09:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730452691; cv=none; b=K3l4iQ9zPBTVyRCOLjtgYAAtvdW7MYZD6IhPWMz4Dg1+eUALXKbcLmbdUcBeTcFY/o7RvBy/1237vVziscB0V6cNuH3pVaG94LuAee7eT7v2BkaZGG3q0uOLJd6+E4QS0mXcf9k7/+bLIRz4ITsfbbpsHGmHITfJxV6evaslOyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730452691; c=relaxed/simple;
	bh=GZDBKRY/r2JAAZBQJKg1D8Adsis4pMVuMCR8H2t79Uk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aHasJYVQl7j5ptiXzXE2C4zWiBsDbqwgDIJjusE4U1Y+yY4S12LnG/JP6qMRrA524soJAXJIyvnaA24LzxZBYCIyuBzufkAdKiTPTlBcmVJRIPEZKp4VzCucd/Lp6s9VO+bjrH3WNpL2JDJSRjTtI2ii08zI9aNEDS+sfGop6AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XfwFM6rzFz6K6Qm;
	Fri,  1 Nov 2024 17:15:35 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id D2066140A36;
	Fri,  1 Nov 2024 17:18:06 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.171.129) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 10:18:04 +0100
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
Subject: [PATCH v15 06/15] cxl/mbox: Add SET_FEATURE mailbox command
Date: Fri, 1 Nov 2024 09:17:24 +0000
Message-ID: <20241101091735.1465-7-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20241101091735.1465-1-shiju.jose@huawei.com>
References: <20241101091735.1465-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Add support for SET_FEATURE mailbox command.

CXL spec 3.1 section 8.2.9.6 describes optional device specific features.
CXL devices support features with changeable attributes.
The settings of a feature can be optionally modified using Set Feature
command.
CXL spec 3.1 section 8.2.9.6.3 describes Set Feature command.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/core/mbox.c | 73 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h    | 34 +++++++++++++++++++
 2 files changed, 107 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 3cd4bce2872d..4b9e62de164b 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1011,6 +1011,79 @@ size_t cxl_get_feature(struct cxl_memdev_state *mds, const uuid_t feat_uuid,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_get_feature, CXL);
 
+/*
+ * FEAT_DATA_MIN_PAYLOAD_SIZE - min extra number of bytes should be
+ * available in the mailbox for storing the actual feature data so that
+ * the feature data transfer would work as expected.
+ */
+#define FEAT_DATA_MIN_PAYLOAD_SIZE 10
+int cxl_set_feature(struct cxl_memdev_state *mds,
+		    const uuid_t feat_uuid, u8 feat_version,
+		    void *feat_data, size_t feat_data_size,
+		    u8 feat_flag)
+{
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
+	struct cxl_memdev_set_feat_pi {
+		struct cxl_mbox_set_feat_hdr hdr;
+		u8 feat_data[];
+	}  __packed;
+	size_t data_in_size, data_sent_size = 0;
+	struct cxl_mbox_cmd mbox_cmd;
+	size_t hdr_size;
+	int rc = 0;
+
+	struct cxl_memdev_set_feat_pi *pi __free(kfree) =
+					kmalloc(cxl_mbox->payload_size, GFP_KERNEL);
+	pi->hdr.uuid = feat_uuid;
+	pi->hdr.version = feat_version;
+	feat_flag &= ~CXL_SET_FEAT_FLAG_DATA_TRANSFER_MASK;
+	feat_flag |= CXL_SET_FEAT_FLAG_DATA_SAVED_ACROSS_RESET;
+	hdr_size = sizeof(pi->hdr);
+	/*
+	 * Check minimum mbox payload size is available for
+	 * the feature data transfer.
+	 */
+	if (hdr_size + FEAT_DATA_MIN_PAYLOAD_SIZE > cxl_mbox->payload_size)
+		return -ENOMEM;
+
+	if ((hdr_size + feat_data_size) <= cxl_mbox->payload_size) {
+		pi->hdr.flags = cpu_to_le32(feat_flag |
+				       CXL_SET_FEAT_FLAG_FULL_DATA_TRANSFER);
+		data_in_size = feat_data_size;
+	} else {
+		pi->hdr.flags = cpu_to_le32(feat_flag |
+				       CXL_SET_FEAT_FLAG_INITIATE_DATA_TRANSFER);
+		data_in_size = cxl_mbox->payload_size - hdr_size;
+	}
+
+	do {
+		pi->hdr.offset = cpu_to_le16(data_sent_size);
+		memcpy(pi->feat_data, feat_data + data_sent_size, data_in_size);
+		mbox_cmd = (struct cxl_mbox_cmd) {
+			.opcode = CXL_MBOX_OP_SET_FEATURE,
+			.size_in = hdr_size + data_in_size,
+			.payload_in = pi,
+		};
+		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
+		if (rc < 0)
+			return rc;
+
+		data_sent_size += data_in_size;
+		if (data_sent_size >= feat_data_size)
+			return 0;
+
+		if ((feat_data_size - data_sent_size) <= (cxl_mbox->payload_size - hdr_size)) {
+			data_in_size = feat_data_size - data_sent_size;
+			pi->hdr.flags = cpu_to_le32(feat_flag |
+					       CXL_SET_FEAT_FLAG_FINISH_DATA_TRANSFER);
+		} else {
+			pi->hdr.flags = cpu_to_le32(feat_flag |
+					       CXL_SET_FEAT_FLAG_CONTINUE_DATA_TRANSFER);
+		}
+	} while (true);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_set_feature, CXL);
+
 /**
  * cxl_enumerate_cmds() - Enumerate commands for a device.
  * @mds: The driver data for the operation
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 0c152719669a..fb356be8b426 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -532,6 +532,7 @@ enum cxl_opcode {
 	CXL_MBOX_OP_GET_SUP_LOG_SUBLIST = 0x0405,
 	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
 	CXL_MBOX_OP_GET_FEATURE		= 0x0501,
+	CXL_MBOX_OP_SET_FEATURE		= 0x0502,
 	CXL_MBOX_OP_IDENTIFY		= 0x4000,
 	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
 	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
@@ -879,6 +880,35 @@ struct cxl_mbox_get_feat_in {
 	u8 selection;
 }  __packed;
 
+/*
+ * Set Feature CXL 3.1 Spec 8.2.9.6.3
+ */
+
+/*
+ * Set Feature input payload
+ * CXL rev 3.1 section 8.2.9.6.3 Table 8-101
+ */
+/* Set Feature : Payload in flags */
+#define CXL_SET_FEAT_FLAG_DATA_TRANSFER_MASK	GENMASK(2, 0)
+enum cxl_set_feat_flag_data_transfer {
+	CXL_SET_FEAT_FLAG_FULL_DATA_TRANSFER,
+	CXL_SET_FEAT_FLAG_INITIATE_DATA_TRANSFER,
+	CXL_SET_FEAT_FLAG_CONTINUE_DATA_TRANSFER,
+	CXL_SET_FEAT_FLAG_FINISH_DATA_TRANSFER,
+	CXL_SET_FEAT_FLAG_ABORT_DATA_TRANSFER,
+	CXL_SET_FEAT_FLAG_DATA_TRANSFER_MAX
+};
+
+#define CXL_SET_FEAT_FLAG_DATA_SAVED_ACROSS_RESET	BIT(3)
+
+struct cxl_mbox_set_feat_hdr {
+	uuid_t uuid;
+	__le32 flags;
+	__le16 offset;
+	u8 version;
+	u8 rsvd[9];
+}  __packed;
+
 int cxl_internal_send_cmd(struct cxl_mailbox *cxl_mbox,
 			  struct cxl_mbox_cmd *cmd);
 int cxl_dev_state_identify(struct cxl_memdev_state *mds);
@@ -945,4 +975,8 @@ int cxl_get_supported_feature_entry(struct cxl_memdev_state *mds, const uuid_t *
 size_t cxl_get_feature(struct cxl_memdev_state *mds, const uuid_t feat_uuid,
 		       enum cxl_get_feat_selection selection,
 		       void *feat_out, size_t feat_out_size);
+int cxl_set_feature(struct cxl_memdev_state *mds,
+		    const uuid_t feat_uuid, u8 feat_version,
+		    void *feat_data, size_t feat_data_size,
+		    u8 feat_flag);
 #endif /* __CXL_MEM_H__ */
-- 
2.34.1


