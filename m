Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8EA114D164
	for <lists+linux-edac@lfdr.de>; Wed, 29 Jan 2020 20:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbgA2TvR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 29 Jan 2020 14:51:17 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:58089 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgA2TvR (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 29 Jan 2020 14:51:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1580327477; x=1611863477;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=W17piQXMaWDxRZfOLyj1W0yKyPDXNP1W2liQWdMx6lk=;
  b=WqzfaXdubbIP0DADciHj2RXdiuJIiFGWM4jmT1VVVLI5eGZOgCZgb4M/
   4yWqd5zKPWgNtHIyjSpyEIvkyRTCx3ZnxB21lClJewHuTWe4Y+pnNib74
   RKFwLw7iAx2VoHzRt4TV+l3BEu5YZlFcqCDVw6U7kV3MYPeIWw6sv+S35
   Q=;
IronPort-SDR: nqicRwkJOCzJ7i7B68+RJ3g0Ilv9eg7gSaulI0Nj9gEUMY787O4EZ/H/T58A6WXB/ldkCZPxvV
 lg8RRiz+1WqQ==
X-IronPort-AV: E=Sophos;i="5.70,379,1574121600"; 
   d="scan'208";a="13912678"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-53356bf6.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 29 Jan 2020 19:51:14 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-53356bf6.us-west-2.amazon.com (Postfix) with ESMTPS id CF9E2A1CF6;
        Wed, 29 Jan 2020 19:51:12 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Wed, 29 Jan 2020 19:51:12 +0000
Received: from u8a88181e7b2355.ant.amazon.com (10.43.162.50) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 29 Jan 2020 19:51:01 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <bp@alien8.de>, <mchehab@kernel.org>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <rrichter@marvell.com>, <hhhawa@amazon.com>,
        <robh+dt@kernel.org>, <frowand.list@gmail.com>,
        <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <Jonathan.Cameron@huawei.com>, <arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <dwmw@amazon.co.uk>,
        <benh@amazon.com>, <ronenk@amazon.com>, <talel@amazon.com>,
        <jonnyc@amazon.com>, <hanochu@amazon.com>, <barakw@amazon.com>
Subject: [PATCH v9 2/3] of: EXPORT_SYMBOL_GPL of_find_next_cache_node
Date:   Wed, 29 Jan 2020 21:50:15 +0200
Message-ID: <20200129195016.956-3-hhhawa@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200129195016.956-1-hhhawa@amazon.com>
References: <20200129195016.956-1-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.50]
X-ClientProxiedBy: EX13D13UWB003.ant.amazon.com (10.43.161.233) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Make of_find_next_cache_node() available for modules.

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 drivers/of/base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index db7fbc0c0893..416286582b9b 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2224,6 +2224,7 @@ struct device_node *of_find_next_cache_node(const struct device_node *np)
 
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(of_find_next_cache_node);
 
 /**
  * of_find_last_cache_level - Find the level at which the last cache is
-- 
2.17.1

