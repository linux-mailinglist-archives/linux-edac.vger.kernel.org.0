Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECCE659979
	for <lists+linux-edac@lfdr.de>; Fri, 30 Dec 2022 15:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbiL3OsL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 30 Dec 2022 09:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbiL3OsK (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 30 Dec 2022 09:48:10 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8952CB84D;
        Fri, 30 Dec 2022 06:48:06 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0B1DC1EC064A;
        Fri, 30 Dec 2022 15:48:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1672411685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=D8sh2IxPMw6n2bzVvHUCXWtyK943VHmfJSYwXW9Zz/M=;
        b=agDQ4GxxoXEsC19IJOa2d2on/k1krQbu/8gwkOoIwR1BrNouEe7/U86KO55VW2iek8IWVf
        A+Dk39F91IKG01cy4wUmbLRfTNb3kdN/RUNaYBDPYzJYLd2+a7kNEB3byinTIoLxdxkC/d
        aHdu9Hs359m0H1mXQlpU1IO3brGZxuA=
Date:   Fri, 30 Dec 2022 15:48:01 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Farber, Eliav" <farbere@amazon.com>
Cc:     mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, talel@amazon.com, jonnyc@amazon.com,
        hhhawa@amazon.com, hanochu@amazon.com, itamark@amazon.com,
        shellykz@amazon.com, amitlavi@amazon.com, dkl@amazon.com
Subject: Re: [PATCH v2] edac: fix period calculation in
 edac_device_reset_delay_period()
Message-ID: <Y676ITA0tCjEo3av@zn.tnic>
References: <20221020124458.22153-1-farbere@amazon.com>
 <Y62xA548/wQAggRL@zn.tnic>
 <aebd2f07-674c-b848-69e7-5479d111bad1@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aebd2f07-674c-b848-69e7-5479d111bad1@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Dec 29, 2022 at 10:17:48PM +0200, Farber, Eliav wrote:
> The one-liner below will not work. See the comment in
> edac_device_workq_setup() that explains why round is used:

Bah, right you are - there's that "optimization".

Ok, I've applied this:

---
From: Eliav Farber <farbere@amazon.com>
Date: Thu, 20 Oct 2022 12:44:58 +0000
Subject: [PATCH] EDAC/device: Fix period calculation in
 edac_device_reset_delay_period()

Fix period calculation in case user sets a value of 1000.  The input of
round_jiffies_relative() should be in jiffies and not in milli-seconds.

  [ bp: Use the same code pattern as in edac_device_workq_setup() for
    clarity. ]

Fixes: c4cf3b454eca ("EDAC: Rework workqueue handling")
Signed-off-by: Eliav Farber <farbere@amazon.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20221020124458.22153-1-farbere@amazon.com
---
 drivers/edac/edac_device.c | 17 ++++++++---------
 drivers/edac/edac_module.h |  2 +-
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
index 19522c568aa5..878deb4880cd 100644
--- a/drivers/edac/edac_device.c
+++ b/drivers/edac/edac_device.c
@@ -394,17 +394,16 @@ static void edac_device_workq_teardown(struct edac_device_ctl_info *edac_dev)
  *	Then restart the workq on the new delay
  */
 void edac_device_reset_delay_period(struct edac_device_ctl_info *edac_dev,
-					unsigned long value)
+				    unsigned long msec)
 {
-	unsigned long jiffs = msecs_to_jiffies(value);
-
-	if (value == 1000)
-		jiffs = round_jiffies_relative(value);
-
-	edac_dev->poll_msec = value;
-	edac_dev->delay	    = jiffs;
+	edac_dev->poll_msec = msec;
+	edac_dev->delay	    = msecs_to_jiffies(msec);
 
-	edac_mod_work(&edac_dev->work, jiffs);
+	/* See comment in edac_device_workq_setup() above */
+	if (edac_dev->poll_msec == 1000)
+		edac_mod_work(&edac_dev->work, round_jiffies_relative(edac_dev->delay));
+	else
+		edac_mod_work(&edac_dev->work, edac_dev->delay);
 }
 
 int edac_device_alloc_index(void)
diff --git a/drivers/edac/edac_module.h b/drivers/edac/edac_module.h
index 763c076d96f2..47593afdc234 100644
--- a/drivers/edac/edac_module.h
+++ b/drivers/edac/edac_module.h
@@ -53,7 +53,7 @@ bool edac_stop_work(struct delayed_work *work);
 bool edac_mod_work(struct delayed_work *work, unsigned long delay);
 
 extern void edac_device_reset_delay_period(struct edac_device_ctl_info
-					   *edac_dev, unsigned long value);
+					   *edac_dev, unsigned long msec);
 extern void edac_mc_reset_delay_period(unsigned long value);
 
 /*
-- 
2.35.1

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
