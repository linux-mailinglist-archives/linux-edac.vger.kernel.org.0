Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48BCA1CCBD8
	for <lists+linux-edac@lfdr.de>; Sun, 10 May 2020 17:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbgEJPOD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 10 May 2020 11:14:03 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:45553 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbgEJPOD (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 10 May 2020 11:14:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1589123643; x=1620659643;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=etN4ALYGPM9V5Q40WgjkffnHXlnsshVqeiFAxKMYC7U=;
  b=HUVSMkn2O1houaNaT1ZB59rpCl+5EdDvtrfNVMwa0OTizL59+KkNzznU
   2904QC0OLHd0PxKWUmGLgYEAWQXx8d56SiVVQENbaLG5Pzpb7CGAehxbI
   /NR4g30Mgnsd/pEWJVwmZa30km3FaKo2H6I5oCXm7/5sT/yQA1mjMvzyL
   A=;
IronPort-SDR: o4y9oeVXjV5s6bHibTXuvwjsE/+e1K7IK0Uh75vNEhER9mu88TKMVizogH17D7GM2qTOGFFynZ
 L5q2yvC2rV8Q==
X-IronPort-AV: E=Sophos;i="5.73,376,1583193600"; 
   d="scan'208";a="42338666"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-c300ac87.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 10 May 2020 15:14:01 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-c300ac87.us-west-2.amazon.com (Postfix) with ESMTPS id 41BC4A21E9;
        Sun, 10 May 2020 15:14:00 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 10 May 2020 15:13:59 +0000
Received: from u8a88181e7b2355.ant.amazon.com (10.43.161.174) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 10 May 2020 15:13:50 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <bp@alien8.de>, <mchehab@kernel.org>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <rrichter@marvell.com>, <hhhawa@amazon.com>,
        <robh+dt@kernel.org>, <frowand.list@gmail.com>,
        <davem@davemloft.net>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <dwmw@amazon.co.uk>,
        <benh@amazon.com>, <ronenk@amazon.com>, <talel@amazon.com>,
        <jonnyc@amazon.com>, <hanochu@amazon.com>, <eitan@amazon.com>
Subject: [PATCH v10 2/3] of: EXPORT_SYMBOL_GPL of_find_next_cache_node
Date:   Sun, 10 May 2020 18:13:09 +0300
Message-ID: <20200510151310.17372-3-hhhawa@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200510151310.17372-1-hhhawa@amazon.com>
References: <20200510151310.17372-1-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.174]
X-ClientProxiedBy: EX13D27UWB002.ant.amazon.com (10.43.161.167) To
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
index ae03b1218b06..1f8daf4c3398 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2174,6 +2174,7 @@ struct device_node *of_find_next_cache_node(const struct device_node *np)
 
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(of_find_next_cache_node);
 
 /**
  * of_find_last_cache_level - Find the level at which the last cache is
-- 
2.17.1

