Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDE163DD6
	for <lists+linux-edac@lfdr.de>; Wed, 10 Jul 2019 00:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfGIWWu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 Jul 2019 18:22:50 -0400
Received: from mga06.intel.com ([134.134.136.31]:10284 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726580AbfGIWWt (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 9 Jul 2019 18:22:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2019 15:22:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,472,1557212400"; 
   d="scan'208";a="364289199"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by fmsmga005.fm.intel.com with ESMTP; 09 Jul 2019 15:22:48 -0700
From:   thor.thayer@linux.intel.com
To:     bp@alien8.de, mchehab@kernel.org, james.morse@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com, dinguyen@kernel.org
Cc:     devicetree@vger.kernel.org, linux-edac@vger.kernel.org,
        Thor Thayer <thor.thayer@linux.intel.com>
Subject: [PATCH 2/3] arm64: dts: Stratix10: Include regs in SDRAM ECC node
Date:   Tue,  9 Jul 2019 17:24:49 -0500
Message-Id: <1562711090-900-3-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562711090-900-1-git-send-email-thor.thayer@linux.intel.com>
References: <1562711090-900-1-git-send-email-thor.thayer@linux.intel.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Include the regs directly in the SDRAM node instead of using
a syscon. The Stratix10 SDRAM ECC registers are partitioned
away from other Sys Manager registers so the syscon is no
longer needed for Stratix10.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index 4b0f674df849..a1e9545de3d3 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -517,11 +517,6 @@
 			status = "disabled";
 		};
 
-		sdr: sdr@f8011100 {
-			compatible = "altr,sdr-ctl", "syscon";
-			reg = <0xf8011100 0xc0>;
-		};
-
 		eccmgr {
 			compatible = "altr,socfpga-s10-ecc-manager",
 				     "altr,socfpga-a10-ecc-manager";
@@ -533,9 +528,9 @@
 			#interrupt-cells = <2>;
 			ranges;
 
-			sdramedac {
+			sdramedac@0xf8011100 {
 				compatible = "altr,sdram-edac-s10";
-				altr,sdr-syscon = <&sdr>;
+				reg = <0xf8011100 0xc0>;
 				interrupts = <16 4>;
 			};
 
-- 
2.7.4

