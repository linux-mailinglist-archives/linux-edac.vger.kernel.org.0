Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9A611845A
	for <lists+linux-edac@lfdr.de>; Tue, 10 Dec 2019 11:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfLJKHR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 10 Dec 2019 05:07:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40584 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfLJKHR (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 10 Dec 2019 05:07:17 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iecQ3-0006LC-Jb; Tue, 10 Dec 2019 11:07:03 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 203F61C2905;
        Tue, 10 Dec 2019 11:07:03 +0100 (CET)
Date:   Tue, 10 Dec 2019 10:07:03 -0000
From:   "tip-bot2 for Konstantin Khlebnikov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/MCE/AMD: Do not use rdmsr_safe_on_cpu() in
 smca_configure()
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Borislav Petkov <bp@suse.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "linux-edac" <linux-edac@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, "x86-ml" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <157252708836.3876.4604398213417262402.stgit@buzz>
References: <157252708836.3876.4604398213417262402.stgit@buzz>
MIME-Version: 1.0
Message-ID: <157597242302.30329.18337877757273874643.tip-bot2@tip-bot2>
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

Commit-ID:     17ba1939e3676417590ec6f7555608e137e1719a
Gitweb:        https://git.kernel.org/tip/17ba1939e3676417590ec6f7555608e137e1719a
Author:        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
AuthorDate:    Thu, 31 Oct 2019 16:04:48 +03:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 09 Dec 2019 14:54:59 +01:00

x86/MCE/AMD: Do not use rdmsr_safe_on_cpu() in smca_configure()

The function smca_configure() is called only on the current CPU
therefore replace rdmsr_safe_on_cpu() with atomic rdmsr_safe() and avoid
the IPI.

 [ bp: Cleanup commit message. ]

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/157252708836.3876.4604398213417262402.stgit@buzz
---
 arch/x86/kernel/cpu/mce/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 5167bd2..e41e3b4 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -269,7 +269,7 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
 	if (smca_banks[bank].hwid)
 		return;
 
-	if (rdmsr_safe_on_cpu(cpu, MSR_AMD64_SMCA_MCx_IPID(bank), &low, &high)) {
+	if (rdmsr_safe(MSR_AMD64_SMCA_MCx_IPID(bank), &low, &high)) {
 		pr_warn("Failed to read MCA_IPID for bank %d\n", bank);
 		return;
 	}
