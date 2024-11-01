Return-Path: <linux-edac+bounces-2391-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD139B8D8D
	for <lists+linux-edac@lfdr.de>; Fri,  1 Nov 2024 10:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D353CB238D9
	for <lists+linux-edac@lfdr.de>; Fri,  1 Nov 2024 09:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B4016F0D0;
	Fri,  1 Nov 2024 09:18:05 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3D3156883;
	Fri,  1 Nov 2024 09:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730452685; cv=none; b=pk074HGFsemUb0QlgUudbTZaGdeA1tWlu4JDhtXl84JbABdg+Fze4XrtuKQRqliiCvLXuGYKQIbShVA7TDI5UQXaMSf/gi6akJG1zR3Up20IhU+6uIls1I5Qj3MAd/eAaDsCM3EFLoliDl9q2jOX+bYBP2itS7N0kY02e6UHgRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730452685; c=relaxed/simple;
	bh=ajB6vUkb5ONQJ9QgKSFCpaBQzjP6/jZcVhfcwd4Eq1c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BF6f3FW8yjbCWZh8ymxp2xW6Uom6I18lzSz/gj/8LPNPHyhIr6BG+U7YcgJ20ZlwqCtfLv4l4gBZQaNFhe156b+gTVcQ491Li0dJhejmcO6Sx9vkj/KYLhUneFZTbcJb79zQZU/142MwrOPKJXuYi7A77EqryVEH7Z9R+YhpIUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XfwBV6F27z6L6w8;
	Fri,  1 Nov 2024 17:13:06 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id A30AD140D1D;
	Fri,  1 Nov 2024 17:18:00 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.171.129) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 10:17:58 +0100
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
Subject: [PATCH v15 04/15] cxl: Add Get Supported Features command for kernel usage
Date: Fri, 1 Nov 2024 09:17:22 +0000
Message-ID: <20241101091735.1465-5-shiju.jose@huawei.com>
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
 drivers/cxl/core/mbox.c      | 175 +++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h         |  47 ++++++++++
 drivers/cxl/pci.c            |   4 +
 include/cxl/mailbox.h        |   4 +
 include/uapi/linux/cxl_mem.h |   1 +
 5 files changed, 231 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 5175138c4fb7..5045960e3bfe 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -67,6 +67,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
 	CXL_CMD(SET_SHUTDOWN_STATE, 0x1, 0, 0),
 	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
 	CXL_CMD(GET_TIMESTAMP, 0, 0x8, 0),
+	CXL_CMD(GET_SUPPORTED_FEATURES, 0x8, CXL_VARIABLE_PAYLOAD, 0),
 };
 
 /*
@@ -795,6 +796,180 @@ static const uuid_t log_uuid[] = {
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
+	mbox_in.count = sizeof(mbox_out);
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
+	if (!cxl_mbox->num_features)
+		return -ENOENT;
+
+	return 0;
+}
+
+int cxl_get_supported_features(struct cxl_memdev_state *mds)
+{
+	int remain_feats, max_size, max_feats, start, rc;
+	struct cxl_dev_state *cxlds = &mds->cxlds;
+	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
+	int feat_size = sizeof(struct cxl_feat_entry);
+	struct cxl_mbox_get_sup_feats_out *mbox_out;
+	struct cxl_mbox_get_sup_feats_in mbox_in;
+	int hdr_size = sizeof(*mbox_out);
+	struct cxl_mbox_cmd mbox_cmd;
+	struct cxl_mem_command *cmd;
+	void *ptr;
+
+	/* Get supported features is optional, need to check */
+	cmd = cxl_mem_find_command(CXL_MBOX_OP_GET_SUPPORTED_FEATURES);
+	if (!cmd)
+		return -EOPNOTSUPP;
+	if (!test_bit(cmd->info.id, mds->enabled_cmds))
+		return -EOPNOTSUPP;
+
+	rc = cxl_get_supported_features_count(cxlds);
+	if (rc)
+		return rc;
+
+	struct cxl_feat_entry *entries __free(kvfree) =
+		kvmalloc(cxl_mbox->num_features * feat_size, GFP_KERNEL);
+
+	if (!entries)
+		return -ENOMEM;
+
+	cxl_mbox->entries = no_free_ptr(entries);
+	rc = devm_add_action_or_reset(cxl_mbox->host, cxl_free_features,
+				      cxl_mbox->entries);
+	if (rc)
+		return rc;
+
+	max_size = cxl_mbox->payload_size - hdr_size;
+	/* max feat entries that can fit in mailbox max payload size */
+	max_feats = max_size / feat_size;
+	ptr = &cxl_mbox->entries[0];
+
+	mbox_out = kvmalloc(cxl_mbox->payload_size, GFP_KERNEL);
+	if (!mbox_out)
+		return -ENOMEM;
+
+	start = 0;
+	remain_feats = cxl_mbox->num_features;
+	do {
+		int retrieved, alloc_size, copy_feats;
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
+		mbox_in.count = alloc_size;
+		mbox_in.start_idx = start;
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
+			goto err;
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
+		/*
+		 * If the reported output entries * defined entry size !=
+		 * retrieved output bytes, then the output package is incorrect.
+		 */
+		if (mbox_out->num_entries * feat_size != retrieved) {
+			rc = -ENXIO;
+			goto err;
+		}
+
+		memcpy(ptr, mbox_out->ents, retrieved);
+		ptr += retrieved;
+		/*
+		 * If the number of output entries is less than expected, add the
+		 * remaining entries to the next batch.
+		 */
+		remain_feats += copy_feats - mbox_out->num_entries;
+		start += mbox_out->num_entries;
+	} while (remain_feats);
+
+	kfree(mbox_out);
+	return 0;
+
+err:
+	kfree(mbox_out);
+	cxl_mbox->num_features = 0;
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_supported_features, CXL);
+
+int cxl_get_supported_feature_entry(struct cxl_memdev_state *mds, const uuid_t *feat_uuid,
+				    struct cxl_feat_entry *feat_entry_out)
+{
+	struct cxl_dev_state *cxlds = &mds->cxlds;
+	struct cxl_feat_entry *feat_entry;
+	int count;
+
+	/* Check CXL dev supports the feature */
+	feat_entry = &cxlds->cxl_mbox.entries[0];
+	for (count = 0; count < cxlds->cxl_mbox.num_features; count++, feat_entry++) {
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
index 2a25d1957ddb..f88b10188632 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -530,6 +530,7 @@ enum cxl_opcode {
 	CXL_MBOX_OP_GET_LOG_CAPS	= 0x0402,
 	CXL_MBOX_OP_CLEAR_LOG           = 0x0403,
 	CXL_MBOX_OP_GET_SUP_LOG_SUBLIST = 0x0405,
+	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
 	CXL_MBOX_OP_IDENTIFY		= 0x4000,
 	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
 	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
@@ -813,6 +814,48 @@ enum {
 	CXL_PMEM_SEC_PASS_USER,
 };
 
+/* Get Supported Features (0x500h) CXL r3.1 8.2.9.6.1 */
+struct cxl_mbox_get_sup_feats_in {
+	__le32 count;
+	__le16 start_idx;
+	u8 reserved[2];
+} __packed;
+
+/* Supported Feature Entry : Payload out attribute flags */
+#define CXL_FEAT_ENTRY_FLAG_CHANGABLE	BIT(0)
+#define CXL_FEAT_ENTRY_FLAG_DEEPEST_RESET_PERSISTENCE_MASK	GENMASK(3, 1)
+#define CXL_FEAT_ENTRY_FLAG_PERSIST_ACROSS_FIRMWARE_UPDATE	BIT(4)
+#define CXL_FEAT_ENTRY_FLAG_SUPPORT_DEFAULT_SELECTION	BIT(5)
+#define CXL_FEAT_ENTRY_FLAG_SUPPORT_SAVED_SELECTION	BIT(6)
+
+enum cxl_feat_attr_value_persistence {
+	CXL_FEAT_ATTR_VALUE_PERSISTENCE_NONE,
+	CXL_FEAT_ATTR_VALUE_PERSISTENCE_CXL_RESET,
+	CXL_FEAT_ATTR_VALUE_PERSISTENCE_HOT_RESET,
+	CXL_FEAT_ATTR_VALUE_PERSISTENCE_WARM_RESET,
+	CXL_FEAT_ATTR_VALUE_PERSISTENCE_COLD_RESET,
+	CXL_FEAT_ATTR_VALUE_PERSISTENCE_MAX
+};
+
+struct cxl_feat_entry {
+	uuid_t uuid;
+	__le16 id;
+	__le16 get_feat_size;
+	__le16 set_feat_size;
+	__le32 attr_flags;
+	u8 get_feat_ver;
+	u8 set_feat_ver;
+	__le16 set_effects;
+	u8 reserved[18];
+} __packed;
+
+struct cxl_mbox_get_sup_feats_out {
+	__le16 num_entries;
+	__le16 supported_feats;
+	u8 reserved[4];
+	struct cxl_feat_entry ents[] __counted_by_le(supported_feats);
+} __packed;
+
 int cxl_internal_send_cmd(struct cxl_mailbox *cxl_mbox,
 			  struct cxl_mbox_cmd *cmd);
 int cxl_dev_state_identify(struct cxl_memdev_state *mds);
@@ -872,4 +915,8 @@ struct cxl_hdm {
 struct seq_file;
 struct dentry *cxl_debugfs_create_dir(const char *dir);
 void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
+
+int cxl_get_supported_features(struct cxl_memdev_state *mds);
+int cxl_get_supported_feature_entry(struct cxl_memdev_state *mds, const uuid_t *feat_uuid,
+				    struct cxl_feat_entry *feat_entry_out);
 #endif /* __CXL_MEM_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 188412d45e0d..5c2926eec3c3 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -887,6 +887,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
+	rc = cxl_get_supported_features(mds);
+	if (rc)
+		dev_dbg(&pdev->dev, "No features enumerated.\n");
+
 	rc = cxl_set_timestamp(mds);
 	if (rc)
 		return rc;
diff --git a/include/cxl/mailbox.h b/include/cxl/mailbox.h
index bacd111e75f1..cc66afec3473 100644
--- a/include/cxl/mailbox.h
+++ b/include/cxl/mailbox.h
@@ -14,6 +14,8 @@ struct cxl_mbox_cmd;
  * @mbox_mutex: mutex protects device mailbox and firmware
  * @mbox_wait: rcuwait for mailbox
  * @mbox_send: @dev specific transport for transmitting mailbox commands
+ * @num_features: number of supported features
+ * @entries: list of supported feature entries.
  */
 struct cxl_mailbox {
 	struct device *host;
@@ -21,6 +23,8 @@ struct cxl_mailbox {
 	struct mutex mbox_mutex; /* lock to protect mailbox context */
 	struct rcuwait mbox_wait;
 	int (*mbox_send)(struct cxl_mailbox *cxl_mbox, struct cxl_mbox_cmd *cmd);
+	int num_features;
+	struct cxl_feat_entry *entries;
 };
 
 int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host);
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
2.34.1


