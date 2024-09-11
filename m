Return-Path: <linux-edac+bounces-1847-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A3A974DFE
	for <lists+linux-edac@lfdr.de>; Wed, 11 Sep 2024 11:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5ED11F23665
	for <lists+linux-edac@lfdr.de>; Wed, 11 Sep 2024 09:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6361865EC;
	Wed, 11 Sep 2024 09:07:22 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78554185B4D;
	Wed, 11 Sep 2024 09:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726045642; cv=none; b=MtIrzz234nNSYRa9cphzq+sVgHiJQFOqZOLJFKw0J2DZ5X5YxbNkCLK1qYqgfLTTIVkM7XrE8vvlDGENeBTtXjQmvSdF+Xt7XhQeFc52ptQyR0EEa/518RJGpkiOUD5QGPnC70XgGqYCqGUmMitRyNFEX9XGU2jwI88bXGOAcQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726045642; c=relaxed/simple;
	bh=2RiEQxClHwYeX0h2bMNc92gSkY9x5D76kMJtmP3Hloo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S+n0R0ABoXmWFLjb0NL3CLBKFP3xUD2qHUdL9cAhJPc6dUDcvrTLtu5hRAOT0HdVr+sFfnUJeOHEXa960lip9q23TjGA/xjn8+L92Pnb4ud+E0s+vaMD3EX4AgVdd7m7Uvm8W9OZnN4ma+/PDG+dsQudlYKEHfaYy8n50DGEhC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X3ZMp39nxz6K6R1;
	Wed, 11 Sep 2024 17:02:30 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 89E9E1400F4;
	Wed, 11 Sep 2024 17:07:17 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.245.151) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Sep 2024 11:07:14 +0200
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
	<wbs@os.amperecomputing.com>, <nifan.cxl@gmail.com>, <yazen.ghannam@amd.com>,
	<jgroves@micron.com>, <vsalve@micron.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <roberto.sassu@huawei.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v12 06/17] cxl: Refactor user ioctl command path from mds to mailbox
Date: Wed, 11 Sep 2024 10:04:35 +0100
Message-ID: <20240911090447.751-7-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240911090447.751-1-shiju.jose@huawei.com>
References: <20240911090447.751-1-shiju.jose@huawei.com>
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

With 'struct cxl_mailbox' context introduced, the helper functions
cxl_query_cmd() and cxl_send_cmd() can take a cxl_mailbox directly
rather than a cxl_memdev parameter. Refactor to use cxl_mailbox
directly.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/core.h     |   6 +-
 drivers/cxl/core/mbox.c     | 120 ++++++++++++++++++------------------
 drivers/cxl/core/memdev.c   |  39 ++++++++----
 drivers/cxl/cxlmem.h        |   6 +-
 drivers/cxl/pci.c           |   6 +-
 drivers/cxl/pmem.c          |   6 +-
 drivers/cxl/security.c      |  18 ++++--
 include/linux/cxl/mailbox.h |   5 ++
 8 files changed, 116 insertions(+), 90 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 72a506c9dbd0..2b9f80d61ee9 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -4,6 +4,8 @@
 #ifndef __CXL_CORE_H__
 #define __CXL_CORE_H__
 
+#include <linux/cxl/mailbox.h>
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
index 5cbb76c4aa16..fa1ee495a4e3 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -225,7 +225,7 @@ static const char *cxl_mem_opcode_to_name(u16 opcode)
 
 /**
  * cxl_internal_send_cmd() - Kernel internal interface to send a mailbox command
- * @mds: The driver data for the operation
+ * @cxl_mbox: CXL mailbox context for the operation
  * @mbox_cmd: initialized command to execute
  *
  * Context: Any context.
@@ -241,10 +241,9 @@ static const char *cxl_mem_opcode_to_name(u16 opcode)
  * error. While this distinction can be useful for commands from userspace, the
  * kernel will only be able to use results when both are successful.
  */
-int cxl_internal_send_cmd(struct cxl_memdev_state *mds,
+int cxl_internal_send_cmd(struct cxl_mailbox *cxl_mbox,
 			  struct cxl_mbox_cmd *mbox_cmd)
 {
-	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	size_t out_size, min_out;
 	int rc;
 
@@ -350,40 +349,40 @@ static bool cxl_payload_from_user_allowed(u16 opcode, void *payload_in)
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
@@ -398,10 +397,8 @@ static void cxl_mbox_cmd_dtor(struct cxl_mbox_cmd *mbox)
 
 static int cxl_to_mem_cmd_raw(struct cxl_mem_command *mem_cmd,
 			      const struct cxl_send_command *send_cmd,
-			      struct cxl_memdev_state *mds)
+			      struct cxl_mailbox *cxl_mbox)
 {
-	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
-
 	if (send_cmd->raw.rsvd)
 		return -EINVAL;
 
@@ -416,7 +413,7 @@ static int cxl_to_mem_cmd_raw(struct cxl_mem_command *mem_cmd,
 	if (!cxl_mem_raw_command_allowed(send_cmd->raw.opcode))
 		return -EPERM;
 
-	dev_WARN_ONCE(mds->cxlds.dev, true, "raw command path used\n");
+	dev_WARN_ONCE(cxl_mbox->host, true, "raw command path used\n");
 
 	*mem_cmd = (struct cxl_mem_command) {
 		.info = {
@@ -432,7 +429,7 @@ static int cxl_to_mem_cmd_raw(struct cxl_mem_command *mem_cmd,
 
 static int cxl_to_mem_cmd(struct cxl_mem_command *mem_cmd,
 			  const struct cxl_send_command *send_cmd,
-			  struct cxl_memdev_state *mds)
+			  struct cxl_mailbox *cxl_mbox)
 {
 	struct cxl_mem_command *c = &cxl_mem_commands[send_cmd->id];
 	const struct cxl_command_info *info = &c->info;
@@ -447,11 +444,11 @@ static int cxl_to_mem_cmd(struct cxl_mem_command *mem_cmd,
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
@@ -495,10 +492,9 @@ static int cxl_to_mem_cmd(struct cxl_mem_command *mem_cmd,
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
 
@@ -515,24 +511,23 @@ static int cxl_validate_cmd_from_user(struct cxl_mbox_cmd *mbox_cmd,
 
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
@@ -553,9 +548,9 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
 	cxl_for_each_cmd(cmd) {
 		struct cxl_command_info info = cmd->info;
 
-		if (test_bit(info.id, mds->enabled_cmds))
+		if (test_bit(info.id, cxl_mbox->enabled_cmds))
 			info.flags |= CXL_MEM_COMMAND_FLAG_ENABLED;
-		if (test_bit(info.id, mds->exclusive_cmds))
+		if (test_bit(info.id, cxl_mbox->exclusive_cmds))
 			info.flags |= CXL_MEM_COMMAND_FLAG_EXCLUSIVE;
 
 		if (copy_to_user(&q->commands[j++], &info, sizeof(info)))
@@ -570,7 +565,7 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
 
 /**
  * handle_mailbox_cmd_from_user() - Dispatch a mailbox command for userspace.
- * @mds: The driver data for the operation
+ * @mailbox: The mailbox context for the operation.
  * @mbox_cmd: The validated mailbox command.
  * @out_payload: Pointer to userspace's output payload.
  * @size_out: (Input) Max payload size to copy out.
@@ -591,13 +586,12 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
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
@@ -634,10 +628,9 @@ static int handle_mailbox_cmd_from_user(struct cxl_memdev_state *mds,
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
@@ -647,11 +640,11 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
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
@@ -689,7 +682,7 @@ static int cxl_xfer_log(struct cxl_memdev_state *mds, uuid_t *uuid,
 			.payload_out = out,
 		};
 
-		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 
 		/*
 		 * The output payload length that indicates the number
@@ -725,6 +718,7 @@ static int cxl_xfer_log(struct cxl_memdev_state *mds, uuid_t *uuid,
  */
 static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
 {
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_cel_entry *cel_entry;
 	const int cel_entries = size / sizeof(*cel_entry);
 	struct device *dev = mds->cxlds.dev;
@@ -738,7 +732,7 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
 		int enabled = 0;
 
 		if (cmd) {
-			set_bit(cmd->info.id, mds->enabled_cmds);
+			set_bit(cmd->info.id, cxl_mbox->enabled_cmds);
 			enabled++;
 		}
 
@@ -775,7 +769,7 @@ static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_memdev_state *
 		/* At least the record number field must be valid */
 		.min_out = 2,
 	};
-	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 	if (rc < 0) {
 		kvfree(ret);
 		return ERR_PTR(rc);
@@ -808,6 +802,7 @@ static const uuid_t log_uuid[] = {
  */
 int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
 {
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_mbox_get_supported_logs *gsl;
 	struct device *dev = mds->cxlds.dev;
 	struct cxl_mem_command *cmd;
@@ -846,7 +841,7 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
 		/* In case CEL was bogus, enable some default commands. */
 		cxl_for_each_cmd(cmd)
 			if (cmd->flags & CXL_CMD_FLAG_FORCE_ENABLE)
-				set_bit(cmd->info.id, mds->enabled_cmds);
+				set_bit(cmd->info.id, cxl_mbox->enabled_cmds);
 
 		/* Found the required CEL */
 		rc = 0;
@@ -964,7 +959,7 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
 
 		if (i == max_handles) {
 			payload->nr_recs = i;
-			rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+			rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 			if (rc)
 				goto free_pl;
 			i = 0;
@@ -975,7 +970,7 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
 	if (i) {
 		payload->nr_recs = i;
 		mbox_cmd.size_in = struct_size(payload, handles, i);
-		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 		if (rc)
 			goto free_pl;
 	}
@@ -1009,7 +1004,7 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
 			.min_out = struct_size(payload, records, 0),
 		};
 
-		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 		if (rc) {
 			dev_err_ratelimited(dev,
 				"Event log '%d': Failed to query event records : %d",
@@ -1080,6 +1075,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, CXL);
  */
 static int cxl_mem_get_partition_info(struct cxl_memdev_state *mds)
 {
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_mbox_get_partition_info pi;
 	struct cxl_mbox_cmd mbox_cmd;
 	int rc;
@@ -1089,7 +1085,7 @@ static int cxl_mem_get_partition_info(struct cxl_memdev_state *mds)
 		.size_out = sizeof(pi),
 		.payload_out = &pi,
 	};
-	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 	if (rc)
 		return rc;
 
@@ -1116,6 +1112,7 @@ static int cxl_mem_get_partition_info(struct cxl_memdev_state *mds)
  */
 int cxl_dev_state_identify(struct cxl_memdev_state *mds)
 {
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	/* See CXL 2.0 Table 175 Identify Memory Device Output Payload */
 	struct cxl_mbox_identify id;
 	struct cxl_mbox_cmd mbox_cmd;
@@ -1130,7 +1127,7 @@ int cxl_dev_state_identify(struct cxl_memdev_state *mds)
 		.size_out = sizeof(id),
 		.payload_out = &id,
 	};
-	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 	if (rc < 0)
 		return rc;
 
@@ -1170,11 +1167,12 @@ static int __cxl_mem_sanitize(struct cxl_memdev_state *mds, u16 cmd)
 	};
 	struct cxl_mbox_cmd mbox_cmd = { .opcode = cmd };
 	struct cxl_dev_state *cxlds = &mds->cxlds;
+	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
 
 	if (cmd != CXL_MBOX_OP_SANITIZE && cmd != CXL_MBOX_OP_SECURE_ERASE)
 		return -EINVAL;
 
-	rc = cxl_internal_send_cmd(mds, &sec_cmd);
+	rc = cxl_internal_send_cmd(cxl_mbox, &sec_cmd);
 	if (rc < 0) {
 		dev_err(cxlds->dev, "Failed to get security state : %d", rc);
 		return rc;
@@ -1193,7 +1191,7 @@ static int __cxl_mem_sanitize(struct cxl_memdev_state *mds, u16 cmd)
 	    sec_out & CXL_PMEM_SEC_STATE_LOCKED)
 		return -EINVAL;
 
-	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 	if (rc < 0) {
 		dev_err(cxlds->dev, "Failed to sanitize device : %d", rc);
 		return rc;
@@ -1310,6 +1308,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_mem_create_range_info, CXL);
 
 int cxl_set_timestamp(struct cxl_memdev_state *mds)
 {
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_mbox_cmd mbox_cmd;
 	struct cxl_mbox_set_timestamp_in pi;
 	int rc;
@@ -1321,7 +1320,7 @@ int cxl_set_timestamp(struct cxl_memdev_state *mds)
 		.payload_in = &pi,
 	};
 
-	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 	/*
 	 * Command is optional. Devices may have another way of providing
 	 * a timestamp, or may return all 0s in timestamp fields.
@@ -1362,7 +1361,7 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 			.min_out = struct_size(po, record, 0),
 		};
 
-		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 		if (rc)
 			break;
 
@@ -1438,6 +1437,7 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
 	mutex_init(&mds->event.log_lock);
 	mds->cxlds.dev = dev;
 	mds->cxlds.reg_map.host = dev;
+	mds->cxlds.cxl_mbox.host = dev;
 	mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
 	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
 	mds->ram_perf.qos_class = CXL_QOS_CLASS_INVALID;
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 05bb84cb1274..9f0fe698414d 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -279,6 +279,7 @@ static int cxl_validate_poison_dpa(struct cxl_memdev *cxlmd, u64 dpa)
 int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 {
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_mbox_inject_poison inject;
 	struct cxl_poison_record record;
 	struct cxl_mbox_cmd mbox_cmd;
@@ -308,7 +309,7 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 		.size_in = sizeof(inject),
 		.payload_in = &inject,
 	};
-	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 	if (rc)
 		goto out;
 
@@ -334,6 +335,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_inject_poison, CXL);
 int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
 {
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_mbox_clear_poison clear;
 	struct cxl_poison_record record;
 	struct cxl_mbox_cmd mbox_cmd;
@@ -372,7 +374,7 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
 		.payload_in = &clear,
 	};
 
-	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 	if (rc)
 		goto out;
 
@@ -564,9 +566,11 @@ EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, CXL);
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
@@ -579,9 +583,11 @@ EXPORT_SYMBOL_NS_GPL(set_exclusive_cxl_commands, CXL);
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
@@ -656,11 +662,14 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
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
@@ -715,6 +724,7 @@ static int cxl_memdev_release_file(struct inode *inode, struct file *file)
  */
 static int cxl_mem_get_fw_info(struct cxl_memdev_state *mds)
 {
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_mbox_get_fw_info info;
 	struct cxl_mbox_cmd mbox_cmd;
 	int rc;
@@ -725,7 +735,7 @@ static int cxl_mem_get_fw_info(struct cxl_memdev_state *mds)
 		.payload_out = &info,
 	};
 
-	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 	if (rc < 0)
 		return rc;
 
@@ -749,6 +759,7 @@ static int cxl_mem_get_fw_info(struct cxl_memdev_state *mds)
  */
 static int cxl_mem_activate_fw(struct cxl_memdev_state *mds, int slot)
 {
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_mbox_activate_fw activate;
 	struct cxl_mbox_cmd mbox_cmd;
 
@@ -765,7 +776,7 @@ static int cxl_mem_activate_fw(struct cxl_memdev_state *mds, int slot)
 	activate.action = CXL_FW_ACTIVATE_OFFLINE;
 	activate.slot = slot;
 
-	return cxl_internal_send_cmd(mds, &mbox_cmd);
+	return cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 }
 
 /**
@@ -780,6 +791,7 @@ static int cxl_mem_activate_fw(struct cxl_memdev_state *mds, int slot)
  */
 static int cxl_mem_abort_fw_xfer(struct cxl_memdev_state *mds)
 {
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_mbox_transfer_fw *transfer;
 	struct cxl_mbox_cmd mbox_cmd;
 	int rc;
@@ -799,7 +811,7 @@ static int cxl_mem_abort_fw_xfer(struct cxl_memdev_state *mds)
 
 	transfer->action = CXL_FW_TRANSFER_ACTION_ABORT;
 
-	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 	kfree(transfer);
 	return rc;
 }
@@ -924,7 +936,7 @@ static enum fw_upload_err cxl_fw_write(struct fw_upload *fwl, const u8 *data,
 		.poll_count = 30,
 	};
 
-	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 	if (rc < 0) {
 		rc = FW_UPLOAD_ERR_RW_ERROR;
 		goto out_free;
@@ -991,10 +1003,11 @@ static void cxl_remove_fw_upload(void *fwl)
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
index 19609b708b09..d7c6ffe2a884 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -417,8 +417,6 @@ struct cxl_dev_state {
  * @lsa_size: Size of Label Storage Area
  *                (CXL 2.0 8.2.9.5.1.1 Identify Memory Device)
  * @firmware_version: Firmware version for the memory device.
- * @enabled_cmds: Hardware commands found enabled in CEL.
- * @exclusive_cmds: Commands that are kernel-internal only
  * @total_bytes: sum of all possible capacities
  * @volatile_only_bytes: hard volatile capacity
  * @persistent_only_bytes: hard persistent capacity
@@ -441,8 +439,6 @@ struct cxl_memdev_state {
 	struct cxl_dev_state cxlds;
 	size_t lsa_size;
 	char firmware_version[0x10];
-	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
-	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
 	u64 total_bytes;
 	u64 volatile_only_bytes;
 	u64 persistent_only_bytes;
@@ -769,7 +765,7 @@ enum {
 	CXL_PMEM_SEC_PASS_USER,
 };
 
-int cxl_internal_send_cmd(struct cxl_memdev_state *mds,
+int cxl_internal_send_cmd(struct cxl_mailbox *cxl_mbox,
 			  struct cxl_mbox_cmd *cmd);
 int cxl_dev_state_identify(struct cxl_memdev_state *mds);
 int cxl_await_media_ready(struct cxl_dev_state *cxlds);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index faf6f5a49368..3c73de475bf3 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -661,6 +661,7 @@ static int cxl_event_req_irq(struct cxl_dev_state *cxlds, u8 setting)
 static int cxl_event_get_int_policy(struct cxl_memdev_state *mds,
 				    struct cxl_event_interrupt_policy *policy)
 {
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_mbox_cmd mbox_cmd = {
 		.opcode = CXL_MBOX_OP_GET_EVT_INT_POLICY,
 		.payload_out = policy,
@@ -668,7 +669,7 @@ static int cxl_event_get_int_policy(struct cxl_memdev_state *mds,
 	};
 	int rc;
 
-	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 	if (rc < 0)
 		dev_err(mds->cxlds.dev,
 			"Failed to get event interrupt policy : %d", rc);
@@ -679,6 +680,7 @@ static int cxl_event_get_int_policy(struct cxl_memdev_state *mds,
 static int cxl_event_config_msgnums(struct cxl_memdev_state *mds,
 				    struct cxl_event_interrupt_policy *policy)
 {
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_mbox_cmd mbox_cmd;
 	int rc;
 
@@ -695,7 +697,7 @@ static int cxl_event_config_msgnums(struct cxl_memdev_state *mds,
 		.size_in = sizeof(*policy),
 	};
 
-	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 	if (rc < 0) {
 		dev_err(mds->cxlds.dev, "Failed to set event interrupt policy : %d",
 			rc);
diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index 3985ff9ce70e..5453c0faa295 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -120,6 +120,7 @@ static int cxl_pmem_get_config_data(struct cxl_memdev_state *mds,
 				    struct nd_cmd_get_config_data_hdr *cmd,
 				    unsigned int buf_len)
 {
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_mbox_get_lsa get_lsa;
 	struct cxl_mbox_cmd mbox_cmd;
 	int rc;
@@ -141,7 +142,7 @@ static int cxl_pmem_get_config_data(struct cxl_memdev_state *mds,
 		.payload_out = cmd->out_buf,
 	};
 
-	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 	cmd->status = 0;
 
 	return rc;
@@ -151,6 +152,7 @@ static int cxl_pmem_set_config_data(struct cxl_memdev_state *mds,
 				    struct nd_cmd_set_config_hdr *cmd,
 				    unsigned int buf_len)
 {
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_mbox_set_lsa *set_lsa;
 	struct cxl_mbox_cmd mbox_cmd;
 	int rc;
@@ -177,7 +179,7 @@ static int cxl_pmem_set_config_data(struct cxl_memdev_state *mds,
 		.size_in = struct_size(set_lsa, data, cmd->in_length),
 	};
 
-	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 
 	/*
 	 * Set "firmware" status (4-packed bytes at the end of the input
diff --git a/drivers/cxl/security.c b/drivers/cxl/security.c
index 21856a3f408e..95a92b87c99a 100644
--- a/drivers/cxl/security.c
+++ b/drivers/cxl/security.c
@@ -15,6 +15,7 @@ static unsigned long cxl_pmem_get_security_flags(struct nvdimm *nvdimm,
 	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
 	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	unsigned long security_flags = 0;
 	struct cxl_get_security_output {
 		__le32 flags;
@@ -29,7 +30,7 @@ static unsigned long cxl_pmem_get_security_flags(struct nvdimm *nvdimm,
 		.payload_out = &out,
 	};
 
-	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 	if (rc < 0)
 		return 0;
 
@@ -71,6 +72,7 @@ static int cxl_pmem_security_change_key(struct nvdimm *nvdimm,
 	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
 	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_mbox_cmd mbox_cmd;
 	struct cxl_set_pass set_pass;
 
@@ -87,7 +89,7 @@ static int cxl_pmem_security_change_key(struct nvdimm *nvdimm,
 		.payload_in = &set_pass,
 	};
 
-	return cxl_internal_send_cmd(mds, &mbox_cmd);
+	return cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 }
 
 static int __cxl_pmem_security_disable(struct nvdimm *nvdimm,
@@ -97,6 +99,7 @@ static int __cxl_pmem_security_disable(struct nvdimm *nvdimm,
 	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
 	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_disable_pass dis_pass;
 	struct cxl_mbox_cmd mbox_cmd;
 
@@ -112,7 +115,7 @@ static int __cxl_pmem_security_disable(struct nvdimm *nvdimm,
 		.payload_in = &dis_pass,
 	};
 
-	return cxl_internal_send_cmd(mds, &mbox_cmd);
+	return cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 }
 
 static int cxl_pmem_security_disable(struct nvdimm *nvdimm,
@@ -132,11 +135,12 @@ static int cxl_pmem_security_freeze(struct nvdimm *nvdimm)
 	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
 	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_mbox_cmd mbox_cmd = {
 		.opcode = CXL_MBOX_OP_FREEZE_SECURITY,
 	};
 
-	return cxl_internal_send_cmd(mds, &mbox_cmd);
+	return cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 }
 
 static int cxl_pmem_security_unlock(struct nvdimm *nvdimm,
@@ -145,6 +149,7 @@ static int cxl_pmem_security_unlock(struct nvdimm *nvdimm,
 	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
 	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	u8 pass[NVDIMM_PASSPHRASE_LEN];
 	struct cxl_mbox_cmd mbox_cmd;
 	int rc;
@@ -156,7 +161,7 @@ static int cxl_pmem_security_unlock(struct nvdimm *nvdimm,
 		.payload_in = pass,
 	};
 
-	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 	if (rc < 0)
 		return rc;
 
@@ -170,6 +175,7 @@ static int cxl_pmem_security_passphrase_erase(struct nvdimm *nvdimm,
 	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
 	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_mbox_cmd mbox_cmd;
 	struct cxl_pass_erase erase;
 	int rc;
@@ -185,7 +191,7 @@ static int cxl_pmem_security_passphrase_erase(struct nvdimm *nvdimm,
 		.payload_in = &erase,
 	};
 
-	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 	if (rc < 0)
 		return rc;
 
diff --git a/include/linux/cxl/mailbox.h b/include/linux/cxl/mailbox.h
index 654df6175828..2380b22d7a12 100644
--- a/include/linux/cxl/mailbox.h
+++ b/include/linux/cxl/mailbox.h
@@ -3,6 +3,7 @@
 #ifndef __CXL_MBOX_H__
 #define __CXL_MBOX_H__
 
+#include <uapi/linux/cxl_mem.h>
 #include <linux/auxiliary_bus.h>
 
 /**
@@ -45,6 +46,8 @@ struct cxl_mbox_cmd {
  * struct cxl_mailbox - context for CXL mailbox operations
  * @host: device that hosts the mailbox
  * @adev: auxiliary device for fw-ctl
+ * @enabled_cmds: Hardware commands found enabled in CEL.
+ * @exclusive_cmds: Commands that are kernel-internal only
  * @payload_size: Size of space for payload
  *                (CXL 3.1 8.2.8.4.3 Mailbox Capabilities Register)
  * @mbox_mutex: mutex protects device mailbox and firmware
@@ -54,6 +57,8 @@ struct cxl_mbox_cmd {
 struct cxl_mailbox {
 	struct device *host;
 	struct auxiliary_device adev; /* For fw-ctl */
+	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
+	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
 	size_t payload_size;
 	struct mutex mbox_mutex; /* lock to protect mailbox context */
 	struct rcuwait mbox_wait;
-- 
2.34.1


