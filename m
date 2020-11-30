Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C2D2C800E
	for <lists+linux-edac@lfdr.de>; Mon, 30 Nov 2020 09:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgK3IfC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 30 Nov 2020 03:35:02 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:63028 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbgK3IfC (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 30 Nov 2020 03:35:02 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 0AU8VpY8067866;
        Mon, 30 Nov 2020 16:31:51 +0800 (GMT-8)
        (envelope-from troy_lee@aspeedtech.com)
Received: from TroyLee-PC.localdomain (192.168.100.253) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 30 Nov
 2020 16:34:12 +0800
From:   Troy Lee <troy_lee@aspeedtech.com>
To:     Stefan Schaeckeler <sschaeck@cisco.com>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "Borislav Petkov" <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
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
Subject: [PATCH 1/3] dt-bindings: edac: aspeed-sdram-edac: Add ast2400/ast2600 support
Date:   Mon, 30 Nov 2020 16:33:43 +0800
Message-ID: <20201130083345.4814-1-troy_lee@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.100.253]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 0AU8VpY8067866
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Adding Aspeed AST2400 and AST2600 binding for edac driver.

Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
---
 .../devicetree/bindings/edac/aspeed-sdram-edac.txt       | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt b/Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
index 6a0f3d90d682..8ca9e0a049d8 100644
--- a/Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
+++ b/Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
@@ -1,6 +1,6 @@
-Aspeed AST2500 SoC EDAC node
+Aspeed BMC SoC EDAC node
 
-The Aspeed AST2500 SoC supports DDR3 and DDR4 memory with and without ECC (error
+The Aspeed BMC SoC supports DDR3 and DDR4 memory with and without ECC (error
 correction check).
 
 The memory controller supports SECDED (single bit error correction, double bit
@@ -11,7 +11,10 @@ Note, the bootloader must configure ECC mode in the memory controller.
 
 
 Required properties:
-- compatible: should be "aspeed,ast2500-sdram-edac"
+- compatible: should be one of
+	- "aspeed,ast2400-sdram-edac"
+	- "aspeed,ast2500-sdram-edac"
+	- "aspeed,ast2600-sdram-edac"
 - reg:        sdram controller register set should be <0x1e6e0000 0x174>
 - interrupts: should be AVIC interrupt #0
 
-- 
2.17.1

