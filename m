Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA106D5311
	for <lists+linux-edac@lfdr.de>; Mon,  3 Apr 2023 23:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbjDCVHp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 3 Apr 2023 17:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbjDCVHl (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 3 Apr 2023 17:07:41 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3819F1BD0;
        Mon,  3 Apr 2023 14:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680556055; x=1712092055;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+YKvwuyVLDMR+sFs/3u3SFfneQIZ0qZ0jxgoSlbNg60=;
  b=Tkfw2IlO125v9nJbpsh999w7xg4ys5Oe0wtu5whib+FCinOvVjmitfxz
   WiBcOCxhrLlDa+96DdlvFnmVeohPsTf1HUi9Bmvaz+KEdPArvOeerjBfl
   yDaTYWdU7VBSbT1lwwLtwQ4UyskuS7Wevmz4xYzEq5Ymo/Y0601FyfoHV
   dn4+fHnK9xa2aYNCyaMm1KroeSyk+cSwNr/jm8Uc1qA/etVZjbVWP9wPR
   rGLpjENesKwe7fsO7tBk6X9V9uHQmrXcKUDutoqr29IwfatrfWGcSIWIk
   Iu96+c4Md56DbbXDrEDhTnntf3AkkWcOiR0nglWjvuyV+2ZJWanMEBgWc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="330590865"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="330590865"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 14:07:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="775354462"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="775354462"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 14:07:25 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita.KoralahalliChannabasappa@amd.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>
Subject: [PATCH v4 5/5] x86/mce: Handle AMD threshold interrupt storms
Date:   Mon,  3 Apr 2023 14:07:16 -0700
Message-Id: <20230403210716.347773-6-tony.luck@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230403210716.347773-1-tony.luck@intel.com>
References: <ZCRYl9c7xgIJ+pJe@yaz-sghr>
 <20230403210716.347773-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Tested-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/internal.h |  2 ++
 arch/x86/kernel/cpu/mce/amd.c      | 49 ++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/mce/core.c     |  3 ++
 3 files changed, 54 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index d052d80cce7a..f1a48bc2e904 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -224,6 +224,7 @@ extern bool filter_mce(struct mce *m);
 
 #ifdef CONFIG_X86_MCE_AMD
 extern bool amd_filter_mce(struct mce *m);
+void mce_amd_handle_storm(int bank, bool on);
 
 /*
  * If MCA_CONFIG[McaLsbInStatusSupported] is set, extract ErrAddr in bits
@@ -251,6 +252,7 @@ static __always_inline void smca_extract_err_addr(struct mce *m)
 
 #else
 static inline bool amd_filter_mce(struct mce *m) { return false; }
+static inline void mce_amd_handle_storm(int bank, bool on) {}
 static inline void smca_extract_err_addr(struct mce *m) { }
 #endif
 
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 23c5072fbbb7..cd79295e2a0a 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -468,6 +468,47 @@ static void threshold_restart_bank(void *_tr)
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
@@ -868,6 +909,7 @@ static void amd_threshold_interrupt(void)
 	struct threshold_block *first_block = NULL, *block = NULL, *tmp = NULL;
 	struct threshold_bank **bp = this_cpu_read(threshold_banks);
 	unsigned int bank, cpu = smp_processor_id();
+	u64 status;
 
 	/*
 	 * Validate that the threshold bank has been initialized already. The
@@ -881,6 +923,13 @@ static void amd_threshold_interrupt(void)
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
index 820b317b1b85..fac90625d8cb 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2062,6 +2062,9 @@ void mce_handle_storm(int bank, bool on)
 	case X86_VENDOR_INTEL:
 		mce_intel_handle_storm(bank, on);
 		break;
+	case X86_VENDOR_AMD:
+		mce_amd_handle_storm(bank, on);
+		break;
 	}
 }
 
-- 
2.39.2

