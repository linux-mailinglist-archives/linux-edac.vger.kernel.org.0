Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE7521D16B
	for <lists+linux-edac@lfdr.de>; Mon, 13 Jul 2020 10:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbgGMILg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 13 Jul 2020 04:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgGMILg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 13 Jul 2020 04:11:36 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8522FC061755;
        Mon, 13 Jul 2020 01:11:36 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 3C9F0BC070;
        Mon, 13 Jul 2020 08:11:33 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     jbaron@akamai.com, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, rrichter@marvell.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] EDAC/ie31200: Replace HTTP links with HTTPS ones
Date:   Mon, 13 Jul 2020 10:11:26 +0200
Message-Id: <20200713081126.32283-1-grandmaster@al2klimov.de>
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

 If there are any URLs to be removed completely or at least not just HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.

 Sorry again to all maintainers who complained about subject lines.
 Now I realized that you want an actually perfect prefixes,
 not just subsystem ones.
 I tried my best...
 And yes, *I could* (at least half-)automate it.
 Impossible is nothing! :)


 drivers/edac/ie31200_edac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index d68346a8e141..b52175e7c6d2 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -9,7 +9,7 @@
  * Since the DRAM controller is on the cpu chip, we can use its PCI device
  * id to identify these processors.
  *
- * PCI DRAM controller device ids (Taken from The PCI ID Repository - http://pci-ids.ucw.cz/)
+ * PCI DRAM controller device ids (Taken from The PCI ID Repository - https://pci-ids.ucw.cz/)
  *
  * 0108: Xeon E3-1200 Processor Family DRAM Controller
  * 010c: Xeon E3-1200/2nd Generation Core Processor Family DRAM Controller
@@ -23,9 +23,9 @@
  * 3e..: 8th/9th Gen Core Processor Host Bridge/DRAM Registers
  *
  * Based on Intel specification:
- * http://www.intel.com/content/dam/www/public/us/en/documents/datasheets/xeon-e3-1200v3-vol-2-datasheet.pdf
+ * https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/xeon-e3-1200v3-vol-2-datasheet.pdf
  * http://www.intel.com/content/www/us/en/processors/xeon/xeon-e3-1200-family-vol-2-datasheet.html
- * http://www.intel.com/content/www/us/en/processors/core/7th-gen-core-family-mobile-h-processor-lines-datasheet-vol-2.html
+ * https://www.intel.com/content/www/us/en/processors/core/7th-gen-core-family-mobile-h-processor-lines-datasheet-vol-2.html
  * https://www.intel.com/content/www/us/en/products/docs/processors/core/8th-gen-core-family-datasheet-vol-2.html
  *
  * According to the above datasheet (p.16):
-- 
2.27.0

