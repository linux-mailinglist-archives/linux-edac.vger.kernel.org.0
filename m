Return-Path: <linux-edac+bounces-1510-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DF892FB01
	for <lists+linux-edac@lfdr.de>; Fri, 12 Jul 2024 15:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C918CB22745
	for <lists+linux-edac@lfdr.de>; Fri, 12 Jul 2024 13:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6E2171075;
	Fri, 12 Jul 2024 13:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFkd4JS6"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955AE170855;
	Fri, 12 Jul 2024 13:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720790122; cv=none; b=X2BLLHZ1L62uyalLfQYZ7aSX7/ywsDVypnFDmtLehMXFYwEEA1lh8gIxkCwbOjB/Xx1brHWAffy8bz2QV+MXu/AkQoLB5X88fzXl23qMhgu2BBat+IPwpsvGGXjPVJmo7ALb6kEYrZWd2B9ywg2wEkJH06lgbQvdB/1+b5y+nlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720790122; c=relaxed/simple;
	bh=yjdVpMd5ozOqshPdRctXbXJ90enrbC9UDU0HeS1DIBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxfsxXVb6Z2L6swvpTnFNMCL5VDOyANHDOSfb3aMur/H2rsR/JjYS6EAcC/45uOvqKVJ/cWY7ir8QfUVU0TbFy1xhY4cxJilbK3FcL/Wf2VAM2N9sWA6rXBi7tmgyPaKXYklXqmB8yJaoXVm/nIvQgkLcveUPP3dMIE8OI8zz9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vFkd4JS6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CFB0C4AF0B;
	Fri, 12 Jul 2024 13:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720790122;
	bh=yjdVpMd5ozOqshPdRctXbXJ90enrbC9UDU0HeS1DIBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vFkd4JS6mSgTM2kI+Gq4+VJFd18DVAzhpjmZHNpTTMN9sT49IEf+6hS+Nw1kZWEpC
	 nQoazMn4oKIQNeVmZgBVhgSf2FHXtuMmDsh8v8ASgGml94uEpp/7qKOFTynw1KROLz
	 Re0m7EwhBM5g5evGf2Enn2w1efniwuh2Q+YF69WkbC8PqKtnuBSde1Oyvl37NiwaGk
	 KdqbaU25GgP6dK/FwacWC4N2JR42dgpldmb6LBxgTHb8nYpIxV1nRLObzN/FSFZpBV
	 OuFrTZ8/lDuzcXbFjFD7afsOLx7yQL0qaXus3DcDq68NdvWp91km0FmaPDLxPV700+
	 7TzN6ehaXb0Ew==
Received: from mchehab by mail.kernel.org with local (Exim 4.97.1)
	(envelope-from <mchehab@kernel.org>)
	id 1sSG7K-00000003iE9-1OBn;
	Fri, 12 Jul 2024 15:15:18 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"Shiju Jose" <shiju.jose@huawei.com>,
	Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>,
	Eric Blake <eblake@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Michael Roth <michael.roth@amd.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH v2 4/7] acpi/ghes: Add a logic to handle block addresses and FW first ARM processor error injection
Date: Fri, 12 Jul 2024 15:15:11 +0200
Message-ID: <75c58d17a14b2c3dabcde790e0bdfbdbf8909025.1720789922.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720789921.git.mchehab+huawei@kernel.org>
References: <cover.1720789921.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

1. Some GHES functions require handling addresses. Add a helper function
   to support it.

2. Add support for ACPI CPER (firmware-first) ARM processor error injection.

Compliance with N.2.4.4 ARM Processor Error Section in UEFI 2.6 and
upper specs, using error type bit encoding as detailed at UEFI 2.9A
errata.

Error injection examples:

{ "execute": "qmp_capabilities" }

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
...

Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Co-authored-by: Shiju Jose <shiju.jose@huawei.com>
For Add a logic to handle block addresses,
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
For FW first ARM processor error injection,
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 configs/targets/aarch64-softmmu.mak |   1 +
 hw/acpi/ghes.c                      | 258 ++++++++++++++++++++++++++--
 hw/arm/Kconfig                      |   4 +
 hw/arm/arm_error_inject.c           |  35 ++++
 hw/arm/arm_error_inject_stubs.c     |  18 ++
 hw/arm/meson.build                  |   3 +
 include/hw/acpi/ghes.h              |   2 +
 qapi/arm-error-inject.json          |  49 ++++++
 qapi/meson.build                    |   1 +
 qapi/qapi-schema.json               |   1 +
 10 files changed, 361 insertions(+), 11 deletions(-)
 create mode 100644 hw/arm/arm_error_inject.c
 create mode 100644 hw/arm/arm_error_inject_stubs.c
 create mode 100644 qapi/arm-error-inject.json

diff --git a/configs/targets/aarch64-softmmu.mak b/configs/targets/aarch64-softmmu.mak
index 84cb32dc2f4f..b4b3cd97934a 100644
--- a/configs/targets/aarch64-softmmu.mak
+++ b/configs/targets/aarch64-softmmu.mak
@@ -5,3 +5,4 @@ TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-vfp-sysregs.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml gdb-xml/arm-m-profile-mve.xml gdb-xml/aarch64-pauth.xml
 # needed by boot.c
 TARGET_NEED_FDT=y
+CONFIG_ARM_EINJ=y
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 5b8bc6eeb437..6075ef5893ce 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -27,6 +27,7 @@
 #include "hw/acpi/generic_event_device.h"
 #include "hw/nvram/fw_cfg.h"
 #include "qemu/uuid.h"
+#include "qapi/qapi-types-arm-error-inject.h"
 
 #define ACPI_GHES_ERRORS_FW_CFG_FILE        "etc/hardware_errors"
 #define ACPI_GHES_DATA_ADDR_FW_CFG_FILE     "etc/hardware_errors_addr"
@@ -53,6 +54,12 @@
 /* The memory section CPER size, UEFI 2.6: N.2.5 Memory Error Section */
 #define ACPI_GHES_MEM_CPER_LENGTH           80
 
+/*
+ * ARM Processor section CPER size, UEFI 2.10: N.2.4.4
+ * ARM Processor Error Section
+ */
+#define ACPI_GHES_ARM_CPER_LENGTH (72 + 600)
+
 /* Masks for block_status flags */
 #define ACPI_GEBS_UNCORRECTABLE         1
 
@@ -231,6 +238,142 @@ static int acpi_ghes_record_mem_error(uint64_t error_block_address,
     return 0;
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
+static int acpi_ghes_record_arm_error(uint8_t error_types,
+                                      uint64_t error_block_address)
+{
+    GArray *block;
+
+    /* ARM processor Error Section Type */
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
 /*
  * Build table for the hardware error fw_cfg blob.
  * Initialize "etc/hardware_errors" and "etc/hardware_errors_addr" fw_cfg blobs.
@@ -392,23 +535,22 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
     ags->present = true;
 }
 
+static uint64_t ghes_get_state_start_address(void)
+{
+    AcpiGedState *acpi_ged_state =
+        ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED, NULL));
+    AcpiGhesState *ags = &acpi_ged_state->ghes_state;
+
+    return le64_to_cpu(ags->ghes_addr_le);
+}
+
 int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
 {
     uint64_t error_block_addr, read_ack_register_addr, read_ack_register = 0;
-    uint64_t start_addr;
+    uint64_t start_addr = ghes_get_state_start_address();
     bool ret = -1;
-    AcpiGedState *acpi_ged_state;
-    AcpiGhesState *ags;
-
     assert(source_id < ACPI_HEST_SRC_ID_RESERVED);
 
-    acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
-                                                       NULL));
-    g_assert(acpi_ged_state);
-    ags = &acpi_ged_state->ghes_state;
-
-    start_addr = le64_to_cpu(ags->ghes_addr_le);
-
     if (physical_address) {
 
         if (source_id < ACPI_HEST_SRC_ID_RESERVED) {
@@ -448,6 +590,100 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
     return ret;
 }
 
+/*
+ * Error register block data layout
+ *
+ * | +---------------------+ ges.ghes_addr_le
+ * | |error_block_address0 |
+ * | +---------------------+
+ * | |error_block_address1 |
+ * | +---------------------+ --+--
+ * | |    .............    | GHES_ADDRESS_SIZE
+ * | +---------------------+ --+--
+ * | |error_block_addressN |
+ * | +---------------------+
+ * | | read_ack_register0  |
+ * | +---------------------+ --+--
+ * | | read_ack_register1  | GHES_ADDRESS_SIZE
+ * | +---------------------+ --+--
+ * | |   .............     |
+ * | +---------------------+
+ * | | read_ack_registerN  |
+ * | +---------------------+ --+--
+ * | |      CPER           |   |
+ * | |      ....           | GHES_MAX_RAW_DATA_LENGT
+ * | |      CPER           |   |
+ * | +---------------------+ --+--
+ * | |    ..........       |
+ * | +---------------------+
+ * | |      CPER           |
+ * | |      ....           |
+ * | |      CPER           |
+ * | +---------------------+
+ */
+
+/* Map from uint32_t notify to entry offset in GHES */
+static const uint8_t error_source_to_index[] = { 0xff, 0xff, 0xff, 0xff,
+                                                 0xff, 0xff, 0xff, 1, 0};
+
+static bool ghes_get_addr(uint32_t notify, uint64_t *error_block_addr,
+                          uint64_t *read_ack_register_addr)
+{
+    uint64_t base;
+
+    if (notify >= ACPI_GHES_NOTIFY_RESERVED) {
+        return false;
+    }
+
+    /* Find and check the source id for this new CPER */
+    if (error_source_to_index[notify] == 0xff) {
+        return false;
+    }
+
+    base = ghes_get_state_start_address();
+
+    *read_ack_register_addr = base +
+        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
+        error_source_to_index[notify] * sizeof(uint64_t);
+
+    /* Could also be read back from the error_block_address register */
+    *error_block_addr = base +
+        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
+        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
+        error_source_to_index[notify] * ACPI_GHES_MAX_RAW_DATA_LENGTH;
+
+    return true;
+}
+
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
 bool acpi_ghes_present(void)
 {
     AcpiGedState *acpi_ged_state;
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 1ad60da7aa2d..bafac82f9fd3 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -712,3 +712,7 @@ config ARMSSE
     select UNIMP
     select SSE_COUNTER
     select SSE_TIMER
+
+config ARM_EINJ
+    bool
+    default y if AARCH64
diff --git a/hw/arm/arm_error_inject.c b/hw/arm/arm_error_inject.c
new file mode 100644
index 000000000000..1da97d5d4fdc
--- /dev/null
+++ b/hw/arm/arm_error_inject.c
@@ -0,0 +1,35 @@
+/*
+ * ARM Processor error injection
+ *
+ * Copyright(C) 2024 Huawei LTD.
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi-commands-arm-error-inject.h"
+#include "hw/boards.h"
+#include "hw/acpi/ghes.h"
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
index 000000000000..b51f4202fe64
--- /dev/null
+++ b/hw/arm/arm_error_inject_stubs.c
@@ -0,0 +1,18 @@
+/*
+ * QMP stub for ARM processor error injection.
+ *
+ * Copyright(C) 2024 Huawei LTD.
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi-commands-arm-error-inject.h"
+
+void qmp_arm_inject_error(ArmProcessorErrorTypeList *errortypes, Error **errp)
+{
+    error_setg(errp, "ARM processor error support is not compiled in");
+}
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 0c07ab522f4c..cb7fe09fc87b 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -60,6 +60,7 @@ arm_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
 arm_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
 arm_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
 arm_ss.add(when: 'CONFIG_XEN', if_true: files('xen_arm.c'))
+arm_ss.add(when: 'CONFIG_ARM_EINJ', if_true: files('arm_error_inject.c'))
 
 system_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmu-common.c'))
 system_ss.add(when: 'CONFIG_CHEETAH', if_true: files('palm.c'))
@@ -77,5 +78,7 @@ system_ss.add(when: 'CONFIG_TOSA', if_true: files('tosa.c'))
 system_ss.add(when: 'CONFIG_VERSATILE', if_true: files('versatilepb.c'))
 system_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
 system_ss.add(when: 'CONFIG_Z2', if_true: files('z2.c'))
+system_ss.add(when: 'CONFIG_ARM_EINJ', if_false: files('arm_error_inject_stubs.c'))
+system_ss.add(when: 'CONFIG_ALL', if_true: files('arm_error_inject_stubs.c'))
 
 hw_arch += {'arm': arm_ss}
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 4f1ab1a73a06..dc531ffce7ae 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -75,6 +75,8 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
                           GArray *hardware_errors);
 int acpi_ghes_record_errors(uint8_t notify, uint64_t error_physical_addr);
 
+bool ghes_record_arm_errors(uint8_t error_types, uint32_t notify);
+
 /**
  * acpi_ghes_present: Report whether ACPI GHES table is present
  *
diff --git a/qapi/arm-error-inject.json b/qapi/arm-error-inject.json
new file mode 100644
index 000000000000..430e6cea6b60
--- /dev/null
+++ b/qapi/arm-error-inject.json
@@ -0,0 +1,49 @@
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
+# Since: 9.1
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
+# Features:
+#
+# @unstable: This command is experimental.
+#
+# Since: 9.1
+##
+{ 'command': 'arm-inject-error',
+  'data': { 'errortypes': ['ArmProcessorErrorType'] },
+  'features': [ 'unstable' ]
+}
diff --git a/qapi/meson.build b/qapi/meson.build
index e7bc54e5d047..5927932c4be3 100644
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
index b1581988e4eb..479a22de7e43 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -81,3 +81,4 @@
 { 'include': 'vfio.json' }
 { 'include': 'cryptodev.json' }
 { 'include': 'cxl.json' }
+{ 'include': 'arm-error-inject.json' }
-- 
2.45.2


