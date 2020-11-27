Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05342C6940
	for <lists+linux-edac@lfdr.de>; Fri, 27 Nov 2020 17:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731264AbgK0QS3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 27 Nov 2020 11:18:29 -0500
Received: from mga09.intel.com ([134.134.136.24]:46780 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730324AbgK0QS3 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 27 Nov 2020 11:18:29 -0500
IronPort-SDR: f0pjX9GKT8W8IljbRq2iqciLD1uS6jDF7ALT38mmAHPcF8gWrWaKlVxNHcctaY74TBD5yJMsCg
 raJud/zpAKZw==
X-IronPort-AV: E=McAfee;i="6000,8403,9818"; a="172567153"
X-IronPort-AV: E=Sophos;i="5.78,375,1599548400"; 
   d="scan'208";a="172567153"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2020 08:18:28 -0800
IronPort-SDR: U5sPqM2Z6LrYhlajZNXbSVjbGR6s385DfcOE4fru4a1Jz1+7ifAz+XNrMKnSl8vkFqRF7V+cWH
 9jk3F3fbNxiw==
X-IronPort-AV: E=Sophos;i="5.78,375,1599548400"; 
   d="scan'208";a="548095130"
Received: from paolonig001.ir.intel.com ([163.33.183.93])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2020 08:18:26 -0800
From:   Gabriele Paoloni <gabriele.paoloni@intel.com>
To:     tony.luck@intel.com, bp@alien8.de, tglx@linutronix.de,
        mingo@redhat.com, x86@kernel.org, hpa@zytor.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gabriele.paoloni@intel.com, linux-safety@lists.elisa.tech
Subject: [PATCH v2 2/5] x86/mce: move the mce_panic() call and 'kill_it' assignments to the right places
Date:   Fri, 27 Nov 2020 16:18:16 +0000
Message-Id: <20201127161819.3106432-3-gabriele.paoloni@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201127161819.3106432-1-gabriele.paoloni@intel.com>
References: <20201127161819.3106432-1-gabriele.paoloni@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Right now for local MCEs we panic(),if needed, right after lmce is
set. For global MCEs mce_reign() takes care of calling mce_panic().
Hence:
- improve readibility by moving the conditional evaluation of
tolerant up to when kill_it is set first;
- move the mce_panic() call up into the statement where mce_end()
fails.

Signed-off-by: Gabriele Paoloni <gabriele.paoloni@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/core.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 32b7099e3511..50e9b0893a92 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1350,8 +1350,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	 * severity is MCE_AR_SEVERITY we have other options.
 	 */
 	if (!(m.mcgstatus & MCG_STATUS_RIPV))
-		kill_it = 1;
-
+		kill_it = (cfg->tolerant == 3) ? 0 : 1;
 	/*
 	 * Check if this MCE is signaled to only this logical processor,
 	 * on Intel, Zhaoxin only.
@@ -1387,6 +1386,12 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		if (mce_end(order) < 0) {
 			if (!no_way_out)
 				no_way_out = worst >= MCE_PANIC_SEVERITY;
+			/*
+			 * mce_reign() has probably failed hence evaluate if we need
+			 * to panic
+			 */
+			if (no_way_out && mca_cfg.tolerant < 3)
+				mce_panic("Fatal machine check on current CPU", &m, msg);
 		}
 	} else {
 		/*
@@ -1403,15 +1408,6 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		}
 	}
 
-	/*
-	 * If tolerant is at an insane level we drop requests to kill
-	 * processes and continue even when there is no way out.
-	 */
-	if (cfg->tolerant == 3)
-		kill_it = 0;
-	else if (no_way_out)
-		mce_panic("Fatal machine check on current CPU", &m, msg);
-
 	if (worst > 0)
 		irq_work_queue(&mce_irq_work);
 
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

