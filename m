Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90FF6166FBC
	for <lists+linux-edac@lfdr.de>; Fri, 21 Feb 2020 07:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgBUGrK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 21 Feb 2020 01:47:10 -0500
Received: from inva021.nxp.com ([92.121.34.21]:37678 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbgBUGrK (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 21 Feb 2020 01:47:10 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 20DF6206B9D;
        Fri, 21 Feb 2020 07:47:08 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2A932206BAE;
        Fri, 21 Feb 2020 07:47:00 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 5D98940381;
        Fri, 21 Feb 2020 14:46:06 +0800 (SGT)
From:   sherry sun <sherry.sun@nxp.com>
To:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rrichter@marvell.com, michal.simek@xilinx.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-edac@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, frank.li@nxp.com
Subject: [PATCH 1/3] dt-bindings: memory-controllers: Add i.MX8MP DDRC binding doc
Date:   Fri, 21 Feb 2020 14:39:14 +0800
Message-Id: <1582267156-20189-2-git-send-email-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582267156-20189-1-git-send-email-sherry.sun@nxp.com>
References: <1582267156-20189-1-git-send-email-sherry.sun@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Sherry Sun <sherry.sun@nxp.com>

Add documentation for i.MX8MP DDRC binding based on synopsys_edac doc,
which use the same memory-controller IP.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 .../devicetree/bindings/memory-controllers/synopsys.txt   | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/synopsys.txt b/Documentation/devicetree/bindings/memory-controllers/synopsys.txt
index 9d32762c47e1..5c03959a451f 100644
--- a/Documentation/devicetree/bindings/memory-controllers/synopsys.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/synopsys.txt
@@ -6,16 +6,20 @@ bus width configurations.
 The Zynq DDR ECC controller has an optional ECC support in half-bus width
 (16-bit) configuration.
 
-These both ECC controllers correct single bit ECC errors and detect double bit
+The i.MX8MP DDR ECC controller has an ECC support in 64-bit bus width
+configurations.
+
+These all ECC controllers correct single bit ECC errors and detect double bit
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

