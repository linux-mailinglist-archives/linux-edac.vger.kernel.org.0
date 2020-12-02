Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E40D2CBA38
	for <lists+linux-edac@lfdr.de>; Wed,  2 Dec 2020 11:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgLBKNN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 2 Dec 2020 05:13:13 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:59036 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgLBKNN (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 2 Dec 2020 05:13:13 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 0B2A9qgg086424;
        Wed, 2 Dec 2020 18:09:52 +0800 (GMT-8)
        (envelope-from troy_lee@aspeedtech.com)
Received: from TroyLee-PC.localdomain (192.168.100.253) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 2 Dec
 2020 18:12:21 +0800
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
Subject: [PATCH v3 2/3] ARM: dts: aspeed: Add AST2600 edac into common devicetree
Date:   Wed, 2 Dec 2020 18:12:17 +0800
Message-ID: <20201202101218.18393-2-troy_lee@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201202101218.18393-1-troy_lee@aspeedtech.com>
References: <20201202101218.18393-1-troy_lee@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.100.253]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 0B2A9qgg086424
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Adding Aspeed AST2600 edac node into common devicetree.

Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-g6.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index b58220a49cbd..74367ee96f20 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -69,6 +69,12 @@
 		always-on;
 	};
 
+	edac: sdram@1e6e0000 {
+		compatible = "aspeed,ast2600-sdram-edac", "syscon";
+		reg = <0x1e6e0000 0x174>;
+		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	ahb {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
2.17.1

