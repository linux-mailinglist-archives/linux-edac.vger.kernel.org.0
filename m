Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0368148D563
	for <lists+linux-edac@lfdr.de>; Thu, 13 Jan 2022 11:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiAMKGg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 13 Jan 2022 05:06:36 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:25523 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiAMKGe (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 13 Jan 2022 05:06:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1642068394; x=1673604394;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OEe8UJVrva6O5WnViJeZduwrLI034dWRHuRnXhh70zI=;
  b=VLXN78iYjS6+di/rVojm/NsegUF+/Z+XChSH2hEa0uKTAfNKfwx/rSYd
   R+jPyt74FQiWo7ihvYI97eXioVizUYkop8UV61mHvxpqj8ZwHGTmwtuAl
   mzHxd39qmf55s3UyHec3z44zFbzcIuNE28N0SORAVzIoDwA4Omwjao3T8
   c=;
X-IronPort-AV: E=Sophos;i="5.88,284,1635206400"; 
   d="scan'208";a="170130791"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-2dbf0206.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP; 13 Jan 2022 10:06:25 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-2dbf0206.us-west-2.amazon.com (Postfix) with ESMTPS id 5ED61A253F;
        Thu, 13 Jan 2022 10:06:25 +0000 (UTC)
Received: from EX13D13UWB003.ant.amazon.com (10.43.161.233) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Thu, 13 Jan 2022 10:06:23 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D13UWB003.ant.amazon.com (10.43.161.233) with Microsoft SMTP Server (TLS)
 id 15.0.1497.26; Thu, 13 Jan 2022 10:06:23 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP
 Server id 15.0.1497.28 via Frontend Transport; Thu, 13 Jan 2022 10:06:22
 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 912FA2D7B; Thu, 13 Jan 2022 10:06:22 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <bp@alien8.de>
CC:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ronenk@amazon.com>,
        <talel@amazon.com>, <hhhawa@amazon.com>, <jonnyc@amazon.com>,
        <hanochu@amazon.com>, <farbere@amazon.com>
Subject: [PATCH 1/4] EDAC: Fix calculation of returned address and next offset in edac_align_ptr()
Date:   Thu, 13 Jan 2022 10:06:19 +0000
Message-ID: <20220113100622.12783-2-farbere@amazon.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220113100622.12783-1-farbere@amazon.com>
References: <20220113100622.12783-1-farbere@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Do alignment logic properly and use 'ptr' for calculating the remainder
of the alignment.

This became an issue because 'struct edac_mc_layer' has a size that is
not zero modulo eight, and the next offset that was prepared for the
private-data was unaligned, causing an alignment exception.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 drivers/edac/edac_mc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index fd440b35d76e..61d72bd96754 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -265,7 +265,7 @@ void *edac_align_ptr(void **p, unsigned size, int n_elems)
 	else
 		return (char *)ptr;
 
-	r = (unsigned long)p % align;
+	r = (unsigned long)ptr % align;
 
 	if (r == 0)
 		return (char *)ptr;
-- 
2.32.0

