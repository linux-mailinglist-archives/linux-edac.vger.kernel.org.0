Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F615F1804
	for <lists+linux-edac@lfdr.de>; Sat,  1 Oct 2022 03:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbiJABOV (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 30 Sep 2022 21:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbiJABOU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 30 Sep 2022 21:14:20 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4CEBF74;
        Fri, 30 Sep 2022 18:14:12 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 2C1A9E0EC2;
        Fri, 30 Sep 2022 02:27:27 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=wm9cUlz9s3i/BTmlyVWrBRYZtZvcB8DRwSDQ4fSeZqA=; b=PgySd3wX01pd
        3tGG5J27WI+GnaqaEjZ/Me6OBKHOCvcZCgiHLJUf2FbnU3eRYio+GV3rNqY3w8hK
        hi94c/ilWE7CxFKuKmfGGsU/Ztb0I/BaNY7M2TT+xdCTC4+QDsBIr6kd/WLlkAmZ
        L5CXI032pYiMAhJjmQXHCp/MDoxecHQ=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 166D3E0E6B;
        Fri, 30 Sep 2022 02:27:27 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 30 Sep 2022 02:27:27 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Manish Narani <manish.narani@xilinx.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH RESEND v3 04/17] EDAC/synopsys: Drop erroneous ADDRMAP4.addrmap_col_b10 parse
Date:   Fri, 30 Sep 2022 02:26:59 +0300
Message-ID: <20220929232712.12202-5-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220929232712.12202-1-Sergey.Semin@baikalelectronics.ru>
References: <20220929232712.12202-1-Sergey.Semin@baikalelectronics.ru>
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

Currently the ADDRMAP4.addrmap_col_b10 field gets to be parsed in case of
the LPDDR3 memory and Quarter DQ bus width mode. It's wrong since that
field is marked as unused for that mode in all the available DW uMCTL2
DDRC releases (up to IP-core v3.91a). Most likely the field parsing has
been added by mistake as a result of the copy-paste from the Half DW bus
width mode part of the same function. Drop it from the driver for good
then.

Fixes: 1a81361f75d8 ("EDAC, synopsys: Add Error Injection support for ZynqMP DDR controller")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/edac/synopsys_edac.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index c6f3b383e5ff..da1d90a87778 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -1239,10 +1239,6 @@ static void setup_column_address_map(struct synps_edac_priv *priv, u32 *addrmap)
 				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
 				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
 				 COL_B9_BASE);
-			priv->col_shift[13] = ((addrmap[4] &
-				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
-				((addrmap[4] & COL_MAX_VAL_MASK) +
-				 COL_B10_BASE);
 		} else {
 			priv->col_shift[11] = (((addrmap[3] >> 16) &
 				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
-- 
2.37.3


