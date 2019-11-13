Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA683FB37E
	for <lists+linux-edac@lfdr.de>; Wed, 13 Nov 2019 16:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfKMPRJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 13 Nov 2019 10:17:09 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:41950 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727754AbfKMPRI (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 13 Nov 2019 10:17:08 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3BA8B76400B6B499B126;
        Wed, 13 Nov 2019 23:16:58 +0800 (CST)
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Wed, 13 Nov 2019 23:16:47 +0800
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-efi@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>, <james.morse@arm.com>
CC:     <rjw@rjwysocki.net>, <tony.luck@intel.com>, <linuxarm@huawei.com>,
        <ard.biesheuvel@linaro.org>, <nariman.poushin@linaro.org>,
        Thanu Rangarajan <Thanu.Rangarajan@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v4 1/6] efi / ras: CCIX Memory error reporting
Date:   Wed, 13 Nov 2019 23:16:22 +0800
Message-ID: <20191113151627.7950-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113151627.7950-1-Jonathan.Cameron@huawei.com>
References: <20191113151627.7950-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.123.41.22]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

CCIX defines a number of different error types
(See CCIX spec 1.0) and UEFI 2.8 defines a CPER record to allow
for them to be reported when firmware first handling is in use.
The last part of that record is a copy of the CCIX protocol
error record which can provide very detailed information.

This patch introduces infrastructure and support for one of those
error types, CCIX Memory Errors.  Later patches will supply
equivalent support for the other error types.

The variable length and content of the different messages makes
a single tracepoint impractical.  As such the current RAS
tracepoint only covers the memory error. Additional trace points
will be introduced for other error types along with their
cper handling in a follow up series.

RAS daemon support to follow shortly. qemu injection patches
also available but not currently planing to upstream those.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/acpi/apei/Kconfig        |   8 +
 drivers/acpi/apei/ghes.c         |  39 ++++
 drivers/firmware/efi/Kconfig     |   5 +
 drivers/firmware/efi/Makefile    |   1 +
 drivers/firmware/efi/cper-ccix.c | 359 +++++++++++++++++++++++++++++++
 drivers/firmware/efi/cper.c      |   6 +
 include/linux/cper.h             | 118 ++++++++++
 include/ras/ras_event.h          |  79 +++++++
 8 files changed, 615 insertions(+)

diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index 6b18f8bc7be3..e687b18dee34 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -68,3 +68,11 @@ config ACPI_APEI_ERST_DEBUG
 	  error information to and from a persistent store. Enable this
 	  if you want to debugging and testing the ERST kernel support
 	  and firmware implementation.
+
+config ACPI_APEI_CCIX
+       bool "APEI CCIX error recovery support"
+       depends on ACPI_APEI && MEMORY_FAILURE
+       help
+	 CCIX has a number of defined error types. This option enables
+	 the handling of CPER records generated by a firmware performing
+	 firmware first error handling of these CCIX errors.
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 777f6f7122b4..75a177ae9de3 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -490,6 +490,42 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 #endif
 }
 
+static void ghes_handle_ccix_per(struct acpi_hest_generic_data *gdata, int sev)
+{
+#ifdef CONFIG_ACPI_APEI_CCIX
+	struct cper_sec_ccix_header *header = acpi_hest_get_payload(gdata);
+	__u32 *dw;
+	enum ccix_per_type per_type;
+	static u32 err_seq;
+	void *payload;
+
+	/* Check if space for CCIX CPER header and 8 DW of a PER log header */
+	if (gdata->error_data_length <
+	    sizeof(*header) + CCIX_PER_LOG_HEADER_DWS * sizeof(__u32))
+		return;
+
+	if ((header->validation_bits & CPER_CCIX_VALID_PER_LOG) == 0)
+		return;
+
+	dw = (__u32 *)(header + 1);
+
+	per_type = FIELD_GET(CCIX_PER_LOG_DW1_PER_TYPE_M, dw[1]);
+	payload = acpi_hest_get_payload(gdata);
+
+	switch (per_type) {
+	case CCIX_MEMORY_ERROR:
+		trace_ccix_memory_error_event(payload, err_seq, sev,
+					      ccix_mem_err_ven_len_get(payload));
+		break;
+	default:
+		/* Unknown error type */
+		pr_info("CCIX error of unknown or vendor defined type\n");
+		break;
+	}
+	err_seq++;
+#endif
+}
+
 static void ghes_do_proc(struct ghes *ghes,
 			 const struct acpi_hest_generic_status *estatus)
 {
@@ -520,6 +556,9 @@ static void ghes_do_proc(struct ghes *ghes,
 		else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
 			ghes_handle_aer(gdata);
 		}
+		else if (guid_equal(sec_type, &CPER_SEC_CCIX)) {
+			ghes_handle_ccix_per(gdata, estatus->error_severity);
+		}
 		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
 			struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
 
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index b248870a9806..096e693a9522 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -209,6 +209,11 @@ config UEFI_CPER_X86
 	depends on UEFI_CPER && X86
 	default y
 
+config UEFI_CPER_CCIX
+       bool
+       depends on UEFI_CPER
+       default y
+
 config EFI_DEV_PATH_PARSER
 	bool
 	depends on ACPI
diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index 4ac2de4dfa72..9a52c7d01e94 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -34,3 +34,4 @@ obj-$(CONFIG_EFI_CAPSULE_LOADER)	+= capsule-loader.o
 obj-$(CONFIG_EFI_EARLYCON)		+= earlycon.o
 obj-$(CONFIG_UEFI_CPER_ARM)		+= cper-arm.o
 obj-$(CONFIG_UEFI_CPER_X86)		+= cper-x86.o
+obj-$(CONFIG_UEFI_CPER_CCIX)		+= cper-ccix.o
diff --git a/drivers/firmware/efi/cper-ccix.c b/drivers/firmware/efi/cper-ccix.c
new file mode 100644
index 000000000000..53ab5d650479
--- /dev/null
+++ b/drivers/firmware/efi/cper-ccix.c
@@ -0,0 +1,359 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * UEFI Common Platform Error Record (CPER) support for CCIX
+ * protocol errors.
+ *
+ * Copyright (C) 2019, Huawei
+ *	Author: Jonathan Cameron <jonathan.cameron@huawei.com>
+ *
+ * The CCIX® trademark and CCIX trade name are owned solely by
+ * CCIX CONSORTIUM, INC. and all rights are reserved therein.
+ *
+ * CPER is the format used to describe platform hardware error by
+ * various tables, such as ERST, BERT and HEST etc.
+ *
+ * For more information about CPER, please refer to Appendix N of UEFI
+ * Specification version 2.9.
+ *
+ * CCIX defines a number of Protocol Error Messages which for the
+ * main body of the CCIX CPER records.  These are defined in the
+ * CCIX Specification 1.0.
+ */
+
+#include <acpi/ghes.h>
+#include <linux/acpi.h>
+#include <linux/bitfield.h>
+#include <linux/cper.h>
+#include <linux/kernel.h>
+#include <linux/printk.h>
+#include <ras/ras_event.h>
+
+static char rcd_decode_str[CPER_REC_LEN];
+
+static const char * const ccix_comp_type_strs[] = {
+	"Request Agent",
+	"Home Agent",
+	"Slave Agent",
+	"Port",
+	"Link",
+};
+
+const char *cper_ccix_comp_type_str(u8 comp_type)
+{
+	return comp_type < ARRAY_SIZE(ccix_comp_type_strs) ?
+		ccix_comp_type_strs[comp_type] : "Reserved";
+}
+
+static const char * const ccix_per_type_strs[] = {
+	"Memory Error",
+	"Cache Error",
+	"ATC Error",
+	"Port Error",
+	"Link Error",
+	"Agent Internal",
+};
+
+static const char * const ccix_mem_pool_gen_type_strs[] = {
+	"Other, Non-specified",
+	"ROM",
+	"Volatile",
+	"Non-volatile",
+	"Device",
+};
+
+static const char *cper_ccix_mem_err_generic_type_str(u16 type)
+{
+	const char *gen_type_str;
+
+	if (type < ARRAY_SIZE(ccix_mem_pool_gen_type_strs))
+		gen_type_str = ccix_mem_pool_gen_type_strs[type];
+	else if (type >= 0x80)
+		gen_type_str = "Vendor";
+	else
+		gen_type_str = "Reserved";
+
+	return gen_type_str;
+}
+
+static const char * const ccix_mem_op_type_strs[] = {
+	"Generic",
+	"Read",
+	"Write",
+	"Reserved",
+	"Scrub",
+};
+
+static const char *cper_ccix_mem_err_op_str(u8 op_type)
+{
+	return op_type < ARRAY_SIZE(ccix_mem_op_type_strs) ?
+		ccix_mem_op_type_strs[op_type] :
+		"Reserved";
+}
+
+/* Sightly different from the generic version */
+static const char * const ccix_mem_err_type_strs[] = {
+	"Unknown",
+	"No Error",
+	"Single-bit ECC",
+	"Multi-bit ECC",
+	"Single-symbol ChipKill ECC",
+	"Multi-symbol ChipKill ECC",
+	"Master Abort",
+	"Target Abort",
+	"Parity Error",
+	"Watchdog Timeout",
+	"Invalid Address",
+	"Mirror Broken",
+	"Memory Sparing",
+	"Scrub",
+	"Physical Memory Map-out Event",
+};
+
+const char *cper_ccix_mem_err_type_str(unsigned int error_type)
+{
+	return error_type < ARRAY_SIZE(ccix_mem_err_type_strs) ?
+		ccix_mem_err_type_strs[error_type] : "Reserved";
+}
+
+static const char * const ccix_mem_spec_type_strs[] = {
+	"Other, Not-specified",
+	"SRAM",
+	"DDR",
+	"NVDIMM-F",
+	"NVDIMM-N",
+	"HBM",
+	"Flash"
+};
+
+static const char *cper_ccix_mem_err_spec_type_str(u8 specific_type)
+{
+	if (specific_type < ARRAY_SIZE(ccix_mem_spec_type_strs))
+		return ccix_mem_spec_type_strs[specific_type];
+	else if (specific_type >= 0x80)
+		return "Vendor";
+	else
+		return "Reserved";
+}
+
+/*
+ * We pack up everything except those that are needed for software handling:
+ * - error_type, physical_addr
+ * and header values that would require additional validation bits:
+ * - source, component, severity,
+ * implicit: protocol error type (mem)
+ */
+void cper_ccix_mem_err_pack(const struct cper_sec_ccix_mem_error *mem_record,
+			    struct cper_ccix_mem_err_compact *cmem_err,
+			    const u16 vendor_data_len,
+			    u8 *vendor_data)
+{
+	cmem_err->validation_bits = mem_record->validation_bits;
+	cmem_err->mem_err_type = mem_record->memory_error_type;
+	cmem_err->pool_generic_type = mem_record->pool_generic_type;
+	cmem_err->op_type = mem_record->op_type;
+	cmem_err->card = mem_record->card;
+	cmem_err->module = mem_record->module;
+	cmem_err->bank = mem_record->bank;
+	cmem_err->device = mem_record->device;
+	cmem_err->row = mem_record->row;
+	cmem_err->column = mem_record->column;
+	cmem_err->rank = mem_record->rank;
+	cmem_err->bit_pos = mem_record->bit_pos;
+	cmem_err->chip_id = mem_record->chip_id;
+	cmem_err->pool_specific_type = mem_record->pool_specific_type;
+	cmem_err->fru = mem_record->fru;
+	memcpy(vendor_data, &mem_record->vendor_data[1], vendor_data_len);
+}
+
+static int cper_ccix_err_location(struct cper_ccix_mem_err_compact *cmem_err,
+				  char *msg)
+{
+	u32 len = CPER_REC_LEN - 1;
+	u32 n = 0;
+
+	if (!msg)
+		return 0;
+
+	if (cmem_err->validation_bits & CCIX_MEM_ERR_GENERIC_MEM_VALID)
+		n += snprintf(msg + n, len, "Pool Generic Type: %s ",
+			      cper_ccix_mem_err_generic_type_str(cmem_err->pool_generic_type));
+
+	if (cmem_err->validation_bits & CCIX_MEM_ERR_MEM_ERR_TYPE_VALID)
+		n += snprintf(msg + n, len, "Err Type: %s ",
+			      cper_ccix_mem_err_type_str(cmem_err->mem_err_type));
+	if (cmem_err->validation_bits & CCIX_MEM_ERR_OP_VALID)
+		n += snprintf(msg + n, len, "Operation: %s ",
+			     cper_ccix_mem_err_op_str(cmem_err->op_type));
+
+	if (cmem_err->validation_bits & CCIX_MEM_ERR_CARD_VALID)
+		n += snprintf(msg + n, len, "Card: %d ", cmem_err->card);
+	if (cmem_err->validation_bits & CCIX_MEM_ERR_MOD_VALID)
+		n += snprintf(msg + n, len, "Mod: %d ", cmem_err->module);
+	if (cmem_err->validation_bits & CCIX_MEM_ERR_BANK_VALID)
+		n += snprintf(msg + n, len, "Bank: %d ", cmem_err->bank);
+	if (cmem_err->validation_bits & CCIX_MEM_ERR_DEVICE_VALID)
+		n += snprintf(msg + n, len, "Device: %d ", cmem_err->device);
+	if (cmem_err->validation_bits & CCIX_MEM_ERR_ROW_VALID)
+		n += snprintf(msg + n, len, "Row: %d ", cmem_err->row);
+	if (cmem_err->validation_bits & CCIX_MEM_ERR_COL_VALID)
+		n += snprintf(msg + n, len, "Col: %d ", cmem_err->column);
+	if (cmem_err->validation_bits & CCIX_MEM_ERR_RANK_VALID)
+		n += snprintf(msg + n, len, "Rank: %d ", cmem_err->rank);
+	if (cmem_err->validation_bits & CCIX_MEM_ERR_BIT_POS_VALID)
+		n += snprintf(msg + n, len, "BitPos: %d ", cmem_err->bit_pos);
+	if (cmem_err->validation_bits & CCIX_MEM_ERR_CHIP_ID_VALID)
+		n += snprintf(msg + n, len, "ChipID: %d ", cmem_err->chip_id);
+	if (cmem_err->validation_bits & CCIX_MEM_ERR_SPEC_TYPE_VALID)
+		n += snprintf(msg + n, len, "Pool Specific Type: %s ",
+			      cper_ccix_mem_err_spec_type_str(cmem_err->pool_specific_type));
+	n += snprintf(msg + n, len, "FRU: %d ", cmem_err->fru);
+
+	return n;
+}
+
+const char *cper_ccix_mem_err_unpack(struct trace_seq *p,
+				     struct cper_ccix_mem_err_compact *cmem_err)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+
+	if (cper_ccix_err_location(cmem_err, rcd_decode_str))
+		trace_seq_printf(p, "%s", rcd_decode_str);
+	trace_seq_putc(p, '\0');
+
+	return ret;
+}
+
+static int cper_ccix_mem_err_details(const char *pfx,
+				     struct acpi_hest_generic_data *gdata)
+{
+	struct cper_ccix_mem_error *full_mem_err;
+	struct cper_sec_ccix_mem_error *mem_err;
+	u16 vendor_data_len;
+	int i;
+
+	if (gdata->error_data_length < sizeof(*full_mem_err))
+		return -ENOSPC;
+
+	full_mem_err = acpi_hest_get_payload(gdata);
+
+	mem_err = &full_mem_err->mem_record;
+	printk("%s""FRU ID: %u, Length: %u\n", pfx,
+	       mem_err->fru, mem_err->length);
+	if (mem_err->validation_bits & CCIX_MEM_ERR_GENERIC_MEM_VALID)
+		printk("%s""Pool Generic Type: %s\n", pfx,
+		       cper_ccix_mem_err_generic_type_str(mem_err->pool_generic_type));
+
+	if (mem_err->validation_bits & CCIX_MEM_ERR_OP_VALID)
+		printk("%s""Operation: %s\n", pfx,
+		       cper_ccix_mem_err_op_str(mem_err->op_type));
+
+	if (mem_err->validation_bits & CCIX_MEM_ERR_MEM_ERR_TYPE_VALID) {
+		printk("%s""Mem Error Type: %s\n", pfx,
+		       cper_ccix_mem_err_type_str(mem_err->memory_error_type));
+	}
+	if (mem_err->validation_bits & CCIX_MEM_ERR_CARD_VALID)
+		printk("%s""Card: %u\n", pfx, mem_err->card);
+	if (mem_err->validation_bits & CCIX_MEM_ERR_MOD_VALID)
+		printk("%s""Module: %u\n", pfx, mem_err->module);
+	if (mem_err->validation_bits & CCIX_MEM_ERR_BANK_VALID)
+		printk("%s""Bank: %u\n", pfx, mem_err->bank);
+	if (mem_err->validation_bits & CCIX_MEM_ERR_DEVICE_VALID)
+		printk("%s""Device: %u\n", pfx, mem_err->device);
+	if (mem_err->validation_bits & CCIX_MEM_ERR_ROW_VALID)
+		printk("%s""Row: %u\n", pfx, mem_err->row);
+	if (mem_err->validation_bits & CCIX_MEM_ERR_COL_VALID)
+		printk("%s""Column: %u\n", pfx, mem_err->column);
+	if (mem_err->validation_bits & CCIX_MEM_ERR_RANK_VALID)
+		printk("%s""Rank: %u\n", pfx, mem_err->rank);
+	if (mem_err->validation_bits & CCIX_MEM_ERR_BIT_POS_VALID)
+		printk("%s""Bit Pos: %u\n", pfx, mem_err->bit_pos);
+	if (mem_err->validation_bits & CCIX_MEM_ERR_CHIP_ID_VALID)
+		printk("%s""Chip ID: %u\n", pfx, mem_err->chip_id);
+	if (mem_err->validation_bits & CCIX_MEM_ERR_SPEC_TYPE_VALID)
+		printk("%s""Specific Type: %s\n", pfx,
+		       cper_ccix_mem_err_spec_type_str(mem_err->pool_specific_type));
+
+	if (mem_err->validation_bits & CCIX_MEM_ERR_VENDOR_DATA_VALID) {
+		if (gdata->error_data_length < sizeof(*full_mem_err) + 4)
+			return -ENOSPC;
+
+		vendor_data_len = mem_err->vendor_data[0] & GENMASK(15, 0);
+		if (gdata->error_data_length <
+		    sizeof(*full_mem_err) + vendor_data_len)
+			return -ENOSPC;
+
+		for (i = 0; i < vendor_data_len / 4 - 1; i++)
+			printk("%s""Vendor%d: 0x%08x\n", pfx, i,
+			       mem_err->vendor_data[i + 1]);
+	}
+
+	return 0;
+}
+
+int cper_print_ccix_per(const char *pfx, struct acpi_hest_generic_data *gdata)
+{
+	struct cper_sec_ccix_header *header = acpi_hest_get_payload(gdata);
+	__u32 *dw;
+	__u32 comp_type;
+	enum ccix_per_type per_type;
+	bool vendor_per;
+
+	if (gdata->error_data_length < sizeof(*header))
+		return -ENOSPC;
+
+	printk("%s""CPER Length: %u\n", pfx, header->length);
+	if (header->validation_bits & CPER_CCIX_VALID_SOURCE_ID)
+		printk("%s""Source: %u\n", pfx, header->source_id);
+	if (header->validation_bits & CPER_CCIX_VALID_PORT_ID)
+		printk("%s""Port: %u\n", pfx, header->port_id);
+	/* Not much use if we don't have the per log, in theory it's optional */
+	if ((header->validation_bits & CPER_CCIX_VALID_PER_LOG) == 0)
+		return 0;
+
+	/* The per log header is a packed structure so needs breaking up */
+	if (gdata->error_data_length < sizeof(*header) + 8 * 4)
+		return -ENOSPC;
+
+	dw = (__u32 *)(header + 1);
+
+	printk("%s""PER Rev: %lu, Log Length: %lu\n", pfx,
+	       FIELD_GET(CCIX_PER_LOG_DW0_REV_M, dw[0]),
+	       FIELD_GET(CCIX_PER_LOG_DW0_LEN_M, dw[0]));
+	comp_type = FIELD_GET(CCIX_PER_LOG_DW1_COMP_TYPE_M, dw[1]);
+	printk("%s""Component: %s\n", pfx, cper_ccix_comp_type_str(comp_type));
+	printk("%s""ME: %lu, SevUE: %lu, SevNoComm: %lu, SevDegraded: %lu, SevDeferred %lu\n",
+	       pfx,
+	       FIELD_GET(CCIX_PER_LOG_DW0_ME_M, dw[0]),
+	       FIELD_GET(CCIX_PER_LOG_DW1_SEV_UE_M, dw[1]),
+	       FIELD_GET(CCIX_PER_LOG_DW1_SEV_NO_COMM_M, dw[1]),
+	       FIELD_GET(CCIX_PER_LOG_DW1_SEV_DEGRADED_M, dw[1]),
+	       FIELD_GET(CCIX_PER_LOG_DW1_SEV_DEFFERABLE_M, dw[1]));
+
+	/* per_type is vendor defined if VEN is set */
+	vendor_per = FIELD_GET(CCIX_PER_LOG_DW1_VEN_VAL_M, dw[1]) ?
+		true : false;
+	per_type = FIELD_GET(CCIX_PER_LOG_DW1_PER_TYPE_M, dw[1]);
+	if (vendor_per)
+		printk("%s""Protocol Error Type: Vendor%u", pfx, per_type);
+	else
+		printk("%s""Protocol Error Type: %s\n", pfx,
+		       per_type < ARRAY_SIZE(ccix_per_type_strs) ?
+		       ccix_per_type_strs[per_type] : "Reserved");
+
+	if (FIELD_GET(CCIX_PER_LOG_DW1_ADDR_VAL_M, dw[1]))
+		printk("%s""Address: 0x%llx\n", pfx,
+		       (((__u64)dw[2]) << 32) | (dw[3] & 0xFFFFFFFC));
+
+	/* Vendor defined PER message, perhaps we could print it out */
+	if (vendor_per)
+		return 0;
+
+	switch (per_type) {
+	case CCIX_MEMORY_ERROR:
+		return cper_ccix_mem_err_details(pfx, gdata);
+	default:
+		/* Vendor defined so no formatting be done */
+		break;
+	}
+	return 0;
+}
diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index b1af0de2e100..03bb27db2e87 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -474,6 +474,12 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
 			cper_print_pcie(newpfx, pcie, gdata);
 		else
 			goto err_section_too_small;
+	} else if (guid_equal(sec_type, &CPER_SEC_CCIX)) {
+		int ret;
+		/* CCIX CPER entries are variable length */
+		ret = cper_print_ccix_per(newpfx, gdata);
+		if (ret)
+			goto err_section_too_small;
 #if defined(CONFIG_ARM64) || defined(CONFIG_ARM)
 	} else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
 		struct cper_sec_proc_arm *arm_err = acpi_hest_get_payload(gdata);
diff --git a/include/linux/cper.h b/include/linux/cper.h
index 4f005d95ce88..df7a34c3ba4f 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -174,6 +174,9 @@ enum {
 #define CPER_SEC_PCIE							\
 	GUID_INIT(0xD995E954, 0xBBC1, 0x430F, 0xAD, 0x91, 0xB4, 0x4D,	\
 		  0xCB, 0x3C, 0x6F, 0x35)
+#define CPER_SEC_CCIX							\
+	GUID_INIT(0x91335EF6, 0xEBFB, 0x4478, 0xA6, 0xA6, 0x88, 0xB7,	\
+		  0x28, 0xCF, 0x75, 0xD7)
 /* Firmware Error Record Reference */
 #define CPER_SEC_FW_ERR_REC_REF						\
 	GUID_INIT(0x81212A96, 0x09ED, 0x4996, 0x94, 0x71, 0x8D, 0x72,	\
@@ -242,6 +245,10 @@ enum {
 
 #define CPER_PCIE_SLOT_SHIFT			3
 
+#define CPER_CCIX_VALID_SOURCE_ID		BIT(0)
+#define CPER_CCIX_VALID_PORT_ID			BIT(1)
+#define CPER_CCIX_VALID_PER_LOG			BIT(2)
+
 #define CPER_ARM_VALID_MPIDR			BIT(0)
 #define CPER_ARM_VALID_AFFINITY_LEVEL		BIT(1)
 #define CPER_ARM_VALID_RUNNING_STATE		BIT(2)
@@ -521,6 +528,105 @@ struct cper_sec_pcie {
 	u8	aer_info[96];
 };
 
+struct cper_sec_ccix_header {
+	__u32	length;
+	__u64	validation_bits;
+	__u8	source_id;
+	__u8	port_id;
+	__u8	reserved[2];
+};
+
+#define CCIX_PER_LOG_DW0_REV_M			GENMASK(7, 0)
+#define CCIX_PER_LOG_DW0_LEN_M			GENMASK(14, 8)
+#define CCIX_PER_LOG_DW0_ME_M			BIT(15)
+#define CCIX_PER_LOG_DW1_COMP_TYPE_M		GENMASK(15, 12)
+#define CCIX_PER_LOG_DW1_SEV_UE_M		BIT(16)
+#define CCIX_PER_LOG_DW1_SEV_NO_COMM_M		BIT(17)
+#define CCIX_PER_LOG_DW1_SEV_DEGRADED_M		BIT(18)
+#define CCIX_PER_LOG_DW1_SEV_DEFFERABLE_M	BIT(19)
+#define CCIX_PER_LOG_DW1_PER_TYPE_M		GENMASK(27, 24)
+#define CCIX_PER_LOG_DW1_ADDR_VAL_M		BIT(30)
+#define CCIX_PER_LOG_DW1_VEN_VAL_M		BIT(31)
+enum ccix_per_type {
+	CCIX_MEMORY_ERROR = 0,
+	CCIX_CACHE_ERROR = 1,
+	CCIX_ATC_ERROR = 2,
+	CCIX_PORT_ERROR = 3,
+	CCIX_LINK_ERROR = 4,
+	CCIX_AGENT_INTERNAL_ERROR = 5,
+};
+
+#define CCIX_PER_LOG_HEADER_DWS 8
+
+struct cper_sec_ccix_mem_error {
+	__u32	validation_bits;
+#define CCIX_MEM_ERR_GENERIC_MEM_VALID		BIT(0)
+#define CCIX_MEM_ERR_OP_VALID			BIT(1)
+#define CCIX_MEM_ERR_MEM_ERR_TYPE_VALID		BIT(2)
+#define CCIX_MEM_ERR_CARD_VALID			BIT(3)
+#define CCIX_MEM_ERR_BANK_VALID			BIT(4)
+#define CCIX_MEM_ERR_DEVICE_VALID		BIT(5)
+#define CCIX_MEM_ERR_ROW_VALID			BIT(6)
+#define CCIX_MEM_ERR_COL_VALID			BIT(7)
+#define CCIX_MEM_ERR_RANK_VALID			BIT(8)
+#define CCIX_MEM_ERR_BIT_POS_VALID		BIT(9)
+#define CCIX_MEM_ERR_CHIP_ID_VALID		BIT(10)
+#define CCIX_MEM_ERR_VENDOR_DATA_VALID		BIT(11)
+#define CCIX_MEM_ERR_MOD_VALID			BIT(12)
+#define CCIX_MEM_ERR_SPEC_TYPE_VALID		BIT(13)
+
+	__u8	fru;
+	__u8	reserved;
+	__u16	length; /* Includes vendor specific log info */
+	__u8	pool_generic_type;
+	__u8	op_type;
+	__u8	memory_error_type;
+	__u8	card;
+	__u16	module;
+	__u16	bank;
+	__u32	device;
+	__u32	row;
+	__u32	column;
+	__u32	rank;
+	__u8	bit_pos;
+	__u8	chip_id;
+	__u8	pool_specific_type;
+	__u32	vendor_data[];
+};
+
+struct cper_ccix_mem_error {
+	struct cper_sec_ccix_header header;
+	__u32 ccix_header[CCIX_PER_LOG_HEADER_DWS];
+	struct cper_sec_ccix_mem_error mem_record;
+};
+
+static inline u16 ccix_mem_err_ven_len_get(struct cper_ccix_mem_error *mem_err)
+{
+	if (mem_err->mem_record.validation_bits &
+	    CCIX_MEM_ERR_VENDOR_DATA_VALID)
+		return mem_err->mem_record.vendor_data[0] & 0xFFFF;
+	else
+		return 0;
+}
+
+struct cper_ccix_mem_err_compact {
+	__u32	validation_bits;
+	__u8	mem_err_type;
+	__u8	pool_generic_type;
+	__u8	pool_specific_type;
+	__u8	op_type;
+	__u8	card;
+	__u16	module;
+	__u16	bank;
+	__u32	device;
+	__u32	row;
+	__u32	column;
+	__u32	rank;
+	__u8	bit_pos;
+	__u8	chip_id;
+	__u8	fru;
+};
+
 /* Reset to default packing */
 #pragma pack()
 
@@ -535,6 +641,18 @@ void cper_mem_err_pack(const struct cper_sec_mem_err *,
 		       struct cper_mem_err_compact *);
 const char *cper_mem_err_unpack(struct trace_seq *,
 				struct cper_mem_err_compact *);
+void cper_ccix_mem_err_pack(const struct cper_sec_ccix_mem_error *mem_record,
+			    struct cper_ccix_mem_err_compact *cmem_err,
+			    const u16 vendor_data_len,
+			    u8 *vendor_data);
+const char *cper_ccix_mem_err_unpack(struct trace_seq *p,
+				     struct cper_ccix_mem_err_compact *cmem_err);
+const char *cper_ccix_mem_err_type_str(unsigned int error_type);
+const char *cper_ccix_comp_type_str(u8 comp_type);
+struct acpi_hest_generic_data;
+int cper_print_ccix_per(const char *pfx,
+			struct acpi_hest_generic_data *gdata);
+
 void cper_print_proc_arm(const char *pfx,
 			 const struct cper_sec_proc_arm *proc);
 void cper_print_proc_ia(const char *pfx,
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index 36c5c5e38c1d..560e55958561 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -14,6 +14,7 @@
 #include <linux/cper.h>
 #include <linux/mm.h>
 
+#include <linux/bitfield.h>
 /*
  * MCE Extended Error Log trace event
  *
@@ -338,6 +339,84 @@ TRACE_EVENT(aer_event,
 			"Not available")
 );
 
+#if defined(CONFIG_ACPI_APEI_CCIX)
+/*
+ * CCIX PER log memory error trace event
+ *
+ * These events are generated when hardware detects a corrected or
+ * uncorrected event.
+ *
+ * Some elements of the record are not included
+ * - PER version (tracepoint should remain compatible across versions)
+ * - Multiple Error
+ */
+TRACE_EVENT(ccix_memory_error_event,
+	TP_PROTO(struct cper_ccix_mem_error *mem,
+		 u32 err_seq,
+		 u8 sev,
+		 u16 ven_len),
+
+	TP_ARGS(mem, err_seq, sev, ven_len),
+
+	TP_STRUCT__entry(
+		__field(u32, err_seq)
+		__field(u8, sev)
+		__field(u8, sevdetail)
+		__field(u8, source)
+		__field(u8, component)
+		__field(u64, pa)
+		__field(u8, pa_mask_lsb)
+		__field_struct(struct cper_ccix_mem_err_compact, data)
+		__field(u16, vendor_data_length)
+		__dynamic_array(u8, vendor_data, ven_len)
+	),
+
+	TP_fast_assign(
+		__entry->err_seq = err_seq;
+		__entry->sev = sev;
+		__entry->sevdetail =
+			FIELD_GET(CCIX_PER_LOG_DW1_SEV_UE_M |
+				  CCIX_PER_LOG_DW1_SEV_NO_COMM_M |
+				  CCIX_PER_LOG_DW1_SEV_DEGRADED_M |
+				  CCIX_PER_LOG_DW1_SEV_DEFFERABLE_M,
+						   mem->ccix_header[1]);
+		if (mem->header.validation_bits & 0x1)
+			__entry->source = mem->header.source_id;
+		else
+			__entry->source = ~0;
+		__entry->component = FIELD_GET(CCIX_PER_LOG_DW1_COMP_TYPE_M,
+					       mem->ccix_header[1]);
+		if (mem->ccix_header[1] & CCIX_PER_LOG_DW1_ADDR_VAL_M) {
+			__entry->pa = (u64)mem->ccix_header[2] << 32 |
+				(mem->ccix_header[3] & 0xfffffffc);
+			__entry->pa_mask_lsb = mem->ccix_header[4] & 0xff;
+		} else {
+			__entry->pa = ~0ull;
+			__entry->pa_mask_lsb = ~0;
+		}
+		__entry->vendor_data_length = ven_len ? ven_len - 4 : 0;
+		cper_ccix_mem_err_pack(&mem->mem_record, &__entry->data,
+				       __entry->vendor_data_length,
+				       __get_dynamic_array(vendor_data));
+	),
+
+	TP_printk("{%d} %s CCIX PER Memory Error in %s SevUE:%d SevNoComm:%d SevDegraded:%d SevDeferred:%d physical addr: %016llx (mask: %x) %s vendor:%s",
+		__entry->err_seq,
+		cper_severity_str(__entry->sev),
+		cper_ccix_comp_type_str(__entry->component),
+		  __entry->sevdetail & BIT(0) ? 1 : 0,
+		  __entry->sevdetail & BIT(1) ? 1 : 0,
+		  __entry->sevdetail & BIT(2) ? 1 : 0,
+		  __entry->sevdetail & BIT(3) ? 1 : 0,
+		__entry->pa,
+		__entry->pa_mask_lsb,
+		cper_ccix_mem_err_unpack(p, &__entry->data),
+		__print_hex(__get_dynamic_array(vendor_data),
+			    __entry->vendor_data_length)
+	)
+);
+#endif
+
 /*
  * memory-failure recovery action result event
  *
-- 
2.20.1

