Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E98F19A67B
	for <lists+linux-edac@lfdr.de>; Wed,  1 Apr 2020 09:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732044AbgDAHrS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 1 Apr 2020 03:47:18 -0400
Received: from inva021.nxp.com ([92.121.34.21]:54950 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731997AbgDAHrQ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 1 Apr 2020 03:47:16 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7EEEC200C8C;
        Wed,  1 Apr 2020 09:47:15 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2BEBE200C89;
        Wed,  1 Apr 2020 09:47:10 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id BBF2F40328;
        Wed,  1 Apr 2020 15:47:03 +0800 (SGT)
From:   Sherry Sun <sherry.sun@nxp.com>
To:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rrichter@marvell.com, michal.simek@xilinx.com,
        manish.narani@xilinx.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        frank.li@nxp.com
Subject: [PATCH v2 2/4] EDAC: Add synopsys edac driver support for i.MX8MP
Date:   Wed,  1 Apr 2020 15:39:07 +0800
Message-Id: <1585726749-13039-3-git-send-email-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585726749-13039-1-git-send-email-sherry.sun@nxp.com>
References: <1585726749-13039-1-git-send-email-sherry.sun@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

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

