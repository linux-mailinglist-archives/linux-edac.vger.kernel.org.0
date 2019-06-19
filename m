Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 928834B326
	for <lists+linux-edac@lfdr.de>; Wed, 19 Jun 2019 09:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730791AbfFSHeq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 19 Jun 2019 03:34:46 -0400
Received: from mail5.windriver.com ([192.103.53.11]:48350 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbfFSHeq (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 19 Jun 2019 03:34:46 -0400
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x5J7X9OX014063
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 19 Jun 2019 00:33:24 -0700
Received: from pek-lpggp2 (128.224.153.75) by ALA-HCB.corp.ad.wrs.com
 (147.11.189.41) with Microsoft SMTP Server id 14.3.439.0; Wed, 19 Jun 2019
 00:32:58 -0700
Received: by pek-lpggp2 (Postfix, from userid 20544)    id BAE5E72061C; Wed, 19
 Jun 2019 15:15:20 +0800 (CST)
From:   Jiping Ma <jiping.ma2@windriver.com>
To:     <jbaron@akamai.com>
CC:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mchehab@kernel.org>, <bp@alien8.de>, <jiping.ma2@windriver.com>
Subject: [PATCH] EDAC, ie31200: Add Intel Corporation 3rd Gen Core processor
Date:   Wed, 19 Jun 2019 15:15:18 +0800
Message-ID: <1560928518-243100-2-git-send-email-jiping.ma2@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1560928518-243100-1-git-send-email-jiping.ma2@windriver.com>
References: <1560928518-243100-1-git-send-email-jiping.ma2@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

3rd Gen Core seems to work just like Skylake.

Signed-off-by: Jiping Ma <jiping.ma2@windriver.com>
---
 drivers/edac/ie31200_edac.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index aac9b9b..1445336 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -19,6 +19,7 @@
  * 0c08: Xeon E3-1200 v3 Processor DRAM Controller
  * 1918: Xeon E3-1200 v5 Skylake Host Bridge/DRAM Registers
  * 5918: Xeon E3-1200 Xeon E3-1200 v6/7th Gen Core Processor Host Bridge/DRAM Registers
+ * 0154: 3rd Gen Core processor DRAM Controller
  *
  * Based on Intel specification:
  * http://www.intel.com/content/dam/www/public/us/en/documents/datasheets/xeon-e3-1200v3-vol-2-datasheet.pdf
@@ -59,6 +60,7 @@
 #define PCI_DEVICE_ID_INTEL_IE31200_HB_7 0x0c08
 #define PCI_DEVICE_ID_INTEL_IE31200_HB_8 0x1918
 #define PCI_DEVICE_ID_INTEL_IE31200_HB_9 0x5918
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_10 0x0154
 
 #define IE31200_DIMMS			4
 #define IE31200_RANKS			8
@@ -569,6 +571,9 @@ static void ie31200_remove_one(struct pci_dev *pdev)
 		PCI_VEND_DEV(INTEL, IE31200_HB_9), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		IE31200},
 	{
+		PCI_VEND_DEV(INTEL, IE31200_HB_10), PCI_ANY_ID, PCI_ANY_ID, 0, 0
+		, IE31200},
+	{
 		0,
 	}            /* 0 terminated list. */
 };
-- 
1.9.1

