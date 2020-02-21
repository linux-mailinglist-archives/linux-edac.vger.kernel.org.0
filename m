Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86035166FC1
	for <lists+linux-edac@lfdr.de>; Fri, 21 Feb 2020 07:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgBUGrO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 21 Feb 2020 01:47:14 -0500
Received: from inva020.nxp.com ([92.121.34.13]:41260 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727066AbgBUGrO (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 21 Feb 2020 01:47:14 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1D8891A6D94;
        Fri, 21 Feb 2020 07:47:12 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 27D6D1A6D8D;
        Fri, 21 Feb 2020 07:47:04 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 97AF64042D;
        Fri, 21 Feb 2020 14:46:08 +0800 (SGT)
From:   sherry sun <sherry.sun@nxp.com>
To:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rrichter@marvell.com, michal.simek@xilinx.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-edac@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, frank.li@nxp.com
Subject: [PATCH 2/3] EDAC: Add synopsys edac driver support for i.MX8MP
Date:   Fri, 21 Feb 2020 14:39:15 +0800
Message-Id: <1582267156-20189-3-git-send-email-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582267156-20189-1-git-send-email-sherry.sun@nxp.com>
References: <1582267156-20189-1-git-send-email-sherry.sun@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Sherry Sun <sherry.sun@nxp.com>

The i.MX8MP has a memory controller supported by this driver. So here
add edac driver for i.MX8MP based on synopsys edac driver.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/edac/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index fe2eb892a1bd..58a2d67d5513 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -475,7 +475,7 @@ config EDAC_ARMADA_XP
 
 config EDAC_SYNOPSYS
 	tristate "Synopsys DDR Memory Controller"
-	depends on ARCH_ZYNQ || ARCH_ZYNQMP
+	depends on ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_MXC
 	help
 	  Support for error detection and correction on the Synopsys DDR
 	  memory controller.
-- 
2.17.1

