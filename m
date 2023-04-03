Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53EBC6D5314
	for <lists+linux-edac@lfdr.de>; Mon,  3 Apr 2023 23:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbjDCVHv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 3 Apr 2023 17:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbjDCVHm (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 3 Apr 2023 17:07:42 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9FD3C05;
        Mon,  3 Apr 2023 14:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680556059; x=1712092059;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fYZQDLM69ukAcHy2Lr4F4fSjXY8oE5A3ji5UAJN5ox0=;
  b=gBOGNkCCPAPog4kGKFKj1upDW1HyYKmeqTN0FRfJhuSq+P/D7tozxPJ2
   MEi2sRxTz9yT8kxChqcLjXlSW+CODRV7A76UrMaNR19dG1w8oEqpOb6Ic
   XUq1QjK3rT9ZE3GaqC3xpUfZuUUsRZg13n6y+32mtZLpFtjsS76jGOQ5O
   CqaPDkfCa/qVgsyFzWlEeN4YGOs0DsstRD34xH5RJX07TEKuoMEeNsBh+
   00kDFm8516HM8uLnCgJcT8bbtTpX7SHKiGIN7WiYQ7e20HRvN3xVPeaaW
   nDSrxkq/YDK0T689hZST91QjsOndMdQ6yalM3J5/HY9tPtnBxeA0ROiK1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="330590869"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="330590869"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 14:07:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="775354456"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="775354456"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 14:07:25 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita.KoralahalliChannabasappa@amd.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>
Subject: [PATCH v4 3/5] x86/mce: Introduce mce_handle_storm() to deal with begin/end of storms
Date:   Mon,  3 Apr 2023 14:07:14 -0700
Message-Id: <20230403210716.347773-4-tony.luck@intel.com>
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

Intel and AMD need to take different actions when a storm begins or
ends. Prepare for the storm code moving from intel.c into core.c by
adding a function that checks CPU vendor to pick the right action.

No functional changes.

[Tony: Changed from function pointer to regular function]

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Tested-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/internal.h |  3 +++
 arch/x86/kernel/cpu/mce/core.c     |  9 +++++++++
 arch/x86/kernel/cpu/mce/intel.c    | 12 ++++++++++--
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 8d3a740a66ff..68288099b125 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -43,12 +43,14 @@ extern mce_banks_t mce_banks_ce_disabled;
 void track_cmci_storm(int bank, u64 status);
 
 #ifdef CONFIG_X86_MCE_INTEL
+void mce_intel_handle_storm(int bank, bool on);
 void cmci_disable_bank(int bank);
 void intel_init_cmci(void);
 void intel_init_lmce(void);
 void intel_clear_lmce(void);
 bool intel_filter_mce(struct mce *m);
 #else
+static inline void mce_intel_handle_storm(int bank, bool on) { }
 static inline void cmci_disable_bank(int bank) { }
 static inline void intel_init_cmci(void) { }
 static inline void intel_init_lmce(void) { }
@@ -57,6 +59,7 @@ static inline bool intel_filter_mce(struct mce *m) { return false; }
 #endif
 
 void mce_timer_kick(bool storm);
+void mce_handle_storm(int bank, bool on);
 
 #ifdef CONFIG_ACPI_APEI
 int apei_write_mce(struct mce *m);
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 20347eb65b8b..099d8444aca4 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1975,6 +1975,15 @@ static void mce_zhaoxin_feature_clear(struct cpuinfo_x86 *c)
 	intel_clear_lmce();
 }
 
+void mce_handle_storm(int bank, bool on)
+{
+	switch (boot_cpu_data.x86_vendor) {
+	case X86_VENDOR_INTEL:
+		mce_intel_handle_storm(bank, on);
+		break;
+	}
+}
+
 static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
 {
 	switch (c->x86_vendor) {
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index 4106877de028..a8248514a689 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -152,6 +152,14 @@ static void cmci_set_threshold(int bank, int thresh)
 	raw_spin_unlock_irqrestore(&cmci_discover_lock, flags);
 }
 
+void mce_intel_handle_storm(int bank, bool on)
+{
+	if (on)
+		cmci_set_threshold(bank, CMCI_STORM_THRESHOLD);
+	else
+		cmci_set_threshold(bank, cmci_threshold[bank]);
+}
+
 static void cmci_storm_begin(int bank)
 {
 	__set_bit(bank, this_cpu_ptr(mce_poll_banks));
@@ -211,13 +219,13 @@ void track_cmci_storm(int bank, u64 status)
 		if (history & GENMASK_ULL(STORM_END_POLL_THRESHOLD - 1, 0))
 			return;
 		pr_notice("CPU%d BANK%d CMCI storm subsided\n", smp_processor_id(), bank);
-		cmci_set_threshold(bank, cmci_threshold[bank]);
+		mce_handle_storm(bank, false);
 		cmci_storm_end(bank);
 	} else {
 		if (hweight64(history) < STORM_BEGIN_THRESHOLD)
 			return;
 		pr_notice("CPU%d BANK%d CMCI storm detected\n", smp_processor_id(), bank);
-		cmci_set_threshold(bank, CMCI_STORM_THRESHOLD);
+		mce_handle_storm(bank, true);
 		cmci_storm_begin(bank);
 	}
 }
-- 
2.39.2

