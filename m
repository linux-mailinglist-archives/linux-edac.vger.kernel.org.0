Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB3C4B7FD4
	for <lists+linux-edac@lfdr.de>; Thu, 19 Sep 2019 19:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391339AbfISRRw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 19 Sep 2019 13:17:52 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:34983 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390155AbfISRRw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 19 Sep 2019 13:17:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568913471; x=1600449471;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=O4eZ3KV5H3cbWZUv6d/fj3CQJRxb49xJtLU/UPgKy3k=;
  b=ed7hBoQ/gnbdzP57tBDBqqbrlxFtmnIiZSv/947fNvgwHqmbTvoBkobC
   LmWnB04x2JUjCs43oB4j4NYv5d4xYzeFMQlLGRVfWsWYaxXTRpws1dEuw
   5fQmQuOGzvUuT6E4LlwlSX7qoIZknvcc1EKEnUl0TixWi4LmYAZ1MVEhn
   k=;
X-IronPort-AV: E=Sophos;i="5.64,524,1559520000"; 
   d="scan'208";a="785851144"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-821c648d.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 19 Sep 2019 17:17:49 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-821c648d.us-east-1.amazon.com (Postfix) with ESMTPS id B79AEA225C;
        Thu, 19 Sep 2019 17:17:47 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 19 Sep 2019 17:17:46 +0000
Received: from ua9e4f3715fbc5f.ant.amazon.com (10.43.160.5) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 19 Sep 2019 17:17:40 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <bp@alien8.de>, <mchehab@kernel.org>, <james.morse@arm.com>,
        <rrichter@marvell.com>
CC:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dwmw@amazon.co.uk>, <benh@amazon.com>, <ronenk@amazon.com>,
        <talel@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <hhhawa@amazon.com>
Subject: [PATCH v3 2/2] edac: move edac_device_handle_*() API functions to header
Date:   Thu, 19 Sep 2019 18:17:13 +0100
Message-ID: <20190919171713.8060-3-hhhawa@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190919171713.8060-1-hhhawa@amazon.com>
References: <20190919171713.8060-1-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.5]
X-ClientProxiedBy: EX13D06UWC002.ant.amazon.com (10.43.162.205) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Move edac_device_handle_*() functions from source file to header file as
inline funtcion that use the new API with single error.

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
---
 drivers/edac/edac_device.c | 14 --------------
 drivers/edac/edac_device.h | 37 ++++++++++++++-----------------------
 2 files changed, 14 insertions(+), 37 deletions(-)

diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
index 866934f2bcb0..d54223594916 100644
--- a/drivers/edac/edac_device.c
+++ b/drivers/edac/edac_device.c
@@ -651,17 +651,3 @@ void __edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
 		      block ? block->name : "N/A", count, msg);
 }
 EXPORT_SYMBOL_GPL(__edac_device_handle_ue);
-
-void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
-			int inst_nr, int block_nr, const char *msg)
-{
-	__edac_device_handle_ce(edac_dev, 1, inst_nr, block_nr, msg);
-}
-EXPORT_SYMBOL_GPL(edac_device_handle_ce);
-
-void edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
-			int inst_nr, int block_nr, const char *msg)
-{
-	__edac_device_handle_ue(edac_dev, 1, inst_nr, block_nr, msg);
-}
-EXPORT_SYMBOL_GPL(edac_device_handle_ue);
diff --git a/drivers/edac/edac_device.h b/drivers/edac/edac_device.h
index 30dc5f5979c8..796ea134a691 100644
--- a/drivers/edac/edac_device.h
+++ b/drivers/edac/edac_device.h
@@ -285,29 +285,6 @@ extern int edac_device_add_device(struct edac_device_ctl_info *edac_dev);
  */
 extern struct edac_device_ctl_info *edac_device_del_device(struct device *dev);
 
-/**
- * edac_device_handle_ue():
- *	perform a common output and handling of an 'edac_dev' UE event
- *
- * @edac_dev: pointer to struct &edac_device_ctl_info
- * @inst_nr: number of the instance where the UE error happened
- * @block_nr: number of the block where the UE error happened
- * @msg: message to be printed
- */
-extern void edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
-				int inst_nr, int block_nr, const char *msg);
-/**
- * edac_device_handle_ce():
- *	perform a common output and handling of an 'edac_dev' CE event
- *
- * @edac_dev: pointer to struct &edac_device_ctl_info
- * @inst_nr: number of the instance where the CE error happened
- * @block_nr: number of the block where the CE error happened
- * @msg: message to be printed
- */
-extern void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
-				int inst_nr, int block_nr, const char *msg);
-
 /**
  * edac_device_alloc_index: Allocate a unique device index number
  *
@@ -357,4 +334,18 @@ static inline void edac_device_handle_ue_count(struct edac_device_ctl_info *edac
 {
 	__edac_device_handle_ue(edac_dev, count, inst_nr, block_nr, msg);
 }
+
+static inline void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
+					 int inst_nr, int block_nr,
+					 const char *msg)
+{
+	__edac_device_handle_ce(edac_dev, 1, inst_nr, block_nr, msg);
+}
+
+static inline void edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
+					 int inst_nr, int block_nr,
+					 const char *msg)
+{
+	__edac_device_handle_ue(edac_dev, 1, inst_nr, block_nr, msg);
+}
 #endif
-- 
2.17.1

