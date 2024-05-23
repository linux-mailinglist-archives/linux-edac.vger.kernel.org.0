Return-Path: <linux-edac+bounces-1095-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F33C68CD7EC
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2024 17:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA330282498
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2024 15:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1252C381C6;
	Thu, 23 May 2024 15:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YWoDRJul"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE45B1EF1D;
	Thu, 23 May 2024 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479827; cv=fail; b=KPf7ORPpu0A378DjOECDOqqL6SARvTJw8lqGna9bFIIvN3q2CsYfLe6gbC3Mn7QE3TicErGciSE7DXq50/PXePrSHmA6nyWXWNT/GSnKQkdCw4XAY7rAk5u7w2+q2Jid5WAxKrPi1FwsKA7rOv438A8iUySFgsxa+VaApqW3d9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479827; c=relaxed/simple;
	bh=0r6gT6ZzXeEtZtcqwStoSzaMLYOOCGDeuOMr2aSTmr4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mhFl9EdIb6b/CABtgokpgPtMJ8iFg6RvIL09QULqlYvUk8TOaeP42ZPSAJ0aTOA3B6RwskYXH7MMcNAQ/LpkauOt0FfxSvyhJqD3wKfrVt53ECO0T/1zi7JNDmG0nAt4MsHUhXoylyij1FPFYLtBeW4epo2zXQR/KPRHoquVoq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YWoDRJul; arc=fail smtp.client-ip=40.107.244.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UabDHBMMT1RNpXGhue1zUV+KnBRf21lI6qP+1tWRVmJjcGqWCvfTwtHoBbY+H0T/+ChN22zI7cz7Rj6RjSKV+p4oZS4qwlsC+pG3YRpe1yMnpEzw/Y6dYGEg8hAYsU2QRgDwa3fFByfdVCg5bPiF1qy75a44QPx2czz4czqk4gJu62X8aEyZI3b31RZy0UAV022u5PIJitLrqr+/KdG6O+T4FDILvGkKSv+l69cJoBMxA101v3erOAVQjLe53v6/uuyD3icgZLBEzGPlbwAgrLBLlCb4wAXsDxMthOvmX96P3hbvv7NFbI3zTalYJptDj6ZzbTew+OWq5QwFBdZ9TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPUtHhKwrlRtBb4Vnv0gH0Sv04x2EJblW+23HZPJ//Y=;
 b=OZfBep1MZ5xFmSRfxhL5b0zSR0RRyawgsf8Ecwj+ccQIV8gG2G1iGZqljwklBViiZ3A6zNzq42TfIWXA/wUg5r5ByN3TZ1YNsQSoBwKQh6L8FzesyNahPy5YLN/3F18J1fqrWHIj3VFprytH4tiHj6ldx6cak9at1ErtDxPFrZ1mGl/kJZ6eO48BxcZRgtI958NrINJpOWIdyTUrEdQIRuU+x/rmUQ9r+QjnkXmu9hmSrYuzIE825eq6u/WkGRW/rAAJEBN+cyd6xYd9OR1UnUAAaogJrLiFllZqDaUoItukoGrAbs6fh/jDPjS0RNYwWFxp0An47wF4zPCh+Cf4VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPUtHhKwrlRtBb4Vnv0gH0Sv04x2EJblW+23HZPJ//Y=;
 b=YWoDRJulSPnDqo8FoJYAW0DV+vcJMHVgZ0QqjRZmlqHMFSUtl4HfzmLXyNwWj+HIQENK/YwJnOAA557DTCShhAlis8n00K8XWynl1Z6o1v940fABi1AqCeosQIrXLDaGkdh3Nt4GTRmtTDifTv9+/I0hAGD7dSK+ptatGd/pcVY=
Received: from BN0PR08CA0015.namprd08.prod.outlook.com (2603:10b6:408:142::31)
 by SA1PR12MB7269.namprd12.prod.outlook.com (2603:10b6:806:2be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 15:57:02 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:142:cafe::ee) by BN0PR08CA0015.outlook.office365.com
 (2603:10b6:408:142::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36 via Frontend
 Transport; Thu, 23 May 2024 15:57:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 15:57:02 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 10:56:58 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<avadhut.naik@amd.com>, <john.allen@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH 6/9] x86/mce: Unify AMD THR handler with MCA Polling
Date: Thu, 23 May 2024 10:56:38 -0500
Message-ID: <20240523155641.2805411-7-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523155641.2805411-1-yazen.ghannam@amd.com>
References: <20240523155641.2805411-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|SA1PR12MB7269:EE_
X-MS-Office365-Filtering-Correlation-Id: e1cacdfa-3ddf-49ff-b28c-08dc7b40fc85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1M3/sJJcJG7491UycX2ydrf7difyx5Z3QG4LxkUhUKDTmyMztmAN8pMiPPTi?=
 =?us-ascii?Q?zXfFcckT8ku3K3OSfTfmU3q9xdF6z29ExegGGiGO+GBJuBgo/ZcHGfEdStrx?=
 =?us-ascii?Q?DyUsx4sLkCzIizFFsJ6GySB9YMPKE2NXgs37Wh/oXjEELKC2IgVAWEsDFAPT?=
 =?us-ascii?Q?Z97fPVVIllUPWOOeGnpV/5+jNLq7cCFrAoCVV1L2aksHF7UCd4Hp9nUDw30r?=
 =?us-ascii?Q?E3G3AF5YLd/30Ui/NsebLz9nxejfBRTXd0Z+YZ/ojgWcQ7s576nsF51G1Ojl?=
 =?us-ascii?Q?RthCJKufdyvSbf6mAS0d0xzqZUoIAo3AQllNJ6jOLmNhm6o1bmRkHnPlc163?=
 =?us-ascii?Q?EK6G3dB1zAY9ey+MN6KdJU+Ue0PGpgdHmTDLvpKGoHW6b1wWRh/jgwawQKOc?=
 =?us-ascii?Q?Ugm1m5nTWN5gL/M8qBLOgnrq0BWc4LyjbhDTAxZebtgwSnbluEcSGW6E/bCR?=
 =?us-ascii?Q?Wq19aC8Jzy4bvsIFXUPD2r8tYjvtF+Q3Lxrzn9MxXibAwK1FQXeyr2rDXn0P?=
 =?us-ascii?Q?Wi07MkAhR+4dgvntq4sg4JZS1OeWwou+njx+AB+id8G0aImc5cdYJydHHX+Y?=
 =?us-ascii?Q?hAajtPMV5H7cRL3W+JgL1HoR16MDww7zuvXhWgPI8JuDk+veICdjOCfw+mAR?=
 =?us-ascii?Q?mL3cBSmEooGxynpWoFPF3OTzxrVWNsHYXikoqYMuY2Tj8hn7SN70Zav5J0iq?=
 =?us-ascii?Q?bpMoJi1ZzwnoCJkddtj4OlM9y6gmZ11apzVX4gy1e2p7crFIb9MQYTftWmfx?=
 =?us-ascii?Q?vh4GZwij4irKoJG+cc/ZdSQDBqHxr2pNnWBLjJQK2gY9PqgZOZBsxpsiQfnL?=
 =?us-ascii?Q?Zqcg42Ei7Uhd75yfady+PAM+n+lwHiVTyTMLYa5BJtpLAaVBKG/HbXtzXy7f?=
 =?us-ascii?Q?Vf8v9SybFKF8aZPRMfWu3Ei2wxDgD3TKhQkcZy/h7qUb4PKeg6IFJY+FyQQA?=
 =?us-ascii?Q?goxMNIVgofAhpDCDTHO09ZIedapNcjQ1RZNnlXzfwEQywbizJN/GrkHutlq7?=
 =?us-ascii?Q?GR7rnFrQJ5ztKvA4LeJtv/4c8z46REjNWtdDdfYpv2FnOj2CbAcmGqlEpas8?=
 =?us-ascii?Q?prjd339C5eLEtNtbO43TB9YE5HIYfF459fhMLYOlyyswA3mUOtU3NesWo9w9?=
 =?us-ascii?Q?4UL0pqnHm13LvYAJVBWB7h3lYwPCPMc7DpVAf0XnA3e4qBRlRS/S4FkTwqWF?=
 =?us-ascii?Q?HF8REvSQ3yQSaw3mWmW5fQcNKbcM1sP6GxPojOGvDjeD6YjXO2m1rrd49Szl?=
 =?us-ascii?Q?CcFqXtRNfuuKTstUBm9VH/PBKxTC5k5Q8aCQXxjJj/zBKipSwcN1sppjBt2n?=
 =?us-ascii?Q?fwuKk1UJb8Ngm1BAkSaR2NEXEh+cjewvLJeVx0lX6RD/T/xZhfhXplR6Kv+7?=
 =?us-ascii?Q?LmM2MRY6te7EjIKaKiRgaVASFxKO?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 15:57:02.4042
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1cacdfa-3ddf-49ff-b28c-08dc7b40fc85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7269

AMD systems optionally support an MCA thresholding interrupt. The
interrupt should be used as another signal to trigger MCA polling. This
is similar to how the Intel Corrected Machine Check interrupt (CMCI) is
handled.

AMD MCA thresholding is managed using the MCA_MISC registers within an
MCA bank. The OS will need to modify the hardware error count field in
order to reset the threshold limit and rearm the interrupt. Management
of the MCA_MISC register should be done as a follow up to the basic MCA
polling flow. It should not be the main focus of the interrupt handler.

Furthermore, future systems will have the ability to send an MCA
thresholding interrupt to the OS even when the OS does not manage the
feature, i.e. MCA_MISC registers are Read-as-Zero/Locked.

Call the common MCA polling function when handling the MCA thresholding
interrupt. This will allow the OS to find any valid errors whether or
not the MCA thresholding feature is OS-managed. Also, this allows the
common MCA polling options and kernel parameters to apply to AMD
systems.

Add a callback to the MCA polling function to check and reset any
threshold blocks that have reached their threshold limit.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c      | 54 +++++++++++++-----------------
 arch/x86/kernel/cpu/mce/core.c     |  8 +++++
 arch/x86/kernel/cpu/mce/internal.h |  2 ++
 3 files changed, 33 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index d7dee59cc1ca..1ac445a0dc12 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -56,6 +56,7 @@
 #define SMCA_THR_LVT_OFF	0xF000
 
 static bool thresholding_irq_en;
+static DEFINE_PER_CPU_READ_MOSTLY(mce_banks_t, mce_thr_intr_banks);
 
 static const char * const th_names[] = {
 	"load_store",
@@ -578,6 +579,7 @@ prepare_threshold_block(unsigned int bank, unsigned int block, u32 addr,
 	if (!b.interrupt_capable)
 		goto done;
 
+	__set_bit(bank, this_cpu_ptr(mce_thr_intr_banks));
 	b.interrupt_enable = 1;
 
 	if (!mce_flags.smca) {
@@ -883,12 +885,7 @@ static void amd_deferred_error_interrupt(void)
 		log_error_deferred(bank);
 }
 
-static void log_error_thresholding(unsigned int bank, u64 misc)
-{
-	_log_error_deferred(bank, misc);
-}
-
-static void log_and_reset_block(struct threshold_block *block)
+static void reset_block(struct threshold_block *block)
 {
 	struct thresh_restart tr;
 	u32 low = 0, high = 0;
@@ -902,49 +899,44 @@ static void log_and_reset_block(struct threshold_block *block)
 	if (!(high & MASK_OVERFLOW_HI))
 		return;
 
-	/* Log the MCE which caused the threshold event. */
-	log_error_thresholding(block->bank, ((u64)high << 32) | low);
-
-	/* Reset threshold block after logging error. */
 	memset(&tr, 0, sizeof(tr));
 	tr.b = block;
 	threshold_restart_bank(&tr);
 }
 
-/*
- * Threshold interrupt handler will service THRESHOLD_APIC_VECTOR. The interrupt
- * goes off when error_count reaches threshold_limit.
- */
-static void amd_threshold_interrupt(void)
+void amd_reset_thr_limit(unsigned int bank)
 {
 	struct threshold_block *first_block = NULL, *block = NULL, *tmp = NULL;
 	struct threshold_bank **bp = this_cpu_read(threshold_banks);
-	unsigned int bank, cpu = smp_processor_id();
 
 	/*
 	 * Validate that the threshold bank has been initialized already. The
 	 * handler is installed at boot time, but on a hotplug event the
 	 * interrupt might fire before the data has been initialized.
 	 */
-	if (!bp)
+	if (!bp || !bp[bank])
 		return;
 
-	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
-		if (!(per_cpu(bank_map, cpu) & BIT_ULL(bank)))
-			continue;
+	first_block = bp[bank]->blocks;
+	if (!first_block)
+		return;
 
-		first_block = bp[bank]->blocks;
-		if (!first_block)
-			continue;
+	/*
+	 * The first block is also the head of the list. Check it first
+	 * before iterating over the rest.
+	 */
+	reset_block(first_block);
+	list_for_each_entry_safe(block, tmp, &first_block->miscj, miscj)
+		reset_block(block);
+}
 
-		/*
-		 * The first block is also the head of the list. Check it first
-		 * before iterating over the rest.
-		 */
-		log_and_reset_block(first_block);
-		list_for_each_entry_safe(block, tmp, &first_block->miscj, miscj)
-			log_and_reset_block(block);
-	}
+/*
+ * Threshold interrupt handler will service THRESHOLD_APIC_VECTOR. The interrupt
+ * goes off when error_count reaches threshold_limit.
+ */
+static void amd_threshold_interrupt(void)
+{
+	machine_check_poll(MCP_TIMESTAMP, this_cpu_ptr(&mce_thr_intr_banks));
 }
 
 /*
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 58b8efdcec0b..d6517b93c903 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -660,6 +660,12 @@ static noinstr void mce_read_aux(struct mce *m, int i)
 	}
 }
 
+static void reset_thr_limit(unsigned int bank)
+{
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+		return amd_reset_thr_limit(bank);
+}
+
 DEFINE_PER_CPU(unsigned, mce_poll_count);
 
 static bool ser_log_poll_error(struct mce *m)
@@ -769,6 +775,8 @@ void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 			mce_log(&m);
 
 clear_it:
+		reset_thr_limit(i);
+
 		/*
 		 * Clear state for this bank.
 		 */
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 08571b10bf3f..3e062cf01d4d 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -262,6 +262,7 @@ extern bool filter_mce(struct mce *m);
 #ifdef CONFIG_X86_MCE_AMD
 extern bool amd_filter_mce(struct mce *m);
 bool amd_mce_usable_address(struct mce *m);
+void amd_reset_thr_limit(unsigned int bank);
 
 /*
  * If MCA_CONFIG[McaLsbInStatusSupported] is set, extract ErrAddr in bits
@@ -290,6 +291,7 @@ static __always_inline void smca_extract_err_addr(struct mce *m)
 #else
 static inline bool amd_filter_mce(struct mce *m) { return false; }
 static inline bool amd_mce_usable_address(struct mce *m) { return false; }
+static inline void amd_reset_thr_limit(unsigned int bank) { }
 static inline void smca_extract_err_addr(struct mce *m) { }
 #endif
 
-- 
2.34.1


