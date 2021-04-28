Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB0B236D0D2
	for <lists+linux-edac@lfdr.de>; Wed, 28 Apr 2021 05:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbhD1DRt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 27 Apr 2021 23:17:49 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:41018 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229556AbhD1DRt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Tue, 27 Apr 2021 23:17:49 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=kaige.fu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UX1cOJN_1619579822;
Received: from localhost(mailfrom:kaige.fu@linux.alibaba.com fp:SMTPD_---0UX1cOJN_1619579822)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 28 Apr 2021 11:17:03 +0800
From:   Kaige Fu <kaige.fu@linux.alibaba.com>
To:     linux-edac@vger.kernel.org
Cc:     Kaige Fu <kaige.fu@linux.alibaba.com>,
        Shannon Zhao <shannon.zhao@linux.alibaba.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH] EDAC/mce_amd: Print !SMCA processor warning for 0x19 family
Date:   Wed, 28 Apr 2021 11:15:06 +0800
Message-Id: <93c212e8b182843d0a113cb05571416ba19bc355.1619576976.git.kaige.fu@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

KVM doesn't enable SMCA for 0x19 family AMD processors.
Consequently, a warning as following will be print when load
edac_mce_amd.ko in a virtual machine.

"Huh? What family is it: 0x19?!"

To make the log more clear, this patch prints !SMCA processor
warning for 0x19 family.

Signed-off-by: Kaige Fu <kaige.fu@linux.alibaba.com>
Cc: Shannon Zhao <shannon.zhao@linux.alibaba.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: James Morse <james.morse@arm.com>
Cc: Robert Richter <rrichter@marvell.com>
Cc: linux-edac@vger.kernel.org
---
 drivers/edac/mce_amd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 5dd905a3f30c..0602082c1ef0 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -1229,6 +1229,7 @@ static int __init mce_amd_init(void)
 
 	case 0x17:
 	case 0x18:
+	case 0x19:
 		pr_warn_once("Decoding supported only on Scalable MCA processors.\n");
 		return -EINVAL;
 
-- 
1.8.3.1

