Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A427ACE764
	for <lists+linux-edac@lfdr.de>; Mon,  7 Oct 2019 17:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfJGP0h (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 7 Oct 2019 11:26:37 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:22121 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbfJGP0g (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 7 Oct 2019 11:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1570461996; x=1601997996;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=xGLkeCy55JZslCZd5P+Gri+DOIbpI9xCoQlPZNd+zRA=;
  b=A9tDf8x4QswhcvJ0h+UHn6zW3VjthQhyvecxGbCz6A45p/8fFpmPAzy5
   vh1iHT+IbdoleALoOOhP+33siXxK27+qbtGxLAzSKGmg4oO9VpB5jkyAB
   mTHyIfIv/awPgWrnvY6vcLbqZw8xwT5I5bygsIsEHQLEKDLwWzNuP8YKL
   0=;
X-IronPort-AV: E=Sophos;i="5.67,268,1566864000"; 
   d="scan'208";a="707257350"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1a-807d4a99.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 07 Oct 2019 15:18:49 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-807d4a99.us-east-1.amazon.com (Postfix) with ESMTPS id BF3D6A1D9F;
        Mon,  7 Oct 2019 15:18:13 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 7 Oct 2019 15:18:12 +0000
Received: from ua9e4f3715fbc5f.ant.amazon.com (10.43.162.116) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 7 Oct 2019 15:18:02 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <bp@alien8.de>, <mchehab@kernel.org>, <mark.rutland@arm.com>,
        <james.morse@arm.com>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>, <davem@davemloft.net>,
        <gregkh@linuxfoundation.org>, <linus.walleij@linaro.org>,
        <daniel@iogearbox.net>, <paulmck@linux.ibm.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <dwmw@amazon.co.uk>,
        <benh@amazon.com>, <ronenk@amazon.com>, <talel@amazon.com>,
        <jonnyc@amazon.com>, <hanochu@amazon.com>, <hhhawa@amazon.com>
Subject: [PATCH v6 2/3] of: EXPORT_SYMBOL_GPL of_find_next_cache_node
Date:   Mon, 7 Oct 2019 16:17:29 +0100
Message-ID: <20191007151730.7705-3-hhhawa@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191007151730.7705-1-hhhawa@amazon.com>
References: <20191007151730.7705-1-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.116]
X-ClientProxiedBy: EX13D03UWC002.ant.amazon.com (10.43.162.160) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Make of_find_next_cache_node() available for modules.

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
---
 drivers/of/base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 20e0e7ee4edf..fe22c7428958 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2172,6 +2172,7 @@ struct device_node *of_find_next_cache_node(const struct device_node *np)
 
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(of_find_next_cache_node);
 
 /**
  * of_find_last_cache_level - Find the level at which the last cache is
-- 
2.17.1

