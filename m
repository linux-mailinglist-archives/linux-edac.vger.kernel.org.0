Return-Path: <linux-edac+bounces-1974-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A82996A6A
	for <lists+linux-edac@lfdr.de>; Wed,  9 Oct 2024 14:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20F16282FEE
	for <lists+linux-edac@lfdr.de>; Wed,  9 Oct 2024 12:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAC519AA63;
	Wed,  9 Oct 2024 12:43:21 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE32199FDA;
	Wed,  9 Oct 2024 12:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728477801; cv=none; b=rW7M71f9SC6mXx1r3xq8WXNW8jJmzMNw72fvGvRhdOiaGv6qLPlIBVWBn1GMiOxRYv+4b9mgo3EWZrIUEhX2bsGm6GN3PC3moLlqp5u+4NJ8oimrUk8xrx67VdO06EtIlQ+MasmzHHKb9AMmVBgwVbt97gHHEfRD6KSZOz7Ypqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728477801; c=relaxed/simple;
	bh=xI1/mDEUVcgehJeYztwKZRX3KZjtzcwIo/1ptpPrxpk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t2f9Mmo4Bpx1m6CRJACt63K1ZR3vPa9s1HU4w5j50ydNCcs5Wsrs2bh5JnAVO00jQVYzI+0eQGLMBRQyeEhmDgqemzMYs1FP+0V6DoABvv8HU1WewABP5dsnNGkGO9wWRsuh+M583jdlIoM7zpOKd0KONWPEoHD2hK8VcURr4Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XNsxH4KKQz6GD4k;
	Wed,  9 Oct 2024 20:42:59 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 47E19140C98;
	Wed,  9 Oct 2024 20:43:17 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.152.209) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Oct 2024 14:43:15 +0200
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
Subject: [PATCH v13 06/18] cxl: Convert cxl_internal_send_cmd() to use 'struct cxl_mailbox' as input
Date: Wed, 9 Oct 2024 13:41:07 +0100
Message-ID: <20241009124120.1124-7-shiju.jose@huawei.com>
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

With the CXL mailbox context split out, cxl_internal_send_cmd() can take
'struct cxl_mailbox' as an input parameter rather than
'struct memdev_dev_state'. Change input parameter for
cxl_internal_send_cmd() and fixup all impacted call sites.

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Link: https://patch.msgid.link/20240724185649.2574627-3-dave.jiang@intel.com
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core/mbox.c   | 38 ++++++++++++++++++++------------------
 drivers/cxl/core/memdev.c | 23 +++++++++++++----------
 drivers/cxl/cxlmem.h      |  2 +-
 drivers/cxl/pci.c         |  6 ++++--
 drivers/cxl/pmem.c        |  6 ++++--
 drivers/cxl/security.c    | 23 ++++++++++++-----------
 6 files changed, 54 insertions(+), 44 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 4d37462125b9..e77fb28cb6b2 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -225,7 +225,7 @@ static const char *cxl_mem_opcode_to_name(u16 opcode)
 
 /**
  * cxl_internal_send_cmd() - Kernel internal interface to send a mailbox command
- * @mds: The driver data for the operation
+ * @cxl_mbox: CXL mailbox context
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
 
@@ -689,7 +688,7 @@ static int cxl_xfer_log(struct cxl_memdev_state *mds, uuid_t *uuid,
 			.payload_out = out,
 		};
 
-		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 
 		/*
 		 * The output payload length that indicates the number
@@ -775,7 +774,7 @@ static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_memdev_state *
 		/* At least the record number field must be valid */
 		.min_out = 2,
 	};
-	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 	if (rc < 0) {
 		kvfree(ret);
 		return ERR_PTR(rc);
@@ -964,7 +963,7 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
 
 		if (i == max_handles) {
 			payload->nr_recs = i;
-			rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+			rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 			if (rc)
 				goto free_pl;
 			i = 0;
@@ -975,7 +974,7 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
 	if (i) {
 		payload->nr_recs = i;
 		mbox_cmd.size_in = struct_size(payload, handles, i);
-		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 		if (rc)
 			goto free_pl;
 	}
@@ -1009,7 +1008,7 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
 			.min_out = struct_size(payload, records, 0),
 		};
 
-		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 		if (rc) {
 			dev_err_ratelimited(dev,
 				"Event log '%d': Failed to query event records : %d",
@@ -1080,6 +1079,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, CXL);
  */
 static int cxl_mem_get_partition_info(struct cxl_memdev_state *mds)
 {
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_mbox_get_partition_info pi;
 	struct cxl_mbox_cmd mbox_cmd;
 	int rc;
@@ -1089,7 +1089,7 @@ static int cxl_mem_get_partition_info(struct cxl_memdev_state *mds)
 		.size_out = sizeof(pi),
 		.payload_out = &pi,
 	};
-	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 	if (rc)
 		return rc;
 
@@ -1116,6 +1116,7 @@ static int cxl_mem_get_partition_info(struct cxl_memdev_state *mds)
  */
 int cxl_dev_state_identify(struct cxl_memdev_state *mds)
 {
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	/* See CXL 2.0 Table 175 Identify Memory Device Output Payload */
 	struct cxl_mbox_identify id;
 	struct cxl_mbox_cmd mbox_cmd;
@@ -1130,7 +1131,7 @@ int cxl_dev_state_identify(struct cxl_memdev_state *mds)
 		.size_out = sizeof(id),
 		.payload_out = &id,
 	};
-	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 	if (rc < 0)
 		return rc;
 
@@ -1158,6 +1159,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_dev_state_identify, CXL);
 
 static int __cxl_mem_sanitize(struct cxl_memdev_state *mds, u16 cmd)
 {
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	int rc;
 	u32 sec_out = 0;
 	struct cxl_get_security_output {
@@ -1169,14 +1171,13 @@ static int __cxl_mem_sanitize(struct cxl_memdev_state *mds, u16 cmd)
 		.size_out = sizeof(out),
 	};
 	struct cxl_mbox_cmd mbox_cmd = { .opcode = cmd };
-	struct cxl_dev_state *cxlds = &mds->cxlds;
 
 	if (cmd != CXL_MBOX_OP_SANITIZE && cmd != CXL_MBOX_OP_SECURE_ERASE)
 		return -EINVAL;
 
-	rc = cxl_internal_send_cmd(mds, &sec_cmd);
+	rc = cxl_internal_send_cmd(cxl_mbox, &sec_cmd);
 	if (rc < 0) {
-		dev_err(cxlds->dev, "Failed to get security state : %d", rc);
+		dev_err(cxl_mbox->host, "Failed to get security state : %d", rc);
 		return rc;
 	}
 
@@ -1193,9 +1194,9 @@ static int __cxl_mem_sanitize(struct cxl_memdev_state *mds, u16 cmd)
 	    sec_out & CXL_PMEM_SEC_STATE_LOCKED)
 		return -EINVAL;
 
-	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 	if (rc < 0) {
-		dev_err(cxlds->dev, "Failed to sanitize device : %d", rc);
+		dev_err(cxl_mbox->host, "Failed to sanitize device : %d", rc);
 		return rc;
 	}
 
@@ -1310,6 +1311,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_mem_create_range_info, CXL);
 
 int cxl_set_timestamp(struct cxl_memdev_state *mds)
 {
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_mbox_cmd mbox_cmd;
 	struct cxl_mbox_set_timestamp_in pi;
 	int rc;
@@ -1321,7 +1323,7 @@ int cxl_set_timestamp(struct cxl_memdev_state *mds)
 		.payload_in = &pi,
 	};
 
-	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 	/*
 	 * Command is optional. Devices may have another way of providing
 	 * a timestamp, or may return all 0s in timestamp fields.
@@ -1338,7 +1340,7 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 		       struct cxl_region *cxlr)
 {
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
-	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
+	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
 	struct cxl_mbox_poison_out *po;
 	struct cxl_mbox_poison_in pi;
 	int nr_records = 0;
@@ -1362,7 +1364,7 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 			.min_out = struct_size(po, record, 0),
 		};
 
-		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 		if (rc)
 			break;
 
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 05bb84cb1274..84fefb76dafa 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -278,7 +278,7 @@ static int cxl_validate_poison_dpa(struct cxl_memdev *cxlmd, u64 dpa)
 
 int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 {
-	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
 	struct cxl_mbox_inject_poison inject;
 	struct cxl_poison_record record;
 	struct cxl_mbox_cmd mbox_cmd;
@@ -308,13 +308,13 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 		.size_in = sizeof(inject),
 		.payload_in = &inject,
 	};
-	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 	if (rc)
 		goto out;
 
 	cxlr = cxl_dpa_to_region(cxlmd, dpa);
 	if (cxlr)
-		dev_warn_once(mds->cxlds.dev,
+		dev_warn_once(cxl_mbox->host,
 			      "poison inject dpa:%#llx region: %s\n", dpa,
 			      dev_name(&cxlr->dev));
 
@@ -333,7 +333,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_inject_poison, CXL);
 
 int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
 {
-	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
 	struct cxl_mbox_clear_poison clear;
 	struct cxl_poison_record record;
 	struct cxl_mbox_cmd mbox_cmd;
@@ -372,13 +372,13 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
 		.payload_in = &clear,
 	};
 
-	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 	if (rc)
 		goto out;
 
 	cxlr = cxl_dpa_to_region(cxlmd, dpa);
 	if (cxlr)
-		dev_warn_once(mds->cxlds.dev,
+		dev_warn_once(cxl_mbox->host,
 			      "poison clear dpa:%#llx region: %s\n", dpa,
 			      dev_name(&cxlr->dev));
 
@@ -715,6 +715,7 @@ static int cxl_memdev_release_file(struct inode *inode, struct file *file)
  */
 static int cxl_mem_get_fw_info(struct cxl_memdev_state *mds)
 {
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_mbox_get_fw_info info;
 	struct cxl_mbox_cmd mbox_cmd;
 	int rc;
@@ -725,7 +726,7 @@ static int cxl_mem_get_fw_info(struct cxl_memdev_state *mds)
 		.payload_out = &info,
 	};
 
-	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 	if (rc < 0)
 		return rc;
 
@@ -749,6 +750,7 @@ static int cxl_mem_get_fw_info(struct cxl_memdev_state *mds)
  */
 static int cxl_mem_activate_fw(struct cxl_memdev_state *mds, int slot)
 {
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_mbox_activate_fw activate;
 	struct cxl_mbox_cmd mbox_cmd;
 
@@ -765,7 +767,7 @@ static int cxl_mem_activate_fw(struct cxl_memdev_state *mds, int slot)
 	activate.action = CXL_FW_ACTIVATE_OFFLINE;
 	activate.slot = slot;
 
-	return cxl_internal_send_cmd(mds, &mbox_cmd);
+	return cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 }
 
 /**
@@ -780,6 +782,7 @@ static int cxl_mem_activate_fw(struct cxl_memdev_state *mds, int slot)
  */
 static int cxl_mem_abort_fw_xfer(struct cxl_memdev_state *mds)
 {
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_mbox_transfer_fw *transfer;
 	struct cxl_mbox_cmd mbox_cmd;
 	int rc;
@@ -799,7 +802,7 @@ static int cxl_mem_abort_fw_xfer(struct cxl_memdev_state *mds)
 
 	transfer->action = CXL_FW_TRANSFER_ACTION_ABORT;
 
-	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 	kfree(transfer);
 	return rc;
 }
@@ -924,7 +927,7 @@ static enum fw_upload_err cxl_fw_write(struct fw_upload *fwl, const u8 *data,
 		.poll_count = 30,
 	};
 
-	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 	if (rc < 0) {
 		rc = FW_UPLOAD_ERR_RW_ERROR;
 		goto out_free;
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 4ead415f8971..c7c423ae16ab 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -811,7 +811,7 @@ enum {
 	CXL_PMEM_SEC_PASS_USER,
 };
 
-int cxl_internal_send_cmd(struct cxl_memdev_state *mds,
+int cxl_internal_send_cmd(struct cxl_mailbox *cxl_mbox,
 			  struct cxl_mbox_cmd *cmd);
 int cxl_dev_state_identify(struct cxl_memdev_state *mds);
 int cxl_await_media_ready(struct cxl_dev_state *cxlds);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index eca6f533386b..3b747aff2f4b 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -658,6 +658,7 @@ static int cxl_event_req_irq(struct cxl_dev_state *cxlds, u8 setting)
 static int cxl_event_get_int_policy(struct cxl_memdev_state *mds,
 				    struct cxl_event_interrupt_policy *policy)
 {
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_mbox_cmd mbox_cmd = {
 		.opcode = CXL_MBOX_OP_GET_EVT_INT_POLICY,
 		.payload_out = policy,
@@ -665,7 +666,7 @@ static int cxl_event_get_int_policy(struct cxl_memdev_state *mds,
 	};
 	int rc;
 
-	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 	if (rc < 0)
 		dev_err(mds->cxlds.dev,
 			"Failed to get event interrupt policy : %d", rc);
@@ -676,6 +677,7 @@ static int cxl_event_get_int_policy(struct cxl_memdev_state *mds,
 static int cxl_event_config_msgnums(struct cxl_memdev_state *mds,
 				    struct cxl_event_interrupt_policy *policy)
 {
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_mbox_cmd mbox_cmd;
 	int rc;
 
@@ -692,7 +694,7 @@ static int cxl_event_config_msgnums(struct cxl_memdev_state *mds,
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
index 21856a3f408e..452d1a9b9148 100644
--- a/drivers/cxl/security.c
+++ b/drivers/cxl/security.c
@@ -14,6 +14,7 @@ static unsigned long cxl_pmem_get_security_flags(struct nvdimm *nvdimm,
 {
 	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
 	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
+	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
 	unsigned long security_flags = 0;
 	struct cxl_get_security_output {
@@ -29,7 +30,7 @@ static unsigned long cxl_pmem_get_security_flags(struct nvdimm *nvdimm,
 		.payload_out = &out,
 	};
 
-	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 	if (rc < 0)
 		return 0;
 
@@ -70,7 +71,7 @@ static int cxl_pmem_security_change_key(struct nvdimm *nvdimm,
 {
 	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
 	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
-	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
 	struct cxl_mbox_cmd mbox_cmd;
 	struct cxl_set_pass set_pass;
 
@@ -87,7 +88,7 @@ static int cxl_pmem_security_change_key(struct nvdimm *nvdimm,
 		.payload_in = &set_pass,
 	};
 
-	return cxl_internal_send_cmd(mds, &mbox_cmd);
+	return cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 }
 
 static int __cxl_pmem_security_disable(struct nvdimm *nvdimm,
@@ -96,7 +97,7 @@ static int __cxl_pmem_security_disable(struct nvdimm *nvdimm,
 {
 	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
 	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
-	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
 	struct cxl_disable_pass dis_pass;
 	struct cxl_mbox_cmd mbox_cmd;
 
@@ -112,7 +113,7 @@ static int __cxl_pmem_security_disable(struct nvdimm *nvdimm,
 		.payload_in = &dis_pass,
 	};
 
-	return cxl_internal_send_cmd(mds, &mbox_cmd);
+	return cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 }
 
 static int cxl_pmem_security_disable(struct nvdimm *nvdimm,
@@ -131,12 +132,12 @@ static int cxl_pmem_security_freeze(struct nvdimm *nvdimm)
 {
 	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
 	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
-	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
 	struct cxl_mbox_cmd mbox_cmd = {
 		.opcode = CXL_MBOX_OP_FREEZE_SECURITY,
 	};
 
-	return cxl_internal_send_cmd(mds, &mbox_cmd);
+	return cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 }
 
 static int cxl_pmem_security_unlock(struct nvdimm *nvdimm,
@@ -144,7 +145,7 @@ static int cxl_pmem_security_unlock(struct nvdimm *nvdimm,
 {
 	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
 	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
-	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
 	u8 pass[NVDIMM_PASSPHRASE_LEN];
 	struct cxl_mbox_cmd mbox_cmd;
 	int rc;
@@ -156,7 +157,7 @@ static int cxl_pmem_security_unlock(struct nvdimm *nvdimm,
 		.payload_in = pass,
 	};
 
-	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 	if (rc < 0)
 		return rc;
 
@@ -169,7 +170,7 @@ static int cxl_pmem_security_passphrase_erase(struct nvdimm *nvdimm,
 {
 	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
 	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
-	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
 	struct cxl_mbox_cmd mbox_cmd;
 	struct cxl_pass_erase erase;
 	int rc;
@@ -185,7 +186,7 @@ static int cxl_pmem_security_passphrase_erase(struct nvdimm *nvdimm,
 		.payload_in = &erase,
 	};
 
-	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 	if (rc < 0)
 		return rc;
 
-- 
2.34.1


