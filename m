Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D955319DB52
	for <lists+linux-edac@lfdr.de>; Fri,  3 Apr 2020 18:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404204AbgDCQT4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 3 Apr 2020 12:19:56 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49384 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404374AbgDCQTz (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 3 Apr 2020 12:19:55 -0400
Received: from zn.tnic (p200300EC2F0D8900BDBBB37D18611998.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:8900:bdbb:b37d:1861:1998])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 530C21EC0CF3;
        Fri,  3 Apr 2020 18:19:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1585930794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cBsewcd5O2TRQ4KvHAkBQnG2M3bkQT4wvGh+cR4bzek=;
        b=AJAMCfKg839wBJjWJfvwivNYPgka5Hq6fmY+FHGcRevMM04+n7U6cSwNjvrZL+Zluq+uAk
        9myJ/ZdbM54Z1LDMUKAoPnEV5HpGfr7hGtsLipuZk5TBFzAkKtXOJm1t8HFShqdcddstlV
        zFkBvwERnb3/lTl8MryITXUCVs0jPfQ=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-edac <linux-edac@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/7] x86/mce/amd: Cleanup threshold device remove path
Date:   Fri,  3 Apr 2020 18:19:42 +0200
Message-Id: <20200403161943.1458-7-bp@alien8.de>
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

Pass in the bank pointer directly to the cleaning up functions,
obviating the need for per-CPU accesses. Make the clean up path
interrupt-safe by cleaning the bank pointer first so that the rest of
the teardown happens safe from the thresholding interrupt.

No functional changes.

 [ bp: Write commit message and reverse bank->shared test to save an
   indentation level in threshold_remove_bank(). ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/amd_nb.h |  1 +
 arch/x86/kernel/cpu/mce/amd.c | 79 ++++++++++++++++-------------------
 2 files changed, 38 insertions(+), 42 deletions(-)

diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index c7df20e78b09..455066a06f60 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -57,6 +57,7 @@ struct threshold_bank {
 
 	/* initialized to the number of CPUs on the node sharing this bank */
 	refcount_t		cpus;
+	unsigned int		shared;
 };
 
 struct amd_northbridge {
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index a33d9a1caf36..16e7aea86ab1 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1362,6 +1362,7 @@ static int threshold_create_bank(struct threshold_bank **bp, unsigned int cpu,
 	}
 
 	if (is_shared_bank(bank)) {
+		b->shared = 1;
 		refcount_set(&b->cpus, 1);
 
 		/* nb is already initialized, see above */
@@ -1391,21 +1392,16 @@ static void threshold_block_release(struct kobject *kobj)
 	kfree(to_block(kobj));
 }
 
-static void deallocate_threshold_block(unsigned int cpu, unsigned int bank)
+static void deallocate_threshold_blocks(struct threshold_bank *bank)
 {
-	struct threshold_block *pos = NULL;
-	struct threshold_block *tmp = NULL;
-	struct threshold_bank *head = per_cpu(threshold_banks, cpu)[bank];
-
-	if (!head)
-		return;
+	struct threshold_block *pos, *tmp;
 
-	list_for_each_entry_safe(pos, tmp, &head->blocks->miscj, miscj) {
+	list_for_each_entry_safe(pos, tmp, &bank->blocks->miscj, miscj) {
 		list_del(&pos->miscj);
 		kobject_put(&pos->kobj);
 	}
 
-	kobject_put(&head->blocks->kobj);
+	kobject_put(&bank->blocks->kobj);
 }
 
 static void __threshold_remove_blocks(struct threshold_bank *b)
@@ -1419,57 +1415,56 @@ static void __threshold_remove_blocks(struct threshold_bank *b)
 		kobject_del(&pos->kobj);
 }
 
-static void threshold_remove_bank(unsigned int cpu, int bank)
+static void threshold_remove_bank(struct threshold_bank *bank)
 {
 	struct amd_northbridge *nb;
-	struct threshold_bank *b;
 
-	b = per_cpu(threshold_banks, cpu)[bank];
-	if (!b)
-		return;
+	if (!bank->blocks)
+		goto out_free;
 
-	if (!b->blocks)
-		goto free_out;
+	if (!bank->shared)
+		goto out_dealloc;
 
-	if (is_shared_bank(bank)) {
-		if (!refcount_dec_and_test(&b->cpus)) {
-			__threshold_remove_blocks(b);
-			per_cpu(threshold_banks, cpu)[bank] = NULL;
-			return;
-		} else {
-			/*
-			 * the last CPU on this node using the shared bank is
-			 * going away, remove that bank now.
-			 */
-			nb = node_to_amd_nb(amd_get_nb_id(cpu));
-			nb->bank4 = NULL;
-		}
+	if (!refcount_dec_and_test(&bank->cpus)) {
+		__threshold_remove_blocks(bank);
+		return;
+	} else {
+		/*
+		 * The last CPU on this node using the shared bank is going
+		 * away, remove that bank now.
+		 */
+		nb = node_to_amd_nb(amd_get_nb_id(smp_processor_id()));
+		nb->bank4 = NULL;
 	}
 
-	deallocate_threshold_block(cpu, bank);
+out_dealloc:
+	deallocate_threshold_blocks(bank);
 
-free_out:
-	kobject_del(b->kobj);
-	kobject_put(b->kobj);
-	kfree(b);
-	per_cpu(threshold_banks, cpu)[bank] = NULL;
+out_free:
+	kobject_put(bank->kobj);
+	kfree(bank);
 }
 
 int mce_threshold_remove_device(unsigned int cpu)
 {
 	struct threshold_bank **bp = this_cpu_read(threshold_banks);
-	unsigned int bank;
+	unsigned int bank, numbanks = this_cpu_read(mce_num_banks);
 
 	if (!bp)
 		return 0;
 
-	for (bank = 0; bank < per_cpu(mce_num_banks, cpu); ++bank) {
-		if (!(per_cpu(bank_map, cpu) & (1 << bank)))
-			continue;
-		threshold_remove_bank(cpu, bank);
-	}
-	/* Clear the pointer before freeing the memory */
+	/*
+	 * Clear the pointer before cleaning up, so that the interrupt won't
+	 * touch anything of this.
+	 */
 	this_cpu_write(threshold_banks, NULL);
+
+	for (bank = 0; bank < numbanks; bank++) {
+		if (bp[bank]) {
+			threshold_remove_bank(bp[bank]);
+			bp[bank] = NULL;
+		}
+	}
 	kfree(bp);
 	return 0;
 }
-- 
2.21.0

