Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9F275A5E4
	for <lists+linux-edac@lfdr.de>; Thu, 20 Jul 2023 07:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjGTFt0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 20 Jul 2023 01:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjGTFt0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 20 Jul 2023 01:49:26 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495FA171B
        for <linux-edac@vger.kernel.org>; Wed, 19 Jul 2023 22:49:24 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D4F561EC0A91;
        Thu, 20 Jul 2023 07:49:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1689832162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/pte+ackR+Ax7idRUSrfcHMjDXUqcyRY8yBODT3njEk=;
        b=HTSnfIUPpV1Lm8lbzZGIkm618p1Fb85Wh28oXYTIzD+RQ/xNN6HgWlH12UZTIyO7mG6s0m
        bYdVB7H47cgaks5YwpCf30PJTEYd0HhsQR+0SxiTxpV8R+910n/Lc+dQvuh66AeZEv2s7f
        5+qyHjkDu9ZjPCKj3+Pm0gZgKFy6JCE=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hQmiggtoRu6C; Thu, 20 Jul 2023 05:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1689832158; bh=/pte+ackR+Ax7idRUSrfcHMjDXUqcyRY8yBODT3njEk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FTTLN4hJmGTjOPZEi831gg03IvtaGP9DFSq42iiJSHVmojcahKFqEEm5fufU0iXMo
         0d71YzkLEg2UtT23s/uRMN0zd/JhGl1hUiYdFYJuo9yiGNL42xorsG74EdKbrixbLh
         rJlAUMKj/MoawiObjRfhtD2QhwL2Wc0iN7G2Q/pxbEmhPfBffhlMqeFZfIm0iMWyQg
         1ivTug+/4IuhcQUOpF6GdPdpCcg2/xF+XiTKm1485L/qZP4X3LlXeStI7m1OSdbwKl
         cs4pX9v34VOXg1w4g8Yo/jMLIET6uW8V1nxNE7EC51JYiuoi6lihkROCvjPPdOnv8g
         Gmp9ybe+EGTmV7tgnUQHk18xSDNAyS/DfHz8PU0wBhyeaTENthR422oX67D736JQXB
         X4zlDmfFVPCFjKxg+0cGJ/uGm8YksTrl1x8AY4gwkN59rlxVBSz4PsdVr6Z/9soP+a
         la84BYtm3j+1x7pdqUeZofX1e/TmWJuJ7dxz7IyJazL731NT8yLxN+dqQJzRCQ/p+3
         /Du77rrysi5QjC7kJFxQo5PkdzMd2ohv1HonB8siQU0ZVklR4ZLyz0uZ1SSgm/JnTh
         +DKlSrxvMR819zbWZ80EyHUmGiPBZDaZuxLyxM8+x/+l9sQHYZHKFC/YsfW8UDidWK
         ZH8xUj14x0w9lwqhraUgQoi4=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4A8B340E0185;
        Thu, 20 Jul 2023 05:49:14 +0000 (UTC)
Date:   Thu, 20 Jul 2023 07:49:08 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Aristeu Rozanski <aris@ruivo.org>
Cc:     Tony Luck <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "aris@redhat.com" <aris@redhat.com>
Subject: [PATCH] x86/mce: Prevent duplicate error records
Message-ID: <20230720054908.GAZLjK1CSIrioNSI/f@fat_crate.local>
References: <20230717152317.GA94963@cathedrallabs.org>
 <20230719092619.GJZLesOyHrL8JQyDZN@fat_crate.local>
 <20230719180723.GB94963@cathedrallabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230719180723.GB94963@cathedrallabs.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Wed, 19 Jul 2023 14:19:50 +0200

A legitimate use case of the MCA infrastructure is to have the firmware
log all uncorrectable errors and also, have the OS see all correctable
errors.

The uncorrectable, UCNA errors are usually configured to be reported
through an SMI. CMCI, which is the correctable error reporting
interrupt, uses SMI too and having both enabled, leads to unnecessary
overhead.

So what ends up happening is, people disable CMCI in the wild and leave
on only the UCNA SMI.

When CMCI is disabled, the MCA infrastructure resorts to polling the MCA
banks. If a MCA MSR is shared between the logical threads, one error
ends up getting logged multiple times as the polling runs on every
logical thread.

Therefore, introduce locking on the Intel side of the polling routine to
prevent such duplicate error records from appearing.

Based on a patch by Aristeu Rozanski <aris@ruivo.org>.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/r/20230515143225.GC4090740@cathedrallabs.org
---
 arch/x86/kernel/cpu/mce/core.c     |  9 ++++++++-
 arch/x86/kernel/cpu/mce/intel.c    | 19 ++++++++++++++++++-
 arch/x86/kernel/cpu/mce/internal.h |  1 +
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 89e2aab5d34d..b8ad5a5b4026 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1608,6 +1608,13 @@ static void __start_timer(struct timer_list *t, unsigned long interval)
 	local_irq_restore(flags);
 }
 
+static void mc_poll_banks_default(void)
+{
+	machine_check_poll(0, this_cpu_ptr(&mce_poll_banks));
+}
+
+void (*mc_poll_banks)(void) = mc_poll_banks_default;
+
 static void mce_timer_fn(struct timer_list *t)
 {
 	struct timer_list *cpu_t = this_cpu_ptr(&mce_timer);
@@ -1618,7 +1625,7 @@ static void mce_timer_fn(struct timer_list *t)
 	iv = __this_cpu_read(mce_next_interval);
 
 	if (mce_available(this_cpu_ptr(&cpu_info))) {
-		machine_check_poll(0, this_cpu_ptr(&mce_poll_banks));
+		mc_poll_banks();
 
 		if (mce_intel_cmci_poll()) {
 			iv = mce_adjust_timer(iv);
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index 95275a5e57e0..f5323551c1a9 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -56,6 +56,13 @@ static DEFINE_PER_CPU(int, cmci_backoff_cnt);
  */
 static DEFINE_RAW_SPINLOCK(cmci_discover_lock);
 
+/*
+ * On systems that do support CMCI but it's disabled, polling for MCEs can
+ * cause the same event to be reported multiple times because IA32_MCi_STATUS
+ * is shared by the same package.
+ */
+static DEFINE_SPINLOCK(cmci_poll_lock);
+
 #define CMCI_THRESHOLD		1
 #define CMCI_POLL_INTERVAL	(30 * HZ)
 #define CMCI_STORM_INTERVAL	(HZ)
@@ -426,12 +433,22 @@ void cmci_disable_bank(int bank)
 	raw_spin_unlock_irqrestore(&cmci_discover_lock, flags);
 }
 
+/* Bank polling function when CMCI is disabled. */
+static void cmci_mc_poll_banks(void)
+{
+	spin_lock(&cmci_poll_lock);
+	machine_check_poll(0, this_cpu_ptr(&mce_poll_banks));
+	spin_unlock(&cmci_poll_lock);
+}
+
 void intel_init_cmci(void)
 {
 	int banks;
 
-	if (!cmci_supported(&banks))
+	if (!cmci_supported(&banks)) {
+		mc_poll_banks = cmci_mc_poll_banks;
 		return;
+	}
 
 	mce_threshold_vector = intel_threshold_interrupt;
 	cmci_discover(banks);
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index d2412ce2d312..ed4a71c0f093 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -274,4 +274,5 @@ static __always_inline u32 mca_msr_reg(int bank, enum mca_msr reg)
 	return 0;
 }
 
+extern void (*mc_poll_banks)(void);
 #endif /* __X86_MCE_INTERNAL_H__ */
-- 
2.41.0


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
