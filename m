Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDE7219DB59
	for <lists+linux-edac@lfdr.de>; Fri,  3 Apr 2020 18:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404399AbgDCQUH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 3 Apr 2020 12:20:07 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49310 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404365AbgDCQTy (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 3 Apr 2020 12:19:54 -0400
Received: from zn.tnic (p200300EC2F0D8900BDBBB37D18611998.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:8900:bdbb:b37d:1861:1998])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 80A7A1EC0CEE;
        Fri,  3 Apr 2020 18:19:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1585930793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WxfUHWPsjSfvG/d93sW/gdjDn/TEWXVobucmlT3oP+E=;
        b=sQq/8rDkKktjonzP4XOCDPk0aAqWHZGrz0cIYhe92k8Klp6bryCgwhYv/d3Eb1rrxvW/G7
        J2ccoc88mGzhB02oPY+RkVog8yzg/dEymx9PNLrSpHIpu3zXmmhfrGrNF6rJ4P+8E/lVu7
        X7hD+Y+YKmTXQ4RWKviHS4TsS2UjPUk=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-edac <linux-edac@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/7] x86/mce/amd: Straighten CPU hotplug path
Date:   Fri,  3 Apr 2020 18:19:41 +0200
Message-Id: <20200403161943.1458-6-bp@alien8.de>
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

mce_threshold_create_device() hotplug callback runs on the plugged in
CPU so:

 - use this_cpu_read() which is faster
 - pass in struct threshold_bank **bp to threshold_create_bank() and
   instead of doing per-CPU accesses
 - Use rdmsr_safe() instead of rdmsr_safe_on_cpu() which avoids an IPI.

No functional changes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mce/amd.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index d3c416b6052a..a33d9a1caf36 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1223,10 +1223,10 @@ static int allocate_threshold_blocks(unsigned int cpu, struct threshold_bank *tb
 	u32 low, high;
 	int err;
 
-	if ((bank >= per_cpu(mce_num_banks, cpu)) || (block >= NR_BLOCKS))
+	if ((bank >= this_cpu_read(mce_num_banks)) || (block >= NR_BLOCKS))
 		return 0;
 
-	if (rdmsr_safe_on_cpu(cpu, address, &low, &high))
+	if (rdmsr_safe(address, &low, &high))
 		return 0;
 
 	if (!(high & MASK_VALID_HI)) {
@@ -1316,9 +1316,10 @@ static int __threshold_add_blocks(struct threshold_bank *b)
 	return err;
 }
 
-static int threshold_create_bank(unsigned int cpu, unsigned int bank)
+static int threshold_create_bank(struct threshold_bank **bp, unsigned int cpu,
+				 unsigned int bank)
 {
-	struct device *dev = per_cpu(mce_device, cpu);
+	struct device *dev = this_cpu_read(mce_device);
 	struct amd_northbridge *nb = NULL;
 	struct threshold_bank *b = NULL;
 	const char *name = get_name(bank, NULL);
@@ -1338,7 +1339,7 @@ static int threshold_create_bank(unsigned int cpu, unsigned int bank)
 			if (err)
 				goto out;
 
-			per_cpu(threshold_banks, cpu)[bank] = b;
+			bp[bank] = b;
 			refcount_inc(&b->cpus);
 
 			err = __threshold_add_blocks(b);
@@ -1374,8 +1375,7 @@ static int threshold_create_bank(unsigned int cpu, unsigned int bank)
 	if (err)
 		goto out_kobj;
 
-	per_cpu(threshold_banks, cpu)[bank] = b;
-
+	bp[bank] = b;
 	return 0;
 
 out_kobj:
@@ -1487,35 +1487,33 @@ int mce_threshold_remove_device(unsigned int cpu)
  */
 int mce_threshold_create_device(unsigned int cpu)
 {
-	unsigned int bank;
+	unsigned int numbanks, bank;
 	struct threshold_bank **bp;
 	int err;
 
 	if (!mce_flags.amd_threshold)
 		return 0;
 
-	bp = per_cpu(threshold_banks, cpu);
+	bp = this_cpu_read(threshold_banks);
 	if (bp)
 		return 0;
 
-	bp = kcalloc(per_cpu(mce_num_banks, cpu), sizeof(struct threshold_bank *),
-		     GFP_KERNEL);
+	numbanks = this_cpu_read(mce_num_banks);
+	bp = kcalloc(numbanks, sizeof(*bp), GFP_KERNEL);
 	if (!bp)
 		return -ENOMEM;
 
-	per_cpu(threshold_banks, cpu) = bp;
-
-	for (bank = 0; bank < per_cpu(mce_num_banks, cpu); ++bank) {
-		if (!(per_cpu(bank_map, cpu) & (1 << bank)))
+	for (bank = 0; bank < numbanks; ++bank) {
+		if (!(this_cpu_read(bank_map) & (1 << bank)))
 			continue;
-		err = threshold_create_bank(cpu, bank);
+		err = threshold_create_bank(bp, cpu, bank);
 		if (err)
 			goto out_err;
 	}
+	this_cpu_write(threshold_banks, bp);
 
 	if (thresholding_irq_en)
 		mce_threshold_vector = amd_threshold_interrupt;
-
 	return 0;
 out_err:
 	mce_threshold_remove_device(cpu);
-- 
2.21.0

