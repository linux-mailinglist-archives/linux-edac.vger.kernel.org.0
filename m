Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B601A963F
	for <lists+linux-edac@lfdr.de>; Wed, 15 Apr 2020 10:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894405AbgDOIX7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 15 Apr 2020 04:23:59 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2377 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2894407AbgDOIXx (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 15 Apr 2020 04:23:53 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9DA2429C6DCD93E4EFC6;
        Wed, 15 Apr 2020 16:23:49 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Wed, 15 Apr 2020
 16:23:38 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <bp@alien8.de>, <mchehab@kernel.org>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <rrichter@marvell.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] EDAC: remove defined but not used 'bridge_str'
Date:   Wed, 15 Apr 2020 16:50:06 +0800
Message-ID: <20200415085006.6732-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Fix the following gcc warning:

drivers/edac/amd8131_edac.c:47:21: warning: ‘bridge_str’ defined but not
used [-Wunused-const-variable=]
 static char * const bridge_str[] = {
                     ^~~~~~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/edac/amd8131_edac.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/edac/amd8131_edac.c b/drivers/edac/amd8131_edac.c
index 93c82bc17493..169353710982 100644
--- a/drivers/edac/amd8131_edac.c
+++ b/drivers/edac/amd8131_edac.c
@@ -44,14 +44,6 @@ static void edac_pci_write_dword(struct pci_dev *dev, int reg, u32 val32)
 			" PCI Access Write Error at 0x%x\n", reg);
 }
 
-static char * const bridge_str[] = {
-	[NORTH_A] = "NORTH A",
-	[NORTH_B] = "NORTH B",
-	[SOUTH_A] = "SOUTH A",
-	[SOUTH_B] = "SOUTH B",
-	[NO_BRIDGE] = "NO BRIDGE",
-};
-
 /* Support up to two AMD8131 chipsets on a platform */
 static struct amd8131_dev_info amd8131_devices[] = {
 	{
-- 
2.21.1

