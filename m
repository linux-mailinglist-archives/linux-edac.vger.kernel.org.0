Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F512C693B
	for <lists+linux-edac@lfdr.de>; Fri, 27 Nov 2020 17:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730603AbgK0QSZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 27 Nov 2020 11:18:25 -0500
Received: from mga09.intel.com ([134.134.136.24]:46780 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730324AbgK0QSZ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 27 Nov 2020 11:18:25 -0500
IronPort-SDR: x0y67RIEi1s+LRD2SuyAMOuGErhkRJFSYNb6Mqt2n2cfN1QkikNt23jSK9GiU6kIjQoygCXUnt
 dJFLUrmEqtNQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9818"; a="172567140"
X-IronPort-AV: E=Sophos;i="5.78,375,1599548400"; 
   d="scan'208";a="172567140"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2020 08:18:23 -0800
IronPort-SDR: T/NWv4uCOBGKnlk2FygWraXekl408JsHQNbQYeOPsnFR037rmidmuwBhpKYYyBXX6kEtHakYr8
 esiAIiCl+mpQ==
X-IronPort-AV: E=Sophos;i="5.78,375,1599548400"; 
   d="scan'208";a="548095098"
Received: from paolonig001.ir.intel.com ([163.33.183.93])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2020 08:18:21 -0800
From:   Gabriele Paoloni <gabriele.paoloni@intel.com>
To:     tony.luck@intel.com, bp@alien8.de, tglx@linutronix.de,
        mingo@redhat.com, x86@kernel.org, hpa@zytor.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gabriele.paoloni@intel.com, linux-safety@lists.elisa.tech
Subject: [PATCH v2 0/5] x86/MCE: some minor fixes
Date:   Fri, 27 Nov 2020 16:18:14 +0000
Message-Id: <20201127161819.3106432-1-gabriele.paoloni@intel.com>
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

Changes since v1:
- fixed grammar
- improved readibility of patch1 and Cc'd for stable
- kill_it flag renamed to kill_current_task

Signed-off-by: Gabriele Paoloni <gabriele.paoloni@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>

Gabriele Paoloni (5):
  x86/mce: do not overwrite no_way_out if mce_end() fails
  x86/mce: move the mce_panic() call and 'kill_it' assignments to the
    right places
  x86/mce: for LMCE panic only if mca_cfg.tolerant < 3
  x86/mce: remove redundant call to irq_work_queue()
  x86/mce: rename kill_it as kill_current_task

 arch/x86/kernel/cpu/mce/core.c | 39 +++++++++++++++-------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

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

