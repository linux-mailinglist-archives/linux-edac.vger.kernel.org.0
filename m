Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFE4463537
	for <lists+linux-edac@lfdr.de>; Tue, 30 Nov 2021 14:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239468AbhK3NUa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 30 Nov 2021 08:20:30 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:28849 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239455AbhK3NU2 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Tue, 30 Nov 2021 08:20:28 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Uyt6NXY_1638278214;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Uyt6NXY_1638278214)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 30 Nov 2021 21:16:56 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     mchehab@kernel.org, bp@alien8.de, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     xueshuai@linux.alibaba.com, zhangliguang@linux.alibaba.com,
        zhuo.song@linux.alibaba.com
Subject: [PATCH] edac,ghes,cper: Add device to Memory Error Record
Date:   Tue, 30 Nov 2021 21:16:48 +0800
Message-Id: <20211130131648.85860-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

If Bit 7 of Validation Bits is valid, the device number of the memory
associated with errors should be reported to Memory Error Record.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/edac/ghes_edac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index a918ca93e4f7..cf98b270d6f7 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -378,6 +378,8 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 	if (mem_err->validation_bits & CPER_MEM_VALID_BANK_ADDRESS)
 		p += sprintf(p, "bank_address:%d ",
 			     mem_err->bank & CPER_MEM_BANK_ADDRESS_MASK);
+	if (mem_err->validation_bits & CPER_MEM_VALID_DEVICE)
+		p += sprintf(p, "device:%d ", mem_err->device);
 	if (mem_err->validation_bits & (CPER_MEM_VALID_ROW | CPER_MEM_VALID_ROW_EXT)) {
 		u32 row = mem_err->row;
 
-- 
2.20.1.12.g72788fdb

