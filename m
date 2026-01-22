Return-Path: <linux-edac+bounces-5669-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHKNCs70cWmvZwAAu9opvQ
	(envelope-from <linux-edac+bounces-5669-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Thu, 22 Jan 2026 10:58:38 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F1E64E89
	for <lists+linux-edac@lfdr.de>; Thu, 22 Jan 2026 10:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1058D540554
	for <lists+linux-edac@lfdr.de>; Thu, 22 Jan 2026 09:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442A840B6F1;
	Thu, 22 Jan 2026 09:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ds1CjAwL"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC87248893;
	Thu, 22 Jan 2026 09:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769075309; cv=none; b=lC38mHpfcR2q714lTpep/GuCLS/km3IRNN63BhdtVJ6wqhUxPOi1NVSZ660Qre/NjjOgRukMfHtfri2xYTHDNevFYwnmGCgZNMS2KbA0WD4R54NvIEGBwcc1gLIGNiJzrYlg1n04CLcO0rsMeMF5bz2gbDHUNstjVOQdMFbt4PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769075309; c=relaxed/simple;
	bh=OcMkeCd22CSWYSMxhfO6fjwVqZwQfci/NlAG1TXYMI4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XNMoPzXsdUddUngn8A4klykmMzer2lcHW4C0zj/65kLAGj4ub8YHXS2nNd9uvQvKn7lIymcAlnwquvu1c+ZkIxj3y8V59NcRKUPPqDHhIuXKmgIFowvYOgAQt7pZ+wPXJDPZeSiRaaQrm4tVXU/WEgg0BnAzyiqyvFSXzAWigVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ds1CjAwL; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769075304; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=FceONJwVjg8vdGz5WZuq5fGe+EXqsU2TZx7AP6HAvqc=;
	b=ds1CjAwLfavFRMRzMTflAik37IA2LcvAGz65rfDUXdgkDFVEo3D07iSDgfrBk+kihygjWeTqV7lDk++f8kB5uK29yXxVhsvi3u0zWfc08yQfQLUut+SUMn5dWBrBHAtrG95BQ2HtfWSdYpvVWdthKNw+cqhLJSYVybiV0x8U+mQ=
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0Wxbwgq9_1769075300 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 22 Jan 2026 17:48:23 +0800
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
Subject: [PATCH v6 12/16] ras: AEST: Allow configuring CE threshold via debugfs
Date: Thu, 22 Jan 2026 17:46:52 +0800
Message-Id: <20260122094656.73399-13-tianruidong@linux.alibaba.com>
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
	TAGGED_FROM(0.00)[bounces-5669-lists,linux-edac=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,linux.alibaba.com:mid,linux.alibaba.com:dkim,arm.com:url,alibaba.com:email]
X-Rspamd-Queue-Id: 94F1E64E89
X-Rspamd-Action: no action

This commit introduces the ability to configure the Corrected Error (CE)
threshold for AEST records through debugfs. This allows administrators to
dynamically adjust the CE threshold for error reporting.

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 Documentation/ABI/testing/debugfs-aest | 16 ++++++++++
 drivers/ras/aest/aest-sysfs.c          | 42 ++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/Documentation/ABI/testing/debugfs-aest b/Documentation/ABI/testing/debugfs-aest
index 295df9e9b455..4d160072d37a 100644
--- a/Documentation/ABI/testing/debugfs-aest
+++ b/Documentation/ABI/testing/debugfs-aest
@@ -24,6 +24,14 @@ Description:
 		See more at:
 			https://developer.arm.com/documentation/den0085/latest/
 
+What:		/sys/kernel/debug/aest/<name>.<id>/<node_name>/ce_threshold
+Date:		Dec 2025
+KernelVersion	6.19
+Contact:	Ruidong Tian <tianruidong@linux.alibaba.com>
+Description:
+		(WO) Write the ce threshold to all records of this node. Failed
+		if input exceeded the maximum threshold
+
 What:		/sys/kernel/debug/aest/<name>.<id>/<node_name>/err_count
 Date:		Dec 2025
 KernelVersion	6.19
@@ -38,6 +46,14 @@ Contact:	Ruidong Tian <tianruidong@linux.alibaba.com>
 Description:
 		(RO) Read err_* register and return val.
 
+What:		/sys/kernel/debug/aest/<name>.<id>/<node_name>/record<index>/ce_threshold
+Date:		Dec 2025
+KernelVersion	6.19
+Contact:	Ruidong Tian <tianruidong@linux.alibaba.com>
+Description:
+		(RW) Read and write the ce threshold to this record. Failed
+		if input exceeded the maximum threshold
+
 What:		/sys/kernel/debug/aest/<name>.<id>/<node_name>/record<index>/err_count
 Date:		Dec 2025
 KernelVersion	6.19
diff --git a/drivers/ras/aest/aest-sysfs.c b/drivers/ras/aest/aest-sysfs.c
index b54e879506aa..392e7ad8328e 100644
--- a/drivers/ras/aest/aest-sysfs.c
+++ b/drivers/ras/aest/aest-sysfs.c
@@ -7,6 +7,25 @@
 
 #include "aest.h"
 
+static void
+aest_store_threshold(struct aest_record *record, void *data)
+{
+	u64 err_misc0, *threshold = data;
+	struct ce_threshold *ce = &record->ce;
+
+	if (*threshold > ce->info->max_count)
+		return;
+
+	ce->threshold = *threshold;
+	ce->count = ce->info->max_count - ce->threshold + 1;
+
+	err_misc0 = record_read(record, ERXMISC0);
+	ce->reg_val = (err_misc0 & ~ce->info->mask) |
+			(ce->count << ce->info->shift);
+
+	record_write(record, ERXMISC0, ce->reg_val);
+}
+
 static void
 aest_error_count(struct aest_record *record, void *data)
 {
@@ -77,6 +96,27 @@ DEFINE_AEST_DEBUGFS_ATTR(err_misc1, ERXMISC1);
 DEFINE_AEST_DEBUGFS_ATTR(err_misc2, ERXMISC2);
 DEFINE_AEST_DEBUGFS_ATTR(err_misc3, ERXMISC3);
 
+static int record_ce_threshold_get(void *data, u64 *val)
+{
+	struct aest_record *record = data;
+
+	*val = record->ce.threshold;
+	return 0;
+}
+
+static int record_ce_threshold_set(void *data, u64 val)
+{
+	u64 threshold = val;
+	struct aest_record *record = data;
+
+	aest_store_threshold(record, &threshold);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(record_ce_threshold_ops, record_ce_threshold_get,
+					record_ce_threshold_set, "%llu\n");
+
 static int aest_record_err_count_show(struct seq_file *m, void *data)
 {
 	struct aest_record *record = m->private;
@@ -116,6 +156,8 @@ static void aest_record_init_debugfs(struct aest_record *record)
 								&err_misc3_ops);
 	debugfs_create_file("err_count", 0400, record->debugfs, record,
 						&aest_record_err_count_fops);
+	debugfs_create_file("ce_threshold", 0600, record->debugfs, record,
+						&record_ce_threshold_ops);
 }
 
 static void
-- 
2.51.2.612.gdc70283dfc


