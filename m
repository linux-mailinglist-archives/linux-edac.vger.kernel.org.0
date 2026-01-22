Return-Path: <linux-edac+bounces-5663-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IO/oAs7zcWmvZwAAu9opvQ
	(envelope-from <linux-edac+bounces-5663-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Thu, 22 Jan 2026 10:54:22 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A5F64D93
	for <lists+linux-edac@lfdr.de>; Thu, 22 Jan 2026 10:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D110806CDE
	for <lists+linux-edac@lfdr.de>; Thu, 22 Jan 2026 09:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746C33AEF34;
	Thu, 22 Jan 2026 09:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uPkOuCVf"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59634284B26;
	Thu, 22 Jan 2026 09:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769075271; cv=none; b=LhjmjSvl+aD/C6OY3LFKWw8uX97GqQnueGfgk4m2tzKyZCI2i0WN3u6q0WL0fnnXL4rm2YdthoT/qmfbLAPCr/hElZ4yRYPPJItZSD+/DeUs7Vgvjt8dvJOLT1pjVCGPYOxFOUkgzSb8pXPKHNmnmNCaTxVqkCzFc29i39kTQB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769075271; c=relaxed/simple;
	bh=JxvMWPoKGlB3uCfwmZ2W41dAQhQ/djGCES7s6qCtI0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dwps1o3qhomjvH0iVlZ+6tX1Q5RqPKWiXjHAB6IbPOGPOMi9l+HfWHQRL55GEq8j1o1nWY8ubHTE4C7e2pCi6z2xQI+l9O6QGR04wvahJjcHdvkPcEoY48WjLPvyudRcu6gb8EH3W+BvkEVpa4eBI/Vp5ZW3kPTkurgpcc7+T3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uPkOuCVf; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769075266; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=5Gb/0pO9ZhFEXcQF/4tc/EbwH+IhljJ6XBnX4XBc2RQ=;
	b=uPkOuCVf3oKcby6JYXfLYTNOHju14fdoHCUqQ6Z2rrbZWsANHBBpBm0R1eYUv9u5WlTYZSx7p3RRSBYLg0S7te/qBPk1wxMDsLKnxNl7bxqh1iXemOVCa9DR8r5UgrjKtmQR5L2YLRZ1GzWj9EaAA4z0J/duU8e9ybp8skKDNao=
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0Wxbuwk0_1769075261 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 22 Jan 2026 17:47:45 +0800
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
Subject: [PATCH v6 05/16] ras: AEST: Probe RAS system architecture version
Date: Thu, 22 Jan 2026 17:46:45 +0800
Message-Id: <20260122094656.73399-6-tianruidong@linux.alibaba.com>
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
	TAGGED_FROM(0.00)[bounces-5663-lists,linux-edac=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:mid,linux.alibaba.com:dkim,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,alibaba.com:email]
X-Rspamd-Queue-Id: B4A5F64D93
X-Rspamd-Action: no action

The RAS version of a component can be probed via its ERRDEVARCH register.

In cases where a component (e.g., SMMU) does not implement an ERRDEVARCH
register, the driver falls back to using the RAS version of the Processing
Element (PE).

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 arch/arm64/include/asm/ras.h |  3 +++
 drivers/ras/aest/aest-core.c | 22 ++++++++++++++++++++++
 drivers/ras/aest/aest.h      |  3 +++
 3 files changed, 28 insertions(+)

diff --git a/arch/arm64/include/asm/ras.h b/arch/arm64/include/asm/ras.h
index b6640b9972bf..da7c441252fe 100644
--- a/arch/arm64/include/asm/ras.h
+++ b/arch/arm64/include/asm/ras.h
@@ -4,6 +4,9 @@
 
 #include <linux/types.h>
 
+/* ERRDEVARCH */
+#define ERRDEVARCH_REV GENMASK(19, 16)
+
 struct ras_ext_regs {
 	u64 err_fr;
 	u64 err_ctlr;
diff --git a/drivers/ras/aest/aest-core.c b/drivers/ras/aest/aest-core.c
index f4a5119dc513..84b2fb8127ff 100644
--- a/drivers/ras/aest/aest-core.c
+++ b/drivers/ras/aest/aest-core.c
@@ -16,6 +16,27 @@ DEFINE_PER_CPU(struct aest_device, percpu_adev);
 #undef pr_fmt
 #define pr_fmt(fmt) "AEST: " fmt
 
+static int get_aest_node_ver(struct aest_node *node)
+{
+	u64 reg;
+	void *devarch_base;
+
+	if (node->type == ACPI_AEST_GIC_ERROR_NODE) {
+		devarch_base = ioremap(node->info->interface_hdr->address +
+					       GIC_ERRDEVARCH,
+				       PAGE_SIZE);
+		if (!devarch_base)
+			return 0;
+
+		reg = readl_relaxed(devarch_base);
+		iounmap(devarch_base);
+
+		return FIELD_GET(ERRDEVARCH_REV, reg);
+	}
+
+	return FIELD_GET(ID_AA64PFR0_EL1_RAS_MASK, read_cpuid(ID_AA64PFR0_EL1));
+}
+
 static int aest_init_record(struct aest_record *record, int i,
 			    struct aest_node *node)
 {
@@ -108,6 +129,7 @@ static int aest_init_node(struct aest_device *adev, struct aest_node *node,
 	node->adev = adev;
 	node->info = anode;
 	node->type = anode->type;
+	node->version = get_aest_node_ver(node);
 	node->name = alloc_aest_node_name(node);
 	if (!node->name)
 		return -ENOMEM;
diff --git a/drivers/ras/aest/aest.h b/drivers/ras/aest/aest.h
index 31131cce9928..bf0b9a49fdaa 100644
--- a/drivers/ras/aest/aest.h
+++ b/drivers/ras/aest/aest.h
@@ -61,6 +61,8 @@
 #define ERXMISC2 0x30
 #define ERXMISC3 0x38
 
+#define GIC_ERRDEVARCH 0xFFBC
+
 struct aest_access {
 	u64 (*read)(void *base, u32 offset);
 	void (*write)(void *base, u32 offset, u64 val);
@@ -141,6 +143,7 @@ struct aest_node {
 	 *              error events.
 	 */
 	unsigned long *status_reporting;
+	int version;
 
 	const struct aest_group *group;
 	struct aest_device *adev;
-- 
2.51.2.612.gdc70283dfc


