Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2838B615D65
	for <lists+linux-edac@lfdr.de>; Wed,  2 Nov 2022 09:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiKBIND (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 2 Nov 2022 04:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiKBIM7 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 2 Nov 2022 04:12:59 -0400
Received: from mailgw.kylinos.cn (unknown [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AFC15A28;
        Wed,  2 Nov 2022 01:12:54 -0700 (PDT)
X-UUID: 93fe71868d19410593e6438955f46595-20221102
X-CPASD-INFO: 8ca4923a18c8495b90d56cbcf6835c4b@gbObVGZkYZFdWKWEg3yAnFlhlGVmj4K
        yqHBYY2OTYIKVhH5xTV5uYFV9fWtVYV9dYVR6eGxQYmBgZFJ4i3-XblBgXoZgUZB3h6WbVGlgYw==
X-CLOUD-ID: 8ca4923a18c8495b90d56cbcf6835c4b
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,OB:0.0,URL:-5,TVAL:209.
        0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:0.0,CUTS:81.0,IP:-2.0,MAL:-5.0,PHF:-5.0,PHC:-5.
        0,SPF:4.0,EDMS:-5,IPLABEL:4480.0,FROMTO:0,AD:0,FFOB:0.0,CFOB:0.0,SPC:0,SIG:-5
        ,AUF:17,DUF:7267,ACD:129,DCD:129,SL:0,EISP:0,AG:0,CFC:0.499,CFSR:0.058,UAT:0,
        RAF:0,IMG:-5.0,DFA:0,DTA:0,IBL:-2.0,ADI:-5,SBL:0,REDM:0,REIP:0,ESB:0,ATTNUM:0
        ,EAF:0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: 93fe71868d19410593e6438955f46595-20221102
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1
X-UUID: 93fe71868d19410593e6438955f46595-20221102
X-User: chenzhang@kylinos.cn
Received: from localhost.localdomain [(112.64.161.44)] by mailgw
        (envelope-from <chenzhang@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 199791; Wed, 02 Nov 2022 16:12:58 +0800
From:   chen zhang <chenzhang@kylinos.cn>
To:     mchehab@kernel.org, james.morse@arm.com, rric@kernel.org
Cc:     chenzhang_0901@163.com, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, chen zhang <chenzhang@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] EDAC: Fix typo in comments
Date:   Wed,  2 Nov 2022 16:12:48 +0800
Message-Id: <20221102081248.45694-1-chenzhang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,T_SPF_PERMERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Fix spelling typo in comments.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: chen zhang <chenzhang@kylinos.cn>
---
 drivers/edac/i5400_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/i5400_edac.c b/drivers/edac/i5400_edac.c
index f76624ee82ef..b04c6dc0cf1f 100644
--- a/drivers/edac/i5400_edac.c
+++ b/drivers/edac/i5400_edac.c
@@ -279,7 +279,7 @@ static inline int from_nf_ferr(unsigned int mask)
 #define FERR_NF_RECOVERABLE	to_nf_mask(ERROR_NF_RECOVERABLE)
 #define FERR_NF_UNCORRECTABLE	to_nf_mask(ERROR_NF_UNCORRECTABLE)
 
-/* Defines to extract the vaious fields from the
+/* Defines to extract the various fields from the
  *	MTRx - Memory Technology Registers
  */
 #define MTR_DIMMS_PRESENT(mtr)		((mtr) & (1 << 10))
-- 
2.25.1

