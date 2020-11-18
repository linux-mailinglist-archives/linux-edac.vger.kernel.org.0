Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF142B803E
	for <lists+linux-edac@lfdr.de>; Wed, 18 Nov 2020 16:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgKRPQF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 18 Nov 2020 10:16:05 -0500
Received: from mga12.intel.com ([192.55.52.136]:8041 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbgKRPQF (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 18 Nov 2020 10:16:05 -0500
IronPort-SDR: K3HjGX1a54vaJlemn/4Jm/oaECa4wSLVdar+mMdAAk6DOHJmqdL/ag869B4F2qQuf5oZNtbyZs
 reHre9+wqiEA==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="150399361"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="150399361"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 07:16:03 -0800
IronPort-SDR: YsAkNBARL3HuPONP6kRUnF11yeoR3+ZaUcpZskIYpOJG2DWYRZUtTZ+eTWadQ2Lq3sjmZnV/4z
 mSsF6lGpIX9Q==
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="359492091"
Received: from paolonig001.ir.intel.com ([163.33.183.93])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 07:16:01 -0800
From:   Gabriele Paoloni <gabriele.paoloni@intel.com>
To:     tony.luck@intel.com, bp@alien8.de, tglx@linutronix.de,
        mingo@redhat.com, x86@kernel.org, hpa@zytor.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gabriele.paoloni@intel.com, linux-safety@lists.elisa.tech
Subject: [PATCH 2/4] x86/mce: move the mce_panic() call and kill_it assignments at the right places
Date:   Wed, 18 Nov 2020 15:15:50 +0000
Message-Id: <20201118151552.1412-3-gabriele.paoloni@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201118151552.1412-1-gabriele.paoloni@intel.com>
References: <20201118151552.1412-1-gabriele.paoloni@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Right now for local MCEs we panic(),if needed, right after lmce is
set. For global MCEs mce_reign() takes care of calling mce_panic().
Hence this patch:
- improves readibility by moving the conditional evaluation of
tolerant up to when kill_it is set first
- moves the mce_panic() call up into the statement where mce_end()
fails

Signed-off-by: Gabriele Paoloni <gabriele.paoloni@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/core.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index b990892c6766..e025ff04438f 100644
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
@@ -1384,8 +1383,15 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	 * When there's any problem use only local no_way_out state.
 	 */
 	if (!lmce) {
-		if (mce_end(order) < 0)
+		if (mce_end(order) < 0) {
 			no_way_out = no_way_out ? no_way_out : worst >= MCE_PANIC_SEVERITY;
+			/*
+			 * mce_reign() has probably failed hence evaluate if we need
+			 * to panic
+			 */
+			if (no_way_out && mca_cfg.tolerant < 3)
+				mce_panic("Fatal machine check on current CPU", &m, msg);
+		}
 	} else {
 		/*
 		 * If there was a fatal machine check we should have
@@ -1401,15 +1407,6 @@ noinstr void do_machine_check(struct pt_regs *regs)
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

