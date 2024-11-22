Return-Path: <linux-edac+bounces-2612-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3D89D63C3
	for <lists+linux-edac@lfdr.de>; Fri, 22 Nov 2024 19:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED2FCB27022
	for <lists+linux-edac@lfdr.de>; Fri, 22 Nov 2024 18:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967E11E04A0;
	Fri, 22 Nov 2024 18:04:51 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F471DFE2B;
	Fri, 22 Nov 2024 18:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732298691; cv=none; b=IrcsGfBNWHXCC4A+gja0x1bCI8uZL1CgKNrYBOtyJ84BZ+eUH9Am8E21CejZUx6t1v/HgOp4d9lJ/iqhN4s5Wjdc9+tHCUBRKNaoPsGVy2R5Zfog2RZUfXs1DDA+dhKx1Yw7EiDOA8QXxzi8ylbposi9xy8wD1eJRvwPG3xEGCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732298691; c=relaxed/simple;
	bh=Zaz83bB7tLWNiqxXzxYLKExkwjw1STxQ2slylg6d3YM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a9H8ysdhMyh43cCVAk/ojfO8RhxvVmgwGkOleKMo4913IlR6dbJfrWIIy9zKnvQOiNcnmgq7yp6yQB1ZGlx/XT6ZubW44WArvg30I6dWI/Bcw+8rHrG3hTDC2t3dT0XJZy2RSOFgzZfZLYB8/r7goJZWvgAg0pupZH9I4zAOGA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xw2zm41GVz6L7mY;
	Sat, 23 Nov 2024 02:04:20 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 566A614010C;
	Sat, 23 Nov 2024 02:04:46 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.171.16) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 22 Nov 2024 19:04:44 +0100
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
Subject: [PATCH v17 04/18] cxl: Refactor user ioctl command path from mds to mailbox
Date: Fri, 22 Nov 2024 18:04:01 +0000
Message-ID: <20241122180416.1932-5-shiju.jose@huawei.com>
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

With 'struct cxl_mailbox' context introduced, the helper functions
cxl_query_cmd() and cxl_send_cmd() can take a cxl_mailbox directly
rather than a cxl_memdev parameter. Refactor to use cxl_mailbox
directly.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/core.h   |  6 ++-
 drivers/cxl/core/mbox.c   | 91 +++++++++++++++++++--------------------
 drivers/cxl/core/memdev.c | 22 +++++++---
 drivers/cxl/cxlmem.h      | 40 -----------------
 include/cxl/mailbox.h     | 41 +++++++++++++++++-
 5 files changed, 103 insertions(+), 97 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 0c62b4069ba0..ff30d1c99ca7 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -4,6 +4,8 @@
 #ifndef __CXL_CORE_H__
 #define __CXL_CORE_H__
 
+#include <cxl/mailbox.h>
+
 extern const struct device_type cxl_nvdimm_bridge_type;
 extern const struct device_type cxl_nvdimm_type;
 extern const struct device_type cxl_pmu_type;
@@ -65,9 +67,9 @@ static inline void cxl_region_exit(void)
 
 struct cxl_send_command;
 struct cxl_mem_query_commands;
-int cxl_query_cmd(struct cxl_memdev *cxlmd,
+int cxl_query_cmd(struct cxl_mailbox *cxl_mbox,
 		  struct cxl_mem_query_commands __user *q);
-int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s);
+int cxl_send_cmd(struct cxl_mailbox *cxl_mailbox, struct cxl_send_command __user *s);
 void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 				   resource_size_t length);
 
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 5175138c4fb7..880ac1dba3cc 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -349,40 +349,40 @@ static bool cxl_payload_from_user_allowed(u16 opcode, void *payload_in)
 	return true;
 }
 
-static int cxl_mbox_cmd_ctor(struct cxl_mbox_cmd *mbox,
-			     struct cxl_memdev_state *mds, u16 opcode,
+static int cxl_mbox_cmd_ctor(struct cxl_mbox_cmd *mbox_cmd,
+			     struct cxl_mailbox *cxl_mbox, u16 opcode,
 			     size_t in_size, size_t out_size, u64 in_payload)
 {
-	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
-	*mbox = (struct cxl_mbox_cmd) {
+	*mbox_cmd = (struct cxl_mbox_cmd) {
 		.opcode = opcode,
 		.size_in = in_size,
 	};
 
 	if (in_size) {
-		mbox->payload_in = vmemdup_user(u64_to_user_ptr(in_payload),
-						in_size);
-		if (IS_ERR(mbox->payload_in))
-			return PTR_ERR(mbox->payload_in);
-
-		if (!cxl_payload_from_user_allowed(opcode, mbox->payload_in)) {
-			dev_dbg(mds->cxlds.dev, "%s: input payload not allowed\n",
+		mbox_cmd->payload_in = vmemdup_user(u64_to_user_ptr(in_payload),
+						    in_size);
+		if (IS_ERR(mbox_cmd->payload_in))
+			return PTR_ERR(mbox_cmd->payload_in);
+
+		if (!cxl_payload_from_user_allowed(opcode,
+						   mbox_cmd->payload_in)) {
+			dev_dbg(cxl_mbox->host, "%s: input payload not allowed\n",
 				cxl_mem_opcode_to_name(opcode));
-			kvfree(mbox->payload_in);
+			kvfree(mbox_cmd->payload_in);
 			return -EBUSY;
 		}
 	}
 
 	/* Prepare to handle a full payload for variable sized output */
 	if (out_size == CXL_VARIABLE_PAYLOAD)
-		mbox->size_out = cxl_mbox->payload_size;
+		mbox_cmd->size_out = cxl_mbox->payload_size;
 	else
-		mbox->size_out = out_size;
+		mbox_cmd->size_out = out_size;
 
-	if (mbox->size_out) {
-		mbox->payload_out = kvzalloc(mbox->size_out, GFP_KERNEL);
-		if (!mbox->payload_out) {
-			kvfree(mbox->payload_in);
+	if (mbox_cmd->size_out) {
+		mbox_cmd->payload_out = kvzalloc(mbox_cmd->size_out, GFP_KERNEL);
+		if (!mbox_cmd->payload_out) {
+			kvfree(mbox_cmd->payload_in);
 			return -ENOMEM;
 		}
 	}
@@ -397,10 +397,8 @@ static void cxl_mbox_cmd_dtor(struct cxl_mbox_cmd *mbox)
 
 static int cxl_to_mem_cmd_raw(struct cxl_mem_command *mem_cmd,
 			      const struct cxl_send_command *send_cmd,
-			      struct cxl_memdev_state *mds)
+			      struct cxl_mailbox *cxl_mbox)
 {
-	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
-
 	if (send_cmd->raw.rsvd)
 		return -EINVAL;
 
@@ -415,7 +413,7 @@ static int cxl_to_mem_cmd_raw(struct cxl_mem_command *mem_cmd,
 	if (!cxl_mem_raw_command_allowed(send_cmd->raw.opcode))
 		return -EPERM;
 
-	dev_WARN_ONCE(mds->cxlds.dev, true, "raw command path used\n");
+	dev_WARN_ONCE(cxl_mbox->host, true, "raw command path used\n");
 
 	*mem_cmd = (struct cxl_mem_command) {
 		.info = {
@@ -431,7 +429,7 @@ static int cxl_to_mem_cmd_raw(struct cxl_mem_command *mem_cmd,
 
 static int cxl_to_mem_cmd(struct cxl_mem_command *mem_cmd,
 			  const struct cxl_send_command *send_cmd,
-			  struct cxl_memdev_state *mds)
+			  struct cxl_mailbox *cxl_mbox)
 {
 	struct cxl_mem_command *c = &cxl_mem_commands[send_cmd->id];
 	const struct cxl_command_info *info = &c->info;
@@ -446,11 +444,11 @@ static int cxl_to_mem_cmd(struct cxl_mem_command *mem_cmd,
 		return -EINVAL;
 
 	/* Check that the command is enabled for hardware */
-	if (!test_bit(info->id, mds->enabled_cmds))
+	if (!test_bit(info->id, cxl_mbox->enabled_cmds))
 		return -ENOTTY;
 
 	/* Check that the command is not claimed for exclusive kernel use */
-	if (test_bit(info->id, mds->exclusive_cmds))
+	if (test_bit(info->id, cxl_mbox->exclusive_cmds))
 		return -EBUSY;
 
 	/* Check the input buffer is the expected size */
@@ -479,7 +477,7 @@ static int cxl_to_mem_cmd(struct cxl_mem_command *mem_cmd,
 /**
  * cxl_validate_cmd_from_user() - Check fields for CXL_MEM_SEND_COMMAND.
  * @mbox_cmd: Sanitized and populated &struct cxl_mbox_cmd.
- * @mds: The driver data for the operation
+ * @cxl_mbox: CXL mailbox context
  * @send_cmd: &struct cxl_send_command copied in from userspace.
  *
  * Return:
@@ -494,10 +492,9 @@ static int cxl_to_mem_cmd(struct cxl_mem_command *mem_cmd,
  * safe to send to the hardware.
  */
 static int cxl_validate_cmd_from_user(struct cxl_mbox_cmd *mbox_cmd,
-				      struct cxl_memdev_state *mds,
+				      struct cxl_mailbox *cxl_mbox,
 				      const struct cxl_send_command *send_cmd)
 {
-	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_mem_command mem_cmd;
 	int rc;
 
@@ -514,24 +511,23 @@ static int cxl_validate_cmd_from_user(struct cxl_mbox_cmd *mbox_cmd,
 
 	/* Sanitize and construct a cxl_mem_command */
 	if (send_cmd->id == CXL_MEM_COMMAND_ID_RAW)
-		rc = cxl_to_mem_cmd_raw(&mem_cmd, send_cmd, mds);
+		rc = cxl_to_mem_cmd_raw(&mem_cmd, send_cmd, cxl_mbox);
 	else
-		rc = cxl_to_mem_cmd(&mem_cmd, send_cmd, mds);
+		rc = cxl_to_mem_cmd(&mem_cmd, send_cmd, cxl_mbox);
 
 	if (rc)
 		return rc;
 
 	/* Sanitize and construct a cxl_mbox_cmd */
-	return cxl_mbox_cmd_ctor(mbox_cmd, mds, mem_cmd.opcode,
+	return cxl_mbox_cmd_ctor(mbox_cmd, cxl_mbox, mem_cmd.opcode,
 				 mem_cmd.info.size_in, mem_cmd.info.size_out,
 				 send_cmd->in.payload);
 }
 
-int cxl_query_cmd(struct cxl_memdev *cxlmd,
+int cxl_query_cmd(struct cxl_mailbox *cxl_mbox,
 		  struct cxl_mem_query_commands __user *q)
 {
-	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
-	struct device *dev = &cxlmd->dev;
+	struct device *dev = cxl_mbox->host;
 	struct cxl_mem_command *cmd;
 	u32 n_commands;
 	int j = 0;
@@ -552,9 +548,9 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
 	cxl_for_each_cmd(cmd) {
 		struct cxl_command_info info = cmd->info;
 
-		if (test_bit(info.id, mds->enabled_cmds))
+		if (test_bit(info.id, cxl_mbox->enabled_cmds))
 			info.flags |= CXL_MEM_COMMAND_FLAG_ENABLED;
-		if (test_bit(info.id, mds->exclusive_cmds))
+		if (test_bit(info.id, cxl_mbox->exclusive_cmds))
 			info.flags |= CXL_MEM_COMMAND_FLAG_EXCLUSIVE;
 
 		if (copy_to_user(&q->commands[j++], &info, sizeof(info)))
@@ -569,7 +565,7 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
 
 /**
  * handle_mailbox_cmd_from_user() - Dispatch a mailbox command for userspace.
- * @mds: The driver data for the operation
+ * @cxl_mbox: The mailbox context for the operation.
  * @mbox_cmd: The validated mailbox command.
  * @out_payload: Pointer to userspace's output payload.
  * @size_out: (Input) Max payload size to copy out.
@@ -590,13 +586,12 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
  *
  * See cxl_send_cmd().
  */
-static int handle_mailbox_cmd_from_user(struct cxl_memdev_state *mds,
+static int handle_mailbox_cmd_from_user(struct cxl_mailbox *cxl_mbox,
 					struct cxl_mbox_cmd *mbox_cmd,
 					u64 out_payload, s32 *size_out,
 					u32 *retval)
 {
-	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
-	struct device *dev = mds->cxlds.dev;
+	struct device *dev = cxl_mbox->host;
 	int rc;
 
 	dev_dbg(dev,
@@ -633,10 +628,9 @@ static int handle_mailbox_cmd_from_user(struct cxl_memdev_state *mds,
 	return rc;
 }
 
-int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
+int cxl_send_cmd(struct cxl_mailbox *cxl_mbox, struct cxl_send_command __user *s)
 {
-	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
-	struct device *dev = &cxlmd->dev;
+	struct device *dev = cxl_mbox->host;
 	struct cxl_send_command send;
 	struct cxl_mbox_cmd mbox_cmd;
 	int rc;
@@ -646,11 +640,11 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
 	if (copy_from_user(&send, s, sizeof(send)))
 		return -EFAULT;
 
-	rc = cxl_validate_cmd_from_user(&mbox_cmd, mds, &send);
+	rc = cxl_validate_cmd_from_user(&mbox_cmd, cxl_mbox, &send);
 	if (rc)
 		return rc;
 
-	rc = handle_mailbox_cmd_from_user(mds, &mbox_cmd, send.out.payload,
+	rc = handle_mailbox_cmd_from_user(cxl_mbox, &mbox_cmd, send.out.payload,
 					  &send.out.size, &send.retval);
 	if (rc)
 		return rc;
@@ -724,6 +718,7 @@ static int cxl_xfer_log(struct cxl_memdev_state *mds, uuid_t *uuid,
  */
 static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
 {
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_cel_entry *cel_entry;
 	const int cel_entries = size / sizeof(*cel_entry);
 	struct device *dev = mds->cxlds.dev;
@@ -737,7 +732,7 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
 		int enabled = 0;
 
 		if (cmd) {
-			set_bit(cmd->info.id, mds->enabled_cmds);
+			set_bit(cmd->info.id, cxl_mbox->enabled_cmds);
 			enabled++;
 		}
 
@@ -807,6 +802,7 @@ static const uuid_t log_uuid[] = {
  */
 int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
 {
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_mbox_get_supported_logs *gsl;
 	struct device *dev = mds->cxlds.dev;
 	struct cxl_mem_command *cmd;
@@ -845,7 +841,7 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
 		/* In case CEL was bogus, enable some default commands. */
 		cxl_for_each_cmd(cmd)
 			if (cmd->flags & CXL_CMD_FLAG_FORCE_ENABLE)
-				set_bit(cmd->info.id, mds->enabled_cmds);
+				set_bit(cmd->info.id, cxl_mbox->enabled_cmds);
 
 		/* Found the required CEL */
 		rc = 0;
@@ -1448,6 +1444,7 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
 	mutex_init(&mds->event.log_lock);
 	mds->cxlds.dev = dev;
 	mds->cxlds.reg_map.host = dev;
+	mds->cxlds.cxl_mbox.host = dev;
 	mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
 	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
 	mds->ram_perf.qos_class = CXL_QOS_CLASS_INVALID;
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 84fefb76dafa..4d544a55ac3e 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -564,9 +564,11 @@ EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, CXL);
 void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 				unsigned long *cmds)
 {
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
+
 	down_write(&cxl_memdev_rwsem);
-	bitmap_or(mds->exclusive_cmds, mds->exclusive_cmds, cmds,
-		  CXL_MEM_COMMAND_ID_MAX);
+	bitmap_or(cxl_mbox->exclusive_cmds, cxl_mbox->exclusive_cmds,
+		  cmds, CXL_MEM_COMMAND_ID_MAX);
 	up_write(&cxl_memdev_rwsem);
 }
 EXPORT_SYMBOL_NS_GPL(set_exclusive_cxl_commands, CXL);
@@ -579,9 +581,11 @@ EXPORT_SYMBOL_NS_GPL(set_exclusive_cxl_commands, CXL);
 void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 				  unsigned long *cmds)
 {
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
+
 	down_write(&cxl_memdev_rwsem);
-	bitmap_andnot(mds->exclusive_cmds, mds->exclusive_cmds, cmds,
-		      CXL_MEM_COMMAND_ID_MAX);
+	bitmap_andnot(cxl_mbox->exclusive_cmds, cxl_mbox->exclusive_cmds,
+		      cmds, CXL_MEM_COMMAND_ID_MAX);
 	up_write(&cxl_memdev_rwsem);
 }
 EXPORT_SYMBOL_NS_GPL(clear_exclusive_cxl_commands, CXL);
@@ -656,11 +660,14 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
 static long __cxl_memdev_ioctl(struct cxl_memdev *cxlmd, unsigned int cmd,
 			       unsigned long arg)
 {
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
+
 	switch (cmd) {
 	case CXL_MEM_QUERY_COMMANDS:
-		return cxl_query_cmd(cxlmd, (void __user *)arg);
+		return cxl_query_cmd(cxl_mbox, (void __user *)arg);
 	case CXL_MEM_SEND_COMMAND:
-		return cxl_send_cmd(cxlmd, (void __user *)arg);
+		return cxl_send_cmd(cxl_mbox, (void __user *)arg);
 	default:
 		return -ENOTTY;
 	}
@@ -994,10 +1001,11 @@ static void cxl_remove_fw_upload(void *fwl)
 int devm_cxl_setup_fw_upload(struct device *host, struct cxl_memdev_state *mds)
 {
 	struct cxl_dev_state *cxlds = &mds->cxlds;
+	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
 	struct device *dev = &cxlds->cxlmd->dev;
 	struct fw_upload *fwl;
 
-	if (!test_bit(CXL_MEM_COMMAND_ID_GET_FW_INFO, mds->enabled_cmds))
+	if (!test_bit(CXL_MEM_COMMAND_ID_GET_FW_INFO, cxl_mbox->enabled_cmds))
 		return 0;
 
 	fwl = firmware_upload_register(THIS_MODULE, dev, dev_name(dev),
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 2a25d1957ddb..a0a49809cd76 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -106,42 +106,6 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
 	return xa_load(&port->endpoints, (unsigned long)&cxlmd->dev);
 }
 
-/**
- * struct cxl_mbox_cmd - A command to be submitted to hardware.
- * @opcode: (input) The command set and command submitted to hardware.
- * @payload_in: (input) Pointer to the input payload.
- * @payload_out: (output) Pointer to the output payload. Must be allocated by
- *		 the caller.
- * @size_in: (input) Number of bytes to load from @payload_in.
- * @size_out: (input) Max number of bytes loaded into @payload_out.
- *            (output) Number of bytes generated by the device. For fixed size
- *            outputs commands this is always expected to be deterministic. For
- *            variable sized output commands, it tells the exact number of bytes
- *            written.
- * @min_out: (input) internal command output payload size validation
- * @poll_count: (input) Number of timeouts to attempt.
- * @poll_interval_ms: (input) Time between mailbox background command polling
- *                    interval timeouts.
- * @return_code: (output) Error code returned from hardware.
- *
- * This is the primary mechanism used to send commands to the hardware.
- * All the fields except @payload_* correspond exactly to the fields described in
- * Command Register section of the CXL 2.0 8.2.8.4.5. @payload_in and
- * @payload_out are written to, and read from the Command Payload Registers
- * defined in CXL 2.0 8.2.8.4.8.
- */
-struct cxl_mbox_cmd {
-	u16 opcode;
-	void *payload_in;
-	void *payload_out;
-	size_t size_in;
-	size_t size_out;
-	size_t min_out;
-	int poll_count;
-	int poll_interval_ms;
-	u16 return_code;
-};
-
 /*
  * Per CXL 3.0 Section 8.2.8.4.5.1
  */
@@ -461,8 +425,6 @@ static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
  * @lsa_size: Size of Label Storage Area
  *                (CXL 2.0 8.2.9.5.1.1 Identify Memory Device)
  * @firmware_version: Firmware version for the memory device.
- * @enabled_cmds: Hardware commands found enabled in CEL.
- * @exclusive_cmds: Commands that are kernel-internal only
  * @total_bytes: sum of all possible capacities
  * @volatile_only_bytes: hard volatile capacity
  * @persistent_only_bytes: hard persistent capacity
@@ -485,8 +447,6 @@ struct cxl_memdev_state {
 	struct cxl_dev_state cxlds;
 	size_t lsa_size;
 	char firmware_version[0x10];
-	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
-	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
 	u64 total_bytes;
 	u64 volatile_only_bytes;
 	u64 persistent_only_bytes;
diff --git a/include/cxl/mailbox.h b/include/cxl/mailbox.h
index bacd111e75f1..cc894f07a435 100644
--- a/include/cxl/mailbox.h
+++ b/include/cxl/mailbox.h
@@ -3,12 +3,49 @@
 #ifndef __CXL_MBOX_H__
 #define __CXL_MBOX_H__
 #include <linux/rcuwait.h>
+#include <uapi/linux/cxl_mem.h>
 
-struct cxl_mbox_cmd;
+/**
+ * struct cxl_mbox_cmd - A command to be submitted to hardware.
+ * @opcode: (input) The command set and command submitted to hardware.
+ * @payload_in: (input) Pointer to the input payload.
+ * @payload_out: (output) Pointer to the output payload. Must be allocated by
+ *		 the caller.
+ * @size_in: (input) Number of bytes to load from @payload_in.
+ * @size_out: (input) Max number of bytes loaded into @payload_out.
+ *            (output) Number of bytes generated by the device. For fixed size
+ *            outputs commands this is always expected to be deterministic. For
+ *            variable sized output commands, it tells the exact number of bytes
+ *            written.
+ * @min_out: (input) internal command output payload size validation
+ * @poll_count: (input) Number of timeouts to attempt.
+ * @poll_interval_ms: (input) Time between mailbox background command polling
+ *                    interval timeouts.
+ * @return_code: (output) Error code returned from hardware.
+ *
+ * This is the primary mechanism used to send commands to the hardware.
+ * All the fields except @payload_* correspond exactly to the fields described in
+ * Command Register section of the CXL 2.0 8.2.8.4.5. @payload_in and
+ * @payload_out are written to, and read from the Command Payload Registers
+ * defined in CXL 2.0 8.2.8.4.8.
+ */
+struct cxl_mbox_cmd {
+	u16 opcode;
+	void *payload_in;
+	void *payload_out;
+	size_t size_in;
+	size_t size_out;
+	size_t min_out;
+	int poll_count;
+	int poll_interval_ms;
+	u16 return_code;
+};
 
 /**
  * struct cxl_mailbox - context for CXL mailbox operations
  * @host: device that hosts the mailbox
+ * @enabled_cmds: mailbox commands that are enabled by the driver
+ * @exclusive_cmds: mailbox commands that are exclusive to the kernel
  * @payload_size: Size of space for payload
  *                (CXL 3.1 8.2.8.4.3 Mailbox Capabilities Register)
  * @mbox_mutex: mutex protects device mailbox and firmware
@@ -17,6 +54,8 @@ struct cxl_mbox_cmd;
  */
 struct cxl_mailbox {
 	struct device *host;
+	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
+	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
 	size_t payload_size;
 	struct mutex mbox_mutex; /* lock to protect mailbox context */
 	struct rcuwait mbox_wait;
-- 
2.43.0


