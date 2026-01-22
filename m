Return-Path: <linux-edac+bounces-5659-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OahGmbzcWmvZwAAu9opvQ
	(envelope-from <linux-edac+bounces-5659-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Thu, 22 Jan 2026 10:52:38 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3C264D4A
	for <lists+linux-edac@lfdr.de>; Thu, 22 Jan 2026 10:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0AD404E1A28
	for <lists+linux-edac@lfdr.de>; Thu, 22 Jan 2026 09:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBD0387341;
	Thu, 22 Jan 2026 09:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="k2J+8pKl"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD25824BD;
	Thu, 22 Jan 2026 09:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769075247; cv=none; b=roR6VrpMxGfvA8bPFe69+U9Uqa5QU9yhlhh4C9ieyb4GLrLqQ534B6SaP1SMpaOBKd8jjKanP3DKYBqWb2nL6R2d6aIdgLYokQOxuiMZn6U4e8eyG/omrVy09dzPBk7CUuui+bLMdqvXD0A1KBdnckhcMd2DdJdjcjgFiXnoi0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769075247; c=relaxed/simple;
	bh=lUJDFhqIwrydOCAQkP6ExC9To0t1zANf28smu6iDH0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G3Su89v5XeMHS8MJp2YNYDdshjWUgrdASbdZQgIBXqjY7hn3f97HA1O2o9EDXsjHnCAFf/QhF4/1Rn581fNSA+GRf5mAtpw9V0vvhryy0IqV0EEGwOMo7BeU3epo7aujVYvgB/+P6XitMPGJl/U8z57by7t3Kvfvjl0tZHAzyWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=k2J+8pKl; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769075240; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=fCmbaKQAmT+0+OvpnhlSUdrQgAKyDfLEsgBx77Ci0yM=;
	b=k2J+8pKlgYGyVxg0kp/TwRpBwvIKA/TyqcqCzIxuk6oglo9s0EQ3bBlD/VclifH6oqbNaKMS8eInF8GNR8nnoZVO5ygW5VnoOBchHpYWli/amYXtX6dGY4Liv/HC6k05MR5d4ERHakP2gHbwlKfXQKe0AP3C/JwliNp34AG0/I8=
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0WxbuaKI_1769075230 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 22 Jan 2026 17:47:18 +0800
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
Subject: [PATCH v6 01/16] ACPI/AEST: Parse the AEST table
Date: Thu, 22 Jan 2026 17:46:41 +0800
Message-Id: <20260122094656.73399-2-tianruidong@linux.alibaba.com>
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
	TAGGED_FROM(0.00)[bounces-5659-lists,linux-edac=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,linux.alibaba.com:mid,linux.alibaba.com:dkim,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,arm.com:url]
X-Rspamd-Queue-Id: CC3C264D4A
X-Rspamd-Action: no action

This patch introduces the creation of AEST platform devices, where each
device represents a logical "error node device" grouping one or more
AEST nodes from the ACPI table.

Instead of relying on the optional 'error_node_device' field in the AEST
table[1], this commit uses the interrupt number as the sole identifier for
the parent device. This design simplifies the driver logic by providing a
single, consistent mechanism for grouping nodes.

The 'error_node_device' field can be unspecified, but an AEST node is
always physically associated with a parent component. The interrupt
number serves as a reliable proxy for this association. This approach
is based on the safe assumption that distinct hardware components (e.g.,
SMMU, CMN, GIC) are assigned unique error interrupts and do not share
them.

[1]: https://developer.arm.com/documentation/den0085/latest

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 MAINTAINERS                  |   8 +
 arch/arm64/include/asm/ras.h |  15 ++
 drivers/acpi/arm64/Kconfig   |  11 ++
 drivers/acpi/arm64/Makefile  |   1 +
 drivers/acpi/arm64/aest.c    | 311 +++++++++++++++++++++++++++++++++++
 include/linux/acpi_aest.h    |  56 +++++++
 6 files changed, 402 insertions(+)
 create mode 100644 arch/arm64/include/asm/ras.h
 create mode 100644 drivers/acpi/arm64/aest.c
 create mode 100644 include/linux/acpi_aest.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 0d044a58cbfe..e1f8027522ec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -341,6 +341,14 @@ S:	Maintained
 F:	drivers/acpi/arm64
 F:	include/linux/acpi_iort.h
 
+ACPI AEST
+M:	Ruidong Tian <tianruidond@linux.alibaba.com>
+L:	linux-acpi@vger.kernel.org
+L:	linux-arm-kernel@lists.infradead.org
+S:	Supported
+F:	drivers/acpi/arm64/aest.c
+F:	include/linux/acpi_aest.h
+
 ACPI FOR RISC-V (ACPI/riscv)
 M:	Sunil V L <sunilvl@ventanamicro.com>
 L:	linux-acpi@vger.kernel.org
diff --git a/arch/arm64/include/asm/ras.h b/arch/arm64/include/asm/ras.h
new file mode 100644
index 000000000000..b6640b9972bf
--- /dev/null
+++ b/arch/arm64/include/asm/ras.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_RAS_H
+#define __ASM_RAS_H
+
+#include <linux/types.h>
+
+struct ras_ext_regs {
+	u64 err_fr;
+	u64 err_ctlr;
+	u64 err_status;
+	u64 err_addr;
+	u64 err_misc[4];
+};
+
+#endif /* __ASM_RAS_H */
diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
index f2fd79f22e7d..52df190356c8 100644
--- a/drivers/acpi/arm64/Kconfig
+++ b/drivers/acpi/arm64/Kconfig
@@ -24,3 +24,14 @@ config ACPI_APMT
 
 config ACPI_MPAM
 	bool
+
+config ACPI_AEST
+	bool "ARM Error Source Table Support"
+	depends on ARM64_RAS_EXTN
+
+	help
+	  The Arm Error Source Table (AEST) provides details on ACPI
+	  extensions that enable kernel-first handling of errors in a
+	  system that supports the Armv8 RAS extensions.
+
+	  If set, the kernel will report and log hardware errors.
diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
index 9390b57cb564..bad77fdbf8dd 100644
--- a/drivers/acpi/arm64/Makefile
+++ b/drivers/acpi/arm64/Makefile
@@ -7,5 +7,6 @@ obj-$(CONFIG_ACPI_IORT) 	+= iort.o
 obj-$(CONFIG_ACPI_MPAM) 	+= mpam.o
 obj-$(CONFIG_ACPI_PROCESSOR_IDLE) += cpuidle.o
 obj-$(CONFIG_ARM_AMBA)		+= amba.o
+obj-$(CONFIG_ACPI_AEST) 	+= aest.o
 obj-y				+= dma.o init.o
 obj-y				+= thermal_cpufreq.o
diff --git a/drivers/acpi/arm64/aest.c b/drivers/acpi/arm64/aest.c
new file mode 100644
index 000000000000..b8359b95f40f
--- /dev/null
+++ b/drivers/acpi/arm64/aest.c
@@ -0,0 +1,311 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ARM Error Source Table Support
+ *
+ * Copyright (c) 2025, Alibaba Group.
+ */
+
+#include <linux/xarray.h>
+#include <linux/platform_device.h>
+#include <linux/acpi_aest.h>
+
+#include "init.h"
+
+#undef pr_fmt
+#define pr_fmt(fmt) "ACPI AEST: " fmt
+
+static struct xarray *aest_array;
+
+static void __init aest_init_interface(struct acpi_aest_hdr *hdr,
+				       struct acpi_aest_node *node)
+{
+	struct acpi_aest_node_interface_header *interface;
+
+	interface = ACPI_ADD_PTR(struct acpi_aest_node_interface_header, hdr,
+				 hdr->node_interface_offset);
+
+	node->type = hdr->type;
+	node->interface_hdr = interface;
+
+	switch (interface->group_format) {
+	case ACPI_AEST_NODE_GROUP_FORMAT_4K: {
+		struct acpi_aest_node_interface_4k *interface_4k =
+			(struct acpi_aest_node_interface_4k *)(interface + 1);
+
+		node->common = &interface_4k->common;
+		node->record_implemented =
+			(unsigned long *)&interface_4k->error_record_implemented;
+		node->status_reporting =
+			(unsigned long *)&interface_4k->error_status_reporting;
+		node->addressing_mode =
+			(unsigned long *)&interface_4k->addressing_mode;
+		break;
+	}
+	case ACPI_AEST_NODE_GROUP_FORMAT_16K: {
+		struct acpi_aest_node_interface_16k *interface_16k =
+			(struct acpi_aest_node_interface_16k *)(interface + 1);
+
+		node->common = &interface_16k->common;
+		node->record_implemented =
+			(unsigned long *)interface_16k->error_record_implemented;
+		node->status_reporting =
+			(unsigned long *)interface_16k->error_status_reporting;
+		node->addressing_mode =
+			(unsigned long *)interface_16k->addressing_mode;
+		break;
+	}
+	case ACPI_AEST_NODE_GROUP_FORMAT_64K: {
+		struct acpi_aest_node_interface_64k *interface_64k =
+			(struct acpi_aest_node_interface_64k *)(interface + 1);
+
+		node->common = &interface_64k->common;
+		node->record_implemented =
+			(unsigned long *)interface_64k->error_record_implemented;
+		node->status_reporting =
+			(unsigned long *)interface_64k->error_status_reporting;
+		node->addressing_mode =
+			(unsigned long *)interface_64k->addressing_mode;
+		break;
+	}
+	default:
+		pr_err("invalid group format: %d\n", interface->group_format);
+	}
+
+	node->interrupt = ACPI_ADD_PTR(struct acpi_aest_node_interrupt_v2, hdr,
+				       hdr->node_interrupt_offset);
+
+	node->interrupt_count = hdr->node_interrupt_count;
+}
+
+static struct aest_hnode *__init
+acpi_aest_alloc_ahnode(struct acpi_aest_node *node, u64 error_device_id)
+{
+	struct aest_hnode *ahnode __free(kfree) = NULL;
+
+	ahnode = kzalloc(sizeof(*ahnode), GFP_KERNEL);
+	if (!ahnode)
+		return NULL;
+
+	INIT_LIST_HEAD(&ahnode->list);
+	ahnode->id = error_device_id;
+	ahnode->count = 0;
+	ahnode->type = node->type;
+
+	return_ptr(ahnode);
+}
+static int __init acpi_aest_init_node(struct acpi_aest_hdr *aest_hdr)
+{
+	struct aest_hnode *ahnode;
+	u64 error_device_id;
+	struct acpi_aest_node *node;
+
+	node = kzalloc(sizeof(*node), GFP_KERNEL);
+	if (!node)
+		return -ENOMEM;
+
+	node->spec_pointer =
+		ACPI_ADD_PTR(void, aest_hdr, aest_hdr->node_specific_offset);
+	if (aest_hdr->type == ACPI_AEST_PROCESSOR_ERROR_NODE)
+		node->processor_spec_pointer =
+			ACPI_ADD_PTR(void, node->spec_pointer,
+				     sizeof(struct acpi_aest_processor));
+
+	aest_init_interface(aest_hdr, node);
+
+	if (node->interrupt_count <= 0)
+		return -EINVAL;
+
+	error_device_id = node->interrupt[0].gsiv;
+	ahnode = xa_load(aest_array, error_device_id);
+	if (!ahnode) {
+		ahnode = acpi_aest_alloc_ahnode(node, error_device_id);
+		if (!ahnode)
+			return -ENOMEM;
+		xa_store(aest_array, error_device_id, ahnode, GFP_KERNEL);
+	}
+
+	list_add_tail(&node->list, &ahnode->list);
+	ahnode->count++;
+
+	return 0;
+}
+
+static int __init acpi_aest_init_nodes(struct acpi_table_header *aest_table)
+{
+	struct acpi_aest_hdr *aest_node, *aest_end;
+	struct acpi_table_aest *aest;
+	int rc;
+
+	aest = (struct acpi_table_aest *)aest_table;
+	aest_node = ACPI_ADD_PTR(struct acpi_aest_hdr, aest,
+				 sizeof(struct acpi_table_header));
+	aest_end = ACPI_ADD_PTR(struct acpi_aest_hdr, aest, aest_table->length);
+
+	while (aest_node < aest_end) {
+		if (((u64)aest_node + aest_node->length) > (u64)aest_end) {
+			pr_warn(FW_WARN
+				"AEST node pointer overflow, bad table.\n");
+			return -EINVAL;
+		}
+
+		rc = acpi_aest_init_node(aest_node);
+		if (rc)
+			return rc;
+
+		aest_node = ACPI_ADD_PTR(struct acpi_aest_hdr, aest_node,
+					 aest_node->length);
+	}
+
+	return 0;
+}
+
+static int acpi_aest_parse_irqs(struct platform_device *pdev,
+				struct acpi_aest_node *anode,
+				struct resource *res, int *res_idx, int irqs[2])
+{
+	int i;
+	struct acpi_aest_node_interrupt_v2 *interrupt;
+	int trigger, irq;
+
+	for (i = 0; i < anode->interrupt_count; i++) {
+		interrupt = &anode->interrupt[i];
+		if (irqs[interrupt->type])
+			continue;
+
+		trigger = (interrupt->flags & AEST_INTERRUPT_MODE) ?
+				  ACPI_LEVEL_SENSITIVE :
+				  ACPI_EDGE_SENSITIVE;
+
+		irq = acpi_register_gsi(&pdev->dev, interrupt->gsiv, trigger,
+					ACPI_ACTIVE_HIGH);
+		if (irq <= 0) {
+			pr_err("failed to map AEST GSI %d\n", interrupt->gsiv);
+			return irq;
+		}
+
+		res[*res_idx].start = irq;
+		res[*res_idx].end = irq;
+		res[*res_idx].flags = IORESOURCE_IRQ;
+		res[*res_idx].name = interrupt->type ? AEST_ERI_NAME :
+						       AEST_FHI_NAME;
+
+		(*res_idx)++;
+
+		irqs[interrupt->type] = irq;
+	}
+
+	return 0;
+}
+
+DEFINE_FREE(res, struct resource *, if (_T) kfree(_T))
+static struct platform_device *__init
+acpi_aest_alloc_pdev(struct aest_hnode *ahnode, int index)
+{
+	struct platform_device *pdev __free(platform_device_put) =
+		platform_device_alloc("AEST", index++);
+	struct resource *res __free(res);
+	struct acpi_aest_node *anode;
+	int ret, size, j, irq[AEST_MAX_INTERRUPT_PER_NODE] = { 0 };
+
+	if (!pdev)
+		return ERR_PTR(-ENOMEM);
+
+	res = kcalloc(ahnode->count + AEST_MAX_INTERRUPT_PER_NODE, sizeof(*res),
+		      GFP_KERNEL);
+	if (!res)
+		return ERR_PTR(-ENOMEM);
+
+	j = 0;
+	list_for_each_entry(anode, &ahnode->list, list) {
+		if (anode->interface_hdr->type !=
+		    ACPI_AEST_NODE_SYSTEM_REGISTER) {
+			res[j].name = AEST_NODE_NAME;
+			res[j].start = anode->interface_hdr->address;
+			switch (anode->interface_hdr->group_format) {
+			case ACPI_AEST_NODE_GROUP_FORMAT_4K:
+				size = 4 * KB;
+				break;
+			case ACPI_AEST_NODE_GROUP_FORMAT_16K:
+				size = 16 * KB;
+				break;
+			case ACPI_AEST_NODE_GROUP_FORMAT_64K:
+				size = 64 * KB;
+				break;
+			default:
+				size = 4 * KB;
+			}
+			res[j].end = res[j].start + size - 1;
+			res[j].flags = IORESOURCE_MEM;
+		}
+
+		ret = acpi_aest_parse_irqs(pdev, anode, res, &j, irq);
+		if (ret)
+			return ERR_PTR(ret);
+	}
+
+	ret = platform_device_add_resources(pdev, res, j);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = platform_device_add_data(pdev, &ahnode, sizeof(ahnode));
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = platform_device_add(pdev);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return_ptr(pdev);
+}
+static int __init acpi_aest_alloc_pdevs(void)
+{
+	int ret = 0, index = 0;
+	struct aest_hnode *ahnode = NULL;
+	unsigned long i;
+
+	xa_for_each(aest_array, i, ahnode) {
+		struct platform_device *pdev =
+			acpi_aest_alloc_pdev(ahnode, index++);
+
+		if (IS_ERR(pdev)) {
+			ret = PTR_ERR(pdev);
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static int __init acpi_aest_init(void)
+{
+	int ret;
+
+	if (acpi_disabled)
+		return 0;
+
+	struct acpi_table_header *aest_table __free(acpi_put_table) =
+		acpi_get_table_pointer(ACPI_SIG_AEST, 0);
+	if (IS_ERR(aest_table))
+		return 0;
+
+	aest_array = kzalloc(sizeof(struct xarray), GFP_KERNEL);
+	if (!aest_array)
+		return -ENOMEM;
+
+	xa_init(aest_array);
+
+	ret = acpi_aest_init_nodes(aest_table);
+	if (ret) {
+		pr_err("Failed init aest node %d\n", ret);
+		return ret;
+	}
+
+	ret = acpi_aest_alloc_pdevs();
+	if (ret) {
+		pr_err("Failed alloc pdev %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+subsys_initcall_sync(acpi_aest_init);
diff --git a/include/linux/acpi_aest.h b/include/linux/acpi_aest.h
new file mode 100644
index 000000000000..53c1970e7583
--- /dev/null
+++ b/include/linux/acpi_aest.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ACPI_AEST_H__
+#define __ACPI_AEST_H__
+
+#include <asm/ras.h>
+#include <linux/acpi.h>
+
+/* AEST resource name */
+#define AEST_NODE_NAME "AEST:NODE"
+#define AEST_FHI_NAME "AEST:FHI"
+#define AEST_ERI_NAME "AEST:ERI"
+
+/* AEST interrupt */
+#define AEST_INTERRUPT_MODE BIT(0)
+
+#define AEST_MAX_INTERRUPT_PER_NODE 2
+
+#define KB 1024
+#define MB (1024 * KB)
+#define GB (1024 * MB)
+
+struct aest_hnode {
+	struct list_head list;
+	int count;
+	u32 id;
+	int type;
+};
+
+struct acpi_aest_node {
+	struct list_head list;
+	int type;
+	struct acpi_aest_node_interface_header *interface_hdr;
+	unsigned long *record_implemented;
+	unsigned long *status_reporting;
+	unsigned long *addressing_mode;
+	struct acpi_aest_node_interface_common *common;
+	union {
+		struct acpi_aest_processor *processor;
+		struct acpi_aest_memory *memory;
+		struct acpi_aest_smmu *smmu;
+		struct acpi_aest_vendor_v2 *vendor;
+		struct acpi_aest_gic *gic;
+		struct acpi_aest_pcie *pcie;
+		struct acpi_aest_proxy *proxy;
+		void *spec_pointer;
+	};
+	union {
+		struct acpi_aest_processor_cache *cache;
+		struct acpi_aest_processor_tlb *tlb;
+		struct acpi_aest_processor_generic *generic;
+		void *processor_spec_pointer;
+	};
+	struct acpi_aest_node_interrupt_v2 *interrupt;
+	int interrupt_count;
+};
+#endif /* __ACPI_AEST_H__ */
-- 
2.51.2.612.gdc70283dfc


