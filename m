Return-Path: <linux-edac+bounces-5666-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Bw3Ezz0cWn1ZwAAu9opvQ
	(envelope-from <linux-edac+bounces-5666-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Thu, 22 Jan 2026 10:56:12 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F2764DF9
	for <lists+linux-edac@lfdr.de>; Thu, 22 Jan 2026 10:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1054A801B38
	for <lists+linux-edac@lfdr.de>; Thu, 22 Jan 2026 09:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4D83D34AE;
	Thu, 22 Jan 2026 09:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="x8sinkhf"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E023A63F2;
	Thu, 22 Jan 2026 09:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769075292; cv=none; b=ttlpXNjt/1re37ia3BFPL+7BYHzOjTeKjO7Ad1eI+g++B7pRw2LpmBzcIsPvjCnKTkQvA73G2aABnueenVr5RDUsR43ToM9v3WYaZT33KUKRi4UrszUKrRcZ4cZpSCrGHFeWqiZrvLfeUWfkZbXCm+GnOh1GYXjj3UxkFvKeGgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769075292; c=relaxed/simple;
	bh=SO0/560UPK92U6WvkHVzv1MkeC2T9tDsd9Y4GT+sl+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dG7BpApSZXTbZXmasnRHWNGsA7Q4B0VYpqkXLmcMCcRR84Ky59rBOi9CT59Bn/flXuCGzzlmI+Rup+pEt3rIB5IR9j+9aCcNMIp8S/LrIX6ighK9oPn6fm6GM4IMCES6XhAnT7raFTjyehOep/U9UZafQ/219CNpL/dnMLWKQd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=x8sinkhf; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769075286; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=72cxXQagokwmA/cZnex2Pm94HvbMxhBEqjUGllZTVzo=;
	b=x8sinkhf4qQvEHf1s+jcnLYRI1yphtnnEAMYiUi5rms3KIXBrULWzHz69BrUdbVrbGqrHzVhRhu0r+bTbPDhAK/iq3l3kf9PZV+ZNyZg2h6XNS5ysSO/Ua431gHuu2uh4WP2GLJOBvY7n8x0MNgPfRvP7ePXij9csPhCiRt2yj4=
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0Wxby8oS_1769075283 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 22 Jan 2026 17:48:06 +0800
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
Subject: [PATCH v6 09/16] ras: AEST: Add cpuhp callback
Date: Thu, 22 Jan 2026 17:46:49 +0800
Message-Id: <20260122094656.73399-10-tianruidong@linux.alibaba.com>
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
	TAGGED_FROM(0.00)[bounces-5666-lists,linux-edac=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,linux.alibaba.com:mid,linux.alibaba.com:dkim,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 01F2764DF9
X-Rspamd-Action: no action

Move the configuration of interrupts and CE thresholds
into the CPU hotplug callbacks for the per-CPU AEST node.

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 drivers/ras/aest/aest-core.c | 118 ++++++++++++++++++++++++++++++++++-
 drivers/ras/aest/aest.h      |   5 ++
 include/linux/cpuhotplug.h   |   1 +
 3 files changed, 121 insertions(+), 3 deletions(-)

diff --git a/drivers/ras/aest/aest-core.c b/drivers/ras/aest/aest-core.c
index 5ec0ba38f51b..686dde6f2e68 100644
--- a/drivers/ras/aest/aest-core.c
+++ b/drivers/ras/aest/aest-core.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2025, Alibaba Group.
  */
 
+#include <linux/cpu.h>
 #include <linux/interrupt.h>
 #include <linux/panic.h>
 #include <linux/platform_device.h>
@@ -563,8 +564,6 @@ static int aest_init_record(struct aest_record *record, int i,
 	record->addressing_mode = test_bit(i, node->info->addressing_mode);
 	record->index = i;
 	record->node = node;
-	aest_set_ce_threshold(record);
-	aest_enable_irq(record);
 
 	aest_record_dbg(record, "base: %p, index: %d, address mode: %x\n",
 			record->regs_base, record->index,
@@ -572,9 +571,113 @@ static int aest_init_record(struct aest_record *record, int i,
 	return 0;
 }
 
+static void aest_online_record(struct aest_record *record, void *data)
+{
+	if (record_read(record, ERXFR) & ERR_FR_CE)
+		aest_set_ce_threshold(record);
+
+	aest_enable_irq(record);
+}
+
+static void aest_online_oncore_node(struct aest_node *node)
+{
+	int count;
+
+	count = aest_proc(node);
+	aest_node_dbg(node, "Find %d error on CPU%d before AEST probe\n", count,
+		      smp_processor_id());
+
+	aest_node_foreach_record(aest_online_record, node, NULL,
+				 node->record_implemented);
+
+	aest_node_foreach_record(aest_online_record, node, NULL,
+				 node->status_reporting);
+}
+
+static void aest_online_oncore_dev(void *data)
+{
+	int fhi_irq, eri_irq, i;
+	struct aest_device *adev = this_cpu_ptr(data);
+
+	for (i = 0; i < adev->node_cnt; i++)
+		aest_online_oncore_node(&adev->nodes[i]);
+
+	fhi_irq = adev->irq[ACPI_AEST_NODE_FAULT_HANDLING];
+	if (fhi_irq > 0)
+		enable_percpu_irq(fhi_irq, IRQ_TYPE_NONE);
+	eri_irq = adev->irq[ACPI_AEST_NODE_ERROR_RECOVERY];
+	if (eri_irq > 0)
+		enable_percpu_irq(eri_irq, IRQ_TYPE_NONE);
+}
+
+static void aest_offline_oncore_dev(void *data)
+{
+	int fhi_irq, eri_irq;
+	struct aest_device *adev = this_cpu_ptr(data);
+
+	fhi_irq = adev->irq[ACPI_AEST_NODE_FAULT_HANDLING];
+	if (fhi_irq > 0)
+		disable_percpu_irq(fhi_irq);
+	eri_irq = adev->irq[ACPI_AEST_NODE_ERROR_RECOVERY];
+	if (eri_irq > 0)
+		disable_percpu_irq(eri_irq);
+}
+
+static void aest_online_dev(struct aest_device *adev)
+{
+	int count, i;
+	struct aest_node *node;
+
+	for (i = 0; i < adev->node_cnt; i++) {
+		node = &adev->nodes[i];
+
+		if (!node->name)
+			continue;
+
+		count = aest_proc(node);
+		aest_node_dbg(node, "Find %d error before AEST probe\n", count);
+
+		aest_config_irq(node);
+
+		aest_node_foreach_record(aest_online_record, node, NULL,
+					 node->record_implemented);
+		aest_node_foreach_record(aest_online_record, node, NULL,
+					 node->status_reporting);
+	}
+}
+
+static int aest_starting_cpu(unsigned int cpu)
+{
+	pr_debug("CPU%d starting\n", cpu);
+	aest_online_oncore_dev(&percpu_adev);
+
+	return 0;
+}
+
+static int aest_dying_cpu(unsigned int cpu)
+{
+	pr_debug("CPU%d dying\n", cpu);
+	aest_offline_oncore_dev(&percpu_adev);
+
+	return 0;
+}
+
 static void aest_device_remove(struct platform_device *pdev)
 {
+	struct aest_device *adev = platform_get_drvdata(pdev);
+	int i;
+
 	platform_set_drvdata(pdev, NULL);
+
+	if (adev->type != ACPI_AEST_PROCESSOR_ERROR_NODE)
+		return;
+
+	on_each_cpu(aest_offline_oncore_dev, adev->adev_oncore, 1);
+
+	for (i = 0; i < MAX_GSI_PER_NODE; i++) {
+		if (adev->irq[i])
+			free_percpu_irq(adev->irq[i], adev->adev_oncore);
+	}
 }
 
 static char *alloc_aest_node_name(struct aest_node *node)
@@ -682,7 +785,6 @@ static int aest_init_node(struct aest_device *adev, struct aest_node *node,
 				return -ENOMEM;
 		}
 	}
-	aest_config_irq(node);
 
 	ret = aest_node_set_errgsr(adev, node);
 	if (ret)
@@ -826,6 +928,16 @@ static int aest_device_probe(struct platform_device *pdev)
 		aest_dev_err(adev, "register irq failed\n");
 		return ret;
 	}
+
+	if (aest_dev_is_oncore(adev))
+		ret = cpuhp_setup_state(CPUHP_AP_ARM_AEST_STARTING,
+					"drivers/acpi/arm64/aest:starting",
+					aest_starting_cpu, aest_dying_cpu);
+	else
+		aest_online_dev(adev);
+	if (ret)
+		return ret;
+
 	platform_set_drvdata(pdev, adev);
 
 	aest_dev_dbg(adev, "Node cnt: %x, id: %x\n", adev->node_cnt, adev->id);
diff --git a/drivers/ras/aest/aest.h b/drivers/ras/aest/aest.h
index a5e43b2a2e90..f85e81ff35a6 100644
--- a/drivers/ras/aest/aest.h
+++ b/drivers/ras/aest/aest.h
@@ -339,3 +339,8 @@ static inline void aest_sync(struct aest_node *node)
 	if (node->type == ACPI_AEST_PROCESSOR_ERROR_NODE)
 		isb();
 }
+
+static inline bool aest_dev_is_oncore(struct aest_device *adev)
+{
+	return adev->type == ACPI_AEST_PROCESSOR_ERROR_NODE;
+}
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 62cd7b35a29c..831fe9011943 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -179,6 +179,7 @@ enum cpuhp_state {
 	CPUHP_AP_HYPERV_TIMER_STARTING,
 	/* Must be the last timer callback */
 	CPUHP_AP_DUMMY_TIMER_STARTING,
+	CPUHP_AP_ARM_AEST_STARTING,
 	CPUHP_AP_ARM_XEN_STARTING,
 	CPUHP_AP_ARM_XEN_RUNSTATE_STARTING,
 	CPUHP_AP_ARM_CORESIGHT_STARTING,
-- 
2.51.2.612.gdc70283dfc


