Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76E5119A679
	for <lists+linux-edac@lfdr.de>; Wed,  1 Apr 2020 09:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732026AbgDAHrQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 1 Apr 2020 03:47:16 -0400
Received: from inva020.nxp.com ([92.121.34.13]:50576 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731999AbgDAHrP (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 1 Apr 2020 03:47:15 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A8B761A0D0A;
        Wed,  1 Apr 2020 09:47:13 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 563251A0D20;
        Wed,  1 Apr 2020 09:47:08 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 1C8374030C;
        Wed,  1 Apr 2020 15:47:02 +0800 (SGT)
From:   Sherry Sun <sherry.sun@nxp.com>
To:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rrichter@marvell.com, michal.simek@xilinx.com,
        manish.narani@xilinx.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        frank.li@nxp.com
Subject: [PATCH v2 1/4] dt-bindings: memory-controllers: Add i.MX8MP DDRC binding doc
Date:   Wed,  1 Apr 2020 15:39:06 +0800
Message-Id: <1585726749-13039-2-git-send-email-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585726749-13039-1-git-send-email-sherry.sun@nxp.com>
References: <1585726749-13039-1-git-send-email-sherry.sun@nxp.com>
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

