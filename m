Return-Path: <linux-edac+bounces-1973-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F81996A67
	for <lists+linux-edac@lfdr.de>; Wed,  9 Oct 2024 14:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52DED282D3B
	for <lists+linux-edac@lfdr.de>; Wed,  9 Oct 2024 12:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0796A199FC0;
	Wed,  9 Oct 2024 12:43:19 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEF3199EB4;
	Wed,  9 Oct 2024 12:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728477798; cv=none; b=BxipM+lkWLlNSpwxsVn/ds1og81wzihG5WGIk+W9CkDR6G+3gl28xny0kdYvuwwnvgUBKZCgRT48T1c1AOMnVf9d0LWFV4pZiFA+TSJDjyDQtAQ7bINnQo7kfXqP9x7VXIChEdXw0q1rvI91RVCNKyLLVWrJpDYMPB/MqmJte2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728477798; c=relaxed/simple;
	bh=LG1AM+cAWZDf8o4xhnK6NbaWKnRSDBouvHV5Jq27VfE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jeH4uXU/CM19eI3YTiauighKa4iURgg5VF3eUy4WowBs38KIr5TZkUSWn89G9OvOt9zdZYi50ULpSGZGdhtfVfXcXi3bJpq82ZEVlZpl1M2dHZyL5/T4SgQPIHYUc4enMr6NakmoRYNFSU0eDQ79QAqL7H/Ogw9U7lLkbKa4Smc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XNsw45s5Nz6K70v;
	Wed,  9 Oct 2024 20:41:56 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 78F96140B3C;
	Wed,  9 Oct 2024 20:43:14 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.152.209) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Oct 2024 14:43:12 +0200
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
Subject: [PATCH v13 05/18] cxl: Move mailbox related bits to the same context
Date: Wed, 9 Oct 2024 13:41:06 +0100
Message-ID: <20241009124120.1124-6-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20241009124120.1124-1-shiju.jose@huawei.com>
References: <20241009124120.1124-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Dave Jiang <dave.jiang@intel.com>

Create a new 'struct cxl_mailbox' and move all mailbox related bits to
it. This allows isolation of all CXL mailbox data in order to export
some of the calls to external kernel callers and avoid exporting of CXL
driver specific bits such has device states. The allocation of
'struct cxl_mailbox' is also split out with cxl_mailbox_create() so the
mailbox can be created independently.

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Link: https://patch.msgid.link/20240724185649.2574627-2-dave.jiang@intel.com
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core/mbox.c      | 57 ++++++++++++++++++++---------
 drivers/cxl/core/memdev.c    | 18 ++++++----
 drivers/cxl/cxlmem.h         | 21 +++++------
 drivers/cxl/pci.c            | 70 +++++++++++++++++++++++-------------
 drivers/cxl/pmem.c           |  4 ++-
 include/cxl/mailbox.h        | 28 +++++++++++++++
 tools/testing/cxl/test/mem.c | 38 ++++++++++++++------
 7 files changed, 164 insertions(+), 72 deletions(-)
 create mode 100644 include/cxl/mailbox.h

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index e5cdeafdf76e..4d37462125b9 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -244,16 +244,17 @@ static const char *cxl_mem_opcode_to_name(u16 opcode)
 int cxl_internal_send_cmd(struct cxl_memdev_state *mds,
 			  struct cxl_mbox_cmd *mbox_cmd)
 {
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	size_t out_size, min_out;
 	int rc;
 
-	if (mbox_cmd->size_in > mds->payload_size ||
-	    mbox_cmd->size_out > mds->payload_size)
+	if (mbox_cmd->size_in > cxl_mbox->payload_size ||
+	    mbox_cmd->size_out > cxl_mbox->payload_size)
 		return -E2BIG;
 
 	out_size = mbox_cmd->size_out;
 	min_out = mbox_cmd->min_out;
-	rc = mds->mbox_send(mds, mbox_cmd);
+	rc = cxl_mbox->mbox_send(cxl_mbox, mbox_cmd);
 	/*
 	 * EIO is reserved for a payload size mismatch and mbox_send()
 	 * may not return this error.
@@ -353,6 +354,7 @@ static int cxl_mbox_cmd_ctor(struct cxl_mbox_cmd *mbox,
 			     struct cxl_memdev_state *mds, u16 opcode,
 			     size_t in_size, size_t out_size, u64 in_payload)
 {
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	*mbox = (struct cxl_mbox_cmd) {
 		.opcode = opcode,
 		.size_in = in_size,
@@ -374,7 +376,7 @@ static int cxl_mbox_cmd_ctor(struct cxl_mbox_cmd *mbox,
 
 	/* Prepare to handle a full payload for variable sized output */
 	if (out_size == CXL_VARIABLE_PAYLOAD)
-		mbox->size_out = mds->payload_size;
+		mbox->size_out = cxl_mbox->payload_size;
 	else
 		mbox->size_out = out_size;
 
@@ -398,6 +400,8 @@ static int cxl_to_mem_cmd_raw(struct cxl_mem_command *mem_cmd,
 			      const struct cxl_send_command *send_cmd,
 			      struct cxl_memdev_state *mds)
 {
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
+
 	if (send_cmd->raw.rsvd)
 		return -EINVAL;
 
@@ -406,7 +410,7 @@ static int cxl_to_mem_cmd_raw(struct cxl_mem_command *mem_cmd,
 	 * gets passed along without further checking, so it must be
 	 * validated here.
 	 */
-	if (send_cmd->out.size > mds->payload_size)
+	if (send_cmd->out.size > cxl_mbox->payload_size)
 		return -EINVAL;
 
 	if (!cxl_mem_raw_command_allowed(send_cmd->raw.opcode))
@@ -494,6 +498,7 @@ static int cxl_validate_cmd_from_user(struct cxl_mbox_cmd *mbox_cmd,
 				      struct cxl_memdev_state *mds,
 				      const struct cxl_send_command *send_cmd)
 {
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_mem_command mem_cmd;
 	int rc;
 
@@ -505,7 +510,7 @@ static int cxl_validate_cmd_from_user(struct cxl_mbox_cmd *mbox_cmd,
 	 * supports, but output can be arbitrarily large (simply write out as
 	 * much data as the hardware provides).
 	 */
-	if (send_cmd->in.size > mds->payload_size)
+	if (send_cmd->in.size > cxl_mbox->payload_size)
 		return -EINVAL;
 
 	/* Sanitize and construct a cxl_mem_command */
@@ -591,6 +596,7 @@ static int handle_mailbox_cmd_from_user(struct cxl_memdev_state *mds,
 					u64 out_payload, s32 *size_out,
 					u32 *retval)
 {
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct device *dev = mds->cxlds.dev;
 	int rc;
 
@@ -601,7 +607,7 @@ static int handle_mailbox_cmd_from_user(struct cxl_memdev_state *mds,
 		cxl_mem_opcode_to_name(mbox_cmd->opcode),
 		mbox_cmd->opcode, mbox_cmd->size_in);
 
-	rc = mds->mbox_send(mds, mbox_cmd);
+	rc = cxl_mbox->mbox_send(cxl_mbox, mbox_cmd);
 	if (rc)
 		goto out;
 
@@ -659,11 +665,12 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
 static int cxl_xfer_log(struct cxl_memdev_state *mds, uuid_t *uuid,
 			u32 *size, u8 *out)
 {
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	u32 remaining = *size;
 	u32 offset = 0;
 
 	while (remaining) {
-		u32 xfer_size = min_t(u32, remaining, mds->payload_size);
+		u32 xfer_size = min_t(u32, remaining, cxl_mbox->payload_size);
 		struct cxl_mbox_cmd mbox_cmd;
 		struct cxl_mbox_get_log log;
 		int rc;
@@ -752,17 +759,18 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
 
 static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_memdev_state *mds)
 {
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_mbox_get_supported_logs *ret;
 	struct cxl_mbox_cmd mbox_cmd;
 	int rc;
 
-	ret = kvmalloc(mds->payload_size, GFP_KERNEL);
+	ret = kvmalloc(cxl_mbox->payload_size, GFP_KERNEL);
 	if (!ret)
 		return ERR_PTR(-ENOMEM);
 
 	mbox_cmd = (struct cxl_mbox_cmd) {
 		.opcode = CXL_MBOX_OP_GET_SUPPORTED_LOGS,
-		.size_out = mds->payload_size,
+		.size_out = cxl_mbox->payload_size,
 		.payload_out = ret,
 		/* At least the record number field must be valid */
 		.min_out = 2,
@@ -910,6 +918,7 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
 				  enum cxl_event_log_type log,
 				  struct cxl_get_event_payload *get_pl)
 {
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_mbox_clear_event_payload *payload;
 	u16 total = le16_to_cpu(get_pl->record_count);
 	u8 max_handles = CXL_CLEAR_EVENT_MAX_HANDLES;
@@ -920,8 +929,8 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
 	int i;
 
 	/* Payload size may limit the max handles */
-	if (pl_size > mds->payload_size) {
-		max_handles = (mds->payload_size - sizeof(*payload)) /
+	if (pl_size > cxl_mbox->payload_size) {
+		max_handles = (cxl_mbox->payload_size - sizeof(*payload)) /
 			      sizeof(__le16);
 		pl_size = struct_size(payload, handles, max_handles);
 	}
@@ -979,6 +988,7 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
 static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
 				    enum cxl_event_log_type type)
 {
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
 	struct device *dev = mds->cxlds.dev;
 	struct cxl_get_event_payload *payload;
@@ -995,7 +1005,7 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
 			.payload_in = &log_type,
 			.size_in = sizeof(log_type),
 			.payload_out = payload,
-			.size_out = mds->payload_size,
+			.size_out = cxl_mbox->payload_size,
 			.min_out = struct_size(payload, records, 0),
 		};
 
@@ -1328,6 +1338,7 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 		       struct cxl_region *cxlr)
 {
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_mbox_poison_out *po;
 	struct cxl_mbox_poison_in pi;
 	int nr_records = 0;
@@ -1346,7 +1357,7 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 			.opcode = CXL_MBOX_OP_GET_POISON,
 			.size_in = sizeof(pi),
 			.payload_in = &pi,
-			.size_out = mds->payload_size,
+			.size_out = cxl_mbox->payload_size,
 			.payload_out = po,
 			.min_out = struct_size(po, record, 0),
 		};
@@ -1382,7 +1393,9 @@ static void free_poison_buf(void *buf)
 /* Get Poison List output buffer is protected by mds->poison.lock */
 static int cxl_poison_alloc_buf(struct cxl_memdev_state *mds)
 {
-	mds->poison.list_out = kvmalloc(mds->payload_size, GFP_KERNEL);
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
+
+	mds->poison.list_out = kvmalloc(cxl_mbox->payload_size, GFP_KERNEL);
 	if (!mds->poison.list_out)
 		return -ENOMEM;
 
@@ -1408,6 +1421,19 @@ int cxl_poison_state_init(struct cxl_memdev_state *mds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_poison_state_init, CXL);
 
+int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host)
+{
+	if (!cxl_mbox || !host)
+		return -EINVAL;
+
+	cxl_mbox->host = host;
+	mutex_init(&cxl_mbox->mbox_mutex);
+	rcuwait_init(&cxl_mbox->mbox_wait);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_mailbox_init, CXL);
+
 struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
 {
 	struct cxl_memdev_state *mds;
@@ -1418,7 +1444,6 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
 		return ERR_PTR(-ENOMEM);
 	}
 
-	mutex_init(&mds->mbox_mutex);
 	mutex_init(&mds->event.log_lock);
 	mds->cxlds.dev = dev;
 	mds->cxlds.reg_map.host = dev;
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 0277726afd04..05bb84cb1274 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -58,7 +58,7 @@ static ssize_t payload_max_show(struct device *dev,
 
 	if (!mds)
 		return sysfs_emit(buf, "\n");
-	return sysfs_emit(buf, "%zu\n", mds->payload_size);
+	return sysfs_emit(buf, "%zu\n", cxlds->cxl_mbox.payload_size);
 }
 static DEVICE_ATTR_RO(payload_max);
 
@@ -124,15 +124,16 @@ static ssize_t security_state_show(struct device *dev,
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
 	unsigned long state = mds->security.state;
 	int rc = 0;
 
 	/* sync with latest submission state */
-	mutex_lock(&mds->mbox_mutex);
+	mutex_lock(&cxl_mbox->mbox_mutex);
 	if (mds->security.sanitize_active)
 		rc = sysfs_emit(buf, "sanitize\n");
-	mutex_unlock(&mds->mbox_mutex);
+	mutex_unlock(&cxl_mbox->mbox_mutex);
 	if (rc)
 		return rc;
 
@@ -829,12 +830,13 @@ static enum fw_upload_err cxl_fw_prepare(struct fw_upload *fwl, const u8 *data,
 {
 	struct cxl_memdev_state *mds = fwl->dd_handle;
 	struct cxl_mbox_transfer_fw *transfer;
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 
 	if (!size)
 		return FW_UPLOAD_ERR_INVALID_SIZE;
 
 	mds->fw.oneshot = struct_size(transfer, data, size) <
-			    mds->payload_size;
+			    cxl_mbox->payload_size;
 
 	if (cxl_mem_get_fw_info(mds))
 		return FW_UPLOAD_ERR_HW_ERROR;
@@ -854,6 +856,7 @@ static enum fw_upload_err cxl_fw_write(struct fw_upload *fwl, const u8 *data,
 {
 	struct cxl_memdev_state *mds = fwl->dd_handle;
 	struct cxl_dev_state *cxlds = &mds->cxlds;
+	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
 	struct cxl_memdev *cxlmd = cxlds->cxlmd;
 	struct cxl_mbox_transfer_fw *transfer;
 	struct cxl_mbox_cmd mbox_cmd;
@@ -877,7 +880,7 @@ static enum fw_upload_err cxl_fw_write(struct fw_upload *fwl, const u8 *data,
 	 * sizeof(*transfer) is 128.  These constraints imply that @cur_size
 	 * will always be 128b aligned.
 	 */
-	cur_size = min_t(size_t, size, mds->payload_size - sizeof(*transfer));
+	cur_size = min_t(size_t, size, cxl_mbox->payload_size - sizeof(*transfer));
 
 	remaining = size - cur_size;
 	size_in = struct_size(transfer, data, cur_size);
@@ -1059,16 +1062,17 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, CXL);
 static void sanitize_teardown_notifier(void *data)
 {
 	struct cxl_memdev_state *mds = data;
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct kernfs_node *state;
 
 	/*
 	 * Prevent new irq triggered invocations of the workqueue and
 	 * flush inflight invocations.
 	 */
-	mutex_lock(&mds->mbox_mutex);
+	mutex_lock(&cxl_mbox->mbox_mutex);
 	state = mds->security.sanitize_node;
 	mds->security.sanitize_node = NULL;
-	mutex_unlock(&mds->mbox_mutex);
+	mutex_unlock(&cxl_mbox->mbox_mutex);
 
 	cancel_delayed_work_sync(&mds->security.poll_dwork);
 	sysfs_put(state);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index a81a8982bf93..4ead415f8971 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -3,11 +3,12 @@
 #ifndef __CXL_MEM_H__
 #define __CXL_MEM_H__
 #include <uapi/linux/cxl_mem.h>
+#include <linux/pci.h>
 #include <linux/cdev.h>
 #include <linux/uuid.h>
-#include <linux/rcuwait.h>
 #include <linux/node.h>
 #include <cxl/event.h>
+#include <cxl/mailbox.h>
 #include "cxl.h"
 
 /* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
@@ -424,6 +425,7 @@ struct cxl_dpa_perf {
  * @ram_res: Active Volatile memory capacity configuration
  * @serial: PCIe Device Serial Number
  * @type: Generic Memory Class device or Vendor Specific Memory device
+ * @cxl_mbox: CXL mailbox context
  */
 struct cxl_dev_state {
 	struct device *dev;
@@ -438,8 +440,14 @@ struct cxl_dev_state {
 	struct resource ram_res;
 	u64 serial;
 	enum cxl_devtype type;
+	struct cxl_mailbox cxl_mbox;
 };
 
+static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
+{
+	return dev_get_drvdata(cxl_mbox->host);
+}
+
 /**
  * struct cxl_memdev_state - Generic Type-3 Memory Device Class driver data
  *
@@ -448,11 +456,8 @@ struct cxl_dev_state {
  * the functionality related to that like Identify Memory Device and Get
  * Partition Info
  * @cxlds: Core driver state common across Type-2 and Type-3 devices
- * @payload_size: Size of space for payload
- *                (CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register)
  * @lsa_size: Size of Label Storage Area
  *                (CXL 2.0 8.2.9.5.1.1 Identify Memory Device)
- * @mbox_mutex: Mutex to synchronize mailbox access.
  * @firmware_version: Firmware version for the memory device.
  * @enabled_cmds: Hardware commands found enabled in CEL.
  * @exclusive_cmds: Commands that are kernel-internal only
@@ -470,17 +475,13 @@ struct cxl_dev_state {
  * @poison: poison driver state info
  * @security: security driver state info
  * @fw: firmware upload / activation state
- * @mbox_wait: RCU wait for mbox send completely
- * @mbox_send: @dev specific transport for transmitting mailbox commands
  *
  * See CXL 3.0 8.2.9.8.2 Capacity Configuration and Label Storage for
  * details on capacity parameters.
  */
 struct cxl_memdev_state {
 	struct cxl_dev_state cxlds;
-	size_t payload_size;
 	size_t lsa_size;
-	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
 	char firmware_version[0x10];
 	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
 	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
@@ -500,10 +501,6 @@ struct cxl_memdev_state {
 	struct cxl_poison_state poison;
 	struct cxl_security_state security;
 	struct cxl_fw_state fw;
-
-	struct rcuwait mbox_wait;
-	int (*mbox_send)(struct cxl_memdev_state *mds,
-			 struct cxl_mbox_cmd *cmd);
 };
 
 static inline struct cxl_memdev_state *
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 4be35dc22202..eca6f533386b 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -11,6 +11,7 @@
 #include <linux/pci.h>
 #include <linux/aer.h>
 #include <linux/io.h>
+#include <cxl/mailbox.h>
 #include "cxlmem.h"
 #include "cxlpci.h"
 #include "cxl.h"
@@ -124,6 +125,7 @@ static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
 	u16 opcode;
 	struct cxl_dev_id *dev_id = id;
 	struct cxl_dev_state *cxlds = dev_id->cxlds;
+	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
 
 	if (!cxl_mbox_background_complete(cxlds))
@@ -132,13 +134,13 @@ static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
 	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
 	opcode = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK, reg);
 	if (opcode == CXL_MBOX_OP_SANITIZE) {
-		mutex_lock(&mds->mbox_mutex);
+		mutex_lock(&cxl_mbox->mbox_mutex);
 		if (mds->security.sanitize_node)
 			mod_delayed_work(system_wq, &mds->security.poll_dwork, 0);
-		mutex_unlock(&mds->mbox_mutex);
+		mutex_unlock(&cxl_mbox->mbox_mutex);
 	} else {
 		/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
-		rcuwait_wake_up(&mds->mbox_wait);
+		rcuwait_wake_up(&cxl_mbox->mbox_wait);
 	}
 
 	return IRQ_HANDLED;
@@ -152,8 +154,9 @@ static void cxl_mbox_sanitize_work(struct work_struct *work)
 	struct cxl_memdev_state *mds =
 		container_of(work, typeof(*mds), security.poll_dwork.work);
 	struct cxl_dev_state *cxlds = &mds->cxlds;
+	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
 
-	mutex_lock(&mds->mbox_mutex);
+	mutex_lock(&cxl_mbox->mbox_mutex);
 	if (cxl_mbox_background_complete(cxlds)) {
 		mds->security.poll_tmo_secs = 0;
 		if (mds->security.sanitize_node)
@@ -167,7 +170,7 @@ static void cxl_mbox_sanitize_work(struct work_struct *work)
 		mds->security.poll_tmo_secs = min(15 * 60, timeout);
 		schedule_delayed_work(&mds->security.poll_dwork, timeout * HZ);
 	}
-	mutex_unlock(&mds->mbox_mutex);
+	mutex_unlock(&cxl_mbox->mbox_mutex);
 }
 
 /**
@@ -192,17 +195,18 @@ static void cxl_mbox_sanitize_work(struct work_struct *work)
  * not need to coordinate with each other. The driver only uses the primary
  * mailbox.
  */
-static int __cxl_pci_mbox_send_cmd(struct cxl_memdev_state *mds,
+static int __cxl_pci_mbox_send_cmd(struct cxl_mailbox *cxl_mbox,
 				   struct cxl_mbox_cmd *mbox_cmd)
 {
-	struct cxl_dev_state *cxlds = &mds->cxlds;
+	struct cxl_dev_state *cxlds = mbox_to_cxlds(cxl_mbox);
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
 	void __iomem *payload = cxlds->regs.mbox + CXLDEV_MBOX_PAYLOAD_OFFSET;
 	struct device *dev = cxlds->dev;
 	u64 cmd_reg, status_reg;
 	size_t out_len;
 	int rc;
 
-	lockdep_assert_held(&mds->mbox_mutex);
+	lockdep_assert_held(&cxl_mbox->mbox_mutex);
 
 	/*
 	 * Here are the steps from 8.2.8.4 of the CXL 2.0 spec.
@@ -315,10 +319,10 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_memdev_state *mds,
 
 		timeout = mbox_cmd->poll_interval_ms;
 		for (i = 0; i < mbox_cmd->poll_count; i++) {
-			if (rcuwait_wait_event_timeout(&mds->mbox_wait,
-				       cxl_mbox_background_complete(cxlds),
-				       TASK_UNINTERRUPTIBLE,
-				       msecs_to_jiffies(timeout)) > 0)
+			if (rcuwait_wait_event_timeout(&cxl_mbox->mbox_wait,
+						       cxl_mbox_background_complete(cxlds),
+						       TASK_UNINTERRUPTIBLE,
+						       msecs_to_jiffies(timeout)) > 0)
 				break;
 		}
 
@@ -360,7 +364,7 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_memdev_state *mds,
 		 */
 		size_t n;
 
-		n = min3(mbox_cmd->size_out, mds->payload_size, out_len);
+		n = min3(mbox_cmd->size_out, cxl_mbox->payload_size, out_len);
 		memcpy_fromio(mbox_cmd->payload_out, payload, n);
 		mbox_cmd->size_out = n;
 	} else {
@@ -370,14 +374,14 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_memdev_state *mds,
 	return 0;
 }
 
-static int cxl_pci_mbox_send(struct cxl_memdev_state *mds,
+static int cxl_pci_mbox_send(struct cxl_mailbox *cxl_mbox,
 			     struct cxl_mbox_cmd *cmd)
 {
 	int rc;
 
-	mutex_lock_io(&mds->mbox_mutex);
-	rc = __cxl_pci_mbox_send_cmd(mds, cmd);
-	mutex_unlock(&mds->mbox_mutex);
+	mutex_lock_io(&cxl_mbox->mbox_mutex);
+	rc = __cxl_pci_mbox_send_cmd(cxl_mbox, cmd);
+	mutex_unlock(&cxl_mbox->mbox_mutex);
 
 	return rc;
 }
@@ -385,6 +389,7 @@ static int cxl_pci_mbox_send(struct cxl_memdev_state *mds,
 static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
 {
 	struct cxl_dev_state *cxlds = &mds->cxlds;
+	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
 	const int cap = readl(cxlds->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
 	struct device *dev = cxlds->dev;
 	unsigned long timeout;
@@ -417,8 +422,8 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
 		return -ETIMEDOUT;
 	}
 
-	mds->mbox_send = cxl_pci_mbox_send;
-	mds->payload_size =
+	cxl_mbox->mbox_send = cxl_pci_mbox_send;
+	cxl_mbox->payload_size =
 		1 << FIELD_GET(CXLDEV_MBOX_CAP_PAYLOAD_SIZE_MASK, cap);
 
 	/*
@@ -428,16 +433,15 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
 	 * there's no point in going forward. If the size is too large, there's
 	 * no harm is soft limiting it.
 	 */
-	mds->payload_size = min_t(size_t, mds->payload_size, SZ_1M);
-	if (mds->payload_size < 256) {
+	cxl_mbox->payload_size = min_t(size_t, cxl_mbox->payload_size, SZ_1M);
+	if (cxl_mbox->payload_size < 256) {
 		dev_err(dev, "Mailbox is too small (%zub)",
-			mds->payload_size);
+			cxl_mbox->payload_size);
 		return -ENXIO;
 	}
 
-	dev_dbg(dev, "Mailbox payload sized %zu", mds->payload_size);
+	dev_dbg(dev, "Mailbox payload sized %zu", cxl_mbox->payload_size);
 
-	rcuwait_init(&mds->mbox_wait);
 	INIT_DELAYED_WORK(&mds->security.poll_dwork, cxl_mbox_sanitize_work);
 
 	/* background command interrupts are optional */
@@ -578,9 +582,10 @@ static void free_event_buf(void *buf)
  */
 static int cxl_mem_alloc_event_buf(struct cxl_memdev_state *mds)
 {
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_get_event_payload *buf;
 
-	buf = kvmalloc(mds->payload_size, GFP_KERNEL);
+	buf = kvmalloc(cxl_mbox->payload_size, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 	mds->event.buf = buf;
@@ -786,6 +791,17 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
 	return 0;
 }
 
+static int cxl_pci_type3_init_mailbox(struct cxl_dev_state *cxlds)
+{
+	/*
+	 * Fail the init if there's no mailbox. For a type3 this is out of spec.
+	 */
+	if (!cxlds->reg_map.device_map.mbox.valid)
+		return -ENODEV;
+
+	return cxl_mailbox_init(&cxlds->cxl_mbox, cxlds->dev);
+}
+
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
@@ -846,6 +862,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
 
+	rc = cxl_pci_type3_init_mailbox(cxlds);
+	if (rc)
+		return rc;
+
 	rc = cxl_await_media_ready(cxlds);
 	if (rc == 0)
 		cxlds->media_ready = true;
diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index 4ef93da22335..3985ff9ce70e 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -102,13 +102,15 @@ static int cxl_pmem_get_config_size(struct cxl_memdev_state *mds,
 				    struct nd_cmd_get_config_size *cmd,
 				    unsigned int buf_len)
 {
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
+
 	if (sizeof(*cmd) > buf_len)
 		return -EINVAL;
 
 	*cmd = (struct nd_cmd_get_config_size){
 		.config_size = mds->lsa_size,
 		.max_xfer =
-			mds->payload_size - sizeof(struct cxl_mbox_set_lsa),
+			cxl_mbox->payload_size - sizeof(struct cxl_mbox_set_lsa),
 	};
 
 	return 0;
diff --git a/include/cxl/mailbox.h b/include/cxl/mailbox.h
new file mode 100644
index 000000000000..bacd111e75f1
--- /dev/null
+++ b/include/cxl/mailbox.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2024 Intel Corporation. */
+#ifndef __CXL_MBOX_H__
+#define __CXL_MBOX_H__
+#include <linux/rcuwait.h>
+
+struct cxl_mbox_cmd;
+
+/**
+ * struct cxl_mailbox - context for CXL mailbox operations
+ * @host: device that hosts the mailbox
+ * @payload_size: Size of space for payload
+ *                (CXL 3.1 8.2.8.4.3 Mailbox Capabilities Register)
+ * @mbox_mutex: mutex protects device mailbox and firmware
+ * @mbox_wait: rcuwait for mailbox
+ * @mbox_send: @dev specific transport for transmitting mailbox commands
+ */
+struct cxl_mailbox {
+	struct device *host;
+	size_t payload_size;
+	struct mutex mbox_mutex; /* lock to protect mailbox context */
+	struct rcuwait mbox_wait;
+	int (*mbox_send)(struct cxl_mailbox *cxl_mbox, struct cxl_mbox_cmd *cmd);
+};
+
+int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host);
+
+#endif
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 129f179b0ac5..7b4b8a2aaf61 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -8,6 +8,7 @@
 #include <linux/delay.h>
 #include <linux/sizes.h>
 #include <linux/bits.h>
+#include <cxl/mailbox.h>
 #include <asm/unaligned.h>
 #include <crypto/sha2.h>
 #include <cxlmem.h>
@@ -534,6 +535,7 @@ static int mock_gsl(struct cxl_mbox_cmd *cmd)
 
 static int mock_get_log(struct cxl_memdev_state *mds, struct cxl_mbox_cmd *cmd)
 {
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_mbox_get_log *gl = cmd->payload_in;
 	u32 offset = le32_to_cpu(gl->offset);
 	u32 length = le32_to_cpu(gl->length);
@@ -542,7 +544,7 @@ static int mock_get_log(struct cxl_memdev_state *mds, struct cxl_mbox_cmd *cmd)
 
 	if (cmd->size_in < sizeof(*gl))
 		return -EINVAL;
-	if (length > mds->payload_size)
+	if (length > cxl_mbox->payload_size)
 		return -EINVAL;
 	if (offset + length > sizeof(mock_cel))
 		return -EINVAL;
@@ -617,12 +619,13 @@ void cxl_mockmem_sanitize_work(struct work_struct *work)
 {
 	struct cxl_memdev_state *mds =
 		container_of(work, typeof(*mds), security.poll_dwork.work);
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 
-	mutex_lock(&mds->mbox_mutex);
+	mutex_lock(&cxl_mbox->mbox_mutex);
 	if (mds->security.sanitize_node)
 		sysfs_notify_dirent(mds->security.sanitize_node);
 	mds->security.sanitize_active = false;
-	mutex_unlock(&mds->mbox_mutex);
+	mutex_unlock(&cxl_mbox->mbox_mutex);
 
 	dev_dbg(mds->cxlds.dev, "sanitize complete\n");
 }
@@ -631,6 +634,7 @@ static int mock_sanitize(struct cxl_mockmem_data *mdata,
 			 struct cxl_mbox_cmd *cmd)
 {
 	struct cxl_memdev_state *mds = mdata->mds;
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	int rc = 0;
 
 	if (cmd->size_in != 0)
@@ -648,14 +652,14 @@ static int mock_sanitize(struct cxl_mockmem_data *mdata,
 		return -ENXIO;
 	}
 
-	mutex_lock(&mds->mbox_mutex);
+	mutex_lock(&cxl_mbox->mbox_mutex);
 	if (schedule_delayed_work(&mds->security.poll_dwork,
 				  msecs_to_jiffies(mdata->sanitize_timeout))) {
 		mds->security.sanitize_active = true;
 		dev_dbg(mds->cxlds.dev, "sanitize issued\n");
 	} else
 		rc = -EBUSY;
-	mutex_unlock(&mds->mbox_mutex);
+	mutex_unlock(&cxl_mbox->mbox_mutex);
 
 	return rc;
 }
@@ -1333,12 +1337,13 @@ static int mock_activate_fw(struct cxl_mockmem_data *mdata,
 	return -EINVAL;
 }
 
-static int cxl_mock_mbox_send(struct cxl_memdev_state *mds,
+static int cxl_mock_mbox_send(struct cxl_mailbox *cxl_mbox,
 			      struct cxl_mbox_cmd *cmd)
 {
-	struct cxl_dev_state *cxlds = &mds->cxlds;
-	struct device *dev = cxlds->dev;
+	struct device *dev = cxl_mbox->host;
 	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
+	struct cxl_memdev_state *mds = mdata->mds;
+	struct cxl_dev_state *cxlds = &mds->cxlds;
 	int rc = -EIO;
 
 	switch (cmd->opcode) {
@@ -1453,6 +1458,11 @@ static ssize_t event_trigger_store(struct device *dev,
 }
 static DEVICE_ATTR_WO(event_trigger);
 
+static int cxl_mock_mailbox_create(struct cxl_dev_state *cxlds)
+{
+	return cxl_mailbox_init(&cxlds->cxl_mbox, cxlds->dev);
+}
+
 static int cxl_mock_mem_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1460,6 +1470,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	struct cxl_memdev_state *mds;
 	struct cxl_dev_state *cxlds;
 	struct cxl_mockmem_data *mdata;
+	struct cxl_mailbox *cxl_mbox;
 	int rc;
 
 	mdata = devm_kzalloc(dev, sizeof(*mdata), GFP_KERNEL);
@@ -1487,13 +1498,18 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	if (IS_ERR(mds))
 		return PTR_ERR(mds);
 
+	cxlds = &mds->cxlds;
+	rc = cxl_mock_mailbox_create(cxlds);
+	if (rc)
+		return rc;
+
+	cxl_mbox = &mds->cxlds.cxl_mbox;
 	mdata->mds = mds;
-	mds->mbox_send = cxl_mock_mbox_send;
-	mds->payload_size = SZ_4K;
+	cxl_mbox->mbox_send = cxl_mock_mbox_send;
+	cxl_mbox->payload_size = SZ_4K;
 	mds->event.buf = (struct cxl_get_event_payload *) mdata->event_buf;
 	INIT_DELAYED_WORK(&mds->security.poll_dwork, cxl_mockmem_sanitize_work);
 
-	cxlds = &mds->cxlds;
 	cxlds->serial = pdev->id;
 	if (is_rcd(pdev))
 		cxlds->rcd = true;
-- 
2.34.1


