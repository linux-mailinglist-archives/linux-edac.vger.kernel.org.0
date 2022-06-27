Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAAB755D540
	for <lists+linux-edac@lfdr.de>; Tue, 28 Jun 2022 15:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239955AbiF0Rgi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Jun 2022 13:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239943AbiF0Rgc (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 27 Jun 2022 13:36:32 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD79D11C;
        Mon, 27 Jun 2022 10:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656351391; x=1687887391;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ifbgke9g3cUqAFj1zvxitSnKIjkRzB3Yfahvct9CLGk=;
  b=V/5IA1ThfFeavyUMXOPTdQ364YNNmdumYoEj17MTCE93ZoiHqA4Q57mi
   eItQNoiRIKovHx0/5CMecacRyX9pTqptHq4d55Zbm0I3hPvszAPhZyBug
   qr6PmpPJsIoEzwvzjml83+BOSF9inxG8YZTO0U0E5Quw3cMcLhaB711z+
   bXuKX1zptjRenAvfSrh8ROK/EmSANKKpHReJyxYgrfcwpNXtf3HZyi2QT
   RDWM3bydUqdhWSWGSotS+QvhQD42k/QF+C/BhQZBYeQRVxEsxjqnOlgP6
   XD+YYVyT4zOy2M33MZRVV1bZ8999S4w2Wn1qBS3Tiag0lDV+owztmlwht
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="270262458"
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="270262458"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 10:36:12 -0700
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="594399461"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 10:36:11 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Smita.KoralahalliChannabasappa@amd.com,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, yazen.ghannam@amd.com, patches@lists.linux.dev,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH v2 5/5] x86/mce: Handle AMD threshold interrupt storms
Date:   Mon, 27 Jun 2022 10:36:05 -0700
Message-Id: <20220627173605.514504-6-tony.luck@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220627173605.514504-1-tony.luck@intel.com>
References: <YrFSSZqjtWlm9rUr@agluck-desk3.sc.intel.com>
 <20220627173605.514504-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

Extend the logic of handling CMCI storms to AMD threshold interrupts.

Rely on the similar approach as of Intel's CMCI to mitigate storms per
CPU and per bank. But, unlike CMCI, do not set thresholds and reduce
interrupt rate on a storm. Rather, disable the interrupt on the
corresponding CPU and bank. Re-enable back the interrupts if enough
consecutive polls of the bank show no corrected errors (30, as
programmed by Intel).

Turning off the threshold interrupts would be a better solution on AMD
systems as other error severities will still be handled even if the
threshold interrupts are disabled.

[Tony: Small tweak because mce_handle_storm() isn't a pointer now]

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/amd.c      | 49 ++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/mce/core.c     |  3 ++
 arch/x86/kernel/cpu/mce/internal.h |  2 ++
 3 files changed, 54 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 1c87501e0fa3..b7f92af065e1 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -466,6 +466,47 @@ static void threshold_restart_bank(void *_tr)
 	wrmsr(tr->b->address, lo, hi);
 }
 
+static void _reset_block(struct threshold_block *block)
+{
+	struct thresh_restart tr;
+
+	memset(&tr, 0, sizeof(tr));
+	tr.b = block;
+	threshold_restart_bank(&tr);
+}
+
+static void toggle_interrupt_reset_block(struct threshold_block *block, bool on)
+{
+	if (!block)
+		return;
+
+	block->interrupt_enable = !!on;
+	_reset_block(block);
+}
+
+void mce_amd_handle_storm(int bank, bool on)
+{
+	struct threshold_block *first_block = NULL, *block = NULL, *tmp = NULL;
+	struct threshold_bank **bp = this_cpu_read(threshold_banks);
+	unsigned long flags;
+
+	if (!bp)
+		return;
+
+	local_irq_save(flags);
+
+	first_block = bp[bank]->blocks;
+	if (!first_block)
+		goto end;
+
+	toggle_interrupt_reset_block(first_block, on);
+
+	list_for_each_entry_safe(block, tmp, &first_block->miscj, miscj)
+		toggle_interrupt_reset_block(block, on);
+end:
+	local_irq_restore(flags);
+}
+
 static void mce_threshold_block_init(struct threshold_block *b, int offset)
 {
 	struct thresh_restart tr = {
@@ -867,6 +908,7 @@ static void amd_threshold_interrupt(void)
 	struct threshold_block *first_block = NULL, *block = NULL, *tmp = NULL;
 	struct threshold_bank **bp = this_cpu_read(threshold_banks);
 	unsigned int bank, cpu = smp_processor_id();
+	u64 status;
 
 	/*
 	 * Validate that the threshold bank has been initialized already. The
@@ -880,6 +922,13 @@ static void amd_threshold_interrupt(void)
 		if (!(per_cpu(bank_map, cpu) & (1 << bank)))
 			continue;
 
+		rdmsrl(mca_msr_reg(bank, MCA_STATUS), status);
+		track_cmci_storm(bank, status);
+
+		/* Return early on an interrupt storm */
+		if (this_cpu_read(bank_storm[bank]))
+			return;
+
 		first_block = bp[bank]->blocks;
 		if (!first_block)
 			continue;
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index d27daa199523..6121f0afe45a 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2072,6 +2072,9 @@ void mce_handle_storm(int bank, bool on)
 	case X86_VENDOR_INTEL:
 		mce_intel_handle_storm(bank, on);
 		break;
+	case X86_VENDOR_AMD:
+		mce_amd_handle_storm(bank, on);
+		break;
 	}
 }
 
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index d7cad839a6a9..24b2b1f1bfdc 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -206,7 +206,9 @@ extern bool filter_mce(struct mce *m);
 
 #ifdef CONFIG_X86_MCE_AMD
 extern bool amd_filter_mce(struct mce *m);
+void mce_amd_handle_storm(int bank, bool on);
 #else
+static inline void mce_amd_handle_storm(int bank, bool on) {}
 static inline bool amd_filter_mce(struct mce *m) { return false; }
 #endif
 
-- 
2.35.3

