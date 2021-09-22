Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E324149F0
	for <lists+linux-edac@lfdr.de>; Wed, 22 Sep 2021 14:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhIVNBD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 22 Sep 2021 09:01:03 -0400
Received: from mx24.baidu.com ([111.206.215.185]:54210 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230350AbhIVNBD (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 22 Sep 2021 09:01:03 -0400
Received: from BC-Mail-Ex27.internal.baidu.com (unknown [172.31.51.21])
        by Forcepoint Email with ESMTPS id A9B8549C90D736DA522A;
        Wed, 22 Sep 2021 20:59:31 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex27.internal.baidu.com (172.31.51.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 22 Sep 2021 20:59:31 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Wed, 22 Sep 2021 20:59:30 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Talel Shenhar <talel@amazon.com>, Borislav Petkov <bp@alien8.de>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "James Morse" <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] EDAC/al-mc-edac: Make use of the helper function devm_add_action_or_reset()
Date:   Wed, 22 Sep 2021 20:59:23 +0800
Message-ID: <20210922125924.321-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex31.internal.baidu.com (172.31.51.25) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The helper function devm_add_action_or_reset() will internally
call devm_add_action(), and if devm_add_action() fails then it will
execute the action mentioned and return the error code. So
use devm_add_action_or_reset() instead of devm_add_action()
to simplify the error handling, reduce the code.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/edac/al_mc_edac.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/edac/al_mc_edac.c b/drivers/edac/al_mc_edac.c
index 7d4f396c27b5..178b9e581a72 100644
--- a/drivers/edac/al_mc_edac.c
+++ b/drivers/edac/al_mc_edac.c
@@ -238,11 +238,9 @@ static int al_mc_edac_probe(struct platform_device *pdev)
 	if (!mci)
 		return -ENOMEM;
 
-	ret = devm_add_action(&pdev->dev, devm_al_mc_edac_free, mci);
-	if (ret) {
-		edac_mc_free(mci);
+	ret = devm_add_action_or_reset(&pdev->dev, devm_al_mc_edac_free, mci);
+	if (ret)
 		return ret;
-	}
 
 	platform_set_drvdata(pdev, mci);
 	al_mc = mci->pvt_info;
@@ -293,11 +291,9 @@ static int al_mc_edac_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = devm_add_action(&pdev->dev, devm_al_mc_edac_del, &pdev->dev);
-	if (ret) {
-		edac_mc_del_mc(&pdev->dev);
+	ret = devm_add_action_or_reset(&pdev->dev, devm_al_mc_edac_del, &pdev->dev);
+	if (ret)
 		return ret;
-	}
 
 	if (al_mc->irq_ue > 0) {
 		ret = devm_request_irq(&pdev->dev,
-- 
2.25.1

