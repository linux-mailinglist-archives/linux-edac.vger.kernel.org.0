Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEED4F67F1
	for <lists+linux-edac@lfdr.de>; Wed,  6 Apr 2022 19:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239601AbiDFR6B (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Apr 2022 13:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239942AbiDFR5m (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 6 Apr 2022 13:57:42 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3DA1578F8;
        Wed,  6 Apr 2022 09:08:18 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E86941EC0531;
        Wed,  6 Apr 2022 18:08:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649261293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LaD6kLx2lHmaoJGZnze6BBGNKdyNqLYnWL7U7Z2JqwU=;
        b=rBJn66aefcq4wxaoMV8nYj8XwS/L+1kwr4ULrnEWk0Eg3vhCa4j2q9kyiEVbVmSGYuH5np
        2UwoLiIwH1R8aXC6em5E9vgPpY7xJhTtdVIKC1r3WvLkuIeiYUd3UY5OVWwSOK9E7YaphK
        YuQHn4GLYxz8AZ3N/jI5VSYeNAL+hoo=
Date:   Wed, 6 Apr 2022 18:08:12 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v4 1/2] x86/mce: Check for writes ignored in MCA_STATUS
 register
Message-ID: <Yk267A1MKOo2AlXQ@zn.tnic>
References: <20220214233640.70510-1-Smita.KoralahalliChannabasappa@amd.com>
 <20220214233640.70510-2-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220214233640.70510-2-Smita.KoralahalliChannabasappa@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Feb 14, 2022 at 05:36:39PM -0600, Smita Koralahalli wrote:
> diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
> index 5fbd7ffb3233..43ba63b7dc73 100644
> --- a/arch/x86/kernel/cpu/mce/inject.c
> +++ b/arch/x86/kernel/cpu/mce/inject.c
> @@ -470,11 +470,36 @@ static void toggle_nb_mca_mst_cpu(u16 nid)
>  		       __func__, PCI_FUNC(F3->devfn), NBCFG);
>  }
>  
> +struct mce_err_handler {
> +	struct mce *mce;
> +	int err;
> +};

Well, we already have a struct mce i_mce which serves as a sort-of
global container for injection data which gets dumped into the hardware
upon injection time.

Now you're adding another struct which contains additional info and are
adding a pointer to that i_mce.

But this is not a clean design - when you do stuff like that you need to
unify all those global-info-containing structs and make the code dealing
with them straight-forward . I.e., if you don't look at the big picture
of a design, it soon grows into an unwieldy mess which some poor sod
would need to clean up afterwards and that poor sod is in most cases the
maintainer.

So I went and did that ontop of your patch, this is one possible way to
do it but it.

Here it is, a combined diff ontop of tip:ras/core. Please split it into
patches: first patch converts to the new descriptor and then a second
one adds the MCA_STATUS checking bits.

There are a couple of other changes in there, if they're not clear, feel
free to ask.

Thx.

---
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 43ba63b7dc73..0fd1eea2f754 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -33,10 +33,14 @@
 
 #include "internal.h"
 
-/*
- * Collect all the MCi_XXX settings
- */
-static struct mce i_mce;
+static bool hw_injection_possible = true;
+
+/* Collect all the MCi_XXX settings */
+static struct inject_desc {
+	struct mce m;
+	int err;
+} inj_desc;
+
 static struct dentry *dfs_inj;
 
 #define MAX_FLAG_OPT_SIZE	4
@@ -110,9 +114,11 @@ static int inj_ipid_set(void *data, u64 val)
 
 DEFINE_SIMPLE_ATTRIBUTE(ipid_fops, inj_ipid_get, inj_ipid_set, "%llx\n");
 
-static void setup_inj_struct(struct mce *m)
+static void setup_inj_struct(void)
 {
-	memset(m, 0, sizeof(struct mce));
+	struct mce *m = &inj_desc.m;
+
+	memset(&inj_desc, 0, sizeof(struct inject_desc));
 
 	m->cpuvendor = boot_cpu_data.x86_vendor;
 	m->time	     = ktime_get_real_seconds();
@@ -470,84 +476,78 @@ static void toggle_nb_mca_mst_cpu(u16 nid)
 		       __func__, PCI_FUNC(F3->devfn), NBCFG);
 }
 
-struct mce_err_handler {
-	struct mce *mce;
-	int err;
-};
-
-static struct mce_err_handler mce_err;
-
-static bool prepare_mca_status(struct mce *m)
+static bool prepare_mca_status(void)
 {
-	u32 status_reg = mca_msr_reg(m->bank, MCA_STATUS);
-	u64 status_val = m->status;
+	u32 status_reg = mca_msr_reg(inj_desc.m.bank, MCA_STATUS);
+	u64 status_val = inj_desc.m.status;
 
 	wrmsrl(status_reg, status_val);
 	rdmsrl(status_reg, status_val);
 
-	return status_val;
+	return status_val == inj_desc.m.status;
 }
 
-static void prepare_msrs(void *info)
+static void prepare_msrs(void *unused)
 {
-	struct mce_err_handler *i_mce_err = ((struct mce_err_handler *)info);
-	struct mce m = *i_mce_err->mce;
-	u8 b = m.bank;
+	struct mce *m = &inj_desc.m;
+	u8 b = inj_desc.m.bank;
 
-	if (!prepare_mca_status(&m)) {
+	if (!prepare_mca_status()) {
 		pr_err("Platform does not allow error injection, try using APEI EINJ instead.\n");
-		i_mce_err->err = -EINVAL;
+		inj_desc.err = -EINVAL;
+		hw_injection_possible = false;
 		return;
 	}
 
-	wrmsrl(MSR_IA32_MCG_STATUS, m.mcgstatus);
+	wrmsrl(MSR_IA32_MCG_STATUS, m->mcgstatus);
 
 	if (boot_cpu_has(X86_FEATURE_SMCA)) {
-		if (m.inject_flags == DFR_INT_INJ) {
-			wrmsrl(MSR_AMD64_SMCA_MCx_DESTAT(b), m.status);
-			wrmsrl(MSR_AMD64_SMCA_MCx_DEADDR(b), m.addr);
+		if (m->inject_flags == DFR_INT_INJ) {
+			wrmsrl(MSR_AMD64_SMCA_MCx_DESTAT(b), m->status);
+			wrmsrl(MSR_AMD64_SMCA_MCx_DEADDR(b), m->addr);
 		} else {
-			wrmsrl(MSR_AMD64_SMCA_MCx_STATUS(b), m.status);
-			wrmsrl(MSR_AMD64_SMCA_MCx_ADDR(b), m.addr);
+			wrmsrl(MSR_AMD64_SMCA_MCx_STATUS(b), m->status);
+			wrmsrl(MSR_AMD64_SMCA_MCx_ADDR(b), m->addr);
 		}
 
-		wrmsrl(MSR_AMD64_SMCA_MCx_MISC(b), m.misc);
-		wrmsrl(MSR_AMD64_SMCA_MCx_SYND(b), m.synd);
+		wrmsrl(MSR_AMD64_SMCA_MCx_MISC(b), m->misc);
+		wrmsrl(MSR_AMD64_SMCA_MCx_SYND(b), m->synd);
 	} else {
-		wrmsrl(MSR_IA32_MCx_STATUS(b), m.status);
-		wrmsrl(MSR_IA32_MCx_ADDR(b), m.addr);
-		wrmsrl(MSR_IA32_MCx_MISC(b), m.misc);
+		wrmsrl(MSR_IA32_MCx_STATUS(b), m->status);
+		wrmsrl(MSR_IA32_MCx_ADDR(b), m->addr);
+		wrmsrl(MSR_IA32_MCx_MISC(b), m->misc);
 	}
 }
 
-static void do_inject(void)
+static int do_inject(void)
 {
+	struct mce *m = &inj_desc.m;
+	unsigned int cpu = m->extcpu;
 	u64 mcg_status = 0;
-	unsigned int cpu = i_mce.extcpu;
-	u8 b = i_mce.bank;
+	u8 b = m->bank;
 
-	mce_err.mce = &i_mce;
-	mce_err.err = 0;
+	m->tsc = rdtsc_ordered();
 
-	i_mce.tsc = rdtsc_ordered();
+	m->status |= MCI_STATUS_VAL;
 
-	i_mce.status |= MCI_STATUS_VAL;
+	if (m->misc)
+		m->status |= MCI_STATUS_MISCV;
 
-	if (i_mce.misc)
-		i_mce.status |= MCI_STATUS_MISCV;
-
-	if (i_mce.synd)
-		i_mce.status |= MCI_STATUS_SYNDV;
+	if (m->synd)
+		m->status |= MCI_STATUS_SYNDV;
 
 	if (inj_type == SW_INJ) {
-		mce_log(&i_mce);
-		return;
+		mce_log(m);
+		return 0;
 	}
 
+	if (!hw_injection_possible)
+		return -EINVAL;
+
 	/* prep MCE global settings for the injection */
 	mcg_status = MCG_STATUS_MCIP | MCG_STATUS_EIPV;
 
-	if (!(i_mce.status & MCI_STATUS_PCC))
+	if (!(m->status & MCI_STATUS_PCC))
 		mcg_status |= MCG_STATUS_RIPV;
 
 	/*
@@ -556,8 +556,8 @@ static void do_inject(void)
 	 * - MCx_STATUS[UC] cleared: deferred errors are _not_ UC
 	 */
 	if (inj_type == DFR_INT_INJ) {
-		i_mce.status |= MCI_STATUS_DEFERRED;
-		i_mce.status &= ~MCI_STATUS_UC;
+		m->status |= MCI_STATUS_DEFERRED;
+		m->status &= ~MCI_STATUS_UC;
 	}
 
 	/*
@@ -578,13 +578,13 @@ static void do_inject(void)
 
 	toggle_hw_mce_inject(cpu, true);
 
-	i_mce.mcgstatus = mcg_status;
-	i_mce.inject_flags = inj_type;
-	smp_call_function_single(cpu, prepare_msrs, &mce_err, 0);
+	m->mcgstatus = mcg_status;
+	m->inject_flags = inj_type;
+	smp_call_function_single(cpu, prepare_msrs, NULL, 0);
 
 	toggle_hw_mce_inject(cpu, false);
 
-	if (mce_err.err)
+	if (inj_desc.err)
 		goto err;
 
 	switch (inj_type) {
@@ -601,6 +601,7 @@ static void do_inject(void)
 err:
 	cpus_read_unlock();
 
+	return inj_desc.err;
 }
 
 /*
@@ -611,6 +612,7 @@ static int inj_bank_set(void *data, u64 val)
 {
 	struct mce *m = (struct mce *)data;
 	u8 n_banks;
+	int err;
 	u64 cap;
 
 	/* Get bank count on target CPU so we can handle non-uniform values. */
@@ -650,12 +652,12 @@ static int inj_bank_set(void *data, u64 val)
 	}
 
 inject:
-	do_inject();
+	err = do_inject();
 
 	/* Reset injection struct */
-	setup_inj_struct(&i_mce);
+	setup_inj_struct();
 
-	return mce_err.err;
+	return err;
 }
 
 MCE_INJECT_GET(bank);
@@ -745,7 +747,7 @@ static void __init debugfs_init(void)
 
 	for (i = 0; i < ARRAY_SIZE(dfs_fls); i++)
 		debugfs_create_file(dfs_fls[i].name, dfs_fls[i].perm, dfs_inj,
-				    &i_mce, dfs_fls[i].fops);
+				    &inj_desc.m, dfs_fls[i].fops);
 }
 
 static int __init inject_init(void)
@@ -758,7 +760,7 @@ static int __init inject_init(void)
 	register_nmi_handler(NMI_LOCAL, mce_raise_notify, 0, "mce_notify");
 	mce_register_injector_chain(&inject_nb);
 
-	setup_inj_struct(&i_mce);
+	setup_inj_struct();
 
 	pr_info("Machine check injector initialized\n");
 
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
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
