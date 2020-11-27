Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9ED2C693E
	for <lists+linux-edac@lfdr.de>; Fri, 27 Nov 2020 17:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731190AbgK0QS0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 27 Nov 2020 11:18:26 -0500
Received: from mga09.intel.com ([134.134.136.24]:46780 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730324AbgK0QS0 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 27 Nov 2020 11:18:26 -0500
IronPort-SDR: fYhdgZZwj+JlYaovRohWnnnUOFgt96NNYnCQdncxNkhe60YP2x5/sCTCkLWLV7uRpSPwJKzAUs
 535ofj0BbHZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9818"; a="172567146"
X-IronPort-AV: E=Sophos;i="5.78,375,1599548400"; 
   d="scan'208";a="172567146"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2020 08:18:26 -0800
IronPort-SDR: FSYa2JxjTM/bJugn698bg9ey7Rjg+V1wbeMYGMF/zoqOfJi4Ph1GHuSbd+6GG+Fj/V0u55NX0J
 2MLx55m1QarA==
X-IronPort-AV: E=Sophos;i="5.78,375,1599548400"; 
   d="scan'208";a="548095109"
Received: from paolonig001.ir.intel.com ([163.33.183.93])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2020 08:18:23 -0800
From:   Gabriele Paoloni <gabriele.paoloni@intel.com>
To:     tony.luck@intel.com, bp@alien8.de, tglx@linutronix.de,
        mingo@redhat.com, x86@kernel.org, hpa@zytor.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gabriele.paoloni@intel.com, linux-safety@lists.elisa.tech
Subject: [PATCH v2 1/5] x86/mce: do not overwrite no_way_out if mce_end() fails
Date:   Fri, 27 Nov 2020 16:18:15 +0000
Message-Id: <20201127161819.3106432-2-gabriele.paoloni@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201127161819.3106432-1-gabriele.paoloni@intel.com>
References: <20201127161819.3106432-1-gabriele.paoloni@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Currently if mce_end() fails 'no_way_out' is set equal to 'worst'.
'worst' is the worst severity that was found across the MCA banks
associated with the current CPU; however at this point 'no_way_out'
could have been already set by mca_start() by looking at all
severities of all CPUs that entered the MCE handler.
If mce_end() fails, check first if no_way_out is already set and,
if so, stick to it, otherwise use the local worst value.

Cc: <stable@vger.kernel.org>
Signed-off-by: Gabriele Paoloni <gabriele.paoloni@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 4102b866e7c0..32b7099e3511 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1384,8 +1384,10 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	 * When there's any problem use only local no_way_out state.
 	 */
 	if (!lmce) {
-		if (mce_end(order) < 0)
-			no_way_out = worst >= MCE_PANIC_SEVERITY;
+		if (mce_end(order) < 0) {
+			if (!no_way_out)
+				no_way_out = worst >= MCE_PANIC_SEVERITY;
+		}
 	} else {
 		/*
 		 * If there was a fatal machine check we should have
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

