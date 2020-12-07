Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A95E22D0C7A
	for <lists+linux-edac@lfdr.de>; Mon,  7 Dec 2020 10:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgLGJBW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 7 Dec 2020 04:01:22 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:34893 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbgLGJBU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 7 Dec 2020 04:01:20 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 0B78vaST096566;
        Mon, 7 Dec 2020 16:57:36 +0800 (GMT-8)
        (envelope-from troy_lee@aspeedtech.com)
Received: from TroyLee-PC.localdomain (192.168.100.253) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 7 Dec
 2020 17:00:24 +0800
From:   Troy Lee <troy_lee@aspeedtech.com>
To:     Stefan Schaeckeler <sschaeck@cisco.com>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "Borislav Petkov" <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:EDAC-CORE" <linux-edac@vger.kernel.org>
CC:     <leetroy@gmail.com>, <troy_lee@aspeedtech.com>,
        <ryan_chen@aspeedtech.com>
Subject: [PATCH v4 3/3] edac: Supporting AST2400 and AST2600 edac driver
Date:   Mon, 7 Dec 2020 17:00:13 +0800
Message-ID: <20201207090013.14145-3-troy_lee@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201207090013.14145-1-troy_lee@aspeedtech.com>
References: <20201207090013.14145-1-troy_lee@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.100.253]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 0B78vaST096566
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Adding AST2400 and AST2600 edac driver support.

Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
---
 drivers/edac/Kconfig       | 6 +++---
 drivers/edac/aspeed_edac.c | 7 +++++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 7a47680d6f07..c410331e8ee8 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -515,10 +515,10 @@ config EDAC_QCOM
 	  health, you should probably say 'Y' here.
 
 config EDAC_ASPEED
-	tristate "Aspeed AST 2500 SoC"
-	depends on MACH_ASPEED_G5
+	tristate "Aspeed AST BMC SoC"
+	depends on ARCH_ASPEED
 	help
-	  Support for error detection and correction on the Aspeed AST 2500 SoC.
+	  Support for error detection and correction on the Aspeed AST BMC SoC.
 
 	  First, ECC must be configured in the bootloader. Then, this driver
 	  will expose error counters via the EDAC kernel framework.
diff --git a/drivers/edac/aspeed_edac.c b/drivers/edac/aspeed_edac.c
index fde809efc520..a46da56d6d54 100644
--- a/drivers/edac/aspeed_edac.c
+++ b/drivers/edac/aspeed_edac.c
@@ -239,7 +239,7 @@ static int init_csrows(struct mem_ctl_info *mci)
 	int rc;
 
 	/* retrieve info about physical memory from device tree */
-	np = of_find_node_by_path("/memory");
+	np = of_find_node_by_name(NULL, "memory");
 	if (!np) {
 		dev_err(mci->pdev, "dt: missing /memory node\n");
 		return -ENODEV;
@@ -375,10 +375,13 @@ static int aspeed_remove(struct platform_device *pdev)
 
 
 static const struct of_device_id aspeed_of_match[] = {
+	{ .compatible = "aspeed,ast2400-sdram-edac" },
 	{ .compatible = "aspeed,ast2500-sdram-edac" },
+	{ .compatible = "aspeed,ast2600-sdram-edac" },
 	{},
 };
 
+MODULE_DEVICE_TABLE(of, aspeed_of_match);
 
 static struct platform_driver aspeed_driver = {
 	.driver		= {
@@ -392,5 +395,5 @@ module_platform_driver(aspeed_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Stefan Schaeckeler <sschaeck@cisco.com>");
-MODULE_DESCRIPTION("Aspeed AST2500 EDAC driver");
+MODULE_DESCRIPTION("Aspeed BMC SoC EDAC driver");
 MODULE_VERSION("1.0");
-- 
2.17.1

