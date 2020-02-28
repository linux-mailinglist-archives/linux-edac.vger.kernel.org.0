Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91158172ECA
	for <lists+linux-edac@lfdr.de>; Fri, 28 Feb 2020 03:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbgB1CWs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 27 Feb 2020 21:22:48 -0500
Received: from inva021.nxp.com ([92.121.34.21]:53948 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726943AbgB1CWs (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 27 Feb 2020 21:22:48 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7D7DF209FF2;
        Fri, 28 Feb 2020 03:22:46 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B66CD208396;
        Fri, 28 Feb 2020 03:22:40 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 89744402AD;
        Fri, 28 Feb 2020 10:22:33 +0800 (SGT)
From:   Sherry Sun <sherry.sun@nxp.com>
To:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rrichter@marvell.com, michal.simek@xilinx.com,
        manish.narani@xilinx.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, frank.li@nxp.com
Subject: [PATCH v2] EDAC: synopsys: Fix the wrong call of pinf->col parameter
Date:   Fri, 28 Feb 2020 10:16:23 +0800
Message-Id: <1582856183-5007-1-git-send-email-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Since ZynqMP platform call zynqmp_get_error_info() function to get ce/ue
information. In this function, pinf->col parameter is not used, this
parameter is only used by Zynq platforme in zynq_get_error_info(). So
here pinf->col should not be called and printed for ZynqMP, need remove
it.

Fixes: b500b4a029d57 ("EDAC, synopsys: Add ECC support for ZynqMP DDR controller")
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
This patch is based on [PATCH V2] EDAC: synopsys: Fix back to back snprintf() messages for CE/UE
Changes in V2:
- Separated this patch from the original patchset.

---
 drivers/edac/synopsys_edac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 880ffd833718..da707d539f7f 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -484,8 +484,8 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 				 pinf->bitpos, pinf->data);
 		} else {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "DDR ECC error type:%s Row %d Bank %d Col %d BankGroup Number %d Block Number %d Bit Position: %d Data: 0x%08x",
-				 "CE", pinf->row, pinf->bank, pinf->col,
+				 "DDR ECC error type:%s Row %d Bank %d BankGroup Number %d Block Number %d Bit Position: %d Data: 0x%08x",
+				 "CE", pinf->row, pinf->bank,
 				 pinf->bankgrpnr, pinf->blknr,
 				 pinf->bitpos, pinf->data);
 		}
@@ -503,8 +503,8 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 				"UE", pinf->row, pinf->bank, pinf->col);
 		} else {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "DDR ECC error type :%s Row %d Bank %d Col %d BankGroup Number %d Block Number %d",
-				 "UE", pinf->row, pinf->bank, pinf->col,
+				 "DDR ECC error type :%s Row %d Bank %d BankGroup Number %d Block Number %d",
+				 "UE", pinf->row, pinf->bank,
 				 pinf->bankgrpnr, pinf->blknr);
 		}
 
-- 
2.17.1

