Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D3D4FFB13
	for <lists+linux-edac@lfdr.de>; Wed, 13 Apr 2022 18:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236491AbiDMQVk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 13 Apr 2022 12:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234365AbiDMQVj (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 13 Apr 2022 12:21:39 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4090FD4C;
        Wed, 13 Apr 2022 09:19:17 -0700 (PDT)
Received: from zn.tnic (p2e55d808.dip0.t-ipconnect.de [46.85.216.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B788D1EC059D;
        Wed, 13 Apr 2022 18:19:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649866751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=difRPq0m2HqVyMy5NVNSyrXcy6+3vIY5KlKnjoap02o=;
        b=eL+prnBPX3EmDj1z1JrOiZWChrcuBYyRQelPz+2Ios6pos/tCsx+fl86Tlgju97j4LJIl9
        b/ay9QBK6aRNT+cH3thi4ypNfR4K8zn8hvtVQYNWEHdlqNz6o4SO5XuXoNitoesqcpVppl
        rzoO2jpcH9fuYM0HdnxYdZbXQEGghQU=
Date:   Wed, 13 Apr 2022 18:19:11 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, hpa@zytor.com,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v5 2/2] x86/mce: Add support for Extended Physical
 Address MCA changes
Message-ID: <Ylb3/4oi6KAjdsJW@zn.tnic>
References: <20220412154038.261750-1-Smita.KoralahalliChannabasappa@amd.com>
 <20220412154038.261750-3-Smita.KoralahalliChannabasappa@amd.com>
 <YlakNe012hhErszh@zn.tnic>
 <YlbZ1k1cT1FVJj4W@yaz-ubuntu>
 <YlbkCK9LU2KdXZUG@zn.tnic>
 <YlbzbZO6AvxOqQb/@agluck-desk3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YlbzbZO6AvxOqQb/@agluck-desk3.sc.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Apr 13, 2022 at 08:59:41AM -0700, Luck, Tony wrote:
> If MCP_DONTLOG bit is set, then this does little. It will find
> banks with valid records, NOT log them, clear them. But then we
> loop and clear all banks.
> 
> So maybe do:
> 
> 	if (mca_cfg.bootlog) {
> 		bitmap_fill(all_banks, MAX_NR_BANKS);
> 		machine_check_poll(MCP_UC | MCP_QUEUE_LOG, &all_banks);
> 	}

Ack, thx.

> This will a new name to indicate that it is logging as well as init & clear.

Ok.

> Otherwise seeems fine.

Thanks, here it is (untested yet).

---
From: Borislav Petkov <bp@suse.de>
Date: Wed, 13 Apr 2022 18:11:01 +0200
Subject: [PATCH] x86/mce: Cleanup bank processing on init

Unify the bank preparation into __mcheck_cpu_init_clear_banks(), rename
that function to what it does now - prepares banks. Do this so that
generic and vendor banks init goes first so that settings done during
that init can take effect before the first bank polling takes place.

Move __mcheck_cpu_check_banks() into __mcheck_cpu_init_prepare_banks()
as it already loops over the banks.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/mce.h     |  3 +-
 arch/x86/kernel/cpu/mce/core.c | 64 ++++++++++------------------------
 2 files changed, 19 insertions(+), 48 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index cc73061e7255..5450df861ec5 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -252,8 +252,7 @@ DECLARE_PER_CPU(mce_banks_t, mce_poll_banks);
 enum mcp_flags {
 	MCP_TIMESTAMP	= BIT(0),	/* log time stamp */
 	MCP_UC		= BIT(1),	/* log uncorrected errors */
-	MCP_DONTLOG	= BIT(2),	/* only clear, don't log */
-	MCP_QUEUE_LOG	= BIT(3),	/* only queue to genpool */
+	MCP_QUEUE_LOG	= BIT(2),	/* only queue to genpool */
 };
 bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b);
 
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 99e3ff9607a3..6e49dda09a2a 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -724,9 +724,6 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 log_it:
 		error_seen = true;
 
-		if (flags & MCP_DONTLOG)
-			goto clear_it;
-
 		mce_read_aux(&m, i);
 		m.severity = mce_severity(&m, NULL, NULL, false);
 		/*
@@ -1693,7 +1690,7 @@ static void __mcheck_cpu_mce_banks_init(void)
 		/*
 		 * Init them all, __mcheck_cpu_apply_quirks() is going to apply
 		 * the required vendor quirks before
-		 * __mcheck_cpu_init_clear_banks() does the final bank setup.
+		 * __mcheck_cpu_init_prepare_banks() does the final bank setup.
 		 */
 		b->ctl = -1ULL;
 		b->init = true;
@@ -1732,21 +1729,8 @@ static void __mcheck_cpu_cap_init(void)
 
 static void __mcheck_cpu_init_generic(void)
 {
-	enum mcp_flags m_fl = 0;
-	mce_banks_t all_banks;
 	u64 cap;
 
-	if (!mca_cfg.bootlog)
-		m_fl = MCP_DONTLOG;
-
-	/*
-	 * Log the machine checks left over from the previous reset. Log them
-	 * only, do not start processing them. That will happen in mcheck_late_init()
-	 * when all consumers have been registered on the notifier chain.
-	 */
-	bitmap_fill(all_banks, MAX_NR_BANKS);
-	machine_check_poll(MCP_UC | MCP_QUEUE_LOG | m_fl, &all_banks);
-
 	cr4_set_bits(X86_CR4_MCE);
 
 	rdmsrl(MSR_IA32_MCG_CAP, cap);
@@ -1754,36 +1738,22 @@ static void __mcheck_cpu_init_generic(void)
 		wrmsr(MSR_IA32_MCG_CTL, 0xffffffff, 0xffffffff);
 }
 
-static void __mcheck_cpu_init_clear_banks(void)
+static void __mcheck_cpu_init_prepare_banks(void)
 {
 	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
+	mce_banks_t all_banks;
+	u64 msrval;
 	int i;
 
-	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
-		struct mce_bank *b = &mce_banks[i];
-
-		if (!b->init)
-			continue;
-		wrmsrl(mca_msr_reg(i, MCA_CTL), b->ctl);
-		wrmsrl(mca_msr_reg(i, MCA_STATUS), 0);
+	/*
+	 * Log the machine checks left over from the previous reset. Log them
+	 * only, do not start processing them. That will happen in mcheck_late_init()
+	 * when all consumers have been registered on the notifier chain.
+	 */
+	if (mca_cfg.bootlog) {
+		bitmap_fill(all_banks, MAX_NR_BANKS);
+		machine_check_poll(MCP_UC | MCP_QUEUE_LOG, &all_banks);
 	}
-}
-
-/*
- * Do a final check to see if there are any unused/RAZ banks.
- *
- * This must be done after the banks have been initialized and any quirks have
- * been applied.
- *
- * Do not call this from any user-initiated flows, e.g. CPU hotplug or sysfs.
- * Otherwise, a user who disables a bank will not be able to re-enable it
- * without a system reboot.
- */
-static void __mcheck_cpu_check_banks(void)
-{
-	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
-	u64 msrval;
-	int i;
 
 	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
 		struct mce_bank *b = &mce_banks[i];
@@ -1791,6 +1761,9 @@ static void __mcheck_cpu_check_banks(void)
 		if (!b->init)
 			continue;
 
+		wrmsrl(mca_msr_reg(i, MCA_CTL), b->ctl);
+		wrmsrl(mca_msr_reg(i, MCA_STATUS), 0);
+
 		rdmsrl(mca_msr_reg(i, MCA_CTL), msrval);
 		b->init = !!msrval;
 	}
@@ -2158,8 +2131,7 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c)
 	__mcheck_cpu_init_early(c);
 	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_vendor(c);
-	__mcheck_cpu_init_clear_banks();
-	__mcheck_cpu_check_banks();
+	__mcheck_cpu_init_prepare_banks();
 	__mcheck_cpu_setup_timer();
 }
 
@@ -2327,7 +2299,7 @@ static void mce_syscore_resume(void)
 {
 	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_vendor(raw_cpu_ptr(&cpu_info));
-	__mcheck_cpu_init_clear_banks();
+	__mcheck_cpu_init_prepare_banks();
 }
 
 static struct syscore_ops mce_syscore_ops = {
@@ -2345,7 +2317,7 @@ static void mce_cpu_restart(void *data)
 	if (!mce_available(raw_cpu_ptr(&cpu_info)))
 		return;
 	__mcheck_cpu_init_generic();
-	__mcheck_cpu_init_clear_banks();
+	__mcheck_cpu_init_prepare_banks();
 	__mcheck_cpu_init_timer();
 }
 
-- 
2.35.1

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
