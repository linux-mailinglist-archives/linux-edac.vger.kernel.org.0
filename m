Return-Path: <linux-edac+bounces-5667-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCCgAFv0cWmvZwAAu9opvQ
	(envelope-from <linux-edac+bounces-5667-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Thu, 22 Jan 2026 10:56:43 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 842B864E16
	for <lists+linux-edac@lfdr.de>; Thu, 22 Jan 2026 10:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 86D04842742
	for <lists+linux-edac@lfdr.de>; Thu, 22 Jan 2026 09:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774273E9F62;
	Thu, 22 Jan 2026 09:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WbpP7oA7"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70996284B26;
	Thu, 22 Jan 2026 09:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769075295; cv=none; b=d0WavrGqXTdW7T34hwuH278nLcDI4F3ykz+pwoEL6g+A9M+h31g8AuqFILv0MTixv/44iGvhviYJgmiwrTNxICVCC1ffh5gkoMMXIABHKB2ICG+ZdWj7xr/2XYDOpu8FDXufBy4d2ULE04OHkrXjp/9eDxoJlFh458ZEqW9cers=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769075295; c=relaxed/simple;
	bh=Gw3ltpMhhEaoRgz7zgwlj8pS1KIbGhH45BEv23tb9Y4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k2dDXGEV1Yuo/wMDXDxW2JslDN0j6BFD/Zr8k/gMm34Cshyjko1RqolE+WAZo873rGv5PesNcMLGpJOjDCWeFjmDPlkJh/zjYZh3+z2qf/yDBciOymWxzWNayHu+zahrwDU9Yh7MvHuZimtfAmxVSD8aZjU/DIxBOErvwMkBSbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WbpP7oA7; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769075282; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=HbjJfoRz9aErwXVTMtf0zYLIY833c8yNPoAwx9n0qRw=;
	b=WbpP7oA7u5fNpl21lqfIZA+4NJB/EKOtQlI8DU8+d08gMe/TkKUXqcPiL6efae2/eqeKPIiJonQhMx5hPZhRPd9+XlP+iLR718/LLzGlTKoSl3RVZAKi4AuqnMJEFEbIIezlDHhFgWdAcUOmL28WXgjKypNOd6MOZJP3VEeN0vE=
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0WxbuaeA_1769075278 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 22 Jan 2026 17:48:01 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	lpieralisi@kernel.org,
	guohanjun@huawei.com,
	sudeep.holla@arm.com,
	rafael@kernel.org,
	robin.murphy@arm.com,
	mark.rutland@arm.com,
	tony.luck@intel.com,
	bp@alien8.de,
	tglx@linutronix.de,
	peterz@infradead.org
Cc: lenb@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-edac@vger.kernel.org,
	mchehab@kernel.org,
	xueshuai@linux.alibaba.com,
	zhuo.song@linux.alibaba.com,
	oliver.yang@linux.alibaba.com,
	Ruidong Tian <tianruidong@linux.alibaba.com>
Subject: [PATCH v6 08/16] ras: AEST: Enable and register IRQs
Date: Thu, 22 Jan 2026 17:46:48 +0800
Message-Id: <20260122094656.73399-9-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20260122094656.73399-1-tianruidong@linux.alibaba.com>
References: <20260122094656.73399-1-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.46 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-5667-lists,linux-edac=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linux.alibaba.com,none];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-edac];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[tianruidong@linux.alibaba.com,linux-edac@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,linux.alibaba.com:mid,linux.alibaba.com:dkim]
X-Rspamd-Queue-Id: 842B864E16
X-Rspamd-Action: no action

The interrupt numbers for certain error records may be explicitly
programmed into their configuration register.

And for PPIs, each core will maintains its own copy of the aest_device
structure.

Given that handling RAS errors entails complex processes such as EDAC
and memory_failure, all handling is deferred to and handled within a
bottom-half context.

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 arch/arm64/include/asm/ras.h |  36 +++
 drivers/ras/aest/aest-core.c | 531 ++++++++++++++++++++++++++++++++++-
 drivers/ras/aest/aest.h      |  56 ++++
 include/linux/acpi_aest.h    |   7 +
 include/linux/ras.h          |   8 +
 5 files changed, 637 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/ras.h b/arch/arm64/include/asm/ras.h
index 6c51d27520c0..02cf15278d9f 100644
--- a/arch/arm64/include/asm/ras.h
+++ b/arch/arm64/include/asm/ras.h
@@ -2,6 +2,7 @@
 #ifndef __ASM_RAS_H
 #define __ASM_RAS_H
 
+#include <linux/bits.h>
 #include <linux/types.h>
 
 /* ERR<n>FR */
@@ -37,6 +38,41 @@
 #define ERR_MISC0_16B_OFR BIT(47)
 #define ERR_MISC0_16B_CECR GENMASK_ULL(46, 32)
 
+/* ERR<n>STATUS */
+#define ERR_STATUS_AV BIT(31)
+#define ERR_STATUS_V BIT(30)
+#define ERR_STATUS_UE BIT(29)
+#define ERR_STATUS_ER BIT(28)
+#define ERR_STATUS_OF BIT(27)
+#define ERR_STATUS_MV BIT(26)
+#define ERR_STATUS_CE (BIT(25) | BIT(24))
+#define ERR_STATUS_DE BIT(23)
+#define ERR_STATUS_PN BIT(22)
+#define ERR_STATUS_UET (BIT(21) | BIT(20))
+#define ERR_STATUS_CI BIT(19)
+#define ERR_STATUS_IERR GENMASK_ULL(15, 8)
+#define ERR_STATUS_SERR GENMASK_ULL(7, 0)
+
+/* Theses bits are	 write-one-to-clear */
+#define ERR_STATUS_W1TC                                                  \
+	(ERR_STATUS_AV | ERR_STATUS_V | ERR_STATUS_UE | ERR_STATUS_ER |  \
+	 ERR_STATUS_OF | ERR_STATUS_MV | ERR_STATUS_CE | ERR_STATUS_DE | \
+	 ERR_STATUS_PN | ERR_STATUS_UET | ERR_STATUS_CI)
+
+#define ERR_STATUS_UET_UC 0
+#define ERR_STATUS_UET_UEU 1
+#define ERR_STATUS_UET_UEO 2
+#define ERR_STATUS_UET_UER 3
+
+/* ERR<n>ADDR */
+#define ERR_ADDR_AI BIT(61)
+#define ERR_ADDR_PADDR GENMASK_ULL(55, 0)
+
+/* ERR<n>CTLR */
+#define ERR_CTLR_CFI BIT(8)
+#define ERR_CTLR_FI BIT(3)
+#define ERR_CTLR_UI BIT(2)
+
 /* ERRDEVARCH */
 #define ERRDEVARCH_REV GENMASK(19, 16)
 
diff --git a/drivers/ras/aest/aest-core.c b/drivers/ras/aest/aest-core.c
index 5cfe91a6d72a..5ec0ba38f51b 100644
--- a/drivers/ras/aest/aest-core.c
+++ b/drivers/ras/aest/aest-core.c
@@ -5,8 +5,11 @@
  * Copyright (c) 2025, Alibaba Group.
  */
 
+#include <linux/interrupt.h>
+#include <linux/panic.h>
 #include <linux/platform_device.h>
 #include <linux/xarray.h>
+#include <linux/genalloc.h>
 #include <linux/ras.h>
 
 #include "aest.h"
@@ -16,6 +19,439 @@ DEFINE_PER_CPU(struct aest_device, percpu_adev);
 #undef pr_fmt
 #define pr_fmt(fmt) "AEST: " fmt
 
+/*
+ * This memory pool is only to be used to save AEST node in AEST irq context.
+ * There can be 500 AEST node at most.
+ */
+#define AEST_NODE_ALLOCED_MAX 500
+
+#define AEST_LOG_PREFIX_BUFFER 64
+
+BLOCKING_NOTIFIER_HEAD(aest_decoder_chain);
+
+static void aest_print(struct aest_event *event)
+{
+	static atomic_t seqno = { 0 };
+	unsigned int curr_seqno;
+	char pfx_seq[AEST_LOG_PREFIX_BUFFER];
+	int index;
+	struct ras_ext_regs *regs;
+
+	curr_seqno = atomic_inc_return(&seqno);
+	snprintf(pfx_seq, sizeof(pfx_seq), "{%u}" HW_ERR, curr_seqno);
+	pr_info("%sHardware error from AEST %s\n", pfx_seq, event->node_name);
+
+	switch (event->type) {
+	case ACPI_AEST_PROCESSOR_ERROR_NODE:
+		pr_err("%s Error from CPU%d\n", pfx_seq, event->id0);
+		break;
+	case ACPI_AEST_MEMORY_ERROR_NODE:
+		pr_err("%s Error from memory at SRAT proximity domain %#x\n",
+		       pfx_seq, event->id0);
+		break;
+	case ACPI_AEST_SMMU_ERROR_NODE:
+		pr_err("%s Error from SMMU IORT node %#x subcomponent %#x\n",
+		       pfx_seq, event->id0, event->id1);
+		break;
+	case ACPI_AEST_VENDOR_ERROR_NODE:
+		pr_err("%s Error from vendor hid %8.8s uid %#x\n", pfx_seq,
+		       event->hid, event->id1);
+		break;
+	case ACPI_AEST_GIC_ERROR_NODE:
+		pr_err("%s Error from GIC type %#x instance %#x\n", pfx_seq,
+		       event->id0, event->id1);
+		break;
+	default:
+		pr_err("%s Unknown AEST node type\n", pfx_seq);
+		return;
+	}
+
+	index = event->index;
+	regs = &event->regs;
+
+	pr_err("%s  ERR%dFR: 0x%llx\n", pfx_seq, index, regs->err_fr);
+	pr_err("%s  ERR%dCTRL: 0x%llx\n", pfx_seq, index, regs->err_ctlr);
+	pr_err("%s  ERR%dSTATUS: 0x%llx\n", pfx_seq, index, regs->err_status);
+	if (regs->err_status & ERR_STATUS_AV)
+		pr_err("%s  ERR%dADDR: 0x%llx\n", pfx_seq, index,
+		       regs->err_addr);
+
+	if (regs->err_status & ERR_STATUS_MV) {
+		pr_err("%s  ERR%dMISC0: 0x%llx\n", pfx_seq, index,
+		       regs->err_misc[0]);
+		pr_err("%s  ERR%dMISC1: 0x%llx\n", pfx_seq, index,
+		       regs->err_misc[1]);
+		pr_err("%s  ERR%dMISC2: 0x%llx\n", pfx_seq, index,
+		       regs->err_misc[2]);
+		pr_err("%s  ERR%dMISC3: 0x%llx\n", pfx_seq, index,
+		       regs->err_misc[3]);
+	}
+}
+
+static void aest_handle_memory_failure(u64 addr)
+{
+	unsigned long pfn;
+
+	pfn = PHYS_PFN(addr);
+
+	if (!pfn_valid(pfn)) {
+		pr_warn(HW_ERR "Invalid physical address: %#llx\n", addr);
+		return;
+	}
+
+#ifdef CONFIG_MEMORY_FAILURE
+	memory_failure(pfn, 0);
+#endif
+}
+
+static void init_aest_event(struct aest_event *event,
+			    struct aest_record *record,
+			    struct ras_ext_regs *regs)
+{
+	struct aest_node *node = record->node;
+	struct acpi_aest_node *info = node->info;
+
+	event->type = node->type;
+	event->node_name = node->name;
+	switch (node->type) {
+	case ACPI_AEST_PROCESSOR_ERROR_NODE:
+		if (info->processor->flags &
+		    (ACPI_AEST_PROC_FLAG_SHARED | ACPI_AEST_PROC_FLAG_GLOBAL))
+			event->id0 = smp_processor_id();
+		else
+			event->id0 = get_cpu_for_acpi_id(
+				info->processor->processor_id);
+
+		event->id1 = info->processor->resource_type;
+		break;
+	case ACPI_AEST_MEMORY_ERROR_NODE:
+		event->id0 = info->memory->srat_proximity_domain;
+		break;
+	case ACPI_AEST_SMMU_ERROR_NODE:
+		event->id0 = info->smmu->iort_node_reference;
+		event->id1 = info->smmu->subcomponent_reference;
+		break;
+	case ACPI_AEST_VENDOR_ERROR_NODE:
+		event->id0 = 0;
+		event->id1 = info->vendor->acpi_uid;
+		event->hid = info->vendor->acpi_hid;
+		break;
+	case ACPI_AEST_GIC_ERROR_NODE:
+		event->id0 = info->gic->interface_type;
+		event->id1 = info->gic->instance_id;
+		break;
+	default:
+		event->id0 = 0;
+		event->id1 = 0;
+	}
+
+	memcpy(&event->regs, regs, sizeof(*regs));
+	event->index = record->index;
+	event->addressing_mode = record->addressing_mode;
+}
+
+static int aest_node_gen_pool_add(struct aest_device *adev,
+				  struct aest_record *record,
+				  struct ras_ext_regs *regs)
+{
+	struct aest_event *event;
+
+	if (!adev->pool)
+		return -EINVAL;
+
+	event = (void *)gen_pool_alloc(adev->pool, sizeof(*event));
+	if (!event)
+		return -ENOMEM;
+
+	init_aest_event(event, record, regs);
+	llist_add(&event->llnode, &adev->event_list);
+
+	return 0;
+}
+
+static void aest_log(struct aest_record *record, struct ras_ext_regs *regs)
+{
+	struct aest_device *adev = record->node->adev;
+
+	if (!aest_node_gen_pool_add(adev, record, regs))
+		schedule_work(&adev->aest_work);
+}
+
+void aest_register_decode_chain(struct notifier_block *nb)
+{
+	blocking_notifier_chain_register(&aest_decoder_chain, nb);
+}
+EXPORT_SYMBOL_GPL(aest_register_decode_chain);
+
+void aest_unregister_decode_chain(struct notifier_block *nb)
+{
+	blocking_notifier_chain_unregister(&aest_decoder_chain, nb);
+}
+EXPORT_SYMBOL_GPL(aest_unregister_decode_chain);
+
+static void aest_node_pool_process(struct work_struct *work)
+{
+	struct llist_node *head;
+	struct aest_event *event;
+	struct aest_device *adev =
+		container_of(work, struct aest_device, aest_work);
+	u64 status, addr;
+
+	head = llist_del_all(&adev->event_list);
+	if (!head)
+		return;
+
+	head = llist_reverse_order(head);
+	llist_for_each_entry(event, head, llnode) {
+		aest_print(event);
+
+		status = event->regs.err_status;
+		if (!(event->regs.err_addr & ERR_ADDR_AI) &&
+		    (status & (ERR_STATUS_UE | ERR_STATUS_DE))) {
+			if (event->addressing_mode == AEST_ADDREESS_SPA)
+				addr = event->regs.err_addr & PHYS_MASK;
+			aest_handle_memory_failure(addr);
+		}
+
+		blocking_notifier_call_chain(&aest_decoder_chain, 0, event);
+		gen_pool_free(adev->pool, (unsigned long)event, sizeof(*event));
+	}
+}
+
+static int aest_node_pool_init(struct aest_device *adev)
+{
+	unsigned long addr, size;
+
+	size = ilog2(sizeof(struct aest_event));
+	adev->pool =
+		devm_gen_pool_create(adev->dev, size, -1, dev_name(adev->dev));
+	if (!adev->pool)
+		return -ENOMEM;
+
+	size = PAGE_ALIGN(size * AEST_NODE_ALLOCED_MAX);
+	addr = (unsigned long)devm_kzalloc(adev->dev, size, GFP_KERNEL);
+	if (!addr)
+		return -ENOMEM;
+
+	return gen_pool_add(adev->pool, addr, size, -1);
+}
+
+static void aest_panic(struct aest_record *record, struct ras_ext_regs *regs,
+		       char *msg)
+{
+	struct aest_event event = { 0 };
+
+	init_aest_event(&event, record, regs);
+
+	aest_print(&event);
+
+	panic(msg);
+}
+
+static void aest_proc_record(struct aest_record *record, void *data)
+{
+	struct ras_ext_regs regs = { 0 };
+	int *count = data;
+	u64 ue;
+
+	regs.err_status = record_read(record, ERXSTATUS);
+	if (!(regs.err_status & ERR_STATUS_V))
+		return;
+
+	(*count)++;
+
+	if (regs.err_status & ERR_STATUS_AV)
+		regs.err_addr = record_read(record, ERXADDR);
+
+	regs.err_fr = record_read(record, ERXFR);
+	regs.err_ctlr = record_read(record, ERXCTLR);
+
+	if (regs.err_status & ERR_STATUS_MV) {
+		regs.err_misc[0] = record_read(record, ERXMISC0);
+		regs.err_misc[1] = record_read(record, ERXMISC1);
+		if (record->node->version >= ID_AA64PFR0_EL1_RAS_V1P1) {
+			regs.err_misc[2] = record_read(record, ERXMISC2);
+			regs.err_misc[3] = record_read(record, ERXMISC3);
+		}
+
+		if (record->node->info->interface_hdr->flags &
+		    AEST_XFACE_FLAG_CLEAR_MISC) {
+			record_write(record, ERXMISC0, 0);
+			record_write(record, ERXMISC1, 0);
+			if (record->node->version >= ID_AA64PFR0_EL1_RAS_V1P1) {
+				record_write(record, ERXMISC2, 0);
+				record_write(record, ERXMISC3, 0);
+			}
+			/* ce count is 0 if record do not support ce */
+		} else if (record->ce.count > 0)
+			record_write(record, ERXMISC0, record->ce.reg_val);
+	}
+
+	/* panic if unrecoverable and uncontainable error encountered */
+	ue = FIELD_GET(ERR_STATUS_UET, regs.err_status);
+	if ((regs.err_status & ERR_STATUS_UE) &&
+	    (ue == ERR_STATUS_UET_UC || ue == ERR_STATUS_UET_UEU))
+		aest_panic(record, &regs,
+			   "AEST: unrecoverable error encountered");
+
+	aest_log(record, &regs);
+
+	/* Write-one-to-clear the bits we've seen */
+	regs.err_status &= ERR_STATUS_W1TC;
+
+	/* Multi bit filed need to write all-ones to clear. */
+	if (regs.err_status & ERR_STATUS_CE)
+		regs.err_status |= ERR_STATUS_CE;
+
+	/* Multi bit filed need to write all-ones to clear. */
+	if (regs.err_status & ERR_STATUS_UET)
+		regs.err_status |= ERR_STATUS_UET;
+
+	record_write(record, ERXSTATUS, regs.err_status);
+}
+
+static void aest_node_foreach_record(void (*func)(struct aest_record *, void *),
+				     struct aest_node *node, void *data,
+				     unsigned long *bitmap)
+{
+	int i;
+
+	for_each_clear_bit(i, bitmap, node->record_count) {
+		aest_select_record(node, i);
+
+		func(&node->records[i], data);
+
+		aest_sync(node);
+	}
+}
+
+static int aest_proc(struct aest_node *node)
+{
+	int count = 0, i, j, size = node->record_count;
+	u64 err_group = 0;
+
+	aest_node_dbg(node, "Poll bitmap %*pb\n", size,
+		      node->record_implemented);
+	aest_node_foreach_record(aest_proc_record, node, &count,
+				 node->record_implemented);
+
+	if (!node->errgsr)
+		return count;
+
+	aest_node_dbg(node, "Report bitmap %*pb\n", size,
+		      node->status_reporting);
+	for (i = 0; i < BITS_TO_U64(size); i++) {
+		err_group = readq_relaxed((void *)node->errgsr + i * 8);
+		aest_node_dbg(node, "errgsr[%d]: 0x%llx\n", i, err_group);
+
+		for_each_set_bit(j, (unsigned long *)&err_group,
+				 BITS_PER_LONG) {
+			/*
+			 * Error group base is only valid in Memory Map node,
+			 * so driver do not need to write select register and
+			 * sync.
+			 */
+			if (test_bit(i * BITS_PER_LONG + j,
+				     node->status_reporting))
+				continue;
+			aest_proc_record(&node->records[j], &count);
+		}
+	}
+
+	return count;
+}
+
+static irqreturn_t aest_irq_func(int irq, void *input)
+{
+	struct aest_device *adev = input;
+	int i;
+
+	for (i = 0; i < adev->node_cnt; i++)
+		aest_proc(&adev->nodes[i]);
+
+	return IRQ_HANDLED;
+}
+
+static int aest_register_irq(struct aest_device *adev)
+{
+	int i, irq, ret;
+	char *irq_desc;
+
+	irq_desc = devm_kasprintf(adev->dev, GFP_KERNEL, "%s.%s.",
+				  dev_driver_string(adev->dev),
+				  dev_name(adev->dev));
+	if (!irq_desc)
+		return -ENOMEM;
+
+	for (i = 0; i < MAX_GSI_PER_NODE; i++) {
+		irq = adev->irq[i];
+
+		if (!irq)
+			continue;
+
+		if (irq_is_percpu_devid(irq)) {
+			ret = request_percpu_irq(irq, aest_irq_func, irq_desc,
+						 adev->adev_oncore);
+			if (ret)
+				goto free;
+		} else {
+			ret = devm_request_irq(adev->dev, irq, aest_irq_func, 0,
+					       irq_desc, adev);
+			if (ret)
+				return ret;
+		}
+	}
+	return 0;
+
+free:
+	for (; i >= 0; i--) {
+		irq = adev->irq[i];
+
+		if (irq_is_percpu_devid(irq))
+			free_percpu_irq(irq, adev->adev_oncore);
+	}
+
+	return ret;
+}
+
+static void aest_enable_irq(struct aest_record *record)
+{
+	u64 err_ctlr;
+	struct aest_device *adev = record->node->adev;
+
+	err_ctlr = record_read(record, ERXCTLR);
+
+	if (adev->irq[ACPI_AEST_NODE_FAULT_HANDLING])
+		err_ctlr |= (ERR_CTLR_FI | ERR_CTLR_CFI);
+	if (adev->irq[ACPI_AEST_NODE_ERROR_RECOVERY])
+		err_ctlr |= ERR_CTLR_UI;
+
+	record_write(record, ERXCTLR, err_ctlr);
+}
+
+static void aest_config_irq(struct aest_node *node)
+{
+	int i;
+	struct acpi_aest_node_interrupt_v2 *interrupt;
+
+	if (!node->irq_config)
+		return;
+
+	for (i = 0; i < node->info->interrupt_count; i++) {
+		interrupt = &node->info->interrupt[i];
+
+		if (interrupt->type == ACPI_AEST_NODE_FAULT_HANDLING)
+			writeq_relaxed(interrupt->gsiv, node->irq_config);
+
+		if (interrupt->type == ACPI_AEST_NODE_ERROR_RECOVERY)
+			writeq_relaxed(interrupt->gsiv, node->irq_config + 8);
+
+		aest_node_dbg(node, "config irq type %d gsiv %d at %llx",
+			      interrupt->type, interrupt->gsiv,
+			      (u64)node->irq_config);
+	}
+}
+
 static enum ras_ce_threshold aest_get_ce_threshold(struct aest_record *record)
 {
 	u64 err_fr, err_fr_cec, err_fr_rp = -1;
@@ -128,6 +564,7 @@ static int aest_init_record(struct aest_record *record, int i,
 	record->index = i;
 	record->node = node;
 	aest_set_ce_threshold(record);
+	aest_enable_irq(record);
 
 	aest_record_dbg(record, "base: %p, index: %d, address mode: %x\n",
 			record->regs_base, record->index,
@@ -232,6 +669,21 @@ static int aest_init_node(struct aest_device *adev, struct aest_node *node,
 		}
 	}
 
+	address = node->info->common->interrupt_config_register_base;
+	if ((flags & AEST_XFACE_FLAG_INT_CONFIG) && address) {
+		if (address - anode->interface_hdr->address < node->group->size)
+			node->irq_config =
+				node->base +
+				(address - anode->interface_hdr->address);
+		else {
+			node->irq_config =
+				devm_ioremap(adev->dev, address, PAGE_SIZE);
+			if (!node->irq_config)
+				return -ENOMEM;
+		}
+	}
+	aest_config_irq(node);
+
 	ret = aest_node_set_errgsr(adev, node);
 	if (ret)
 		return ret;
@@ -276,6 +728,66 @@ static int aest_init_nodes(struct aest_device *adev, struct aest_hnode *ahnode)
 	return 0;
 }
 
+static int __setup_ppi(struct aest_device *adev)
+{
+	int cpu, i;
+	struct aest_device *oncore_adev;
+	struct aest_node *oncore_node;
+	size_t size;
+
+	adev->adev_oncore = &percpu_adev;
+	for_each_possible_cpu(cpu) {
+		oncore_adev = per_cpu_ptr(&percpu_adev, cpu);
+		memcpy(oncore_adev, adev, sizeof(struct aest_device));
+
+		oncore_adev->nodes =
+			devm_kcalloc(adev->dev, oncore_adev->node_cnt,
+				     sizeof(struct aest_node), GFP_KERNEL);
+		if (!oncore_adev->nodes)
+			return -ENOMEM;
+
+		size = adev->node_cnt * sizeof(struct aest_node);
+		memcpy(oncore_adev->nodes, adev->nodes, size);
+		for (i = 0; i < oncore_adev->node_cnt; i++) {
+			oncore_node = &oncore_adev->nodes[i];
+			oncore_node->records = devm_kcalloc(
+				adev->dev, oncore_node->record_count,
+				sizeof(struct aest_record), GFP_KERNEL);
+			if (!oncore_node->records)
+				return -ENOMEM;
+
+			size = oncore_node->record_count *
+			       sizeof(struct aest_record);
+			memcpy(oncore_node->records, adev->nodes[i].records,
+			       size);
+		}
+
+		aest_dev_dbg(adev, "Init device on CPU%d.\n", cpu);
+	}
+
+	return 0;
+}
+
+static int aest_setup_irq(struct platform_device *pdev,
+			  struct aest_device *adev)
+{
+	int fhi_irq, eri_irq;
+
+	fhi_irq = platform_get_irq_byname_optional(pdev, AEST_FHI_NAME);
+	if (fhi_irq > 0)
+		adev->irq[0] = fhi_irq;
+
+	eri_irq = platform_get_irq_byname_optional(pdev, AEST_ERI_NAME);
+	if (eri_irq > 0)
+		adev->irq[1] = eri_irq;
+
+	/* Allocate and initialise the percpu device pointer for PPI */
+	if (irq_is_percpu(fhi_irq) || irq_is_percpu(eri_irq))
+		return __setup_ppi(adev);
+
+	return 0;
+}
+
 static int aest_device_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -289,14 +801,31 @@ static int aest_device_probe(struct platform_device *pdev)
 	adev = devm_kzalloc(&pdev->dev, sizeof(*adev), GFP_KERNEL);
 	if (!adev)
 		return -ENOMEM;
-
 	adev->dev = &pdev->dev;
 	adev->id = pdev->id;
 	aest_set_name(adev, ahnode);
+
+	INIT_WORK(&adev->aest_work, aest_node_pool_process);
+	ret = aest_node_pool_init(adev);
+	if (ret) {
+		aest_dev_err(adev, "Failed init aest node pool.\n");
+		return ret;
+	}
+	init_llist_head(&adev->event_list);
+
 	ret = aest_init_nodes(adev, ahnode);
 	if (ret)
 		return ret;
 
+	ret = aest_setup_irq(pdev, adev);
+	if (ret)
+		return ret;
+
+	ret = aest_register_irq(adev);
+	if (ret) {
+		aest_dev_err(adev, "register irq failed\n");
+		return ret;
+	}
 	platform_set_drvdata(pdev, adev);
 
 	aest_dev_dbg(adev, "Node cnt: %x, id: %x\n", adev->node_cnt, adev->id);
diff --git a/drivers/ras/aest/aest.h b/drivers/ras/aest/aest.h
index 85eeed79bcbe..a5e43b2a2e90 100644
--- a/drivers/ras/aest/aest.h
+++ b/drivers/ras/aest/aest.h
@@ -67,6 +67,34 @@
 
 #define GIC_ERRDEVARCH 0xFFBC
 
+struct aest_event {
+	struct llist_node llnode;
+	char *node_name;
+	u32 type;
+	/*
+	 * Different nodes have different meanings:
+	 *   - Processor node	: processor number.
+	 *   - Memory node	: SRAT proximity domain.
+	 *   - SMMU node	: IORT proximity domain.
+	 *   - GIC node		: interface type.
+	 */
+	u32 id0;
+	/*
+	 * Different nodes have different meanings:
+	 *   - Processor node	: processor resource type.
+	 *   - Memory node	: Non.
+	 *   - SMMU node	: subcomponent reference.
+	 *   - Vendor node	: Unique ID.
+	 *   - GIC node		: instance identifier.
+	 */
+	u32 id1;
+	/* Vendor node	: hardware ID. */
+	char *hid;
+	u32 index;
+	int addressing_mode;
+	struct ras_ext_regs regs;
+};
+
 struct aest_access {
 	u64 (*read)(void *base, u32 offset);
 	void (*write)(void *base, u32 offset, u64 val);
@@ -141,6 +169,7 @@ struct aest_node {
 	void *errgsr;
 	void *base;
 	void *inj;
+	void *irq_config;
 
 	/*
 	 * This bitmap indicates which of the error records within this error
@@ -172,6 +201,7 @@ struct aest_node {
 
 	int record_count;
 	struct aest_record *records;
+	struct aest_node __percpu *oncore_node;
 };
 
 struct aest_device {
@@ -180,6 +210,12 @@ struct aest_device {
 	int node_cnt;
 	struct aest_node *nodes;
 	u32 id;
+	int irq[MAX_GSI_PER_NODE];
+
+	struct work_struct aest_work;
+	struct gen_pool *pool;
+	struct llist_head event_list;
+	struct aest_device __percpu *adev_oncore;
 };
 
 static const char *const aest_node_name[] = {
@@ -283,3 +319,23 @@ static const struct aest_access aest_access[] = {
 	},
 	{ }
 };
+
+/*
+ * Each PE may has multi error record, you must selects an error
+ * record to be accessed through the Error Record System
+ * registers.
+ */
+static inline void aest_select_record(struct aest_node *node, int index)
+{
+	if (node->type == ACPI_AEST_PROCESSOR_ERROR_NODE) {
+		write_sysreg_s(index, SYS_ERRSELR_EL1);
+		isb();
+	}
+}
+
+/* Ensure all writes has taken effect. */
+static inline void aest_sync(struct aest_node *node)
+{
+	if (node->type == ACPI_AEST_PROCESSOR_ERROR_NODE)
+		isb();
+}
diff --git a/include/linux/acpi_aest.h b/include/linux/acpi_aest.h
index a7898c643896..3a899f57f92f 100644
--- a/include/linux/acpi_aest.h
+++ b/include/linux/acpi_aest.h
@@ -10,6 +10,13 @@
 #define AEST_FHI_NAME "AEST:FHI"
 #define AEST_ERI_NAME "AEST:ERI"
 
+/* AEST component */
+#define ACPI_AEST_PROC_FLAG_GLOBAL	(1<<0)
+#define ACPI_AEST_PROC_FLAG_SHARED	(1<<1)
+
+#define AEST_ADDREESS_SPA	0
+#define AEST_ADDREESS_LA	1
+
 /* AEST interrupt */
 #define AEST_INTERRUPT_MODE BIT(0)
 
diff --git a/include/linux/ras.h b/include/linux/ras.h
index 468941bfe855..05096f049dac 100644
--- a/include/linux/ras.h
+++ b/include/linux/ras.h
@@ -63,4 +63,12 @@ amd_convert_umc_mca_addr_to_sys_addr(struct atl_err *err) { return -EINVAL; }
 #define GET_LOGICAL_INDEX(mpidr) -EINVAL
 #endif /* CONFIG_ARM || CONFIG_ARM64 */
 
+#if IS_ENABLED(CONFIG_AEST)
+void aest_register_decode_chain(struct notifier_block *nb);
+void aest_unregister_decode_chain(struct notifier_block *nb);
+#else
+static inline void aest_register_decode_chain(struct notifier_block *nb) {}
+static inline void aest_unregister_decode_chain(struct notifier_block *nb) {}
+#endif /* CONFIG_AEST */
+
 #endif /* __RAS_H__ */
-- 
2.51.2.612.gdc70283dfc


