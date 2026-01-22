Return-Path: <linux-edac+bounces-5664-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLGXO/TzcWmvZwAAu9opvQ
	(envelope-from <linux-edac+bounces-5664-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Thu, 22 Jan 2026 10:55:01 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A45264DA8
	for <lists+linux-edac@lfdr.de>; Thu, 22 Jan 2026 10:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 70EC44E61F2
	for <lists+linux-edac@lfdr.de>; Thu, 22 Jan 2026 09:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FF0392B7C;
	Thu, 22 Jan 2026 09:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vsxdMiNk"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396AA284B26;
	Thu, 22 Jan 2026 09:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769075282; cv=none; b=rEt2jhcQXzWdlPyK38KrySTkXRkELuvSWTk8m3ERNXH2srb7lt3f/8AlTFqCcsBhPGw6JFXj4IdbqGauHwVGSxEWlcqSNOR2hT5MGXEk2Ybd5BsNKLO8gBq9jGnioVgnBvBPP0ExVxSJqBzegJbcz8etZPcgu1g81HSvupaYOGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769075282; c=relaxed/simple;
	bh=DnMBcfwUjtt1RUKLWGSecejfX5UC0YZOIdosE1gy7YA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iHeBEA5H6mAJ6oXfV6oXkB1ZhHH01I7EnXBcef5ttFH9D9W1FMZy4bRn3ZzxHW7vT11ZtE8AnaVnhkPnjbDuzDjHE7NSowGDI67FwIZYcNguJlwSEOvmql8b9Jy20tVKecjckvySNJpDOC+M0Pxtq8ya21bBiPBBN5RFCohJtY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vsxdMiNk; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769075270; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=a2pQ+C4SUP4Ig2ZogJ3bhHxA66J4i8YOEkIhS0I/+MI=;
	b=vsxdMiNkkcmF4L+WED2QQEWcAiaRgyP+yH5Zg++FPmSdR7NaxVEt4fIp+f8jTJJ1cXcsRrzftyuZ4JROViqrb4VatV99O/Yzaw29S4IksBWewOM0bMXeaqENpxs61KpG91vIXiD7R3SQ18RxEdQb+aiXJatnjUHtS0KjhLA99TA=
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0WxbtZj3_1769075266 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 22 Jan 2026 17:47:50 +0800
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
Subject: [PATCH v6 06/16] ras: AEST: Support RAS Common Fault Injection Model Extension
Date: Thu, 22 Jan 2026 17:46:46 +0800
Message-Id: <20260122094656.73399-7-tianruidong@linux.alibaba.com>
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
	TAGGED_FROM(0.00)[bounces-5664-lists,linux-edac=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,linux.alibaba.com:mid,linux.alibaba.com:dkim,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 6A45264DA8
X-Rspamd-Action: no action

Add inject register descripted in Common Fault Injection Model
Extension.

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 drivers/ras/aest/aest-core.c | 15 ++++++++++++++-
 drivers/ras/aest/aest.h      | 10 ++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/ras/aest/aest-core.c b/drivers/ras/aest/aest-core.c
index 84b2fb8127ff..1218ae51079c 100644
--- a/drivers/ras/aest/aest-core.c
+++ b/drivers/ras/aest/aest-core.c
@@ -124,7 +124,7 @@ static int aest_init_node(struct aest_device *adev, struct aest_node *node,
 			  struct acpi_aest_node *anode)
 {
 	int i, ret;
-	u64 address;
+	u64 address, flags;
 
 	node->adev = adev;
 	node->info = anode;
@@ -145,6 +145,19 @@ static int aest_init_node(struct aest_device *adev, struct aest_node *node,
 			return -ENOMEM;
 	}
 
+	flags = anode->interface_hdr->flags;
+	address = node->info->common->fault_inject_register_base;
+	if ((flags & AEST_XFACE_FLAG_FAULT_INJECT) && address) {
+		if (address - anode->interface_hdr->address < node->group->size)
+			node->inj = node->base +
+				    (address - anode->interface_hdr->address);
+		else {
+			node->inj = devm_ioremap(adev->dev, address, PAGE_SIZE);
+			if (!node->inj)
+				return -ENOMEM;
+		}
+	}
+
 	ret = aest_node_set_errgsr(adev, node);
 	if (ret)
 		return ret;
diff --git a/drivers/ras/aest/aest.h b/drivers/ras/aest/aest.h
index bf0b9a49fdaa..505ecd9635bc 100644
--- a/drivers/ras/aest/aest.h
+++ b/drivers/ras/aest/aest.h
@@ -60,6 +60,9 @@
 #define ERXMISC1 0x28
 #define ERXMISC2 0x30
 #define ERXMISC3 0x38
+#define ERXPFGF 0x800
+#define ERXPFGCTL 0x808
+#define ERXPFGCDN 0x810
 
 #define GIC_ERRDEVARCH 0xFFBC
 
@@ -120,6 +123,7 @@ struct aest_node {
 	u8 type;
 	void *errgsr;
 	void *base;
+	void *inj;
 
 	/*
 	 * This bitmap indicates which of the error records within this error
@@ -208,6 +212,9 @@ static inline u64 aest_sysreg_read(void *__unused, u32 offset)
 		CASE_READ(res, ERXMISC1)
 		CASE_READ(res, ERXMISC2)
 		CASE_READ(res, ERXMISC3)
+		CASE_READ(res, ERXPFGF)
+		CASE_READ(res, ERXPFGCTL)
+		CASE_READ(res, ERXPFGCDN)
 	default :
 		res = 0;
 	}
@@ -225,6 +232,9 @@ static inline void aest_sysreg_write(void *base, u32 offset, u64 val)
 		CASE_WRITE(val, ERXMISC1)
 		CASE_WRITE(val, ERXMISC2)
 		CASE_WRITE(val, ERXMISC3)
+		CASE_WRITE(val, ERXPFGF)
+		CASE_WRITE(val, ERXPFGCTL)
+		CASE_WRITE(val, ERXPFGCDN)
 	default :
 		return;
 	}
-- 
2.51.2.612.gdc70283dfc


