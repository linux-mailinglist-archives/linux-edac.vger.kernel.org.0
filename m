Return-Path: <linux-edac+bounces-5662-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJZJAkP0cWn1ZwAAu9opvQ
	(envelope-from <linux-edac+bounces-5662-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Thu, 22 Jan 2026 10:56:19 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF8864E01
	for <lists+linux-edac@lfdr.de>; Thu, 22 Jan 2026 10:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C28A662531B
	for <lists+linux-edac@lfdr.de>; Thu, 22 Jan 2026 09:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB075387341;
	Thu, 22 Jan 2026 09:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mm9l/U4F"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6908D3502B7;
	Thu, 22 Jan 2026 09:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769075269; cv=none; b=LSRwW/QSElIyBXanDHVQinhvaj8TmxsgZbrcaZ9h8FXMCJ0FwNsD5gt0Gaxzq+13Gm4rPvGYls4pAbp3PLMVSl5gDDT+xoVYJT4EpKiXDqMBJAX1F/lXuhKQDVm5xlIpvqXkhaPs+dzTdDh8rARwyASDkE2veHy3ZoaEYs0Mj0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769075269; c=relaxed/simple;
	bh=ITIj0lBVMPLmiOa+cB6SF5mDxSiBQpFd7QgPmvkO2GI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A19yZHSIJg8n6dMSxO3/u3v+TbZeiCF/XBPk071IcATHaJzVdDxBvaPJQwQJdIvsOvn9Yab/omVq2uakgeKaBi6KJIb3tviaYuqu/EpU6M4Z8HY79h0TJTDnhv8UoV7oOiuLLVj01RVXMRFs5W3+xjBT0DgHyvXTb+/Zv5unSOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mm9l/U4F; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769075258; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=jREerp1UUtlvwq6DucOPbqJRI1tz6hZrq/qDog8bRt8=;
	b=mm9l/U4FmBbFJx0kk7mrL8moSLI6tqw6D02C+dLx3TfLgBcDR/lMrIoM7aBlbfDr53Fd8mtlbyWIIJXw6fN82Y4sgqfwr+elcMXsr8AZapkG8X6yxMVfD0KekKGakPSy7BYuZTmfEiMDw2XVIR+PW2XliMF6ZeaQohhZPfGpM1E=
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0WxbuwhN_1769075254 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 22 Jan 2026 17:47:37 +0800
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
Subject: [PATCH v6 04/16] ras: AEST: Unify the read/write interface for system and MMIO register
Date: Thu, 22 Jan 2026 17:46:44 +0800
Message-Id: <20260122094656.73399-5-tianruidong@linux.alibaba.com>
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
	TAGGED_FROM(0.00)[bounces-5662-lists,linux-edac=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,linux.alibaba.com:mid,linux.alibaba.com:dkim,alibaba.com:email]
X-Rspamd-Queue-Id: BAF8864E01
X-Rspamd-Action: no action

Use record_read/write to simultaneously read and write system registers and
MMIO registers while maintaining code conciseness.

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 drivers/ras/aest/aest-core.c |  1 +
 drivers/ras/aest/aest.h      | 94 ++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+)

diff --git a/drivers/ras/aest/aest-core.c b/drivers/ras/aest/aest-core.c
index acebb293ac75..f4a5119dc513 100644
--- a/drivers/ras/aest/aest-core.c
+++ b/drivers/ras/aest/aest-core.c
@@ -29,6 +29,7 @@ static int aest_init_record(struct aest_record *record, int i,
 		record->regs_base =
 			node->base + sizeof(struct ras_ext_regs) * i;
 
+	record->access = &aest_access[node->info->interface_hdr->type];
 	record->addressing_mode = test_bit(i, node->info->addressing_mode);
 	record->index = i;
 	record->node = node;
diff --git a/drivers/ras/aest/aest.h b/drivers/ras/aest/aest.h
index 3250675e99b7..31131cce9928 100644
--- a/drivers/ras/aest/aest.h
+++ b/drivers/ras/aest/aest.h
@@ -10,6 +10,11 @@
 
 #define MAX_GSI_PER_NODE 2
 
+#define record_read(record, offset) \
+	record->access->read(record->regs_base, offset)
+#define record_write(record, offset, val) \
+	record->access->write(record->regs_base, offset, val)
+
 #define aest_dev_err(__adev, format, ...) \
 	dev_err((__adev)->dev, format, ##__VA_ARGS__)
 #define aest_dev_info(__adev, format, ...) \
@@ -47,6 +52,20 @@
 #define ERXGROUP_16K_ERRGSR_NUM 4
 #define ERXGROUP_64K_ERRGSR_NUM 14
 
+#define ERXFR 0x0
+#define ERXCTLR 0x8
+#define ERXSTATUS 0x10
+#define ERXADDR 0x18
+#define ERXMISC0 0x20
+#define ERXMISC1 0x28
+#define ERXMISC2 0x30
+#define ERXMISC3 0x38
+
+struct aest_access {
+	u64 (*read)(void *base, u32 offset);
+	void (*write)(void *base, u32 offset, u64 val);
+};
+
 struct aest_record {
 	char *name;
 	int index;
@@ -63,6 +82,7 @@ struct aest_record {
 	 */
 	int addressing_mode;
 	struct aest_node *node;
+	const struct aest_access *access;
 };
 
 struct aest_group {
@@ -159,3 +179,77 @@ static inline int aest_set_name(struct aest_device *adev,
 
 	return 0;
 }
+
+#define CASE_READ(res, x)                           \
+	case (x): {                                 \
+		res = read_sysreg_s(SYS_##x##_EL1); \
+		break;                              \
+	}
+
+#define CASE_WRITE(val, x)                            \
+	case (x): {                                   \
+		write_sysreg_s((val), SYS_##x##_EL1); \
+		break;                                \
+	}
+
+static inline u64 aest_sysreg_read(void *__unused, u32 offset)
+{
+	u64 res;
+
+	switch (offset) {
+		CASE_READ(res, ERXFR)
+		CASE_READ(res, ERXCTLR)
+		CASE_READ(res, ERXSTATUS)
+		CASE_READ(res, ERXADDR)
+		CASE_READ(res, ERXMISC0)
+		CASE_READ(res, ERXMISC1)
+		CASE_READ(res, ERXMISC2)
+		CASE_READ(res, ERXMISC3)
+	default :
+		res = 0;
+	}
+	return res;
+}
+
+static inline void aest_sysreg_write(void *base, u32 offset, u64 val)
+{
+	switch (offset) {
+		CASE_WRITE(val, ERXFR)
+		CASE_WRITE(val, ERXCTLR)
+		CASE_WRITE(val, ERXSTATUS)
+		CASE_WRITE(val, ERXADDR)
+		CASE_WRITE(val, ERXMISC0)
+		CASE_WRITE(val, ERXMISC1)
+		CASE_WRITE(val, ERXMISC2)
+		CASE_WRITE(val, ERXMISC3)
+	default :
+		return;
+	}
+}
+
+static inline u64 aest_iomem_read(void *base, u32 offset)
+{
+	return readq_relaxed(base + offset);
+}
+
+static inline void aest_iomem_write(void *base, u32 offset, u64 val)
+{
+	writeq_relaxed(val, base + offset);
+}
+
+/* access type is decided by AEST interface type. */
+static const struct aest_access aest_access[] = {
+	[ACPI_AEST_NODE_SYSTEM_REGISTER] = {
+		.read = aest_sysreg_read,
+		.write = aest_sysreg_write,
+	},
+	[ACPI_AEST_NODE_MEMORY_MAPPED] = {
+		.read = aest_iomem_read,
+		.write = aest_iomem_write,
+	},
+	[ACPI_AEST_NODE_SINGLE_RECORD_MEMORY_MAPPED] = {
+		.read = aest_iomem_read,
+		.write = aest_iomem_write,
+	},
+	{ }
+};
-- 
2.51.2.612.gdc70283dfc


