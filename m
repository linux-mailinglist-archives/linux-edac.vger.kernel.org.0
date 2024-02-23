Return-Path: <linux-edac+bounces-667-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EE786142A
	for <lists+linux-edac@lfdr.de>; Fri, 23 Feb 2024 15:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F58F1F2417E
	for <lists+linux-edac@lfdr.de>; Fri, 23 Feb 2024 14:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C482F6FAD;
	Fri, 23 Feb 2024 14:37:50 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB568BE7;
	Fri, 23 Feb 2024 14:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699070; cv=none; b=uIyaFTmQBBuFifsUg2MrhVoHYRzzCnpGVD+LAPtO4/G6EJa8mjjSRBCem71c8UOuI+p3RW6mNJPX3MfKl3iUyo/QB/VBDsnRIlJoRo+8AywyJBxMwYZ1O2orOcUqtDLckFph0gqMaLf0LnrPAb10w5//0WFA381mUKkWHA3bm3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699070; c=relaxed/simple;
	bh=QQVv86g7bqybHD9Ctz5R/WPEsgeUAAHVHhIcWKBXBZc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lgt2cxfVv7tXWrn3ld2HjF+u/e+VIbP00DuSXQZ5Pg/d5slaCGrMPSFP5EV1cqp6prgI8i3wMMOpjCm07HlkmKw/+6GoWlQGzDdNyLV0qvTuLUFrOLTkY9g1b5a/shBTFHdv3duXITbizW7YXPEX1bWojLkfJmKvFWsBPzKZoeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ThCDK00m9z6JB2X;
	Fri, 23 Feb 2024 22:33:21 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id A21C21410B3;
	Fri, 23 Feb 2024 22:37:46 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 14:37:45 +0000
From: <shiju.jose@huawei.com>
To: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-mm@kvack.org>, <dan.j.williams@intel.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>
CC: <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<david@redhat.com>, <Vilas.Sridharan@amd.com>, <leo.duran@amd.com>,
	<Yazen.Ghannam@amd.com>, <rientjes@google.com>, <jiaqiyan@google.com>,
	<tony.luck@intel.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <naoya.horiguchi@nec.com>,
	<james.morse@arm.com>, <jthoughton@google.com>, <somasundaram.a@hpe.com>,
	<erdemaktas@google.com>, <pgonda@google.com>, <duenwen@google.com>,
	<mike.malvestuto@intel.com>, <gthelen@google.com>,
	<wschwartz@amperecomputing.com>, <dferguson@amperecomputing.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH v7 09/12] ACPICA: ACPI 6.5: Add support for RAS2 table
Date: Fri, 23 Feb 2024 22:37:20 +0800
Message-ID: <20240223143723.1574-10-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20240223143723.1574-1-shiju.jose@huawei.com>
References: <20240223143723.1574-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500006.china.huawei.com (7.191.161.198)

From: Shiju Jose <shiju.jose@huawei.com>

Add support for ACPI RAS2 feature table(RAS2) defined in the ACPI 6.5
Specification & upwards revision, section 5.2.21.

The RAS2 table provides interfaces for platform RAS features. RAS2 offers
the same services as RASF, but is more scalable than the latter.
RAS2 supports independent RAS controls and capabilities for a given RAS
feature for multiple instances of the same component in a given system.
The platform can support either RAS2 or RASF but not both.

Link: https://github.com/acpica/acpica/pull/899

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 include/acpi/actbl2.h | 137 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 9775384d61c6..15c271657f9f 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -47,6 +47,7 @@
 #define ACPI_SIG_PPTT           "PPTT"	/* Processor Properties Topology Table */
 #define ACPI_SIG_PRMT           "PRMT"	/* Platform Runtime Mechanism Table */
 #define ACPI_SIG_RASF           "RASF"	/* RAS Feature table */
+#define ACPI_SIG_RAS2           "RAS2"	/* RAS2 Feature table */
 #define ACPI_SIG_RGRT           "RGRT"	/* Regulatory Graphics Resource Table */
 #define ACPI_SIG_RHCT           "RHCT"	/* RISC-V Hart Capabilities Table */
 #define ACPI_SIG_SBST           "SBST"	/* Smart Battery Specification Table */
@@ -2751,6 +2752,142 @@ enum acpi_rasf_status {
 #define ACPI_RASF_ERROR                 (1<<2)
 #define ACPI_RASF_STATUS                (0x1F<<3)
 
+/*******************************************************************************
+ *
+ * RAS2 - RAS2 Feature Table (ACPI 6.5)
+ *        Version 2
+ *
+ *
+ ******************************************************************************/
+
+struct acpi_table_ras2 {
+	struct acpi_table_header header;        /* Common ACPI table header */
+	u16 reserved;
+	u16 num_pcc_descs;
+};
+
+/*
+ * RAS2 Platform Communication Channel Descriptor
+ */
+
+struct acpi_ras2_pcc_desc {
+	u8 channel_id;
+	u16 reserved;
+	u8 feature_type;
+	u32 instance;
+};
+
+/*
+ * RAS2 Platform Communication Channel Shared Memory Region
+ */
+
+struct acpi_ras2_shared_memory {
+	u32 signature;
+	u16 command;
+	u16 status;
+	u16 version;
+	u8 features[16];
+	u8 set_capabilities[16];
+	u16 num_parameter_blocks;
+	u32 set_capabilities_status;
+};
+
+/* RAS2 Parameter Block Structure Header */
+
+struct acpi_ras2_parameter_block {
+	u16 type;
+	u16 version;
+	u16 length;
+};
+
+/*
+ * RAS2 Parameter Block Structure for PATROL_SCRUB
+ */
+
+struct acpi_ras2_patrol_scrub_parameter {
+	struct acpi_ras2_parameter_block header;
+	u16 patrol_scrub_command;
+	u64 requested_address_range[2];
+	u64 actual_address_range[2];
+	u32 flags;
+	u32 scrub_params_out;
+	u32 scrub_params_in;
+};
+
+/* Masks for Flags field above */
+
+#define ACPI_RAS2_SCRUBBER_RUNNING      1
+
+/*
+ * RAS2 Parameter Block Structure for LA2PA_TRANSLATION
+ */
+
+struct acpi_ras2_la2pa_translation_parameter {
+	struct acpi_ras2_parameter_block header;
+	u16 addr_translation_command;
+	u64 sub_instance_id;
+	u64 logical_address;
+	u64 physical_address;
+	u32 status;
+};
+
+/* Channel Commands */
+
+enum acpi_ras2_commands {
+	ACPI_RAS2_EXECUTE_RAS2_COMMAND = 1
+};
+
+/* Platform RAS2 Features */
+
+enum acpi_ras2_features {
+	ACPI_RAS2_PATROL_SCRUB_SUPPORTED = 0,
+	ACPI_RAS2_LA2PA_TRANSLATION = 1
+};
+
+/* RAS2 Patrol Scrub Commands */
+
+enum acpi_ras2_patrol_scrub_commands {
+	ACPI_RAS2_GET_PATROL_PARAMETERS = 1,
+	ACPI_RAS2_START_PATROL_SCRUBBER = 2,
+	ACPI_RAS2_STOP_PATROL_SCRUBBER = 3
+};
+
+/* RAS2 LA2PA Translation Commands */
+
+enum acpi_ras2_la2pa_translation_commands {
+	ACPI_RAS2_GET_LA2PA_TRANSLATION = 1
+};
+
+/* RAS2 LA2PA Translation Status values */
+
+enum acpi_ras2_la2pa_translation_status {
+	ACPI_RAS2_LA2PA_TRANSLATION_SUCCESS = 0,
+	ACPI_RAS2_LA2PA_TRANSLATION_FAIL = 1
+};
+
+/* Channel Command flags */
+
+#define ACPI_RAS2_GENERATE_SCI          (1<<15)
+
+/* Status values */
+
+enum acpi_ras2_status {
+	ACPI_RAS2_SUCCESS = 0,
+	ACPI_RAS2_NOT_VALID  = 1,
+	ACPI_RAS2_NOT_SUPPORTED = 2,
+	ACPI_RAS2_BUSY = 3,
+	ACPI_RAS2_FAILED = 4,
+	ACPI_RAS2_ABORTED = 5,
+	ACPI_RAS2_INVALID_DATA = 6
+};
+
+/* Status flags */
+
+#define ACPI_RAS2_COMMAND_COMPLETE      (1)
+#define ACPI_RAS2_SCI_DOORBELL          (1<<1)
+#define ACPI_RAS2_ERROR                 (1<<2)
+#define ACPI_RAS2_STATUS                (0x1F<<3)
+
 /*******************************************************************************
  *
  * RGRT - Regulatory Graphics Resource Table
-- 
2.34.1


