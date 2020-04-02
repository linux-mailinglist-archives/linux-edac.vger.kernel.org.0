Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0FA19B9E2
	for <lists+linux-edac@lfdr.de>; Thu,  2 Apr 2020 03:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732783AbgDBB23 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 1 Apr 2020 21:28:29 -0400
Received: from inva021.nxp.com ([92.121.34.21]:39008 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbgDBB23 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 1 Apr 2020 21:28:29 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E75C2200F79;
        Thu,  2 Apr 2020 03:28:26 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 390BE200A6C;
        Thu,  2 Apr 2020 03:28:21 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 7E309402E3;
        Thu,  2 Apr 2020 09:28:14 +0800 (SGT)
From:   Sherry Sun <sherry.sun@nxp.com>
To:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rrichter@marvell.com, michal.simek@xilinx.com,
        manish.narani@xilinx.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, frank.li@nxp.com
Subject: [patch v3 1/4] dt-bindings: memory-controllers: Add i.MX8MP DDRC binding doc
Date:   Thu,  2 Apr 2020 09:20:30 +0800
Message-Id: <1585790433-31465-2-git-send-email-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585790433-31465-1-git-send-email-sherry.sun@nxp.com>
References: <1585790433-31465-1-git-send-email-sherry.sun@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add documentation for i.MX8MP DDRC binding based on synopsys_edac doc,
which use the same memory-controller IP.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/memory-controllers/synopsys.txt   | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/synopsys.txt b/Documentation/devicetree/bindings/memory-controllers/synopsys.txt
index 9d32762c47e1..4fd14ba61474 100644
--- a/Documentation/devicetree/bindings/memory-controllers/synopsys.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/synopsys.txt
@@ -6,16 +6,20 @@ bus width configurations.
 The Zynq DDR ECC controller has an optional ECC support in half-bus width
 (16-bit) configuration.
 
-These both ECC controllers correct single bit ECC errors and detect double bit
+The i.MX8MP DDR ECC controller has an ECC support in 64-bit bus width
+configurations.
+
+All the ECC controllers correct single bit ECC errors and detect double bit
 ECC errors.
 
 Required properties:
  - compatible: One of:
 	- 'xlnx,zynq-ddrc-a05' : Zynq DDR ECC controller
 	- 'xlnx,zynqmp-ddrc-2.40a' : ZynqMP DDR ECC controller
+	- 'fsl,imx8mp-ddrc' : i.MX8MP DDR ECC controller
  - reg: Should contain DDR controller registers location and length.
 
-Required properties for "xlnx,zynqmp-ddrc-2.40a":
+Required properties for "xlnx,zynqmp-ddrc-2.40a" and "fsl,imx8mp-ddrc":
  - interrupts: Property with a value describing the interrupt number.
 
 Example:
-- 
2.17.1

