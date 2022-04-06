Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2054F5B2F
	for <lists+linux-edac@lfdr.de>; Wed,  6 Apr 2022 12:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348909AbiDFKI0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Apr 2022 06:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245525AbiDFKHG (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 6 Apr 2022 06:07:06 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618B7C6F3E;
        Tue,  5 Apr 2022 23:36:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nj4MnzuK1ljBBEh76na5ZcUPQBxSemoMyDgarheZnw7dzZR2VrFSb8ec7xPKNkgF0CUfJ/OSKlzgKCDTwoPFWpQy+nBukoM+6QcFtfeohxCAH+1SL4imlPunn0pJgp3ClQ0idOwLuA4DE3cC6JPGC2a33Ci4soFaT4F7zdUPhgBXwq0cpN1yn4N5XDQEsYbeBy1B1dzoGwIuDNh6VT9dWAQsT0F3/wJ1lwapzKRbwVc+uUYYKO0wjRWyB7f2jcN2AOTsPol6/Z0phtpM4hD7FvWqbW7c4YQJnu8rYALIKU46g4ccuYD9Rw7bohPt1EJTLSUv88rwSWZr/cEhAmxZAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+8GKPehvHpdlqm1HL5LfuFgl9gX+YhcAcsVIMeyzI8=;
 b=BPzp4h+DQJw+8636PCb3gtAKBGIvhM6uvo6E7UBvFSZgI1ZTZCCSh6PcZNfjvu7jCWzWZN9yNRg8lyKNALyl9WLlP7zdxhxNoMm7lb8smHVVvdLqKcV3/rcoS7PohvMHtNwoZscVJ5kQ//PQIE4f2RGDHk425RMIo+KD49TL9pKWvBWH1pNgdcwIvXxYKCgaB8r22nB6NnUONhzAihelaXjRB5gmxewsIiONsQJPO7t2xO3JC1UgQamkJgSSxe0cPvMiPKoUby9CK63Ok1jvDa9QIasMnla5AyGoudgbzKZdxYpJHor9d6ZmQfyvlRz+SJSMNdrlQ3ay4LBibecc3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+8GKPehvHpdlqm1HL5LfuFgl9gX+YhcAcsVIMeyzI8=;
 b=Y8Gsb2o++Sm6AvBd3cXBzQzDq9YnEdWmQl5x7cKd/DbIFuq4bHymlQF9ZzncIOn50UIARahXqo88mWer8+BJ9mdRwADrU1BDzTL6jP7N36Ub8ma4GITp+sTmYbR0wlVLiRGCYhfz0yLIUsALzJ9OJBODD8Vfoc0m5euX6qn8FzE=
Received: from DM6PR03CA0020.namprd03.prod.outlook.com (2603:10b6:5:40::33) by
 DM5PR12MB2439.namprd12.prod.outlook.com (2603:10b6:4:b4::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.31; Wed, 6 Apr 2022 06:36:04 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::dc) by DM6PR03CA0020.outlook.office365.com
 (2603:10b6:5:40::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Wed, 6 Apr 2022 06:36:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Wed, 6 Apr 2022 06:36:03 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 6 Apr
 2022 01:36:02 -0500
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
CC:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        <hpa@zytor.com>, Yazen Ghannam <yazen.ghannam@amd.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>
Subject: [RFC PATCH 4/5] x86/mce: Move storm handling to core.
Date:   Wed, 6 Apr 2022 01:35:41 -0500
Message-ID: <20220406063542.183946-5-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220406063542.183946-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20220406063542.183946-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbf7c2ab-29c7-4f4a-5696-08da1797b916
X-MS-TrafficTypeDiagnostic: DM5PR12MB2439:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB24397D07FDFAF3716CFE701690E79@DM5PR12MB2439.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DjIaiaMjiizQ6/Jq09e0S8xaoBJAXffrOKRMyNSi8yjYqsNqYfbj6ESsWNM7NMq0R5PCQrXFNjFlPBMGJTTxC0iA0E0Rqe9hJpfSC7zQh5B2EVfo7kHMV3eJJCGwi3qorzN1EUEMx8UxMp464fGENJWwIivX1vSvx5itjmf/DEKYUg39ofGVY+BMYyfc4aUIbJFkw/ESRvazdcnFtq29UFTMkq88menRFa8vbZTOMGDZJ/8+3jWZHdhS8uT8DVB5FoQp4PQwvNHmZL6gDU/S5tnzbBZ1zsyBLCoLqt4MAbbIhCosaEIBAFec4wD401J8YtvfLh/CtQOj9QwoPu44N6dXhtu+QjCcYPZmx8v2TpWo69FWEGGATgFGb7x/9CcSjrWjA2rOsatNpXIv+dHKxPtVNfaGw8hCAnR8FLWfTepnXW/EO/utFz9yC2E/2WIpobDdr0SgaIBIgzzoh7X+9RQp58Tzrf6xHnQVUJk210OcCzj6SKYOQQ8zZzdnaXmHhueJEpGvoXE8W/h0DyCqr68ULtDK1bmm1+1oqlx6iraUwMiLU0XgelWjEQhY0Tp/0r7jiygoQ+BN4Pc6d2gvdiOPfGLbBXN74SZOM5VPvuWq/Xl6DQUcnTv+z2mGWNU7h11BKBxyZOZ4ww1y2z6U6HumD+AWJGJCj2lhsLpvjbuzxwYmKn492AJDLV0FQZ5oz77lsUjESVLXzzMR14TONw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(5660300002)(6666004)(70586007)(70206006)(36756003)(83380400001)(7696005)(86362001)(82310400005)(26005)(336012)(4326008)(186003)(1076003)(2616005)(8676002)(508600001)(426003)(8936002)(40460700003)(16526019)(110136005)(54906003)(2906002)(36860700001)(316002)(356005)(47076005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 06:36:03.8002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf7c2ab-29c7-4f4a-5696-08da1797b916
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2439
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

AMD's storm handling for threshold interrupts is similar to Intel's CMCI
storm handling. Hence, make the storm handling code common by moving to
core and removing the vendor exclusivity.

On the contrary, setting different thresholds to reduce rate of interrupts
in IA32_MCi_CTL2 register is kept Intel intact as the storm handling for
AMD slightly differs where in it handles the storms by turning off the
interrupts.

No functional changes.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
This is another patch which can be merged into Tony's per CPU per bank
CMCI storm mitigation.
---
 arch/x86/kernel/cpu/mce/core.c     |  81 +++++++++++++++++++++++
 arch/x86/kernel/cpu/mce/intel.c    | 100 +----------------------------
 arch/x86/kernel/cpu/mce/internal.h |  25 ++++++++
 3 files changed, 107 insertions(+), 99 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index db6d60825e77..6caee488bf7d 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -611,6 +611,87 @@ static struct notifier_block mce_default_nb = {
 	.priority	= MCE_PRIO_LOWEST,
 };
 
+/*
+ * CMCI storm tracking state
+ *	stormy_bank_count: per-cpu count of MC banks in storm state
+ *	bank_history: bitmask tracking of corrected errors seen in each bank
+ *	bank_time_stamp: last time (in jiffies) that each bank was polled
+ */
+DEFINE_PER_CPU(int, stormy_bank_count);
+DEFINE_PER_CPU(u64 [MAX_NR_BANKS], bank_history);
+DEFINE_PER_CPU(bool [MAX_NR_BANKS], bank_storm);
+DEFINE_PER_CPU(unsigned long [MAX_NR_BANKS], bank_time_stamp);
+
+void cmci_storm_begin(int bank)
+{
+	__set_bit(bank, this_cpu_ptr(mce_poll_banks));
+	this_cpu_write(bank_storm[bank], true);
+
+	/*
+	 * If this is the first bank on this CPU to enter storm mode
+	 * start polling
+	 */
+	if (this_cpu_inc_return(stormy_bank_count) == 1)
+		mce_timer_kick(true);
+}
+
+void cmci_storm_end(int bank)
+{
+	__clear_bit(bank, this_cpu_ptr(mce_poll_banks));
+	this_cpu_write(bank_history[bank], 0ull);
+	this_cpu_write(bank_storm[bank], false);
+
+	/* If no banks left in storm mode, stop polling */
+	if (!this_cpu_dec_return(stormy_bank_count))
+		mce_timer_kick(false);
+}
+
+void track_cmci_storm(int bank, u64 status)
+{
+	unsigned long now = jiffies, delta;
+	unsigned int shift = 1;
+	u64 history;
+
+	/*
+	 * When a bank is in storm mode, the history mask covers about
+	 * one second of elapsed time. Check how long it has been since
+	 * this bank was last polled, and compute a shift value to update
+	 * the history bitmask.  When not in storm mode, each consecutive
+	 * poll of the bank is logged in the next history bit, so shift
+	 * is kept at "1".
+	 */
+	if (this_cpu_read(bank_storm[bank])) {
+		delta = now - this_cpu_read(bank_time_stamp[bank]);
+		shift = (delta + HZBITS) / HZBITS;
+	}
+
+	/* If has been a long time since the last poll, clear history */
+	if (shift >= 64)
+		history = 0;
+	else
+		history = this_cpu_read(bank_history[bank]) << shift;
+	this_cpu_write(bank_time_stamp[bank], now);
+
+	/* History keeps track of corrected errors. VAL=1 && UC=0 */
+	if ((status & (MCI_STATUS_VAL | MCI_STATUS_UC)) == MCI_STATUS_VAL)
+		history |= 1;
+	this_cpu_write(bank_history[bank], history);
+
+	if (this_cpu_read(bank_storm[bank])) {
+		if (history & GENMASK_ULL(STORM_END_POLL_THRESHOLD - 1, 0))
+			return;
+		pr_notice("CPU%d BANK%d CMCI storm subsided\n", smp_processor_id(), bank);
+		mce_handle_storm(bank, true);
+		cmci_storm_end(bank);
+	} else {
+		if (hweight64(history) < STORM_BEGIN_THRESHOLD)
+			return;
+		pr_notice("CPU%d BANK%d CMCI storm detected\n", smp_processor_id(), bank);
+		mce_handle_storm(bank, false);
+		cmci_storm_begin(bank);
+	}
+}
+
 /*
  * Read ADDR and MISC registers.
  */
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index 7edc31742fe0..6cc9aa97c092 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -47,17 +47,7 @@ static DEFINE_PER_CPU(mce_banks_t, mce_banks_owned);
  */
 static DEFINE_RAW_SPINLOCK(cmci_discover_lock);
 
-/*
- * CMCI storm tracking state
- *	stormy_bank_count: per-cpu count of MC banks in storm state
- *	bank_history: bitmask tracking of corrected errors seen in each bank
- *	bank_time_stamp: last time (in jiffies) that each bank was polled
- *	cmci_threshold: MCi_CTL2 threshold for each bank when there is no storm
- */
-static DEFINE_PER_CPU(int, stormy_bank_count);
-static DEFINE_PER_CPU(u64 [MAX_NR_BANKS], bank_history);
-static DEFINE_PER_CPU(bool [MAX_NR_BANKS], bank_storm);
-static DEFINE_PER_CPU(unsigned long [MAX_NR_BANKS], bank_time_stamp);
+/* MCi_CTL2 threshold for each bank when there is no storm */
 static int cmci_threshold[MAX_NR_BANKS];
 
 /* Linux non-storm CMCI threshold (may be overridden by BIOS */
@@ -70,24 +60,6 @@ static int cmci_threshold[MAX_NR_BANKS];
  */
 #define CMCI_STORM_THRESHOLD	32749
 
-/*
- * How many errors within the history buffer mark the start of a storm
- */
-#define STORM_BEGIN_THRESHOLD	5
-
-/*
- * How many polls of machine check bank without an error before declaring
- * the storm is over
- */
-#define STORM_END_POLL_THRESHOLD	30
-
-/*
- * When there is no storm each "bit" in the history represents
- * this many jiffies. When there is a storm every poll() takes
- * one history bit.
- */
-#define HZBITS (HZ / 64)
-
 static int cmci_supported(int *banks)
 {
 	u64 cap;
@@ -167,76 +139,6 @@ void mce_intel_handle_storm(int bank, bool on)
 		cmci_set_threshold(bank, CMCI_STORM_THRESHOLD);
 }
 
-static void cmci_storm_begin(int bank)
-{
-	__set_bit(bank, this_cpu_ptr(mce_poll_banks));
-	this_cpu_write(bank_storm[bank], true);
-
-	/*
-	 * If this is the first bank on this CPU to enter storm mode
-	 * start polling
-	 */
-	if (this_cpu_inc_return(stormy_bank_count) == 1)
-		mce_timer_kick(true);
-}
-
-static void cmci_storm_end(int bank)
-{
-	__clear_bit(bank, this_cpu_ptr(mce_poll_banks));
-	this_cpu_write(bank_history[bank], 0ull);
-	this_cpu_write(bank_storm[bank], false);
-
-	/* If no banks left in storm mode, stop polling */
-	if (!this_cpu_dec_return(stormy_bank_count))
-		mce_timer_kick(false);
-}
-
-void track_cmci_storm(int bank, u64 status)
-{
-	unsigned long now = jiffies, delta;
-	unsigned int shift = 1;
-	u64 history;
-
-	/*
-	 * When a bank is in storm mode, the history mask covers about
-	 * one second of elapsed time. Check how long it has been since
-	 * this bank was last polled, and compute a shift value to update
-	 * the history bitmask.  When not in storm mode, each consecutive
-	 * poll of the bank is logged in the next history bit, so shift
-	 * is kept at "1".
-	 */
-	if (this_cpu_read(bank_storm[bank])) {
-		delta = now - this_cpu_read(bank_time_stamp[bank]);
-		shift = (delta + HZBITS) / HZBITS;
-	}
-
-	/* If has been a long time since the last poll, clear history */
-	if (shift >= 64)
-		history = 0;
-	else
-		history = this_cpu_read(bank_history[bank]) << shift;
-	this_cpu_write(bank_time_stamp[bank], now);
-
-	/* History keeps track of corrected errors. VAL=1 && UC=0 */
-	if ((status & (MCI_STATUS_VAL | MCI_STATUS_UC)) == MCI_STATUS_VAL)
-		history |= 1;
-	this_cpu_write(bank_history[bank], history);
-
-	if (this_cpu_read(bank_storm[bank])) {
-		if (history & GENMASK_ULL(STORM_END_POLL_THRESHOLD - 1, 0))
-			return;
-		pr_notice("CPU%d BANK%d CMCI storm subsided\n", smp_processor_id(), bank);
-		mce_handle_storm(bank, true);
-		cmci_storm_end(bank);
-	} else {
-		if (hweight64(history) < STORM_BEGIN_THRESHOLD)
-			return;
-		pr_notice("CPU%d BANK%d CMCI storm detected\n", smp_processor_id(), bank);
-		mce_handle_storm(bank, false);
-		cmci_storm_begin(bank);
-	}
-}
-
 /*
  * The interrupt handler. This is called on every event.
  * Just call the poller directly to log any events.
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index c95802db9535..49907cadf9ad 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -60,6 +60,31 @@ static inline bool intel_filter_mce(struct mce *m) { return false; }
 
 void mce_timer_kick(bool storm);
 extern void (*mce_handle_storm)(int bank, bool on);
+void cmci_storm_begin(int bank);
+void cmci_storm_end(int bank);
+
+DECLARE_PER_CPU(int, stormy_bank_count);
+DECLARE_PER_CPU(u64 [MAX_NR_BANKS], bank_history);
+DECLARE_PER_CPU(bool [MAX_NR_BANKS], bank_storm);
+DECLARE_PER_CPU(unsigned long [MAX_NR_BANKS], bank_time_stamp);
+
+/*
+ * How many errors within the history buffer mark the start of a storm
+ */
+#define STORM_BEGIN_THRESHOLD	5
+
+/*
+ * How many polls of machine check bank without an error before declaring
+ * the storm is over
+ */
+#define STORM_END_POLL_THRESHOLD	30
+
+/*
+ * When there is no storm each "bit" in the history represents
+ * this many jiffies. When there is a storm every poll() takes
+ * one history bit.
+ */
+#define HZBITS (HZ / 64)
 
 #ifdef CONFIG_ACPI_APEI
 int apei_write_mce(struct mce *m);
-- 
2.17.1

