Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9707E60607F
	for <lists+linux-edac@lfdr.de>; Thu, 20 Oct 2022 14:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiJTMpI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 20 Oct 2022 08:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiJTMpH (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 20 Oct 2022 08:45:07 -0400
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E09AFF8FE;
        Thu, 20 Oct 2022 05:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1666269905; x=1697805905;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=g+Mj6CRyj2LV1ySn2gOnQJn4NQ7XWVLANWajuKVQIGI=;
  b=eQZ0V3ZLWnl1AWwHWO4dXzuw7D7RDcRajyUkDSx0x6P0rih0T3HIOIl6
   fNe27++bUIJ314uzrHiM87S5W56RQDZY//nRY4cRsDEiLEBudJbxaHOH6
   w6mHufeVyF5q9TdJxhhTgsOyKgLyJ6NMw++USa7i5WEiFg1tIfCHcVOQ2
   o=;
X-IronPort-AV: E=Sophos;i="5.95,198,1661817600"; 
   d="scan'208";a="257694944"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-e823fbde.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 12:45:02 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1a-e823fbde.us-east-1.amazon.com (Postfix) with ESMTPS id 30B70C0A0C;
        Thu, 20 Oct 2022 12:44:59 +0000 (UTC)
Received: from EX19D013UWA004.ant.amazon.com (10.13.138.207) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.42; Thu, 20 Oct 2022 12:44:59 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX19D013UWA004.ant.amazon.com (10.13.138.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.15;
 Thu, 20 Oct 2022 12:44:59 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.60.234) with Microsoft SMTP
 Server id 15.0.1497.42 via Frontend Transport; Thu, 20 Oct 2022 12:44:58
 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 2E7284BBA; Thu, 20 Oct 2022 12:44:58 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <bp@alien8.de>, <mchehab@kernel.org>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <rric@kernel.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <talel@amazon.com>, <jonnyc@amazon.com>, <hhhawa@amazon.com>,
        <hanochu@amazon.com>, <farbere@amazon.com>, <itamark@amazon.com>,
        <shellykz@amazon.com>, <amitlavi@amazon.com>, <dkl@amazon.com>
Subject: [PATCH v2] edac: fix period calculation in edac_device_reset_delay_period()
Date:   Thu, 20 Oct 2022 12:44:58 +0000
Message-ID: <20221020124458.22153-1-farbere@amazon.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-12.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Fix period calculation in case user sets a value of 1000.
The input of round_jiffies_relative() should be in jiffies and not in
milli-seconds.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
v2 --> v1:
- Fix the bug without modifying jiffs which is used to set
  edac_dev->delay.

 drivers/edac/edac_device.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
index 19522c568aa5..e944dd9b3593 100644
--- a/drivers/edac/edac_device.c
+++ b/drivers/edac/edac_device.c
@@ -398,13 +398,13 @@ void edac_device_reset_delay_period(struct edac_device_ctl_info *edac_dev,
 {
 	unsigned long jiffs = msecs_to_jiffies(value);
 
-	if (value == 1000)
-		jiffs = round_jiffies_relative(value);
-
 	edac_dev->poll_msec = value;
 	edac_dev->delay	    = jiffs;
 
-	edac_mod_work(&edac_dev->work, jiffs);
+	if (value == 1000)
+		edac_mod_work(&edac_dev->work, round_jiffies_relative(jiffs));
+	else
+		edac_mod_work(&edac_dev->work, jiffs);
 }
 
 int edac_device_alloc_index(void)
-- 
2.37.1

