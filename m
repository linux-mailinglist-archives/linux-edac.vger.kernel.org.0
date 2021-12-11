Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADFA8471321
	for <lists+linux-edac@lfdr.de>; Sat, 11 Dec 2021 10:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbhLKJTf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 11 Dec 2021 04:19:35 -0500
Received: from smtpbg127.qq.com ([109.244.180.96]:56046 "EHLO smtpbg.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230206AbhLKJTe (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sat, 11 Dec 2021 04:19:34 -0500
X-QQ-mid: bizesmtp45t1639214357tp0q2cjc
Received: from localhost.localdomain (unknown [182.132.179.213])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sat, 11 Dec 2021 17:19:16 +0800 (CST)
X-QQ-SSF: 01000000008000D0H000B00A0000000
X-QQ-FEAT: TzHnbXlu93pRW0fktOVQsSVC/lCRcE3bO8RsrNpzf6GBxnYyfN8VswfWiQ4WM
        E33MpzFJyarduiiY6hHUHZCs7i7+7H1nr9bC2p54n0fNN9tmLLlNyK241DBxpLj8kjrSo42
        Ue1ZJaJXDHI9aBkel1y40jE0PnxHXaa+gBMmH1l9Zg89f4vXDVC7e02eLaLAXhnbGdWVOb6
        PGArPe4AIagjJTemiHvLq4l/3eVjHr11zctq9CkKfyqvTHGXBlAVReGVkIKBQNlHMQPCr48
        mRVjsx9HAAH6rww92wSHy68M6PSAKpGNilczG2XyJhAF908RrB8O3QckkUYr/ugQzEgOns5
        rg/xHXh7q+8PWJ5k44xc4uM05WbnEtiiadN6kEO
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     bp@alien8.de
Cc:     tony.luck@intel.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] RAS/CEC: fix typo in a comment
Date:   Sat, 11 Dec 2021 17:19:14 +0800
Message-Id: <20211211091914.268823-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam1
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The double `an' in the comment in line 41 is repeated. Remove one
of them from the comment.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/ras/cec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index d7894f178bd4..42f2fc0bc8a9 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -38,7 +38,7 @@
  * elements entered into the array, during which, we're decaying all elements.
  * If, after decay, an element gets inserted again, its generation is set to 11b
  * to make sure it has higher numerical count than other, older elements and
- * thus emulate an an LRU-like behavior when deleting elements to free up space
+ * thus emulate an LRU-like behavior when deleting elements to free up space
  * in the page.
  *
  * When an element reaches it's max count of action_threshold, we try to poison
-- 
2.34.1

