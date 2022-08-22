Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D7C59C8A0
	for <lists+linux-edac@lfdr.de>; Mon, 22 Aug 2022 21:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238229AbiHVTV1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Aug 2022 15:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238691AbiHVTU4 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Aug 2022 15:20:56 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0732913D14;
        Mon, 22 Aug 2022 12:20:23 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 9D50CDA6;
        Mon, 22 Aug 2022 22:23:30 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 9D50CDA6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1661196210;
        bh=LzgKLA2Es3MVjHYo8FGWSLKo8lr8OalQ3g2hasfSC+k=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=YlzCnLA1UyogqEyTz5GoGP8fEomf1wvjDDnWhNAzjskiCrSVudf8ovRgwV2EyI87t
         9aa0j/EtmY5KKQFwDrXEiHh9yV26f2zsbOnLUzg6wARVRpv6v3BVDt6gPE+BAysizW
         ISrqu6Y/F6sElTkPQOATQU49INUv6to2bCKe0HfE=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 22 Aug 2022 22:20:16 +0300
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
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 04/13] EDAC/synopsys: Add optional ECC Scrub support
Date:   Mon, 22 Aug 2022 22:19:47 +0300
Message-ID: <20220822191957.28546-5-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220822191957.28546-1-Sergey.Semin@baikalelectronics.ru>
References: <20220822191957.28546-1-Sergey.Semin@baikalelectronics.ru>
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

DW uMCTL2 DDRC ECC has a so called ECC Scrub feature in case if an
single-bit error is detected. The scrub is executed as a new RMW operation
to the location that resulted in a single-bit error thus fixing the ECC
code preserved in the SDRAM. But that feature not only optional, but also
runtime switchable. So there can be platforms with DW uMCTL2 DDRC not
supporting hardware-base scrub. In those cases the single-bit errors will
still be detected but won't be fixed until the next SDRAM write commands
to the erroneous location. Since the ECC Scrub feature availability is
detectable by means of the ECCCFG0.dis_scrub flag state we can use it to
tune the MCI core up so one would automatically execute the
platform-specific the platform-specific scrubbing to the affected SDRAM
location. It's now possible to be done since the DW uMCTL2 DDRC driver
supports the actual system address reported to the MCI core. The only
thing left to do is to auto-detect the ECC Scrub feature availability and
set the mem_ctl.info.scrub_mode mode with SCRUB_SW_SRC if the feature is
unavailable. The rest will be done by the MCI core when the single-bit
errors happen.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/edac/synopsys_edac.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 872ad9a164a7..2b8de7e8fae1 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -32,6 +32,7 @@
 #define SNPS_EDAC_MOD_VER		"1"
 
 /* DDR capabilities */
+#define SNPS_CAP_ECC_SCRUB		BIT(0)
 #define SNPS_CAP_ZYNQMP			BIT(31)
 
 /* Synopsys uMCTL2 DDR controller registers that are relevant to ECC */
@@ -114,6 +115,7 @@
 #define DDR_MSTR_MEM_LPDDR4		BIT(5)
 
 /* ECC CFG0 register definitions */
+#define ECC_CFG0_DIS_SCRUB		BIT(4)
 #define ECC_CFG0_MODE_MASK		GENMASK(2, 0)
 
 /* ECC status register definitions */
@@ -1008,6 +1010,10 @@ static int snps_get_ddrc_info(struct snps_edac_priv *priv)
 		return -ENXIO;
 	}
 
+	/* Assume HW-src scrub is always available if it isn't disabled */
+	if (!(regval & ECC_CFG0_DIS_SCRUB))
+		priv->info.caps |= SNPS_CAP_ECC_SCRUB;
+
 	/* Auto-detect the basic HIF/SDRAM bus parameters */
 	regval = readl(priv->baseaddr + DDR_MSTR_OFST);
 
@@ -1484,8 +1490,14 @@ static struct mem_ctl_info *snps_mc_create(struct snps_edac_priv *priv)
 			 MEM_FLAG_DDR3 | MEM_FLAG_LPDDR3 |
 			 MEM_FLAG_DDR4 | MEM_FLAG_LPDDR4;
 	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
-	mci->scrub_cap = SCRUB_FLAG_HW_SRC;
-	mci->scrub_mode = SCRUB_NONE;
+
+	if (priv->info.caps & SNPS_CAP_ECC_SCRUB) {
+		mci->scrub_mode = SCRUB_HW_SRC;
+		mci->scrub_cap = SCRUB_FLAG_HW_SRC;
+	} else {
+		mci->scrub_mode = SCRUB_SW_SRC;
+		mci->scrub_cap = SCRUB_FLAG_SW_SRC;
+	}
 
 	mci->edac_cap = EDAC_FLAG_SECDED;
 	mci->ctl_name = "snps_umctl2_ddrc";
@@ -1578,6 +1590,8 @@ static int snps_ddrc_info_show(struct seq_file *s, void *data)
 
 	seq_puts(s, "Caps:");
 	if (priv->info.caps) {
+		if (priv->info.caps & SNPS_CAP_ECC_SCRUB)
+			seq_puts(s, " +Scrub");
 		if (priv->info.caps & SNPS_CAP_ZYNQMP)
 			seq_puts(s, " +ZynqMP");
 	} else {
-- 
2.35.1

