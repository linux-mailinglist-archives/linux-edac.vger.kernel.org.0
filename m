Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE479692C79
	for <lists+linux-edac@lfdr.de>; Sat, 11 Feb 2023 02:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjBKBSD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 10 Feb 2023 20:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBKBSC (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 10 Feb 2023 20:18:02 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25D63A08D;
        Fri, 10 Feb 2023 17:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676078281; x=1707614281;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=4hf1OloHBVcxR02BTOFRj9IkRyZKjqy/ZG29ImkR/mg=;
  b=ZW/B5D2lbfx5/fy5z2THVTJ2Aqx28uwfiKVRXx9v5U8QcE1RwDwiOm8K
   BeRN4DEjEf5r42x1nyRR7BBH54H3I2HH1nXPzwuD31YnZ98aqRyCI9m2i
   oSwKYJIm1Z/bhPdDgKPpqZHag2hjH4mtgVDmlU58uCeguxRLlbuGVd3/V
   z854/KcBxrsEF9d2xayKXEWVVnFEX4rTcc+1/IfsTVsyarenz+aIO6AIm
   Cph9oaiK8gIdmHSrD1whVfZHq5d5e3Ab95JCrPPw2/fYQ7MHVzEjEoJvd
   YGSyiFe7AJUgTOSkGECU5/3wrR4Vy4cRxnAbtriaVqTYN6+oEm0j4gNPy
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="314210621"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="314210621"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 17:18:01 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="670188088"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="670188088"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.105])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 17:17:58 -0800
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Borislav Petkov <bp@alien8.de>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Feng Xu <feng.f.xu@intel.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] EDAC/skx: Fix overflows on the DRAM row address mapping arrays
Date:   Sat, 11 Feb 2023 09:17:28 +0800
Message-Id: <20230211011728.71764-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <IA1PR11MB61710A47690BD5DA2826F29389DF9@IA1PR11MB6171.namprd11.prod.outlook.com>
References: <IA1PR11MB61710A47690BD5DA2826F29389DF9@IA1PR11MB6171.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The current DRAM row address mapping arrays skx_{open,close}_row[]
only support ranks with sizes up to 16G. Decoding a rank address
to a DRAM row address for a 32G rank by using either one of the
above arrays by the skx_edac driver, will result in an overflow on
the array.

For a 32G rank, the most significant DRAM row address bit (the
bit17) is mapped from the bit34 of the rank address. Add this new
mapping item to both arrays to fix the overflow issue.

Fixes: 4ec656bdf43a ("EDAC, skx_edac: Add EDAC driver for Skylake")
Reported-by: Feng Xu <feng.f.xu@intel.com>
Tested-by: Feng Xu <feng.f.xu@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
v1->v2:
    Fix the Fixes tag in the commit message.

 drivers/edac/skx_base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/skx_base.c b/drivers/edac/skx_base.c
index 9397abb42c49..0a862336a7ce 100644
--- a/drivers/edac/skx_base.c
+++ b/drivers/edac/skx_base.c
@@ -510,7 +510,7 @@ static bool skx_rir_decode(struct decoded_addr *res)
 }
 
 static u8 skx_close_row[] = {
-	15, 16, 17, 18, 20, 21, 22, 28, 10, 11, 12, 13, 29, 30, 31, 32, 33
+	15, 16, 17, 18, 20, 21, 22, 28, 10, 11, 12, 13, 29, 30, 31, 32, 33, 34
 };
 
 static u8 skx_close_column[] = {
@@ -518,7 +518,7 @@ static u8 skx_close_column[] = {
 };
 
 static u8 skx_open_row[] = {
-	14, 15, 16, 20, 28, 21, 22, 23, 24, 25, 26, 27, 29, 30, 31, 32, 33
+	14, 15, 16, 20, 28, 21, 22, 23, 24, 25, 26, 27, 29, 30, 31, 32, 33, 34
 };
 
 static u8 skx_open_column[] = {
-- 
2.17.1

