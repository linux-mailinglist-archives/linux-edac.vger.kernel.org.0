Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28BAB2B8034
	for <lists+linux-edac@lfdr.de>; Wed, 18 Nov 2020 16:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgKRPQF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 18 Nov 2020 10:16:05 -0500
Received: from mga12.intel.com ([192.55.52.136]:8041 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgKRPQF (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 18 Nov 2020 10:16:05 -0500
IronPort-SDR: Uz82WJJscjClWgeoGpbMjVBkQQRYRt380ycLj8h9Wz7xmQ+yzM5593hZkA9+YsBZ5ANXY/1xT+
 TfAx5ySBG/tA==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="150399355"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="150399355"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 07:16:00 -0800
IronPort-SDR: GYtp/eQEMJHox3iSJRYa0KY4b4v4TwS7rbVt7DlVD6PBO5ZpAkMbHz9LG3SGZhf51VhcE8MPWI
 ebHCf7THJvWg==
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="359492070"
Received: from paolonig001.ir.intel.com ([163.33.183.93])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 07:15:58 -0800
From:   Gabriele Paoloni <gabriele.paoloni@intel.com>
To:     tony.luck@intel.com, bp@alien8.de, tglx@linutronix.de,
        mingo@redhat.com, x86@kernel.org, hpa@zytor.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gabriele.paoloni@intel.com, linux-safety@lists.elisa.tech
Subject: [PATCH 1/4] x86/mce: do not overwrite no_way_out if mce_end() fails
Date:   Wed, 18 Nov 2020 15:15:49 +0000
Message-Id: <20201118151552.1412-2-gabriele.paoloni@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201118151552.1412-1-gabriele.paoloni@intel.com>
References: <20201118151552.1412-1-gabriele.paoloni@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Currently if mce_end() fails no_way_out is set equal to worst.
worst is the worst severirty that was found in the MCA banks
associated to the current CPU; however at this point no_way_out
could be already set by mca_start() by looking at all severities
of all CPUs that entered the MCE handler.
if mce_end() fails we first check if no_way_out is already set and
if so we stick to it, otherwise we use the local worst value

Signed-off-by: Gabriele Paoloni <gabriele.paoloni@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 4102b866e7c0..b990892c6766 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1385,7 +1385,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	 */
 	if (!lmce) {
 		if (mce_end(order) < 0)
-			no_way_out = worst >= MCE_PANIC_SEVERITY;
+			no_way_out = no_way_out ? no_way_out : worst >= MCE_PANIC_SEVERITY;
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

