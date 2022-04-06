Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7494F5B6B
	for <lists+linux-edac@lfdr.de>; Wed,  6 Apr 2022 12:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245340AbiDFKIM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Apr 2022 06:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237093AbiDFKHF (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 6 Apr 2022 06:07:05 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2085.outbound.protection.outlook.com [40.107.95.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0871FC6F3C;
        Tue,  5 Apr 2022 23:36:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHT2nySY9fqq4FR5ypWDtTQ27bAa9l+ymcGEbGK8U8hinM+8kFTyI8hSNpZIV+XATcRDCRuwiitinDoJz+dlLQ7/9JYd0xYMuKVZEXsgZCXX/TAQz6ECUbSPJXFZ7bwXIBjOH6N+jZKjqIXsr7TjSaiPgXPwCw+uTnxC9rLQIOAB2QVJDbqBpgoZWyZIOvyow7Zrgzx+2x3dBiTodB5/tIs+JBcVc+Ae2sjm8mdWXJ5EfLtmAtH4w2AQjtBFuiNB+L+Nw9dn7EF1WNsTKEBZMWI6/NATCkL35sFLxGnl0Bva73Mvvv6BbcucNl/zI3ucqm+OColG/gsY8Gfjz0hDUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ix1OCm4UWW0j9eULSlGTy4JF66hn6i4VBEKBJ5TzXZg=;
 b=AdGlc8++YW7vakoY+sKpf/DeDmHtfGieYQixV9cj9NFy6SaGc5RH1nvFzcYHExfzpJt/fmTJjHhnQFaT2dK4m5Of0LnEaMfE5B8vQncsIt0LHNkslOE7Rwpo4U6uEK/BNyuynrXUI0sFUp7w2yYFJ6nLUlL7EkXG3Jy7MSovQOVqutsUHKt6YNbUVlOJCYZN9fk5qkIrwSZOprPoW1MyaMWX0BuHJrm9GF/SK//P7DQp+b/3BGrkS3oFQWV2xrJvvnkDq153B16rdydWwfcG296i1svcKTgVrWMYpPLrrMer2+IXWk4Sp76zxeb036rTrX06cY/c/gnIafsXEYLUng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ix1OCm4UWW0j9eULSlGTy4JF66hn6i4VBEKBJ5TzXZg=;
 b=xAWUf9PwKGTDwPiRViIc9/wlVrVzUygpfc4sop/9zj4SiyOo9/wkrqyVbxrbtA1iRMnWkfjBS2hQ6JFnbDGnfJSZU3TLzTUndKMEWnsRy5OtfVP7XioKQnr1RKD5T8oeoo91IQqjHFQF3x388f5i7Eh9ZDb3leTaZl5YzsaEUN8=
Received: from DS7PR05CA0082.namprd05.prod.outlook.com (2603:10b6:8:57::23) by
 BN8PR12MB4595.namprd12.prod.outlook.com (2603:10b6:408:72::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.31; Wed, 6 Apr 2022 06:36:01 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::d9) by DS7PR05CA0082.outlook.office365.com
 (2603:10b6:8:57::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21 via Frontend
 Transport; Wed, 6 Apr 2022 06:36:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Wed, 6 Apr 2022 06:36:00 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 6 Apr
 2022 01:35:59 -0500
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
CC:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        <hpa@zytor.com>, Yazen Ghannam <yazen.ghannam@amd.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>
Subject: [PATCH 2/5] x86/mce: Add per-bank CMCI storm mitigation
Date:   Wed, 6 Apr 2022 01:35:39 -0500
Message-ID: <20220406063542.183946-3-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: c71c05fb-8fa1-4e22-ad33-08da1797b747
X-MS-TrafficTypeDiagnostic: BN8PR12MB4595:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB4595F05C6DCE07C67AC8D69A90E79@BN8PR12MB4595.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7jK0TY/xEJAH5/IkOmB+IPCaIlMlYkl9CmFG3uvc4VxRCU2Kq+coyIrgGjhHZiljlB3kgOD8i6PcG5uKxWw6HgXsdvlugLiwaYJNYYGJ5ZsPx+/Kx1WnBsFCCTBZ/Acn1i4+53AfTIK2HjMrWZnC0wwf6CCd6PEgcCKgrQHjUvkey6qFL0z10+A2xmJz7Kh9gSiQ4ACn8Et+4EYr1/n61NcU/kuTs0WKP+ax9ZWNZ0mZwQZ/GyKKAWRecpjWuEileCTDwzqWPxMXMtXQVpQtRnWmuxpIdm/BcC6rmTKrhWuTqnYf6SCB7ovQ5H1rNyYTWYC0IB0VIAFUB/4V7UehXFc6Z723E1mgDmlntCeTY252tld892DsMw69EwxpJ+ZIt1HymUjWRwKDAzJDmSWki+jKnnZitT3Rd/TvEoQPVJnNepyc9PTAGgpCCnns5fiGX9P0j3yF6EPpE868rP0n9wx407rTlvhCfJKJhKEriPzYanlhdpr/IIWZ/xfPypy/XY/jSe9JUZO9owcYZ92bn+FTQLIyY0OAsXSK6rTm8ClZCRaP6Cju4gSI307jK2W1OqVlCCCObCVFGnnHdZJ26lEywuRvOvL4fcj4szetcK3baKDtf+fDKKUfHSkCgA9ooeO9zmgJ/NrFEDaAVV9t76YROIT5ug8cTB7+L1Z7RhMT78O2glH9fjVxTG/qWUErUjbCWMoUEkzYCwyRSPK5ig==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(356005)(2616005)(36860700001)(15650500001)(8936002)(1076003)(5660300002)(2906002)(7696005)(82310400005)(30864003)(47076005)(36756003)(54906003)(83380400001)(70586007)(70206006)(8676002)(6666004)(40460700003)(81166007)(86362001)(4326008)(426003)(16526019)(186003)(26005)(336012)(316002)(110136005)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 06:36:00.7681
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c71c05fb-8fa1-4e22-ad33-08da1797b747
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4595
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Tony Luck <tony.luck@intel.com>

Add a hook into machine_check_poll() to keep track of per-CPU, per-bank
corrected error logs.

Maintain a bitmap history for each bank showing whether the bank
logged an corrected error or not each time it is polled.

In normal operation the interval between polls of this banks
determines how far to shift the history. The 64 bit width corresponds
to about one second.

When a storm is observed the Rate of interrupts is reduced by setting
a large threshold value for this bank in IA32_MCi_CTL2. This bank is
added to the bitmap of banks for this CPU to poll. The polling rate
is increased to once per second.
During a storm each bit in the history indicates the status of the
bank each time it is polled. Thus the history covers just over a minute.

Declare a storm for that bank if the number of corrected interrupts
seen in that history is above some threshold (5 in this RFC code for
ease of testing, likely move to 15 for compatibility with previous
storm detection).

A storm on a bank ends if enough consecutive polls of the bank show
no corrected errors (currently 30, may also change). That resets the
threshold in IA32_MCi_CTL2 back to 1, removes the bank from the bitmap
for polling, and changes the polling rate back to the default.

If a CPU with banks in storm mode is taken offline, the new CPU
that inherits ownership of those banks takes over management of
storm(s) in the inherited bank(s).

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/core.c     |  26 +++--
 arch/x86/kernel/cpu/mce/intel.c    | 146 ++++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/mce/internal.h |   4 +-
 3 files changed, 165 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 331d4f7cf5f2..13844a38aa2c 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -692,6 +692,8 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		barrier();
 		m.status = mce_rdmsrl(mca_msr_reg(i, MCA_STATUS));
 
+		track_cmci_storm(i, m.status);
+
 		/* If this entry is not valid, ignore it */
 		if (!(m.status & MCI_STATUS_VAL))
 			continue;
@@ -1595,6 +1597,7 @@ static unsigned long check_interval = INITIAL_CHECK_INTERVAL;
 
 static DEFINE_PER_CPU(unsigned long, mce_next_interval); /* in jiffies */
 static DEFINE_PER_CPU(struct timer_list, mce_timer);
+static DEFINE_PER_CPU(bool, storm_poll_mode);
 
 static void __start_timer(struct timer_list *t, unsigned long interval)
 {
@@ -1630,22 +1633,29 @@ static void mce_timer_fn(struct timer_list *t)
 	else
 		iv = min(iv * 2, round_jiffies_relative(check_interval * HZ));
 
-	__this_cpu_write(mce_next_interval, iv);
-	__start_timer(t, iv);
+	if (__this_cpu_read(storm_poll_mode)) {
+		__start_timer(t, HZ);
+	} else {
+		__this_cpu_write(mce_next_interval, iv);
+		__start_timer(t, iv);
+	}
 }
 
 /*
- * Ensure that the timer is firing in @interval from now.
+ * When a storm starts on any bank on this CPU, switch to polling
+ * once per second. When the storm ends, revert to the default
+ * polling interval.
  */
-void mce_timer_kick(unsigned long interval)
+void mce_timer_kick(bool storm)
 {
 	struct timer_list *t = this_cpu_ptr(&mce_timer);
-	unsigned long iv = __this_cpu_read(mce_next_interval);
 
-	__start_timer(t, interval);
+	__this_cpu_write(storm_poll_mode, storm);
 
-	if (interval < iv)
-		__this_cpu_write(mce_next_interval, interval);
+	if (storm)
+		__start_timer(t, HZ);
+	else
+		__this_cpu_write(mce_next_interval, check_interval * HZ);
 }
 
 /* Must not be called in IRQ context where del_timer_sync() can deadlock */
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index 052bf2708391..59cad4061e5a 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -47,8 +47,47 @@ static DEFINE_PER_CPU(mce_banks_t, mce_banks_owned);
  */
 static DEFINE_RAW_SPINLOCK(cmci_discover_lock);
 
+/*
+ * CMCI storm tracking state
+ *	stormy_bank_count: per-cpu count of MC banks in storm state
+ *	bank_history: bitmask tracking of corrected errors seen in each bank
+ *	bank_time_stamp: last time (in jiffies) that each bank was polled
+ *	cmci_threshold: MCi_CTL2 threshold for each bank when there is no storm
+ */
+static DEFINE_PER_CPU(int, stormy_bank_count);
+static DEFINE_PER_CPU(u64 [MAX_NR_BANKS], bank_history);
+static DEFINE_PER_CPU(bool [MAX_NR_BANKS], bank_storm);
+static DEFINE_PER_CPU(unsigned long [MAX_NR_BANKS], bank_time_stamp);
+static int cmci_threshold[MAX_NR_BANKS];
+
+/* Linux non-storm CMCI threshold (may be overridden by BIOS */
 #define CMCI_THRESHOLD		1
 
+/*
+ * High threshold to limit CMCI rate during storms. Max supported is
+ * 0x7FFF. Use this slightly smaller value so it has a distinctive
+ * signature when some asks "Why am I not seeing all corrected errors?"
+ */
+#define CMCI_STORM_THRESHOLD	32749
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
+
 static int cmci_supported(int *banks)
 {
 	u64 cap;
@@ -103,6 +142,93 @@ static bool lmce_supported(void)
 	return tmp & FEAT_CTL_LMCE_ENABLED;
 }
 
+/*
+ * Set a new CMCI threshold value. Preserve the state of the
+ * MCI_CTL2_CMCI_EN bit in case this happens during a
+ * cmci_rediscover() operation.
+ */
+static void cmci_set_threshold(int bank, int thresh)
+{
+	unsigned long flags;
+	u64 val;
+
+	raw_spin_lock_irqsave(&cmci_discover_lock, flags);
+	rdmsrl(MSR_IA32_MCx_CTL2(bank), val);
+	val &= ~MCI_CTL2_CMCI_THRESHOLD_MASK;
+	wrmsrl(MSR_IA32_MCx_CTL2(bank), val | thresh);
+	raw_spin_unlock_irqrestore(&cmci_discover_lock, flags);
+}
+
+static void cmci_storm_begin(int bank)
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
+static void cmci_storm_end(int bank)
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
+		cmci_set_threshold(bank, cmci_threshold[bank]);
+		cmci_storm_end(bank);
+	} else {
+		if (hweight64(history) < STORM_BEGIN_THRESHOLD)
+			return;
+		pr_notice("CPU%d BANK%d CMCI storm detected\n", smp_processor_id(), bank);
+		cmci_set_threshold(bank, CMCI_STORM_THRESHOLD);
+		cmci_storm_begin(bank);
+	}
+}
+
 /*
  * The interrupt handler. This is called on every event.
  * Just call the poller directly to log any events.
@@ -147,6 +273,9 @@ static void cmci_discover(int banks)
 			continue;
 		}
 
+		if ((val & MCI_CTL2_CMCI_THRESHOLD_MASK) == CMCI_STORM_THRESHOLD)
+			goto storm;
+
 		if (!mca_cfg.bios_cmci_threshold) {
 			val &= ~MCI_CTL2_CMCI_THRESHOLD_MASK;
 			val |= CMCI_THRESHOLD;
@@ -159,7 +288,7 @@ static void cmci_discover(int banks)
 			bios_zero_thresh = 1;
 			val |= CMCI_THRESHOLD;
 		}
-
+storm:
 		val |= MCI_CTL2_CMCI_EN;
 		wrmsrl(MSR_IA32_MCx_CTL2(i), val);
 		rdmsrl(MSR_IA32_MCx_CTL2(i), val);
@@ -167,7 +296,14 @@ static void cmci_discover(int banks)
 		/* Did the enable bit stick? -- the bank supports CMCI */
 		if (val & MCI_CTL2_CMCI_EN) {
 			set_bit(i, owned);
-			__clear_bit(i, this_cpu_ptr(mce_poll_banks));
+			if ((val & MCI_CTL2_CMCI_THRESHOLD_MASK) == CMCI_STORM_THRESHOLD) {
+				pr_notice("CPU%d BANK%d CMCI inherited storm\n", smp_processor_id(), i);
+				this_cpu_write(bank_history[i], ~0ull);
+				this_cpu_write(bank_time_stamp[i], jiffies);
+				cmci_storm_begin(i);
+			} else {
+				__clear_bit(i, this_cpu_ptr(mce_poll_banks));
+			}
 			/*
 			 * We are able to set thresholds for some banks that
 			 * had a threshold of 0. This means the BIOS has not
@@ -177,6 +313,10 @@ static void cmci_discover(int banks)
 			if (mca_cfg.bios_cmci_threshold && bios_zero_thresh &&
 					(val & MCI_CTL2_CMCI_THRESHOLD_MASK))
 				bios_wrong_thresh = 1;
+
+			/* Save default threshold for each bank */
+			if (cmci_threshold[i] == 0)
+				cmci_threshold[i] = val & MCI_CTL2_CMCI_THRESHOLD_MASK;
 		} else {
 			WARN_ON(!test_bit(i, this_cpu_ptr(mce_poll_banks)));
 		}
@@ -218,6 +358,8 @@ static void __cmci_disable_bank(int bank)
 	val &= ~MCI_CTL2_CMCI_EN;
 	wrmsrl(MSR_IA32_MCx_CTL2(bank), val);
 	__clear_bit(bank, this_cpu_ptr(mce_banks_owned));
+	if ((val & MCI_CTL2_CMCI_THRESHOLD_MASK) == CMCI_STORM_THRESHOLD)
+		cmci_storm_end(bank);
 }
 
 /*
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 17d313c9cc60..1ee8fc0d97fe 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -41,12 +41,14 @@ struct dentry *mce_get_debugfs_dir(void);
 extern mce_banks_t mce_banks_ce_disabled;
 
 #ifdef CONFIG_X86_MCE_INTEL
+void track_cmci_storm(int bank, u64 status);
 void cmci_disable_bank(int bank);
 void intel_init_cmci(void);
 void intel_init_lmce(void);
 void intel_clear_lmce(void);
 bool intel_filter_mce(struct mce *m);
 #else
+static inline void track_cmci_storm(int bank, u64 status) { }
 static inline void cmci_disable_bank(int bank) { }
 static inline void intel_init_cmci(void) { }
 static inline void intel_init_lmce(void) { }
@@ -54,7 +56,7 @@ static inline void intel_clear_lmce(void) { }
 static inline bool intel_filter_mce(struct mce *m) { return false; }
 #endif
 
-void mce_timer_kick(unsigned long interval);
+void mce_timer_kick(bool storm);
 
 #ifdef CONFIG_ACPI_APEI
 int apei_write_mce(struct mce *m);
-- 
2.17.1

