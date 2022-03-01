Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6934C8546
	for <lists+linux-edac@lfdr.de>; Tue,  1 Mar 2022 08:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbiCAHeX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 1 Mar 2022 02:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233022AbiCAHeW (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 1 Mar 2022 02:34:22 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752187DE38
        for <linux-edac@vger.kernel.org>; Mon, 28 Feb 2022 23:33:42 -0800 (PST)
Received: from integral2.. (unknown [182.2.70.248])
        by gnuweeb.org (Postfix) with ESMTPSA id 6FA437EDA2;
        Tue,  1 Mar 2022 07:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1646119476;
        bh=oduq7UbWH4yY7hi8T5IT1C8abw9Vor905WGb4sLdUnQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TBp3j/Fqcss/3NXNfLhqpiGq5+F0a9kmmYlsNW76kM7KmCFmclci5SUTGrefVy4hI
         nHCjc50jwNtfVCX20O/xJ6TgHUdOsXLmtoymbV7hlCwZjeplUEUrYqFh9ldjzay1oB
         cXEoeHFXVHtC/fqYGbtYQS4j0PH+q7siofvBQfXlmLTdZJRYc+CuAEDXezp5zwSFQ+
         4YyZz/XcQph1EBDf35eeLE1gvCX9agwvxrUMJUdrMPcFjHq3mNaluHQmEMRTV1DqID
         MbPTqDd8DfVbV6dOPNlNbFpgHI++HPnzTuYTImQIyipG7jhrGgbYt0IuLJ44mesSWE
         P04lgLLNjtOTA==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, gwml@vger.gnuweeb.org,
        x86@kernel.org, stable@vger.kernel.org,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: [PATCH 2/2] x86/mce/amd: Fix memory leak when `threshold_create_bank()` fails
Date:   Tue,  1 Mar 2022 14:23:53 +0700
Message-Id: <20220301072353.95749-3-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220301072353.95749-1-ammarfaizi2@gnuweeb.org>
References: <20220301072353.95749-1-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

@bp is a local variable, calling mce_threshold_remove_device() when
threshold_create_bank() fails will not free the @bp. Note that
mce_threshold_remove_device() frees the @bp only if it's already
stored in the @threshold_banks per-CPU variable.

At that point, the @threshold_banks per-CPU variable is still NULL,
so the mce_threshold_remove_device() will just be a no-op and the
@bp is leaked.

Fix this by calling kfree() and early returning when we fail.

This bug is introduced by commit 6458de97fc15530b544 ("x86/mce/amd:
Straighten CPU hotplug path") [1].

Link: https://lore.kernel.org/all/20200403161943.1458-6-bp@alien8.de [1]

Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Fixes: 6458de97fc15530b54477c4e2b70af653e8ac3d9 ("x86/mce/amd: Straighten CPU hotplug path")
Cc: stable@vger.kernel.org # v5.8+
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 arch/x86/kernel/cpu/mce/amd.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 9f4b508886dd..75d019dfe8d6 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1350,15 +1350,14 @@ int mce_threshold_create_device(unsigned int cpu)
 		if (!(this_cpu_read(bank_map) & (1 << bank)))
 			continue;
 		err = threshold_create_bank(bp, cpu, bank);
-		if (err)
-			goto out_err;
+		if (err) {
+			kfree(bp);
+			return err;
+		}
 	}
 	this_cpu_write(threshold_banks, bp);
 
 	if (thresholding_irq_en)
 		mce_threshold_vector = amd_threshold_interrupt;
 	return 0;
-out_err:
-	mce_threshold_remove_device(cpu);
-	return err;
 }
-- 
2.32.0

