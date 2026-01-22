Return-Path: <linux-edac+bounces-5672-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIxeKCL1cWmvZwAAu9opvQ
	(envelope-from <linux-edac+bounces-5672-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Thu, 22 Jan 2026 11:00:02 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A0D64ED3
	for <lists+linux-edac@lfdr.de>; Thu, 22 Jan 2026 11:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AB8066224AC
	for <lists+linux-edac@lfdr.de>; Thu, 22 Jan 2026 09:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF194219F1;
	Thu, 22 Jan 2026 09:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cT2QkuJO"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC65D407584;
	Thu, 22 Jan 2026 09:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769075322; cv=none; b=L+2Dj0y+KL4LWAovjIEgwBBob3sPHc6fcpGZyRmEF5zsD0e6Wb7GYL8XQlBCrB6xISttD3bI1oI9LDji+BAptvIWi9CKyX96L0IAAr8WCNo7L1oxibTPx4YFI861TP5ssw2PLmqqhac404wd9jvElhJhCdqQeNqMCZ8ap0DGkgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769075322; c=relaxed/simple;
	bh=eOTfY/F4l+lDhYJPmR/Zix002JRT64JHoENB5jyZ/mg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KPU/6Qqe/Op8th5aoIgy7ooJHFjdwECR+yJY/y4fBPRzPaVtfYgLXhBuPiR00eMPCEYNn1OCFaQjrvownvozBGekn80G2Khc8UwaNSuMIRYgv7zfDTbIrEAWuuaeOpmg5bLrYDBXUtJArspL1HRvWuyf6hoMMmtv7BiJu0VXWFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cT2QkuJO; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769075316; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=hFFZQX82Bmm9r98yVs8p4sid8uUuSTJLq1HybImupxc=;
	b=cT2QkuJOv1QYZzOxV30quQqkni6dkLqwNg84idWisJaRUmPlHFNhubtfthvV+WCgol2Jwub1lxubZdu8DbVV6HIBxUbNId9AKqJbpb1JZOUnH1pivS99+zfqApjjjcmcLOPpnvLwEO9tolgeNCTJoAb0ObWzVNRPonzgCrQ26+w=
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0Wxbx2rp_1769075312 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 22 Jan 2026 17:48:36 +0800
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
Subject: [PATCH v6 14/16] ras: AEST: Add framework to process AEST vendor node
Date: Thu, 22 Jan 2026 17:46:54 +0800
Message-Id: <20260122094656.73399-15-tianruidong@linux.alibaba.com>
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
	TAGGED_FROM(0.00)[bounces-5672-lists,linux-edac=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linux.alibaba.com,none];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-edac];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[tianruidong@linux.alibaba.com,linux-edac@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,linux.alibaba.com:mid,linux.alibaba.com:dkim,arm.com:url,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 23A0D64ED3
X-Rspamd-Action: no action

AEST table include vendor error node to support the component that do
not implement standard Arm RAS architecture[1]. Each vendor node may
have their own initialize and interrupt handle function. This patch
supply a framework to process vendor error nodes, the vendor process
function is binded with vendor HID.

[1]: https://developer.arm.com/documentation/ddi0587/latest/

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 drivers/ras/aest/aest-core.c | 28 +++++++++++++++++++++++++++-
 drivers/ras/aest/aest.h      |  5 +++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/ras/aest/aest-core.c b/drivers/ras/aest/aest-core.c
index a290b482bf8b..047c9a8cffe4 100644
--- a/drivers/ras/aest/aest-core.c
+++ b/drivers/ras/aest/aest-core.c
@@ -922,6 +922,29 @@ static int aest_setup_irq(struct platform_device *pdev,
 	return 0;
 }
 
+static struct aest_vendor_match vendor_match[] = {
+	{  },
+};
+
+static int
+aest_vendor_probe(struct aest_device *adev, struct aest_hnode *ahnode)
+{
+	int i;
+	struct acpi_aest_node *anode;
+
+	anode = list_first_entry(&ahnode->list, struct acpi_aest_node, list);
+	if (!anode)
+		return -ENODEV;
+
+	aest_dev_dbg(adev, "Try to probe vendor node %s\n", anode->vendor->acpi_hid);
+	for (i = 0; i < ARRAY_SIZE(vendor_match); i++) {
+		if (!strncmp(vendor_match[i].hid, anode->vendor->acpi_hid, 8))
+			return vendor_match[i].probe(adev, ahnode);
+	}
+
+	return -ENODEV;
+}
+
 static int aest_device_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -947,7 +970,10 @@ static int aest_device_probe(struct platform_device *pdev)
 	}
 	init_llist_head(&adev->event_list);
 
-	ret = aest_init_nodes(adev, ahnode);
+	if (ahnode->type == ACPI_AEST_VENDOR_ERROR_NODE)
+		ret = aest_vendor_probe(adev, ahnode);
+	else
+		ret = aest_init_nodes(adev, ahnode);
 	if (ret)
 		return ret;
 
diff --git a/drivers/ras/aest/aest.h b/drivers/ras/aest/aest.h
index 2f6a7b9ca4ef..304c03839d31 100644
--- a/drivers/ras/aest/aest.h
+++ b/drivers/ras/aest/aest.h
@@ -244,6 +244,11 @@ static const char *const aest_node_name[] = {
 	[ACPI_AEST_PROXY_ERROR_NODE] = "proxy",
 };
 
+struct aest_vendor_match {
+	char hid[ACPI_ID_LEN];
+	int (*probe)(struct aest_device *adev, struct aest_hnode *anode);
+};
+
 static inline int aest_set_name(struct aest_device *adev,
 				struct aest_hnode *ahnode)
 {
-- 
2.51.2.612.gdc70283dfc


