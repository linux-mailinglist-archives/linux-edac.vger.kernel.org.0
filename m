Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B8C2191BF
	for <lists+linux-edac@lfdr.de>; Wed,  8 Jul 2020 22:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgGHUof (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 8 Jul 2020 16:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgGHUof (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 8 Jul 2020 16:44:35 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D9AC061A0B;
        Wed,  8 Jul 2020 13:44:35 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 9A107BC0CB;
        Wed,  8 Jul 2020 20:44:31 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     mchehab@kernel.org, bp@alien8.de, tony.luck@intel.com,
        james.morse@arm.com, rrichter@marvell.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] EDAC-I7300: Replace HTTP links with HTTPS ones
Date:   Wed,  8 Jul 2020 22:44:25 +0200
Message-Id: <20200708204425.22444-1-grandmaster@al2klimov.de>
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
 Continuing my work started at 93431e0607e5.
 See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
 (Actually letting a shell for loop submit all this stuff for me.)

 If there are any URLs to be removed completely or at least not HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.


 drivers/edac/i7300_edac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/i7300_edac.c b/drivers/edac/i7300_edac.c
index 2e9bbe56cde9..7d19f88b084b 100644
--- a/drivers/edac/i7300_edac.c
+++ b/drivers/edac/i7300_edac.c
@@ -5,10 +5,10 @@
  * Copyright (c) 2010 by:
  *	 Mauro Carvalho Chehab
  *
- * Red Hat Inc. http://www.redhat.com
+ * Red Hat Inc. https://www.redhat.com
  *
  * Intel 7300 Chipset Memory Controller Hub (MCH) - Datasheet
- *	http://www.intel.com/Assets/PDF/datasheet/318082.pdf
+ *	https://www.intel.com/Assets/PDF/datasheet/318082.pdf
  *
  * TODO: The chipset allow checking for PCI Express errors also. Currently,
  *	 the driver covers only memory error errors
@@ -1206,7 +1206,7 @@ module_exit(i7300_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Mauro Carvalho Chehab");
-MODULE_AUTHOR("Red Hat Inc. (http://www.redhat.com)");
+MODULE_AUTHOR("Red Hat Inc. (https://www.redhat.com)");
 MODULE_DESCRIPTION("MC Driver for Intel I7300 memory controllers - "
 		   I7300_REVISION);
 
-- 
2.27.0

