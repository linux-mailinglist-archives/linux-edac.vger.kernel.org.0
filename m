Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C14C6C9990
	for <lists+linux-edac@lfdr.de>; Mon, 27 Mar 2023 04:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjC0C1U (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 26 Mar 2023 22:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjC0C1T (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 26 Mar 2023 22:27:19 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A8246AB;
        Sun, 26 Mar 2023 19:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679884038; x=1711420038;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lcJDjZz1f6RIh93Nz0ZXOC3R17pA5JdLExUtChIuXM8=;
  b=lWZC2MFDNtY8K/tRzKD8Nkx5A7msh+d2va+Hk7Jz8pjvoUc19oo8f5YU
   VCmlGEYsw+THxeSaVaTNJFXm561/EIVUAqcco87hYGthLD/wVQBe6spsv
   MlwlYm+g8MsQO1ic9x4orGxxJ8c6Via0iXMAobU+fhfqCDtOOt6gkIvJx
   h1bFEpoDT9YYKTpRiBX7vrPPcSv6jVNa6UZBy0mswTJehaJjC6hkGQtnR
   1DOZEWwBxGEyKuTvs1eDGrtKjc8Nmi2En5dBwKCFXpfShS2SjccpL9q1c
   XScmofmn8Cusu+j4U3uT6W32Mm2kswyfMh5ejd93lSr0y04nJkXtha1JP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="405086196"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="405086196"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 19:27:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="1012925785"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="1012925785"
Received: from zhiquan-linux-dev.bj.intel.com ([10.238.155.101])
  by fmsmga005.fm.intel.com with ESMTP; 26 Mar 2023 19:27:15 -0700
From:   Zhiquan Li <zhiquan1.li@intel.com>
To:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tony.luck@intel.com, naoya.horiguchi@nec.com, bp@alien8.de
Cc:     youquan.song@intel.com, zhiquan1.li@intel.com
Subject: [PATCH v2] x86/mce: Set PG_hwpoison page flag to avoid the capture kernel panic
Date:   Mon, 27 Mar 2023 10:33:58 +0800
Message-Id: <20230327023358.3191922-1-zhiquan1.li@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Kdump can exclude the HWPosion page to avoid touch the error page
again, the prerequisite is the PG_hwpoison page flag is set.
However, for some MCE fatal error cases, there is no opportunity
to queue a task for calling memory_failure(), as a result,
the capture kernel touches the error page again and panics.

Add function mce_set_page_hwpoison_now() which marks a page as
HWPoison before kernel panic() for MCE error, so that the dump
program can check and skip the error page and prevent the capture
kernel panic.

[Tony: Changed TestSetPageHWPoison() to SetPageHWPoison()]

Co-developed-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Zhiquan Li <zhiquan1.li@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>

---

Changes since V1:
- Rebased to latest tip/ras/core (based on v6.3-rc1).
- Revised the commit message as per Naoya's suggestion.
- Removed 'TODO' from comment, as previously discussed, there is nothing
  more to do at this time.
  Link: https://lore.kernel.org/all/20230127015030.30074-1-tony.luck@intel.com/
---
 arch/x86/kernel/cpu/mce/core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 7832a69d170e..dea393ca949b 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -156,6 +156,22 @@ void mce_unregister_decode_chain(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(mce_unregister_decode_chain);
 
+/*
+ * Kdump can exclude the HWPosion page to avoid touch the error page again,
+ * the prerequisite is the PG_hwpoison page flag is set. However, for some
+ * MCE fatal error cases, there are no opportunity to queue a task
+ * for calling memory_failure(), as a result, the capture kernel panics.
+ * This function marks the page as HWPoison before kernel panic() for MCE.
+ */
+static void mce_set_page_hwpoison_now(unsigned long pfn)
+{
+	struct page *p;
+
+	p = pfn_to_online_page(pfn);
+	if (p)
+		SetPageHWPoison(p);
+}
+
 static void __print_mce(struct mce *m)
 {
 	pr_emerg(HW_ERR "CPU %d: Machine Check%s: %Lx Bank %d: %016Lx\n",
@@ -286,6 +302,8 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
 	if (!fake_panic) {
 		if (panic_timeout == 0)
 			panic_timeout = mca_cfg.panic_timeout;
+		if (final && (final->status & MCI_STATUS_ADDRV))
+			mce_set_page_hwpoison_now(final->addr >> PAGE_SHIFT);
 		panic(msg);
 	} else
 		pr_emerg(HW_ERR "Fake kernel panic: %s\n", msg);
-- 
2.25.1

