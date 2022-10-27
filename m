Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136D360FB76
	for <lists+linux-edac@lfdr.de>; Thu, 27 Oct 2022 17:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236426AbiJ0PKj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 27 Oct 2022 11:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236132AbiJ0PJS (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 27 Oct 2022 11:09:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C9418E73F;
        Thu, 27 Oct 2022 08:09:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63A02623A7;
        Thu, 27 Oct 2022 15:09:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64C0C433D6;
        Thu, 27 Oct 2022 15:09:15 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oo4Vf-00BviQ-0B;
        Thu, 27 Oct 2022 11:09:31 -0400
Message-ID: <20221027150930.891623466@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 27 Oct 2022 11:05:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-edac@vger.kernel.org
Subject: [RFC][PATCH v2 30/31] timers: x86/mce: Use __init_timer() for resetting timers
References: <20221027150525.753064657@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

DEBUG_OBJECTS_TIMERS is now checking if a timer is ever enqueued, and if
so, it must call del_timer_shutdown() before freeing, otherwise
debug objects will trigger. This requires that once a timer is initialized
(and initialized for debug objects) it must not be re-initialized using
timer_setup(), as that will call the debug objects initialization code
again and trigger a bug if it was ever used.

As the mce reinitializes its timers on CPU hotplug, it must use
__init_timer() instead of timer_setup(), which will only initialize the
debug objects once.

Link: https://lore.kernel.org/all/20220407161745.7d6754b3@gandalf.local.home/

Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-edac@vger.kernel.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/x86/kernel/cpu/mce/core.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 2c8ec5c71712..d2653c7d40b3 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2051,14 +2051,24 @@ static void __mcheck_cpu_setup_timer(void)
 {
 	struct timer_list *t = this_cpu_ptr(&mce_timer);
 
-	timer_setup(t, mce_timer_fn, TIMER_PINNED);
+	/*
+	 * timer_setup() may only be used on a timer for the
+	 * first time it is initialized. This resets the
+	 * timer on CPU hotplug, so use __init_timer() instead.
+	 */
+	__init_timer(t, mce_timer_fn, TIMER_PINNED);
 }
 
 static void __mcheck_cpu_init_timer(void)
 {
 	struct timer_list *t = this_cpu_ptr(&mce_timer);
 
-	timer_setup(t, mce_timer_fn, TIMER_PINNED);
+	/*
+	 * timer_setup() may only be used on a timer for the
+	 * first time it is initialized. This resets the
+	 * timer on CPU hotplug, so use __init_timer() instead.
+	 */
+	__init_timer(t, mce_timer_fn, TIMER_PINNED);
 	mce_start_timer(t);
 }
 
-- 
2.35.1
