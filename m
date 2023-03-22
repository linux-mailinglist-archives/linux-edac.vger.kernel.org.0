Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDB46C3F58
	for <lists+linux-edac@lfdr.de>; Wed, 22 Mar 2023 01:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjCVAvs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 21 Mar 2023 20:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjCVAvr (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 21 Mar 2023 20:51:47 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0ECB591CF;
        Tue, 21 Mar 2023 17:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679446303; x=1710982303;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B9PpiLYBjsH8WiDosu/yBXR5Y3A1fdmmZghUTR96/7g=;
  b=gf7Baxq7u4q4TtX0d+PTk8M05FMh6kUXSGBnZl9CcTlcdlku9h7EdG9U
   byCUF913qc3N/AdsQkfliKCThp3hDrPQgw3Z0AzDmd1sODWGOwAZwYmNi
   VVYLX4kaoBR1LVTYDIw5wiJmj/yyM87nGdYkVBYpJCxQBBWuRLa1urC5n
   HoOSMjIW5y2Q2zwIyBdB5kl3T/2Vj0ULCr/mZBYK+Esho2kmmIW4zZYRG
   mfsOCOoIcCeG85F3zbCbiiJXEvDbLMGJxNCPSEFDaugZDy1qEKP16AS4k
   AGnmLyPWbUDUenZdbKIh8Nu5G4yj03MA/xLQFYPeiJemLgRo7yomDJ+oK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="336602269"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="336602269"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 17:51:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="681711889"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="681711889"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 17:51:41 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, patches@lists.linux.dev,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH] x86/mce: Check that memory address is usable for recovery
Date:   Tue, 21 Mar 2023 17:51:31 -0700
Message-Id: <20230322005131.174499-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

uc_decode_notifier() includes a check that "struct mce"
contains a valid address for recovery. But the machine
check recovery code does not include a similar check.

Use mce_usable_address() to check that there is a valid
address.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 2eec60f50057..fa28b3f7d945 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1533,7 +1533,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		/* If this triggers there is no way to recover. Die hard. */
 		BUG_ON(!on_thread_stack() || !user_mode(regs));
 
-		if (kill_current_task)
+		if (kill_current_task || !mce_usable_address(&m))
 			queue_task_work(&m, msg, kill_me_now);
 		else
 			queue_task_work(&m, msg, kill_me_maybe);
-- 
2.39.2

