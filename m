Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC2F3F5418
	for <lists+linux-edac@lfdr.de>; Tue, 24 Aug 2021 02:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbhHXAcR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 23 Aug 2021 20:32:17 -0400
Received: from mga14.intel.com ([192.55.52.115]:16110 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233478AbhHXAcO (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 23 Aug 2021 20:32:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10085"; a="216928119"
X-IronPort-AV: E=Sophos;i="5.84,346,1620716400"; 
   d="scan'208";a="216928119"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 17:31:30 -0700
X-IronPort-AV: E=Sophos;i="5.84,346,1620716400"; 
   d="scan'208";a="526371238"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 17:31:30 -0700
Date:   Mon, 23 Aug 2021 17:31:29 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sumanth Kamatala <skamatala@juniper.net>
Subject: [PATCH v3] x86/mce: Defer processing of early errors
Message-ID: <20210824003129.GA1642753@agluck-desk2.amr.corp.intel.com>
References: <20210819224452.1619400-1-tony.luck@intel.com>
 <YR+f/fdGIxWcLTP2@zn.tnic>
 <20210820144314.GA1622759@agluck-desk2.amr.corp.intel.com>
 <YR/Oxark0bhLlona@zn.tnic>
 <20210823184547.GA1638691@agluck-desk2.amr.corp.intel.com>
 <20210823204122.GA1640015@agluck-desk2.amr.corp.intel.com>
 <YSQKT0NPrx6puVUQ@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSQKT0NPrx6puVUQ@zn.tnic>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Borislav Petkov <bp@alien8.de>

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

Add a new flag MCP_QUEUE_LOG to machine_check_poll() to be used
in early machine check initialization to indicate that any errors
found should just be queued to genpool. When mcheck_late_init() is
called it will call mce_schedule_work() to actually log any errors
queued in the genpool

Fixes: 5de97c9f6d85 ("x86/mce: Factor out and deprecate the /dev/mcelog driver")
Reported-by: Sumanth Kamatala <skamatala@juniper.net>
Signed-off-by: Tony Luck <tony.luck@intel.com>

[Boris: Your code (with one name change) my commit log]
---
 arch/x86/include/asm/mce.h     |  1 +
 arch/x86/kernel/cpu/mce/core.c | 11 ++++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 0607ec4f5091..da9321548f6f 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -265,6 +265,7 @@ enum mcp_flags {
 	MCP_TIMESTAMP	= BIT(0),	/* log time stamp */
 	MCP_UC		= BIT(1),	/* log uncorrected errors */
 	MCP_DONTLOG	= BIT(2),	/* only clear, don't log */
+	MCP_QUEUE_LOG	= BIT(3),	/* only queue to genpool */
 };
 bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b);
 
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 22791aadc085..8cb7816d03b4 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -817,7 +817,10 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		if (mca_cfg.dont_log_ce && !mce_usable_address(&m))
 			goto clear_it;
 
-		mce_log(&m);
+		if (flags & MCP_QUEUE_LOG)
+			mce_gen_pool_add(&m);
+		else
+			mce_log(&m);
 
 clear_it:
 		/*
@@ -1639,10 +1642,12 @@ static void __mcheck_cpu_init_generic(void)
 		m_fl = MCP_DONTLOG;
 
 	/*
-	 * Log the machine checks left over from the previous reset.
+	 * Log the machine checks left over from the previous reset. Log them
+	 * only, do not start processing them. That will happen in mcheck_late_init()
+	 * when all consumers have been registered on the notifier chain.
 	 */
 	bitmap_fill(all_banks, MAX_NR_BANKS);
-	machine_check_poll(MCP_UC | m_fl, &all_banks);
+	machine_check_poll(MCP_UC | MCP_QUEUE_LOG | m_fl, &all_banks);
 
 	cr4_set_bits(X86_CR4_MCE);
 
-- 
2.29.2

