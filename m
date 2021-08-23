Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 053DD3F5256
	for <lists+linux-edac@lfdr.de>; Mon, 23 Aug 2021 22:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbhHWUmI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 23 Aug 2021 16:42:08 -0400
Received: from mga12.intel.com ([192.55.52.136]:19218 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232503AbhHWUmH (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 23 Aug 2021 16:42:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10085"; a="196753074"
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="196753074"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 13:41:23 -0700
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="535505880"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 13:41:23 -0700
Date:   Mon, 23 Aug 2021 13:41:22 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sumanth Kamatala <skamatala@juniper.net>
Subject: [PATCH v2] x86/mce: Defer processing early errors until
 mcheck_late_init()
Message-ID: <20210823204122.GA1640015@agluck-desk2.amr.corp.intel.com>
References: <20210819224452.1619400-1-tony.luck@intel.com>
 <YR+f/fdGIxWcLTP2@zn.tnic>
 <20210820144314.GA1622759@agluck-desk2.amr.corp.intel.com>
 <YR/Oxark0bhLlona@zn.tnic>
 <20210823184547.GA1638691@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210823184547.GA1638691@agluck-desk2.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

When a fatal machine check results in a system reset, Linux does
not clear the error(s) from machine check bank(s).

Hardware preserves the machine check banks across a warm reset.

During initialization of the kernel after the reboot, Linux reads,
logs, and clears all machine check banks.

But there is a problem. In:
commit 5de97c9f6d85 ("x86/mce: Factor out and deprecate the /dev/mcelog driver")
the call to mce_register_decode_chain() moved later in the boot sequence.
This means that /dev/mcelog doesn't see those early error logs.

This was partially fixed by:
commit cd9c57cad3fe ("x86/MCE: Dump MCE to dmesg if no consumers")

which made sure that the logs were not lost completely by printing
to the console. But parsing console logs is error prone. Users
of /dev/mcelog should expect to find any early errors logged to
standard places.

Delay processing logs until after all built-in code has had a chance
to register on the mce notifier chain (modules are still out of luck,
there's not way to know how long to wait for those to load).

Fixes: 5de97c9f6d85 ("x86/mce: Factor out and deprecate the /dev/mcelog driver")
Reported-by: Sumanth Kamatala <skamatala@juniper.net>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 22791aadc085..593af202f586 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -129,6 +129,8 @@ static void (*quirk_no_way_out)(int bank, struct mce *m, struct pt_regs *regs);
  */
 BLOCKING_NOTIFIER_HEAD(x86_mce_decoder_chain);
 
+static bool mce_init_complete;
+
 /* Do initial initialization of a struct mce */
 noinstr void mce_setup(struct mce *m)
 {
@@ -155,7 +157,7 @@ EXPORT_PER_CPU_SYMBOL_GPL(injectm);
 
 void mce_log(struct mce *m)
 {
-	if (!mce_gen_pool_add(m))
+	if (!mce_gen_pool_add(m) && mce_init_complete)
 		irq_work_queue(&mce_irq_work);
 }
 EXPORT_SYMBOL_GPL(mce_log);
@@ -2771,6 +2773,8 @@ static int __init mcheck_late_init(void)
 
 	mcheck_debugfs_init();
 
+	mce_init_complete = true;
+
 	/*
 	 * Flush out everything that has been logged during early boot, now that
 	 * everything has been initialized (workqueues, decoders, ...).
-- 
2.29.2

