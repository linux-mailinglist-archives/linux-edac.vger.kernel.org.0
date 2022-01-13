Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A614D48D567
	for <lists+linux-edac@lfdr.de>; Thu, 13 Jan 2022 11:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiAMKGl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 13 Jan 2022 05:06:41 -0500
Received: from smtp-fw-80007.amazon.com ([99.78.197.218]:42547 "EHLO
        smtp-fw-80007.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiAMKGk (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 13 Jan 2022 05:06:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1642068401; x=1673604401;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Iz+I4bzIGgmHfCHsYZ6rNTtN23uutTDTQTkg7YnpZtM=;
  b=ZOckOUPVGTvVgg5b4+U24LL0NctugflI7wY7QwH4ObW0dP0QxKKeaBlB
   OU+nldW/udtFTcTknq15kezP6FfwoeMGREw49ClJ/UqbR4n9eMq9IJunF
   rxsGxRxbsOlLWYZwbwuK/uSmmA2apj4nqZ0JnQBqcswP2uf2j9rbPQEgD
   4=;
X-IronPort-AV: E=Sophos;i="5.88,284,1635206400"; 
   d="scan'208";a="55067096"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-0085f2c8.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP; 13 Jan 2022 10:06:24 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-0085f2c8.us-west-2.amazon.com (Postfix) with ESMTPS id F3F5041557;
        Thu, 13 Jan 2022 10:06:23 +0000 (UTC)
Received: from EX13D13UWB004.ant.amazon.com (10.43.161.218) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Thu, 13 Jan 2022 10:06:23 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D13UWB004.ant.amazon.com (10.43.161.218) with Microsoft SMTP Server (TLS)
 id 15.0.1497.26; Thu, 13 Jan 2022 10:06:23 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1497.28 via Frontend Transport; Thu, 13 Jan 2022 10:06:23
 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 9A16C3096; Thu, 13 Jan 2022 10:06:22 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <bp@alien8.de>
CC:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ronenk@amazon.com>,
        <talel@amazon.com>, <hhhawa@amazon.com>, <jonnyc@amazon.com>,
        <hanochu@amazon.com>, <farbere@amazon.com>
Subject: [PATCH 4/4] EDAC: Refactor edac_align_ptr() flow
Date:   Thu, 13 Jan 2022 10:06:22 +0000
Message-ID: <20220113100622.12783-5-farbere@amazon.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220113100622.12783-1-farbere@amazon.com>
References: <20220113100622.12783-1-farbere@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Modify flow to be more clear:
 - Calculate required alignment based on size.
 - Check if *p is aligned and fix if not.
 - Set return ptr to to be *p.
 - Increase *p by new size for the next call.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 drivers/edac/edac_mc.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 3367bf997b73..a3ff5a019fc7 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -241,9 +241,7 @@ EXPORT_SYMBOL_GPL(edac_mem_types);
 void *edac_align_ptr(void **p, unsigned size, int n_elems)
 {
 	unsigned align, r;
-	void *ptr = *p;
-
-	*p += size * n_elems;
+	void *ptr;
 
 	/*
 	 * 'p' can possibly be an unaligned item X such that sizeof(X) is
@@ -258,16 +256,22 @@ void *edac_align_ptr(void **p, unsigned size, int n_elems)
 	else if (size > sizeof(u8))
 		align = sizeof(u16);
 	else
-		return ptr;
-
-	r = (unsigned long)ptr % align;
+		goto out;
 
-	if (r == 0)
-		return ptr;
+	/* Calculate alignment, and fix *p if not aligned. */
+	r = (unsigned long)*p % align;
+	if (r)
+		*p += align - r;
 
-	*p += align - r;
+out:
+	/*
+	 * Set return ptr to to be *p (after alignment if it was needed),
+	 * and increase *p by new size for the next call.
+	 */
+	ptr = *p;
+	*p += size * n_elems;
 
-	return (void *)(((unsigned long)ptr) + align - r);
+	return ptr;
 }
 
 static void _edac_mc_free(struct mem_ctl_info *mci)
-- 
2.32.0

