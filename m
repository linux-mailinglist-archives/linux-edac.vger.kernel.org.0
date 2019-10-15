Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC87D7628
	for <lists+linux-edac@lfdr.de>; Tue, 15 Oct 2019 14:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfJOMNQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Oct 2019 08:13:16 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:14668 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfJOMNP (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 15 Oct 2019 08:13:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1571141594; x=1602677594;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=xGLkeCy55JZslCZd5P+Gri+DOIbpI9xCoQlPZNd+zRA=;
  b=uspgVD+PWGXTmKbng5j0/wanVhwLetMZhdlY1VsIK3WRMIx5+Jr+5A2Z
   GuvnZVqQmjWSdNhtXQBIlgGHYQwgsoEJtLGoAiPRAoGI26Jj8on7olE+S
   j7ZNRHyOB2MYpI082n5b3ZEfpHwRXu1C02O+I4Ucdgg6wPsBJIIfwypnm
   I=;
X-IronPort-AV: E=Sophos;i="5.67,299,1566864000"; 
   d="scan'208";a="429217749"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-55156cd4.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 15 Oct 2019 12:10:14 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-55156cd4.us-west-2.amazon.com (Postfix) with ESMTPS id 0C4BCA1FA9;
        Tue, 15 Oct 2019 12:10:12 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 15 Oct 2019 12:10:12 +0000
Received: from ua9e4f3715fbc5f.ant.amazon.com (10.43.162.200) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 15 Oct 2019 12:10:02 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <bp@alien8.de>, <mchehab@kernel.org>, <mark.rutland@arm.com>,
        <james.morse@arm.com>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>, <davem@davemloft.net>,
        <gregkh@linuxfoundation.org>, <linus.walleij@linaro.org>,
        <daniel@iogearbox.net>, <paulmck@linux.ibm.com>,
        <Sudeep.Holla@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <dwmw@amazon.co.uk>,
        <benh@amazon.com>, <ronenk@amazon.com>, <talel@amazon.com>,
        <jonnyc@amazon.com>, <hanochu@amazon.com>, <hhhawa@amazon.com>
Subject: [PATCH v7 2/3] of: EXPORT_SYMBOL_GPL of_find_next_cache_node
Date:   Tue, 15 Oct 2019 13:09:26 +0100
Message-ID: <20191015120927.10470-3-hhhawa@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191015120927.10470-1-hhhawa@amazon.com>
References: <20191015120927.10470-1-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.200]
X-ClientProxiedBy: EX13D25UWB003.ant.amazon.com (10.43.161.33) To
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

