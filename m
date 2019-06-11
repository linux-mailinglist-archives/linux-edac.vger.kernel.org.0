Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 335A73D231
	for <lists+linux-edac@lfdr.de>; Tue, 11 Jun 2019 18:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389575AbfFKQZu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 11 Jun 2019 12:25:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58019 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388330AbfFKQZu (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 11 Jun 2019 12:25:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5BGPD5X281357
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 11 Jun 2019 09:25:13 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5BGPD5X281357
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560270314;
        bh=1YSEMLSFXBL0r9Y8s64bWxuBVG0X/upe09QEg6jbjZc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=cPBGQ3cHTFArH4sbTUhxjX6meXY27D/JHaOUv3b5DoUF3RVyHn1i1ZJ/TllZj9qHK
         z9yde1SexSMOPe9w8IQnqPCnr0crPvSX0G+yJA8494UlRcE2R/XvCWBmHsiHNf/FsY
         w1Ju1dS4HacaQ3p9S43ErV7UK6DyAFKzddBpCTcIJr2jt8XQL+2QuT3SLHFhm0MITl
         0XkBGd+6jLmT8YcWsrpZtiFKZ8sXzCQlzUNDIHt9g+OayTYZ/qLeDuoPd0ahTJdaTx
         CEFWyXkfNVGXmGJSaF5qykRU8V4tGRzpGPxDpPI+WI3oxRaYclChrQ38RfZZeEo/RP
         TkRLYirM9aF9A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5BGPC8b281350;
        Tue, 11 Jun 2019 09:25:12 -0700
Date:   Tue, 11 Jun 2019 09:25:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yazen Ghannam <tipbot@zytor.com>
Message-ID: <tip-c7d314f386e987be8b51eeb7dd947756ae23f6b6@git.kernel.org>
Cc:     tony.luck@intel.com, mingo@redhat.com, yazen.ghannam@amd.com,
        hpa@zytor.com, bp@suse.de, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        linux-edac@vger.kernel.org, x86@kernel.org
Reply-To: x86@kernel.org, linux-edac@vger.kernel.org, tony.luck@intel.com,
          mingo@redhat.com, yazen.ghannam@amd.com, hpa@zytor.com,
          bp@suse.de, tglx@linutronix.de, linux-kernel@vger.kernel.org,
          mingo@kernel.org
In-Reply-To: <20190607201752.221446-5-Yazen.Ghannam@amd.com>
References: <20190607201752.221446-5-Yazen.Ghannam@amd.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] x86/MCE: Make the number of MCA banks a per-CPU
 variable
Git-Commit-ID: c7d314f386e987be8b51eeb7dd947756ae23f6b6
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-1.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Commit-ID:  c7d314f386e987be8b51eeb7dd947756ae23f6b6
Gitweb:     https://git.kernel.org/tip/c7d314f386e987be8b51eeb7dd947756ae23f6b6
Author:     Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate: Fri, 7 Jun 2019 20:18:05 +0000
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Tue, 11 Jun 2019 15:23:09 +0200

x86/MCE: Make the number of MCA banks a per-CPU variable

The number of MCA banks is provided per logical CPU. Historically, this
number has been the same across all CPUs, but this is not an
architectural guarantee. Future AMD systems may have MCA bank counts
that vary between logical CPUs in a system.

This issue was partially addressed in

  006c077041dc ("x86/mce: Handle varying MCA bank counts")

by allocating structures using the maximum number of MCA banks and by
saving the maximum MCA bank count in a system as the global count. This
means that some extra structures are allocated. Also, this means that
CPUs will spend more time in the #MC and other handlers checking extra
MCA banks.

Thus, define the number of MCA banks as a per-CPU variable.

 [ bp: Make mce_num_banks an unsigned int. ]

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: "x86@kernel.org" <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190607201752.221446-5-Yazen.Ghannam@amd.com
---
 arch/x86/kernel/cpu/mce/amd.c      | 19 ++++++++--------
 arch/x86/kernel/cpu/mce/core.c     | 45 +++++++++++++++++++++-----------------
 arch/x86/kernel/cpu/mce/internal.h |  2 +-
 3 files changed, 36 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index d4d6e4b7f9dc..fb5c935af2c5 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -495,7 +495,7 @@ static u32 get_block_address(u32 current_addr, u32 low, u32 high,
 {
 	u32 addr = 0, offset = 0;
 
-	if ((bank >= mca_cfg.banks) || (block >= NR_BLOCKS))
+	if ((bank >= per_cpu(mce_num_banks, cpu)) || (block >= NR_BLOCKS))
 		return addr;
 
 	if (mce_flags.smca)
@@ -627,11 +627,12 @@ void disable_err_thresholding(struct cpuinfo_x86 *c, unsigned int bank)
 /* cpu init entry point, called from mce.c with preempt off */
 void mce_amd_feature_init(struct cpuinfo_x86 *c)
 {
-	u32 low = 0, high = 0, address = 0;
 	unsigned int bank, block, cpu = smp_processor_id();
+	u32 low = 0, high = 0, address = 0;
 	int offset = -1;
 
-	for (bank = 0; bank < mca_cfg.banks; ++bank) {
+
+	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
 		if (mce_flags.smca)
 			smca_configure(bank, cpu);
 
@@ -976,7 +977,7 @@ static void amd_deferred_error_interrupt(void)
 {
 	unsigned int bank;
 
-	for (bank = 0; bank < mca_cfg.banks; ++bank)
+	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank)
 		log_error_deferred(bank);
 }
 
@@ -1017,7 +1018,7 @@ static void amd_threshold_interrupt(void)
 	struct threshold_block *first_block = NULL, *block = NULL, *tmp = NULL;
 	unsigned int bank, cpu = smp_processor_id();
 
-	for (bank = 0; bank < mca_cfg.banks; ++bank) {
+	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
 		if (!(per_cpu(bank_map, cpu) & (1 << bank)))
 			continue;
 
@@ -1204,7 +1205,7 @@ static int allocate_threshold_blocks(unsigned int cpu, unsigned int bank,
 	u32 low, high;
 	int err;
 
-	if ((bank >= mca_cfg.banks) || (block >= NR_BLOCKS))
+	if ((bank >= per_cpu(mce_num_banks, cpu)) || (block >= NR_BLOCKS))
 		return 0;
 
 	if (rdmsr_safe_on_cpu(cpu, address, &low, &high))
@@ -1438,7 +1439,7 @@ int mce_threshold_remove_device(unsigned int cpu)
 {
 	unsigned int bank;
 
-	for (bank = 0; bank < mca_cfg.banks; ++bank) {
+	for (bank = 0; bank < per_cpu(mce_num_banks, cpu); ++bank) {
 		if (!(per_cpu(bank_map, cpu) & (1 << bank)))
 			continue;
 		threshold_remove_bank(cpu, bank);
@@ -1459,14 +1460,14 @@ int mce_threshold_create_device(unsigned int cpu)
 	if (bp)
 		return 0;
 
-	bp = kcalloc(mca_cfg.banks, sizeof(struct threshold_bank *),
+	bp = kcalloc(per_cpu(mce_num_banks, cpu), sizeof(struct threshold_bank *),
 		     GFP_KERNEL);
 	if (!bp)
 		return -ENOMEM;
 
 	per_cpu(threshold_banks, cpu) = bp;
 
-	for (bank = 0; bank < mca_cfg.banks; ++bank) {
+	for (bank = 0; bank < per_cpu(mce_num_banks, cpu); ++bank) {
 		if (!(per_cpu(bank_map, cpu) & (1 << bank)))
 			continue;
 		err = threshold_create_bank(cpu, bank);
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 49fac95d036b..10f9f140985e 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -65,6 +65,8 @@ static DEFINE_MUTEX(mce_sysfs_mutex);
 
 DEFINE_PER_CPU(unsigned, mce_exception_count);
 
+DEFINE_PER_CPU_READ_MOSTLY(unsigned int, mce_num_banks);
+
 struct mce_bank {
 	u64			ctl;			/* subevents to enable */
 	bool			init;			/* initialise bank? */
@@ -701,7 +703,7 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 	if (flags & MCP_TIMESTAMP)
 		m.tsc = rdtsc();
 
-	for (i = 0; i < mca_cfg.banks; i++) {
+	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
 		if (!mce_banks[i].ctl || !test_bit(i, *b))
 			continue;
 
@@ -803,7 +805,7 @@ static int mce_no_way_out(struct mce *m, char **msg, unsigned long *validp,
 	char *tmp;
 	int i;
 
-	for (i = 0; i < mca_cfg.banks; i++) {
+	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
 		m->status = mce_rdmsrl(msr_ops.status(i));
 		if (!(m->status & MCI_STATUS_VAL))
 			continue;
@@ -1083,7 +1085,7 @@ static void mce_clear_state(unsigned long *toclear)
 {
 	int i;
 
-	for (i = 0; i < mca_cfg.banks; i++) {
+	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
 		if (test_bit(i, toclear))
 			mce_wrmsrl(msr_ops.status(i), 0);
 	}
@@ -1141,7 +1143,7 @@ static void __mc_scan_banks(struct mce *m, struct mce *final,
 	struct mca_config *cfg = &mca_cfg;
 	int severity, i;
 
-	for (i = 0; i < cfg->banks; i++) {
+	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
 		__clear_bit(i, toclear);
 		if (!test_bit(i, valid_banks))
 			continue;
@@ -1482,9 +1484,10 @@ EXPORT_SYMBOL_GPL(mce_notify_irq);
 static void __mcheck_cpu_mce_banks_init(void)
 {
 	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
+	u8 n_banks = this_cpu_read(mce_num_banks);
 	int i;
 
-	for (i = 0; i < MAX_NR_BANKS; i++) {
+	for (i = 0; i < n_banks; i++) {
 		struct mce_bank *b = &mce_banks[i];
 
 		b->ctl = -1ULL;
@@ -1503,10 +1506,14 @@ static void __mcheck_cpu_cap_init(void)
 	rdmsrl(MSR_IA32_MCG_CAP, cap);
 
 	b = cap & MCG_BANKCNT_MASK;
-	if (WARN_ON_ONCE(b > MAX_NR_BANKS))
+
+	if (b > MAX_NR_BANKS) {
+		pr_warn("CPU%d: Using only %u machine check banks out of %u\n",
+			smp_processor_id(), MAX_NR_BANKS, b);
 		b = MAX_NR_BANKS;
+	}
 
-	mca_cfg.banks = max(mca_cfg.banks, b);
+	this_cpu_write(mce_num_banks, b);
 
 	__mcheck_cpu_mce_banks_init();
 
@@ -1545,7 +1552,7 @@ static void __mcheck_cpu_init_clear_banks(void)
 	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
 	int i;
 
-	for (i = 0; i < mca_cfg.banks; i++) {
+	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
 		struct mce_bank *b = &mce_banks[i];
 
 		if (!b->init)
@@ -1596,7 +1603,7 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 
 	/* This should be disabled by the BIOS, but isn't always */
 	if (c->x86_vendor == X86_VENDOR_AMD) {
-		if (c->x86 == 15 && cfg->banks > 4) {
+		if (c->x86 == 15 && this_cpu_read(mce_num_banks) > 4) {
 			/*
 			 * disable GART TBL walk error reporting, which
 			 * trips off incorrectly with the IOMMU & 3ware
@@ -1615,7 +1622,7 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 		 * Various K7s with broken bank 0 around. Always disable
 		 * by default.
 		 */
-		if (c->x86 == 6 && cfg->banks > 0)
+		if (c->x86 == 6 && this_cpu_read(mce_num_banks) > 0)
 			mce_banks[0].ctl = 0;
 
 		/*
@@ -1637,7 +1644,7 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 		 * valid event later, merely don't write CTL0.
 		 */
 
-		if (c->x86 == 6 && c->x86_model < 0x1A && cfg->banks > 0)
+		if (c->x86 == 6 && c->x86_model < 0x1A && this_cpu_read(mce_num_banks) > 0)
 			mce_banks[0].init = 0;
 
 		/*
@@ -1873,7 +1880,7 @@ static void __mce_disable_bank(void *arg)
 
 void mce_disable_bank(int bank)
 {
-	if (bank >= mca_cfg.banks) {
+	if (bank >= this_cpu_read(mce_num_banks)) {
 		pr_warn(FW_BUG
 			"Ignoring request to disable invalid MCA bank %d.\n",
 			bank);
@@ -1962,7 +1969,7 @@ static void mce_disable_error_reporting(void)
 	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
 	int i;
 
-	for (i = 0; i < mca_cfg.banks; i++) {
+	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
 		struct mce_bank *b = &mce_banks[i];
 
 		if (b->init)
@@ -2073,7 +2080,7 @@ static ssize_t show_bank(struct device *s, struct device_attribute *attr,
 	u8 bank = attr_to_bank(attr)->bank;
 	struct mce_bank *b;
 
-	if (bank >= mca_cfg.banks)
+	if (bank >= per_cpu(mce_num_banks, s->id))
 		return -EINVAL;
 
 	b = &per_cpu(mce_banks_array, s->id)[bank];
@@ -2091,7 +2098,7 @@ static ssize_t set_bank(struct device *s, struct device_attribute *attr,
 	if (kstrtou64(buf, 0, &new) < 0)
 		return -EINVAL;
 
-	if (bank >= mca_cfg.banks)
+	if (bank >= per_cpu(mce_num_banks, s->id))
 		return -EINVAL;
 
 	b = &per_cpu(mce_banks_array, s->id)[bank];
@@ -2243,7 +2250,7 @@ static int mce_device_create(unsigned int cpu)
 		if (err)
 			goto error;
 	}
-	for (j = 0; j < mca_cfg.banks; j++) {
+	for (j = 0; j < per_cpu(mce_num_banks, cpu); j++) {
 		err = device_create_file(dev, &mce_bank_devs[j].attr);
 		if (err)
 			goto error2;
@@ -2275,7 +2282,7 @@ static void mce_device_remove(unsigned int cpu)
 	for (i = 0; mce_device_attrs[i]; i++)
 		device_remove_file(dev, mce_device_attrs[i]);
 
-	for (i = 0; i < mca_cfg.banks; i++)
+	for (i = 0; i < per_cpu(mce_num_banks, cpu); i++)
 		device_remove_file(dev, &mce_bank_devs[i].attr);
 
 	device_unregister(dev);
@@ -2305,7 +2312,7 @@ static void mce_reenable_cpu(void)
 
 	if (!cpuhp_tasks_frozen)
 		cmci_reenable();
-	for (i = 0; i < mca_cfg.banks; i++) {
+	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
 		struct mce_bank *b = &mce_banks[i];
 
 		if (b->init)
@@ -2493,8 +2500,6 @@ EXPORT_SYMBOL_GPL(mcsafe_key);
 
 static int __init mcheck_late_init(void)
 {
-	pr_info("Using %d MCE banks\n", mca_cfg.banks);
-
 	if (mca_cfg.recovery)
 		static_branch_inc(&mcsafe_key);
 
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 35b3e5c02c1c..43031db429d2 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -118,7 +118,6 @@ struct mca_config {
 	      bios_cmci_threshold	: 1,
 	      __reserved		: 59;
 
-	u8 banks;
 	s8 bootlog;
 	int tolerant;
 	int monarch_timeout;
@@ -127,6 +126,7 @@ struct mca_config {
 };
 
 extern struct mca_config mca_cfg;
+DECLARE_PER_CPU_READ_MOSTLY(unsigned int, mce_num_banks);
 
 struct mce_vendor_flags {
 	/*
