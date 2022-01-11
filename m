Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0108D48B256
	for <lists+linux-edac@lfdr.de>; Tue, 11 Jan 2022 17:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343617AbiAKQiI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 11 Jan 2022 11:38:08 -0500
Received: from linux.microsoft.com ([13.77.154.182]:55310 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240478AbiAKQiH (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 11 Jan 2022 11:38:07 -0500
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id D0F8A20B7179;
        Tue, 11 Jan 2022 08:38:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D0F8A20B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1641919087;
        bh=LQTIt1o2dF9xnFNozSO3fGIYEI6teAaPWNDzB2AGpiE=;
        h=From:To:Cc:Subject:Date:From;
        b=hJiEShbln4ZTPutSnCrBawnDK48pJSbhlWsT3ohzVkjorbyk3I4fXJVGjj7XvpuzF
         Ovh+nf2trS4hlPcum7sGkLHhIuQNgEMA2AD31VZd3wWLDW+OfK8dP8g2AvUFRp3SBv
         UMkxMz+LEfyInOaauyNqc9GUSvVAa8T6qZu9+3Kk=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Lei Wang <lewan@microsoft.com>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sinan Kaya <okaya@kernel.org>,
        Shiping Ji <shiping.linux@gmail.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] EDAC/dmc520: Don't print an error for each unconfigured interrupt line
Date:   Tue, 11 Jan 2022 10:38:00 -0600
Message-Id: <20220111163800.22362-1-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The dmc520 driver requires that at least one interrupt line, out of the ten
possible, is configured. The driver prints an error and returns -EINVAL
from its .probe function if there are no interrupt lines configured.

Don't print a KERN_ERR level message for each interrupt line that's
unconfigured as that can confuse users into thinking that there is an
error condition.

Before this change, the following KERN_ERR level messages would be
reported if only dram_ecc_errc and dram_ecc_errd were configured in the
device tree:

 dmc520 68000000.dmc: IRQ ram_ecc_errc not found
 dmc520 68000000.dmc: IRQ ram_ecc_errd not found
 dmc520 68000000.dmc: IRQ failed_access not found
 dmc520 68000000.dmc: IRQ failed_prog not found
 dmc520 68000000.dmc: IRQ link_err not
 dmc520 68000000.dmc: IRQ temperature_event not found
 dmc520 68000000.dmc: IRQ arch_fsm not found
 dmc520 68000000.dmc: IRQ phy_request not found

Fixes: 1088750d7839 ("EDAC: Add EDAC driver for DMC520")
Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
Cc: <stable@vger.kernel.org>
Reported-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/edac/dmc520_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/dmc520_edac.c b/drivers/edac/dmc520_edac.c
index b8a7d9594afd..1fa5ca57e9ec 100644
--- a/drivers/edac/dmc520_edac.c
+++ b/drivers/edac/dmc520_edac.c
@@ -489,7 +489,7 @@ static int dmc520_edac_probe(struct platform_device *pdev)
 	dev = &pdev->dev;
 
 	for (idx = 0; idx < NUMBER_OF_IRQS; idx++) {
-		irq = platform_get_irq_byname(pdev, dmc520_irq_configs[idx].name);
+		irq = platform_get_irq_byname_optional(pdev, dmc520_irq_configs[idx].name);
 		irqs[idx] = irq;
 		masks[idx] = dmc520_irq_configs[idx].mask;
 		if (irq >= 0) {
-- 
2.25.1

