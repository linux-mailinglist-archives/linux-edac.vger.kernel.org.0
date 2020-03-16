Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E72D2186C51
	for <lists+linux-edac@lfdr.de>; Mon, 16 Mar 2020 14:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731154AbgCPNlf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 16 Mar 2020 09:41:35 -0400
Received: from inva021.nxp.com ([92.121.34.21]:54992 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730970AbgCPNlf (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 16 Mar 2020 09:41:35 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A4EBC200A2C;
        Mon, 16 Mar 2020 14:41:32 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id ED6EA200A31;
        Mon, 16 Mar 2020 14:41:26 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id DEFEC402E4;
        Mon, 16 Mar 2020 21:41:19 +0800 (SGT)
From:   Sherry Sun <sherry.sun@nxp.com>
To:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rrichter@marvell.com, michal.simek@xilinx.com,
        manish.narani@xilinx.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, frank.li@nxp.com
Subject: [patch v3] EDAC: synopsys: Fix the wrong call of pinf->col parameter
Date:   Mon, 16 Mar 2020 21:34:39 +0800
Message-Id: <1584365679-27443-1-git-send-email-sherry.sun@nxp.com>
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

In order to show which function called handle_error() explicitly, here
use DDR_ECC_INTR_SUPPORT as check condition to distinguish Zynq and
ZynqMP platform instead the current way.

Fixes: b500b4a029d57 ("EDAC, synopsys: Add ECC support for ZynqMP DDR controller")
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Reviewed-by: Manish Narani <manish.narani@xilinx.com>
---
Changes in V3:
- Make the check condition in handle_error() more explicitly, use 
quirks & DDR_ECC_INTR_SUPPORT instead !quirks, and exchange the context in
if/else.

Changes in V2:
- Separated this patch from the original patchset.

---
 drivers/edac/synopsys_edac.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 880ffd833718..12211dc040e8 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -477,16 +477,16 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 
 	if (p->ce_cnt) {
 		pinf = &p->ceinfo;
-		if (!priv->p_data->quirks) {
+		if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "DDR ECC error type:%s Row %d Bank %d Col %d Bit Position: %d Data: 0x%08x",
-				 "CE", pinf->row, pinf->bank, pinf->col,
+				 "DDR ECC error type:%s Row %d Bank %d BankGroup Number %d Block Number %d Bit Position: %d Data: 0x%08x",
+				 "CE", pinf->row, pinf->bank,
+				 pinf->bankgrpnr, pinf->blknr,
 				 pinf->bitpos, pinf->data);
 		} else {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "DDR ECC error type:%s Row %d Bank %d Col %d BankGroup Number %d Block Number %d Bit Position: %d Data: 0x%08x",
+				 "DDR ECC error type:%s Row %d Bank %d Col %d Bit Position: %d Data: 0x%08x",
 				 "CE", pinf->row, pinf->bank, pinf->col,
-				 pinf->bankgrpnr, pinf->blknr,
 				 pinf->bitpos, pinf->data);
 		}
 
@@ -497,15 +497,15 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 
 	if (p->ue_cnt) {
 		pinf = &p->ueinfo;
-		if (!priv->p_data->quirks) {
+		if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "DDR ECC error type :%s Row %d Bank %d Col %d ",
-				"UE", pinf->row, pinf->bank, pinf->col);
+				 "DDR ECC error type :%s Row %d Bank %d BankGroup Number %d Block Number %d",
+				 "UE", pinf->row, pinf->bank,
+				 pinf->bankgrpnr, pinf->blknr);
 		} else {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "DDR ECC error type :%s Row %d Bank %d Col %d BankGroup Number %d Block Number %d",
-				 "UE", pinf->row, pinf->bank, pinf->col,
-				 pinf->bankgrpnr, pinf->blknr);
+				 "DDR ECC error type :%s Row %d Bank %d Col %d ",
+				 "UE", pinf->row, pinf->bank, pinf->col);
 		}
 
 		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
-- 
2.17.1

