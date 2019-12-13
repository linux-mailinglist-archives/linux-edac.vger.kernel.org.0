Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8780A11E35E
	for <lists+linux-edac@lfdr.de>; Fri, 13 Dec 2019 13:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfLMMLO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 13 Dec 2019 07:11:14 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:47600 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726867AbfLMMLO (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 13 Dec 2019 07:11:14 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 95267D7B149C30DAA05A;
        Fri, 13 Dec 2019 20:11:12 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Fri, 13 Dec 2019
 20:11:03 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <bp@alien8.de>, <mchehab@kernel.org>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <rrichter@marvell.com>
CC:     <yukuai3@huawei.com>, <zhengbin13@huawei.com>,
        <yi.zhang@huawei.com>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] EDAC: remove set but not used variable 'ecc_loc'
Date:   Fri, 13 Dec 2019 20:10:36 +0800
Message-ID: <20191213121036.8886-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/edac/i5100_edac.c: In function ‘i5100_read_log’:
drivers/edac/i5100_edac.c:489:11: warning: variable ‘ecc_loc’
set but not used [-Wunused-but-set-variable]

Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 drivers/edac/i5100_edac.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/edac/i5100_edac.c b/drivers/edac/i5100_edac.c
index 0ddc41e47a96..a7ccf7b13619 100644
--- a/drivers/edac/i5100_edac.c
+++ b/drivers/edac/i5100_edac.c
@@ -486,7 +486,6 @@ static void i5100_read_log(struct mem_ctl_info *mci, int chan,
 	u32 dw;
 	u32 dw2;
 	unsigned syndrome = 0;
-	unsigned ecc_loc = 0;
 	unsigned merr;
 	unsigned bank;
 	unsigned rank;
@@ -499,7 +498,6 @@ static void i5100_read_log(struct mem_ctl_info *mci, int chan,
 		pci_read_config_dword(pdev, I5100_REDMEMA, &dw2);
 		syndrome = dw2;
 		pci_read_config_dword(pdev, I5100_REDMEMB, &dw2);
-		ecc_loc = i5100_redmemb_ecc_locator(dw2);
 	}
 
 	if (i5100_validlog_recmemvalid(dw)) {
-- 
2.17.2

