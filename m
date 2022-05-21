Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECAE52FB0B
	for <lists+linux-edac@lfdr.de>; Sat, 21 May 2022 13:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344955AbiEULMq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 21 May 2022 07:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353474AbiEULMT (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 21 May 2022 07:12:19 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DA433351;
        Sat, 21 May 2022 04:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zQtBKPg+d+cC4XEdv1IkBWPPxZwE5zveLcgSMEEGK7k=;
  b=FQWHsvmiTLuqeVMY/uIL3NAmScLE+bf7gE4E6RdyY7bh6G5qnwAmKapw
   2QO4cqiqehvX38tprHeZpMH/V6MvliexjmRMBNItTE0WqvdYUsET7c7nu
   +uJu8ztdaUCLncnxWrOg0NhAl3hqR1hFNDA+U897f++cg33l+kGrl0nne
   o=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; 
   d="scan'208";a="14727936"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:11:59 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Khuong Dinh <khuong@os.amperecomputing.com>
Cc:     kernel-janitors@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] EDAC/xgene: fix typo in comment
Date:   Sat, 21 May 2022 13:10:49 +0200
Message-Id: <20220521111145.81697-39-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Spelling mistake (triple letters) in comment.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/edac/xgene_edac.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/xgene_edac.c b/drivers/edac/xgene_edac.c
index 7197f9fa0245..54081403db4f 100644
--- a/drivers/edac/xgene_edac.c
+++ b/drivers/edac/xgene_edac.c
@@ -501,7 +501,7 @@ static int xgene_edac_mc_remove(struct xgene_edac_mc_ctx *mcu)
 #define MEMERR_L2C_L2ESRA_PAGE_OFFSET		0x0804
 
 /*
- * Processor Module Domain (PMD) context - Context for a pair of processsors.
+ * Processor Module Domain (PMD) context - Context for a pair of processors.
  * Each PMD consists of 2 CPUs and a shared L2 cache. Each CPU consists of
  * its own L1 cache.
  */

