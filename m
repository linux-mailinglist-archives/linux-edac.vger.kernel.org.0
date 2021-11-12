Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB27244EBA4
	for <lists+linux-edac@lfdr.de>; Fri, 12 Nov 2021 17:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbhKLQ44 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 12 Nov 2021 11:56:56 -0500
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:62169 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235311AbhKLQ4z (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 12 Nov 2021 11:56:55 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id lZoNmTr5w1UGBlZoNmGJxP; Fri, 12 Nov 2021 17:54:04 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 12 Nov 2021 17:54:04 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] EDAC, wq: Remove redundant 'flush_workqueue()' calls
Date:   Fri, 12 Nov 2021 17:53:58 +0100
Message-Id: <0b69bf50e40fb2d6868cb7f873a5ae600c66a48e.1636735970.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

'destroy_workqueue()' already drains the queue before destroying it, so
there is no need to flush it explicitly.

Remove the redundant 'flush_workqueue()' calls.

This was generated with coccinelle:

@@
expression E;
@@
- 	flush_workqueue(E);
	destroy_workqueue(E);

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/edac/wq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/edac/wq.c b/drivers/edac/wq.c
index d021d287eaec..ad3f516627c5 100644
--- a/drivers/edac/wq.c
+++ b/drivers/edac/wq.c
@@ -37,7 +37,6 @@ int edac_workqueue_setup(void)
 
 void edac_workqueue_teardown(void)
 {
-	flush_workqueue(wq);
 	destroy_workqueue(wq);
 	wq = NULL;
 }
-- 
2.30.2

