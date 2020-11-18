Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8222B8037
	for <lists+linux-edac@lfdr.de>; Wed, 18 Nov 2020 16:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbgKRPQI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 18 Nov 2020 10:16:08 -0500
Received: from mga12.intel.com ([192.55.52.136]:8050 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgKRPQI (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 18 Nov 2020 10:16:08 -0500
IronPort-SDR: nYonFwEl9zJoMqqTd2+ZwiZQti2c4WFbWJJGn9YppHl8DZ0xtevVTqrl4kDhUFMJ4MuuWJ6JQS
 qVLDP8y4yS3g==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="150399374"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="150399374"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 07:16:07 -0800
IronPort-SDR: Qdj1G/BZDfUwKBd9PGrja0yEPB2y5oIR8EVsEoULTfcS+ZmJWqFhPNXha2H4xpjI3mfdLEKQTK
 ha0EJCyBdLKQ==
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="359492130"
Received: from paolonig001.ir.intel.com ([163.33.183.93])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 07:16:05 -0800
From:   Gabriele Paoloni <gabriele.paoloni@intel.com>
To:     tony.luck@intel.com, bp@alien8.de, tglx@linutronix.de,
        mingo@redhat.com, x86@kernel.org, hpa@zytor.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gabriele.paoloni@intel.com, linux-safety@lists.elisa.tech
Subject: [PATCH 4/4] x86/mce: remove redundant call to irq_work_queue()
Date:   Wed, 18 Nov 2020 15:15:52 +0000
Message-Id: <20201118151552.1412-5-gabriele.paoloni@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201118151552.1412-1-gabriele.paoloni@intel.com>
References: <20201118151552.1412-1-gabriele.paoloni@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Right now in do_machine_check() we have:
__mc_scan_banks()->mce_log()->irq_work_queue(&mce_irq_work)

hence the call of irq_work_queue() below after __mc_scan_banks()
seems redundant. Just remove it.

Signed-off-by: Gabriele Paoloni <gabriele.paoloni@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index d16cbb05b09c..f2f7bfc60c67 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1407,9 +1407,6 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		}
 	}
 
-	if (worst > 0)
-		irq_work_queue(&mce_irq_work);
-
 	if (worst != MCE_AR_SEVERITY && !kill_it)
 		goto out;
 
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

