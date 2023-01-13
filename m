Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1523C668A1B
	for <lists+linux-edac@lfdr.de>; Fri, 13 Jan 2023 04:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjAMD24 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 12 Jan 2023 22:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbjAMD23 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 12 Jan 2023 22:28:29 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0586E0BE;
        Thu, 12 Jan 2023 19:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673580506; x=1705116506;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=YeWtQNX9AjCiNG5++5pmYcJReh+RFVKd/BHotyPMTjI=;
  b=WPT6mayHy9giJFd6osnyB0Ar0x+L4R2TIF9Qn/VSXPV+Ka8ZqgHIEA9l
   RBakir8I0u3R3P4FsieNggtYeNW07/w0I2fB1FPtOUU6FW3AEW3YNZ2ui
   FOVYXAdHuV9rpolBLPpuSsnc/q04cYF8NonNiDEVW1tvPTChVuCdK5dz6
   LceJ5v+SZj/7T2wbcw2Jla6plQriNldj3UbepzcMCZFDOPRN23UgSyNUc
   iY5rMmCo2pAD6a/Qsvnxnd6mFKvvenHI4ndCpe+W0l/EMKluxZ8v5gh0G
   0kyh/9jwoOcInfZo2I8VabqlRX2QSH7FNUoZWT6741D6KMTLQOfIGa/lS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="410138852"
X-IronPort-AV: E=Sophos;i="5.97,212,1669104000"; 
   d="scan'208";a="410138852"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 19:28:26 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="651386218"
X-IronPort-AV: E=Sophos;i="5.97,212,1669104000"; 
   d="scan'208";a="651386218"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.105])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 19:28:23 -0800
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Borislav Petkov <bp@alien8.de>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Youquan Song <youquan.song@intel.com>,
        Li Zhang <li4.zhang@intel.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] EDAC/skx_common: Delete duplicated and unreachable code
Date:   Fri, 13 Jan 2023 11:27:59 +0800
Message-Id: <20230113032802.41752-3-qiuxu.zhuo@intel.com>
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

skx_mce_check_error() returns early if the error isn't from memory.
So when skx_mce_output_error() is invoked from skx_mce_check_error(),
it doesn't need to re-check whether the error is from memory. Delete
the duplicated and unreachable code from skx_mce_output_error().

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/skx_common.c | 58 ++++++++++++++-------------------------
 1 file changed, 21 insertions(+), 37 deletions(-)

diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 5fdcb6d5b96b..fd8186fe005c 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -560,44 +560,28 @@ static void skx_mce_output_error(struct mem_ctl_info *mci,
 		tp_event = HW_EVENT_ERR_CORRECTED;
 	}
 
-	/*
-	 * According to Intel Architecture spec vol 3B,
-	 * Table 15-10 "IA32_MCi_Status [15:0] Compound Error Code Encoding"
-	 * memory errors should fit one of these masks:
-	 *	000f 0000 1mmm cccc (binary)
-	 *	000f 0010 1mmm cccc (binary)	[RAM used as cache]
-	 * where:
-	 *	f = Correction Report Filtering Bit. If 1, subsequent errors
-	 *	    won't be shown
-	 *	mmm = error type
-	 *	cccc = channel
-	 * If the mask doesn't match, report an error to the parsing logic
-	 */
-	if (!((errcode & 0xef80) == 0x80 || (errcode & 0xef80) == 0x280)) {
-		optype = "Can't parse: it is not a mem";
-	} else {
-		switch (optypenum) {
-		case 0:
-			optype = "generic undef request error";
-			break;
-		case 1:
-			optype = "memory read error";
-			break;
-		case 2:
-			optype = "memory write error";
-			break;
-		case 3:
-			optype = "addr/cmd error";
-			break;
-		case 4:
-			optype = "memory scrubbing error";
-			scrub_err = true;
-			break;
-		default:
-			optype = "reserved";
-			break;
-		}
+	switch (optypenum) {
+	case 0:
+		optype = "generic undef request error";
+		break;
+	case 1:
+		optype = "memory read error";
+		break;
+	case 2:
+		optype = "memory write error";
+		break;
+	case 3:
+		optype = "addr/cmd error";
+		break;
+	case 4:
+		optype = "memory scrubbing error";
+		scrub_err = true;
+		break;
+	default:
+		optype = "reserved";
+		break;
 	}
+
 	if (res->decoded_by_adxl) {
 		len = snprintf(skx_msg, MSG_SIZE, "%s%s err_code:0x%04x:0x%04x %s",
 			 overflow ? " OVERFLOW" : "",
-- 
2.17.1

