Return-Path: <linux-edac+bounces-32-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 710E17ED077
	for <lists+linux-edac@lfdr.de>; Wed, 15 Nov 2023 20:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE8161F212E4
	for <lists+linux-edac@lfdr.de>; Wed, 15 Nov 2023 19:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787323BB48;
	Wed, 15 Nov 2023 19:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gXY9+TwZ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9EC1B9;
	Wed, 15 Nov 2023 11:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700078103; x=1731614103;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d5129gpwYUef8OLtsDlWLxHEjEk4Qud10XxuFNbbP+c=;
  b=gXY9+TwZ2AtTp1ExJR0d3/rTlmpuWnp5/8ksf8EJK/oDZLYgkxifTDIk
   VblexMgy9OypHdIafDAbfDD6wVRZz/0fd43oIYZj4gi2IqSKvK3mqkhD9
   tNlKpIrdt6a34qXoSB62vkUc8mBhJnJuRcMRZ0cvsR1qxoFsmpCyjd0Cn
   RcdB11ArR3ZcaneWsEJh0c0ulSg8vO+rh49aqFp/zXS4rRZPNwas2IyUC
   y+x0Vu5wIEqtzWsskCLiq+UNDUjJsHZIwKKKlemQJS0FY+axIOsSNEiWq
   GT5gqIdStdtTn3DXbKNvIbW6cK/DDC4dt2lFKjsuG1gJQmyz0TL09UqeG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="477165994"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="477165994"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 11:54:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="768693285"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="768693285"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 11:54:57 -0800
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
	Smita.KoralahalliChannabasappa@amd.com,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v10 2/3] x86/mce: Add per-bank CMCI storm mitigation
Date: Wed, 15 Nov 2023 11:54:49 -0800
Message-ID: <20231115195450.12963-3-tony.luck@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115195450.12963-1-tony.luck@intel.com>
References: <20231004183623.17067-1-tony.luck@intel.com>
 <20231115195450.12963-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the core functionality to track CMCI storms at the
machine check bank granularity. Subsequent patches will add
the vendor specific hooks to supply input to the storm
detection and take actions on the start/end of a storm.

machine_check_poll() is called both by the CMCI interrupt code,
and for periodic polls from a timer. Add a hook in this routine
to maintain a bitmap history for each bank showing whether the bank
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

[Changes made based on Boris' comments 23 Oct 2023]

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/internal.h  |  58 +++++++++++++-
 arch/x86/kernel/cpu/mce/core.c      |  33 ++++++--
 arch/x86/kernel/cpu/mce/threshold.c | 112 ++++++++++++++++++++++++++++
 3 files changed, 194 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index b18e99016ce5..e55676f096d8 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -56,7 +56,63 @@ static inline bool intel_filter_mce(struct mce *m) { return false; }
 static inline bool intel_mce_usable_address(struct mce *m) { return false; }
 #endif
 
-void mce_timer_kick(unsigned long interval);
+void mce_timer_kick(bool storm);
+
+#ifdef CONFIG_X86_MCE_THRESHOLD
+void cmci_storm_begin(unsigned int bank);
+void cmci_storm_end(unsigned int bank);
+void mce_track_storm(struct mce *mce);
+void mce_inherit_storm(unsigned int bank);
+bool mce_get_storm_mode(void);
+void mce_set_storm_mode(bool storm);
+#else
+static inline void cmci_storm_begin(unsigned int bank) {}
+static inline void cmci_storm_end(unsigned int bank) {}
+static inline void mce_track_storm(struct mce *mce) {}
+static inline void mce_inherit_storm(unsigned int bank) {}
+static inline bool mce_get_storm_mode(void) { return false; }
+static inline void mce_set_storm_mode(bool storm) {}
+#endif
+
+/*
+ * history:		bitmask tracking whether errors were seen or not seen in
+ *			the most recent polls of a bank. Each '1' bit represents
+ *			an error seen.
+ * timestamp:		last time (in jiffies) that the bank was polled
+ * in_storm_mode:	Is this bank in storm mode?
+ * poll_only:		Bank does not support CMCI, skip storm tracking
+ */
+struct storm_bank {
+	u64 history;
+	u64 timestamp;
+	bool in_storm_mode;
+	bool poll_only;
+};
+
+#define NUM_HISTORY_BITS (sizeof(u64) * BITS_PER_BYTE)
+
+/* How many errors within the history buffer mark the start of a storm. */
+#define STORM_BEGIN_THRESHOLD	5
+
+/*
+ * How many polls of machine check bank without an error before declaring
+ * the storm is over. Since it is tracked by the bitmaks in the history
+ * field of struct storm_bank the mask is 30 bits [0 ... 29].
+ */
+#define STORM_END_POLL_THRESHOLD	29
+
+/*
+ * banks:		per-cpu, per-bank details
+ * stormy_bank_count:	count of MC banks in storm state
+ * poll_mode:		CPU is in poll mode
+ */
+struct mca_storm_desc {
+	struct storm_bank	banks[MAX_NR_BANKS];
+	u8			stormy_bank_count;
+	bool			poll_mode;
+};
+
+DECLARE_PER_CPU(struct mca_storm_desc, storm_desc);
 
 #ifdef CONFIG_ACPI_APEI
 int apei_write_mce(struct mce *m);
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 117848a63aff..820bd7d448c1 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -670,6 +670,16 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		barrier();
 		m.status = mce_rdmsrl(mca_msr_reg(i, MCA_STATUS));
 
+		/*
+		 * Update storm tracking here, before checking for the
+		 * MCI_STATUS_VAL bit. Valid corrected errors count
+		 * towards declaring, or maintaining, storm status. No
+		 * error in a bank counts towards avoiding, or ending,
+		 * storm status.
+		 */
+		if (!mca_cfg.cmci_disabled)
+			mce_track_storm(&m);
+
 		/* If this entry is not valid, ignore it */
 		if (!(m.status & MCI_STATUS_VAL))
 			continue;
@@ -1642,22 +1652,29 @@ static void mce_timer_fn(struct timer_list *t)
 	else
 		iv = min(iv * 2, round_jiffies_relative(check_interval * HZ));
 
-	__this_cpu_write(mce_next_interval, iv);
-	__start_timer(t, iv);
+	if (mce_get_storm_mode()) {
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
+	mce_set_storm_mode(storm);
 
-	if (interval < iv)
-		__this_cpu_write(mce_next_interval, interval);
+	if (storm)
+		__start_timer(t, HZ);
+	else
+		__this_cpu_write(mce_next_interval, check_interval * HZ);
 }
 
 /* Must not be called in IRQ context where del_timer_sync() can deadlock */
diff --git a/arch/x86/kernel/cpu/mce/threshold.c b/arch/x86/kernel/cpu/mce/threshold.c
index ef4e7bb5fd88..0e1988468ee4 100644
--- a/arch/x86/kernel/cpu/mce/threshold.c
+++ b/arch/x86/kernel/cpu/mce/threshold.c
@@ -29,3 +29,115 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_threshold)
 	trace_threshold_apic_exit(THRESHOLD_APIC_VECTOR);
 	apic_eoi();
 }
+
+DEFINE_PER_CPU(struct mca_storm_desc, storm_desc);
+
+void mce_inherit_storm(unsigned int bank)
+{
+	struct mca_storm_desc *storm = this_cpu_ptr(&storm_desc);
+
+	/*
+	 * Previous CPU owning this bank had put it into storm mode,
+	 * but the precise history of that storm is unknown. Assume
+	 * the worst (all recent polls of the bank found a valid error
+	 * logged). This will avoid the new owner prematurely declaring
+	 * the storm has ended.
+	 */
+	storm->banks[bank].history = ~0ull;
+	storm->banks[bank].timestamp = jiffies;
+}
+
+bool mce_get_storm_mode(void)
+{
+	return __this_cpu_read(storm_desc.poll_mode);
+}
+
+void mce_set_storm_mode(bool storm)
+{
+	__this_cpu_write(storm_desc.poll_mode, storm);
+}
+
+static void mce_handle_storm(unsigned int bank, bool on)
+{
+	switch (boot_cpu_data.x86_vendor) {
+	}
+}
+
+void cmci_storm_begin(unsigned int bank)
+{
+	struct mca_storm_desc *storm = this_cpu_ptr(&storm_desc);
+
+	__set_bit(bank, this_cpu_ptr(mce_poll_banks));
+	storm->banks[bank].in_storm_mode = true;
+
+	/*
+	 * If this is the first bank on this CPU to enter storm mode
+	 * start polling.
+	 */
+	if (++storm->stormy_bank_count == 1)
+		mce_timer_kick(true);
+}
+
+void cmci_storm_end(unsigned int bank)
+{
+	struct mca_storm_desc *storm = this_cpu_ptr(&storm_desc);
+
+	__clear_bit(bank, this_cpu_ptr(mce_poll_banks));
+	storm->banks[bank].history = 0;
+	storm->banks[bank].in_storm_mode = false;
+
+	/* If no banks left in storm mode, stop polling. */
+	if (!this_cpu_dec_return(storm_desc.stormy_bank_count))
+		mce_timer_kick(false);
+}
+
+void mce_track_storm(struct mce *mce)
+{
+	struct mca_storm_desc *storm = this_cpu_ptr(&storm_desc);
+	unsigned long now = jiffies, delta;
+	unsigned int shift = 1;
+	u64 history = 0;
+
+	/* No tracking needed for banks that do not support CMCI */
+	if (storm->banks[mce->bank].poll_only)
+		return;
+
+	/*
+	 * When a bank is in storm mode it is polled once per second and
+	 * the history mask will record about the last minute of poll results.
+	 * If it is not in storm mode, then the bank is only checked when
+	 * there is a CMCI interrupt. Check how long it has been since
+	 * this bank was last checked, and adjust the amount of "shift"
+	 * to apply to history.
+	 */
+	if (!storm->banks[mce->bank].in_storm_mode) {
+		delta = now - storm->banks[mce->bank].timestamp;
+		shift = (delta + HZ) / HZ;
+	}
+
+	/* If it has been a long time since the last poll, clear history. */
+	if (shift < NUM_HISTORY_BITS)
+		history = storm->banks[mce->bank].history << shift;
+
+	storm->banks[mce->bank].timestamp = now;
+
+	/* History keeps track of corrected errors. VAL=1 && UC=0 */
+	if ((mce->status & MCI_STATUS_VAL) && mce_is_correctable(mce))
+		history |= 1;
+
+	storm->banks[mce->bank].history = history;
+
+	if (storm->banks[mce->bank].in_storm_mode) {
+		if (history & GENMASK_ULL(STORM_END_POLL_THRESHOLD, 0))
+			return;
+		printk_deferred(KERN_NOTICE "CPU%d BANK%d CMCI storm subsided\n", smp_processor_id(), mce->bank);
+		mce_handle_storm(mce->bank, false);
+		cmci_storm_end(mce->bank);
+	} else {
+		if (hweight64(history) < STORM_BEGIN_THRESHOLD)
+			return;
+		printk_deferred(KERN_NOTICE "CPU%d BANK%d CMCI storm detected\n", smp_processor_id(), mce->bank);
+		mce_handle_storm(mce->bank, true);
+		cmci_storm_begin(mce->bank);
+	}
+}
-- 
2.41.0


