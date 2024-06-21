Return-Path: <linux-edac+bounces-1335-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D89912BD3
	for <lists+linux-edac@lfdr.de>; Fri, 21 Jun 2024 18:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0C9328C131
	for <lists+linux-edac@lfdr.de>; Fri, 21 Jun 2024 16:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90767176239;
	Fri, 21 Jun 2024 16:51:45 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCAF175554
	for <linux-edac@vger.kernel.org>; Fri, 21 Jun 2024 16:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718988705; cv=none; b=AWfrj2Fsew11pABrSDtRHzXQ9AXc5oRAOFh13MCIvohRf4pUy+ZAuY7VwgkE0cvQ1D5D9QuREcAEu3BPYIh80o1CmEzLJhwcyySWIqnD9vjHhhhrjzHf1QTji8LKG7xiJN9cc9CTSxs+g4rLy1egiHTUSLY9dudeoRmhrL+JqMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718988705; c=relaxed/simple;
	bh=CEzTdJ8SabW1w6DENMXx/wt1nnx/ZXmPonYl+tjBxGE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DyQFj9YjURL3xIlxQu6npHg36PIk93y7jUSEnjBRT9xJskli5Hdi9s3PmJwhM9pVbhA0xxJPVnyoEyjJT5732RbBHSOpQUR45h/bjijbcGblf65Af7vmY/8R4xqahCkRzdZz2hfC4FFkOdpvdLgovQP9QOHt2Im/twyFFCzhPK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W5Nft0sNtz6GCty;
	Sat, 22 Jun 2024 00:51:34 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id 54523140A30;
	Sat, 22 Jun 2024 00:51:39 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.151.251) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 17:51:38 +0100
From: <shiju.jose@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-edac@vger.kernel.org>
CC: <jonathan.cameron@huawei.com>, <mchehab+huawei@kernel.org>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>,
	<shiju.jose@huawei.com>
Subject: [RFC PATCH 1/1] hw/arm: FW first ARM processor error injection.
Date: Fri, 21 Jun 2024 17:51:15 +0100
Message-ID: <20240621165115.336-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500006.china.huawei.com (7.191.161.198)

From: Shiju Jose <shiju.jose@huawei.com>

Add support for FW first ARM processor error injection.

Compliance with N.2.4.4 ARM Processor Error Section in
UEFI 2.9A/2.10 specs.

Examples,
{ "execute": "arm-inject-error",
      "arguments": {
        "errortypes": ['cache-error']
      }
}

{ "execute": "arm-inject-error",
      "arguments": {
        "errortypes": ['tlb-error']
      }
}

{ "execute": "arm-inject-error",
      "arguments": {
        "errortypes": ['bus-error']
      }
}

{ "execute": "arm-inject-error",
      "arguments": {
        "errortypes": ['cache-error', 'tlb-error']
      }
}

{ "execute": "arm-inject-error",
      "arguments": {
        "errortypes": ['cache-error', 'tlb-error', 'bus-error', 'micro-arch-error']
      }
}
etc.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 configs/targets/aarch64-softmmu.mak |   1 +
 hw/acpi/ghes.c                      | 170 +++++++++++++++++++++++++++-
 hw/arm/Kconfig                      |   4 +
 hw/arm/arm_error_inject.c           |  49 ++++++++
 hw/arm/arm_error_inject_stubs.c     |  19 ++++
 hw/arm/meson.build                  |   2 +
 include/hw/acpi/ghes.h              |   1 +
 qapi/arm-error-inject.json          |  44 +++++++
 qapi/meson.build                    |   1 +
 qapi/qapi-schema.json               |   1 +
 10 files changed, 291 insertions(+), 1 deletion(-)
 create mode 100644 hw/arm/arm_error_inject.c
 create mode 100644 hw/arm/arm_error_inject_stubs.c
 create mode 100644 qapi/arm-error-inject.json

diff --git a/configs/targets/aarch64-softmmu.mak b/configs/targets/aarch64-softmmu.mak
index b4338e9568..6f9daa9b17 100644
--- a/configs/targets/aarch64-softmmu.mak
+++ b/configs/targets/aarch64-softmmu.mak
@@ -3,3 +3,4 @@ TARGET_BASE_ARCH=arm
 TARGET_SUPPORTS_MTTCG=y
 TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-vfp-sysregs.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml gdb-xml/arm-m-profile-mve.xml gdb-xml/aarch64-pauth.xml
 TARGET_NEED_FDT=y
+CONFIG_ARM_EINJ=y
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 34d8b8a518..ba18e849e2 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -31,6 +31,7 @@
 #include "qemu/uuid.h"
 #include "hw/cxl/cxl_device.h"
 #include "hw/cxl/cxl.h"
+#include "qapi/qapi-types-arm-error-inject.h"
 
 #define ACPI_GHES_ERRORS_FW_CFG_FILE        "etc/hardware_errors"
 #define ACPI_GHES_DATA_ADDR_FW_CFG_FILE     "etc/hardware_errors_addr"
@@ -57,6 +58,7 @@
 /* The memory section CPER size, UEFI 2.6: N.2.5 Memory Error Section */
 #define ACPI_GHES_MEM_CPER_LENGTH           80
 #define ACPI_GHES_PCIE_CPER_LENGTH 208
+#define ACPI_GHES_ARM_CPER_LENGTH (72 + 600)
 
 /* Masks for block_status flags */
 #define ACPI_GEBS_UNCORRECTABLE         1
@@ -189,6 +191,94 @@ static void acpi_ghes_build_append_mem_cper(GArray *table,
     build_append_int_noprefix(table, 0, 7);
 }
 
+/* UEFI 2.9: N.2.4.4 ARM Processor Error Section */
+static void acpi_ghes_build_append_arm_cper(uint8_t error_types, GArray *table)
+{
+    /*
+     * ARM Processor Error Record
+     */
+
+    /* Validation Bits */
+    build_append_int_noprefix(table,
+                              (1ULL << 3) | /* Vendor specific info Valid */
+                              (1ULL << 2) | /* Running status Valid */
+                              (1ULL << 1) | /* Error affinity level Valid */
+                              (1ULL << 0), /* MPIDR Valid */
+                              4);
+    /* Error Info Num */
+    build_append_int_noprefix(table, 1, 2);
+    /* Context Info Num */
+    build_append_int_noprefix(table, 1, 2);
+    /* Section length */
+    build_append_int_noprefix(table, ACPI_GHES_ARM_CPER_LENGTH, 4);
+    /* Error affinity level */
+    build_append_int_noprefix(table, 2, 1);
+    /* Reserved */
+    build_append_int_noprefix(table, 0, 3);
+    /* MPIDR_EL1 */
+    build_append_int_noprefix(table, 0xAB12, 8);
+    /* MIDR_EL1 */
+    build_append_int_noprefix(table, 0xCD24, 8);
+    /* Running state */
+    build_append_int_noprefix(table, 0x1, 4);
+    /* PSCI state */
+    build_append_int_noprefix(table, 0x1234, 4);
+
+    /* ARM Propcessor error information */
+    /* Version */
+    build_append_int_noprefix(table, 0, 1);
+    /*  Length */
+    build_append_int_noprefix(table, 32, 1);
+    /* Validation Bits */
+    build_append_int_noprefix(table,
+                              (1ULL << 4) | /* Physical fault address Valid */
+                             (1ULL << 3) | /* Virtual fault address Valid */
+                             (1ULL << 2) | /* Error information Valid */
+                              (1ULL << 1) | /* Flags Valid */
+                              (1ULL << 0), /* Multiple error count Valid */
+                              2);
+    /* Type */
+    if (error_types & BIT(ARM_PROCESSOR_ERROR_TYPE_CACHE_ERROR) ||
+        error_types & BIT(ARM_PROCESSOR_ERROR_TYPE_TLB_ERROR) ||
+        error_types & BIT(ARM_PROCESSOR_ERROR_TYPE_BUS_ERROR) ||
+        error_types & BIT(ARM_PROCESSOR_ERROR_TYPE_MICRO_ARCH_ERROR)) {
+        build_append_int_noprefix(table, error_types, 1);
+    } else {
+        return;
+    }
+    /* Multiple error count */
+    build_append_int_noprefix(table, 2, 2);
+    /* Flags  */
+    build_append_int_noprefix(table, 0xD, 1);
+    /* Error information  */
+    if (error_types & BIT(ARM_PROCESSOR_ERROR_TYPE_CACHE_ERROR)) {
+        build_append_int_noprefix(table, 0x0091000F, 8);
+    } else if (error_types & BIT(ARM_PROCESSOR_ERROR_TYPE_TLB_ERROR)) {
+        build_append_int_noprefix(table, 0x0054007F, 8);
+    } else if (error_types & BIT(ARM_PROCESSOR_ERROR_TYPE_BUS_ERROR)) {
+        build_append_int_noprefix(table, 0x80D6460FFF, 8);
+    } else if (error_types & BIT(ARM_PROCESSOR_ERROR_TYPE_MICRO_ARCH_ERROR)) {
+        build_append_int_noprefix(table, 0x78DA03FF, 8);
+    } else {
+        return;
+    }
+    /* Virtual fault address  */
+    build_append_int_noprefix(table, 0x67320230, 8);
+    /* Physical fault address  */
+    build_append_int_noprefix(table, 0x5CDFD492, 8);
+
+    /* ARM Propcessor error context information */
+    /* Version */
+    build_append_int_noprefix(table, 0, 2);
+    /* Validation Bits */
+    /* AArch64 EL1 context registers Valid */
+    build_append_int_noprefix(table, 5, 2);
+    /* Register array size */
+    build_append_int_noprefix(table, 592, 4);
+    /* Register array */
+    build_append_int_noprefix(table, 0x12ABDE67, 8);
+}
+
 static void build_append_aer_cper(PCIDevice *dev, GArray *table)
 {
     PCIDeviceClass *pci_class = PCI_DEVICE_GET_CLASS(dev);
@@ -468,7 +558,8 @@ static int acpi_ghes_record_mem_error(uint64_t error_block_address,
           UUID_LE(0xA5BC1114, 0x6F64, 0x4EDE, 0xB8, 0x63, 0x3E, 0x83, \
                   0xED, 0x7C, 0x83, 0xB1);
 
-    /* invalid fru id: ACPI 4.0: 17.3.2.6.1 Generic Error Data,
+    /*
+     * Invalid fru id: ACPI 4.0: 17.3.2.6.1 Generic Error Data,
      * Table 17-13 Generic Error Data Entry
      */
     QemuUUID fru_id = {};
@@ -505,6 +596,54 @@ static int acpi_ghes_record_mem_error(uint64_t error_block_address,
     return 0;
 }
 
+static int acpi_ghes_record_arm_error(uint8_t error_types,
+                                      uint64_t error_block_address)
+{
+    GArray *block;
+
+    /* Memory Error Section Type */
+    const uint8_t uefi_cper_arm_sec[] =
+          UUID_LE(0xE19E3D16, 0xBC11, 0x11E4, 0x9C, 0xAA, 0xC2, 0x05, \
+                  0x1D, 0x5D, 0x46, 0xB0);
+
+    /*
+     * Invalid fru id: ACPI 4.0: 17.3.2.6.1 Generic Error Data,
+     * Table 17-13 Generic Error Data Entry
+     */
+    QemuUUID fru_id = {};
+    uint32_t data_length;
+
+    block = g_array_new(false, true /* clear */, 1);
+
+    /* This is the length if adding a new generic error data entry*/
+    data_length = ACPI_GHES_DATA_LENGTH + ACPI_GHES_ARM_CPER_LENGTH;
+    /*
+     * It should not run out of the preallocated memory if adding a new generic
+     * error data entry
+     */
+    assert((data_length + ACPI_GHES_GESB_SIZE) <=
+            ACPI_GHES_MAX_RAW_DATA_LENGTH);
+
+    /* Build the new generic error status block header */
+    acpi_ghes_generic_error_status(block, ACPI_GEBS_UNCORRECTABLE,
+        0, 0, data_length, ACPI_CPER_SEV_RECOVERABLE);
+
+    /* Build this new generic error data entry header */
+    acpi_ghes_generic_error_data(block, uefi_cper_arm_sec,
+        ACPI_CPER_SEV_RECOVERABLE, 0, 0,
+        ACPI_GHES_ARM_CPER_LENGTH, fru_id, 0);
+
+    /* Build the ARM processor error section CPER */
+    acpi_ghes_build_append_arm_cper(error_types, block);
+
+    /* Write the generic error data entry into guest memory */
+    cpu_physical_memory_write(error_block_address, block->data, block->len);
+
+    g_array_free(block, true);
+
+    return 0;
+}
+
 static int ghes_record_aer_error(PCIDevice *dev, uint64_t error_block_address)
 {
     const uint8_t aer_section_id_le[] = {
@@ -917,6 +1056,35 @@ static bool ghes_get_addr(uint32_t notify, uint64_t *error_block_addr,
     return true;
 }
 
+bool ghes_record_arm_errors(uint8_t error_types, uint32_t notify)
+{
+    int read_ack_register = 0;
+    uint64_t read_ack_register_addr = 0;
+    uint64_t error_block_addr = 0;
+
+    if (!ghes_get_addr(notify, &error_block_addr, &read_ack_register_addr)) {
+        return false;
+    }
+
+    cpu_physical_memory_read(read_ack_register_addr,
+                             &read_ack_register, sizeof(uint64_t));
+    /* zero means OSPM does not acknowledge the error */
+    if (!read_ack_register) {
+        error_report("Last time OSPM does not acknowledge the error,"
+                     " record CPER failed this time, set the ack value to"
+                     " avoid blocking next time CPER record! exit");
+        read_ack_register = 1;
+        cpu_physical_memory_write(read_ack_register_addr,
+                                  &read_ack_register, sizeof(uint64_t));
+        return false;
+    }
+
+    read_ack_register = cpu_to_le64(0);
+    cpu_physical_memory_write(read_ack_register_addr,
+                              &read_ack_register, sizeof(uint64_t));
+    return acpi_ghes_record_arm_error(error_types, error_block_addr);
+}
+
 bool ghes_record_aer_errors(PCIDevice *dev, uint32_t notify)
 {
     int read_ack_register = 0;
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 176c407555..dd2e55f918 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -719,3 +719,7 @@ config ARMSSE
     select UNIMP
     select SSE_COUNTER
     select SSE_TIMER
+
+config CXL_ARM_EINJ
+    bool
+    default y if AARCH64
diff --git a/hw/arm/arm_error_inject.c b/hw/arm/arm_error_inject.c
new file mode 100644
index 0000000000..953a9d6705
--- /dev/null
+++ b/hw/arm/arm_error_inject.c
@@ -0,0 +1,49 @@
+/*
+ * CXL Type 3 (memory expander) device
+ *
+ * Copyright(C) 2020 Intel Corporation.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2. See the
+ * COPYING file in the top-level directory.
+ *
+ * SPDX-License-Identifier: GPL-v2-only
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qemu/error-report.h"
+#include "qapi-commands-arm-error-inject.h"
+#include "hw/qdev-properties.h"
+#include "qapi/error.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/pmem.h"
+#include "qemu/range.h"
+#include "qemu/rcu.h"
+#include "qemu/guest-random.h"
+#include "sysemu/hostmem.h"
+#include "sysemu/numa.h"
+#include "hw/boards.h"
+#include "hw/acpi/ghes.h"
+
+#define DWORD_BYTE 4
+
+/* For ARM processor errors */
+void qmp_arm_inject_error(ArmProcessorErrorTypeList *errortypes, Error **errp)
+{
+    MachineState *machine = MACHINE(qdev_get_machine());
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
+    uint8_t error_types = 0;
+
+    while (errortypes) {
+        error_types |= BIT(errortypes->value);
+        errortypes = errortypes->next;
+    }
+
+    ghes_record_arm_errors(error_types, ACPI_GHES_NOTIFY_GPIO);
+    if (mc->set_error) {
+        mc->set_error();
+    }
+
+    return;
+}
diff --git a/hw/arm/arm_error_inject_stubs.c b/hw/arm/arm_error_inject_stubs.c
new file mode 100644
index 0000000000..b34d336867
--- /dev/null
+++ b/hw/arm/arm_error_inject_stubs.c
@@ -0,0 +1,19 @@
+/*
+ * ARM  Processor errors QMP stubs
+ *
+ * Copyright(C) 2024 Huawei LTD.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2. See the
+ * COPYING file in the top-level directory.
+ *
+ * SPDX-License-Identifier: GPL-v2-only
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-arm-error-inject.h"
+
+void qmp_arm_inject_error(ArmProcessorErrorType type, Error **errp)
+{
+    error_setg(errp, "ARM processor error support is not compiled in");
+}
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 6808135c1f..03a2385fd3 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -59,6 +59,8 @@ arm_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
 arm_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
 arm_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
 arm_ss.add(when: 'CONFIG_XEN', if_true: files('xen_arm.c'))
+arm_ss.add(when: 'CONFIG_ARM_EINJ', if_true: files('arm_error_inject.c'))
+arm_ss.add(when: 'CONFIG_ARM_EINJ', if_false: files('arm_error_inject_stubs.c'))
 
 system_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmu-common.c'))
 system_ss.add(when: 'CONFIG_CHEETAH', if_true: files('palm.c'))
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 171c3e9dad..c2b507cdf1 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -78,6 +78,7 @@ int acpi_ghes_record_errors(uint8_t notify, uint64_t error_physical_addr);
 
 typedef struct PCIDevice PCIDevice;
 bool ghes_record_aer_errors(PCIDevice *dev, uint32_t notify);
+bool ghes_record_arm_errors(uint8_t type, uint32_t notify);
 
 typedef struct CXLError CXLError;
 bool ghes_record_cxl_errors(PCIDevice *dev, PCIEAERErr *err,
diff --git a/qapi/arm-error-inject.json b/qapi/arm-error-inject.json
new file mode 100644
index 0000000000..ccd94d2987
--- /dev/null
+++ b/qapi/arm-error-inject.json
@@ -0,0 +1,44 @@
+# -*- Mode: Python -*-
+# vim: filetype=python
+
+##
+# = ARM Processor Errors
+##
+
+##
+# @ArmProcessorErrorType:
+#
+# Type of ARM processor error to inject
+#
+# @unknown-error: Unknown error
+#
+# @cache-error: Cache error
+#
+# @tlb-error: TLB error
+#
+# @bus-error: Bus error.
+#
+# @micro-arch-error: Micro architectural error.
+#
+# Since: 8.0
+##
+{ 'enum': 'ArmProcessorErrorType',
+  'data': ['unknown-error',
+	   'cache-error',
+           'tlb-error',
+           'bus-error',
+           'micro-arch-error']
+}
+
+##
+# @arm-inject-error:
+#
+# Inject ARM Processor error.
+#
+# @errortypes: ARM processor error types to inject
+#
+# Since: 8.1
+##
+{ 'command': 'arm-inject-error',
+  'data': { 'errortypes': ['ArmProcessorErrorType'] }
+}
diff --git a/qapi/meson.build b/qapi/meson.build
index 375d564277..f0f6198da6 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -22,6 +22,7 @@ if have_system or have_tools or have_ga
 endif
 
 qapi_all_modules = [
+  'arm-error-inject',
   'authz',
   'block',
   'block-core',
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 8304d45625..e8ac20d75a 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -81,3 +81,4 @@
 { 'include': 'virtio.json' }
 { 'include': 'cryptodev.json' }
 { 'include': 'cxl.json' }
+{ 'include': 'arm-error-inject.json' }
-- 
2.34.1


