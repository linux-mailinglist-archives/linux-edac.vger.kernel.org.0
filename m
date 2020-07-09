Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC303219865
	for <lists+linux-edac@lfdr.de>; Thu,  9 Jul 2020 08:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgGIGTv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 9 Jul 2020 02:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgGIGTu (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 9 Jul 2020 02:19:50 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52001C061A0B;
        Wed,  8 Jul 2020 23:19:50 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 02A16BC070;
        Thu,  9 Jul 2020 06:19:45 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     mchehab@kernel.org, bp@alien8.de, tony.luck@intel.com,
        james.morse@arm.com, rrichter@marvell.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH v2] EDAC-I7300: Replace HTTP links with HTTPS ones
Date:   Thu,  9 Jul 2020 08:19:38 +0200
Message-Id: <20200709061938.23869-1-grandmaster@al2klimov.de>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F68E520@ORSMSX115.amr.corp.intel.com>
References: <3908561D78D1C84285E8C5FCA982C28F7F68E520@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
X-Spam-Level: *****
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 drivers/edac/i7300_edac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/i7300_edac.c b/drivers/edac/i7300_edac.c
index 2e9bbe56cde9..4f28b8c8d378 100644
--- a/drivers/edac/i7300_edac.c
+++ b/drivers/edac/i7300_edac.c
@@ -5,7 +5,7 @@
  * Copyright (c) 2010 by:
  *	 Mauro Carvalho Chehab
  *
- * Red Hat Inc. http://www.redhat.com
+ * Red Hat Inc. https://www.redhat.com
  *
  * Intel 7300 Chipset Memory Controller Hub (MCH) - Datasheet
  *	http://www.intel.com/Assets/PDF/datasheet/318082.pdf
@@ -1206,7 +1206,7 @@ module_exit(i7300_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Mauro Carvalho Chehab");
-MODULE_AUTHOR("Red Hat Inc. (http://www.redhat.com)");
+MODULE_AUTHOR("Red Hat Inc. (https://www.redhat.com)");
 MODULE_DESCRIPTION("MC Driver for Intel I7300 memory controllers - "
 		   I7300_REVISION);
 
-- 
2.27.0

