Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1354E10D273
	for <lists+linux-edac@lfdr.de>; Fri, 29 Nov 2019 09:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfK2I3X (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 29 Nov 2019 03:29:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48314 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfK2I3X (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 29 Nov 2019 03:29:23 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iabeI-0001FB-3B; Fri, 29 Nov 2019 09:29:10 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A7B7C1C2114;
        Fri, 29 Nov 2019 09:29:09 +0100 (CET)
Date:   Fri, 29 Nov 2019 08:29:09 -0000
From:   "tip-bot2 for Srinivas Pandruvada" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/urgent] x86/mce/therm_throt: Mask out read-only and
 reserved MSR bits
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-edac" <linux-edac@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, "x86-ml" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191128150824.22413-1-srinivas.pandruvada@linux.intel.com>
References: <20191128150824.22413-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Message-ID: <157501614949.21853.15507465165565649871.tip-bot2@tip-bot2>
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

The following commit has been merged into the ras/urgent branch of tip:

Commit-ID:     5a43b87b3c62ad149ba6e9d0d3e5c0e5da02a5ca
Gitweb:        https://git.kernel.org/tip/5a43b87b3c62ad149ba6e9d0d3e5c0e5da02a5ca
Author:        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
AuthorDate:    Thu, 28 Nov 2019 07:08:24 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 29 Nov 2019 09:17:52 +01:00

x86/mce/therm_throt: Mask out read-only and reserved MSR bits

While writing to MSR IA32_THERM_STATUS/IA32_PKG_THERM_STATUS, avoid
writing 1 to read only and reserved fields because updating some fields
generates exception.

 [ bp: Vertically align for better readability. ]

Fixes: f6656208f04e ("x86/mce/therm_throt: Optimize notifications of thermal throttle")
Reported-by: Dominik Brodowski <linux@dominikbrodowski.net>
Tested-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20191128150824.22413-1-srinivas.pandruvada@linux.intel.com
---
 arch/x86/kernel/cpu/mce/therm_throt.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/therm_throt.c b/arch/x86/kernel/cpu/mce/therm_throt.c
index d01e0da..b38010b 100644
--- a/arch/x86/kernel/cpu/mce/therm_throt.c
+++ b/arch/x86/kernel/cpu/mce/therm_throt.c
@@ -195,17 +195,24 @@ static const struct attribute_group thermal_attr_group = {
 #define THERM_THROT_POLL_INTERVAL	HZ
 #define THERM_STATUS_PROCHOT_LOG	BIT(1)
 
+#define THERM_STATUS_CLEAR_CORE_MASK (BIT(1) | BIT(3) | BIT(5) | BIT(7) | BIT(9) | BIT(11) | BIT(13) | BIT(15))
+#define THERM_STATUS_CLEAR_PKG_MASK  (BIT(1) | BIT(3) | BIT(5) | BIT(7) | BIT(9) | BIT(11))
+
 static void clear_therm_status_log(int level)
 {
 	int msr;
-	u64 msr_val;
+	u64 mask, msr_val;
 
-	if (level == CORE_LEVEL)
-		msr = MSR_IA32_THERM_STATUS;
-	else
-		msr = MSR_IA32_PACKAGE_THERM_STATUS;
+	if (level == CORE_LEVEL) {
+		msr  = MSR_IA32_THERM_STATUS;
+		mask = THERM_STATUS_CLEAR_CORE_MASK;
+	} else {
+		msr  = MSR_IA32_PACKAGE_THERM_STATUS;
+		mask = THERM_STATUS_CLEAR_PKG_MASK;
+	}
 
 	rdmsrl(msr, msr_val);
+	msr_val &= mask;
 	wrmsrl(msr, msr_val & ~THERM_STATUS_PROCHOT_LOG);
 }
 
