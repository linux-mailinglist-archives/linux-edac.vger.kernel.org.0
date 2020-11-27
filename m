Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0148D2C6945
	for <lists+linux-edac@lfdr.de>; Fri, 27 Nov 2020 17:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731403AbgK0QSg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 27 Nov 2020 11:18:36 -0500
Received: from mga09.intel.com ([134.134.136.24]:46780 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730324AbgK0QSg (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 27 Nov 2020 11:18:36 -0500
IronPort-SDR: aetqPrtHsSajUCg+xV2kLlZWxX62CNdZLtXJO0xp0+Ih3Qd5ZlK4ryI4+yibW4l9hkiI7qVAQY
 B8ovk/d7l3sA==
X-IronPort-AV: E=McAfee;i="6000,8403,9818"; a="172567175"
X-IronPort-AV: E=Sophos;i="5.78,375,1599548400"; 
   d="scan'208";a="172567175"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2020 08:18:35 -0800
IronPort-SDR: 4VpXVwaAo5p2D9bQaGy9uojCA1TWHWQumUv8bqM7lWNzcxc56DDhQq8JqftyXhyoiCbpvYoDml
 ilFJOE0+OD2Q==
X-IronPort-AV: E=Sophos;i="5.78,375,1599548400"; 
   d="scan'208";a="548095177"
Received: from paolonig001.ir.intel.com ([163.33.183.93])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2020 08:18:33 -0800
From:   Gabriele Paoloni <gabriele.paoloni@intel.com>
To:     tony.luck@intel.com, bp@alien8.de, tglx@linutronix.de,
        mingo@redhat.com, x86@kernel.org, hpa@zytor.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gabriele.paoloni@intel.com, linux-safety@lists.elisa.tech
Subject: [PATCH v2 5/5] x86/mce: rename kill_it as kill_current_task
Date:   Fri, 27 Nov 2020 16:18:19 +0000
Message-Id: <20201127161819.3106432-6-gabriele.paoloni@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201127161819.3106432-1-gabriele.paoloni@intel.com>
References: <20201127161819.3106432-1-gabriele.paoloni@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Currently if an MCE happens in user-mode or while the kernel
is copying data from user space, 'kill_it' is used to check
if we can recover the execution of the interrupted task or
not; the flag name however is not much meaningful, hence
rename it to match its goal.

Signed-off-by: Gabriele Paoloni <gabriele.paoloni@intel.com>
---
 arch/x86/kernel/cpu/mce/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 802302c54762..740a4fcc1e90 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1320,10 +1320,10 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	int no_way_out = 0;
 
 	/*
-	 * If kill_it gets set, there might be a way to recover from this
+	 * If kill_current_task is not set, there might be a way to recover from this
 	 * error.
 	 */
-	int kill_it = 0;
+	int kill_current_task = 0;
 
 	/*
 	 * MCEs are always local on AMD. Same is determined by MCG_STATUS_LMCES
@@ -1350,7 +1350,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	 * severity is MCE_AR_SEVERITY we have other options.
 	 */
 	if (!(m.mcgstatus & MCG_STATUS_RIPV))
-		kill_it = (cfg->tolerant == 3) ? 0 : 1;
+		kill_current_task = (cfg->tolerant == 3) ? 0 : 1;
 	/*
 	 * Check if this MCE is signaled to only this logical processor,
 	 * on Intel, Zhaoxin only.
@@ -1408,7 +1408,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		}
 	}
 
-	if (worst != MCE_AR_SEVERITY && !kill_it)
+	if (worst != MCE_AR_SEVERITY && !kill_current_task)
 		goto out;
 
 	/* Fault was in user mode and we need to take some action */
@@ -1416,7 +1416,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		/* If this triggers there is no way to recover. Die hard. */
 		BUG_ON(!on_thread_stack() || !user_mode(regs));
 
-		queue_task_work(&m, kill_it);
+		queue_task_work(&m, kill_current_task);
 
 	} else {
 		/*
@@ -1434,7 +1434,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		}
 
 		if (m.kflags & MCE_IN_KERNEL_COPYIN)
-			queue_task_work(&m, kill_it);
+			queue_task_work(&m, kill_current_task);
 	}
 out:
 	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
-- 
2.20.1

---------------------------------------------------------------------
INTEL CORPORATION ITALIA S.p.A. con unico socio
Sede: Milanofiori Palazzo E 4 
CAP 20094 Assago (MI)
Capitale Sociale Euro 104.000,00 interamente versato
Partita I.V.A. e Codice Fiscale  04236760155
Repertorio Economico Amministrativo n. 997124 
Registro delle Imprese di Milano nr. 183983/5281/33
Soggetta ad attivita' di direzione e coordinamento di 
INTEL CORPORATION, USA

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

