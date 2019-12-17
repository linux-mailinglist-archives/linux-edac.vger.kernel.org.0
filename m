Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B55C12282D
	for <lists+linux-edac@lfdr.de>; Tue, 17 Dec 2019 11:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfLQKB3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 17 Dec 2019 05:01:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54876 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbfLQKB3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 17 Dec 2019 05:01:29 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ih9fA-0003qa-Vo; Tue, 17 Dec 2019 11:01:09 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 926221C2A30;
        Tue, 17 Dec 2019 11:01:08 +0100 (CET)
Date:   Tue, 17 Dec 2019 10:01:08 -0000
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce/therm_throt: Mark throttle_active_work() as
 __maybe_unused
Cc:     Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@suse.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        bberg@redhat.com, ckellner@redhat.com,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        hdegoede@redhat.com, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-edac" <linux-edac@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, "x86-ml" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191210203925.3119091-1-arnd@arndb.de>
References: <20191210203925.3119091-1-arnd@arndb.de>
MIME-Version: 1.0
Message-ID: <157657686842.30329.4552093141575050735.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     db1ae0314f47e88ae06679270adf17ffa245afd4
Gitweb:        https://git.kernel.org/tip/db1ae0314f47e88ae06679270adf17ffa245afd4
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Tue, 10 Dec 2019 21:39:13 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 17 Dec 2019 10:26:28 +01:00

x86/mce/therm_throt: Mark throttle_active_work() as __maybe_unused

throttle_active_work() is only called if CONFIG_SYSFS is set, otherwise
we get a harmless warning:

  arch/x86/kernel/cpu/mce/therm_throt.c:238:13: error: 'throttle_active_work' \
	  defined but not used [-Werror=unused-function]

Mark the function as __maybe_unused to avoid the warning.

Fixes: f6656208f04e ("x86/mce/therm_throt: Optimize notifications of thermal throttle")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: bberg@redhat.com
Cc: ckellner@redhat.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: hdegoede@redhat.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20191210203925.3119091-1-arnd@arndb.de
---
 arch/x86/kernel/cpu/mce/therm_throt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/therm_throt.c b/arch/x86/kernel/cpu/mce/therm_throt.c
index b38010b..8963493 100644
--- a/arch/x86/kernel/cpu/mce/therm_throt.c
+++ b/arch/x86/kernel/cpu/mce/therm_throt.c
@@ -235,7 +235,7 @@ static void get_therm_status(int level, bool *proc_hot, u8 *temp)
 	*temp = (msr_val >> 16) & 0x7F;
 }
 
-static void throttle_active_work(struct work_struct *work)
+static void __maybe_unused throttle_active_work(struct work_struct *work)
 {
 	struct _thermal_state *state = container_of(to_delayed_work(work),
 						struct _thermal_state, therm_work);
