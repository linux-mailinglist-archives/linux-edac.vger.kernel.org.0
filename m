Return-Path: <linux-edac+bounces-5670-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBqIIq70cWmvZwAAu9opvQ
	(envelope-from <linux-edac+bounces-5670-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Thu, 22 Jan 2026 10:58:06 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0736B64E73
	for <lists+linux-edac@lfdr.de>; Thu, 22 Jan 2026 10:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB3475A2735
	for <lists+linux-edac@lfdr.de>; Thu, 22 Jan 2026 09:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B29740FD98;
	Thu, 22 Jan 2026 09:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="avf3vb70"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9259D1DFD8B;
	Thu, 22 Jan 2026 09:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769075309; cv=none; b=FddYVQ9zywkcEnJyPOCupqJbjM335SzZcUy3738qehhDmxdd1+cVOdkN4G/C/Ct+sdzfzSIazi5TQ9BD/GGbu7MQJns+N1rLE4dpIEQzqoMBnq7oc3RHUmHE4kwmZX8N4X5ljD1eHKW2LeUWRY3tTxklq0J0yJFPhDvGNrttirU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769075309; c=relaxed/simple;
	bh=U3aoZdGfvPEnAjHsytDpBijt+ed6glREfxMWbeYLgLM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EFB3O/W7nDAyFFBE3KAoT5QCijDWKqrz7FeP10BYKI887xAujA4S6VR9KN7pi6juikro84t5vkBV9yu74nwQZXPaOFKmLEqpBmxnD0Gtk6louZYalMmfEMCHhH5zHCrMnKoJW2eUXI1D11DMwA5YaucM6YtK8mhQYUXmZonaNF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=avf3vb70; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769075297; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=BbFmhPJefrRUBcQA2i8vzPM7Ps4MQ8wQndxlldpZuls=;
	b=avf3vb700N+Akn3YMUDSYpYC4yOaXWEgWdaU6hb/6jpISPUFHi85r0jl8/I8xnY+crCEDtRxi5DIfyD5t5YoemXHlxH9Muigrs+gf/peWhUGE1ryqIFnT8Yk/SBN3pgw/OrrhBg3GKVZ3RxnYE873yMI45WFRB8uvjp1KwGL8NA=
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0WxbwggL_1769075292 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 22 Jan 2026 17:48:16 +0800
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
Subject: [PATCH v6 11/16] ras: AEST: Add error count tracking and debugfs interface
Date: Thu, 22 Jan 2026 17:46:51 +0800
Message-Id: <20260122094656.73399-12-tianruidong@linux.alibaba.com>
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
	TAGGED_FROM(0.00)[bounces-5670-lists,linux-edac=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linux.alibaba.com,none];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-edac];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[tianruidong@linux.alibaba.com,linux-edac@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,arm.com:url,linux.alibaba.com:mid,linux.alibaba.com:dkim]
X-Rspamd-Queue-Id: 0736B64E73
X-Rspamd-Action: no action

This commit introduces error counting functionality for AEST records.
Previously, error statistics were not directly available for individual
error records or AEST nodes.

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 Documentation/ABI/testing/debugfs-aest | 14 ++++++
 drivers/ras/aest/aest-core.c           | 21 +++++++++
 drivers/ras/aest/aest-sysfs.c          | 64 ++++++++++++++++++++++++++
 drivers/ras/aest/aest.h                | 10 ++++
 4 files changed, 109 insertions(+)

diff --git a/Documentation/ABI/testing/debugfs-aest b/Documentation/ABI/testing/debugfs-aest
index 8bacc6bb20b6..295df9e9b455 100644
--- a/Documentation/ABI/testing/debugfs-aest
+++ b/Documentation/ABI/testing/debugfs-aest
@@ -24,9 +24,23 @@ Description:
 		See more at:
 			https://developer.arm.com/documentation/den0085/latest/
 
+What:		/sys/kernel/debug/aest/<name>.<id>/<node_name>/err_count
+Date:		Dec 2025
+KernelVersion	6.19
+Contact:	Ruidong Tian <tianruidong@linux.alibaba.com>
+Description:
+		(RO) Outputs error statistics for all error records of this node.
+
 What:		/sys/kernel/debug/aest/<name>.<id>/<node_name>/record<index>/err_*
 Date:		Dec 2025
 KernelVersion:	6.19
 Contact:	Ruidong Tian <tianruidong@linux.alibaba.com>
 Description:
 		(RO) Read err_* register and return val.
+
+What:		/sys/kernel/debug/aest/<name>.<id>/<node_name>/record<index>/err_count
+Date:		Dec 2025
+KernelVersion	6.19
+Contact:	Ruidong Tian <tianruidong@linux.alibaba.com>
+Description:
+		(RO) Outputs error statistics for all this records.
diff --git a/drivers/ras/aest/aest-core.c b/drivers/ras/aest/aest-core.c
index 3bcc635cf8e4..75cca98024ad 100644
--- a/drivers/ras/aest/aest-core.c
+++ b/drivers/ras/aest/aest-core.c
@@ -170,6 +170,27 @@ static int aest_node_gen_pool_add(struct aest_device *adev,
 	init_aest_event(event, record, regs);
 	llist_add(&event->llnode, &adev->event_list);
 
+	if (regs->err_status & ERR_STATUS_CE)
+		record->count.ce++;
+	if (regs->err_status & ERR_STATUS_DE)
+		record->count.de++;
+	if (regs->err_status & ERR_STATUS_UE) {
+		switch (regs->err_status & ERR_STATUS_UET) {
+		case ERR_STATUS_UET_UC:
+			record->count.uc++;
+			break;
+		case ERR_STATUS_UET_UEU:
+			record->count.ueu++;
+			break;
+		case ERR_STATUS_UET_UER:
+			record->count.uer++;
+			break;
+		case ERR_STATUS_UET_UEO:
+			record->count.ueo++;
+			break;
+		}
+	}
+
 	return 0;
 }
 
diff --git a/drivers/ras/aest/aest-sysfs.c b/drivers/ras/aest/aest-sysfs.c
index f3b5427ff4f0..b54e879506aa 100644
--- a/drivers/ras/aest/aest-sysfs.c
+++ b/drivers/ras/aest/aest-sysfs.c
@@ -7,6 +7,46 @@
 
 #include "aest.h"
 
+static void
+aest_error_count(struct aest_record *record, void *data)
+{
+	struct record_count *count = data;
+
+	count->ce += record->count.ce;
+	count->de += record->count.de;
+	count->uc += record->count.uc;
+	count->ueu += record->count.ueu;
+	count->uer += record->count.uer;
+	count->ueo += record->count.ueo;
+}
+
+/*******************************************************************************
+ *
+ * Debugfs for AEST node
+ *
+ ******************************************************************************/
+
+static int aest_node_err_count_show(struct seq_file *m, void *data)
+{
+	struct aest_node *node = m->private;
+	struct record_count count = { 0 };
+	int i;
+
+	for (i = 0; i < node->record_count; i++)
+		aest_error_count(&node->records[i], &count);
+
+	seq_printf(m, "CE: %llu\n"
+				"DE: %llu\n"
+				"UC: %llu\n"
+				"UEU: %llu\n"
+				"UEO: %llu\n"
+				"UER: %llu\n",
+				count.ce, count.de, count.uc, count.ueu,
+				count.uer, count.ueo);
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(aest_node_err_count);
+
 /*******************************************************************************
  *
  * Attribute for AEST record
@@ -37,6 +77,25 @@ DEFINE_AEST_DEBUGFS_ATTR(err_misc1, ERXMISC1);
 DEFINE_AEST_DEBUGFS_ATTR(err_misc2, ERXMISC2);
 DEFINE_AEST_DEBUGFS_ATTR(err_misc3, ERXMISC3);
 
+static int aest_record_err_count_show(struct seq_file *m, void *data)
+{
+	struct aest_record *record = m->private;
+	struct record_count count = { 0 };
+
+	aest_error_count(record, &count);
+
+	seq_printf(m, "CE: %llu\n"
+				"DE: %llu\n"
+				"UC: %llu\n"
+				"UEU: %llu\n"
+				"UEO: %llu\n"
+				"UER: %llu\n",
+				count.ce, count.de, count.uc, count.ueu,
+				count.uer, count.ueo);
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(aest_record_err_count);
+
 static void aest_record_init_debugfs(struct aest_record *record)
 {
 	debugfs_create_file("err_fr", 0600, record->debugfs, record,
@@ -55,6 +114,8 @@ static void aest_record_init_debugfs(struct aest_record *record)
 								&err_misc2_ops);
 	debugfs_create_file("err_misc3", 0600, record->debugfs, record,
 								&err_misc3_ops);
+	debugfs_create_file("err_count", 0400, record->debugfs, record,
+						&aest_record_err_count_fops);
 }
 
 static void
@@ -63,6 +124,9 @@ aest_node_init_debugfs(struct aest_node *node)
 	int i;
 	struct aest_record *record;
 
+	debugfs_create_file("err_count", 0400, node->debugfs, node,
+					&aest_node_err_count_fops);
+
 	for (i = 0; i < node->record_count; i++) {
 		record = &node->records[i];
 		if (!record->name)
diff --git a/drivers/ras/aest/aest.h b/drivers/ras/aest/aest.h
index ceb9e32bcee3..802430857dc4 100644
--- a/drivers/ras/aest/aest.h
+++ b/drivers/ras/aest/aest.h
@@ -116,6 +116,15 @@ struct ce_threshold {
 	u64 reg_val;
 };
 
+struct record_count {
+	u64 ce;
+	u64 de;
+	u64 uc;
+	u64 uer;
+	u64 ueo;
+	u64 ueu;
+};
+
 struct aest_record {
 	char *name;
 	int index;
@@ -136,6 +145,7 @@ struct aest_record {
 
 	struct ce_threshold ce;
 	enum ras_ce_threshold threshold_type;
+	struct record_count count;
 	struct dentry *debugfs;
 };
 
-- 
2.51.2.612.gdc70283dfc


