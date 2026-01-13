Return-Path: <linux-edac+bounces-5619-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E6ED16F25
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jan 2026 08:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBD293008EB6
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jan 2026 07:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A848130FF21;
	Tue, 13 Jan 2026 07:07:05 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92ABA30DD3F;
	Tue, 13 Jan 2026 07:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768288025; cv=none; b=RJTlWtoLCbN0u1WPlN6gOfQ2QAnIpfI1Xv3D8kWagxAKBTmXEhC46J70GzwbLB5XtiP7InItKgN85mRUHJkgTAiyEb/7O+wWD6sDE6RoSFR2AsrSHSsp/e8LdVJ6CgrHVkgs2Rj6w+Vr/ejIFLIeg4j8PfGajzMS/kC7zCwYLb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768288025; c=relaxed/simple;
	bh=KaSHI9GJXeVkWsBtXAyaYoN5/t0hvWpASY+sZ1Q4cZE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=txwHHShqA9MdEm5NGsCECCGjrxNlwc0wf6niFTLi68akRgDUKgXBTqmNcUsZVfD59o9QWF2WI1rVoESz4ffzc70RCq0vxos0CiQtnOxM4oh9TlrIck+l2QKUklVmA8pso4mCcWA9vZqzHCSNczgSbpAgVkISaR33Hm+6+hw5fvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Tony Luck
	<tony.luck@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>, Nikolay Borisov
	<nik.borisov@suse.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Avadhut Naik
	<avadhut.naik@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [v2 PATCH] x86/mce: Fix timer interval adjustment after logging a MCE event
Date: Tue, 13 Jan 2026 02:05:06 -0500
Message-ID: <20260113070506.2273-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc3.internal.baidu.com (172.31.3.13) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.47
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

Since commit 011d82611172 ("RAS: Add a Corrected Errors Collector"),
mce_timer_fn() has incorrectly determined whether to adjust the
timer interval. The issue arises because mce_notify_irq() now always
returns false when called from the timer path, since the polling code
never sets bit 0 of mce_need_notify. This prevents proper adjustment of
the timer interval based on whether MCE events were logged.

The mce_notify_irq() is called from two contexts:
1. Early notifier block - correctly sets mce_need_notify
2. Timer function - never sets mce_need_notify, making it a noop
   (though logged errors are still processed through mce_log()->
    x86_mce_decoder_chain -> early notifier).

Fix this by modifying machine_check_poll() to return a boolean indicating
whether any MCE was logged, and updating mc_poll_banks() and related
functions to propagate this return value. Then, mce_timer_fn() can use
this direct return value instead of relying on mce_notify_irq() for
timer interval decisions.

This ensures the timer interval is correctly reduced when MCE events are
logged and increased when no events occur.

Fixes: 011d82611172 ("RAS: Add a Corrected Errors Collector")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
Diff with v1: rewrite commit message

 arch/x86/include/asm/mce.h         |  2 +-
 arch/x86/kernel/cpu/mce/core.c     | 17 +++++++++++------
 arch/x86/kernel/cpu/mce/intel.c    |  8 ++++++--
 arch/x86/kernel/cpu/mce/internal.h |  2 +-
 4 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 2d98886..fb9eab4 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -303,7 +303,7 @@ enum mcp_flags {
 	MCP_QUEUE_LOG	= BIT(2),	/* only queue to genpool */
 };
 
-void machine_check_poll(enum mcp_flags flags, mce_banks_t *b);
+bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b);
 
 DECLARE_PER_CPU(struct mce, injectm);
 
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 3444002..8d42691 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -813,10 +813,11 @@ static void clear_bank(struct mce *m)
  * is already totally * confused. In this case it's likely it will
  * not fully execute the machine check handler either.
  */
-void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
+bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 {
 	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
 	struct mce_hw_err err;
+	bool logged = false;
 	struct mce *m;
 	int i;
 
@@ -868,6 +869,7 @@ void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		else
 			mce_log(&err);
 
+		logged = true;
 clear_it:
 		clear_bank(m);
 	}
@@ -878,6 +880,8 @@ void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 	 */
 
 	sync_core();
+
+	return logged;
 }
 EXPORT_SYMBOL_GPL(machine_check_poll);
 
@@ -1776,12 +1780,12 @@ static void __start_timer(struct timer_list *t, unsigned long interval)
 	local_irq_restore(flags);
 }
 
-static void mc_poll_banks_default(void)
+static bool mc_poll_banks_default(void)
 {
-	machine_check_poll(0, this_cpu_ptr(&mce_poll_banks));
+	return machine_check_poll(0, this_cpu_ptr(&mce_poll_banks));
 }
 
-void (*mc_poll_banks)(void) = mc_poll_banks_default;
+bool (*mc_poll_banks)(void) = mc_poll_banks_default;
 
 static bool should_enable_timer(unsigned long iv)
 {
@@ -1792,19 +1796,20 @@ static void mce_timer_fn(struct timer_list *t)
 {
 	struct timer_list *cpu_t = this_cpu_ptr(&mce_timer);
 	unsigned long iv;
+	bool logged = false;
 
 	WARN_ON(cpu_t != t);
 
 	iv = __this_cpu_read(mce_next_interval);
 
 	if (mce_available(this_cpu_ptr(&cpu_info)))
-		mc_poll_banks();
+		logged = mc_poll_banks();
 
 	/*
 	 * Alert userspace if needed. If we logged an MCE, reduce the polling
 	 * interval, otherwise increase the polling interval.
 	 */
-	if (mce_notify_irq())
+	if (logged)
 		iv = max(iv / 2, (unsigned long) HZ/100);
 	else
 		iv = min(iv * 2, round_jiffies_relative(check_interval * HZ));
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index 4655223..a3d2730 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -395,11 +395,15 @@ void cmci_disable_bank(int bank)
 }
 
 /* Bank polling function when CMCI is disabled. */
-static void cmci_mc_poll_banks(void)
+static bool cmci_mc_poll_banks(void)
 {
+	bool logged;
+
 	spin_lock(&cmci_poll_lock);
-	machine_check_poll(0, this_cpu_ptr(&mce_poll_banks));
+	logged = machine_check_poll(0, this_cpu_ptr(&mce_poll_banks));
 	spin_unlock(&cmci_poll_lock);
+
+	return logged;
 }
 
 void intel_init_cmci(void)
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index a31cf98..7bf2360 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -348,5 +348,5 @@ static __always_inline u32 mca_msr_reg(int bank, enum mca_msr reg)
 	return 0;
 }
 
-extern void (*mc_poll_banks)(void);
+extern bool (*mc_poll_banks)(void);
 #endif /* __X86_MCE_INTERNAL_H__ */
-- 
2.9.4


