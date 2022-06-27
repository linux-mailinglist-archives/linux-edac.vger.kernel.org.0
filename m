Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB91E55CAFD
	for <lists+linux-edac@lfdr.de>; Tue, 28 Jun 2022 14:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239959AbiF0Rgi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Jun 2022 13:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239945AbiF0Rgd (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 27 Jun 2022 13:36:33 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D6CB7E8;
        Mon, 27 Jun 2022 10:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656351392; x=1687887392;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TncpZtq+agDq/jm35/vtT+NeRvYHNeO9BO7ZjRMPXig=;
  b=hmaXArTfrtjX0U27AKdBnu3iecp9ySRhE+veiSgOS1ym9XvellNV6P8V
   F75DFd4ogoWpFGV/5RK7eQCRPle6Uhuk3zHaHN45Vdyu3sSlR5zdJZlgr
   Fv7DC6LBMLhCt563z5mDAFPrgDKJiekPR8jD64PTer8a/mS5uK5FNdBlI
   ltWsRaUrTjWiYuEgYrcG8x8si5FZCiBLjPnxIxg17bPIMxQJWPdL4QahN
   s5qL8qj+p/1q614558luafos9rfFK4Ye1iA33gai9I6za8pxXxcFSVNe8
   J34xrAmyhrv+9DzN3Xzkfm1+dOOzy2j51F9+uCCv3CP9h0wCLsW3FQUMO
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="270262456"
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="270262456"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 10:36:12 -0700
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="594399457"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 10:36:11 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Smita.KoralahalliChannabasappa@amd.com,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, yazen.ghannam@amd.com, patches@lists.linux.dev,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH v2 4/5] x86/mce: Move storm handling to core.
Date:   Mon, 27 Jun 2022 10:36:04 -0700
Message-Id: <20220627173605.514504-5-tony.luck@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220627173605.514504-1-tony.luck@intel.com>
References: <YrFSSZqjtWlm9rUr@agluck-desk3.sc.intel.com>
 <20220627173605.514504-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

AMD's storm handling for threshold interrupts is similar to Intel's CMCI
storm handling. Hence, make the storm handling code common by moving to
core and removing the vendor exclusivity.

On the contrary, setting different thresholds to reduce rate of interrupts
in IA32_MCi_CTL2 register is kept Intel intact as the storm handling for
AMD slightly differs where in it handles the storms by turning off the
interrupts.

No functional changes.

[Tony: Same as Smita's original, plus changes rolled in from prior patches]

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/core.c     | 81 ++++++++++++++++++++++++++
 arch/x86/kernel/cpu/mce/intel.c    | 93 +-----------------------------
 arch/x86/kernel/cpu/mce/internal.h | 18 ++++++
 3 files changed, 100 insertions(+), 92 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index f4d2a7ba29f7..d27daa199523 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -613,6 +613,87 @@ static struct notifier_block mce_default_nb = {
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
+	 * When a bank is in storm mode it is polled once per second and
+	 * the history mask will record about the last minute of poll results.
+	 * If it is not in storm mode, then the bank is only checked when
+	 * there is a CMCI interrupt. Check how long it has been since
+	 * this bank was last checked, and adjust the amount of "shift"
+	 * to apply to history.
+	 */
+	if (!this_cpu_read(bank_storm[bank])) {
+		delta = now - this_cpu_read(bank_time_stamp[bank]);
+		shift = (delta + HZ) / HZ;
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
index 4238b73c2143..6cc9aa97c092 100644
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
@@ -70,17 +60,6 @@ static int cmci_threshold[MAX_NR_BANKS];
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
 static int cmci_supported(int *banks)
 {
 	u64 cap;
@@ -160,76 +139,6 @@ void mce_intel_handle_storm(int bank, bool on)
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
-	 * When a bank is in storm mode it is polled once per second and
-	 * the history mask will record about the last minute of poll results.
-	 * If it is not in storm mode, then the bank is only checked when
-	 * there is a CMCI interrupt. Check how long it has been since
-	 * this bank was last checked, and adjust the amount of "shift"
-	 * to apply to history.
-	 */
-	if (!this_cpu_read(bank_storm[bank])) {
-		delta = now - this_cpu_read(bank_time_stamp[bank]);
-		shift = (delta + HZ) / HZ;
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
index 78467f6cdd04..d7cad839a6a9 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -60,6 +60,24 @@ static inline bool intel_filter_mce(struct mce *m) { return false; }
 
 void mce_timer_kick(bool storm);
 void mce_handle_storm(int bank, bool on);
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
 
 #ifdef CONFIG_ACPI_APEI
 int apei_write_mce(struct mce *m);
-- 
2.35.3

