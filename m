Return-Path: <linux-edac+bounces-2613-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1E79D63C5
	for <lists+linux-edac@lfdr.de>; Fri, 22 Nov 2024 19:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89314B2740D
	for <lists+linux-edac@lfdr.de>; Fri, 22 Nov 2024 18:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618FC1E0B84;
	Fri, 22 Nov 2024 18:04:54 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9251E049C;
	Fri, 22 Nov 2024 18:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732298694; cv=none; b=oZeNFs6kJ3Z9Y+r96bQbWGeHh/z5ixiPtzUCjFJ89KLWNMBEpyw4W9zO8WV7LL3rOwICYkdtVDoA70SPWee3DW7MvbIdRaWsg5O0CtEbuKOzBKLrKkTqDIWVq/XULVwy/LS7QF4wwBPEY9Bj7oc6P0LF9VfkxAHUS7X2sGrkAy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732298694; c=relaxed/simple;
	bh=MBeQNr8IlbhcqWovGcKO8uo3wK0oIqvdXlPBsngJR+M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m0WErN+Kk5A6AE5hwv0B0iBc5xdFvhdIbsO5+Ml0nK9rGEMxRrFZuDHALHLgTIegHXvffNm/yUPn2GSqplIy5G36GYxddDbUCLiodlCqpGM05Lg+OICW+wppPaFFimJ/B7QT7ckmTCVD9iWSOnXzSIS0iFDaJFAA3628wAhSuTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xw2zq2g80z6L77S;
	Sat, 23 Nov 2024 02:04:23 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 28E21140CB9;
	Sat, 23 Nov 2024 02:04:49 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.171.16) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 22 Nov 2024 19:04:47 +0100
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
Subject: [PATCH v17 05/18] cxl: Add Get Supported Features command for kernel usage
Date: Fri, 22 Nov 2024 18:04:02 +0000
Message-ID: <20241122180416.1932-6-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20241122180416.1932-1-shiju.jose@huawei.com>
References: <20241122180416.1932-1-shiju.jose@huawei.com>
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

From: Dave Jiang <dave.jiang@intel.com>

CXL spec r3.1 8.2.9.6.1 Get Supported Features (Opcode 0500h)
The command retrieve the list of supported device-specific features
(identified by UUID) and general information about each Feature.

The driver will retrieve the feature entries in order to make checks and
provide information for the Get Feature and Set Feature command. One of
the main piece of information retrieved are the effects a Set Feature
command would have for a particular feature.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Co-developed-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/core/mbox.c      | 179 +++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h         |  44 +++++++++
 drivers/cxl/pci.c            |   4 +
 include/cxl/mailbox.h        |   4 +
 include/uapi/linux/cxl_mem.h |   1 +
 5 files changed, 232 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 880ac1dba3cc..c5d4c7df2f99 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -67,6 +67,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
 	CXL_CMD(SET_SHUTDOWN_STATE, 0x1, 0, 0),
 	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
 	CXL_CMD(GET_TIMESTAMP, 0, 0x8, 0),
+	CXL_CMD(GET_SUPPORTED_FEATURES, 0x8, CXL_VARIABLE_PAYLOAD, 0),
 };
 
 /*
@@ -790,6 +791,184 @@ static const uuid_t log_uuid[] = {
 	[VENDOR_DEBUG_UUID] = DEFINE_CXL_VENDOR_DEBUG_UUID,
 };
 
+static void cxl_free_features(void *features)
+{
+	kvfree(features);
+}
+
+static int cxl_get_supported_features_count(struct cxl_dev_state *cxlds)
+{
+	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
+	struct cxl_mbox_get_sup_feats_out mbox_out;
+	struct cxl_mbox_get_sup_feats_in mbox_in;
+	struct cxl_mbox_cmd mbox_cmd;
+	int rc;
+
+	memset(&mbox_in, 0, sizeof(mbox_in));
+	mbox_in.count = cpu_to_le32(sizeof(mbox_out));
+	memset(&mbox_out, 0, sizeof(mbox_out));
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_GET_SUPPORTED_FEATURES,
+		.size_in = sizeof(mbox_in),
+		.payload_in = &mbox_in,
+		.size_out = sizeof(mbox_out),
+		.payload_out = &mbox_out,
+		.min_out = sizeof(mbox_out),
+	};
+	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
+	if (rc < 0)
+		return rc;
+
+	cxl_mbox->num_features = le16_to_cpu(mbox_out.supported_feats);
+
+	return 0;
+}
+
+int cxl_get_supported_features(struct cxl_dev_state *cxlds)
+{
+	int remain_feats, max_size, max_feats, start, rc;
+	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
+	int feat_size = sizeof(struct cxl_feat_entry);
+	struct cxl_mbox_get_sup_feats_in mbox_in;
+	struct cxl_mbox_cmd mbox_cmd;
+	struct cxl_feat_entry *entry;
+	struct cxl_mem_command *cmd;
+	int hdr_size;
+
+	/* Get supported features is optional, need to check */
+	cmd = cxl_mem_find_command(CXL_MBOX_OP_GET_SUPPORTED_FEATURES);
+	if (!cmd)
+		return -EOPNOTSUPP;
+	if (!test_bit(cmd->info.id, cxl_mbox->enabled_cmds))
+		return -EOPNOTSUPP;
+
+	rc = cxl_get_supported_features_count(cxlds);
+	if (rc)
+		return rc;
+
+	if (!cxl_mbox->num_features) {
+		dev_dbg(cxl_mbox->host, "No CXL features enumerated.\n");
+		return 0;
+	}
+
+	struct cxl_feat_entry *entries __free(kvfree) =
+		kvmalloc(cxl_mbox->num_features * feat_size, GFP_KERNEL);
+
+	if (!entries)
+		return -ENOMEM;
+
+	struct cxl_mbox_get_sup_feats_out *mbox_out __free(kvfree) =
+				kvmalloc(cxl_mbox->payload_size, GFP_KERNEL);
+	if (!mbox_out)
+		return -ENOMEM;
+
+	hdr_size = sizeof(*mbox_out);
+	max_size = cxl_mbox->payload_size - hdr_size;
+	/* max feat entries that can fit in mailbox max payload size */
+	max_feats = max_size / feat_size;
+	entry = &entries[0];
+
+	start = 0;
+	remain_feats = cxl_mbox->num_features;
+	do {
+		int retrieved, alloc_size, copy_feats;
+		int num_entries;
+
+		if (remain_feats > max_feats) {
+			alloc_size = sizeof(*mbox_out) + max_feats * feat_size;
+			remain_feats = remain_feats - max_feats;
+			copy_feats = max_feats;
+		} else {
+			alloc_size = sizeof(*mbox_out) + remain_feats * feat_size;
+			copy_feats = remain_feats;
+			remain_feats = 0;
+		}
+
+		memset(&mbox_in, 0, sizeof(mbox_in));
+		mbox_in.count = cpu_to_le32(alloc_size);
+		mbox_in.start_idx = cpu_to_le16(start);
+		memset(mbox_out, 0, alloc_size);
+		mbox_cmd = (struct cxl_mbox_cmd) {
+			.opcode = CXL_MBOX_OP_GET_SUPPORTED_FEATURES,
+			.size_in = sizeof(mbox_in),
+			.payload_in = &mbox_in,
+			.size_out = alloc_size,
+			.payload_out = mbox_out,
+			.min_out = hdr_size,
+		};
+		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
+		if (rc < 0)
+			return rc;
+
+		if (mbox_cmd.size_out <= hdr_size) {
+			rc = -ENXIO;
+			goto err;
+		}
+
+		/*
+		 * Make sure retrieved out buffer is multiple of feature
+		 * entries.
+		 */
+		retrieved = mbox_cmd.size_out - hdr_size;
+		if (retrieved % feat_size) {
+			rc = -ENXIO;
+			goto err;
+		}
+
+		num_entries = le16_to_cpu(mbox_out->num_entries);
+		/*
+		 * If the reported output entries * defined entry size !=
+		 * retrieved output bytes, then the output package is incorrect.
+		 */
+		if (num_entries * feat_size != retrieved) {
+			rc = -ENXIO;
+			goto err;
+		}
+
+		memcpy(entry, mbox_out->ents, retrieved);
+		entry++;
+		/*
+		 * If the number of output entries is less than expected, add the
+		 * remaining entries to the next batch.
+		 */
+		remain_feats += copy_feats - num_entries;
+		start += num_entries;
+	} while (remain_feats);
+
+	cxl_mbox->entries = no_free_ptr(entries);
+	rc = devm_add_action_or_reset(cxl_mbox->host, cxl_free_features,
+				      cxl_mbox->entries);
+	if (rc)
+		return rc;
+
+	return 0;
+
+err:
+	cxl_mbox->num_features = 0;
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_supported_features, CXL);
+
+int cxl_get_supported_feature_entry(struct cxl_dev_state *cxlds, const uuid_t *feat_uuid,
+				    struct cxl_feat_entry *feat_entry_out)
+{
+	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
+	struct cxl_feat_entry *feat_entry;
+	int count;
+
+	/* Check CXL dev supports the feature */
+	feat_entry = &cxl_mbox->entries[0];
+	for (count = 0; count < cxl_mbox->num_features; count++, feat_entry++) {
+		if (uuid_equal(&feat_entry->uuid, feat_uuid)) {
+			memcpy(feat_entry_out, feat_entry, sizeof(*feat_entry_out));
+			return 0;
+		}
+	}
+
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_supported_feature_entry, CXL);
+
 /**
  * cxl_enumerate_cmds() - Enumerate commands for a device.
  * @mds: The driver data for the operation
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index a0a49809cd76..eaceb9657cb1 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -490,6 +490,7 @@ enum cxl_opcode {
 	CXL_MBOX_OP_GET_LOG_CAPS	= 0x0402,
 	CXL_MBOX_OP_CLEAR_LOG           = 0x0403,
 	CXL_MBOX_OP_GET_SUP_LOG_SUBLIST = 0x0405,
+	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
 	CXL_MBOX_OP_IDENTIFY		= 0x4000,
 	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
 	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
@@ -773,6 +774,45 @@ enum {
 	CXL_PMEM_SEC_PASS_USER,
 };
 
+/* Get Supported Features (0x500h) CXL r3.1 8.2.9.6.1 */
+struct cxl_mbox_get_sup_feats_in {
+	__le32 count;
+	__le16 start_idx;
+	u8 reserved[2];
+} __packed;
+
+/**
+ * struct cxl_feat_entry - CXL Spec r3.1 Table 8-97
+ * @uuid: Feature identifier
+ * @id: Feature Index
+ * @get_feat_size: Get Feature Size
+ * @set_feat_size: Set Feature Size
+ * @flags: Attribute Flags
+ * @get_feat_ver: Get Feature Version
+ * @set_feat_ver: Set Feature Version
+ * @effects: Effects to the OS and hardware when command is executed.
+ *	     Provided by the device.
+ * @reserved: reserved, must be 0
+ */
+struct cxl_feat_entry {
+	uuid_t uuid;
+	__le16 id;
+	__le16 get_feat_size;
+	__le16 set_feat_size;
+	__le32 flags;
+	u8 get_feat_ver;
+	u8 set_feat_ver;
+	__le16 effects;
+	u8 reserved[18];
+} __packed;
+
+struct cxl_mbox_get_sup_feats_out {
+	__le16 num_entries;
+	__le16 supported_feats;
+	u8 reserved[4];
+	struct cxl_feat_entry ents[] __counted_by_le(num_entries);
+} __packed;
+
 int cxl_internal_send_cmd(struct cxl_mailbox *cxl_mbox,
 			  struct cxl_mbox_cmd *cmd);
 int cxl_dev_state_identify(struct cxl_memdev_state *mds);
@@ -832,4 +872,8 @@ struct cxl_hdm {
 struct seq_file;
 struct dentry *cxl_debugfs_create_dir(const char *dir);
 void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
+
+int cxl_get_supported_features(struct cxl_dev_state *cxlds);
+int cxl_get_supported_feature_entry(struct cxl_dev_state *cxlds, const uuid_t *feat_uuid,
+				    struct cxl_feat_entry *feat_entry_out);
 #endif /* __CXL_MEM_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 188412d45e0d..cbb86ecf0e2f 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -887,6 +887,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
+	rc = cxl_get_supported_features(cxlds);
+	if (rc)
+		dev_dbg(&pdev->dev, "No features enumerated.\n");
+
 	rc = cxl_set_timestamp(mds);
 	if (rc)
 		return rc;
diff --git a/include/cxl/mailbox.h b/include/cxl/mailbox.h
index cc894f07a435..03c4b8ad84c1 100644
--- a/include/cxl/mailbox.h
+++ b/include/cxl/mailbox.h
@@ -50,6 +50,8 @@ struct cxl_mbox_cmd {
  *                (CXL 3.1 8.2.8.4.3 Mailbox Capabilities Register)
  * @mbox_mutex: mutex protects device mailbox and firmware
  * @mbox_wait: rcuwait for mailbox
+ * @num_features: number of supported features entries
+ * @features: list of supported feature entries
  * @mbox_send: @dev specific transport for transmitting mailbox commands
  */
 struct cxl_mailbox {
@@ -59,6 +61,8 @@ struct cxl_mailbox {
 	size_t payload_size;
 	struct mutex mbox_mutex; /* lock to protect mailbox context */
 	struct rcuwait mbox_wait;
+	int num_features;
+	struct cxl_feat_entry *entries;
 	int (*mbox_send)(struct cxl_mailbox *cxl_mbox, struct cxl_mbox_cmd *cmd);
 };
 
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index c6c0fe27495d..bd2535962f70 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -50,6 +50,7 @@
 	___C(GET_LOG_CAPS, "Get Log Capabilities"),			  \
 	___C(CLEAR_LOG, "Clear Log"),					  \
 	___C(GET_SUP_LOG_SUBLIST, "Get Supported Logs Sub-List"),	  \
+	___C(GET_SUPPORTED_FEATURES, "Get Supported Features"),		  \
 	___C(MAX, "invalid / last command")
 
 #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
-- 
2.43.0


