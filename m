Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD396145290
	for <lists+linux-edac@lfdr.de>; Wed, 22 Jan 2020 11:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgAVK0P (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 22 Jan 2020 05:26:15 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:63676 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728931AbgAVK0P (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 22 Jan 2020 05:26:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1579688774; x=1611224774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=q1HmxflKg5RJkSzpVrAiFLEw/He8edTOjzy4l2VYtIg=;
  b=mRwiNRAab1UVkPBMCiwJkl1CpBIkUVkQLLt7f9719V8ZsH++/RekIqjP
   A8oFQI5FIBRuakciz6Ut6JFJKJdB62zy44JkUGy3JbU6lDypksXXgnJDj
   uEJflIJ4OcrIqQe3zNU/JVXLPL9xzbrnlODK/D9EbzULkklioSW3GlHNk
   w=;
IronPort-SDR: 04TQwjRwwVdCNlyVcWD/oReZh5voAJY9gQEkB9glJhN5nhUa6+Rw4KZcEZeXuKTHCZwzeMhK41
 dfETuyWqQsTw==
X-IronPort-AV: E=Sophos;i="5.70,349,1574121600"; 
   d="scan'208";a="21698462"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 22 Jan 2020 10:26:03 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com (Postfix) with ESMTPS id 36743A2406;
        Wed, 22 Jan 2020 10:25:57 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Wed, 22 Jan 2020 10:25:57 +0000
Received: from u8a88181e7b2355.ant.amazon.com (10.43.161.78) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 22 Jan 2020 10:25:47 +0000
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
Subject: [PATCH v8 2/3] of: EXPORT_SYMBOL_GPL of_find_next_cache_node
Date:   Wed, 22 Jan 2020 12:25:12 +0200
Message-ID: <20200122102513.31132-3-hhhawa@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200122102513.31132-1-hhhawa@amazon.com>
References: <20200122102513.31132-1-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.78]
X-ClientProxiedBy: EX13D28UWB004.ant.amazon.com (10.43.161.56) To
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
index 1d667eb730e1..9f5610f55ed6 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2212,6 +2212,7 @@ struct device_node *of_find_next_cache_node(const struct device_node *np)
 
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(of_find_next_cache_node);
 
 /**
  * of_find_last_cache_level - Find the level at which the last cache is
-- 
2.17.1

