Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B799A722FD0
	for <lists+linux-edac@lfdr.de>; Mon,  5 Jun 2023 21:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbjFETaH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 5 Jun 2023 15:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjFETaH (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 5 Jun 2023 15:30:07 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4C6A7
        for <linux-edac@vger.kernel.org>; Mon,  5 Jun 2023 12:30:06 -0700 (PDT)
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D24951EC0103;
        Mon,  5 Jun 2023 21:30:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1685993404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0F4XYD4nEzUpXQKPnsi73dLONcgl1OZJgAL/nrztlFA=;
        b=MGx7win6p3Qu99U00zF0oPg3pNzm9Cme0u9bm8sEL0Cz+fdCRbGbFFssAIV/13R1QT859b
        DKjtiygID7AejwUxe391KqdvOGPCm8lIrFOIDaBAcmSmwFm9MJQYPJdsBUGfXgMyQAFEEa
        2I9bA84GMiqIBNQxve1dZs8ogZEdJOY=
Date:   Mon, 5 Jun 2023 21:30:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Aristeu Rozanski <aris@ruivo.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Aristeu Rozanski <aris@redhat.com>
Subject: Re: [PATCH] mce: prevent concurrent polling of MCE events
Message-ID: <20230605193000.GDZH43uFhBmQfSO+9D@fat_crate.local>
References: <SJ1PR11MB6083576B4BE589D6F04559A5FC789@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230515183050.GJZGJ6Wsmr4Yf/H5Ps@fat_crate.local>
 <SJ1PR11MB6083DC9538CDB6E7FA8B803BFC789@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230515194423.GKZGKLl+8mJiLoJAp1@fat_crate.local>
 <SJ1PR11MB6083B867B6B95820366C08BDFC789@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230523141523.GL4090740@cathedrallabs.org>
 <20230604160442.GN4090740@cathedrallabs.org>
 <SJ1PR11MB60830E9036D6D0181CF9CFD4FC4DA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230605174104.GBZH4eMLx1cp+nQJH2@fat_crate.local>
 <SJ1PR11MB6083726809001C8E29D65F15FC4DA@SJ1PR11MB6083.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083726809001C8E29D65F15FC4DA@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jun 05, 2023 at 05:58:40PM +0000, Luck, Tony wrote:
> That would need to take care to only strip out truly duplicated reports, but
> leave in genuine repeats of errors from the same location.

Yeah, timestamps will make them unique.

> I agree this path isn't worth taking.

I have a feeling we might need to dedup at some point but we can do that
in luserspace.

> How much code do you want to duplicate?

The usual. See untested diff below.

> I can't parse that either. Maybe rooted in the fact that UCNA ignores the
> threshold in MCi_CTL2 ... but maybe there's some missing description
> of what the SMI handler is doing.

If you don't know what this does either, then this is going nowhere
before it is properly explained.

> HPE are big fans of firmware first for corrected errors. It's more complicated
> for uncorrected ones as the OS really needs to know about those.

Bah, the firmware is so powerful and perfect. What does it need the OS
for? </sarcasm>

---

Btw, why was that spinlock raw?

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 22dfcb2adcd7..bcdf5b52003c 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1595,6 +1595,13 @@ static unsigned long mce_adjust_timer_default(unsigned long interval)
 
 static unsigned long (*mce_adjust_timer)(unsigned long interval) = mce_adjust_timer_default;
 
+static void poll_cmci_disabled(void)
+{
+	machine_check_poll(0, this_cpu_ptr(&mce_poll_banks));
+}
+
+static void (*poll_cmci_disabled)(void) = poll_cmci_disabled_default;
+
 static void __start_timer(struct timer_list *t, unsigned long interval)
 {
 	unsigned long when = jiffies + interval;
@@ -1618,7 +1625,7 @@ static void mce_timer_fn(struct timer_list *t)
 	iv = __this_cpu_read(mce_next_interval);
 
 	if (mce_available(this_cpu_ptr(&cpu_info))) {
-		machine_check_poll(0, this_cpu_ptr(&mce_poll_banks));
+		poll_cmci_disabled();
 
 		if (mce_intel_cmci_poll()) {
 			iv = mce_adjust_timer(iv);
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index 95275a5e57e0..4722a57baf1e 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -71,6 +71,8 @@ enum {
 	CMCI_STORM_SUBSIDED,
 };
 
+static DEFINE_SPINLOCK(timer_fn_lock);
+
 static atomic_t cmci_storm_on_cpus;
 
 static int cmci_supported(int *banks)
@@ -426,12 +428,22 @@ void cmci_disable_bank(int bank)
 	raw_spin_unlock_irqrestore(&cmci_discover_lock, flags);
 }
 
+static void poll_cmci_disabled_intel(void)
+{
+	raw_spin_lock(&timer_fn_lock);
+	machine_check_poll(0, this_cpu_ptr(&mce_poll_banks));
+	raw_spin_unlock(&timer_fn_lock);
+}
+
 void intel_init_cmci(void)
 {
 	int banks;
 
-	if (!cmci_supported(&banks))
+	if (!cmci_supported(&banks)) {
+		if (mca_cfg.cmci_disabled)
+			poll_cmci_disabled = poll_cmci_disabled_intel;
 		return;
+	}
 
 	mce_threshold_vector = intel_threshold_interrupt;
 	cmci_discover(banks);

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
