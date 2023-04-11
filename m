Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2471A6DE2BD
	for <lists+linux-edac@lfdr.de>; Tue, 11 Apr 2023 19:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjDKRjB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 11 Apr 2023 13:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjDKRi6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 11 Apr 2023 13:38:58 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064AA55AA;
        Tue, 11 Apr 2023 10:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681234737; x=1712770737;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fx+kH2YXFLhNcQcZmykebf2IM6w1phgRWTibE277G10=;
  b=YHCK62DWZY3TpmRxFmXAmyf8b+GC305s7oyIWomHouzaibRlQgRVgEnT
   UKX730AXzAazQg4Of2Mi8PwvJcf8mik8u0clkgKdxZzj4cLT5PJCStD6r
   qEkrRG9UkJYAmdQ+SX5KucyWF2OzHNWb61CzC2d8vxXn4MzIemzIQlUNT
   utkEbw6ugPP2wEaat5zQ5DsVvMvwYGoZ71Pi84laGOkqrx31340R2Uj4J
   YlGrQCHv0so+JTCwZGM/KK30iOpYX7hAI9IClIjygmmPSvj1nFD9GXT9h
   SrRLCf5sNBnRBUXDqWbv1VpMOmSxO0OD33PIhVp935l6g83jsQTgVRyyc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="346359973"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="346359973"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 10:38:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="638911768"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="638911768"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 10:38:54 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita.KoralahalliChannabasappa@amd.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>
Subject: [PATCH v5 4/5] x86/mce: Move storm handling to core.
Date:   Tue, 11 Apr 2023 10:38:40 -0700
Message-Id: <20230411173841.70491-5-tony.luck@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411173841.70491-1-tony.luck@intel.com>
References: <20230403210716.347773-1-tony.luck@intel.com>
 <20230411173841.70491-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
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
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Tested-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/internal.h | 20 ++++++-
 arch/x86/kernel/cpu/mce/core.c     | 81 ++++++++++++++++++++++++++
 arch/x86/kernel/cpu/mce/intel.c    | 93 +-----------------------------
 3 files changed, 100 insertions(+), 94 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index e0d76378c116..9a2d6e289b8d 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -47,7 +47,6 @@ void intel_init_cmci(void);
 void intel_init_lmce(void);
 void intel_clear_lmce(void);
 bool intel_filter_mce(struct mce *m);
-void track_cmci_storm(int bank, u64 status);
 #else
 static inline void mce_intel_handle_storm(int bank, bool on) { }
 static inline void cmci_disable_bank(int bank) { }
@@ -55,11 +54,28 @@ static inline void intel_init_cmci(void) { }
 static inline void intel_init_lmce(void) { }
 static inline void intel_clear_lmce(void) { }
 static inline bool intel_filter_mce(struct mce *m) { return false; }
-static inline void track_cmci_storm(int bank, u64 status) { }
 #endif
 
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
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 099d8444aca4..820b317b1b85 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -607,6 +607,87 @@ static struct notifier_block mce_default_nb = {
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
+		mce_handle_storm(bank, false);
+		cmci_storm_end(bank);
+	} else {
+		if (hweight64(history) < STORM_BEGIN_THRESHOLD)
+			return;
+		pr_notice("CPU%d BANK%d CMCI storm detected\n", smp_processor_id(), bank);
+		mce_handle_storm(bank, true);
+		cmci_storm_begin(bank);
+	}
+}
+
 /*
  * Read ADDR and MISC registers.
  */
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index a8248514a689..20c2143a68c1 100644
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
 		cmci_set_threshold(bank, cmci_threshold[bank]);
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
-		mce_handle_storm(bank, false);
-		cmci_storm_end(bank);
-	} else {
-		if (hweight64(history) < STORM_BEGIN_THRESHOLD)
-			return;
-		pr_notice("CPU%d BANK%d CMCI storm detected\n", smp_processor_id(), bank);
-		mce_handle_storm(bank, true);
-		cmci_storm_begin(bank);
-	}
-}
-
 /*
  * The interrupt handler. This is called on every event.
  * Just call the poller directly to log any events.
-- 
2.39.2

