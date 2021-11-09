Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C71044AD00
	for <lists+linux-edac@lfdr.de>; Tue,  9 Nov 2021 12:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235632AbhKIL6Y (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 Nov 2021 06:58:24 -0500
Received: from m15113.mail.126.com ([220.181.15.113]:41509 "EHLO
        m15113.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbhKIL6Y (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 9 Nov 2021 06:58:24 -0500
X-Greylist: delayed 1867 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Nov 2021 06:58:22 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=drvET
        QHtBlVmidIFH+pwHevafCVpVnSh4McXssVOrug=; b=XEy3NKQjowaGMZ9CCSZzo
        q+mHdIC8zFFHObLWSo+IpMLZ5MBVaVnhQyHKIHTZBmZG9PoTliN5AQhLe5u1uq7T
        0JIsHJArV50occJxfWGlUtDHjq2xD77S3Kcs7KpGAITjPW2MIE6n1OyTj5CdRtn7
        lJX+m2oc5MGE5nDxGl327g=
Received: from pek-lpd-ccm5.wrs.com (unknown [60.247.85.82])
        by smtp3 (Coremail) with SMTP id DcmowABnbAxWWophAXRpCg--.49860S2;
        Tue, 09 Nov 2021 19:24:11 +0800 (CST)
From:   Zhaolong Zhang <zhangzl2013@126.com>
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Zhaolong Zhang <zhangzl2013@126.com>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2] x86/mce: Get rid of cpu_missing
Date:   Tue,  9 Nov 2021 19:23:45 +0800
Message-Id: <20211109112345.2673403-1-zhangzl2013@126.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcmowABnbAxWWophAXRpCg--.49860S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur4kCFykXFWDur17Wr17ZFb_yoW8Wr18pr
        4v93WrJF4rZa4fCa9Fy3Z3Z348Awn3Ka4xGw47Cw43X3W3t347tFZ3Xw1fZF17u395Gr13
        XFWFqF1UKa18taDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UZAw3UUUUU=
X-Originating-IP: [60.247.85.82]
X-CM-SenderInfo: x2kd0wt2osiiat6rjloofrz/1tbiCxdGz1x5fU24kgAAsq
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Get rid of cpu_missing because commit 7bb39313cd62 ("x86/mce: Make
mce_timed_out() identify holdout CPUs") has provided a more detailed
message about which CPUs are missing.

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

