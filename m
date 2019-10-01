Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6500CC3255
	for <lists+linux-edac@lfdr.de>; Tue,  1 Oct 2019 13:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731714AbfJALVx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 1 Oct 2019 07:21:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54949 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfJALVx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 1 Oct 2019 07:21:53 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iFGDs-0000H8-3G; Tue, 01 Oct 2019 13:21:40 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B78681C08B2;
        Tue,  1 Oct 2019 13:21:39 +0200 (CEST)
Date:   Tue, 01 Oct 2019 11:21:39 -0000
From:   "tip-bot2 for Tony W Wang-oc" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Add Zhaoxin MCE support
Cc:     "Tony W Wang-oc" <TonyWWang-oc@zhaoxin.com>,
        Borislav Petkov <bp@suse.de>, CooperYan@zhaoxin.com,
        DavidWang@zhaoxin.com, HerryYang@zhaoxin.com,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "linux-edac" <linux-edac@vger.kernel.org>, QiyuanWang@zhaoxin.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, "x86-ml" <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1568787573-1297-2-git-send-email-TonyWWang-oc@zhaoxin.com>
References: <1568787573-1297-2-git-send-email-TonyWWang-oc@zhaoxin.com>
MIME-Version: 1.0
Message-ID: <156992889966.9978.4146314179705937670.tip-bot2@tip-bot2>
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

Commit-ID:     6e898d2bf67a82df0aa0c955adc9278faba9a635
Gitweb:        https://git.kernel.org/tip/6e898d2bf67a82df0aa0c955adc9278faba9a635
Author:        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
AuthorDate:    Wed, 18 Sep 2019 14:19:30 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 01 Oct 2019 12:32:27 +02:00

x86/mce: Add Zhaoxin MCE support

All newer Zhaoxin CPUs are compatible with Intel's Machine-Check
Architecture, so add support for them.

 [ bp: Reflow comment in vendor_disable_error_reporting() and massage
   commit message. ]

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: CooperYan@zhaoxin.com
Cc: DavidWang@zhaoxin.com
Cc: HerryYang@zhaoxin.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: QiyuanWang@zhaoxin.com
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/1568787573-1297-2-git-send-email-TonyWWang-oc@zhaoxin.com
---
 arch/x86/kernel/cpu/mce/core.c | 44 +++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 743370e..a780fe0 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -488,8 +488,9 @@ int mce_usable_address(struct mce *m)
 	if (!(m->status & MCI_STATUS_ADDRV))
 		return 0;
 
-	/* Checks after this one are Intel-specific: */
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+	/* Checks after this one are Intel/Zhaoxin-specific: */
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_ZHAOXIN)
 		return 1;
 
 	if (!(m->status & MCI_STATUS_MISCV))
@@ -507,10 +508,13 @@ EXPORT_SYMBOL_GPL(mce_usable_address);
 
 bool mce_is_memory_error(struct mce *m)
 {
-	if (m->cpuvendor == X86_VENDOR_AMD ||
-	    m->cpuvendor == X86_VENDOR_HYGON) {
+	switch (m->cpuvendor) {
+	case X86_VENDOR_AMD:
+	case X86_VENDOR_HYGON:
 		return amd_mce_is_memory_error(m);
-	} else if (m->cpuvendor == X86_VENDOR_INTEL) {
+
+	case X86_VENDOR_INTEL:
+	case X86_VENDOR_ZHAOXIN:
 		/*
 		 * Intel SDM Volume 3B - 15.9.2 Compound Error Codes
 		 *
@@ -527,9 +531,10 @@ bool mce_is_memory_error(struct mce *m)
 		return (m->status & 0xef80) == BIT(7) ||
 		       (m->status & 0xef00) == BIT(8) ||
 		       (m->status & 0xeffc) == 0xc;
-	}
 
-	return false;
+	default:
+		return false;
+	}
 }
 EXPORT_SYMBOL_GPL(mce_is_memory_error);
 
@@ -1697,6 +1702,18 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 		if (c->x86 == 6 && c->x86_model == 45)
 			quirk_no_way_out = quirk_sandybridge_ifu;
 	}
+
+	if (c->x86_vendor == X86_VENDOR_ZHAOXIN) {
+		/*
+		 * All newer Zhaoxin CPUs support MCE broadcasting. Enable
+		 * synchronization with a one second timeout.
+		 */
+		if (c->x86 > 6 || (c->x86_model == 0x19 || c->x86_model == 0x1f)) {
+			if (cfg->monarch_timeout < 0)
+				cfg->monarch_timeout = USEC_PER_SEC;
+		}
+	}
+
 	if (cfg->monarch_timeout < 0)
 		cfg->monarch_timeout = 0;
 	if (cfg->bootlog != 0)
@@ -2014,15 +2031,16 @@ static void mce_disable_error_reporting(void)
 static void vendor_disable_error_reporting(void)
 {
 	/*
-	 * Don't clear on Intel or AMD or Hygon CPUs. Some of these MSRs
-	 * are socket-wide.
-	 * Disabling them for just a single offlined CPU is bad, since it will
-	 * inhibit reporting for all shared resources on the socket like the
-	 * last level cache (LLC), the integrated memory controller (iMC), etc.
+	 * Don't clear on Intel or AMD or Hygon or Zhaoxin CPUs. Some of these
+	 * MSRs are socket-wide. Disabling them for just a single offlined CPU
+	 * is bad, since it will inhibit reporting for all shared resources on
+	 * the socket like the last level cache (LLC), the integrated memory
+	 * controller (iMC), etc.
 	 */
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL ||
 	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ||
-	    boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+	    boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_ZHAOXIN)
 		return;
 
 	mce_disable_error_reporting();
