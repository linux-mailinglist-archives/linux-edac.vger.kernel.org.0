Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48EB15E6C0C
	for <lists+linux-edac@lfdr.de>; Thu, 22 Sep 2022 21:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbiIVTv7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 22 Sep 2022 15:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbiIVTvw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 22 Sep 2022 15:51:52 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607BB10C7B0;
        Thu, 22 Sep 2022 12:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663876309; x=1695412309;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l6xuREr5UrI3+dsdLTmENRLQcn+EsoLCovev/Oo8570=;
  b=CQRIm2xoDtsedZhE4oUCcotCrAnFfP27nAjv0GRyN96TOXQd5bNwGnsL
   iAjAP+aiO+AroOcl0pTZRsSzsh8gQqkApc1M7WBDpkkDpgTALdHZnYbv2
   EuOzHfHa2oru1DA3QybrtxkjlrsuoFXx+/qnVdnmdteRX3Xe91+NWtjhW
   kzR85iGVufBLPSBQweYIi3jG5qomBe5vs8WJ+wIJ18ZZIlgURwwMqz9uL
   FA6TV7/j2LXVXpDRS6002rczwDeLWAZ7Je8IwCF6AZ41CMsSWjpgzSk9u
   nLFq0mng+A2OF4GMacaICMvzso4hP69Iqg/7FjipDNVf7MFiF1+ybjkYE
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="280783422"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="280783422"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 12:51:46 -0700
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="622246718"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 12:51:45 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        Carlos Bilbao <carlos.bilbao@amd.com>, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH 2/2] x86/mce: Dump the stack for recoverable machine checks in kernel context
Date:   Thu, 22 Sep 2022 12:51:36 -0700
Message-Id: <20220922195136.54575-3-tony.luck@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220922195136.54575-1-tony.luck@intel.com>
References: <20220922195136.54575-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

It isn't generally useful to dump the stack for a fatal machine check.
The error was detected by hardware when some parity or ECC check failed,
software isn't the problem.

But the kernel now has a few places where it can recover from a machine
check by treating it as an error. E.g. when copying parameters for system
calls from an application.

In order to ease the hunt for additional code flows where machine check
errors can be recovered it is useful to know, for example, why the
kernel was copying a page. Perhaps that code sequence can be modified to
handle machine checks as errors.

Add a new machine check severity value to indicate when a stack dump
may be useful.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/internal.h |  1 +
 arch/x86/kernel/cpu/mce/core.c     | 11 +++++++++--
 arch/x86/kernel/cpu/mce/severity.c |  2 +-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 7e03f5b7f6bd..f03aaff79e39 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -18,6 +18,7 @@ enum severity_level {
 	MCE_UC_SEVERITY,
 	MCE_AR_SEVERITY,
 	MCE_PANIC_SEVERITY,
+	MCE_PANIC_STACKDUMP_SEVERITY,
 };
 
 extern struct blocking_notifier_head x86_mce_decoder_chain;
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 2c8ec5c71712..69ec63eaa625 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -44,6 +44,7 @@
 #include <linux/sync_core.h>
 #include <linux/task_work.h>
 #include <linux/hardirq.h>
+#include <linux/sched/debug.h>
 
 #include <asm/intel-family.h>
 #include <asm/processor.h>
@@ -254,6 +255,9 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
 			wait_for_panic();
 		barrier();
 
+		if (final->severity == MCE_PANIC_STACKDUMP_SEVERITY)
+			show_stack(NULL, NULL, KERN_DEFAULT);
+
 		bust_spinlocks(1);
 		console_verbose();
 	} else {
@@ -864,6 +868,7 @@ static __always_inline int mce_no_way_out(struct mce *m, char **msg, unsigned lo
 					  struct pt_regs *regs)
 {
 	char *tmp = *msg;
+	int severity;
 	int i;
 
 	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
@@ -876,9 +881,11 @@ static __always_inline int mce_no_way_out(struct mce *m, char **msg, unsigned lo
 			quirk_sandybridge_ifu(i, m, regs);
 
 		m->bank = i;
-		if (mce_severity(m, regs, &tmp, true) >= MCE_PANIC_SEVERITY) {
+		severity = mce_severity(m, regs, &tmp, true);
+		if (severity >= MCE_PANIC_SEVERITY) {
 			mce_read_aux(m, i);
 			*msg = tmp;
+			m->severity = severity;
 			return 1;
 		}
 	}
@@ -994,7 +1001,7 @@ static void mce_reign(void)
 	 */
 	if (m && global_worst >= MCE_PANIC_SEVERITY) {
 		/* call mce_severity() to get "msg" for panic */
-		mce_severity(m, NULL, &msg, true);
+		m->severity = mce_severity(m, NULL, &msg, true);
 		mce_panic("Fatal machine check", m, msg);
 	}
 
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index c4477162c07d..89d083c5bd06 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -174,7 +174,7 @@ static struct severity {
 		USER
 		),
 	MCESEV(
-		PANIC, "Data load in unrecoverable area of kernel",
+		PANIC_STACKDUMP, "Data load in unrecoverable area of kernel",
 		SER, MASK(MCI_STATUS_OVER|MCI_UC_SAR|MCI_ADDR|MCACOD, MCI_UC_SAR|MCI_ADDR|MCACOD_DATA),
 		KERNEL
 		),
-- 
2.37.3

