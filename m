Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5AF618119A
	for <lists+linux-edac@lfdr.de>; Wed, 11 Mar 2020 08:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgCKHRc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 11 Mar 2020 03:17:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:38020 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgCKHRc (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 11 Mar 2020 03:17:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 218BDAD2C;
        Wed, 11 Mar 2020 07:17:30 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Jan Luebbe <jlu@pengutronix.de>
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        linux-edac@vger.kernel.org
Subject: [PATCH] EDAC: armada_xp: Use scnprintf() for avoiding potential buffer overflow
Date:   Wed, 11 Mar 2020 08:17:28 +0100
Message-Id: <20200311071728.4541-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Since snprintf() returns the would-be-output size instead of the
actual output size, the succeeding calls may go beyond the given
buffer limit.  Fix it by replacing with scnprintf().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/edac/armada_xp_edac.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/edac/armada_xp_edac.c b/drivers/edac/armada_xp_edac.c
index 7f227bdcbc84..a7502ebe9bdc 100644
--- a/drivers/edac/armada_xp_edac.c
+++ b/drivers/edac/armada_xp_edac.c
@@ -429,26 +429,26 @@ static void aurora_l2_check(struct edac_device_ctl_info *dci)
 
 	src = (attr_cap & AURORA_ERR_ATTR_SRC_MSK) >> AURORA_ERR_ATTR_SRC_OFF;
 	if (src <= 3)
-		len += snprintf(msg+len, size-len, "src=CPU%d ", src);
+		len += scnprintf(msg+len, size-len, "src=CPU%d ", src);
 	else
-		len += snprintf(msg+len, size-len, "src=IO ");
+		len += scnprintf(msg+len, size-len, "src=IO ");
 
 	txn =  (attr_cap & AURORA_ERR_ATTR_TXN_MSK) >> AURORA_ERR_ATTR_TXN_OFF;
 	switch (txn) {
 	case 0:
-		len += snprintf(msg+len, size-len, "txn=Data-Read ");
+		len += scnprintf(msg+len, size-len, "txn=Data-Read ");
 		break;
 	case 1:
-		len += snprintf(msg+len, size-len, "txn=Isn-Read ");
+		len += scnprintf(msg+len, size-len, "txn=Isn-Read ");
 		break;
 	case 2:
-		len += snprintf(msg+len, size-len, "txn=Clean-Flush ");
+		len += scnprintf(msg+len, size-len, "txn=Clean-Flush ");
 		break;
 	case 3:
-		len += snprintf(msg+len, size-len, "txn=Eviction ");
+		len += scnprintf(msg+len, size-len, "txn=Eviction ");
 		break;
 	case 4:
-		len += snprintf(msg+len, size-len,
+		len += scnprintf(msg+len, size-len,
 				"txn=Read-Modify-Write ");
 		break;
 	}
@@ -456,19 +456,19 @@ static void aurora_l2_check(struct edac_device_ctl_info *dci)
 	err = (attr_cap & AURORA_ERR_ATTR_ERR_MSK) >> AURORA_ERR_ATTR_ERR_OFF;
 	switch (err) {
 	case 0:
-		len += snprintf(msg+len, size-len, "err=CorrECC ");
+		len += scnprintf(msg+len, size-len, "err=CorrECC ");
 		break;
 	case 1:
-		len += snprintf(msg+len, size-len, "err=UnCorrECC ");
+		len += scnprintf(msg+len, size-len, "err=UnCorrECC ");
 		break;
 	case 2:
-		len += snprintf(msg+len, size-len, "err=TagParity ");
+		len += scnprintf(msg+len, size-len, "err=TagParity ");
 		break;
 	}
 
-	len += snprintf(msg+len, size-len, "addr=0x%x ", addr_cap & AURORA_ERR_ADDR_CAP_ADDR_MASK);
-	len += snprintf(msg+len, size-len, "index=0x%x ", (way_cap & AURORA_ERR_WAY_IDX_MSK) >> AURORA_ERR_WAY_IDX_OFF);
-	len += snprintf(msg+len, size-len, "way=0x%x", (way_cap & AURORA_ERR_WAY_CAP_WAY_MASK) >> AURORA_ERR_WAY_CAP_WAY_OFFSET);
+	len += scnprintf(msg+len, size-len, "addr=0x%x ", addr_cap & AURORA_ERR_ADDR_CAP_ADDR_MASK);
+	len += scnprintf(msg+len, size-len, "index=0x%x ", (way_cap & AURORA_ERR_WAY_IDX_MSK) >> AURORA_ERR_WAY_IDX_OFF);
+	len += scnprintf(msg+len, size-len, "way=0x%x", (way_cap & AURORA_ERR_WAY_CAP_WAY_MASK) >> AURORA_ERR_WAY_CAP_WAY_OFFSET);
 
 	/* clear error capture registers */
 	writel(AURORA_ERR_ATTR_CAP_VALID, drvdata->base + AURORA_ERR_ATTR_CAP_REG);
-- 
2.16.4

