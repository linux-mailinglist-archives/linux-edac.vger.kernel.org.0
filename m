Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8781879C4
	for <lists+linux-edac@lfdr.de>; Tue, 17 Mar 2020 07:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbgCQGjB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 17 Mar 2020 02:39:01 -0400
Received: from aclms3.advantech.com.tw ([125.252.70.86]:26083 "EHLO
        ACLMS3.advantech.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgCQGjB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 17 Mar 2020 02:39:01 -0400
X-Greylist: delayed 603 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Mar 2020 02:39:00 EDT
Received: from taipei08.ADVANTECH.CORP (unverified [172.20.0.235]) by ACLMS3.advantech.com.tw
 (Clearswift SMTPRS 5.6.0) with ESMTP id <Tddf54e8336ac1401c8808@ACLMS3.advantech.com.tw>;
 Tue, 17 Mar 2020 14:28:55 +0800
Received: from ADVANTECH.CORP (172.17.10.74) by taipei08.ADVANTECH.CORP
 (172.20.0.235) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 17 Mar
 2020 14:28:54 +0800
From:   <Amy.Shih@advantech.com.tw>
To:     <she90122@gmail.com>
CC:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <amy.shih@advantech.com.tw>, <oakley.ding@advantech.com.tw>
Subject: [v1,1/1] EDAC: (pnd2) Fix the log level for message "Failed to register device with error %d"
Date:   Tue, 17 Mar 2020 06:28:28 +0000
Message-ID: <20200317062828.18807-1-Amy.Shih@advantech.com.tw>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.17.10.74]
X-ClientProxiedBy: ACLDAG.ADVANTECH.CORP (172.20.2.88) To
 taipei08.ADVANTECH.CORP (172.20.0.235)
X-StopIT: No
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Amy Shih <amy.shih@advantech.com.tw>

Fix the log level from "KERN_ERR" to "KERN_INFO" for message "Failed to
register device with error %d", since it is not the error message but
the information to notice the user.

Signed-off-by: Amy Shih <amy.shih@advantech.com.tw>
---
 drivers/edac/pnd2_edac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
index 933f772..f15d3b4 100644
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -1572,7 +1572,8 @@ static int __init pnd2_init(void)
 
 	rc = pnd2_probe();
 	if (rc < 0) {
-		pnd2_printk(KERN_ERR, "Failed to register device with error %d.\n", rc);
+		pnd2_printk(KERN_INFO,
+			    "Failed to register device with error %d.\n", rc);
 		return rc;
 	}
 
-- 
1.8.3.1

