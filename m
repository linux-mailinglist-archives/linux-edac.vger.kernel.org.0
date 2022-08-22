Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C77659C85A
	for <lists+linux-edac@lfdr.de>; Mon, 22 Aug 2022 21:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238356AbiHVTPT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Aug 2022 15:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238354AbiHVTOy (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Aug 2022 15:14:54 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C87A2E6B6;
        Mon, 22 Aug 2022 12:14:50 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 0CDDBDAD;
        Mon, 22 Aug 2022 22:17:50 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 0CDDBDAD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1661195870;
        bh=kpRHN29U1DttBVDwy7emXYhRqJj3KzrSFf1idcg+CP4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=jYC2mlb2pxEhhWnTUAECBQ3M0wLfdoZeld3CH9TGI/hsPrVqBSdZ9raeNBfi5fwoE
         3g6L+YtjLtzL75TAa0gPWpJ6cLFkvwtvChcDp1zugODpx1o8/vskjQF4ziwwv2MiUt
         97yPZMTSZ1K5fvXeGxApubeOzrKp2smiBhexgwh4=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 22 Aug 2022 22:14:35 +0300
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
Subject: [PATCH 10/18] EDAC/synopsys: Get corrected bit position
Date:   Mon, 22 Aug 2022 22:14:19 +0300
Message-ID: <20220822191427.27969-11-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220822191427.27969-1-Sergey.Semin@baikalelectronics.ru>
References: <20220822191427.27969-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

Since the DQ-bus width is now available in the driver we can use it to
calculate the bit-position corrected by the ECC engine. It can be done
based on the offsets provided in the table [1]. Using info from that table
let's introduce a new inline method snps_get_bitpos() which would provide
the actual CE bit-position based on the value read from the
ECCSTAT.corrected_bit_num field and the DQ-bus width. The method will be
called if a corrected error is detected.

[1] DesignWare® Cores Enhanced Universal DDR Memory Controller (uMCTL2)
    Databook, Version 3.91a, October 2020, p.426-427

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/edac/synopsys_edac.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index af34a83dc1ef..5a116c9ebeda 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -10,6 +10,7 @@
 #include <linux/bitfield.h>
 #include <linux/edac.h>
 #include <linux/fs.h>
+#include <linux/log2.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/seq_file.h>
@@ -357,6 +358,27 @@ struct snps_edac_priv {
 #endif
 };
 
+/**
+ * snps_get_bitpos - Get DQ-bus corrected bit position.
+ * @bitnum:	Bit number retrieved from the ECCSTAT.corrected_bit_num field.
+ * @dq_width:	Controller DQ-bus width.
+ *
+ * Return: actual corrected DQ-bus bit position starting from 0.
+ */
+static inline u32 snps_get_bitpos(u32 bitnum, enum snps_dq_width dq_width)
+{
+	/* ecc[0] bit */
+	if (bitnum == 0)
+		return BITS_PER_BYTE << dq_width;
+
+	/* ecc[1:x] bit */
+	if (is_power_of_2(bitnum))
+		return (BITS_PER_BYTE << dq_width) + ilog2(bitnum) + 1;
+
+	/* data[0:y] bit */
+	return bitnum - ilog2(bitnum) - 2;
+}
+
 /**
  * snps_get_error_info - Get the current ECC error info.
  * @priv:	DDR memory controller private instance data.
@@ -385,6 +407,8 @@ static int snps_get_error_info(struct snps_edac_priv *priv)
 	if (!p->ce_cnt)
 		goto ue_err;
 
+	p->ceinfo.bitpos = snps_get_bitpos(p->ceinfo.bitpos, priv->info.dq_width);
+
 	regval = readl(base + ECC_CEADDR0_OFST);
 	p->ceinfo.row = FIELD_GET(ECC_CEADDR0_ROW_MASK, regval);
 
-- 
2.35.1

