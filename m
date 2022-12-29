Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBA2658E4A
	for <lists+linux-edac@lfdr.de>; Thu, 29 Dec 2022 16:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiL2PXw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 29 Dec 2022 10:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiL2PXu (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 29 Dec 2022 10:23:50 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C2F11C22;
        Thu, 29 Dec 2022 07:23:49 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 70AFD1EC01CE;
        Thu, 29 Dec 2022 16:23:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1672327427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=aMtwDH9fuMNyFWkoAK3zz+2vAD5QW+IjABKWKnCr+0I=;
        b=qTwUc/jR654Qr5GDk415696RujRNTCW0Uy30uEQgRiQ9eB/DeGNUpE50RaYgRmKuldKdTI
        EUgu4ug3fXezwT5KG0Wdx17Bsoc844F5a08onIqG02Z7WD7SwEH0/4x3xOK9Te5McGdh7t
        r8ssJEEcol8P5nDMdOjangRptj/miVI=
Date:   Thu, 29 Dec 2022 16:23:47 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Eliav Farber <farbere@amazon.com>
Cc:     mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, talel@amazon.com, jonnyc@amazon.com,
        hhhawa@amazon.com, hanochu@amazon.com, itamark@amazon.com,
        shellykz@amazon.com, amitlavi@amazon.com, dkl@amazon.com
Subject: Re: [PATCH v2] edac: fix period calculation in
 edac_device_reset_delay_period()
Message-ID: <Y62xA548/wQAggRL@zn.tnic>
References: <20221020124458.22153-1-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221020124458.22153-1-farbere@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Oct 20, 2022 at 12:44:58PM +0000, Eliav Farber wrote:
> Fix period calculation in case user sets a value of 1000.
> The input of round_jiffies_relative() should be in jiffies and not in
> milli-seconds.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>

Fixes: c4cf3b454eca ("EDAC: Rework workqueue handling")

I guess.

Also, I think the one-liner below does the same, no?

---

diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
index 19522c568aa5..88942a6edc2c 100644
--- a/drivers/edac/edac_device.c
+++ b/drivers/edac/edac_device.c
@@ -399,7 +399,7 @@ void edac_device_reset_delay_period(struct edac_device_ctl_info *edac_dev,
 	unsigned long jiffs = msecs_to_jiffies(value);
 
 	if (value == 1000)
-		jiffs = round_jiffies_relative(value);
+		jiffs = round_jiffies_relative(jiffs);
 
 	edac_dev->poll_msec = value;
 	edac_dev->delay	    = jiffs;

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
