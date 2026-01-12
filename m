Return-Path: <linux-edac+bounces-5613-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AE3D114B8
	for <lists+linux-edac@lfdr.de>; Mon, 12 Jan 2026 09:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 35287300B001
	for <lists+linux-edac@lfdr.de>; Mon, 12 Jan 2026 08:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765EA342CA1;
	Mon, 12 Jan 2026 08:44:51 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D17C32A3C1;
	Mon, 12 Jan 2026 08:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768207491; cv=none; b=Fg/OzqnXbZTfp6UYWcMkp37XoLmSRJNH2vBjALDOcTj4F6LPH3K/jP6LFEj6nERDlwSfKbkdB1Cy2ymScx1qnEDgTX4cQikt8z9KN0KpSmPcWWx/V9ywB6m1BJ15UAjEN8XLFMpAkjv5NCrBNG+4ygIK0CiMuUamR5lwWYYgHBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768207491; c=relaxed/simple;
	bh=5EVy7RwKP+ibchlApd6x1IuWM7UWqscc2DnMFXOiUes=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QR+GlP91BtekBeiKZTxkmI8WfzQ7HOx6p6gTUeuiPveyv0CMPd4ROXQiy3FRv31ecUo1HBaQ8X0/UuIxSftTFxzWxghA6yygPRlnwwZLNSZRCo6EmMqZU0ttoIf6X6wOJmjuOce4bD3wtve0aIV2oNKI3YECa21hYDE5ACSMXQs=
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
Subject: [PATCH] x86/mce: Fix timer interval adjustment after logging a MCE event
Date: Mon, 12 Jan 2026 03:27:47 -0500
Message-ID: <20260112082747.2842-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc8.internal.baidu.com (172.31.50.52) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.47
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

Since commit 011d82611172 ("RAS: Add a Corrected Errors Collector"),
mce_notify_irq() in should_enable_timer() always returns false even
when an MCE event is logged, because bit 0 of mce_need_notify is not
set in mce_log. This prevents the timer interval from being properly
adjusted.

Fix this by modifying machine_check_poll() to return a boolean indicating
whether an MCE was logged, and update mc_poll_banks() to propagate this
return value. The timer interval logic in mce_timer_fn() now uses this
return value directly instead of relying on mce_notify_irq().

Fixes: 011d82611172 ("RAS: Add a Corrected Errors Collector")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
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


