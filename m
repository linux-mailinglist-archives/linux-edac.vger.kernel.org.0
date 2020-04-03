Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A837319DB5F
	for <lists+linux-edac@lfdr.de>; Fri,  3 Apr 2020 18:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404407AbgDCQUI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 3 Apr 2020 12:20:08 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49292 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728352AbgDCQTy (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 3 Apr 2020 12:19:54 -0400
Received: from zn.tnic (p200300EC2F0D8900BDBBB37D18611998.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:8900:bdbb:b37d:1861:1998])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ACAD81EC0CED;
        Fri,  3 Apr 2020 18:19:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1585930792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=revb2MgAgV6cUyetX2ivAXtvOCJXDZhZdRdERTfkrvE=;
        b=nHxjRZfsCAZHy2JghqKilAZnewH7RBOivMc0INXK6pld9rSLClk2K/L0dM5SddDNfrcfAm
        pByhnh9kvrAdmKdKKKqcoXn/xbaTRpOw/gmzcO0NoEPQKw/RyK8rwRw1B4MpgTn5MEIR+c
        njbVcAJ3zO+TfUIZXtk8m1RjpjhxyQw=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-edac <linux-edac@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/7] x86/mce/amd: Sanitize thresholding device creation hotplug path
Date:   Fri,  3 Apr 2020 18:19:40 +0200
Message-Id: <20200403161943.1458-5-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200403161943.1458-1-bp@alien8.de>
References: <20200403161943.1458-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Drop the stupid threshold_init_device() initcall iterating over all
online CPUs in favor of properly setting up everything on the CPU
hotplug path, when each CPU's callback is invoked.

 [ bp: Write commit message. ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mce/amd.c  | 57 ++++++++++------------------------
 arch/x86/kernel/cpu/mce/core.c | 11 +++++++
 2 files changed, 27 insertions(+), 41 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 563942157758..d3c416b6052a 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1474,12 +1474,22 @@ int mce_threshold_remove_device(unsigned int cpu)
 	return 0;
 }
 
-/* create dir/files for all valid threshold banks */
+/**
+ * mce_threshold_create_device - Create the per-CPU MCE threshold device
+ * @cpu:	The plugged in CPU
+ *
+ * Create directories and files for all valid threshold banks.
+ *
+ * This is invoked from the CPU hotplug callback which was installed in
+ * mcheck_init_device(). The invocation happens in context of the hotplug
+ * thread running on @cpu.  The callback is invoked on all CPUs which are
+ * online when the callback is installed or during a real hotplug event.
+ */
 int mce_threshold_create_device(unsigned int cpu)
 {
 	unsigned int bank;
 	struct threshold_bank **bp;
-	int err = 0;
+	int err;
 
 	if (!mce_flags.amd_threshold)
 		return 0;
@@ -1500,49 +1510,14 @@ int mce_threshold_create_device(unsigned int cpu)
 			continue;
 		err = threshold_create_bank(cpu, bank);
 		if (err)
-			goto err;
-	}
-	return err;
-err:
-	mce_threshold_remove_device(cpu);
-	return err;
-}
-
-static __init int threshold_init_device(void)
-{
-	unsigned lcpu = 0;
-
-	/* to hit CPUs online before the notifier is up */
-	for_each_online_cpu(lcpu) {
-		int err = mce_threshold_create_device(lcpu);
-
-		if (err)
-			return err;
+			goto out_err;
 	}
 
 	if (thresholding_irq_en)
 		mce_threshold_vector = amd_threshold_interrupt;
 
 	return 0;
+out_err:
+	mce_threshold_remove_device(cpu);
+	return err;
 }
-/*
- * there are 3 funcs which need to be _initcalled in a logic sequence:
- * 1. xen_late_init_mcelog
- * 2. mcheck_init_device
- * 3. threshold_init_device
- *
- * xen_late_init_mcelog must register xen_mce_chrdev_device before
- * native mce_chrdev_device registration if running under xen platform;
- *
- * mcheck_init_device should be inited before threshold_init_device to
- * initialize mce_device, otherwise a NULL ptr dereference will cause panic.
- *
- * so we use following _initcalls
- * 1. device_initcall(xen_late_init_mcelog);
- * 2. device_initcall_sync(mcheck_init_device);
- * 3. late_initcall(threshold_init_device);
- *
- * when running under xen, the initcall order is 1,2,3;
- * on baremetal, we skip 1 and we do only 2 and 3.
- */
-late_initcall(threshold_init_device);
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 43ca91e14a77..a6009efdfe2b 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2481,6 +2481,13 @@ static __init void mce_init_banks(void)
 	}
 }
 
+/*
+ * When running on XEN, this initcall is ordered against the XEN mcelog
+ * initcall:
+ *
+ *   device_initcall(xen_late_init_mcelog);
+ *   device_initcall_sync(mcheck_init_device);
+ */
 static __init int mcheck_init_device(void)
 {
 	int err;
@@ -2512,6 +2519,10 @@ static __init int mcheck_init_device(void)
 	if (err)
 		goto err_out_mem;
 
+	/*
+	 * Invokes mce_cpu_online() on all CPUs which are online when
+	 * the state is installed.
+	 */
 	err = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/mce:online",
 				mce_cpu_online, mce_cpu_pre_down);
 	if (err < 0)
-- 
2.21.0

