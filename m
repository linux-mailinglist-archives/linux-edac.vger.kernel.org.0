Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD5D6EBF73
	for <lists+linux-edac@lfdr.de>; Sun, 23 Apr 2023 14:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjDWMbg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 23 Apr 2023 08:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjDWMbf (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 23 Apr 2023 08:31:35 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA54D107;
        Sun, 23 Apr 2023 05:31:33 -0700 (PDT)
Received: from dd-virtual-machine.localdomain ([60.247.94.10])
        (user=u202112092@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33NCTlSE024381-33NCTlSF024381
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sun, 23 Apr 2023 20:30:05 +0800
From:   Ruliang Lin <u202112092@hust.edu.cn>
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Ruliang Lin <u202112092@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>, Borislav Petkov <bp@suse.de>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: ras: cec: return value check of `d`
Date:   Sun, 23 Apr 2023 20:29:32 +0800
Message-Id: <20230423122932.31274-1-u202112092@hust.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: u202112092@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Smatch complains that:
create_debugfs_nodes() warn: 'd' is an error pointer or valid

According to the documentation of the debugfs_create_dir() function, 
there is no need to check the return value of this function.
Just delete the dead code.

Fixes: 011d82611172 ("RAS: Add a Corrected Errors Collector")
Signed-off-by: Ruliang Lin <u202112092@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 drivers/ras/cec.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index 321af498ee11..d2a03f94cbfe 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -483,10 +483,6 @@ static int __init create_debugfs_nodes(void)
 	struct dentry *d, *pfn, *decay, *count, *array;
 
 	d = debugfs_create_dir("cec", ras_debugfs_dir);
-	if (!d) {
-		pr_warn("Error creating cec debugfs node!\n");
-		return -1;
-	}
 
 	decay = debugfs_create_file("decay_interval", S_IRUSR | S_IWUSR, d,
 				    &decay_interval, &decay_interval_ops);
-- 
2.25.1

