Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D502684E6
	for <lists+linux-edac@lfdr.de>; Mon, 14 Sep 2020 08:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgINGb6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 14 Sep 2020 02:31:58 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12248 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726075AbgINGbb (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 14 Sep 2020 02:31:31 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A6F764523210BD948D6E;
        Mon, 14 Sep 2020 14:31:29 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Mon, 14 Sep 2020
 14:31:18 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Stefan Schaeckeler <sschaeck@cisco.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        "Joel Stanley" <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
CC:     <linux-edac@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] EDAC/aspeed: use module_platform_driver to simplify the code
Date:   Mon, 14 Sep 2020 14:53:58 +0800
Message-ID: <20200914065358.3726216-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

module_platform_driver() makes the code simpler by eliminating
boilerplate code.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/edac/aspeed_edac.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/edac/aspeed_edac.c b/drivers/edac/aspeed_edac.c
index fbec28dc661d..fde809efc520 100644
--- a/drivers/edac/aspeed_edac.c
+++ b/drivers/edac/aspeed_edac.c
@@ -388,23 +388,7 @@ static struct platform_driver aspeed_driver = {
 	.probe		= aspeed_probe,
 	.remove		= aspeed_remove
 };
-
-
-static int __init aspeed_init(void)
-{
-	return platform_driver_register(&aspeed_driver);
-}
-
-
-static void __exit aspeed_exit(void)
-{
-	platform_driver_unregister(&aspeed_driver);
-}
-
-
-module_init(aspeed_init);
-module_exit(aspeed_exit);
-
+module_platform_driver(aspeed_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Stefan Schaeckeler <sschaeck@cisco.com>");
-- 
2.25.1

