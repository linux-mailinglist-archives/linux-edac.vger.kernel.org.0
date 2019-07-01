Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4473637452
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2019 14:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfFFMhm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 6 Jun 2019 08:37:42 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18093 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727703AbfFFMhk (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 6 Jun 2019 08:37:40 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1999F571A6B648DEC0A6;
        Thu,  6 Jun 2019 20:37:38 +0800 (CST)
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Thu, 6 Jun 2019 20:37:29 +0800
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-efi@vger.kernel.org>
CC:     <linuxarm@huawei.com>, <rjw@rjwysocki.net>, <tony.luck@intel.com>,
        <bp@alien8.de>, <james.morse@arm.com>, <ard.beisheuvel@linaro.org>,
        <nariman.poushin@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 5/6] efi / ras: CCIX Link error reporting
Date:   Thu, 6 Jun 2019 20:36:53 +0800
Message-ID: <20190606123654.78973-6-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606123654.78973-1-Jonathan.Cameron@huawei.com>
References: <20190606123654.78973-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.41.22]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The CCIX 1.0 Base Specification defines a protocol layer
CCIX link and related error reporting mechanism.
The UEFI 2.8 specification includes a CCIX CPER record for
firmware first handling to report these errors to the
operating system.

This patch is very similar to the support previously added
for CCIX Memory Errors and provides both logging and RAS
tracepoint for this error class.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/acpi/apei/ghes.c         |   4 +
 drivers/firmware/efi/cper-ccix.c | 140 +++++++++++++++++++++++++++++++
 include/linux/cper.h             |  48 +++++++++++
 include/ras/ras_event.h          |  65 ++++++++++++++
 4 files changed, 257 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 2b2c0df204523..2cabac7a344c7 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -516,6 +516,10 @@ static void ghes_handle_ccix_per(struct acpi_hest_generic_data *gdata, int sev)
 		trace_ccix_port_error_event(payload, err_seq, sev,
 					    ccix_port_err_ven_len_get(payload));
 		break;
+	case CCIX_LINK_ERROR:
+		trace_ccix_link_error_event(payload, err_seq, sev,
+					    ccix_link_err_ven_len_get(payload));
+		break;
 	default:
 		/* Unknown error type */
 		pr_info("CCIX error of unknown or vendor defined type\n");
diff --git a/drivers/firmware/efi/cper-ccix.c b/drivers/firmware/efi/cper-ccix.c
index fcf77834b9894..1a9661a6c49f4 100644
--- a/drivers/firmware/efi/cper-ccix.c
+++ b/drivers/firmware/efi/cper-ccix.c
@@ -503,6 +503,86 @@ static int cper_ccix_port_err_details(const char *pfx,
 	return 0;
 }
 
+static const char * const ccix_link_err_type_strs[] = {
+	"Generic Error",
+	"Credit Underflow",
+	"Credit Overflow",
+	"Unusable Credit Received",
+	"Link Credit Timeout",
+};
+
+static const char *cper_ccix_link_err_type_str(__u8 op)
+{
+	return op < ARRAY_SIZE(ccix_link_err_type_strs) ?
+		ccix_link_err_type_strs[op] : "Reserved";
+}
+
+static const char * const ccix_link_credit_type_strs[] = {
+	"Memory",
+	"Snoop",
+	"Data",
+	"Misc",
+};
+
+static const char *cper_ccix_link_credit_type_str(__u8 op)
+{
+	return op < ARRAY_SIZE(ccix_link_credit_type_strs) ?
+		ccix_link_credit_type_strs[op] : "Reserved";
+}
+
+static int cper_ccix_link_err_details(const char *pfx,
+				     struct acpi_hest_generic_data *gdata)
+{
+	struct cper_ccix_link_error *full_link_err;
+	struct cper_sec_ccix_link_error *link_err;
+	u16 vendor_data_len;
+	int i;
+
+	if (gdata->error_data_length < sizeof(*full_link_err))
+		return -ENOSPC;
+
+	full_link_err = acpi_hest_get_payload(gdata);
+
+	link_err = &full_link_err->link_record;
+
+	if (link_err->validation_bits & CCIX_LINK_ERR_TYPE_VALID)
+		printk("%s""Error Type: %s\n", pfx,
+		       cper_ccix_link_err_type_str(link_err->err_type));
+
+	if (link_err->validation_bits & CCIX_LINK_ERR_OP_VALID)
+		printk("%s""Operation: %s\n", pfx,
+		       cper_ccix_port_err_op_str(link_err->op_type));
+
+	if (link_err->validation_bits & CCIX_LINK_ERR_LINK_ID_VALID)
+		printk("%s""Link ID: %d\n", pfx, link_err->link_id);
+
+	if (link_err->validation_bits & CCIX_LINK_ERR_CREDIT_TYPE_VALID)
+		printk("%s""Credit Type: %s\n", pfx,
+		       cper_ccix_link_credit_type_str(link_err->credit_type));
+
+	/* CHECK THE AER EQUIVALENT */
+	if (link_err->validation_bits & CCIX_LINK_ERR_MESSAGE_VALID) {
+		for (i = 0; i < ARRAY_SIZE(link_err->message); i++)
+			printk("%s""Message%d: 0x%08x\n", pfx, i, link_err->message[i]);
+	}
+
+	if (link_err->validation_bits & CCIX_LINK_ERR_VENDOR_DATA_VALID) {
+		if (gdata->error_data_length < sizeof(*full_link_err) + 4)
+			return -ENOSPC;
+
+		vendor_data_len = link_err->vendor_data[0] & GENMASK(15, 0);
+		if (gdata->error_data_length < sizeof(*full_link_err) + vendor_data_len)
+			return -ENOSPC;
+
+		for (i = 0; i < vendor_data_len/4 - 1; i++)
+			printk("%s""Vendor%d: 0x%08x\n", pfx, i,
+			       link_err->vendor_data[i + 1]);
+
+	}
+
+	return 0;
+}
+
 int cper_print_ccix_per(const char *pfx, struct acpi_hest_generic_data *gdata)
 {
 	struct cper_sec_ccix_header *header = acpi_hest_get_payload(gdata);
@@ -570,6 +650,8 @@ int cper_print_ccix_per(const char *pfx, struct acpi_hest_generic_data *gdata)
 		return cper_ccix_atc_err_details(pfx, gdata);
 	case CCIX_PORT_ERROR:
 		return cper_ccix_port_err_details(pfx, gdata);
+	case CCIX_LINK_ERROR:
+		return cper_ccix_link_err_details(pfx, gdata);
 	default:
 		/* Vendor defined so no formatting be done */
 		break;
@@ -731,3 +813,61 @@ const char *cper_ccix_port_err_unpack(struct trace_seq *p,
 
 	return ret;
 }
+
+void cper_ccix_link_err_pack(const struct cper_sec_ccix_link_error *link_record,
+			     struct cper_ccix_link_err_compact *clink_err,
+			     const u16 vendor_data_len,
+			     u8 *vendor_data)
+{
+	clink_err->validation_bits = link_record->validation_bits;
+	clink_err->err_type = link_record->err_type;
+	clink_err->op_type = link_record->op_type;
+	clink_err->link_id = link_record->link_id;
+	clink_err->credit_type = link_record->credit_type;
+	memcpy(clink_err->message, link_record->message,
+	       sizeof(clink_err->message));
+
+	memcpy(vendor_data, &link_record->vendor_data[1], vendor_data_len);
+}
+
+static int cper_ccix_err_link_location(struct cper_ccix_link_err_compact *clink_err,
+				       char *msg)
+{
+	u32 len = CPER_REC_LEN - 1;
+	u32 n = 0;
+
+	if (!msg)
+		return 0;
+
+	if (clink_err->validation_bits & CCIX_LINK_ERR_TYPE_VALID)
+		n += snprintf(msg + n, len, "Error Type: %s ",
+			      cper_ccix_link_err_type_str(clink_err->err_type));
+
+
+	if (clink_err->validation_bits & CCIX_LINK_ERR_OP_VALID)
+		n += snprintf(msg + n, len, "Op: %s ",
+			     cper_ccix_port_err_op_str(clink_err->op_type));
+
+	if (clink_err->validation_bits & CCIX_LINK_ERR_LINK_ID_VALID)
+		n += snprintf(msg + n, len, "Link ID: %d ", clink_err->link_id);
+
+	if (clink_err->validation_bits & CCIX_LINK_ERR_CREDIT_TYPE_VALID)
+		n += snprintf(msg + n, len, "Credit Type: %s ",
+			      cper_ccix_link_credit_type_str(clink_err->credit_type));
+
+	/* MESSAGE TODO */
+	return n;
+}
+
+const char *cper_ccix_link_err_unpack(struct trace_seq *p,
+				      struct cper_ccix_link_err_compact *clink_err)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+
+	if (cper_ccix_err_link_location(clink_err, rcd_decode_str))
+		trace_seq_printf(p, "%s", rcd_decode_str);
+
+	trace_seq_putc(p, '\0');
+
+	return ret;
+}
diff --git a/include/linux/cper.h b/include/linux/cper.h
index cd023e0309bf4..05d73604dfd2b 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -754,6 +754,47 @@ struct cper_ccix_port_err_compact {
 	__u8	op_type;
 };
 
+struct cper_sec_ccix_link_error {
+	__u32	validation_bits;
+#define CCIX_LINK_ERR_OP_VALID			BIT(0)
+#define CCIX_LINK_ERR_TYPE_VALID		BIT(1)
+#define CCIX_LINK_ERR_LINK_ID_VALID		BIT(2)
+#define CCIX_LINK_ERR_CREDIT_TYPE_VALID		BIT(3)
+#define CCIX_LINK_ERR_MESSAGE_VALID		BIT(4)
+#define CCIX_LINK_ERR_VENDOR_DATA_VALID		BIT(5)
+	__u16	length; /* Includes vendor specific log info */
+	__u8	op_type;
+	__u8	err_type;
+	__u8	link_id;
+	__u8	credit_type;
+	__u16	reserved;
+	__u32	message[8];
+	__u32	vendor_data[];
+};
+
+struct cper_ccix_link_error {
+	struct cper_sec_ccix_header header;
+	__u32 ccix_header[CCIX_PER_LOG_HEADER_DWS];
+	struct cper_sec_ccix_link_error link_record;
+};
+
+static inline u16 ccix_link_err_ven_len_get(struct cper_ccix_link_error *link_err)
+{
+	if (link_err->link_record.validation_bits & CCIX_LINK_ERR_VENDOR_DATA_VALID)
+		return link_err->link_record.vendor_data[0] & 0xFFFF;
+	else
+		return 0;
+}
+
+struct cper_ccix_link_err_compact {
+	__u32	validation_bits;
+	__u32	message[8];
+	__u8	err_type;
+	__u8	op_type;
+	__u8	link_id;
+	__u8	credit_type;
+};
+
 /* Reset to default packing */
 #pragma pack()
 
@@ -799,6 +840,13 @@ void cper_ccix_port_err_pack(const struct cper_sec_ccix_port_error *port_record,
 const char *cper_ccix_port_err_unpack(struct trace_seq *p,
 				      struct cper_ccix_port_err_compact *cport_err);
 
+void cper_ccix_link_err_pack(const struct cper_sec_ccix_link_error *link_record,
+			     struct cper_ccix_link_err_compact *clink_err,
+			     const u16 vendor_data_len,
+			     u8 *vendor_data);
+const char *cper_ccix_link_err_unpack(struct trace_seq *p,
+				      struct cper_ccix_link_err_compact *clink_err);
+
 struct acpi_hest_generic_data;
 int cper_print_ccix_per(const char *pfx,
 			struct acpi_hest_generic_data *gdata);
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index 52ac3f2d4c117..bfe1c64b9db0b 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -614,6 +614,71 @@ TRACE_EVENT(ccix_port_error_event,
 	)
 );
 
+TRACE_EVENT(ccix_link_error_event,
+	TP_PROTO(struct cper_ccix_link_error *err,
+		 u32 err_seq,
+		 u8 sev, u16 ven_len),
+
+	TP_ARGS(err, err_seq, sev, ven_len),
+
+	TP_STRUCT__entry(
+		__field(u32, err_seq)
+		__field(u8, sev)
+		__field(u8, sevdetail)
+		__field(u8, source)
+		__field(u8, component)
+		__field(u64, pa)
+		__field(u8, pa_mask_lsb)
+		__field_struct(struct cper_ccix_link_err_compact, data)
+		__field(u16, vendor_data_length)
+		__dynamic_array(u8, vendor_data, ven_len)
+	),
+
+	TP_fast_assign(
+		__entry->err_seq = err_seq;
+
+		__entry->sev = sev;
+		__entry->sevdetail = FIELD_GET(CCIX_PER_LOG_DW1_SEV_UE_M |
+			CCIX_PER_LOG_DW1_SEV_NO_COMM_M |
+			CCIX_PER_LOG_DW1_SEV_DEGRADED_M |
+			CCIX_PER_LOG_DW1_SEV_DEFFERABLE_M,
+			err->ccix_header[1]);
+		if (err->header.validation_bits & 0x1)
+			__entry->source = err->header.source_id;
+		else
+			__entry->source = ~0;
+		__entry->component = FIELD_GET(CCIX_PER_LOG_DW1_COMP_TYPE_M,
+						   err->ccix_header[1]);
+		if (err->ccix_header[1] & CCIX_PER_LOG_DW1_ADDR_VAL_M) {
+			__entry->pa = (u64)err->ccix_header[2] << 32 |
+				(err->ccix_header[3] & 0xfffffffc);
+			__entry->pa_mask_lsb = err->ccix_header[4] & 0xff;
+		} else {
+			__entry->pa = ~0ull;
+			__entry->pa_mask_lsb = ~0;
+		}
+		/* Do not store the vendor data header length */
+		__entry->vendor_data_length = ven_len ? ven_len - 4 : 0;
+		cper_ccix_link_err_pack(&err->link_record, &__entry->data,
+					__entry->vendor_data_length,
+					__get_dynamic_array(vendor_data));
+	),
+
+	TP_printk("{%d} %s CCIX PER Link Error in %s SevUE:%d SevNoComm:%d SevDegraded:%d SevDeferred:%d physical addr: %016llx (mask: %x) %s vendor:%s",
+		__entry->err_seq,
+		cper_severity_str(__entry->sev),
+		cper_ccix_comp_type_str(__entry->component),
+		__entry->sevdetail & BIT(0) ? 1 : 0,
+		__entry->sevdetail & BIT(1) ? 1 : 0,
+		__entry->sevdetail & BIT(2) ? 1 : 0,
+		__entry->sevdetail & BIT(3) ? 1 : 0,
+		__entry->pa,
+		__entry->pa_mask_lsb,
+		cper_ccix_link_err_unpack(p, &__entry->data),
+		__print_hex(__get_dynamic_array(vendor_data), __entry->vendor_data_length)
+	)
+);
+
 /*
  * memory-failure recovery action result event
  *
-- 
2.20.1

