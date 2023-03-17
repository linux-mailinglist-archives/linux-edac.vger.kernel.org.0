Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB316BEF7D
	for <lists+linux-edac@lfdr.de>; Fri, 17 Mar 2023 18:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjCQRU6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 17 Mar 2023 13:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjCQRU4 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 17 Mar 2023 13:20:56 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055DEE1932;
        Fri, 17 Mar 2023 10:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679073655; x=1710609655;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0Wc15XvGPYvMWlCpfijnuc/A02oVk5g5vpSMND9b7J8=;
  b=PAssDW64sHnuDPLfjKJc9dU4kNNAYq/uDdHpBrAs09o0CDtBMJe3TBg+
   pEVuhhFNhYeP3jSHtXVrhSehFGrh3co3hOnjtBUY2HjiXpFLaN7k8L3Uu
   lIDfIzG41cAS9sNgwIO+hFLx95eDVlF8YQL6utPpv6IXQ94jWneQNhFAG
   K2MW++6X2ubRtT7ScATvKg9VPih5iZG4BrDPoFpn5/swI8SA/fFcpI3Kn
   Gs4wkscI/9VtgW/DISsiM5BLxl1K9QO5GaUAg+09A1msypB51Nnah0wLc
   nUKSZPiArPnsjYRccI3UhGqay8roprgGAbYEqFVHFX/9hoPs6TDW3+gvh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="339858233"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="339858233"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 10:20:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="804166607"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="804166607"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 10:20:49 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Smita.KoralahalliChannabasappa@amd.com,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, patches@lists.linux.dev,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 3/5] x86/mce: Introduce mce_handle_storm() to deal with begin/end of storms
Date:   Fri, 17 Mar 2023 10:20:40 -0700
Message-Id: <20230317172042.117201-4-tony.luck@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317172042.117201-1-tony.luck@intel.com>
References: <ZBR+GMH0olGoDMGs@yaz-fattaah>
 <20230317172042.117201-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
---
 arch/x86/kernel/cpu/mce/internal.h |  3 +++
 arch/x86/kernel/cpu/mce/core.c     |  9 +++++++++
 arch/x86/kernel/cpu/mce/intel.c    | 12 ++++++++++--
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 72fbec8f6c3c..f37816b4d4cf 100644
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
index 776d4724b1e0..f4d2a7ba29f7 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1985,6 +1985,15 @@ static void mce_zhaoxin_feature_clear(struct cpuinfo_x86 *c)
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
index 4106877de028..4238b73c2143 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -152,6 +152,14 @@ static void cmci_set_threshold(int bank, int thresh)
 	raw_spin_unlock_irqrestore(&cmci_discover_lock, flags);
 }
 
+void mce_intel_handle_storm(int bank, bool on)
+{
+	if (on)
+		cmci_set_threshold(bank, cmci_threshold[bank]);
+	else
+		cmci_set_threshold(bank, CMCI_STORM_THRESHOLD);
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
+		mce_handle_storm(bank, true);
 		cmci_storm_end(bank);
 	} else {
 		if (hweight64(history) < STORM_BEGIN_THRESHOLD)
 			return;
 		pr_notice("CPU%d BANK%d CMCI storm detected\n", smp_processor_id(), bank);
-		cmci_set_threshold(bank, CMCI_STORM_THRESHOLD);
+		mce_handle_storm(bank, false);
 		cmci_storm_begin(bank);
 	}
 }
-- 
2.39.2

