Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4F95F16F8
	for <lists+linux-edac@lfdr.de>; Sat,  1 Oct 2022 02:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbiJAAOW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 30 Sep 2022 20:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiJAAOU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 30 Sep 2022 20:14:20 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54F261BE782;
        Fri, 30 Sep 2022 17:14:15 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id DBF96E0EDA;
        Fri, 30 Sep 2022 02:36:36 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=D65qudqE/ZEcZviOvFPE9+XbDAmFqIx7CZ3DB/NhvX4=; b=mK6IvTR9g7tt
        7cVqjYJG+wkAQwI2l0PLvg8WUmbKMo5xAPZqrSux+ET7fgbnmezAguOTNQ7LFsJa
        0HgACogY/leLuJbKlvVHXJxYX5WsebyX7zCvQFWUDrP6MEKJIoJ0EKBwGwFzaXMy
        lCLELBAyMXtzlIkpjT+H24kiuxj4i4s=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id C2DBDE0E70;
        Fri, 30 Sep 2022 02:36:36 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 30 Sep 2022 02:36:37 +0300
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
Subject: [PATCH RESEND v3 08/18] EDAC/synopsys: Parse ADDRMAP[0] CSR for multi-ranks case only
Date:   Fri, 30 Sep 2022 02:35:20 +0300
Message-ID: <20220929233530.13016-9-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220929233530.13016-1-Sergey.Semin@baikalelectronics.ru>
References: <20220929233530.13016-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.168.10]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
index a55ae7ff931c..87acb683ab5c 100644
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
2.37.3


