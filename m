Return-Path: <linux-edac+bounces-1513-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C66E492FB0A
	for <lists+linux-edac@lfdr.de>; Fri, 12 Jul 2024 15:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 477F51F233EF
	for <lists+linux-edac@lfdr.de>; Fri, 12 Jul 2024 13:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31ED171E5A;
	Fri, 12 Jul 2024 13:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2EqWA7C"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3CC171E4B;
	Fri, 12 Jul 2024 13:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720790124; cv=none; b=uzLAyEEhGewC5mbgoYOMm0f75Y8vpLgx9TgstwbPNRNV9qb2/grqvpgJ5c8nEVwquMZ0q+CR0cr+LBnZzMyuvRDBxEMubPBcMSqdDeTjFfpTwI3PDJZ9pc0k/UWvah6KVYUiHGx+JQMNoFnoR63YzR8qSmUWsvczf1z0qHc214Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720790124; c=relaxed/simple;
	bh=8fT3iZX4Ak9UXbYdPywtW7xLXPjIWOMseP9okwfRJuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KNlJXaonX5jSLBLC5Y4j14LHnO8/QJdCTRa9uVNTD0HQpTSk8i+6MdjX1blpaSW5JjlvusxzJ3GzfiAaRrM22RF0e9l7qGYt9IOszmZEdVPXD5b/UMNPGV22hHn2ySwVg01g/i0cRYnKhUhT807Ev2pEKZdWRkabRhVAqBykAZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2EqWA7C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29EB5C4AF0E;
	Fri, 12 Jul 2024 13:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720790124;
	bh=8fT3iZX4Ak9UXbYdPywtW7xLXPjIWOMseP9okwfRJuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U2EqWA7CHtiDiiyTRgXZU7WHF3m0LWOjFPJPY81n2Nd11kwBzZ/GxNWTzFBGamcu1
	 zdH8uqTMneNnuxECk5b6dEzbihDQGBlOM2XdrmIjaMoRVAKZpU7G464DS3mRzF/5hg
	 x8yF5h2mWrJlLhyX3S7MqYhL3L3OUPg6CGeo480MhtkU3THgm3Ve67nL+1nXouIwBy
	 eifKOq8k0Q62gnKCZTx/xRqqgY365VwIxXEnU0h7ftPTp5+GE2RvBKJ0aE9q5cjDvV
	 EXGIR5ruwIwUi47FgnFkbrjaW1na6T3HbvHn2MVZek8t+PE9nYJPtu+aEU2QwD/185
	 uG0mqUOV5WUZw==
Received: from mchehab by mail.kernel.org with local (Exim 4.97.1)
	(envelope-from <mchehab@kernel.org>)
	id 1sSG7K-00000003iEH-1bpp;
	Fri, 12 Jul 2024 15:15:18 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"Shiju Jose" <shiju.jose@huawei.com>,
	Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>,
	Igor Mammedov <imammedo@redhat.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 6/7] acpi/ghes: update comments to point to newer ACPI specs
Date: Fri, 12 Jul 2024 15:15:13 +0200
Message-ID: <0cdc463665c98c017020d791d36659a879372c1f.1720789922.git.mchehab+huawei@kernel.org>
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

There is one reference to ACPI 4.0 and several references
to ACPI 6.x versions.

Update them to point to ACPI 6.5 whenever possible.

There's one reference that was kept pointing to ACPI 6.4,
though, with HEST revision 1.

ACPI 6.5 now defines HEST revision 2, and defined a new
way to handle source types starting from 12. According
with ACPI 6.5 revision history:

	2312 Update to the HEST table and adding new error
	     source descriptor - Table 18.2.

Yet, the spec doesn't define yet any new source
descriptors. It just defines a different behavior when
source type is above 11.

I also double-checked GHES implementation on an open
source project (Linux Kernel). Currently upstream
doesn't currently handle HEST revision, ignoring such
field.

In any case, revision 2 seems to be backward-compatible
with revison 1 when type <= 11 and just one error is
contained on a HEST record.

So, while it is probably safe to update it, there's no
real need. So, let's keep the implementation using
an ACPI 6.4 compatible table, e. g. HEST revision 1.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/ghes.c | 48 ++++++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 6075ef5893ce..ebf1b812aaaa 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -45,9 +45,9 @@
 #define GAS_ADDR_OFFSET 4
 
 /*
- * The total size of Generic Error Data Entry
- * ACPI 6.1/6.2: 18.3.2.7.1 Generic Error Data,
- * Table 18-343 Generic Error Data Entry
+ * The total size of Generic Error Data Entry before data field
+ * ACPI 6.5: 18.3.2.7.1 Generic Error Data,
+ * Table 18.12 Generic Error Data Entry
  */
 #define ACPI_GHES_DATA_LENGTH               72
 
@@ -65,8 +65,8 @@
 
 /*
  * Total size for Generic Error Status Block except Generic Error Data Entries
- * ACPI 6.2: 18.3.2.7.1 Generic Error Data,
- * Table 18-380 Generic Error Status Block
+ * ACPI 6.5: 18.3.2.7.1 Generic Error Data,
+ * Table 18.11 Generic Error Status Block
  */
 #define ACPI_GHES_GESB_SIZE                 20
 
@@ -82,7 +82,8 @@ enum AcpiGenericErrorSeverity {
 
 /*
  * Hardware Error Notification
- * ACPI 4.0: 17.3.2.7 Hardware Error Notification
+ * ACPI 6.5: 18.3.2.9 Hardware Error Notification,
+ * Table 18.14 - Hardware Error Notification Structure
  * Composes dummy Hardware Error Notification descriptor of specified type
  */
 static void build_ghes_hw_error_notification(GArray *table, const uint8_t type)
@@ -112,7 +113,8 @@ static void build_ghes_hw_error_notification(GArray *table, const uint8_t type)
 
 /*
  * Generic Error Data Entry
- * ACPI 6.1: 18.3.2.7.1 Generic Error Data
+ * ACPI 6.5: 18.3.2.7.1 Generic Error Data,
+ * Table 18.12 - Generic Error Data Entry
  */
 static void acpi_ghes_generic_error_data(GArray *table,
                 const uint8_t *section_type, uint32_t error_severity,
@@ -148,7 +150,8 @@ static void acpi_ghes_generic_error_data(GArray *table,
 
 /*
  * Generic Error Status Block
- * ACPI 6.1: 18.3.2.7.1 Generic Error Data
+ * ACPI 6.5: 18.3.2.7.1 Generic Error Data,
+ * Table 18.11 - Generic Hardware Error Source Structure
  */
 static void acpi_ghes_generic_error_status(GArray *table, uint32_t block_status,
                 uint32_t raw_data_offset, uint32_t raw_data_length,
@@ -429,15 +432,18 @@ void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
         0, sizeof(uint64_t), ACPI_GHES_ERRORS_FW_CFG_FILE, 0);
 }
 
-/* Build Generic Hardware Error Source version 2 (GHESv2) */
+/*
+ * Build Generic Hardware Error Source version 2 (GHESv2)
+ * ACPI 6.5: 18.3.2.8 Generic Hardware Error Source version 2 (GHESv2 - Type 10),
+ * Table 18.13: Generic Hardware Error Source version 2 (GHESv2)
+ */
 static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
 {
     uint64_t address_offset;
-    /*
-     * Type:
-     * Generic Hardware Error Source version 2(GHESv2 - Type 10)
-     */
+    /* Type: (GHESv2 - Type 10) */
     build_append_int_noprefix(table_data, ACPI_GHES_SOURCE_GENERIC_ERROR_V2, 2);
+
+    /* ACPI 6.5: Table 18.10 - Generic Hardware Error Source Structure */
     /* Source Id */
     build_append_int_noprefix(table_data, source_id, 2);
     /* Related Source Id */
@@ -481,11 +487,8 @@ static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
     /* Error Status Block Length */
     build_append_int_noprefix(table_data, ACPI_GHES_MAX_RAW_DATA_LENGTH, 4);
 
-    /*
-     * Read Ack Register
-     * ACPI 6.1: 18.3.2.8 Generic Hardware Error Source
-     * version 2 (GHESv2 - Type 10)
-     */
+    /* ACPI 6.5: fields defined at GHESv2 table */
+    /* Read Ack Register */
     address_offset = table_data->len;
     build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 0x40, 0,
                      4 /* QWord access */, 0);
@@ -504,11 +507,16 @@ static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
     build_append_int_noprefix(table_data, 0x1, 8);
 }
 
-/* Build Hardware Error Source Table */
+/*
+ * Build Hardware Error Source Table
+ * ACPI 6.4: 18.3.2 ACPI Error Source
+ * Table 18.2: Hardware Error Source Table (HEST)
+ */
 void acpi_build_hest(GArray *table_data, BIOSLinker *linker,
                      const char *oem_id, const char *oem_table_id)
 {
-    AcpiTable table = { .sig = "HEST", .rev = 1,
+    AcpiTable table = { .sig = "HEST",
+                        .rev = 1,                   /* ACPI 4.0 to 6.4 */
                         .oem_id = oem_id, .oem_table_id = oem_table_id };
 
     acpi_table_begin(&table, table_data);
-- 
2.45.2


