Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C695222B33C
	for <lists+linux-edac@lfdr.de>; Thu, 23 Jul 2020 18:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgGWQOK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 Jul 2020 12:14:10 -0400
Received: from mga17.intel.com ([192.55.52.151]:15492 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbgGWQOK (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 23 Jul 2020 12:14:10 -0400
IronPort-SDR: lE4Ge1XMALuqv/iJ+Wyd6Ws2Gn98E9isY5FmyReICy4x0qxleUUXyCXU8udY5KYtNZ065ZuxuJ
 QXbHohQz7RhA==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="130638072"
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; 
   d="scan'208";a="130638072"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 09:14:10 -0700
IronPort-SDR: hSdGVxE6AQ8tvikdKjXnStT0/WntneULyJ9PFHgMkn6qq7qFiUZNVbSkdPUh8duuYKf4mOqT0X
 y6tFGrLNHSrg==
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; 
   d="scan'208";a="488421556"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 09:14:10 -0700
From:   ira.weiny@intel.com
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, Tony Luck <tony.luck@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH] x86: Correct noinstr qualifiers
Date:   Thu, 23 Jul 2020 09:14:05 -0700
Message-Id: <20200723161405.852613-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The noinstr qualifier is to be specified before the return type in the
same way inline is used.

These 2 cases were missed by previous patches.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 arch/x86/kernel/alternative.c  | 2 +-
 arch/x86/kernel/cpu/mce/core.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 20e07feb4064..4b7b980c87df 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1046,7 +1046,7 @@ static __always_inline int patch_cmp(const void *key, const void *elt)
 	return 0;
 }
 
-int noinstr poke_int3_handler(struct pt_regs *regs)
+noinstr int poke_int3_handler(struct pt_regs *regs)
 {
 	struct bp_patching_desc *desc;
 	struct text_poke_loc *tp;
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 1a0139d9a34b..c5204d7bca2b 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1214,7 +1214,7 @@ static void kill_me_maybe(struct callback_head *cb)
  * backing the user stack, tracing that reads the user stack will cause
  * potentially infinite recursion.
  */
-void noinstr do_machine_check(struct pt_regs *regs)
+noinstr void do_machine_check(struct pt_regs *regs)
 {
 	DECLARE_BITMAP(valid_banks, MAX_NR_BANKS);
 	DECLARE_BITMAP(toclear, MAX_NR_BANKS);
-- 
2.25.1

