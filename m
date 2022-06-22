Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DBA555266
	for <lists+linux-edac@lfdr.de>; Wed, 22 Jun 2022 19:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376643AbiFVR3P (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 22 Jun 2022 13:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239201AbiFVR3P (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 22 Jun 2022 13:29:15 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB412FFEC;
        Wed, 22 Jun 2022 10:29:13 -0700 (PDT)
Received: from zn.tnic (p200300ea974657a8329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:57a8:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 44E831EC0523;
        Wed, 22 Jun 2022 19:29:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1655918948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rc3AfU6rFy7ZtgzHurH9kY/l4zZAuuCWcwC0ZSrhy2o=;
        b=VTlg7HKYVSpdaoUcWY7uDaNorr1cWVO5UcbttxULEHrJdSTvChR7RxWcL80+CpACP5xfyJ
        Pe3/omeGAaXYyPX5KlinKk0USivsaV2cNXFoNKxnphveVmRH+6fzhr53DZUi5aS9QXIuJj
        +NEkeJybAGG18Do3UeWER44eCP7TX04=
Date:   Wed, 22 Jun 2022 19:29:04 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v5] x86/mce: Check for writes ignored in MCA_STATUS
 register
Message-ID: <YrNRYJx0CNDNj3oX@zn.tnic>
References: <20220610192515.98540-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220610192515.98540-1-Smita.KoralahalliChannabasappa@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jun 10, 2022 at 07:25:15PM +0000, Smita Koralahalli wrote:
>  arch/x86/kernel/cpu/mce/inject.c   | 50 +++++++++++++++++++++++++++++-
>  arch/x86/kernel/cpu/mce/internal.h |  2 +-
>  2 files changed, 50 insertions(+), 2 deletions(-)

I've simplified, improved and removed some stuff. See if that still
works on that platform which ignores writes.

Thx.

---
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Date: Fri, 10 Jun 2022 19:25:15 +0000
Subject: [PATCH] x86/mce: Check whether writes to MCA_STATUS are getting
 ignored

The platform can sometimes - depending on its settings - cause writes
to MCA_STATUS MSRs to get ignored, regardless of HWCR[McStatusWrEn]'s
value.

For further info see

  PPR for AMD Family 19h, Model 01h, Revision B1 Processors, doc ID 55898

at https://bugzilla.kernel.org/show_bug.cgi?id=206537.

Therefore, probe for ignored writes to MCA_STATUS to determine if hardware
error injection is at all possible.

  [ bp: Heavily massage commit message and patch. ]

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220214233640.70510-2-Smita.KoralahalliChannabasappa@amd.com
---
 arch/x86/kernel/cpu/mce/inject.c   | 44 ++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/mce/internal.h |  2 +-
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 5fbd7ffb3233..35ac8bf5bee6 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -33,6 +33,8 @@
 
 #include "internal.h"
 
+static bool hw_injection_possible = true;
+
 /*
  * Collect all the MCi_XXX settings
  */
@@ -339,6 +341,8 @@ static int __set_inj(const char *buf)
 
 	for (i = 0; i < N_INJ_TYPES; i++) {
 		if (!strncmp(flags_options[i], buf, strlen(flags_options[i]))) {
+			if (i > SW_INJ && !hw_injection_possible)
+				continue;
 			inj_type = i;
 			return 0;
 		}
@@ -717,11 +721,51 @@ static void __init debugfs_init(void)
 				    &i_mce, dfs_fls[i].fops);
 }
 
+static void check_hw_inj_possible(void)
+{
+	int cpu;
+	u8 bank;
+
+	/*
+	 * This behavior exists only on SMCA systems though its not directly
+	 * related to SMCA.
+	 */
+	if (!cpu_feature_enabled(X86_FEATURE_SMCA))
+		return;
+
+	cpu = get_cpu();
+
+	for (bank = 0; bank < MAX_NR_BANKS; ++bank) {
+		u64 status = MCI_STATUS_VAL, ipid;
+
+		/* Check whether bank is populated */
+		rdmsrl(MSR_AMD64_SMCA_MCx_IPID(bank), ipid);
+		if (!ipid)
+			continue;
+
+		toggle_hw_mce_inject(cpu, true);
+
+		if (wrmsrl_safe(mca_msr_reg(bank, MCA_STATUS), status)) {
+			hw_injection_possible = false;
+			pr_warn("Platform does not allow *hardware* error injection."
+				"Try using APEI EINJ instead.\n");
+		}
+
+		toggle_hw_mce_inject(cpu, false);
+
+		break;
+	}
+
+	put_cpu();
+}
+
 static int __init inject_init(void)
 {
 	if (!alloc_cpumask_var(&mce_inject_cpumask, GFP_KERNEL))
 		return -ENOMEM;
 
+	check_hw_inj_possible();
+
 	debugfs_init();
 
 	register_nmi_handler(NMI_LOCAL, mce_raise_notify, 0, "mce_notify");
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 4ae0e603f7fa..7e03f5b7f6bd 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -211,7 +211,7 @@ noinstr u64 mce_rdmsrl(u32 msr);
 
 static __always_inline u32 mca_msr_reg(int bank, enum mca_msr reg)
 {
-	if (mce_flags.smca) {
+	if (cpu_feature_enabled(X86_FEATURE_SMCA)) {
 		switch (reg) {
 		case MCA_CTL:	 return MSR_AMD64_SMCA_MCx_CTL(bank);
 		case MCA_ADDR:	 return MSR_AMD64_SMCA_MCx_ADDR(bank);
-- 
2.35.1

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
