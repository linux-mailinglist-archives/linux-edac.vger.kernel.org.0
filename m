Return-Path: <linux-edac+bounces-5194-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED92C0926E
	for <lists+linux-edac@lfdr.de>; Sat, 25 Oct 2025 17:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC8561C20E30
	for <lists+linux-edac@lfdr.de>; Sat, 25 Oct 2025 15:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06153009E2;
	Sat, 25 Oct 2025 15:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ii82CEJR"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE5E3019DA;
	Sat, 25 Oct 2025 15:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761404612; cv=none; b=JszAJm/W2aAuZv6oKAeQ+6DbCpqJ8GiHAaKjXQxOUW9cnqmls+wsn+sSagrZ9hqnBckO/ap2gZyZm9uRowp1m7c5fEN7Prx3lWEHiucxeWHKz9xoXXt14VxMuoKNSyuooYpKV2C4qNYTVRIi5/oDorxpzM4uOW0D3fM8tit4Tl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761404612; c=relaxed/simple;
	bh=BkmuO16h4mmUA1yuwJLb1GsQSmrpODIBX6fKyc5zkCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMM2OIKsXMG5TcDeZNvj/gC/FXZj/rq93BB88LhaiICZ3ttM6k+ov0IvFkc0Sy9vlPNqxPF4wPUBI3Amk+gVysNN9f8NFa2omvWGyHU8HE8/HHA5k1o+XppeUKhYWPZdio0VqxteCH9BSsk2zhgP7rimhewb/1HMuyPZuzHsN7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ii82CEJR; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2FB8640E019F;
	Sat, 25 Oct 2025 15:03:27 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id LAmeftlVqX9D; Sat, 25 Oct 2025 15:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761404602; bh=nCSgOU7dM4yjzLP0h/Updbog8vAhppuSiCCOin6HIpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ii82CEJRRaYuL74C99DQdELj96yqtGFin5opC/b6OtA90rbMWGTQRfauocDES1lHW
	 WsVZKrt4GHgyWpJ/z4FwUnQB60zVlTdmgAadc0fZZf66WS4uqLayXJgFerm5FMK+wI
	 D0ermsAq1V8RLBMTC3CR8JXVmjvpuYBRvRC5DBH6EgkyRQ5FDn3tD601xq3QIhwFev
	 Hg4rPpMWBJ3SCYJs8IOR4rlJVUEc1PNmMkoRMIz6xVxSWYz67iR6XJXjqKUNwXUQiG
	 /t6ooNMNdw2hBmH1Rlytf7ffQHIScwvxhHpG2/s3Qn4j7Q1sq/qTCPeDeuwyuGyRVh
	 zGZQfl8qRekJDZE5g5RNE9YLEjZYIQJL/tXNsufayrxPEbYQL/WrQ7LC4wcs57HP/X
	 5Za/TBrXkjeCHBRKXRm1J1j4RP2QE9DF/U3asuhQ1bPg3x/4TfDiAhzVlvS7kIqtxq
	 sbfCnVPjp/k7TldLrmyLyD1Mf4kFZwjcfmS7wvOx+8vcG3xVl+580Oh6WcQmdJAIsC
	 LbHbMsnSekq27Fj9bziByqicjHyKzTbsGq9X+pI3+zcKKa0zNVeNwf/2lJ1+bG4BhP
	 j7o0bCYUi6e1te7/DowQjsbPnnCaWyThxMayt/BDWi6l7RDpwltCwU/MO4+F5ZP8ow
	 0+lZ+1CNhkkW7oy23KZcbLhc=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 565A840E019B;
	Sat, 25 Oct 2025 15:03:10 +0000 (UTC)
Date: Sat, 25 Oct 2025 17:03:04 +0200
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
Message-ID: <20251025150304.GXaPzmqFawI0NrCC-0@fat_crate.local>
References: <20251016-wip-mca-updates-v7-0-5c139a4062cb@amd.com>
 <20251016-wip-mca-updates-v7-2-5c139a4062cb@amd.com>
 <20251024150333.GSaPuVRQYxH92zyrmO@fat_crate.local>
 <20251024203012.GA251815@yaz-khff2.amd.com>
 <20251024212723.GGaPvvO3l2OlUEG7Xn@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251024212723.GGaPvvO3l2OlUEG7Xn@fat_crate.local>

On Fri, Oct 24, 2025 at 11:27:23PM +0200, Borislav Petkov wrote:
> On Fri, Oct 24, 2025 at 04:30:12PM -0400, Yazen Ghannam wrote:
> > Should I send another revision?
> 
> Nah, I'm not done simplifying this yet. :-P

Yeah, no, looks ok now:

---
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Thu, 16 Oct 2025 16:37:47 +0000
Subject: [PATCH] x86/mce: Unify AMD DFR handler with MCA Polling

AMD systems optionally support a deferred error interrupt. The interrupt
should be used as another signal to trigger MCA polling. This is similar to
how other MCA interrupts are handled.

Deferred errors do not require any special handling related to the interrupt,
e.g. resetting or rearming the interrupt, etc.

However, Scalable MCA systems include a pair of registers, MCA_DESTAT and
MCA_DEADDR, that should be checked for valid errors. This check should be done
whenever MCA registers are polled. Currently, the deferred error interrupt
does this check, but the MCA polling function does not.

Call the MCA polling function when handling the deferred error interrupt. This
keeps all "polling" cases in a common function.

Add an SMCA status check helper. This will do the same status check and
register clearing that the interrupt handler has done. And it extends the
common polling flow to find AMD deferred errors.

Clear the MCA_DESTAT register at the end of the handler rather than the
beginning. This maintains the procedure that the 'status' register must be
cleared as the final step.

  [ bp: Zap commit message pieces explaining what the patch does;
        zap unnecessary special-casing of deferred errors. ]

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/all/20251016-wip-mca-updates-v7-0-5c139a4062cb@amd.com
---
 arch/x86/include/asm/mce.h     |   6 ++
 arch/x86/kernel/cpu/mce/amd.c  | 111 ++++-----------------------------
 arch/x86/kernel/cpu/mce/core.c |  44 ++++++++++++-
 3 files changed, 62 insertions(+), 99 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 31e3cb550fb3..7d6588195d56 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -165,6 +165,12 @@
  */
 #define MCE_IN_KERNEL_COPYIN	BIT_ULL(7)
 
+/*
+ * Indicates that handler should check and clear Deferred error registers
+ * rather than common ones.
+ */
+#define MCE_CHECK_DFR_REGS	BIT_ULL(8)
+
 /*
  * This structure contains all data related to the MCE log.  Also
  * carries a signature to make it easier to find from external
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index ac6a98aa7bc2..d9f9ee7db5c8 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -56,6 +56,7 @@ static bool thresholding_irq_en;
 
 struct mce_amd_cpu_data {
 	mce_banks_t     thr_intr_banks;
+	mce_banks_t     dfr_intr_banks;
 };
 
 static DEFINE_PER_CPU_READ_MOSTLY(struct mce_amd_cpu_data, mce_amd_data);
@@ -300,8 +301,10 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
 		 * APIC based interrupt. First, check that no interrupt has been
 		 * set.
 		 */
-		if ((low & BIT(5)) && !((high >> 5) & 0x3))
+		if ((low & BIT(5)) && !((high >> 5) & 0x3)) {
+			__set_bit(bank, this_cpu_ptr(&mce_amd_data)->dfr_intr_banks);
 			high |= BIT(5);
+		}
 
 		this_cpu_ptr(mce_banks_array)[bank].lsb_in_status = !!(low & BIT(8));
 
@@ -792,37 +795,6 @@ bool amd_mce_usable_address(struct mce *m)
 	return false;
 }
 
-static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
-{
-	struct mce_hw_err err;
-	struct mce *m = &err.m;
-
-	mce_prep_record(&err);
-
-	m->status = status;
-	m->misc   = misc;
-	m->bank   = bank;
-	m->tsc	 = rdtsc();
-
-	if (m->status & MCI_STATUS_ADDRV) {
-		m->addr = addr;
-
-		smca_extract_err_addr(m);
-	}
-
-	if (mce_flags.smca) {
-		rdmsrq(MSR_AMD64_SMCA_MCx_IPID(bank), m->ipid);
-
-		if (m->status & MCI_STATUS_SYNDV) {
-			rdmsrq(MSR_AMD64_SMCA_MCx_SYND(bank), m->synd);
-			rdmsrq(MSR_AMD64_SMCA_MCx_SYND1(bank), err.vendor.amd.synd1);
-			rdmsrq(MSR_AMD64_SMCA_MCx_SYND2(bank), err.vendor.amd.synd2);
-		}
-	}
-
-	mce_log(&err);
-}
-
 DEFINE_IDTENTRY_SYSVEC(sysvec_deferred_error)
 {
 	trace_deferred_error_apic_entry(DEFERRED_ERROR_VECTOR);
@@ -832,75 +804,10 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_deferred_error)
 	apic_eoi();
 }
 
-/*
- * Returns true if the logged error is deferred. False, otherwise.
- */
-static inline bool
-_log_error_bank(unsigned int bank, u32 msr_stat, u32 msr_addr, u64 misc)
-{
-	u64 status, addr = 0;
-
-	rdmsrq(msr_stat, status);
-	if (!(status & MCI_STATUS_VAL))
-		return false;
-
-	if (status & MCI_STATUS_ADDRV)
-		rdmsrq(msr_addr, addr);
-
-	__log_error(bank, status, addr, misc);
-
-	wrmsrq(msr_stat, 0);
-
-	return status & MCI_STATUS_DEFERRED;
-}
-
-static bool _log_error_deferred(unsigned int bank, u32 misc)
-{
-	if (!_log_error_bank(bank, mca_msr_reg(bank, MCA_STATUS),
-			     mca_msr_reg(bank, MCA_ADDR), misc))
-		return false;
-
-	/*
-	 * Non-SMCA systems don't have MCA_DESTAT/MCA_DEADDR registers.
-	 * Return true here to avoid accessing these registers.
-	 */
-	if (!mce_flags.smca)
-		return true;
-
-	/* Clear MCA_DESTAT if the deferred error was logged from MCA_STATUS. */
-	wrmsrq(MSR_AMD64_SMCA_MCx_DESTAT(bank), 0);
-	return true;
-}
-
-/*
- * We have three scenarios for checking for Deferred errors:
- *
- * 1) Non-SMCA systems check MCA_STATUS and log error if found.
- * 2) SMCA systems check MCA_STATUS. If error is found then log it and also
- *    clear MCA_DESTAT.
- * 3) SMCA systems check MCA_DESTAT, if error was not found in MCA_STATUS, and
- *    log it.
- */
-static void log_error_deferred(unsigned int bank)
-{
-	if (_log_error_deferred(bank, 0))
-		return;
-
-	/*
-	 * Only deferred errors are logged in MCA_DE{STAT,ADDR} so just check
-	 * for a valid error.
-	 */
-	_log_error_bank(bank, MSR_AMD64_SMCA_MCx_DESTAT(bank),
-			      MSR_AMD64_SMCA_MCx_DEADDR(bank), 0);
-}
-
 /* APIC interrupt handler for deferred errors */
 static void amd_deferred_error_interrupt(void)
 {
-	unsigned int bank;
-
-	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank)
-		log_error_deferred(bank);
+	machine_check_poll(MCP_TIMESTAMP, &this_cpu_ptr(&mce_amd_data)->dfr_intr_banks);
 }
 
 static void reset_block(struct threshold_block *block)
@@ -952,6 +859,14 @@ void amd_clear_bank(struct mce *m)
 {
 	amd_reset_thr_limit(m->bank);
 
+	/* Clear MCA_DESTAT for all deferred errors even those logged in MCA_STATUS. */
+	if (m->status & MCI_STATUS_DEFERRED)
+		mce_wrmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank), 0);
+
+	/* Don't clear MCA_STATUS if MCA_DESTAT was used exclusively. */
+	if (m->kflags & MCE_CHECK_DFR_REGS)
+		return;
+
 	mce_wrmsrq(mca_msr_reg(m->bank, MCA_STATUS), 0);
 }
 
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 460e90a1a0b1..7be062429ce3 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -687,7 +687,10 @@ static noinstr void mce_read_aux(struct mce_hw_err *err, int i)
 		m->misc = mce_rdmsrq(mca_msr_reg(i, MCA_MISC));
 
 	if (m->status & MCI_STATUS_ADDRV) {
-		m->addr = mce_rdmsrq(mca_msr_reg(i, MCA_ADDR));
+		if (m->kflags & MCE_CHECK_DFR_REGS)
+			m->addr = mce_rdmsrq(MSR_AMD64_SMCA_MCx_DEADDR(i));
+		else
+			m->addr = mce_rdmsrq(mca_msr_reg(i, MCA_ADDR));
 
 		/*
 		 * Mask the reported address by the reported granularity.
@@ -714,6 +717,42 @@ static noinstr void mce_read_aux(struct mce_hw_err *err, int i)
 
 DEFINE_PER_CPU(unsigned, mce_poll_count);
 
+/*
+ * We have three scenarios for checking for Deferred errors:
+ *
+ * 1) Non-SMCA systems check MCA_STATUS and log error if found.
+ * 2) SMCA systems check MCA_STATUS. If error is found then log it and also
+ *    clear MCA_DESTAT.
+ * 3) SMCA systems check MCA_DESTAT, if error was not found in MCA_STATUS, and
+ *    log it.
+ */
+static bool smca_should_log_poll_error(enum mcp_flags flags, struct mce_hw_err *err)
+{
+	struct mce *m = &err->m;
+
+	/*
+	 * If the MCA_STATUS register has a deferred error, then continue using it as
+	 * the status register.
+	 *
+	 * MCA_DESTAT will be cleared at the end of the handler.
+	 */
+	if ((m->status & MCI_STATUS_VAL) && (m->status & MCI_STATUS_DEFERRED))
+		return true;
+
+	/*
+	 * If the MCA_DESTAT register has a deferred error, then use it instead.
+	 *
+	 * MCA_STATUS will not be cleared at the end of the handler.
+	 */
+	m->status = mce_rdmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank));
+	if ((m->status & MCI_STATUS_VAL) && (m->status & MCI_STATUS_DEFERRED)) {
+		m->kflags |= MCE_CHECK_DFR_REGS;
+		return true;
+	}
+
+	return false;
+}
+
 /*
  * Newer Intel systems that support software error
  * recovery need to make additional checks. Other
@@ -740,6 +779,9 @@ static bool should_log_poll_error(enum mcp_flags flags, struct mce_hw_err *err)
 {
 	struct mce *m = &err->m;
 
+	if (mce_flags.smca)
+		return smca_should_log_poll_error(flags, err);
+
 	/* If this entry is not valid, ignore it. */
 	if (!(m->status & MCI_STATUS_VAL))
 		return false;
-- 
2.51.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

