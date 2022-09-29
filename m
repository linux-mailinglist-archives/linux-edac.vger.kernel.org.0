Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419545F16FD
	for <lists+linux-edac@lfdr.de>; Sat,  1 Oct 2022 02:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbiJAAOZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 30 Sep 2022 20:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbiJAAOW (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 30 Sep 2022 20:14:22 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D5141BE785;
        Fri, 30 Sep 2022 17:14:15 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 35D0AE0ED4;
        Fri, 30 Sep 2022 02:36:33 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=x8I3gzj0E45aSX1C7FH1PsX3pFFI9mtYLJ/RDgR1DJQ=; b=a0npqAjEYKNW
        cCKAxuE2ayXfB1BgD2MgRituJYN2xuhijtnbtkuwPZJxml5ILwBoZs+vdHn55EaP
        XATLDtYRA2naJrNfTn1J4VNBHarAgE1oI2neIGk6Y8aXJ2ITTVpNAigK5BAwduI/
        4ObfUvocOG91z75QhPg0fa/LVryrktE=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 28370E0E70;
        Fri, 30 Sep 2022 02:36:33 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 30 Sep 2022 02:36:33 +0300
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
Subject: [PATCH RESEND v3 03/18] EDAC/synopsys: Extend memtypes supported by controller
Date:   Fri, 30 Sep 2022 02:35:15 +0300
Message-ID: <20220929233530.13016-4-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220929233530.13016-1-Sergey.Semin@baikalelectronics.ru>
References: <20220929233530.13016-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

In accordance with [1] the DW uMCTL2 DDR controllers can support the next
DDR protocols: LPDDR, (LP)DDR(2|3|4). If the controller is configured to
support several of these memory chip types only one of these modes will be
able to be enabled at runtime [2]. Taking all of that into account in
order to have a generic DW uMCTL2 DDR controller support in the driver we
need to update the snps_get_mtype() procedure so one would be able to
detect all the currently supported memory types in accordance with the
table defined in [2]. Note alas it's not possible do determine which MEMC
DDR configs were enabled at the IP-core synthesize. Thus we have no choice
but to initialize the mci->mtype_cap field with all the types claimed to
be supported by the reference manual.

While at it convert the MEM_TYPE_* macros to have a unified within the
driver name - attach DDR_MSTR prefix indicating the CSR macro is defined
for.

[1] DesignWare® Cores Enhanced Universal DDR Memory Controller (uMCTL2)
Databook, Version 3.91a, October 2020, p.501
[2] DesignWare® Cores Enhanced Universal DDR Memory Controller (uMCTL2)
Databook, Version 3.91a, October 2020, p.501

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/edac/synopsys_edac.c | 59 +++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 24 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index b2a2f938045c..5adf6598465a 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -97,6 +97,14 @@
 #define DDRCTL_EWDTH_16			2
 #define DDRCTL_EWDTH_32			1
 #define DDRCTL_EWDTH_64			0
+#define DDR_MSTR_MEM_MASK		GENMASK(5, 0)
+#define DDR_MSTR_MEM_DDR2		0
+#define DDR_MSTR_MEM_DDR3		BIT(0)
+#define DDR_MSTR_MEM_LPDDR		BIT(1)
+#define DDR_MSTR_MEM_LPDDR2		BIT(2)
+#define DDR_MSTR_MEM_LPDDR3		BIT(3)
+#define DDR_MSTR_MEM_DDR4		BIT(4)
+#define DDR_MSTR_MEM_LPDDR4		BIT(5)
 
 /* ECC CFG0 register definitions */
 #define ECC_CFG0_MODE_MASK		GENMASK(2, 0)
@@ -141,13 +149,6 @@
 #define ECC_POISON1_BANK_MASK		GENMASK(26, 24)
 #define ECC_POISON1_ROW_MASK		GENMASK(17, 0)
 
-/* DDR Memory type defines */
-#define MEM_TYPE_DDR3			BIT(0)
-#define MEM_TYPE_DDR2			BIT(2)
-#define MEM_TYPE_LPDDR3			BIT(3)
-#define MEM_TYPE_DDR4			BIT(4)
-#define MEM_TYPE_LPDDR4			BIT(5)
-
 /* DDRC ECC CE & UE poison mask */
 #define ECC_CEPOISON_MASK		GENMASK(1, 0)
 #define ECC_UEPOISON_MASK		BIT(0)
@@ -473,7 +474,7 @@ static enum dev_type snps_get_dtype(const void __iomem *base)
 	u32 regval;
 
 	regval = readl(base + DDR_MSTR_OFST);
-	if (!(regval & MEM_TYPE_DDR4))
+	if (!(regval & DDR_MSTR_MEM_DDR4))
 		return DEV_UNKNOWN;
 
 	regval = FIELD_GET(DDR_MSTR_DEV_CFG_MASK, regval);
@@ -534,21 +535,29 @@ static u32 snps_get_memsize(void)
  */
 static enum mem_type snps_get_mtype(const void __iomem *base)
 {
-	enum mem_type mt;
-	u32 memtype;
+	u32 regval;
 
-	memtype = readl(base + DDR_MSTR_OFST);
+	regval = readl(base + DDR_MSTR_OFST);
+	regval = FIELD_GET(DDR_MSTR_MEM_MASK, regval);
 
-	if ((memtype & MEM_TYPE_DDR3) || (memtype & MEM_TYPE_LPDDR3))
-		mt = MEM_DDR3;
-	else if (memtype & MEM_TYPE_DDR2)
-		mt = MEM_RDDR2;
-	else if ((memtype & MEM_TYPE_LPDDR4) || (memtype & MEM_TYPE_DDR4))
-		mt = MEM_DDR4;
-	else
-		mt = MEM_EMPTY;
+	switch (regval) {
+	case DDR_MSTR_MEM_DDR2:
+		return MEM_DDR2;
+	case DDR_MSTR_MEM_DDR3:
+		return MEM_DDR3;
+	case DDR_MSTR_MEM_LPDDR:
+		return MEM_LPDDR;
+	case DDR_MSTR_MEM_LPDDR2:
+		return MEM_LPDDR2;
+	case DDR_MSTR_MEM_LPDDR3:
+		return MEM_LPDDR3;
+	case DDR_MSTR_MEM_DDR4:
+		return MEM_DDR4;
+	case DDR_MSTR_MEM_LPDDR4:
+		return MEM_LPDDR4;
+	}
 
-	return mt;
+	return MEM_RESERVED;
 }
 
 /**
@@ -596,7 +605,9 @@ static void snps_mc_init(struct mem_ctl_info *mci, struct platform_device *pdev)
 	platform_set_drvdata(pdev, mci);
 
 	/* Initialize controller capabilities and configuration */
-	mci->mtype_cap = MEM_FLAG_DDR3 | MEM_FLAG_DDR2;
+	mci->mtype_cap = MEM_FLAG_LPDDR | MEM_FLAG_DDR2 | MEM_FLAG_LPDDR2 |
+			 MEM_FLAG_DDR3 | MEM_FLAG_LPDDR3 |
+			 MEM_FLAG_DDR4 | MEM_FLAG_LPDDR4;
 	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
 	mci->scrub_cap = SCRUB_FLAG_HW_SRC;
 	mci->scrub_mode = SCRUB_NONE;
@@ -802,7 +813,7 @@ static void snps_setup_column_address_map(struct snps_edac_priv *priv, u32 *addr
 			COL_MAX_VAL_MASK) ? 0 : (((addrmap[3] >> 24) &
 					COL_MAX_VAL_MASK) + COL_B9_BASE);
 	if (width == DDRCTL_EWDTH_64) {
-		if (memtype & MEM_TYPE_LPDDR3) {
+		if (memtype & DDR_MSTR_MEM_LPDDR3) {
 			priv->col_shift[10] = ((addrmap[4] &
 				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
 				((addrmap[4] & COL_MAX_VAL_MASK) +
@@ -822,7 +833,7 @@ static void snps_setup_column_address_map(struct snps_edac_priv *priv, u32 *addr
 				 COL_B11_BASE);
 		}
 	} else if (width == DDRCTL_EWDTH_32) {
-		if (memtype & MEM_TYPE_LPDDR3) {
+		if (memtype & DDR_MSTR_MEM_LPDDR3) {
 			priv->col_shift[10] = (((addrmap[3] >> 24) &
 				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
 				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
@@ -842,7 +853,7 @@ static void snps_setup_column_address_map(struct snps_edac_priv *priv, u32 *addr
 				 COL_B10_BASE);
 		}
 	} else {
-		if (memtype & MEM_TYPE_LPDDR3) {
+		if (memtype & DDR_MSTR_MEM_LPDDR3) {
 			priv->col_shift[10] = (((addrmap[3] >> 16) &
 				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
 				(((addrmap[3] >> 16) & COL_MAX_VAL_MASK) +
-- 
2.37.3


