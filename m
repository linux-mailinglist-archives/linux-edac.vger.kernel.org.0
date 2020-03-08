Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A74AD17D4CD
	for <lists+linux-edac@lfdr.de>; Sun,  8 Mar 2020 17:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgCHQde (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 8 Mar 2020 12:33:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:45330 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbgCHQde (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sun, 8 Mar 2020 12:33:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A70BCAFF7;
        Sun,  8 Mar 2020 16:33:32 +0000 (UTC)
Date:   Sun, 8 Mar 2020 17:33:35 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC urgent fix for 5.6
Message-ID: <20200308163335.GC12445@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Linus,

please pull the error reporting fix for synopsys_edac below. (Btw, doing
signed tags only from now on.)

Thx.

---
The following changes since commit f8788d86ab28f61f7b46eb6be375f8a726783636:

  Linux 5.6-rc3 (2020-02-23 16:17:42 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent-2020-03-08

for you to fetch changes up to dfc6014e3b60713f375d0601d7549eed224c4615:

  EDAC/synopsys: Do not print an error with back-to-back snprintf() calls (2020-02-27 16:44:25 +0100)

----------------------------------------------------------------
* Do not overwrite partial decoded error message in synopsys_edac (Sherry Sun)

----------------------------------------------------------------
Sherry Sun (1):
      EDAC/synopsys: Do not print an error with back-to-back snprintf() calls

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
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
