Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3406DE2BB
	for <lists+linux-edac@lfdr.de>; Tue, 11 Apr 2023 19:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjDKRjA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 11 Apr 2023 13:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjDKRi6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 11 Apr 2023 13:38:58 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01F059D6;
        Tue, 11 Apr 2023 10:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681234736; x=1712770736;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zqIINf2SdOOj76FIcmTUsOgOIqBQ4QV0I3zT4pV/9SI=;
  b=Gb9Es2E2lPyS3eAuvPItHY2Voalmwj/s/7qT20kJ+nCUlN6Z/1Cf/dC1
   7whHYfbwqPNB3aatZpMfkQ5/EaVgXKR0VJJjlWlpBhZ/Y3FjqI5EizAAM
   TOF0OJgLqrxM8th8xLlSmoy/2uSefEybikhcqDTZWNKGNCfDK/7hT4pFV
   WBkjNFI879IgMvPg0aX3AD8xBdzzqkumIZ82Fd8Kwv9wmu/wnSRvgcxkC
   4TUJkR0nc7+ylJGIuDXANLbxGAlOEAaxD3tCWRFDLFUQtULH5AT3reQ/D
   Y4ZYw9AH042AVmoSe+/ENBI+ZK8AJKtxi9vmMftbbko3v/Z8rVX3IUdoo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="346359968"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="346359968"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 10:38:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="638911765"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="638911765"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 10:38:54 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita.KoralahalliChannabasappa@amd.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>
Subject: [PATCH v5 3/5] x86/mce: Introduce mce_handle_storm() to deal with begin/end of storms
Date:   Tue, 11 Apr 2023 10:38:39 -0700
Message-Id: <20230411173841.70491-4-tony.luck@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411173841.70491-1-tony.luck@intel.com>
References: <20230403210716.347773-1-tony.luck@intel.com>
 <20230411173841.70491-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
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
index 1e8e0706a4e8..e0d76378c116 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -41,6 +41,7 @@ struct dentry *mce_get_debugfs_dir(void);
 extern mce_banks_t mce_banks_ce_disabled;
 
 #ifdef CONFIG_X86_MCE_INTEL
+void mce_intel_handle_storm(int bank, bool on);
 void cmci_disable_bank(int bank);
 void intel_init_cmci(void);
 void intel_init_lmce(void);
@@ -48,6 +49,7 @@ void intel_clear_lmce(void);
 bool intel_filter_mce(struct mce *m);
 void track_cmci_storm(int bank, u64 status);
 #else
+static inline void mce_intel_handle_storm(int bank, bool on) { }
 static inline void cmci_disable_bank(int bank) { }
 static inline void intel_init_cmci(void) { }
 static inline void intel_init_lmce(void) { }
@@ -57,6 +59,7 @@ static inline void track_cmci_storm(int bank, u64 status) { }
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

