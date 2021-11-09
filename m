Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2A944A941
	for <lists+linux-edac@lfdr.de>; Tue,  9 Nov 2021 09:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235527AbhKIIjE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 Nov 2021 03:39:04 -0500
Received: from m15112.mail.126.com ([220.181.15.112]:54318 "EHLO
        m15112.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235325AbhKIIjB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 9 Nov 2021 03:39:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=kla6R
        9K9d3FCT77Y5F5AOks9pVDk12Rh6lbb/BxZbAQ=; b=NRg9h3K8gfc5Ktyaz0v1f
        vYgI8onby/qLJMS86oBHZjZtFOJRqZI+gumdBvvYGYHR1VtyQDrlCUor4wI0b/rK
        hmgIcal9uokbV4xc1+ludXBcOivuQq36imBiAEN38ugJO8zJXrfPL67WXXDlPy6o
        WCdO7y4anANmG6wBqZxBEQ=
Received: from pek-lpd-ccm5.wrs.com (unknown [60.247.85.82])
        by smtp2 (Coremail) with SMTP id DMmowACnon7oMophVTTeBA--.41486S2;
        Tue, 09 Nov 2021 16:36:03 +0800 (CST)
From:   Zhaolong Zhang <zhangzl2013@126.com>
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Zhaolong Zhang <zhangzl2013@126.com>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH] x86/mce: Get rid of cpu_missing
Date:   Tue,  9 Nov 2021 16:35:47 +0800
Message-Id: <20211109083547.3546963-1-zhangzl2013@126.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <776fad3d.3369.17d03d2c2ba.Coremail.zhangzl2013@126.com>
References: <776fad3d.3369.17d03d2c2ba.Coremail.zhangzl2013@126.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMmowACnon7oMophVTTeBA--.41486S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr1DAFWkJF1kJF18Gw15urg_yoW8Xr1xpr
        4qv3WrtF4rZa43Cayqy3Z3Zw18A3s3Ka4xG3y7Cw43Xw13ta43tFZ3Xwn5ZF17u395Gr13
        XFWFqF15KayxJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UZjjkUUUUU=
X-Originating-IP: [60.247.85.82]
X-CM-SenderInfo: x2kd0wt2osiiat6rjloofrz/1tbikhNGz1pEEwILtgAAs6
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Drop cpu_missing since we have more capable mce_missing_cpus.

Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Zhaolong Zhang <zhangzl2013@126.com>
---
 arch/x86/kernel/cpu/mce/core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 50a3e455cded..51aefffe39f1 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -99,7 +99,6 @@ struct mca_config mca_cfg __read_mostly = {
 
 static DEFINE_PER_CPU(struct mce, mces_seen);
 static unsigned long mce_need_notify;
-static int cpu_missing;
 
 /*
  * MCA banks polled by the period polling timer for corrected events.
@@ -314,8 +313,6 @@ static void mce_panic(const char *msg, struct mce *final, char *exp)
 		if (!apei_err)
 			apei_err = apei_write_mce(final);
 	}
-	if (cpu_missing)
-		pr_emerg(HW_ERR "Some CPUs didn't answer in synchronization\n");
 	if (exp)
 		pr_emerg(HW_ERR "Machine check: %s\n", exp);
 	if (!fake_panic) {
@@ -909,7 +906,6 @@ static int mce_timed_out(u64 *t, const char *msg)
 					 cpumask_pr_args(&mce_missing_cpus));
 			mce_panic(msg, NULL, NULL);
 		}
-		cpu_missing = 1;
 		return 1;
 	}
 	*t -= SPINUNIT;
@@ -2720,7 +2716,6 @@ struct dentry *mce_get_debugfs_dir(void)
 
 static void mce_reset(void)
 {
-	cpu_missing = 0;
 	atomic_set(&mce_fake_panicked, 0);
 	atomic_set(&mce_executing, 0);
 	atomic_set(&mce_callin, 0);
-- 
2.27.0

