Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 972CC19DB5D
	for <lists+linux-edac@lfdr.de>; Fri,  3 Apr 2020 18:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404349AbgDCQTx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 3 Apr 2020 12:19:53 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49310 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404348AbgDCQTx (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 3 Apr 2020 12:19:53 -0400
Received: from zn.tnic (p200300EC2F0D8900BDBBB37D18611998.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:8900:bdbb:b37d:1861:1998])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DCF121EC0CE3;
        Fri,  3 Apr 2020 18:19:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1585930792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D7B+yy1oKm9SYObHllQrPSWx0l5ENOI+htOp1S4XJSQ=;
        b=OuxAUaRQOHX+WoCqXkOZvSLwJD2rRocC9IDJjFyrySC+OJJeJxBK5CYbbnul62GrC4mKFR
        lcUDYqOV1ZsSn+cR6lkJU1oQe9sBpSuN4JqJPl8xNJiR32taGAhefSbZJ+sWuT70HhFnme
        f04iOb1NN1ibRRVUD+RZRj6R365P89s=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-edac <linux-edac@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/7] x86/mce/amd: Protect a not-fully initialized bank from the thresholding interrupt
Date:   Fri,  3 Apr 2020 18:19:39 +0200
Message-Id: <20200403161943.1458-4-bp@alien8.de>
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

Make sure the thresholding bank descriptor is fully initialized when the
thresholding interrupt fires after a hotplug event.

 [ bp: Write commit message and document long-forgotten bank_map. ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mce/amd.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index c3b3326ad4ac..563942157758 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -192,7 +192,12 @@ EXPORT_SYMBOL_GPL(smca_banks);
 static char buf_mcatype[MAX_MCATYPE_NAME_LEN];
 
 static DEFINE_PER_CPU(struct threshold_bank **, threshold_banks);
-static DEFINE_PER_CPU(unsigned int, bank_map);	/* see which banks are on */
+
+/*
+ * A list of the banks enabled on each logical CPU. Controls which respective
+ * descriptors to initialize later in mce_threshold_create_device().
+ */
+static DEFINE_PER_CPU(unsigned int, bank_map);
 
 /* Map of banks that have more than MCA_MISC0 available. */
 static DEFINE_PER_CPU(u32, smca_misc_banks_map);
@@ -1016,13 +1021,22 @@ static void log_and_reset_block(struct threshold_block *block)
 static void amd_threshold_interrupt(void)
 {
 	struct threshold_block *first_block = NULL, *block = NULL, *tmp = NULL;
+	struct threshold_bank **bp = this_cpu_read(threshold_banks);
 	unsigned int bank, cpu = smp_processor_id();
 
+	/*
+	 * Validate that the threshold bank has been initialized already. The
+	 * handler is installed at boot time, but on a hotplug event the
+	 * interrupt might fire before the data has been initialized.
+	 */
+	if (!bp)
+		return;
+
 	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
 		if (!(per_cpu(bank_map, cpu) & (1 << bank)))
 			continue;
 
-		first_block = per_cpu(threshold_banks, cpu)[bank]->blocks;
+		first_block = bp[bank]->blocks;
 		if (!first_block)
 			continue;
 
@@ -1247,6 +1261,7 @@ static int allocate_threshold_blocks(unsigned int cpu, struct threshold_bank *tb
 
 	INIT_LIST_HEAD(&b->miscj);
 
+	/* This is safe as @tb is not visible yet */
 	if (tb->blocks)
 		list_add(&b->miscj, &tb->blocks->miscj);
 	else
-- 
2.21.0

