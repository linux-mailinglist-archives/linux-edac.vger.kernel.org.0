Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286AA668A18
	for <lists+linux-edac@lfdr.de>; Fri, 13 Jan 2023 04:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbjAMD2t (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 12 Jan 2023 22:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjAMD2Z (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 12 Jan 2023 22:28:25 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B64E022;
        Thu, 12 Jan 2023 19:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673580504; x=1705116504;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Uys72rmrfV29jwMveE4Atb+fR/9EjYE55FJLCQdgtlo=;
  b=a4v3V7jJJ2FnBYQBaUlI+ml6B3pHKDYuFPO/aUiErzmbPrp6EZPprrvy
   70NJ98MzTMEdo/ak1rQ61OWPkeIwEGBmpMELxPWCPqP3iQda/oZt4W+Bh
   e1nuk7Puivkk0jLxxL1MWWeWsoPbpPGPNoCujPfyvn2UOOdu2uCwZT61Q
   lP5FSIXoZxgKw97V81QgKme++F7VAHcBYjJ/epv0f27hk7Yilcy2tmxO/
   yQZRjegqcGR0OD7jwnLiQDpykXlekPi/npeH0wNvRE7kZnP1gCT3gD0wA
   2oCsGQYaL5BdVBEl510XCcF2v1DmGNjosDdYJXvj8vC5gfxlucQotSHoq
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="410138845"
X-IronPort-AV: E=Sophos;i="5.97,212,1669104000"; 
   d="scan'208";a="410138845"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 19:28:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="651386205"
X-IronPort-AV: E=Sophos;i="5.97,212,1669104000"; 
   d="scan'208";a="651386205"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.105])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 19:28:21 -0800
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Borislav Petkov <bp@alien8.de>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Youquan Song <youquan.song@intel.com>,
        Li Zhang <li4.zhang@intel.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] EDAC/skx_common: Enable EDAC support for the "near" memory
Date:   Fri, 13 Jan 2023 11:27:58 +0800
Message-Id: <20230113032802.41752-2-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230113032802.41752-1-qiuxu.zhuo@intel.com>
References: <20230113032802.41752-1-qiuxu.zhuo@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The current {skx,i10nm}_edac miss the EDAC support to decode errors from
the 1st level memory (the fast "near" memory as cache) of the 2-level
memory system. Introduce a helper function skx_error_in_mem() to check
whether errors are from memory at the beginning of skx_mce_check_error().

As long as the errors are from memory (either the 1-level memory system
or the 2-level memory system), decode the errors.

Reported-and-tested-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/skx_common.c | 18 ++++++++++++------
 drivers/edac/skx_common.h | 24 ++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index f0f8e98f6efb..5fdcb6d5b96b 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -632,12 +632,18 @@ static bool skx_error_in_1st_level_mem(const struct mce *m)
 	if (!skx_mem_cfg_2lm)
 		return false;
 
-	errcode = GET_BITFIELD(m->status, 0, 15);
+	errcode = GET_BITFIELD(m->status, 0, 15) & MCACOD_MEM_ERR_MASK;
 
-	if ((errcode & 0xef80) != 0x280)
-		return false;
+	return errcode == MCACOD_EXT_MEM_ERR;
+}
 
-	return true;
+static bool skx_error_in_mem(const struct mce *m)
+{
+	u32 errcode;
+
+	errcode = GET_BITFIELD(m->status, 0, 15) & MCACOD_MEM_ERR_MASK;
+
+	return (errcode == MCACOD_MEM_CTL_ERR || errcode == MCACOD_EXT_MEM_ERR);
 }
 
 int skx_mce_check_error(struct notifier_block *nb, unsigned long val,
@@ -651,8 +657,8 @@ int skx_mce_check_error(struct notifier_block *nb, unsigned long val,
 	if (mce->kflags & MCE_HANDLED_CEC)
 		return NOTIFY_DONE;
 
-	/* ignore unless this is memory related with an address */
-	if ((mce->status & 0xefff) >> 7 != 1 || !(mce->status & MCI_STATUS_ADDRV))
+	/* Ignore unless this is memory related with an address */
+	if (!skx_error_in_mem(mce) || !(mce->status & MCI_STATUS_ADDRV))
 		return NOTIFY_DONE;
 
 	memset(&res, 0, sizeof(res));
diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index 0cbadd3d2cd3..312032657264 100644
--- a/drivers/edac/skx_common.h
+++ b/drivers/edac/skx_common.h
@@ -56,6 +56,30 @@
 #define MCI_MISC_ECC_MODE(m)	(((m) >> 59) & 15)
 #define MCI_MISC_ECC_DDRT	8	/* read from DDRT */
 
+/*
+ * According to Intel Architecture spec vol 3B,
+ * Table 15-10 "IA32_MCi_Status [15:0] Compound Error Code Encoding"
+ * memory errors should fit one of these masks:
+ *	000f 0000 1mmm cccc (binary)
+ *	000f 0010 1mmm cccc (binary)	[RAM used as cache]
+ * where:
+ *	f = Correction Report Filtering Bit. If 1, subsequent errors
+ *	    won't be shown
+ *	mmm = error type
+ *	cccc = channel
+ */
+#define MCACOD_MEM_ERR_MASK	0xef80
+/*
+ * Errors from either the memory of the 1-level memory system or the
+ * 2nd level memory (the slow "far" memory) of the 2-level memory system.
+ */
+#define MCACOD_MEM_CTL_ERR	0x80
+/*
+ * Errors from the 1st level memory (the fast "near" memory as cache)
+ * of the 2-level memory system.
+ */
+#define MCACOD_EXT_MEM_ERR	0x280
+
 /*
  * Each cpu socket contains some pci devices that provide global
  * information, and also some that are local to each of the two
-- 
2.17.1

