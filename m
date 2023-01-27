Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534BA67DBFF
	for <lists+linux-edac@lfdr.de>; Fri, 27 Jan 2023 02:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbjA0B6o (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 26 Jan 2023 20:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbjA0B60 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 26 Jan 2023 20:58:26 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F79757A8;
        Thu, 26 Jan 2023 17:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674784364; x=1706320364;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qyfxmzLE5JfhsIee4y1DuROPldIjNhc8I6zB/cwwAS0=;
  b=PkiE5rPB055siIJxO4WCWzQWhUPl5n3+fqk8YeWbHpDaaUk8LBgHrNRn
   Wi+4ghOE1mGDg4Ok/4RxXC+lf341GZF2EpIQZKH+I+djSQo0L6piv33qh
   Gfksc2lhviT5kbe4ZZzx8Vb3ZoubItN3eu1m8+3s/d2q/75dpNuMIzE8l
   c3aY3VLxPAb/wd23DT2W2rGSoeGTF9uNglevglEJ0dEhp4AAdEOxnPr3d
   G7EpJNhwJ32pZcuCm6nfqblBFrbKylCmyqnAUe3OwhP9diHnRJsp5ozpK
   17Yflfhnw2nvjnR606gd8JxRWwze/pVmRlk6XiCW6ILdRZkNAQY8kSfNJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="391553841"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="391553841"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 17:50:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="908503263"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="908503263"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 17:50:39 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Naoya Horiguchi <naoya.horiguchi@nec.com>, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Zhiquan Li <zhiquan1.li@intel.com>,
        Youquan Song <youquan.song@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH] x86/mce: Set PG_hwpoison page flag to avoid the capture kernel panic
Date:   Thu, 26 Jan 2023 17:50:30 -0800
Message-Id: <20230127015030.30074-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Zhiquan Li <zhiquan1.li@intel.com>

Kdump can exclude the HWPosion page to avoid touch the error page
again, the prerequisite is the PG_hwpoison page flag is set.
However, for some MCE fatal error cases, there are no opportunity
to queue a task for calling memory_failure(), as a result,
the capture kernel touches the error page again and panics.

Add function mce_set_page_hwpoison_now() which mark a page as
HWPoison before kernel panic() for MCE error, so that the dump
program can check and skip the error page and prevent the capture
kernel panic.

[Tony: Changed TestSetPageHWPoison() to SetPageHWPoison()]

Co-developedd-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Zhiquan Li <zhiquan1.li@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/core.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 2c8ec5c71712..0630999c6311 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -162,6 +162,24 @@ void mce_unregister_decode_chain(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(mce_unregister_decode_chain);
 
+/*
+ * Kdump can exclude the HWPosion page to avoid touch the error page again,
+ * the prerequisite is the PG_hwpoison page flag is set. However, for some
+ * MCE fatal error cases, there are no opportunity to queue a task
+ * for calling memory_failure(), as a result, the capture kernel panic.
+ * This function mark the page as HWPoison before kernel panic() for MCE.
+ */
+static void mce_set_page_hwpoison_now(unsigned long pfn)
+{
+	struct page *p;
+
+	/* TODO: need to handle other sort of page, like SGX, PMEM and
+	 * HugeTLB pages*/
+	p = pfn_to_online_page(pfn);
+	if (p)
+		SetPageHWPoison(p);
+}
+
 static void __print_mce(struct mce *m)
 {
 	pr_emerg(HW_ERR "CPU %d: Machine Check%s: %Lx Bank %d: %016Lx\n",
@@ -292,6 +310,8 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
 	if (!fake_panic) {
 		if (panic_timeout == 0)
 			panic_timeout = mca_cfg.panic_timeout;
+		if (final && (final->status & MCI_STATUS_ADDRV))
+			 mce_set_page_hwpoison_now(final->addr >> PAGE_SHIFT);
 		panic(msg);
 	} else
 		pr_emerg(HW_ERR "Fake kernel panic: %s\n", msg);
-- 
2.39.1

