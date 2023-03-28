Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072F76CC143
	for <lists+linux-edac@lfdr.de>; Tue, 28 Mar 2023 15:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbjC1Nno (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 28 Mar 2023 09:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbjC1Nna (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 28 Mar 2023 09:43:30 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5D686AC;
        Tue, 28 Mar 2023 06:43:12 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 79FDB1EC0338;
        Tue, 28 Mar 2023 15:43:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1680010990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=3XNLULs5F+FAVGIo2HpX+YyLGYGVF4c35mHywkE1ikQ=;
        b=DP5jAVvkHgPdKxNr++aP6OJJ3NimIfAXYaohqE84iAByv6WD1Pc03PikLct5wlkTGElF2E
        WbpfJK7EjdFljaMVdxatewhmJYqplbuaWgFBHPgS/u15swUeNpyiOg5mqAXYMaqpt7liUw
        YSPuihQAXOMoYR7XtplaRhTiYhWAq7I=
From:   Borislav Petkov <bp@alien8.de>
To:     linux-edac <linux-edac@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] EDAC: Sanitize MODULE_AUTHOR strings
Date:   Tue, 28 Mar 2023 15:43:09 +0200
Message-Id: <20230328134309.23159-1-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Fixup the remaining MODULE_AUTHOR strings to not contain newlines.
Shorten and unbreak others.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 drivers/edac/amd64_edac.c      | 6 ++----
 drivers/edac/e752x_edac.c      | 2 +-
 drivers/edac/e7xxx_edac.c      | 3 +--
 drivers/edac/i5000_edac.c      | 7 ++-----
 drivers/edac/i5100_edac.c      | 3 +--
 drivers/edac/i82860_edac.c     | 3 +--
 drivers/edac/layerscape_edac.c | 3 +--
 drivers/edac/mpc85xx_edac.c    | 3 +--
 drivers/edac/r82600_edac.c     | 3 +--
 9 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 5b42533f306a..8b16ebf5fe12 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -4244,10 +4244,8 @@ module_init(amd64_edac_init);
 module_exit(amd64_edac_exit);
 
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("SoftwareBitMaker: Doug Thompson, "
-		"Dave Peterson, Thayne Harbaugh");
-MODULE_DESCRIPTION("MC support for AMD64 memory controllers - "
-		EDAC_AMD64_VERSION);
+MODULE_AUTHOR("SoftwareBitMaker: Doug Thompson, Dave Peterson, Thayne Harbaugh; AMD");
+MODULE_DESCRIPTION("MC support for AMD64 memory controllers - " EDAC_AMD64_VERSION);
 
 module_param(edac_op_state, int, 0444);
 MODULE_PARM_DESC(edac_op_state, "EDAC Error Reporting state: 0=Poll,1=NMI");
diff --git a/drivers/edac/e752x_edac.c b/drivers/edac/e752x_edac.c
index ac7c9b42d4c7..7221b4bb6df2 100644
--- a/drivers/edac/e752x_edac.c
+++ b/drivers/edac/e752x_edac.c
@@ -1462,7 +1462,7 @@ module_init(e752x_init);
 module_exit(e752x_exit);
 
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Linux Networx (http://lnxi.com) Tom Zimmerman\n");
+MODULE_AUTHOR("Linux Networx (http://lnxi.com) Tom Zimmerman");
 MODULE_DESCRIPTION("MC support for Intel e752x/3100 memory controllers");
 
 module_param(force_function_unhide, int, 0444);
diff --git a/drivers/edac/e7xxx_edac.c b/drivers/edac/e7xxx_edac.c
index 497e710fca3d..5852b95fa470 100644
--- a/drivers/edac/e7xxx_edac.c
+++ b/drivers/edac/e7xxx_edac.c
@@ -596,8 +596,7 @@ module_init(e7xxx_init);
 module_exit(e7xxx_exit);
 
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Linux Networx (http://lnxi.com) Thayne Harbaugh et al\n"
-		"Based on.work by Dan Hollis et al");
+MODULE_AUTHOR("Linux Networx (http://lnxi.com) Thayne Harbaugh et al");
 MODULE_DESCRIPTION("MC support for Intel e7xxx memory controllers");
 module_param(edac_op_state, int, 0444);
 MODULE_PARM_DESC(edac_op_state, "EDAC Error Reporting state: 0=Poll,1=NMI");
diff --git a/drivers/edac/i5000_edac.c b/drivers/edac/i5000_edac.c
index ba46057d4220..4b5a71f8739d 100644
--- a/drivers/edac/i5000_edac.c
+++ b/drivers/edac/i5000_edac.c
@@ -1573,13 +1573,10 @@ module_init(i5000_init);
 module_exit(i5000_exit);
 
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR
-    ("Linux Networx (http://lnxi.com) Doug Thompson <norsk5@xmission.com>");
-MODULE_DESCRIPTION("MC Driver for Intel I5000 memory controllers - "
-		I5000_REVISION);
+MODULE_AUTHOR("Linux Networx (http://lnxi.com) Doug Thompson <norsk5@xmission.com>");
+MODULE_DESCRIPTION("MC Driver for Intel I5000 memory controllers - " I5000_REVISION);
 
 module_param(edac_op_state, int, 0444);
 MODULE_PARM_DESC(edac_op_state, "EDAC Error Reporting state: 0=Poll,1=NMI");
 module_param(misc_messages, int, 0444);
 MODULE_PARM_DESC(misc_messages, "Log miscellaneous non fatal messages");
-
diff --git a/drivers/edac/i5100_edac.c b/drivers/edac/i5100_edac.c
index 8db680b6ae9b..d470afe65001 100644
--- a/drivers/edac/i5100_edac.c
+++ b/drivers/edac/i5100_edac.c
@@ -1220,6 +1220,5 @@ module_init(i5100_init);
 module_exit(i5100_exit);
 
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR
-    ("Arthur Jones <ajones@riverbed.com>");
+MODULE_AUTHOR("Arthur Jones <ajones@riverbed.com>");
 MODULE_DESCRIPTION("MC Driver for Intel I5100 memory controllers");
diff --git a/drivers/edac/i82860_edac.c b/drivers/edac/i82860_edac.c
index fbec90d00f1e..b8a497f0de28 100644
--- a/drivers/edac/i82860_edac.c
+++ b/drivers/edac/i82860_edac.c
@@ -355,8 +355,7 @@ module_init(i82860_init);
 module_exit(i82860_exit);
 
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Red Hat Inc. (http://www.redhat.com) "
-		"Ben Woodard <woodard@redhat.com>");
+MODULE_AUTHOR("Red Hat Inc. (http://www.redhat.com) Ben Woodard <woodard@redhat.com>");
 MODULE_DESCRIPTION("ECC support for Intel 82860 memory hub controllers");
 
 module_param(edac_op_state, int, 0444);
diff --git a/drivers/edac/layerscape_edac.c b/drivers/edac/layerscape_edac.c
index 35ceaca578e1..7c5e2b3c0daa 100644
--- a/drivers/edac/layerscape_edac.c
+++ b/drivers/edac/layerscape_edac.c
@@ -72,5 +72,4 @@ module_exit(fsl_ddr_mc_exit);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("NXP Semiconductor");
 module_param(edac_op_state, int, 0444);
-MODULE_PARM_DESC(edac_op_state,
-		 "EDAC Error Reporting state: 0=Poll, 2=Interrupt");
+MODULE_PARM_DESC(edac_op_state, "EDAC Error Reporting state: 0=Poll, 2=Interrupt");
diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index e50d7928bf8f..55320546c174 100644
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -711,5 +711,4 @@ module_exit(mpc85xx_mc_exit);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Montavista Software, Inc.");
 module_param(edac_op_state, int, 0444);
-MODULE_PARM_DESC(edac_op_state,
-		 "EDAC Error Reporting state: 0=Poll, 2=Interrupt");
+MODULE_PARM_DESC(edac_op_state, "EDAC Error Reporting state: 0=Poll, 2=Interrupt");
diff --git a/drivers/edac/r82600_edac.c b/drivers/edac/r82600_edac.c
index d0aef83dca2a..61e979d5437a 100644
--- a/drivers/edac/r82600_edac.c
+++ b/drivers/edac/r82600_edac.c
@@ -415,8 +415,7 @@ module_init(r82600_init);
 module_exit(r82600_exit);
 
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Tim Small <tim@buttersideup.com> - WPAD Ltd. "
-		"on behalf of EADS Astrium");
+MODULE_AUTHOR("Tim Small <tim@buttersideup.com> - WPAD Ltd. on behalf of EADS Astrium");
 MODULE_DESCRIPTION("MC support for Radisys 82600 memory controllers");
 
 module_param(disable_hardware_scrub, bool, 0644);
-- 
2.35.1

