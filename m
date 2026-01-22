Return-Path: <linux-edac+bounces-5673-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGhKOh71cWmvZwAAu9opvQ
	(envelope-from <linux-edac+bounces-5673-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Thu, 22 Jan 2026 10:59:58 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6314C64ECB
	for <lists+linux-edac@lfdr.de>; Thu, 22 Jan 2026 10:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CBA7B62AC54
	for <lists+linux-edac@lfdr.de>; Thu, 22 Jan 2026 09:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFAD421F07;
	Thu, 22 Jan 2026 09:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MWbJxGtB"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241353A9620;
	Thu, 22 Jan 2026 09:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769075332; cv=none; b=CG1y/eFf+AAV055pVPfgAKIDRAbN5DxS+lWfA8PQojCzZGt0GklDM/ETWznmzUnItDWPhGDh4sXVerc6rwD8vrpSWBN6xMeFBtiQ29bd3zhSjRfp53ySwXryhZ4cWNZv5st6u+427hc4W/BFlqhDf/C5ZAf2HoF3oNbl08CaCQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769075332; c=relaxed/simple;
	bh=zDvI0r721GWuKjzTRxRfKIZm1wASB3iqx/GnbWWTBxc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=THrOLtKBOhELNPQSHGE5dU6p/on7AqXWyuApUWBeFHhwLsdJ1D933PuJlcuBMeTnaZfr9YEsqJbW2a5F/6LAR6r+YGNGbOcw+epm0I+GLLL4qtw7aiYpIo1qbQMNF79TLD5x2bc/44bgU17eRVSxo6YlNAKlDNbqEoL31MW3qMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MWbJxGtB; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769075323; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=inJkZ+nOM0BK9AzUrv7pYctCmdogU8NzevhBnuJcJ5U=;
	b=MWbJxGtBoFIiG/K7kKPK5vTkrKZ3HsC33v24VE8iWgyXoLvj6/duT0XMm4/bChAWsQTauyObUip0RGOUTRurD1sgOZR7dcGsfOEX1HMYrK1auRbQmfBfZed4EdhSadVlerl773p2CyoiOF86crzk3OvW4HIyHw1BQU/iXilnkRI=
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0WxbuaxQ_1769075318 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 22 Jan 2026 17:48:41 +0800
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
Subject: [PATCH v6 15/16] ras: AEST: support vendor node CMN700
Date: Thu, 22 Jan 2026 17:46:55 +0800
Message-Id: <20260122094656.73399-16-tianruidong@linux.alibaba.com>
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
	TAGGED_FROM(0.00)[bounces-5673-lists,linux-edac=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,linux.alibaba.com:mid,linux.alibaba.com:dkim,arm.com:url]
X-Rspamd-Queue-Id: 6314C64ECB
X-Rspamd-Action: no action

The CMN (Coherent Mesh Network) architecture incorporates five distinct
device types. Each device type is associated with an error group register
set. The struct aest_cmn_700 models a single CMN instance, while struct
aest_cmn_700_child represents an individual CMN device.

CMN's error records utilize a memory-mapped single error record view [1].
Critically, one error record corresponds to one AEST node, implying that
a single CMN instance can generate hundreds of AEST nodes. To manage this
scale, this driver introduces a virtual AEST node, which represents an
entire CMN device, such as an HNI or HNF. This allows an HNF AEST node,
for instance, to leverage its errgsr register to pinpoint which specific
error record has reported an error.

During the AEST probe phase, the CMN AEST driver identifies the CMN node
type using the cmn_node_info register. It then reorganizes all AEST nodes
belonging to the same CMN node type into a cohesive CMN AEST node
structure. To locate the relevant CMN register addresses, the CMN's
presence in the DSDT is required, along with the CMN node offset
specified in the AEST vendor specification data [1].

[1]: https://developer.arm.com/documentation/102308/latest/

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 arch/arm64/include/asm/arm-cmn.h |  47 +++++
 drivers/perf/arm-cmn.c           |  37 +---
 drivers/ras/aest/Makefile        |   1 +
 drivers/ras/aest/aest-cmn.c      | 330 +++++++++++++++++++++++++++++++
 drivers/ras/aest/aest-core.c     |  42 ++--
 drivers/ras/aest/aest.h          |  39 ++++
 6 files changed, 444 insertions(+), 52 deletions(-)
 create mode 100644 arch/arm64/include/asm/arm-cmn.h
 create mode 100644 drivers/ras/aest/aest-cmn.c

diff --git a/arch/arm64/include/asm/arm-cmn.h b/arch/arm64/include/asm/arm-cmn.h
new file mode 100644
index 000000000000..1b9f50679794
--- /dev/null
+++ b/arch/arm64/include/asm/arm-cmn.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2015 ARM Ltd.
+ */
+#ifndef __ASM_ARM_CMN_H
+#define __ASM_ARM_CMN_H
+
+#include <asm/sysreg.h>
+
+/* Common register stuff */
+#define CMN_NODE_INFO			0x0000
+#define CMN_NI_NODE_TYPE		GENMASK_ULL(15, 0)
+#define CMN_NI_NODE_ID			GENMASK_ULL(31, 16)
+#define CMN_NI_LOGICAL_ID		GENMASK_ULL(47, 32)
+
+enum cmn_node_type {
+	CMN_TYPE_INVALID,
+	CMN_TYPE_DVM,
+	CMN_TYPE_CFG,
+	CMN_TYPE_DTC,
+	CMN_TYPE_HNI,
+	CMN_TYPE_HNF,
+	CMN_TYPE_XP,
+	CMN_TYPE_SBSX,
+	CMN_TYPE_MPAM_S,
+	CMN_TYPE_MPAM_NS,
+	CMN_TYPE_RNI,
+	CMN_TYPE_RND = 0xd,
+	CMN_TYPE_RNSAM = 0xf,
+	CMN_TYPE_MTSX,
+	CMN_TYPE_HNP,
+	CMN_TYPE_CXRA = 0x100,
+	CMN_TYPE_CXHA,
+	CMN_TYPE_CXLA,
+	CMN_TYPE_CCRA,
+	CMN_TYPE_CCHA,
+	CMN_TYPE_CCLA,
+	CMN_TYPE_CCLA_RNI,
+	CMN_TYPE_HNS = 0x200,
+	CMN_TYPE_HNS_MPAM_S,
+	CMN_TYPE_HNS_MPAM_NS,
+	CMN_TYPE_APB = 0x1000,
+	/* Not a real node type */
+	CMN_TYPE_WP = 0x7770
+};
+
+#endif /* __ASM_ARM_CMN_H */
diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 23245352a3fc..989482096dfb 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -2,6 +2,7 @@
 // Copyright (C) 2016-2020 Arm Limited
 // ARM CMN/CI interconnect PMU driver
 
+#include <asm/arm-cmn.h>
 #include <linux/acpi.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
@@ -19,11 +20,6 @@
 #include <linux/sort.h>
 
 /* Common register stuff */
-#define CMN_NODE_INFO			0x0000
-#define CMN_NI_NODE_TYPE		GENMASK_ULL(15, 0)
-#define CMN_NI_NODE_ID			GENMASK_ULL(31, 16)
-#define CMN_NI_LOGICAL_ID		GENMASK_ULL(47, 32)
-
 #define CMN_CHILD_INFO			0x0080
 #define CMN_CI_CHILD_COUNT		GENMASK_ULL(15, 0)
 #define CMN_CI_CHILD_PTR_OFFSET		GENMASK_ULL(31, 16)
@@ -241,37 +237,6 @@ enum cmn_revision {
 	REV_CI700_R2P0,
 };
 
-enum cmn_node_type {
-	CMN_TYPE_INVALID,
-	CMN_TYPE_DVM,
-	CMN_TYPE_CFG,
-	CMN_TYPE_DTC,
-	CMN_TYPE_HNI,
-	CMN_TYPE_HNF,
-	CMN_TYPE_XP,
-	CMN_TYPE_SBSX,
-	CMN_TYPE_MPAM_S,
-	CMN_TYPE_MPAM_NS,
-	CMN_TYPE_RNI,
-	CMN_TYPE_RND = 0xd,
-	CMN_TYPE_RNSAM = 0xf,
-	CMN_TYPE_MTSX,
-	CMN_TYPE_HNP,
-	CMN_TYPE_CXRA = 0x100,
-	CMN_TYPE_CXHA,
-	CMN_TYPE_CXLA,
-	CMN_TYPE_CCRA,
-	CMN_TYPE_CCHA,
-	CMN_TYPE_CCLA,
-	CMN_TYPE_CCLA_RNI,
-	CMN_TYPE_HNS = 0x200,
-	CMN_TYPE_HNS_MPAM_S,
-	CMN_TYPE_HNS_MPAM_NS,
-	CMN_TYPE_APB = 0x1000,
-	/* Not a real node type */
-	CMN_TYPE_WP = 0x7770
-};
-
 enum cmn_filter_select {
 	SEL_NONE = -1,
 	SEL_OCCUP1ID,
diff --git a/drivers/ras/aest/Makefile b/drivers/ras/aest/Makefile
index 5ee10fc8b2e9..e5a45fde6d36 100644
--- a/drivers/ras/aest/Makefile
+++ b/drivers/ras/aest/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_AEST) 	+= aest.o
 aest-y		:= aest-core.o
 aest-y		+= aest-sysfs.o
 aest-y		+= aest-inject.o
+aest-y		+= aest-cmn.o
diff --git a/drivers/ras/aest/aest-cmn.c b/drivers/ras/aest/aest-cmn.c
new file mode 100644
index 000000000000..ad82ed163a8c
--- /dev/null
+++ b/drivers/ras/aest/aest-cmn.c
@@ -0,0 +1,330 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ARM Error Source Table CMN700 Support
+ *
+ * Copyright (c) 2025, Alibaba Inc
+ */
+
+#include <asm/arm-cmn.h>
+
+#include "aest.h"
+
+/*
+ * CMN include 5 device types, each device type has an error group register set
+ * which contains a set of error records. The struct aest_cmn_700 represents
+ * one CMN Instance, and the struct aest_cmn_700_child represent one CMN device.
+ * The error record of CMN use memory-mapped single error record view, so one
+ * record is correspond to one AEST node, it means there will be hundreds of
+ * AEST node of CMN. As described in chapters 2.6.3.4 of Arm ACPI Spec[1], we
+ * use vendor define data to recognize the device type of an AEST node. So AEST
+ * driver can enumerate all CMN AEST node to initialize struct aest_cmn_700 and
+ * aest_cmn_700_child with HID, UID and other CMN info described in AEST or CMN
+ * register.
+ *
+ * Each CMN Instance has their own error interrupt and the struct aest_cmn_700
+ * is passed to interrupt context. OS check error group register set to locate
+ * record which report error. All procedure is similar with chapters 3.8 in
+ * Arm CMN Spec[2].
+ *
+ * The CMN RAS architecture is showed as follow:
+ *
+ *                     +----+
+ *                  -->|XP  |     ......
+ *                  |  +----+
+ *                  |
+ *                  |  +----+     ......
+ *                  |  |HNI |     +----------------+
+ *                  |  +----+   ->|record/AEST node|
+ *                  |           | +----------------+
+ *  +------------+  |  +----+   |    .
+ *  |CMN Instance|--|  |HNF |---|    .
+ *  +------------+  |  +----+   |    .
+ *                  |           | +----------------+
+ *                  |  +----+   ->|record/AEST node|
+ *                  |  |SBSX|     +----------------+
+ *                  |  +----+     ......
+ *                  |
+ *                  |  +----+
+ *                  -->|CCG |     ......
+ *                     +----+
+ *
+ * [1]: https://developer.arm.com/documentation/den0093/latest
+ * [2]: https://developer.arm.com/documentation/102308/latest
+ */
+
+#define CMN_RAS_DEV_NUM 6
+#define CMN700_ERRGSR_NUM 8
+#define CMN_MAX_UID 8
+#define CMN_ERRDEVARCH 0x3FB8
+#define CMN_ERRDEVARCH_REV GENMASK(19, 16)
+#define CMN_ERRGSR_OFFSET 0x3000
+
+struct cmn_vendor_data {
+	int node_type;
+	int node_id;
+	int logic_id;
+};
+
+struct cmn_config {
+	int errgsr_num;
+	int dev_num;
+	int ras_ver;
+	const int *node_id_map;
+	const char *const *node_name;
+	int (*errgsr_mapping)(int errgsr_bit);
+	u64 (*errgsr_offset)(u64 hnd_ofset, int node_idx);
+};
+
+static const char *const cmn700_node_name[] = {
+	[CMN_TYPE_HNI] = "HNI",	 [CMN_TYPE_HNF] = "HNF",
+	[CMN_TYPE_XP] = "XP",	 [CMN_TYPE_SBSX] = "SBSX",
+	[CMN_TYPE_CXRA] = "RND", [CMN_TYPE_MTSX] = "MTSX",
+};
+
+static const int cmn700_node_id_map[] = {
+	[CMN_TYPE_HNI] = 1,  [CMN_TYPE_HNF] = 2,  [CMN_TYPE_XP] = 0,
+	[CMN_TYPE_SBSX] = 3, [CMN_TYPE_CXRA] = 4, [CMN_TYPE_MTSX] = 5,
+};
+
+static u64 cmn_dev_array[CMN_MAX_UID];
+static struct cmn_config *cmn_config;
+
+static u64 cmn700_errgsr_offset(u64 hnd_offset, int node_idx)
+{
+	return hnd_offset + CMN_ERRGSR_OFFSET +
+	       (node_idx * 2) * CMN700_ERRGSR_NUM * 8;
+}
+
+static struct cmn_config cmn700_config = {
+	.errgsr_num = CMN700_ERRGSR_NUM,
+	.dev_num = CMN_RAS_DEV_NUM,
+	.ras_ver = 1,
+	.node_name = cmn700_node_name,
+	.node_id_map = cmn700_node_id_map,
+	.errgsr_mapping = cmn700_errgsr_mapping,
+	.errgsr_offset = cmn700_errgsr_offset,
+};
+
+static acpi_status aest_cmn_700_resource_ioremap(struct acpi_resource *res,
+						 void *data)
+{
+	struct acpi_resource_address64 addr64;
+	u32 *uid = data;
+	acpi_status status;
+
+	status = acpi_resource_to_address64(res, &addr64);
+	if (ACPI_FAILURE(status) || (addr64.resource_type != ACPI_MEMORY_RANGE))
+		return AE_OK;
+
+	cmn_dev_array[*uid] = (u64)ioremap(addr64.address.minimum,
+					   addr64.address.address_length);
+
+	pr_debug("CMN device resource [%llx-%llx] ioremap to %llx\n",
+		 addr64.address.minimum, addr64.address.maximum,
+		 cmn_dev_array[*uid]);
+
+	return AE_CTRL_TERMINATE;
+}
+
+static acpi_status aest_cmn_get_dev_by_uid(acpi_handle handle, u32 level,
+					   void *data, void **return_value)
+{
+	u32 *match_uid = data;
+	acpi_status status;
+	unsigned long long uid;
+
+	status = acpi_evaluate_integer(handle, METHOD_NAME__UID, NULL, &uid);
+	if (ACPI_FAILURE(status)) {
+		pr_err("Do not find devive\n");
+		return_ACPI_STATUS(status);
+	}
+
+	if (uid != *match_uid)
+		return AE_OK;
+
+	pr_debug("CMN device instance %llx, walk through resource\n", uid);
+
+	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
+				     aest_cmn_700_resource_ioremap, data);
+
+	if (ACPI_FAILURE(status)) {
+		pr_err("Device do not have resource\n");
+		return_ACPI_STATUS(status);
+	}
+
+	return AE_CTRL_TERMINATE;
+}
+
+static inline int aest_cmn_node_ver(void *base)
+{
+	return FIELD_GET(CMN_ERRDEVARCH_REV,
+			 readl_relaxed(base + CMN_ERRDEVARCH));
+}
+
+static int aest_cmn_init_node(struct aest_device *adev,
+			      struct aest_node *cmn_node,
+			      struct acpi_aest_node *anode, u64 type,
+			      u64 errgsr_addr)
+{
+	cmn_node->info = anode;
+	cmn_node->name = devm_kasprintf(adev->dev, GFP_KERNEL, "%s",
+					cmn_config->node_name[type]);
+	if (!cmn_node->name)
+		return -ENOMEM;
+	cmn_node->errgsr = (void *)errgsr_addr;
+	cmn_node->type = anode->type;
+	cmn_node->adev = adev;
+	cmn_node->version = cmn_config->ras_ver;
+	cmn_node->errgsr_num = cmn_config->errgsr_num;
+	cmn_node->errgsr_mapping = cmn_config->errgsr_mapping;
+	cmn_node->record_count = cmn_node->errgsr_num * BITS_PER_LONG / 2;
+	cmn_node->record_implemented = devm_bitmap_zalloc(
+		adev->dev, cmn_node->record_count, GFP_KERNEL);
+	if (!cmn_node->record_implemented)
+		return -ENOMEM;
+	bitmap_set(cmn_node->record_implemented, 0, cmn_node->record_count);
+
+	cmn_node->status_reporting = devm_bitmap_zalloc(
+		adev->dev, cmn_node->record_count, GFP_KERNEL);
+	if (!cmn_node->status_reporting)
+		return -ENOMEM;
+	bitmap_set(cmn_node->status_reporting, 0, cmn_node->record_count);
+
+	cmn_node->records = devm_kcalloc(adev->dev, cmn_node->record_count,
+					 sizeof(struct aest_record),
+					 GFP_KERNEL);
+	if (!cmn_node->records)
+		return -ENOMEM;
+
+	aest_node_dbg(cmn_node, "Node init with errgsr %llx\n", errgsr_addr);
+
+	return 0;
+}
+
+static int aest_cmn_reorgnize_node(struct aest_device *adev,
+				   struct acpi_aest_node *anode, u64 base)
+{
+	struct aest_node *cmn_node;
+	u64 hnd_offset, cmn_node_offset, reg, logic_id, type, node_id;
+	u64 errgsr_addr, hnd_base;
+	struct aest_record *record;
+	int ret, node_index;
+	struct cmn_vendor_data *vendor_data;
+
+	if (anode->interface_hdr->type !=
+	    ACPI_AEST_NODE_SINGLE_RECORD_MEMORY_MAPPED) {
+		aest_dev_err(adev, "CMN just use single memory mapping\n");
+		return -ENODEV;
+	}
+
+	hnd_offset = *((u64 *)anode->vendor->vendor_specific_data);
+	cmn_node_offset = *((u64 *)&anode->vendor->vendor_specific_data[8]);
+
+	reg = readq_relaxed((void *)base + cmn_node_offset + CMN_NODE_INFO);
+
+	logic_id = FIELD_GET(CMN_NI_LOGICAL_ID, reg);
+	type = FIELD_GET(CMN_NI_NODE_TYPE, reg);
+	node_id = FIELD_GET(CMN_NI_NODE_ID, reg);
+
+	hnd_base = base + hnd_offset;
+	node_index = cmn_config->node_id_map[type];
+	errgsr_addr = base + cmn_config->errgsr_offset(hnd_offset, node_index);
+
+	// node not register, create it
+	cmn_node = &adev->nodes[node_index];
+	if (!cmn_node->errgsr) {
+		ret = aest_cmn_init_node(adev, cmn_node, anode, type,
+					 errgsr_addr);
+		if (ret)
+			return -ENOMEM;
+	}
+
+	aest_dev_dbg(adev, "node type %llx, id %llx, offset %llx\n", type,
+		     logic_id, cmn_node_offset);
+
+	if (!test_bit(0, anode->record_implemented))
+		clear_bit(logic_id, cmn_node->record_implemented);
+
+	if (!test_bit(0, anode->status_reporting))
+		clear_bit(logic_id, cmn_node->status_reporting);
+
+	record = &cmn_node->records[logic_id];
+	record->name =
+		devm_kasprintf(adev->dev, GFP_KERNEL, "record%lld", logic_id);
+	if (!record->name)
+		return -ENOMEM;
+	record->regs_base = devm_ioremap(
+		adev->dev, (resource_size_t)anode->interface_hdr->address,
+		sizeof(struct ras_ext_regs));
+	if (!record->regs_base)
+		return -ENOMEM;
+	record->addressing_mode = test_bit(0, anode->addressing_mode);
+	record->node = cmn_node;
+	record->index = logic_id;
+	record->access = &aest_access[anode->interface_hdr->type];
+
+	vendor_data = devm_kzalloc(adev->dev, sizeof(struct cmn_vendor_data),
+				   GFP_KERNEL);
+	vendor_data->node_type = type;
+	vendor_data->node_id = node_id;
+	vendor_data->logic_id = logic_id;
+
+	record->vendor_data = vendor_data;
+	record->vendor_data_size = sizeof(struct cmn_vendor_data);
+
+	aest_record_dbg(record, "base %llx\n", anode->interface_hdr->address);
+
+	return 0;
+}
+
+// reorgnize cmn node
+static int aest_cmn_probe(struct aest_device *adev, struct aest_hnode *ahnode)
+{
+	acpi_status status;
+	u64 base;
+	int ret = 0;
+	struct acpi_aest_node *anode;
+	char name[9];
+
+	anode = list_first_entry(&ahnode->list, struct acpi_aest_node, list);
+	if (!anode)
+		return -ENODEV;
+
+	if (!cmn_dev_array[anode->vendor->acpi_uid]) {
+		snprintf(name, 9, "%s", anode->vendor->acpi_hid);
+		status = acpi_get_devices(name, aest_cmn_get_dev_by_uid,
+					  &anode->vendor->acpi_uid, NULL);
+		if (ACPI_FAILURE(status)) {
+			aest_dev_err(adev, "Can not find base\n");
+			return_ACPI_STATUS(status);
+		}
+	}
+	base = cmn_dev_array[anode->vendor->acpi_uid];
+	if (!base) {
+		aest_dev_err(adev, "Device base invalid\n");
+		return -ENODEV;
+	}
+
+	adev->type = anode->type;
+	adev->node_cnt = cmn_config->dev_num;
+	adev->nodes = devm_kcalloc(adev->dev, adev->node_cnt,
+				   sizeof(struct aest_node), GFP_KERNEL);
+	if (!adev->nodes)
+		return -ENOMEM;
+	aest_set_name(adev, ahnode);
+
+	list_for_each_entry(anode, &ahnode->list, list) {
+		ret = aest_cmn_reorgnize_node(adev, anode, base);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+int aest_cmn700_probe(struct aest_device *adev, struct aest_hnode *ahnode)
+{
+	cmn_config = &cmn700_config;
+
+	return aest_cmn_probe(adev, ahnode);
+}
diff --git a/drivers/ras/aest/aest-core.c b/drivers/ras/aest/aest-core.c
index 047c9a8cffe4..bbf8b1142be7 100644
--- a/drivers/ras/aest/aest-core.c
+++ b/drivers/ras/aest/aest-core.c
@@ -152,6 +152,8 @@ static void init_aest_event(struct aest_event *event,
 	memcpy(&event->regs, regs, sizeof(*regs));
 	event->index = record->index;
 	event->addressing_mode = record->addressing_mode;
+	event->vendor_data_size = record->vendor_data_size;
+	event->vendor_data = record->vendor_data;
 }
 
 static int aest_node_gen_pool_add(struct aest_device *adev,
@@ -341,10 +343,9 @@ void aest_proc_record(struct aest_record *record, void *data, bool fake)
 	record_write(record, ERXSTATUS, regs.err_status);
 }
 
-static void aest_node_foreach_record(void (*func)(struct aest_record *, void *,
-						  bool),
-				     struct aest_node *node, void *data,
-				     unsigned long *bitmap)
+void aest_node_foreach_record(void (*func)(struct aest_record *, void *, bool),
+			      struct aest_node *node, void *data,
+			      unsigned long *bitmap)
 {
 	int i;
 
@@ -359,7 +360,7 @@ static void aest_node_foreach_record(void (*func)(struct aest_record *, void *,
 
 static int aest_proc(struct aest_node *node)
 {
-	int count = 0, i, j, size = node->record_count;
+	int count = 0, i, j, size = node->record_count, record_idx;
 	u64 err_group = 0;
 
 	aest_node_dbg(node, "Poll bitmap %*pb\n", size,
@@ -374,19 +375,21 @@ static int aest_proc(struct aest_node *node)
 		      node->status_reporting);
 	for (i = 0; i < BITS_TO_U64(size); i++) {
 		err_group = readq_relaxed((void *)node->errgsr + i * 8);
-		aest_node_dbg(node, "errgsr[%d]: 0x%llx\n", i, err_group);
-
 		for_each_set_bit(j, (unsigned long *)&err_group,
 				 BITS_PER_LONG) {
+			record_idx =
+				node->errgsr_mapping(i * BITS_PER_LONG + j);
+			aest_node_dbg(node, "errgsr[%d]: bit %d occur error\n",
+				      i, record_idx);
 			/*
 			 * Error group base is only valid in Memory Map node,
 			 * so driver do not need to write select register and
 			 * sync.
 			 */
-			if (test_bit(i * BITS_PER_LONG + j,
-				     node->status_reporting))
+			if (test_bit(record_idx, node->status_reporting))
 				continue;
-			aest_proc_record(&node->records[j], &count, false);
+			aest_proc_record(&node->records[record_idx], &count,
+					 false);
 		}
 	}
 
@@ -398,8 +401,11 @@ static irqreturn_t aest_irq_func(int irq, void *input)
 	struct aest_device *adev = input;
 	int i;
 
-	for (i = 0; i < adev->node_cnt; i++)
+	for (i = 0; i < adev->node_cnt; i++) {
+		if (!adev->nodes[i].record_count)
+			continue;
 		aest_proc(&adev->nodes[i]);
+	}
 
 	return IRQ_HANDLED;
 }
@@ -776,6 +782,7 @@ static int aest_init_node(struct aest_device *adev, struct aest_node *node,
 	node->info = anode;
 	node->type = anode->type;
 	node->version = get_aest_node_ver(node);
+	node->errgsr_mapping = default_errgsr_mapping;
 	node->name = alloc_aest_node_name(node);
 	if (!node->name)
 		return -ENOMEM;
@@ -828,6 +835,7 @@ static int aest_init_node(struct aest_device *adev, struct aest_node *node,
 	if (!node->records)
 		return -ENOMEM;
 
+	node->errgsr_num = DIV_ROUND_UP(node->record_count, BITS_PER_LONG);
 	for (i = 0; i < node->record_count; i++) {
 		ret = aest_init_record(&node->records[i], i, node);
 		if (ret)
@@ -923,11 +931,12 @@ static int aest_setup_irq(struct platform_device *pdev,
 }
 
 static struct aest_vendor_match vendor_match[] = {
-	{  },
+	{ "ARMHC700", &aest_cmn700_probe },
+	{},
 };
 
-static int
-aest_vendor_probe(struct aest_device *adev, struct aest_hnode *ahnode)
+static int aest_vendor_probe(struct aest_device *adev,
+			     struct aest_hnode *ahnode)
 {
 	int i;
 	struct acpi_aest_node *anode;
@@ -936,13 +945,14 @@ aest_vendor_probe(struct aest_device *adev, struct aest_hnode *ahnode)
 	if (!anode)
 		return -ENODEV;
 
-	aest_dev_dbg(adev, "Try to probe vendor node %s\n", anode->vendor->acpi_hid);
+	aest_dev_dbg(adev, "Try to probe vendor node %s\n",
+		     anode->vendor->acpi_hid);
 	for (i = 0; i < ARRAY_SIZE(vendor_match); i++) {
 		if (!strncmp(vendor_match[i].hid, anode->vendor->acpi_hid, 8))
 			return vendor_match[i].probe(adev, ahnode);
 	}
 
-	return -ENODEV;
+	return 0;
 }
 
 static int aest_device_probe(struct platform_device *pdev)
diff --git a/drivers/ras/aest/aest.h b/drivers/ras/aest/aest.h
index 304c03839d31..9d67d79eb4a2 100644
--- a/drivers/ras/aest/aest.h
+++ b/drivers/ras/aest/aest.h
@@ -94,8 +94,16 @@ struct aest_event {
 	/* Vendor node	: hardware ID. */
 	char *hid;
 	u32 index;
+	u64 ce_threshold;
 	int addressing_mode;
 	struct ras_ext_regs regs;
+
+	/*
+	 * This field is used to store vendor specific data for decoding error
+	 * record by EDAC driver.
+	 */
+	void *vendor_data;
+	size_t vendor_data_size;
 };
 
 struct aest_access {
@@ -147,6 +155,9 @@ struct aest_record {
 	enum ras_ce_threshold threshold_type;
 	struct record_count count;
 	struct dentry *debugfs;
+
+	void *vendor_data;
+	size_t vendor_data_size;
 };
 
 struct aest_group {
@@ -208,6 +219,19 @@ struct aest_node {
 	 */
 	unsigned long *status_reporting;
 	int version;
+	/*
+	 * Usually bit[n] in errgsr indicates [n]th error record within this
+	 * error node report error. But some compoent may have different rules.
+	 * For example, CMN700 TRM 4.3.5.12 say:
+	 *	``` Error occurs when the index is even and Fault
+	 *	    occurs when the index is odd. ```
+	 *	Bit[n]: record[n] report ERROR.
+	 *	Bit[n + 1]: record[n] report FAULT.
+	 * errgsr_mapping function is used to map errgsr bit to record index
+	 * for various components.
+	 */
+	int (*errgsr_mapping)(int errgsr_bit);
+	int errgsr_num;
 
 	const struct aest_group *group;
 	struct aest_device *adev;
@@ -366,6 +390,21 @@ static inline bool aest_dev_is_oncore(struct aest_device *adev)
 	return adev->type == ACPI_AEST_PROCESSOR_ERROR_NODE;
 }
 
+static inline int default_errgsr_mapping(int errgsr_bit)
+{
+	return errgsr_bit;
+}
+
+static inline int cmn700_errgsr_mapping(int errgsr_bit)
+{
+	return errgsr_bit / 2;
+}
+
 void aest_dev_init_debugfs(struct aest_device *adev);
 void aest_inject_init_debugfs(struct aest_record *record);
 void aest_proc_record(struct aest_record *record, void *data, bool fake);
+void aest_node_foreach_record(void (*func)(struct aest_record *, void *, bool),
+			      struct aest_node *node, void *data,
+			      unsigned long *bitmap);
+
+int aest_cmn700_probe(struct aest_device *adev, struct aest_hnode *ahnode);
-- 
2.51.2.612.gdc70283dfc


