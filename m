Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57565B488D
	for <lists+linux-edac@lfdr.de>; Sat, 10 Sep 2022 21:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiIJT5R (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 10 Sep 2022 15:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiIJT5O (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 10 Sep 2022 15:57:14 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4865345F6E;
        Sat, 10 Sep 2022 12:57:11 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 4631CDBA;
        Sat, 10 Sep 2022 23:00:55 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 4631CDBA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1662840055;
        bh=kpBrj/0I2/WFJ0dlYLMNRBqo3ds1nP7W4MtluGZBlD0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=QeL1ubQA79hK9p3QimApL2aZ2dBLudSwQalue/9QG1AWK491CFdKNfIo25THkS5gd
         z/xoNjBJiaV7mms/ifN0G5CUOrp15MdWOf1jUITAcR9KU1c8sH1t9+yagQ4pSLdxIH
         nGWdV7JpasDgHqLDWS9um6X7iaEF15zuHWTDK1Vg=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 10 Sep 2022 22:57:04 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 05/15] EDAC/synopsys: Add multi-ranked memory support
Date:   Sat, 10 Sep 2022 22:56:49 +0300
Message-ID: <20220910195659.11843-6-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220910195659.11843-1-Sergey.Semin@baikalelectronics.ru>
References: <20220910195659.11843-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

DW uMCTL2 DDRC supports multi-rank memory attached to the controller. If
so the MSTR.active_ranks field will be set with the populated ranks
bitfield. It is permitted to have one, two or four ranks activated at a
time [1]. Since we now have the number of ranks determined in the
controller configuration detection procedure, it can be easily used for
accordingly extending the MCI chip-select layer. In case of the ECC errors
the affected rank will be read from the CE/UE address CSRs [2].

Note we need to drop the ranks from the total memory size calculation
since multiple ranks are taken into account by means of the layer[0]
definition.

[1] DesignWare® Cores Enhanced Universal DDR Memory Controller (uMCTL2)
    Databook, Version 3.91a, October 2020, p.739
[2] DesignWare® Cores Enhanced Universal DDR Memory Controller (uMCTL2)
    Databook, Version 3.91a, October 2020, p.821, p.832

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/edac/synopsys_edac.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index e1e5468acbd2..d5d82531719b 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -23,9 +23,6 @@
 
 #include "edac_module.h"
 
-/* Number of cs_rows needed per memory controller */
-#define SNPS_EDAC_NR_CSROWS		1
-
 /* Number of channels per memory controller */
 #define SNPS_EDAC_NR_CHANS		1
 
@@ -795,7 +792,7 @@ static void snps_handle_error(struct mem_ctl_info *mci, struct snps_ecc_status *
 
 		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, p->ce_cnt,
 				     PHYS_PFN(sys), offset_in_page(sys),
-				     pinf->syndrome, 0, 0, -1,
+				     pinf->syndrome, pinf->sdram.rank, 0, -1,
 				     priv->message, "");
 	}
 
@@ -812,7 +809,7 @@ static void snps_handle_error(struct mem_ctl_info *mci, struct snps_ecc_status *
 
 		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci, p->ue_cnt,
 				     PHYS_PFN(sys), offset_in_page(sys),
-				     pinf->syndrome, 0, 0, -1,
+				     pinf->syndrome, pinf->sdram.rank, 0, -1,
 				     priv->message, "");
 	}
 
@@ -1411,10 +1408,7 @@ static u64 snps_get_sdram_size(struct snps_edac_priv *priv)
 			size++;
 	}
 
-	for (i = 0; i < DDR_MAX_RANK_WIDTH; i++) {
-		if (map->rank[i] != DDR_ADDRMAP_UNUSED)
-			size++;
-	}
+	/* Skip the ranks since the multi-rankness is determined by layer[0] */
 
 	return 1ULL << (size + priv->info.dq_width);
 }
@@ -1468,7 +1462,7 @@ static struct mem_ctl_info *snps_mc_create(struct snps_edac_priv *priv)
 	struct mem_ctl_info *mci;
 
 	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
-	layers[0].size = SNPS_EDAC_NR_CSROWS;
+	layers[0].size = priv->info.ranks;
 	layers[0].is_virt_csrow = true;
 	layers[1].type = EDAC_MC_LAYER_CHANNEL;
 	layers[1].size = SNPS_EDAC_NR_CHANS;
-- 
2.37.2

