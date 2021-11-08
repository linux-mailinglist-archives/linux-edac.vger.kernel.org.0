Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B990F447C6D
	for <lists+linux-edac@lfdr.de>; Mon,  8 Nov 2021 10:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238302AbhKHJDU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 8 Nov 2021 04:03:20 -0500
Received: from m15112.mail.126.com ([220.181.15.112]:34435 "EHLO
        m15112.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238261AbhKHJDN (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 8 Nov 2021 04:03:13 -0500
X-Greylist: delayed 1813 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Nov 2021 04:03:07 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=262Jf
        JBS5vrrC/6NaXdcXRUKJJ1bSDUknyj66FNj8Yo=; b=MJTRNWE4A8zLrGSMX7AcF
        pe+THu+TXns7Vuth92fik9eUAxUA3w47/SuY9NbAH3dPlwRu4OgF0i2GbI68qwYu
        1vIMeq4pLlPy7B3RXY+fb22dWjFbsC+KphsuuU7H+t07e6SLriDzQv3i7AukX85A
        fKfWANDJFIgFx5/0ND6yrU=
Received: from pek-lpd-ccm5.wrs.com (unknown [60.247.85.82])
        by smtp2 (Coremail) with SMTP id DMmowAAnVt6_34hhJrqvBA--.23324S2;
        Mon, 08 Nov 2021 16:28:54 +0800 (CST)
From:   Zhaolong Zhang <zhangzl2013@126.com>
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Zhaolong Zhang <zhangzl2013@126.com>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH] x86/mce: drop cpu_missing since we have more capable mce_missing_cpus
Date:   Mon,  8 Nov 2021 16:28:32 +0800
Message-Id: <20211108082832.142436-1-zhangzl2013@126.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <572d793c.f2e.17cede4cbf0.Coremail.zhangzl2013@126.com>
References: <572d793c.f2e.17cede4cbf0.Coremail.zhangzl2013@126.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMmowAAnVt6_34hhJrqvBA--.23324S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXw1rXryrWFyDXFW7WFyUWrg_yoW5tF47pa
        1jgw4fXFWrXFy3Ja9xJ3Z7Aw1Fyrn3K3s7GFW7C3y3ZF45tryrKFWSqa45ZFy7C34DCr15
        XF4YgF1jga1DAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UZJ57UUUUU=
X-Originating-IP: [60.247.85.82]
X-CM-SenderInfo: x2kd0wt2osiiat6rjloofrz/1tbiCxlFz1x5fULgpQAAsH
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

move mce_missing_cpus checking into mce_panic() as well, because we don't want
to lose the cpu missing information in case mca_cfg.tolerant > 1 and there is
no_way_out.

Signed-off-by: Zhaolong Zhang <zhangzl2013@126.com>
---
 arch/x86/kernel/cpu/mce/core.c | 38 ++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 50a3e455cded..0bb59e68a457 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -99,7 +99,6 @@ struct mca_config mca_cfg __read_mostly = {
 
 static DEFINE_PER_CPU(struct mce, mces_seen);
 static unsigned long mce_need_notify;
-static int cpu_missing;
 
 /*
  * MCA banks polled by the period polling timer for corrected events.
@@ -253,6 +252,12 @@ static atomic_t mce_panicked;
 static int fake_panic;
 static atomic_t mce_fake_panicked;
 
+/*
+ * Track which CPUs entered the MCA broadcast synchronization and which not in
+ * order to print holdouts.
+ */
+static cpumask_t mce_missing_cpus = CPU_MASK_ALL;
+
 /* Panic in progress. Enable interrupts and wait for final IPI */
 static void wait_for_panic(void)
 {
@@ -314,8 +319,13 @@ static void mce_panic(const char *msg, struct mce *final, char *exp)
 		if (!apei_err)
 			apei_err = apei_write_mce(final);
 	}
-	if (cpu_missing)
-		pr_emerg(HW_ERR "Some CPUs didn't answer in synchronization\n");
+	/*
+	 * cpu_online_mask == &mce_missing_cpus means it is reset and no timeout happens.
+	 */
+	if (!cpumask_equal(cpu_online_mask, &mce_missing_cpus) &&
+	    cpumask_and(&mce_missing_cpus, cpu_online_mask, &mce_missing_cpus))
+		pr_emerg(HW_ERR "CPUs not responding to MCE broadcast (may include false positives): %*pbl\n",
+			 cpumask_pr_args(&mce_missing_cpus));
 	if (exp)
 		pr_emerg(HW_ERR "Machine check: %s\n", exp);
 	if (!fake_panic) {
@@ -880,12 +890,6 @@ static atomic_t mce_executing;
  */
 static atomic_t mce_callin;
 
-/*
- * Track which CPUs entered the MCA broadcast synchronization and which not in
- * order to print holdouts.
- */
-static cpumask_t mce_missing_cpus = CPU_MASK_ALL;
-
 /*
  * Check if a timeout waiting for other CPUs happened.
  */
@@ -904,12 +908,8 @@ static int mce_timed_out(u64 *t, const char *msg)
 		goto out;
 	if ((s64)*t < SPINUNIT) {
 		if (mca_cfg.tolerant <= 1) {
-			if (cpumask_and(&mce_missing_cpus, cpu_online_mask, &mce_missing_cpus))
-				pr_emerg("CPUs not responding to MCE broadcast (may include false positives): %*pbl\n",
-					 cpumask_pr_args(&mce_missing_cpus));
 			mce_panic(msg, NULL, NULL);
 		}
-		cpu_missing = 1;
 		return 1;
 	}
 	*t -= SPINUNIT;
@@ -1079,8 +1079,10 @@ static int mce_end(int order)
 
 	if (!timeout)
 		goto reset;
-	if (order < 0)
+	if (order < 0) {
+		timeout = 0;
 		goto reset;
+	}
 
 	/*
 	 * Allow others to run.
@@ -1128,7 +1130,12 @@ static int mce_end(int order)
 reset:
 	atomic_set(&global_nwo, 0);
 	atomic_set(&mce_callin, 0);
-	cpumask_setall(&mce_missing_cpus);
+	/*
+ 	 * Don't reset mce_missing_cpus if there is mce_timed_out() so that
+ 	 * mce_panic() can report right thing.
+ 	 */
+	if (!((s64)timeout < SPINUNIT))
+		cpumask_setall(&mce_missing_cpus);
 	barrier();
 
 	/*
@@ -2720,7 +2727,6 @@ struct dentry *mce_get_debugfs_dir(void)
 
 static void mce_reset(void)
 {
-	cpu_missing = 0;
 	atomic_set(&mce_fake_panicked, 0);
 	atomic_set(&mce_executing, 0);
 	atomic_set(&mce_callin, 0);
-- 
2.27.0

