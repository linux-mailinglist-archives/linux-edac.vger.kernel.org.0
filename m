Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D095D2B803A
	for <lists+linux-edac@lfdr.de>; Wed, 18 Nov 2020 16:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727288AbgKRPQN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 18 Nov 2020 10:16:13 -0500
Received: from mga12.intel.com ([192.55.52.136]:8041 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgKRPQF (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 18 Nov 2020 10:16:05 -0500
IronPort-SDR: Y2MIooStId7wSQ174TkdaHh2uOPGlWFctZRnDtfcOMa48530j7r+N70h6OYtAqYjR/ELk92G46
 sHbfP7eNdrUA==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="150399351"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="150399351"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 07:15:59 -0800
IronPort-SDR: aTiYNJ44AM906CS+zhEMRp2fvFfXKQF7b6rvBGJ5Nwf/0Q3nXU6P0X3HedyxnM0djnyMjcm5o6
 OaFbHH0nu8Iw==
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="359492060"
Received: from paolonig001.ir.intel.com ([163.33.183.93])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 07:15:56 -0800
From:   Gabriele Paoloni <gabriele.paoloni@intel.com>
To:     tony.luck@intel.com, bp@alien8.de, tglx@linutronix.de,
        mingo@redhat.com, x86@kernel.org, hpa@zytor.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gabriele.paoloni@intel.com, linux-safety@lists.elisa.tech
Subject: [PATCH 0/4] x86/MCE: some minor fixes
Date:   Wed, 18 Nov 2020 15:15:48 +0000
Message-Id: <20201118151552.1412-1-gabriele.paoloni@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

During the safety analysis that was done in the context of the
ELISA project by the safety architecture working group some
incorrectnesses were spotted.
This patchset proposes some fixes.

Signed-off-by: Gabriele Paoloni <gabriele.paoloni@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>

Gabriele Paoloni (4):
  x86/mce: do not overwrite no_way_out if mce_end() fails
  x86/mce: move the mce_panic() call and kill_it assignments at the
    right places
  x86/mce: for LMCE panic only if mca_cfg.tolerant < 3
  x86/mce: remove redundant call to irq_work_queue()

 arch/x86/kernel/cpu/mce/core.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

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

