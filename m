Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D7148D568
	for <lists+linux-edac@lfdr.de>; Thu, 13 Jan 2022 11:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiAMKGm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 13 Jan 2022 05:06:42 -0500
Received: from smtp-fw-9103.amazon.com ([207.171.188.200]:43763 "EHLO
        smtp-fw-9103.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiAMKGl (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 13 Jan 2022 05:06:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1642068400; x=1673604400;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yTT6Ven38nkWxOvaFHPHO4EqO2d8TTTnnFgagM+oe/w=;
  b=pIpjRNcjy10u2RHLjQWOZ0lQgqJTLFbR2LymhJPEgJunlOmfLOB1+2ZO
   2a1wSflmX+jThMjCNdv7c/CrAQaoCxUr/wenMB9W08up/zjP8wTxV3NTg
   8lNFNS0T/68bx5RCo8TnTxy5fWRqYxwyJRoFj8+t24qlxI9iWXg+bxW2k
   Y=;
X-IronPort-AV: E=Sophos;i="5.88,284,1635206400"; 
   d="scan'208";a="984504477"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-2dbf0206.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP; 13 Jan 2022 10:06:24 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-2dbf0206.us-west-2.amazon.com (Postfix) with ESMTPS id 79B48A2540;
        Thu, 13 Jan 2022 10:06:25 +0000 (UTC)
Received: from EX13D13UWB004.ant.amazon.com (10.43.161.218) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Thu, 13 Jan 2022 10:06:23 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13D13UWB004.ant.amazon.com (10.43.161.218) with Microsoft SMTP Server (TLS)
 id 15.0.1497.26; Thu, 13 Jan 2022 10:06:23 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.60.234) with Microsoft SMTP
 Server id 15.0.1497.26 via Frontend Transport; Thu, 13 Jan 2022 10:06:22
 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 971002E6D; Thu, 13 Jan 2022 10:06:22 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <bp@alien8.de>
CC:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ronenk@amazon.com>,
        <talel@amazon.com>, <hhhawa@amazon.com>, <jonnyc@amazon.com>,
        <hanochu@amazon.com>, <farbere@amazon.com>
Subject: [PATCH 3/4] EDAC: Refactor edac_align_ptr() to use u8/u16/u32/u64 data types
Date:   Thu, 13 Jan 2022 10:06:21 +0000
Message-ID: <20220113100622.12783-4-farbere@amazon.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220113100622.12783-1-farbere@amazon.com>
References: <20220113100622.12783-1-farbere@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Prefer well defined size variables, that are same in size across all
systems.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 drivers/edac/edac_mc.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 8b9b86a7720a..3367bf997b73 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -250,18 +250,13 @@ void *edac_align_ptr(void **p, unsigned size, int n_elems)
 	 * 'size'.  Adjust 'p' so that its alignment is at least as
 	 * stringent as what the compiler would provide for X and return
 	 * the aligned result.
-	 * Here we assume that the alignment of a "long long" is the most
-	 * stringent alignment that the compiler will ever provide by default.
-	 * As far as I know, this is a reasonable assumption.
 	 */
-	if (size > sizeof(long))
-		align = sizeof(long long);
-	else if (size > sizeof(int))
-		align = sizeof(long);
-	else if (size > sizeof(short))
-		align = sizeof(int);
-	else if (size > sizeof(char))
-		align = sizeof(short);
+	if (size > sizeof(u32))
+		align = sizeof(u64);
+	else if (size > sizeof(u16))
+		align = sizeof(u32);
+	else if (size > sizeof(u8))
+		align = sizeof(u16);
 	else
 		return ptr;
 
-- 
2.32.0

