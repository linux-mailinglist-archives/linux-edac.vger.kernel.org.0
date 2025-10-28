Return-Path: <linux-edac+bounces-5243-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 162D9C17542
	for <lists+linux-edac@lfdr.de>; Wed, 29 Oct 2025 00:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F1C0E4E2809
	for <lists+linux-edac@lfdr.de>; Tue, 28 Oct 2025 23:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19DC345730;
	Tue, 28 Oct 2025 23:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="NjWsmEz8"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01302AD32;
	Tue, 28 Oct 2025 23:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761693535; cv=none; b=X0uN5pXDcN8CxO9SSzouk3NQhCo88YL+Rm5Pj7yMNdB/gE+mBVEbvgORCxUp+cjzPWNwtbx3/hD/GyJcWYh2MmGcJC8LG/W5Ya5EQVscsusDnJbajZ0UkO6vdLvGNgtq9YbEApV8yrAabZ1nMehM8nQURzccea3kFsAktQKsB0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761693535; c=relaxed/simple;
	bh=u/AsBCLPZSwSiuquTS8net/0yY0pN+chTJWc54dxxaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qo2CyU82K1LmcYU8vPXqCZoDKAUb8LL35rkpxT6MP72nJNnJjokSFdXHcDAfARtU+SVgazD3vDJQfS+sGSV09MK3TcLYgbo7Jfm0efHjAa/C6AVVzeNKcBpUx525qCv9aIGTQh0fYbjf/aONIIW+lTYjxEel+eZ9D1+nNeqF590=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=NjWsmEz8; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6EB3040E00DA;
	Tue, 28 Oct 2025 23:18:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dQdH0zrd16_O; Tue, 28 Oct 2025 23:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761693523; bh=2BcdfkUUlXVS7d00O3QKzdkOKKZIPIfnCTA0Aa8j80E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NjWsmEz8PJ8Jr3rS8dxM8+NBjEvOF///Hh29my4FmIORCNS807zec8qW7tSC+BUpU
	 otDkN69nqBrABlXCa3FZwaKG01afoeYXeOdUk5BsZJrM7C/jH5fglcgatBMEriD1t6
	 t+jVvSU3uOx9laHNt6LySE7kd0GN5aMhTAIi2Rp55pwMVTYPdEz/j1lT/2kLxxtylQ
	 3CGsywn+JQ3kf10Ua9y8Z8qYdvQIeF04yXdk5OyUUz5oYGcW7UZ4F5JcFtafw4dahZ
	 K3Vx3TFy2KlYuhcKC6UDR6JFvvCFL7+DTAqKgK/7p9S7lHKpje6DOM66NEay/SiNfS
	 qp8bs+r+DYi/gIyNJipJMuJfYsIFRrQG0I3mzgcMoaDEw0HZvcR7rmfMZ2lkUtmQs4
	 E0P16xzNOGVzJD4+UuselFIxZFOGwQS4f2yRT5/ncjkHjb3PRBxNHQm0bxIQBSP+Jg
	 SrV5lRWo9FAc+Ws8nOZJ4LIMNm/vgZumdFOHQaU9vpRGOO+BUnJhDqkScP2XA+YY6U
	 FoPnie84SEAud0zLJCzLmUFgjs/+gvQFcmRlC/vIa70k8T/rm8JMzRB1e8Vjiu3ghu
	 H2jIkmrvSGePt6GhM8z222oQ8+89FN3dBaOB/sP8V2u1Nn5exoePR8bPvH/bUOTV5X
	 QchI6x43+CCfqojLjnxUmyPU=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 4F13540E021A;
	Tue, 28 Oct 2025 23:18:31 +0000 (UTC)
Date: Wed, 29 Oct 2025 00:18:25 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Bert Karwatzki <spasswolf@web.de>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v7 2/8] x86/mce: Unify AMD DFR handler with MCA Polling
Message-ID: <20251028231825.GDaQFPQflC7gyVOwMa@fat_crate.local>
References: <20251024150333.GSaPuVRQYxH92zyrmO@fat_crate.local>
 <20251024203012.GA251815@yaz-khff2.amd.com>
 <20251024212723.GGaPvvO3l2OlUEG7Xn@fat_crate.local>
 <20251025150304.GXaPzmqFawI0NrCC-0@fat_crate.local>
 <20251027133542.GA8279@yaz-khff2.amd.com>
 <20251027141139.GA51741@yaz-khff2.amd.com>
 <20251028152231.GAaQDft32eXtTZBBzg@fat_crate.local>
 <20251028154258.GA526743@yaz-khff2.amd.com>
 <20251028174656.GBaQEBkOErfNAJbJsf@fat_crate.local>
 <20251028203719.GA655216@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251028203719.GA655216@yaz-khff2.amd.com>

On Tue, Oct 28, 2025 at 04:37:19PM -0400, Yazen Ghannam wrote:
> Yep, that's it. Much cleaner. :)

:-)

Final version:

From dd705221b2b3fb06fd2dc25dd51a8aaa1b1bd6d5 Mon Sep 17 00:00:00 2001
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Thu, 16 Oct 2025 16:37:48 +0000
Subject: [PATCH] x86/mce/amd: Enable interrupt vectors once per-CPU on SMCA
 systems

Scalable MCA systems have a per-CPU register that gives the APIC LVT offset
for the thresholding and deferred error interrupts.

Currently, this register is read once to set up the deferred error interrupt
and then read again for each thresholding block. Furthermore, the APIC LVT
registers are configured each time, but they only need to be configured once
per-CPU.

Move the APIC LVT setup to the early part of CPU init, so that the registers
are set up once. Also, this ensures that the kernel is ready to service the
interrupts before the individual error sources (each MCA bank) are enabled.

Apply this change only to SMCA systems to avoid breaking any legacy behavior.
The deferred error interrupt is technically advertised by the SUCCOR feature.
However, this was first made available on SMCA systems.  Therefore, only set
up the deferred error interrupt on SMCA systems and simplify the code.

Guidance from hardware designers is that the LVT offsets provided from the
platform should be used. The kernel should not try to enforce specific values.
However, the kernel should check that an LVT offset is not reused for multiple
sources.

Therefore, remove the extra checking and value enforcement from the MCE code.
The "reuse/conflict" case is already handled in setup_APIC_eilvt().

  [ bp: Simplify and drop some comments. ]

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/all/20251016-wip-mca-updates-v7-0-5c139a4062cb@amd.com
---
 arch/x86/kernel/cpu/mce/amd.c  | 121 +++++++++++++++------------------
 arch/x86/kernel/cpu/mce/core.c |  19 +-----
 2 files changed, 56 insertions(+), 84 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index d9f9ee7db5c8..0f4a01056ad3 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -43,9 +43,6 @@
 /* Deferred error settings */
 #define MSR_CU_DEF_ERR		0xC0000410
 #define MASK_DEF_LVTOFF		0x000000F0
-#define MASK_DEF_INT_TYPE	0x00000006
-#define DEF_LVT_OFF		0x2
-#define DEF_INT_TYPE_APIC	0x2
 
 /* Scalable MCA: */
 
@@ -57,6 +54,10 @@ static bool thresholding_irq_en;
 struct mce_amd_cpu_data {
 	mce_banks_t     thr_intr_banks;
 	mce_banks_t     dfr_intr_banks;
+
+	u32		thr_intr_en: 1,
+			dfr_intr_en: 1,
+			__resv: 30;
 };
 
 static DEFINE_PER_CPU_READ_MOSTLY(struct mce_amd_cpu_data, mce_amd_data);
@@ -271,6 +272,7 @@ void (*deferred_error_int_vector)(void) = default_deferred_error_interrupt;
 
 static void smca_configure(unsigned int bank, unsigned int cpu)
 {
+	struct mce_amd_cpu_data *data = this_cpu_ptr(&mce_amd_data);
 	u8 *bank_counts = this_cpu_ptr(smca_bank_counts);
 	const struct smca_hwid *s_hwid;
 	unsigned int i, hwid_mcatype;
@@ -301,8 +303,8 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
 		 * APIC based interrupt. First, check that no interrupt has been
 		 * set.
 		 */
-		if ((low & BIT(5)) && !((high >> 5) & 0x3)) {
-			__set_bit(bank, this_cpu_ptr(&mce_amd_data)->dfr_intr_banks);
+		if ((low & BIT(5)) && !((high >> 5) & 0x3) && data->dfr_intr_en) {
+			__set_bit(bank, data->dfr_intr_banks);
 			high |= BIT(5);
 		}
 
@@ -377,6 +379,14 @@ static bool lvt_off_valid(struct threshold_block *b, int apic, u32 lo, u32 hi)
 {
 	int msr = (hi & MASK_LVTOFF_HI) >> 20;
 
+	/*
+	 * On SMCA CPUs, LVT offset is programmed at a different MSR, and
+	 * the BIOS provides the value. The original field where LVT offset
+	 * was set is reserved. Return early here:
+	 */
+	if (mce_flags.smca)
+		return false;
+
 	if (apic < 0) {
 		pr_err(FW_BUG "cpu %d, failed to setup threshold interrupt "
 		       "for bank %d, block %d (MSR%08X=0x%x%08x)\n", b->cpu,
@@ -385,14 +395,6 @@ static bool lvt_off_valid(struct threshold_block *b, int apic, u32 lo, u32 hi)
 	}
 
 	if (apic != msr) {
-		/*
-		 * On SMCA CPUs, LVT offset is programmed at a different MSR, and
-		 * the BIOS provides the value. The original field where LVT offset
-		 * was set is reserved. Return early here:
-		 */
-		if (mce_flags.smca)
-			return false;
-
 		pr_err(FW_BUG "cpu %d, invalid threshold interrupt offset %d "
 		       "for bank %d, block %d (MSR%08X=0x%x%08x)\n",
 		       b->cpu, apic, b->bank, b->block, b->address, hi, lo);
@@ -473,41 +475,6 @@ static int setup_APIC_mce_threshold(int reserved, int new)
 	return reserved;
 }
 
-static int setup_APIC_deferred_error(int reserved, int new)
-{
-	if (reserved < 0 && !setup_APIC_eilvt(new, DEFERRED_ERROR_VECTOR,
-					      APIC_EILVT_MSG_FIX, 0))
-		return new;
-
-	return reserved;
-}
-
-static void deferred_error_interrupt_enable(struct cpuinfo_x86 *c)
-{
-	u32 low = 0, high = 0;
-	int def_offset = -1, def_new;
-
-	if (rdmsr_safe(MSR_CU_DEF_ERR, &low, &high))
-		return;
-
-	def_new = (low & MASK_DEF_LVTOFF) >> 4;
-	if (!(low & MASK_DEF_LVTOFF)) {
-		pr_err(FW_BUG "Your BIOS is not setting up LVT offset 0x2 for deferred error IRQs correctly.\n");
-		def_new = DEF_LVT_OFF;
-		low = (low & ~MASK_DEF_LVTOFF) | (DEF_LVT_OFF << 4);
-	}
-
-	def_offset = setup_APIC_deferred_error(def_offset, def_new);
-	if ((def_offset == def_new) &&
-	    (deferred_error_int_vector != amd_deferred_error_interrupt))
-		deferred_error_int_vector = amd_deferred_error_interrupt;
-
-	if (!mce_flags.smca)
-		low = (low & ~MASK_DEF_INT_TYPE) | DEF_INT_TYPE_APIC;
-
-	wrmsr(MSR_CU_DEF_ERR, low, high);
-}
-
 static u32 get_block_address(u32 current_addr, u32 low, u32 high,
 			     unsigned int bank, unsigned int block,
 			     unsigned int cpu)
@@ -543,12 +510,10 @@ static u32 get_block_address(u32 current_addr, u32 low, u32 high,
 	return addr;
 }
 
-static int
-prepare_threshold_block(unsigned int bank, unsigned int block, u32 addr,
-			int offset, u32 misc_high)
+static int prepare_threshold_block(unsigned int bank, unsigned int block, u32 addr,
+				   int offset, u32 misc_high)
 {
 	unsigned int cpu = smp_processor_id();
-	u32 smca_low, smca_high;
 	struct threshold_block b;
 	int new;
 
@@ -568,18 +533,10 @@ prepare_threshold_block(unsigned int bank, unsigned int block, u32 addr,
 	__set_bit(bank, this_cpu_ptr(&mce_amd_data)->thr_intr_banks);
 	b.interrupt_enable = 1;
 
-	if (!mce_flags.smca) {
-		new = (misc_high & MASK_LVTOFF_HI) >> 20;
-		goto set_offset;
-	}
-
-	/* Gather LVT offset for thresholding: */
-	if (rdmsr_safe(MSR_CU_DEF_ERR, &smca_low, &smca_high))
-		goto out;
-
-	new = (smca_low & SMCA_THR_LVT_OFF) >> 12;
+	if (mce_flags.smca)
+		goto done;
 
-set_offset:
+	new = (misc_high & MASK_LVTOFF_HI) >> 20;
 	offset = setup_APIC_mce_threshold(offset, new);
 	if (offset == new)
 		thresholding_irq_en = true;
@@ -587,7 +544,6 @@ prepare_threshold_block(unsigned int bank, unsigned int block, u32 addr,
 done:
 	mce_threshold_block_init(&b, offset);
 
-out:
 	return offset;
 }
 
@@ -678,6 +634,32 @@ static void amd_apply_cpu_quirks(struct cpuinfo_x86 *c)
 		mce_banks[0].ctl = 0;
 }
 
+/*
+ * Enable the APIC LVT interrupt vectors once per-CPU. This should be done
+ * before hardware is ready to send interrupts.
+ *
+ * Individual error sources are enabled later during per-bank init.
+ */
+static void smca_enable_interrupt_vectors(void)
+{
+	struct mce_amd_cpu_data *data = this_cpu_ptr(&mce_amd_data);
+	u64 mca_intr_cfg, offset;
+
+	if (!mce_flags.smca || !mce_flags.succor)
+		return;
+
+	if (rdmsrq_safe(MSR_CU_DEF_ERR, &mca_intr_cfg))
+		return;
+
+	offset = (mca_intr_cfg & SMCA_THR_LVT_OFF) >> 12;
+	if (!setup_APIC_eilvt(offset, THRESHOLD_APIC_VECTOR, APIC_EILVT_MSG_FIX, 0))
+		data->thr_intr_en = 1;
+
+	offset = (mca_intr_cfg & MASK_DEF_LVTOFF) >> 4;
+	if (!setup_APIC_eilvt(offset, DEFERRED_ERROR_VECTOR, APIC_EILVT_MSG_FIX, 0))
+		data->dfr_intr_en = 1;
+}
+
 /* cpu init entry point, called from mce.c with preempt off */
 void mce_amd_feature_init(struct cpuinfo_x86 *c)
 {
@@ -689,10 +671,16 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 
 	mce_flags.amd_threshold	 = 1;
 
+	smca_enable_interrupt_vectors();
+
 	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
-		if (mce_flags.smca)
+		if (mce_flags.smca) {
 			smca_configure(bank, cpu);
 
+			if (!this_cpu_ptr(&mce_amd_data)->thr_intr_en)
+				continue;
+		}
+
 		disable_err_thresholding(c, bank);
 
 		for (block = 0; block < NR_BLOCKS; ++block) {
@@ -713,9 +701,6 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 			offset = prepare_threshold_block(bank, block, address, offset, high);
 		}
 	}
-
-	if (mce_flags.succor)
-		deferred_error_interrupt_enable(c);
 }
 
 void smca_bsp_init(void)
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 7be062429ce3..4aff14e04287 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -726,24 +726,11 @@ DEFINE_PER_CPU(unsigned, mce_poll_count);
  * 3) SMCA systems check MCA_DESTAT, if error was not found in MCA_STATUS, and
  *    log it.
  */
-static bool smca_should_log_poll_error(enum mcp_flags flags, struct mce_hw_err *err)
+static bool smca_should_log_poll_error(struct mce *m)
 {
-	struct mce *m = &err->m;
-
-	/*
-	 * If the MCA_STATUS register has a deferred error, then continue using it as
-	 * the status register.
-	 *
-	 * MCA_DESTAT will be cleared at the end of the handler.
-	 */
-	if ((m->status & MCI_STATUS_VAL) && (m->status & MCI_STATUS_DEFERRED))
+	if (m->status & MCI_STATUS_VAL)
 		return true;
 
-	/*
-	 * If the MCA_DESTAT register has a deferred error, then use it instead.
-	 *
-	 * MCA_STATUS will not be cleared at the end of the handler.
-	 */
 	m->status = mce_rdmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank));
 	if ((m->status & MCI_STATUS_VAL) && (m->status & MCI_STATUS_DEFERRED)) {
 		m->kflags |= MCE_CHECK_DFR_REGS;
@@ -780,7 +767,7 @@ static bool should_log_poll_error(enum mcp_flags flags, struct mce_hw_err *err)
 	struct mce *m = &err->m;
 
 	if (mce_flags.smca)
-		return smca_should_log_poll_error(flags, err);
+		return smca_should_log_poll_error(m);
 
 	/* If this entry is not valid, ignore it. */
 	if (!(m->status & MCI_STATUS_VAL))
-- 
2.51.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

