Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8158BBC2A
	for <lists+linux-edac@lfdr.de>; Mon, 23 Sep 2019 21:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733306AbfIWTSl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 23 Sep 2019 15:18:41 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:53921 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbfIWTSl (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 23 Sep 2019 15:18:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1569266320; x=1600802320;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Ur37CA1iKM0CvWWtl8MTbbQZyu0mVRsZHKzDPOxlB2Q=;
  b=TV56YL5GhN2hCedrDZd7HdWhsWEnmkLzUf5JIfBO6EyYyIwV81dImCMq
   KOofK0AdUyzlDDRYGo92ZMg8dmRdATdaD52BocrFbyE5JVF0uIakZQ3wZ
   CKCKoo4MJMrU/QWkf8dSZOclVXRhyuOKbuIgYlN57SHTDoi0myJaiHAL9
   M=;
X-IronPort-AV: E=Sophos;i="5.64,541,1559520000"; 
   d="scan'208";a="836048499"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2c-2225282c.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 23 Sep 2019 19:18:18 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-2225282c.us-west-2.amazon.com (Postfix) with ESMTPS id 82BEFA1E5E;
        Mon, 23 Sep 2019 19:18:15 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 23 Sep 2019 19:18:14 +0000
Received: from ua9e4f3715fbc5f.ant.amazon.com (10.43.161.176) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 23 Sep 2019 19:18:08 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <bp@alien8.de>, <mchehab@kernel.org>, <james.morse@arm.com>,
        <rrichter@marvell.com>
CC:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dwmw@amazon.co.uk>, <benh@amazon.com>, <ronenk@amazon.com>,
        <talel@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <hhhawa@amazon.com>
Subject: [PATCH v4 2/2] edac: move edac_device_handle_*() API functions to header
Date:   Mon, 23 Sep 2019 20:17:41 +0100
Message-ID: <20190923191741.29322-3-hhhawa@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190923191741.29322-1-hhhawa@amazon.com>
References: <20190923191741.29322-1-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.176]
X-ClientProxiedBy: EX13D08UWC002.ant.amazon.com (10.43.162.168) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Move edac_device_handle_*() functions from source file to header file as
inline funtcion that use the new API with single error.

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
Acked-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/edac_device.c | 14 --------------
 drivers/edac/edac_device.h | 35 +++++++++++++----------------------
 2 files changed, 13 insertions(+), 36 deletions(-)

diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
index 6701fd3a8ce0..9460d892d222 100644
--- a/drivers/edac/edac_device.c
+++ b/drivers/edac/edac_device.c
@@ -645,17 +645,3 @@ void __edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
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
index 7869f036138a..e1d4e2544e24 100644
--- a/drivers/edac/edac_device.h
+++ b/drivers/edac/edac_device.h
@@ -312,28 +312,19 @@ void __edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
 			     unsigned int count, int inst_nr, int block_nr,
 			     const char *msg);
 
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
 
 static inline void edac_device_handle_ce_count(struct edac_device_ctl_info *edac_dev,
 					       unsigned int count, int inst_nr,
-- 
2.17.1

