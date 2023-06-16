Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76617733819
	for <lists+linux-edac@lfdr.de>; Fri, 16 Jun 2023 20:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjFPS14 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 16 Jun 2023 14:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbjFPS1z (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 16 Jun 2023 14:27:55 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6EA35AD;
        Fri, 16 Jun 2023 11:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686940073; x=1718476073;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=saXdChlUx9A9/qRbX5PWkqsKLR3duIy530rHq98coDc=;
  b=Y6sK4ICd6XW01L2wrzmIFxMF6/MNZ4+W8DaCUku3BFLdOsVOTgppY9Se
   W/WaJrY/L4Ie6+X4DELhZf0ImyA3LjcFEaeKH2WWCm4so+Z7ODd1AWkiR
   w8DjL+DOKldGiRW5Vp3VwybJNQH226m4SCdq3yArkc2MkmQy+ocXSzvjh
   hXNh9k/Q3oXlWdSKNzkkyQte2TmlUWZlyxZAaC+M9Qht8Kr/RgKHFsbAL
   j/E4rNrOQMe/6/pYKSpD1yRJMdi3grPaZq2o+hkZZSyghJWRMfPRYrVd2
   ryNgWW5IyI/1pF748/86347dQnvCfkUAKIWsJOChaxH1TgH7IHugD3Ix9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="361815192"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="361815192"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 11:27:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="783018172"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="783018172"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 11:27:51 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita.KoralahalliChannabasappa@amd.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>
Subject: [PATCH v6 2/4] x86/mce: Add per-bank CMCI storm mitigation
Date:   Fri, 16 Jun 2023 11:27:42 -0700
Message-Id: <20230616182744.17632-3-tony.luck@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230616182744.17632-1-tony.luck@intel.com>
References: <20230411173841.70491-1-tony.luck@intel.com>
 <20230616182744.17632-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This is the core functionality to track CMCI storms at the
machine check bank granularity. Subsequent patches will add
the vendor specific hooks to supply input to the storm
detection and take actions on the start/end of a storm.

Maintain a bitmap history for each bank showing whether the bank
logged an corrected error or not each time it is polled.

In normal operation the interval between polls of this banks
determines how far to shift the history. The 64 bit width corresponds
to about one second.

When a storm is observed a CPU vendor specific action is taken to reduce
or stop CMCI from the bank that is the source of the storm.  The bank
is added to the bitmap of banks for this CPU to poll. The polling rate
is increased to once per second.  During a storm each bit in the history
indicates the status of the bank each time it is polled. Thus the history
covers just over a minute.

Declare a storm for that bank if the number of corrected interrupts
seen in that history is above some threshold (defined as 5 in this
series, could be tuned later if there is data to suggest a better
value).

A storm on a bank ends if enough consecutive polls of the bank show
no corrected errors (defined as 30, may also change). That calls the
CPU vendor specific function to revert to normal operational mode,
and changes the polling rate back to the default.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/internal.h |  33 ++++++++-
 arch/x86/kernel/cpu/mce/core.c     | 109 ++++++++++++++++++++++++++---
 2 files changed, 133 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 9dcad55835fa..eae88a824d97 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -40,6 +40,8 @@ struct dentry *mce_get_debugfs_dir(void);
 
 extern mce_banks_t mce_banks_ce_disabled;
 
+void track_cmci_storm(int bank, u64 status);
+
 #ifdef CONFIG_X86_MCE_INTEL
 void cmci_disable_bank(int bank);
 void intel_init_cmci(void);
@@ -54,7 +56,36 @@ static inline void intel_clear_lmce(void) { }
 static inline bool intel_filter_mce(struct mce *m) { return false; }
 #endif
 
-void mce_timer_kick(unsigned long interval);
+void mce_timer_kick(bool storm);
+void mce_handle_storm(int bank, bool on);
+void cmci_storm_begin(int bank);
+void cmci_storm_end(int bank);
+
+/**
+ * struct mca_storm_desc - CMCI storm tracking data
+ * @stormy_bank_count: count of MC banks in storm state
+ * @bank_history: bitmask tracking of corrected errors seen in each bank
+ * @bank_storm: determines whether the bank is in storm mode
+ * @bank_time_stamp: last time (in jiffies) that each bank was polled
+ */
+struct mca_storm_desc {
+	int		stormy_bank_count;
+	u64		bank_history[MAX_NR_BANKS];
+	bool		bank_storm[MAX_NR_BANKS];
+	unsigned long	bank_time_stamp[MAX_NR_BANKS];
+};
+DECLARE_PER_CPU(struct mca_storm_desc, storm_desc);
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
index e7936be84204..cd9d9ea5bb0a 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -607,6 +607,83 @@ static struct notifier_block mce_default_nb = {
 	.priority	= MCE_PRIO_LOWEST,
 };
 
+DEFINE_PER_CPU(struct mca_storm_desc, storm_desc);
+
+void cmci_storm_begin(int bank)
+{
+	struct mca_storm_desc *storm = this_cpu_ptr(&storm_desc);
+
+	__set_bit(bank, this_cpu_ptr(mce_poll_banks));
+	storm->bank_storm[bank] = true;
+
+	/*
+	 * If this is the first bank on this CPU to enter storm mode
+	 * start polling
+	 */
+	if (++storm->stormy_bank_count == 1)
+		mce_timer_kick(true);
+}
+
+void cmci_storm_end(int bank)
+{
+	struct mca_storm_desc *storm = this_cpu_ptr(&storm_desc);
+
+	__clear_bit(bank, this_cpu_ptr(mce_poll_banks));
+	storm->bank_history[bank] = 0ull;
+	storm->bank_storm[bank] = false;
+
+	/* If no banks left in storm mode, stop polling */
+	if (!this_cpu_dec_return(storm_desc.stormy_bank_count))
+		mce_timer_kick(false);
+}
+
+void track_cmci_storm(int bank, u64 status)
+{
+	struct mca_storm_desc *storm = this_cpu_ptr(&storm_desc);
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
+	if (!storm->bank_storm[bank]) {
+		delta = now - storm->bank_time_stamp[bank];
+		shift = (delta + HZ) / HZ;
+	}
+
+	/* If has been a long time since the last poll, clear history */
+	if (shift >= 64)
+		history = 0;
+	else
+		history = storm->bank_history[bank] << shift;
+	storm->bank_time_stamp[bank] = now;
+
+	/* History keeps track of corrected errors. VAL=1 && UC=0 */
+	if ((status & (MCI_STATUS_VAL | MCI_STATUS_UC)) == MCI_STATUS_VAL)
+		history |= 1;
+	storm->bank_history[bank] = history;
+
+	if (storm->bank_storm[bank]) {
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
@@ -680,6 +757,8 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		barrier();
 		m.status = mce_rdmsrl(mca_msr_reg(i, MCA_STATUS));
 
+		track_cmci_storm(i, m.status);
+
 		/* If this entry is not valid, ignore it */
 		if (!(m.status & MCI_STATUS_VAL))
 			continue;
@@ -1587,6 +1666,7 @@ static unsigned long check_interval = INITIAL_CHECK_INTERVAL;
 
 static DEFINE_PER_CPU(unsigned long, mce_next_interval); /* in jiffies */
 static DEFINE_PER_CPU(struct timer_list, mce_timer);
+static DEFINE_PER_CPU(bool, storm_poll_mode);
 
 static void __start_timer(struct timer_list *t, unsigned long interval)
 {
@@ -1622,22 +1702,29 @@ static void mce_timer_fn(struct timer_list *t)
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
@@ -1965,6 +2052,12 @@ static void mce_zhaoxin_feature_clear(struct cpuinfo_x86 *c)
 	intel_clear_lmce();
 }
 
+void mce_handle_storm(int bank, bool on)
+{
+	switch (boot_cpu_data.x86_vendor) {
+	}
+}
+
 static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
 {
 	switch (c->x86_vendor) {
-- 
2.40.1

