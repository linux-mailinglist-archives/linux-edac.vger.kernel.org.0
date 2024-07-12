Return-Path: <linux-edac+bounces-1514-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5489792FB0B
	for <lists+linux-edac@lfdr.de>; Fri, 12 Jul 2024 15:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75E0D1C223F2
	for <lists+linux-edac@lfdr.de>; Fri, 12 Jul 2024 13:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF8B172762;
	Fri, 12 Jul 2024 13:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBmNpTdz"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D907B171E6A;
	Fri, 12 Jul 2024 13:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720790124; cv=none; b=iAfkQjLVhECsFUGAQtj+PUyCV0627x9MFSf4mAXBPYkvXEiC/JF7afTFQGf9TzUooGWZrXR9v7gVxyZUk4nV6q/rrhTlLaAHiEtjkGwCDiY2ojt3iVlM8BPQgZF6p0llGrBT7n2KY4D4gJNOlP77lcvYT5qTm8uBC2eXveA7jQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720790124; c=relaxed/simple;
	bh=Ybf7OUJPfmsnLr0J4zNeX89cSaIch9LE7Gl5bnjIZWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bVDWIw2fN4uXFXNGTjkI1vdLfVTw0GjqvWjCgH6pwh4woQdFvc9ywnj1ZZWpmcaCBC08IjiT8R67qw/eEqGQPBeOmKinT4dQGaEakemui0KzSU/dDh6Bl1oRHzMm0YF+ztECBLOOfkqZQ8Ehp3oSPpM804kkQgVuKEs4De0JTp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBmNpTdz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E84C32786;
	Fri, 12 Jul 2024 13:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720790124;
	bh=Ybf7OUJPfmsnLr0J4zNeX89cSaIch9LE7Gl5bnjIZWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jBmNpTdzZPZK0UwtFCXisX4NZTnOauztUc8vw3vmtb9eHvDgearmUahTQbpxqRKFj
	 AtylDSLofXGo4XGZ7iJUWrSkoWGtsYZd01DxUVgMosgGa3QiDyu0gMPWsIFoL8tzh1
	 hfVQJYeDHbbXEuQnhv5lGO5vXyAG4SpiIR7rtkEyLlcjyfdJUfHHtgdI1/lMMHDc1S
	 RphnBMsILjCIsj6hj95/dZOxhgy3/SEF4n4xGhOoCJ3q0jrRw4WSQa9C3XH4X1NkE4
	 02pc2QUCGbauyADL5uADVg+ID4MmIDo0M17CUvR9/EO9a7z/3/6/9/PC4cmj7U9Rn8
	 kRKIfr6x58vsg==
Received: from mchehab by mail.kernel.org with local (Exim 4.97.1)
	(envelope-from <mchehab@kernel.org>)
	id 1sSG7K-00000003iEL-1jI8;
	Fri, 12 Jul 2024 15:15:18 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	"Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	"Shiju Jose" <shiju.jose@huawei.com>,
	Ani Sinha <anisinha@redhat.com>,
	Beraldo Leal <bleal@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>,
	Eric Blake <eblake@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Thomas Huth <thuth@redhat.com>,
	Wainer dos Santos Moschetta <wainersm@redhat.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 7/7] acpi/ghes: extend arm error injection logic
Date: Fri, 12 Jul 2024 15:15:14 +0200
Message-ID: <8e054d0eb8702ec340eb77e4ccfdd4e80c24a822.1720789922.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720789921.git.mchehab+huawei@kernel.org>
References: <cover.1720789921.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

Enrich CPER error injection logic for ARM processor to allow
setting values to  from UEFI 2.10 tables N.16 and N.17.

It should be noticed that, with such change, all arguments are
now optional, so, once QMP is negotiated with:

	{ "execute": "qmp_capabilities" }

the simplest way to generate a cache error is to use:

	{ "execute": "arm-inject-error" }

Also, as now PEI is mapped into an array, it is possible to
inject multiple errors at the same CPER record with:

	{ "execute": "arm-inject-error", "arguments": {
	   "error": [ {"type": [ "cache-error" ]},
		      {"type": [ "tlb-error" ]} ] } }

This would generate both cache and TLB errors, using default
values for other fields.

As all fields from ARM Processor CPER are now mapped, all
types of CPER records can be generated with the new QAPI.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/ghes.c                  | 168 +++++++-------
 hw/arm/arm_error_inject.c       | 399 +++++++++++++++++++++++++++++++-
 hw/arm/arm_error_inject_stubs.c |  20 +-
 include/hw/acpi/ghes.h          |  40 +++-
 qapi/arm-error-inject.json      | 250 +++++++++++++++++++-
 tests/lcitool/libvirt-ci        |   2 +-
 6 files changed, 778 insertions(+), 101 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index ebf1b812aaaa..afd1d098a7e3 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -55,10 +55,10 @@
 #define ACPI_GHES_MEM_CPER_LENGTH           80
 
 /*
- * ARM Processor section CPER size, UEFI 2.10: N.2.4.4
- * ARM Processor Error Section
+ * ARM Processor error section CPER sizes - UEFI 2.10: N.2.4.4
  */
-#define ACPI_GHES_ARM_CPER_LENGTH (72 + 600)
+#define ACPI_GHES_ARM_CPER_LENGTH           40
+#define ACPI_GHES_ARM_CPER_PEI_LENGTH       32
 
 /* Masks for block_status flags */
 #define ACPI_GEBS_UNCORRECTABLE         1
@@ -242,94 +242,98 @@ static int acpi_ghes_record_mem_error(uint64_t error_block_address,
 }
 
 /* UEFI 2.9: N.2.4.4 ARM Processor Error Section */
-static void acpi_ghes_build_append_arm_cper(uint8_t error_types, GArray *table)
+static void acpi_ghes_build_append_arm_cper(ArmError err, uint32_t cper_length,
+                                            GArray *table)
 {
+    unsigned int i, j;
+
     /*
      * ARM Processor Error Record
      */
 
     /* Validation Bits */
-    build_append_int_noprefix(table,
-                              (1ULL << 3) | /* Vendor specific info Valid */
-                              (1ULL << 2) | /* Running status Valid */
-                              (1ULL << 1) | /* Error affinity level Valid */
-                              (1ULL << 0), /* MPIDR Valid */
-                              4);
+    build_append_int_noprefix(table, err.validation, 4);
+
     /* Error Info Num */
-    build_append_int_noprefix(table, 1, 2);
+    build_append_int_noprefix(table, err.err_info_num, 2);
+
     /* Context Info Num */
-    build_append_int_noprefix(table, 1, 2);
+    build_append_int_noprefix(table, err.context_info_num, 2);
+
     /* Section length */
-    build_append_int_noprefix(table, ACPI_GHES_ARM_CPER_LENGTH, 4);
+    build_append_int_noprefix(table, cper_length, 4);
+
     /* Error affinity level */
-    build_append_int_noprefix(table, 2, 1);
+    build_append_int_noprefix(table, err.affinity_level, 1);
+
     /* Reserved */
     build_append_int_noprefix(table, 0, 3);
+
     /* MPIDR_EL1 */
-    build_append_int_noprefix(table, 0xAB12, 8);
+    build_append_int_noprefix(table, err.mpidr_el1, 8);
+
     /* MIDR_EL1 */
-    build_append_int_noprefix(table, 0xCD24, 8);
+    build_append_int_noprefix(table, err.midr_el1, 8);
+
     /* Running state */
-    build_append_int_noprefix(table, 0x1, 4);
-    /* PSCI state */
-    build_append_int_noprefix(table, 0x1234, 4);
-
-    /* ARM Propcessor error information */
-    /* Version */
-    build_append_int_noprefix(table, 0, 1);
-    /*  Length */
-    build_append_int_noprefix(table, 32, 1);
-    /* Validation Bits */
-    build_append_int_noprefix(table,
-                              (1ULL << 4) | /* Physical fault address Valid */
-                             (1ULL << 3) | /* Virtual fault address Valid */
-                             (1ULL << 2) | /* Error information Valid */
-                              (1ULL << 1) | /* Flags Valid */
-                              (1ULL << 0), /* Multiple error count Valid */
-                              2);
-    /* Type */
-    if (error_types & BIT(ARM_PROCESSOR_ERROR_TYPE_CACHE_ERROR) ||
-        error_types & BIT(ARM_PROCESSOR_ERROR_TYPE_TLB_ERROR) ||
-        error_types & BIT(ARM_PROCESSOR_ERROR_TYPE_BUS_ERROR) ||
-        error_types & BIT(ARM_PROCESSOR_ERROR_TYPE_MICRO_ARCH_ERROR)) {
-        build_append_int_noprefix(table, error_types, 1);
-    } else {
-        return;
+    build_append_int_noprefix(table, err.running_state, 4);
+
+    /* PSCI state: only valid when running state is zero  */
+    build_append_int_noprefix(table, err.psci_state, 4);
+
+    for (i = 0; i < err.err_info_num; i++) {
+        /* ARM Propcessor error information */
+        /* Version */
+        build_append_int_noprefix(table, 0, 1);
+
+        /*  Length */
+        build_append_int_noprefix(table, ACPI_GHES_ARM_CPER_PEI_LENGTH, 1);
+
+        /* Validation Bits */
+        build_append_int_noprefix(table, err.pei[i].validation, 2);
+
+        /* Type */
+        build_append_int_noprefix(table, err.pei[i].type, 1);
+
+        /* Multiple error count */
+        build_append_int_noprefix(table, err.pei[i].multiple_error, 2);
+
+        /* Flags  */
+        build_append_int_noprefix(table, err.pei[i].flags, 1);
+
+        /* Error information  */
+        build_append_int_noprefix(table, err.pei[i].error_info, 8);
+
+        /* Virtual fault address  */
+        build_append_int_noprefix(table, err.pei[i].virt_addr, 8);
+
+        /* Physical fault address  */
+        build_append_int_noprefix(table, err.pei[i].phy_addr, 8);
+    }
+
+    for (i = 0; i < err.context_info_num; i++) {
+        /* ARM Propcessor error context information */
+        /* Version */
+        build_append_int_noprefix(table, 0, 2);
+
+        /* Validation type */
+        build_append_int_noprefix(table, err.context[i].type, 2);
+
+        /* Register array size */
+        build_append_int_noprefix(table, err.context[i].size * 8, 4);
+
+        /* Register array (byte 8 of Context info) */
+        for (j = 0; j < err.context[i].size; j++) {
+            build_append_int_noprefix(table, err.context[i].array[j], 8);
+        }
     }
-    /* Multiple error count */
-    build_append_int_noprefix(table, 2, 2);
-    /* Flags  */
-    build_append_int_noprefix(table, 0xD, 1);
-    /* Error information  */
-    if (error_types & BIT(ARM_PROCESSOR_ERROR_TYPE_CACHE_ERROR)) {
-        build_append_int_noprefix(table, 0x0091000F, 8);
-    } else if (error_types & BIT(ARM_PROCESSOR_ERROR_TYPE_TLB_ERROR)) {
-        build_append_int_noprefix(table, 0x0054007F, 8);
-    } else if (error_types & BIT(ARM_PROCESSOR_ERROR_TYPE_BUS_ERROR)) {
-        build_append_int_noprefix(table, 0x80D6460FFF, 8);
-    } else if (error_types & BIT(ARM_PROCESSOR_ERROR_TYPE_MICRO_ARCH_ERROR)) {
-        build_append_int_noprefix(table, 0x78DA03FF, 8);
-    } else {
-        return;
+
+    for (i = 0; i < err.vendor_num; i++) {
+        build_append_int_noprefix(table, err.vendor[i], 1);
     }
-    /* Virtual fault address  */
-    build_append_int_noprefix(table, 0x67320230, 8);
-    /* Physical fault address  */
-    build_append_int_noprefix(table, 0x5CDFD492, 8);
-
-    /* ARM Propcessor error context information */
-    /* Version */
-    build_append_int_noprefix(table, 0, 2);
-    /* Validation Bits */
-    /* AArch64 EL1 context registers Valid */
-    build_append_int_noprefix(table, 5, 2);
-    /* Register array size */
-    build_append_int_noprefix(table, 592, 4);
-    /* Register array */
-    build_append_int_noprefix(table, 0x12ABDE67, 8);
 }
 
-static int acpi_ghes_record_arm_error(uint8_t error_types,
+static int acpi_ghes_record_arm_error(ArmError error,
                                       uint64_t error_block_address)
 {
     GArray *block;
@@ -344,12 +348,18 @@ static int acpi_ghes_record_arm_error(uint8_t error_types,
      * Table 17-13 Generic Error Data Entry
      */
     QemuUUID fru_id = {};
-    uint32_t data_length;
+    uint32_t cper_length, data_length;
 
     block = g_array_new(false, true /* clear */, 1);
 
     /* This is the length if adding a new generic error data entry*/
-    data_length = ACPI_GHES_DATA_LENGTH + ACPI_GHES_ARM_CPER_LENGTH;
+    cper_length = ACPI_GHES_ARM_CPER_LENGTH;
+    cper_length += ACPI_GHES_ARM_CPER_PEI_LENGTH * error.err_info_num;
+    cper_length += error.context_length;
+    cper_length += error.vendor_num;
+
+    data_length = ACPI_GHES_DATA_LENGTH + cper_length;
+
     /*
      * It should not run out of the preallocated memory if adding a new generic
      * error data entry
@@ -363,11 +373,11 @@ static int acpi_ghes_record_arm_error(uint8_t error_types,
 
     /* Build this new generic error data entry header */
     acpi_ghes_generic_error_data(block, uefi_cper_arm_sec,
-        ACPI_CPER_SEV_RECOVERABLE, 0, 0,
-        ACPI_GHES_ARM_CPER_LENGTH, fru_id, 0);
+                                 ACPI_CPER_SEV_RECOVERABLE, 0, 0,
+                                 cper_length, fru_id, 0);
 
     /* Build the ARM processor error section CPER */
-    acpi_ghes_build_append_arm_cper(error_types, block);
+    acpi_ghes_build_append_arm_cper(error, cper_length, block);
 
     /* Write the generic error data entry into guest memory */
     cpu_physical_memory_write(error_block_address, block->data, block->len);
@@ -663,7 +673,7 @@ static bool ghes_get_addr(uint32_t notify, uint64_t *error_block_addr,
     return true;
 }
 
-bool ghes_record_arm_errors(uint8_t error_types, uint32_t notify)
+bool ghes_record_arm_errors(ArmError error, uint32_t notify)
 {
     int read_ack_register = 0;
     uint64_t read_ack_register_addr = 0;
@@ -689,7 +699,7 @@ bool ghes_record_arm_errors(uint8_t error_types, uint32_t notify)
     read_ack_register = cpu_to_le64(0);
     cpu_physical_memory_write(read_ack_register_addr,
                               &read_ack_register, sizeof(uint64_t));
-    return acpi_ghes_record_arm_error(error_types, error_block_addr);
+    return acpi_ghes_record_arm_error(error, error_block_addr);
 }
 
 bool acpi_ghes_present(void)
diff --git a/hw/arm/arm_error_inject.c b/hw/arm/arm_error_inject.c
index 1da97d5d4fdc..67f1c77546b9 100644
--- a/hw/arm/arm_error_inject.c
+++ b/hw/arm/arm_error_inject.c
@@ -10,23 +10,408 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi-commands-arm-error-inject.h"
 #include "hw/boards.h"
 #include "hw/acpi/ghes.h"
+#include "cpu.h"
+
+#define ACPI_GHES_ARM_CPER_CTX_DEFAULT_NREGS 74
+
+/* Handle ARM Processor Error Information (PEI) */
+static const ArmProcessorErrorInformationList *default_pei = { 0 };
+
+static ArmPEI *qmp_arm_pei(uint16_t *err_info_num,
+              bool has_error,
+              ArmProcessorErrorInformationList const *error_list)
+{
+    ArmProcessorErrorInformationList const *next;
+    ArmPeiValidationBitsList const *validation_list;
+    ArmPEI *pei = NULL;
+    uint16_t i;
+
+    if (!has_error) {
+        error_list = default_pei;
+    }
+
+    *err_info_num = 0;
+
+    for (next = error_list; next; next = next->next) {
+        (*err_info_num)++;
+
+        if (*err_info_num >= 255) {
+            break;
+        }
+    }
+
+    pei = g_new0(ArmPEI, (*err_info_num));
+
+    for (next = error_list, i = 0;
+                i < *err_info_num; i++, next = next->next) {
+        ArmProcessorErrorTypeList *type_list = next->value->type;
+        uint16_t pei_validation = 0;
+        uint8_t flags = 0;
+        uint8_t type = 0;
+
+        if (next->value->has_validation) {
+            validation_list = next->value->validation;
+
+            while (validation_list) {
+                pei_validation |= BIT(next->value->validation->value);
+                validation_list = validation_list->next;
+            }
+        }
+
+        /*
+         * According with UEFI 2.9A errata, the meaning of this field is
+         * given by the following bitmap:
+         *
+         *   +-----|---------------------------+
+         *   | Bit | Meaning                   |
+         *   +=====+===========================+
+         *   |  1  | Cache Error               |
+         *   |  2  | TLB Error                 |
+         *   |  3  | Bus Error                 |
+         *   |  4  | Micro-architectural Error |
+         *   +-----|---------------------------+
+         *
+         *   All other values are reserved.
+         *
+         * As bit 0 is reserved, QAPI ArmProcessorErrorType starts from bit 1.
+         */
+        while (type_list) {
+            type |= BIT(type_list->value + 1);
+            type_list = type_list->next;
+        }
+        if (!has_error) {
+            type = BIT(ARM_PROCESSOR_ERROR_TYPE_CACHE_ERROR);
+        }
+        pei[i].type = type;
+
+        if (next->value->has_flags) {
+            ArmProcessorFlagsList *flags_list = next->value->flags;
+
+            while (flags_list) {
+                flags |= BIT(flags_list->value);
+                flags_list = flags_list->next;
+            }
+        } else {
+            flags = BIT(ARM_PROCESSOR_FLAGS_FIRST_ERROR_CAP) |
+                    BIT(ARM_PROCESSOR_FLAGS_PROPAGATED);
+        }
+        pei[i].flags = flags;
+
+        if (next->value->has_multiple_error) {
+            pei[i].multiple_error = next->value->multiple_error;
+            pei_validation |= BIT(ARM_PEI_VALIDATION_BITS_MULTIPLE_ERROR_VALID);
+        }
+
+        if (next->value->has_error_info) {
+            pei[i].error_info = next->value->error_info;
+        } else {
+            switch (type) {
+            case BIT(ARM_PROCESSOR_ERROR_TYPE_CACHE_ERROR):
+                pei[i].error_info = 0x0091000F;
+                break;
+            case BIT(ARM_PROCESSOR_ERROR_TYPE_TLB_ERROR):
+                pei[i].error_info = 0x0054007F;
+                break;
+            case BIT(ARM_PROCESSOR_ERROR_TYPE_BUS_ERROR):
+                pei[i].error_info = 0x80D6460FFF;
+                break;
+            case BIT(ARM_PROCESSOR_ERROR_TYPE_MICRO_ARCH_ERROR):
+                pei[i].error_info = 0x78DA03FF;
+                break;
+            default:
+                /*
+                 * UEFI 2.9A/2.10 doesn't define how this should be filled
+                 * when multiple types are there. So, set default to zero,
+                 * causing it to be removed from validation bits.
+                 */
+                pei[i].error_info = 0;
+            }
+        }
+
+        if (next->value->has_virt_addr) {
+            pei[i].virt_addr = next->value->virt_addr;
+            pei_validation |= BIT(ARM_PEI_VALIDATION_BITS_VIRT_ADDR_VALID);
+        }
+
+        if (next->value->has_phy_addr) {
+            pei[i].phy_addr = next->value->phy_addr;
+            pei_validation |= BIT(ARM_PEI_VALIDATION_BITS_PHY_ADDR_VALID);
+        }
+
+        if (!next->value->has_validation) {
+            if (pei[i].flags) {
+                pei_validation |= BIT(ARM_PEI_VALIDATION_BITS_FLAGS_VALID);
+            }
+            if (pei[i].error_info) {
+                pei_validation |= BIT(ARM_PEI_VALIDATION_BITS_ERROR_INFO_VALID);
+            }
+            if (next->value->has_virt_addr) {
+                pei_validation |= BIT(ARM_PEI_VALIDATION_BITS_VIRT_ADDR_VALID);
+            }
+
+            if (next->value->has_phy_addr) {
+                pei_validation |= BIT(ARM_PEI_VALIDATION_BITS_PHY_ADDR_VALID);
+            }
+        }
+
+        pei[i].validation = pei_validation;
+    }
+
+    return pei;
+}
+
+/*
+ * UEFI 2.10 default context register type (See UEFI 2.10 table N.21 for more)
+ */
+#define CONTEXT_AARCH32_EL1   1
+#define CONTEXT_AARCH64_EL1   5
+
+static int get_default_context_type(void)
+{
+    ARMCPU *cpu = ARM_CPU(qemu_get_cpu(0));
+    bool aarch64;
+
+    aarch64 = object_property_get_bool(OBJECT(cpu), "aarch64", NULL);
+
+    if (aarch64) {
+        return CONTEXT_AARCH64_EL1;
+    }
+    return CONTEXT_AARCH32_EL1;
+}
+
+/* Handle ARM Context */
+static ArmContext *qmp_arm_context(uint16_t *context_info_num,
+                                   uint32_t *context_length,
+                                   bool has_context,
+                                   ArmProcessorContextList const *context_list)
+{
+    ArmProcessorContextList const *next;
+    ArmContext *context = NULL;
+    uint16_t i, j, num, default_type;
+
+    default_type = get_default_context_type();
+
+    if (!has_context) {
+        *context_info_num = 0;
+        *context_length = 0;
+
+        return NULL;
+    }
+
+    /* Calculate sizes */
+    num = 0;
+    for (next = context_list; next; next = next->next) {
+        uint32_t n_regs = 0;
+
+        if (next->value->has_q_register) {
+            uint64List *reg = next->value->q_register;
+
+            while (reg) {
+                n_regs++;
+                reg = reg->next;
+            }
+
+            if (next->value->has_minimal_size &&
+                                        next->value->minimal_size < n_regs) {
+                n_regs = next->value->minimal_size;
+            }
+        } else if (!next->value->has_minimal_size) {
+            n_regs = ACPI_GHES_ARM_CPER_CTX_DEFAULT_NREGS;
+        }
+
+        if (!n_regs) {
+            next->value->minimal_size = 0;
+        } else {
+            next->value->minimal_size = (n_regs + 1) % 0xfffe;
+        }
+
+        num++;
+        if (num >= 65535) {
+            break;
+        }
+    }
+
+    context = g_new0(ArmContext, num);
+
+    /* Fill context data */
+
+    *context_length = 0;
+    *context_info_num = 0;
+
+    next = context_list;
+    for (i = 0; i < num; i++, next = next->next) {
+        if (!next->value->minimal_size) {
+            continue;
+        }
+
+        if (next->value->has_type) {
+            context[*context_info_num].type = next->value->type;
+        } else {
+            context[*context_info_num].type = default_type;
+        }
+        context[*context_info_num].size = next->value->minimal_size;
+        context[*context_info_num].array = g_malloc0(context[*context_info_num].size * 8);
+
+        (*context_info_num)++;
+
+        /* length = 64 bits * (size of the reg array + context type) */
+        *context_length += (context->size + 1) * 8;
+
+        if (!next->value->has_q_register) {
+            *context->array = 0xDEADBEEF;
+        } else {
+            uint64_t *pos = context->array;
+            uint64List *reg = next->value->q_register;
+
+            for (j = 0; j < context->size; j++) {
+                if (!reg) {
+                    break;
+                }
+
+                *(pos++) = reg->value;
+                reg = reg->next;
+            }
+        }
+    }
+
+    if (!*context_info_num) {
+        g_free(context);
+        return NULL;
+    }
+
+    return context;
+}
+
+static uint8_t *qmp_arm_vendor(uint32_t *vendor_num, bool has_vendor_specific,
+                               uint8List const *vendor_specific_list)
+{
+    uint8List const *next = vendor_specific_list;
+    uint8_t *vendor = NULL, *p;
+
+    if (!has_vendor_specific) {
+        return NULL;
+    }
+
+    *vendor_num = 0;
+
+    while (next) {
+        next = next->next;
+        (*vendor_num)++;
+    }
+
+    vendor = g_malloc(*vendor_num);
+
+    p = vendor;
+    next = vendor_specific_list;
+    while (next) {
+        *p = next->value;
+        next = next->next;
+        p++;
+    }
+
+    return vendor;
+}
 
 /* For ARM processor errors */
-void qmp_arm_inject_error(ArmProcessorErrorTypeList *errortypes, Error **errp)
+void qmp_arm_inject_error(bool has_validation,
+                    ArmProcessorValidationBitsList *validation_list,
+                    bool has_affinity_level,
+                    uint8_t affinity_level,
+                    bool has_mpidr_el1,
+                    uint64_t mpidr_el1,
+                    bool has_midr_el1,
+                    uint64_t midr_el1,
+                    bool has_running_state,
+                    ArmProcessorRunningStateList *running_state_list,
+                    bool has_psci_state,
+                    uint32_t psci_state,
+                    bool has_context, ArmProcessorContextList *context_list,
+                    bool has_vendor_specific, uint8List *vendor_specific_list,
+                    bool has_error,
+                    ArmProcessorErrorInformationList *error_list,
+                    Error **errp)
 {
     MachineState *machine = MACHINE(qdev_get_machine());
     MachineClass *mc = MACHINE_GET_CLASS(machine);
-    uint8_t error_types = 0;
+    ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(0));
+    uint32_t running_state = 0;
+    uint16_t validation = 0;
+    ArmError error;
+    uint16_t i;
 
-    while (errortypes) {
-        error_types |= BIT(errortypes->value);
-        errortypes = errortypes->next;
+    /* Handle UEFI 2.0 N.16 specific fields, setting defaults when needed */
+
+    if (!has_midr_el1) {
+        mpidr_el1 = armcpu->midr;
+    }
+
+    if (!has_mpidr_el1) {
+        mpidr_el1 = armcpu->mpidr;
+    }
+
+    if (has_running_state) {
+        while (running_state_list) {
+            running_state |= BIT(running_state_list->value);
+            running_state_list = running_state_list;
+        }
+
+        if (running_state) {
+            error.psci_state = 0;
+        }
+    }
+
+    if (has_validation) {
+        while (validation_list) {
+            validation |= BIT(validation_list->value);
+            validation_list = validation_list->next;
+        }
+    } else {
+        if (has_vendor_specific) {
+            validation |= BIT(ARM_PROCESSOR_VALIDATION_BITS_VENDOR_SPECIFIC_VALID);
+        }
+
+        if (has_affinity_level) {
+            validation |= BIT(ARM_PROCESSOR_VALIDATION_BITS_AFFINITY_VALID);
+        }
+
+        if (mpidr_el1) {
+            validation = BIT(ARM_PROCESSOR_VALIDATION_BITS_MPIDR_VALID);
+        }
+
+        if (!has_running_state) {
+            validation |= BIT(ARM_PROCESSOR_VALIDATION_BITS_RUNNING_STATE_VALID);
+        }
+    }
+
+    /* Fill an error record */
+
+    error.validation = validation;
+    error.affinity_level = affinity_level;
+    error.mpidr_el1 = mpidr_el1;
+    error.midr_el1 = midr_el1;
+    error.running_state = running_state;
+    error.psci_state = psci_state;
+
+    error.pei = qmp_arm_pei(&error.err_info_num, has_error, error_list);
+    error.context = qmp_arm_context(&error.context_info_num,
+                                    &error.context_length,
+                                    has_context, context_list);
+    error.vendor = qmp_arm_vendor(&error.vendor_num, has_vendor_specific,
+                                  vendor_specific_list);
+
+    ghes_record_arm_errors(error, ACPI_GHES_NOTIFY_GPIO);
+
+    if (error.context) {
+        for (i = 0; i < error.context_info_num; i++) {
+            g_free(error.context[i].array);
+        }
     }
+    g_free(error.context);
+    g_free(error.pei);
+    g_free(error.vendor);
 
-    ghes_record_arm_errors(error_types, ACPI_GHES_NOTIFY_GPIO);
     if (mc->set_error) {
         mc->set_error();
     }
diff --git a/hw/arm/arm_error_inject_stubs.c b/hw/arm/arm_error_inject_stubs.c
index b51f4202fe64..7d7c00ad331b 100644
--- a/hw/arm/arm_error_inject_stubs.c
+++ b/hw/arm/arm_error_inject_stubs.c
@@ -10,9 +10,25 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi-commands-arm-error-inject.h"
+#include "hw/acpi/ghes.h"
 
-void qmp_arm_inject_error(ArmProcessorErrorTypeList *errortypes, Error **errp)
+void qmp_arm_inject_error(bool has_validation,
+                        ArmProcessorValidationBitsList *validation,
+                        bool has_affinity_level,
+                        uint8_t affinity_level,
+                        bool has_mpidr_el1,
+                        uint64_t mpidr_el1,
+                        bool has_midr_el1,
+                        uint64_t midr_el1,
+                        bool has_running_state,
+                        ArmProcessorRunningStateList *running_state,
+                        bool has_psci_state,
+                        uint32_t psci_state,
+                        bool has_context, ArmProcessorContextList *context,
+                        bool has_vendor_specific, uint8List *vendor_specific,
+                        bool has_error,
+                        ArmPeiList *error,
+                        Error **errp)
 {
     error_setg(errp, "ARM processor error support is not compiled in");
 }
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index dc531ffce7ae..c591a5fb02c4 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -23,6 +23,7 @@
 #define ACPI_GHES_H
 
 #include "hw/acpi/bios-linker-loader.h"
+#include "qapi/qapi-commands-arm-error-inject.h"
 
 /*
  * Values for Hardware Error Notification Type field
@@ -68,6 +69,43 @@ typedef struct AcpiGhesState {
     bool present; /* True if GHES is present at all on this board */
 } AcpiGhesState;
 
+typedef struct ArmPEI {
+    uint16_t validation;
+    uint8_t type;
+    uint16_t multiple_error;
+    uint8_t flags;
+    uint64_t error_info;
+    uint64_t virt_addr;
+    uint64_t phy_addr;
+} ArmPEI;
+
+typedef struct ArmContext {
+    uint16_t type;
+    uint32_t size;
+    uint64_t *array;
+} ArmContext;
+
+/* ARM processor - UEFI 2.10 table N.16 */
+typedef struct ArmError {
+    uint16_t validation;
+
+    uint8_t affinity_level;
+    uint64_t mpidr_el1;
+    uint64_t midr_el1;
+    uint32_t running_state;
+    uint32_t psci_state;
+
+    /* Those are calculated based on the input data */
+    uint16_t err_info_num;
+    uint16_t context_info_num;
+    uint32_t vendor_num;
+    uint32_t context_length;
+
+    ArmPEI *pei;
+    ArmContext *context;
+    uint8_t *vendor;
+} ArmError;
+
 void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker);
 void acpi_build_hest(GArray *table_data, BIOSLinker *linker,
                      const char *oem_id, const char *oem_table_id);
@@ -75,7 +113,7 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
                           GArray *hardware_errors);
 int acpi_ghes_record_errors(uint8_t notify, uint64_t error_physical_addr);
 
-bool ghes_record_arm_errors(uint8_t error_types, uint32_t notify);
+bool ghes_record_arm_errors(ArmError error, uint32_t notify);
 
 /**
  * acpi_ghes_present: Report whether ACPI GHES table is present
diff --git a/qapi/arm-error-inject.json b/qapi/arm-error-inject.json
index 430e6cea6b60..2a314830fe60 100644
--- a/qapi/arm-error-inject.json
+++ b/qapi/arm-error-inject.json
@@ -2,40 +2,258 @@
 # vim: filetype=python
 
 ##
-# = ARM Processor Errors
+# = ARM Processor Errors as defined at:
+# https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html
+# See tables N.16, N.17 and N.21.
 ##
 
+##
+# @ArmProcessorValidationBits:
+#
+# Indcates whether or not fields of ARM processor CPER record are valid.
+#
+# @mpidr-valid:  MPIDR Valid
+#
+# @affinity-valid: Error affinity level Valid
+#
+# @running-state-valid: Running State
+#
+# @vendor-specific-valid: Vendor Specific Info Valid
+#
+# Since: 9.1
+##
+{ 'enum': 'ArmProcessorValidationBits',
+  'data': ['mpidr-valid',
+           'affinity-valid',
+           'running-state-valid',
+           'vendor-specific-valid']
+}
+
+##
+# @ArmProcessorFlags:
+#
+# Indicates error attributes at the Error info section.
+#
+# @first-error-cap: First error captured
+#
+# @last-error-cap:  Last error captured
+#
+# @propagated: Propagated
+#
+# @overflow: Overflow
+#
+# Since: 9.1
+##
+{ 'enum': 'ArmProcessorFlags',
+  'data': ['first-error-cap',
+           'last-error-cap',
+           'propagated',
+           'overflow']
+}
+
+##
+# @ArmProcessorRunningState:
+#
+# Indicates if the processor is running.
+#
+# @processor-running: indicates that the processor is running
+#
+# Since: 9.1
+##
+{ 'enum': 'ArmProcessorRunningState',
+  'data': ['processor-running']
+}
+
 ##
 # @ArmProcessorErrorType:
 #
-# Type of ARM processor error to inject
-#
-# @unknown-error: Unknown error
+# Type of ARM processor error information to inject.
 #
 # @cache-error: Cache error
 #
 # @tlb-error: TLB error
 #
-# @bus-error: Bus error.
+# @bus-error: Bus error
 #
-# @micro-arch-error: Micro architectural error.
+# @micro-arch-error: Micro architectural error
 #
 # Since: 9.1
 ##
 { 'enum': 'ArmProcessorErrorType',
-  'data': ['unknown-error',
-	   'cache-error',
+  'data': ['cache-error',
            'tlb-error',
            'bus-error',
            'micro-arch-error']
+ }
+
+##
+# @ArmPeiValidationBits:
+#
+# Indcates whether or not fields of Processor Error Info section are valid.
+#
+# @multiple-error-valid: Information at multiple-error field is valid
+#
+# @flags-valid: Information at flags field is valid
+#
+# @error-info-valid: Information at error-info field is valid
+#
+# @virt-addr-valid: Information at virt-addr field is valid
+#
+# @phy-addr-valid: Information at phy-addr field is valid
+#
+# Since: 9.1
+##
+{ 'enum': 'ArmPeiValidationBits',
+  'data': ['multiple-error-valid',
+           'flags-valid',
+           'error-info-valid',
+           'virt-addr-valid',
+           'phy-addr-valid']
+}
+
+##
+# @ArmProcessorErrorInformation:
+#
+# Contains ARM processor error information (PEI) data according with UEFI
+# CPER table N.17.
+#
+# @validation:
+#       Valid validation bits for error-info section.
+#       Argument is optional. If not specified, those flags will be enabled:
+#       first-error-cap and propagated.
+#
+# @type:
+#       ARM processor error types to inject. Argument is mandatory.
+#
+# @multiple-error:
+#       Indicates whether multiple errors have occurred.
+#       Argument is optional. If not specified and @validation not enforced,
+#       this field will be marked as invalid at CPER record..
+#
+# @flags:
+#       Indicates flags that describe the error attributes.
+#       Argument is optional. If not specified and defaults to
+#       first-error and propagated.
+#
+# @error-info:
+#       Error information structure is specific to each error type.
+#       Argument is optional, and its value depends on the PEI type(s).
+#       If not defined, the default depends on the type:
+#       - for cache-error: 0x0091000F;
+#       - for tlb-error: 0x0054007F;
+#       - for bus-error: 0x80D6460FFF;
+#       - for micro-arch-error: 0x78DA03FF;
+#       - if multiple types used, this bit is disabled from @validation bits.
+#
+# @virt-addr:
+#       Virtual fault address associated with the error.
+#       Argument is optional. If not specified and @validation not enforced,
+#       this field will be marked as invalid at CPER record..
+#
+# @phy-addr:
+#       Physical fault address associated with the error.
+#       Argument is optional. If not specified and @validation not enforced,
+#       this field will be marked as invalid at CPER record..
+#
+# Since: 9.1
+##
+{ 'struct': 'ArmProcessorErrorInformation',
+  'data': { '*validation': ['ArmPeiValidationBits'],
+            'type': ['ArmProcessorErrorType'],
+            '*multiple-error': 'uint16',
+            '*flags': ['ArmProcessorFlags'],
+            '*error-info': 'uint64',
+            '*virt-addr':  'uint64',
+            '*phy-addr': 'uint64'}
+}
+
+##
+# @ArmProcessorContext:
+#
+# Provide processor context state specific to the ARM processor architecture,
+# According with UEFI 2.10 CPER table N.21.
+# Argument is optional.If not specified, no context will be used.
+#
+# @type:
+#       Contains an integer value indicating the type of context state being
+#       reported.
+#       Argument is optional. If not defined, it will be set to be EL1 register
+#       for the emulation, e. g.:
+#       - on arm32: AArch32 EL1 context registers;
+#       - on arm64: AArch64 EL1 context registers.
+#
+# @register:
+#       Provides the contents of the actual registers or raw data, depending
+#       on the context type.
+#       Argument is optional. If not defined, it will fill the first register
+#       with 0xDEADBEEF, and the other ones with zero.
+#
+# @minimal-size:
+#       Argument is optional. If provided, define the minimal size of the
+#       context register array. The actual size is defined by checking the
+#       number of register values plus the content of this field (if used),
+#       ensuring that each processor context information structure array is
+#       padded with zeros if the size is not a multiple of 16 bytes.
+#
+# Since: 9.1
+##
+{ 'struct': 'ArmProcessorContext',
+  'data': { '*type': 'uint16',
+            '*minimal-size': 'uint32',
+            '*register': ['uint64']}
 }
 
 ##
 # @arm-inject-error:
 #
-# Inject ARM Processor error.
+# Inject ARM Processor error with data to be filled accordign with UEFI 2.10
+# CPER table N.16.
 #
-# @errortypes: ARM processor error types to inject
+# @validation:
+#       Valid validation bits for ARM processor CPER.
+#       Argument is optional. If not specified, the default is
+#       calculated based on having the corresponding arguments filled.
+#
+# @affinity-level:
+#       Error affinity level for errors that can be attributed to a specific
+#       affinity level.
+#       Argument is optional. If not specified and @validation not enforced,
+#       this field will be marked as invalid at CPER record.
+#
+# @mpidr-el1:
+#       Processor’s unique ID in the system.
+#       Argument is optional. If not specified, it will use the cpu mpidr
+#       field from the emulation data. If zero and @validation is not
+#       enforced, this field will be marked as invalid at CPER record.
+#
+# @midr-el1:  Identification info of the chip
+#       Argument is optional. If not specified, it will use the cpu mpidr
+#       field from the emulation data. If zero and @validation is not
+#       enforced, this field will be marked as invalid at CPER record.
+#
+# @running-state:
+#       Indicates the running state of the processor.
+#       Argument is optional. If not specified and @validation not enforced,
+#       this field will be marked as invalid at CPER record.
+#
+# @psci-state:
+#       Provides PSCI state of the processor, as defined in ARM PSCI document.
+#       Argument is optional. If not specified, it will use the cpu power
+#       state field from the emulation data.
+#
+# @context:
+#       Contains an array of processor context registers.
+#       Argument is optional. If not specified, no context will be added.
+#
+# @vendor-specific:
+#       Contains a byte array of vendor-specific data.
+#       Argument is optional. If not specified, no vendor-specific data
+#       will be added.
+#
+# @error:
+#       Contains an array of ARM processor error information (PEI) sections.
+#       Argument is optional. If not specified, defaults to a single
+#       Program Error Information record defaulting to type=cache-error.
 #
 # Features:
 #
@@ -44,6 +262,16 @@
 # Since: 9.1
 ##
 { 'command': 'arm-inject-error',
-  'data': { 'errortypes': ['ArmProcessorErrorType'] },
+  'data': {
+    '*validation': ['ArmProcessorValidationBits'],
+    '*affinity-level': 'uint8',
+    '*mpidr-el1': 'uint64',
+    '*midr-el1': 'uint64',
+    '*running-state':  ['ArmProcessorRunningState'],
+    '*psci-state': 'uint32',
+    '*context': ['ArmProcessorContext'],
+    '*vendor-specific': ['uint8'],
+    '*error': ['ArmProcessorErrorInformation']
+  },
   'features': [ 'unstable' ]
 }
diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
index 0e9490cebc72..77c800186f34 160000
--- a/tests/lcitool/libvirt-ci
+++ b/tests/lcitool/libvirt-ci
@@ -1 +1 @@
-Subproject commit 0e9490cebc726ef772b6c9e27dac32e7ae99f9b2
+Subproject commit 77c800186f34b21be7660750577cc5582a914deb
-- 
2.45.2


