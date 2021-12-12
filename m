Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C744717FA
	for <lists+linux-edac@lfdr.de>; Sun, 12 Dec 2021 04:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbhLLD1H (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 11 Dec 2021 22:27:07 -0500
Received: from smtpbg126.qq.com ([106.55.201.22]:50560 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229635AbhLLD1G (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sat, 11 Dec 2021 22:27:06 -0500
X-QQ-mid: bizesmtp38t1639279616tvuhi8oz
Received: from localhost.localdomain (unknown [182.132.179.213])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sun, 12 Dec 2021 11:26:55 +0800 (CST)
X-QQ-SSF: 01000000002000D0H000B00A0000000
X-QQ-FEAT: dpyQmELDBxFo0y7giH8K9FeBllKIq5qQDPu1p2HfTShzZnbL2O7nslt9VgfqG
        IAsXQG4UbhLSHiLwpKqmn0GCxknqpOpPu/bYN/mbziCKnVC4WbtyloZ9TmmT/clfkIEAbWv
        9GcyTXRu9chT6ETAWAfaEYWnadG8bYOMIpgWScCQR757QRAm9FR70DpLX+lNGrpOpvB1R/H
        VkLa7iSv5Q+q4IfjK6ohJLAMc0PbKB2u4tZ5i8JS/Pue3d0RhKGtMxZlH744iKt7RKapN6A
        ujg3yY1OTSpNKHECgYDbnQrTGpgVu7+8t5/v6IUx62GuHo/f8z+yHcD/RM9eq2eEFyVLQsD
        JjMqkzGLEfg45SkqEZxsDtvcYRJAyY8oLElZV8w+UPnNlZ22SU=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     bp@alien8.de
Cc:     yazen.ghannam@amd.com, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] EDAC/amd64: fix typo in a comment
Date:   Sun, 12 Dec 2021 11:26:53 +0800
Message-Id: <20211212032653.56459-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam2
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The double `reads' in the comment in line 126 is repeated. Remove one
of them from the comment.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/edac/amd64_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index ca0c67bc25c6..dff6469e9f67 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -123,7 +123,7 @@ static inline int amd64_read_dct_pci_cfg(struct amd64_pvt *pvt, u8 dct,
 		if (dct) {
 			/*
 			 * Note: If ganging is enabled, barring the regs
-			 * F2x[1,0]98 and F2x[1,0]9C; reads reads to F2x1xx
+			 * F2x[1,0]98 and F2x[1,0]9C; reads to F2x1xx
 			 * return 0. (cf. Section 2.8.1 F10h BKDG)
 			 */
 			if (dct_ganging_enabled(pvt))
-- 
2.34.1

