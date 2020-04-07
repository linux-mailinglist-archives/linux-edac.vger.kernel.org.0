Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9271A0756
	for <lists+linux-edac@lfdr.de>; Tue,  7 Apr 2020 08:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgDGGdz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 7 Apr 2020 02:33:55 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:34753 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgDGGdz (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 7 Apr 2020 02:33:55 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id fc413e04;
        Tue, 7 Apr 2020 06:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=mail; bh=DM9NrDkjXWpH4zu4SJmHj2Mdn+k=; b=f0awkIQPRVQo9hlCsQF4
        GvF9MJdapgxLuHNpSOZvBlY0debaS6aHicQQHZIBdH1jBG3bh8dUwkj4rAw/F350
        C6hOWMHuC0QYhFhd5iI8Oi7QfxSH0QEpUegjdZ3ZpjeUnyrZX4vqG3TCrxkvyrwd
        hLjBRvr7Gd6ebmXeP1tvuq7RJBJzd2Dsi9GobMc7sEz0ymLAiX0ASCGHlp7dP0AA
        gm926jwHIdGs0QGf3v8cJwHXhTPrHdrMOtN0QMsHuYDDuhvmq5hFjbI9h+Choj0v
        KPQCCKC0Nincy4Fn4BO48rxRaRxgGGAOFgIzrCUJI2NM0DuXxULLa3XtnQepTGyx
        Hw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0bb34400 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Tue, 7 Apr 2020 06:25:00 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        x86@kernel.org, arnd@arndb.de, srinivas.pandruvada@linux.intel.com,
        bberg@redhat.com, bp@suse.de
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH 1/3] x86/mce/therm_throt: remove unused platform_thermal_notify function pointer
Date:   Tue,  7 Apr 2020 00:33:43 -0600
Message-Id: <20200407063345.4484-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

A long time ago platform_thermal_notify was added as some generic
mechanism for platform drivers to hook thermal events. It seems as
though this has been entirely superseded, and nothing uses it. Remove
the plumbing for this, since this code runs in an interrupt hot path.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/x86/include/asm/mce.h            |  3 ---
 arch/x86/kernel/cpu/mce/therm_throt.c | 25 -------------------------
 2 files changed, 28 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 4359b955e0b7..ee30cb60ad36 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -257,9 +257,6 @@ extern void (*deferred_error_int_vector)(void);
 
 void intel_init_thermal(struct cpuinfo_x86 *c);
 
-/* Interrupt Handler for core thermal thresholds */
-extern int (*platform_thermal_notify)(__u64 msr_val);
-
 /* Interrupt Handler for package thermal thresholds */
 extern int (*platform_thermal_package_notify)(__u64 msr_val);
 
diff --git a/arch/x86/kernel/cpu/mce/therm_throt.c b/arch/x86/kernel/cpu/mce/therm_throt.c
index f36dc0742085..f904e85eb68f 100644
--- a/arch/x86/kernel/cpu/mce/therm_throt.c
+++ b/arch/x86/kernel/cpu/mce/therm_throt.c
@@ -105,10 +105,6 @@ struct thermal_state {
 	struct _thermal_state pkg_thresh1;
 };
 
-/* Callback to handle core threshold interrupts */
-int (*platform_thermal_notify)(__u64 msr_val);
-EXPORT_SYMBOL(platform_thermal_notify);
-
 /* Callback to handle core package threshold_interrupts */
 int (*platform_thermal_package_notify)(__u64 msr_val);
 EXPORT_SYMBOL_GPL(platform_thermal_package_notify);
@@ -551,24 +547,6 @@ static void notify_package_thresholds(__u64 msr_val)
 		platform_thermal_package_notify(msr_val);
 }
 
-static void notify_thresholds(__u64 msr_val)
-{
-	/* check whether the interrupt handler is defined;
-	 * otherwise simply return
-	 */
-	if (!platform_thermal_notify)
-		return;
-
-	/* lower threshold reached */
-	if ((msr_val & THERM_LOG_THRESHOLD0) &&
-			thresh_event_valid(CORE_LEVEL, 0))
-		platform_thermal_notify(msr_val);
-	/* higher threshold reached */
-	if ((msr_val & THERM_LOG_THRESHOLD1) &&
-			thresh_event_valid(CORE_LEVEL, 1))
-		platform_thermal_notify(msr_val);
-}
-
 /* Thermal transition interrupt handler */
 static void intel_thermal_interrupt(void)
 {
@@ -579,9 +557,6 @@ static void intel_thermal_interrupt(void)
 
 	rdmsrl(MSR_IA32_THERM_STATUS, msr_val);
 
-	/* Check for violation of core thermal thresholds*/
-	notify_thresholds(msr_val);
-
 	therm_throt_process(msr_val & THERM_STATUS_PROCHOT,
 			    THERMAL_THROTTLING_EVENT,
 			    CORE_LEVEL);
-- 
2.26.0

