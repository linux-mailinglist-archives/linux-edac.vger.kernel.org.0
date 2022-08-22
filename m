Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B973759C85B
	for <lists+linux-edac@lfdr.de>; Mon, 22 Aug 2022 21:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238405AbiHVTPR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Aug 2022 15:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238348AbiHVTOx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Aug 2022 15:14:53 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4243D2B609;
        Mon, 22 Aug 2022 12:14:47 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 9B660DAA;
        Mon, 22 Aug 2022 22:17:48 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 9B660DAA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1661195868;
        bh=S4Cpg3F9AoedZ1cfMlJGVURz8OADsydtqtvGr0KhezI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=h+bT8RkjDOm7fmyJhnYYUGLPCtCDoa7TYf8uXnrCp8tKFOGDUSFS9cGpjin6WzVjl
         evjrlOYibix15LOovSQ6iaKF4gySj8Y9b8Pm972Cz3oGuCKlxC3bKqx2xM3iOifoMx
         YnLmymo6T7Z7n/dkdrGgao3AeCME0W5sTBB/H/pI=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 22 Aug 2022 22:14:34 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Michal Simek <michal.simek@xilinx.com>,
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
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 08/18] EDAC/synopsys: Parse ADDRMAP[0] CSR for multi-ranks case only
Date:   Mon, 22 Aug 2022 22:14:17 +0300
Message-ID: <20220822191427.27969-9-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220822191427.27969-1-Sergey.Semin@baikalelectronics.ru>
References: <20220822191427.27969-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The ADDRMAP[0] CSR contains the SDRAM Rank bits mapping. Obviously it's
applicable for the multi-ranked memory only. If either the attached memory
isn't multi-ranked or the controller simply doesn't support the multi-rank
memory, parsing the ADDRMAP[0] CSR will be not just pointless, but in the
later case erroneous since the CSR may contain garbage data. So make sure
the ADDRMAP[0] register is only parsed if the multi-ranked memory setup
has been detected.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/edac/synopsys_edac.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 998600670c75..e7f8d448850b 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -1143,9 +1143,12 @@ static void snps_setup_bg_address_map(struct snps_edac_priv *priv, u32 *addrmap)
 
 static void snps_setup_rank_address_map(struct snps_edac_priv *priv, u32 *addrmap)
 {
-	priv->rank_shift[0] = ((addrmap[0] & RANK_MAX_VAL_MASK) ==
-				RANK_MAX_VAL_MASK) ? 0 : ((addrmap[0] &
-				RANK_MAX_VAL_MASK) + RANK_B0_BASE);
+	/* Ranks mapping is unavailable for the single-ranked memory */
+	if (priv->info.ranks > 1) {
+		priv->rank_shift[0] = ((addrmap[0] & RANK_MAX_VAL_MASK) ==
+					RANK_MAX_VAL_MASK) ? 0 : ((addrmap[0] &
+					RANK_MAX_VAL_MASK) + RANK_B0_BASE);
+	}
 }
 
 /**
-- 
2.35.1

