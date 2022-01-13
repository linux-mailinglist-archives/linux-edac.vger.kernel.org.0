Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7249E48D564
	for <lists+linux-edac@lfdr.de>; Thu, 13 Jan 2022 11:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiAMKGi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 13 Jan 2022 05:06:38 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:25523 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiAMKGg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 13 Jan 2022 05:06:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1642068396; x=1673604396;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9iBuEMkjnN/BTukgwf9Qul/VAIKXqO12+ruyZw7dlfQ=;
  b=QqCrnLCl/HzryU9zdi+lMTp+NrmNEXlfuqE/K91xU4WfDyRVADgUtFV3
   H3wgw93MTBibXWmRFtHtSQiTWtMUkjrnEHsClMMWQhUVFOZ4siU8Q4hiC
   JhUPji4sEPn9Gx8GH9swFB+prGmpdPFyiZZ8RFE5EyOAKjv7wyNNo/lF/
   E=;
X-IronPort-AV: E=Sophos;i="5.88,284,1635206400"; 
   d="scan'208";a="170130780"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-0085f2c8.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP; 13 Jan 2022 10:06:24 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-0085f2c8.us-west-2.amazon.com (Postfix) with ESMTPS id D2AD441532;
        Thu, 13 Jan 2022 10:06:23 +0000 (UTC)
Received: from EX13D13UWB002.ant.amazon.com (10.43.161.21) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Thu, 13 Jan 2022 10:06:23 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D13UWB002.ant.amazon.com (10.43.161.21) with Microsoft SMTP Server (TLS)
 id 15.0.1497.26; Thu, 13 Jan 2022 10:06:23 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP
 Server id 15.0.1497.28 via Frontend Transport; Thu, 13 Jan 2022 10:06:23
 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 9419E2D9C; Thu, 13 Jan 2022 10:06:22 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <bp@alien8.de>
CC:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ronenk@amazon.com>,
        <talel@amazon.com>, <hhhawa@amazon.com>, <jonnyc@amazon.com>,
        <hanochu@amazon.com>, <farbere@amazon.com>
Subject: [PATCH 2/4] EDAC: Remove unnecessary cast to char* in edac_align_ptr() function
Date:   Thu, 13 Jan 2022 10:06:20 +0000
Message-ID: <20220113100622.12783-3-farbere@amazon.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220113100622.12783-1-farbere@amazon.com>
References: <20220113100622.12783-1-farbere@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Amend commit 7391c6dcab30 ("drivers/edac: mod edac_align_ptr function")
and change all return path to use void* instead of char* according
to the new signature.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 drivers/edac/edac_mc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 61d72bd96754..8b9b86a7720a 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -263,12 +263,12 @@ void *edac_align_ptr(void **p, unsigned size, int n_elems)
 	else if (size > sizeof(char))
 		align = sizeof(short);
 	else
-		return (char *)ptr;
+		return ptr;
 
 	r = (unsigned long)ptr % align;
 
 	if (r == 0)
-		return (char *)ptr;
+		return ptr;
 
 	*p += align - r;
 
-- 
2.32.0

