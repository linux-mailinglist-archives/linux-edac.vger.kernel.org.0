Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B052A702FF0
	for <lists+linux-edac@lfdr.de>; Mon, 15 May 2023 16:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjEOOeI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 15 May 2023 10:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241839AbjEOOd7 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 15 May 2023 10:33:59 -0400
Received: from lobo.ruivo.org (lobo.ruivo.org [173.14.175.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED9912B
        for <linux-edac@vger.kernel.org>; Mon, 15 May 2023 07:33:30 -0700 (PDT)
Received: by lobo.ruivo.org (Postfix, from userid 1011)
        id 8A31E52B7C; Mon, 15 May 2023 10:32:43 -0400 (EDT)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Received: from jake.ruivo.org (bob.qemu.ruivo [192.168.72.19])
        by lobo.ruivo.org (Postfix) with ESMTPA id CE58052A1A;
        Mon, 15 May 2023 10:32:25 -0400 (EDT)
Received: by jake.ruivo.org (Postfix, from userid 1000)
        id C0A4022005A; Mon, 15 May 2023 10:32:25 -0400 (EDT)
Date:   Mon, 15 May 2023 10:32:25 -0400
From:   Aristeu Rozanski <aris@ruivo.org>
To:     linux-edac@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>,
        Aristeu Rozanski <aris@redhat.com>
Subject: [PATCH] mce: prevent concurrent polling of MCE events
Message-ID: <20230515143225.GC4090740@cathedrallabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Error injection in modern HP machines with CMCI disabled will cause the
injected MCE to be found only by polling. Because these newer machines have a
big number of CPUs per package, it makes a lot more likely for multiple
CPUs polling IMC registers (that are shared in the same package) at same time,
causing multiple reports of the same MCE.

Signed-off-by: Aristeu Rozanski <aris@ruivo.org>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: linux-edac@vger.kernel.org

--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1597,6 +1597,7 @@ static unsigned long check_interval = INITIAL_CHECK_INTERVAL;
 
 static DEFINE_PER_CPU(unsigned long, mce_next_interval); /* in jiffies */
 static DEFINE_PER_CPU(struct timer_list, mce_timer);
+static DEFINE_RAW_SPINLOCK(timer_fn_lock);
 
 static unsigned long mce_adjust_timer_default(unsigned long interval)
 {
@@ -1628,7 +1629,9 @@ static void mce_timer_fn(struct timer_list *t)
 	iv = __this_cpu_read(mce_next_interval);
 
 	if (mce_available(this_cpu_ptr(&cpu_info))) {
+		raw_spin_lock(&timer_fn_lock);
 		machine_check_poll(0, this_cpu_ptr(&mce_poll_banks));
+		raw_spin_unlock(&timer_fn_lock);
 
 		if (mce_intel_cmci_poll()) {
 			iv = mce_adjust_timer(iv);

