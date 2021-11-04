Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F223445001
	for <lists+linux-edac@lfdr.de>; Thu,  4 Nov 2021 09:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhKDIS4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 4 Nov 2021 04:18:56 -0400
Received: from m15114.mail.126.com ([220.181.15.114]:50282 "EHLO
        m15114.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhKDIS4 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 4 Nov 2021 04:18:56 -0400
X-Greylist: delayed 1812 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Nov 2021 04:18:53 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=pAMgP
        U5O60xaFOyhRL1qBr0mrX5w3vzc+YINRhtl3Dk=; b=WLPMpHzxQ6UQ2dp1iWFF0
        FjeEs9mlWcSksQyOr6j3G8B444+hKKUOcS+5PIUaHpMFiVDd2QMq0Ee08fq2ysnE
        hbLHua6Kf8iNg147yhM2OAEKNLgqRKVydMauNZB6bKEJolABqlV2UfiaJo1MARAv
        wdt4MyCMONY5VKHPHkzIFc=
Received: from pek-lpd-ccm5.wrs.com (unknown [60.247.85.82])
        by smtp7 (Coremail) with SMTP id DsmowADHDk+Pj4NhZAinWw--.41518S2;
        Thu, 04 Nov 2021 15:45:37 +0800 (CST)
From:   Zhaolong Zhang <zhangzl2013@126.com>
To:     Zhaolong Zhang <zhangzl2013@126.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/mce: correct cpu_missing reporting in mce_timed_out
Date:   Thu,  4 Nov 2021 15:44:31 +0800
Message-Id: <20211104074431.1091525-1-zhangzl2013@126.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsmowADHDk+Pj4NhZAinWw--.41518S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw15GrWkAFyUXF47ZFy3XFb_yoWfZwcEgw
        n3tw4jkr4fXFy29wnrJa1jqr12qa4SyFsYvw4fta4YyFyqqFWDua1YkFy3AFn3K34rJrW8
        ZrZ5Ar4vvw4j9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbZYw5UUUUU==
X-Originating-IP: [60.247.85.82]
X-CM-SenderInfo: x2kd0wt2osiiat6rjloofrz/1tbi4wFBz1pD-dKMJwAAsx
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

set cpu_missing before mce_panic() so that it prints correct msg.

Signed-off-by: Zhaolong Zhang <zhangzl2013@126.com>
---
 arch/x86/kernel/cpu/mce/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 50a3e455cded..ccefe131ab55 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -903,13 +903,13 @@ static int mce_timed_out(u64 *t, const char *msg)
 	if (!mca_cfg.monarch_timeout)
 		goto out;
 	if ((s64)*t < SPINUNIT) {
+		cpu_missing = 1;
 		if (mca_cfg.tolerant <= 1) {
 			if (cpumask_and(&mce_missing_cpus, cpu_online_mask, &mce_missing_cpus))
 				pr_emerg("CPUs not responding to MCE broadcast (may include false positives): %*pbl\n",
 					 cpumask_pr_args(&mce_missing_cpus));
 			mce_panic(msg, NULL, NULL);
 		}
-		cpu_missing = 1;
 		return 1;
 	}
 	*t -= SPINUNIT;
-- 
2.27.0

