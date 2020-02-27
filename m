Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D62731712AF
	for <lists+linux-edac@lfdr.de>; Thu, 27 Feb 2020 09:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbgB0Ikj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 27 Feb 2020 03:40:39 -0500
Received: from inva020.nxp.com ([92.121.34.13]:48058 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728440AbgB0Ikj (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 27 Feb 2020 03:40:39 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C4C111A27AF;
        Thu, 27 Feb 2020 09:40:36 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7DDEF1A2896;
        Thu, 27 Feb 2020 09:40:31 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 5C6BA402C4;
        Thu, 27 Feb 2020 16:40:25 +0800 (SGT)
From:   Sherry Sun <sherry.sun@nxp.com>
To:     james.morse@arm.com, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, rrichter@marvell.com, michal.simek@xilinx.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, frank.li@nxp.com
Subject: [PATCH V2] EDAC: synopsys: Fix back to back snprintf() messages for CE/UE
Date:   Thu, 27 Feb 2020 16:34:12 +0800
Message-Id: <1582792452-32575-1-git-send-email-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The current way which call snprintf() function two or three times to
output message for CE/UE is incorrect, because it won't output all the
message needed, instead it will only output the last message in
snprintf(). So the simplest and most effective way to fix this problem
is combining all the snprintf() message needed for CE/UE into one
snprintf() function.

Fixes: b500b4a029d57 ("EDAC, synopsys: Add ECC support for ZynqMP DDR controller")
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Reviewed-by: James Morse <james.morse@arm.com>
---
Changes in V2:
- Separated this patch from the original patchset.
- Change the subject to be more concise and clear.

---
 drivers/edac/synopsys_edac.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 2d263382d797..880ffd833718 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -479,20 +479,14 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 		pinf = &p->ceinfo;
 		if (!priv->p_data->quirks) {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "DDR ECC error type:%s Row %d Bank %d Col %d ",
-				  "CE", pinf->row, pinf->bank, pinf->col);
-			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "Bit Position: %d Data: 0x%08x\n",
+				 "DDR ECC error type:%s Row %d Bank %d Col %d Bit Position: %d Data: 0x%08x",
+				 "CE", pinf->row, pinf->bank, pinf->col,
 				 pinf->bitpos, pinf->data);
 		} else {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "DDR ECC error type:%s Row %d Bank %d Col %d ",
-				  "CE", pinf->row, pinf->bank, pinf->col);
-			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "BankGroup Number %d Block Number %d ",
-				 pinf->bankgrpnr, pinf->blknr);
-			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "Bit Position: %d Data: 0x%08x\n",
+				 "DDR ECC error type:%s Row %d Bank %d Col %d BankGroup Number %d Block Number %d Bit Position: %d Data: 0x%08x",
+				 "CE", pinf->row, pinf->bank, pinf->col,
+				 pinf->bankgrpnr, pinf->blknr,
 				 pinf->bitpos, pinf->data);
 		}
 
@@ -509,10 +503,8 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 				"UE", pinf->row, pinf->bank, pinf->col);
 		} else {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "DDR ECC error type :%s Row %d Bank %d Col %d ",
-				 "UE", pinf->row, pinf->bank, pinf->col);
-			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "BankGroup Number %d Block Number %d",
+				 "DDR ECC error type :%s Row %d Bank %d Col %d BankGroup Number %d Block Number %d",
+				 "UE", pinf->row, pinf->bank, pinf->col,
 				 pinf->bankgrpnr, pinf->blknr);
 		}
 
-- 
2.17.1

