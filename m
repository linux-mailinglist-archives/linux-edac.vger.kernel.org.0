Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 126C728CEB4
	for <lists+linux-edac@lfdr.de>; Tue, 13 Oct 2020 14:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgJMMut (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 13 Oct 2020 08:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbgJMMut (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 13 Oct 2020 08:50:49 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DD1C0613D0
        for <linux-edac@vger.kernel.org>; Tue, 13 Oct 2020 05:50:49 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kSJlE-0007lh-26; Tue, 13 Oct 2020 14:50:36 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kSJlC-0005qT-NV; Tue, 13 Oct 2020 14:50:34 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-edac@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        York Sun <york.sun@nxp.com>, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 3/3] arm64: dts: ls104x: Add L1/L2 cache edac node
Date:   Tue, 13 Oct 2020 14:50:33 +0200
Message-Id: <20201013125033.4749-4-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201013125033.4749-1-s.hauer@pengutronix.de>
References: <20201013125033.4749-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-edac@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: York Sun <york.sun@nxp.com>

The Cortex A53/A57 cores on the Layerscape LS104x SoCs support EDAC
for the L1/L2 caches. Add the corresponding nodes for it.

Signed-off-by: York Sun <york.sun@nxp.com>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 5 +++++
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 5c2e370f6316..76cc62b02494 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -935,6 +935,11 @@ optee {
 		};
 	};
 
+	edac-a53 {
+		compatible = "arm,cortex-a53-edac";
+		cpus = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
+	};
+
 };
 
 #include "qoriq-qman-portals.dtsi"
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 0246d975a206..ed35211c9b35 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -895,6 +895,11 @@ optee {
 			method = "smc";
 		};
 	};
+
+	edac-a57 {
+		compatible = "arm,cortex-a57-edac";
+		cpus = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
+	};
 };
 
 #include "qoriq-qman-portals.dtsi"
-- 
2.28.0

