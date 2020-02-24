Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA19516A2FC
	for <lists+linux-edac@lfdr.de>; Mon, 24 Feb 2020 10:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgBXJtZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Feb 2020 04:49:25 -0500
Received: from inva020.nxp.com ([92.121.34.13]:44078 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbgBXJtZ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 24 Feb 2020 04:49:25 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4A88A1AE2B7;
        Mon, 24 Feb 2020 10:49:23 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 879FA1AE2AD;
        Mon, 24 Feb 2020 10:49:17 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id DD0BB402D8;
        Mon, 24 Feb 2020 17:49:10 +0800 (SGT)
From:   Sherry Sun <sherry.sun@nxp.com>
To:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rrichter@marvell.com, michal.simek@xilinx.com
Cc:     linux-edac@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com, frank.li@nxp.com
Subject: [PATCH 2/3] EDAC: synopsys: Reorganizing the output message for CE/UE
Date:   Mon, 24 Feb 2020 17:42:36 +0800
Message-Id: <1582537357-10339-3-git-send-email-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582537357-10339-1-git-send-email-sherry.sun@nxp.com>
References: <1582537357-10339-1-git-send-email-sherry.sun@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The origin way which call sprintf() function two or three times to
output message for CE/UE is incorrect, because it won't output all the
message needed, instead it will only output the last message in
sprintf(). So the simplest and most effective way to fix this problem
is reorganizing all the output message needed for CE/UE into one
sprintf() function.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/edac/synopsys_edac.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 7046b8929522..ef7e907c7956 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -485,20 +485,14 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
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
-				 "DDR ECC error type:%s Row %d Bank %d ",
-				  "CE", pinf->row, pinf->bank);
-			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "BankGroup Number %d Block Number %d ",
-				 pinf->bankgrpnr, pinf->blknr);
-			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "Bit Position: %d Data: 0x%08x\n",
+				 "DDR ECC error type:%s Row %d Bank %d BankGroup Number %d Block Number %d Bit Position: %d Data: 0x%08x",
+				 "CE", pinf->row, pinf->bank,
+				 pinf->bankgrpnr, pinf->blknr,
 				 pinf->bitpos, pinf->data);
 		}
 
@@ -515,10 +509,8 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 				"UE", pinf->row, pinf->bank, pinf->col);
 		} else {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "DDR ECC error type :%s Row %d Bank %d ",
-				 "UE", pinf->row, pinf->bank);
-			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "BankGroup Number %d Block Number %d",
+				 "DDR ECC error type :%s Row %d Bank %d BankGroup Number %d Block Number %d",
+				 "UE", pinf->row, pinf->bank,
 				 pinf->bankgrpnr, pinf->blknr);
 		}
 
-- 
2.17.1

