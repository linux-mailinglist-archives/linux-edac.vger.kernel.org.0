Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD83959C8A7
	for <lists+linux-edac@lfdr.de>; Mon, 22 Aug 2022 21:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238514AbiHVTVn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Aug 2022 15:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238700AbiHVTU5 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Aug 2022 15:20:57 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95E2813D53;
        Mon, 22 Aug 2022 12:20:30 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 3BA08DAA;
        Mon, 22 Aug 2022 22:23:35 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 3BA08DAA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1661196215;
        bh=7ylqOa6KtJzxYsNaCkDs3IPpzbBntgjWaRfez9/K1Vg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=ZPsh344g5kt09WPZsyhHNO38n/ilN/AlbJxS/8zp9Wau0lzTuZlXkvFCCFGcLjiJe
         cL2hGjmz8g3fT3NqvM8NhOvfvYkfbdmqdCjrott2er7/ZbwODJkaPQgcf+hQrlYN1b
         Xg61HbCBp94tu2Vxccvz3kBA4jT4DkD+di8rb1OM=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 22 Aug 2022 22:20:21 +0300
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
Subject: [PATCH 08/13] EDAC/synopsys: Add individual named ECC IRQs support
Date:   Mon, 22 Aug 2022 22:19:51 +0300
Message-ID: <20220822191957.28546-9-Sergey.Semin@baikalelectronics.ru>
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

Currently the DW uMCTL2 DDRC EDAC driver supports a common unnamed IRQ
only. It isn't suitable for our platform which has the individual IRQ
lines for each DDRC event (ECC UE, ECC CE, DFI parity error, Scrubber
done, etc).  Moreover the DW uMCTL2 DDRC IP-core doesn't have an option to
be configured with a common interrupts output line. So in order to have
the generic DW uMCTL2 DDR controller and our platform supported by the
driver we need to add the individual, per DDRC event, IRQs request
support. There is not much to do really since the common IRQs handler has
already been split up into the sub-handlers. So the only thing we need to
do is first try to request the individual IRQs, if failed then fallback to
the common IRQ. The IRQ names are used in accordance with the DW uMCTL2
DDRC DT-bindings.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/edac/synopsys_edac.c | 91 ++++++++++++++++++++++++++++++++----
 1 file changed, 81 insertions(+), 10 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index ac0123ff4595..e7d59238c5ca 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -1524,25 +1524,96 @@ static void snps_mc_free(struct mem_ctl_info *mci)
 	edac_mc_free(mci);
 }
 
-static int snps_setup_irq(struct mem_ctl_info *mci)
+/**
+ * snps_request_ind_irq - Request individual DDRC IRQs.
+ * @mci:	EDAC memory controller instance.
+ *
+ * Return: 0 if the IRQs were successfully requested, 1 if the individual IRQs
+ * are unavailable, otherwise negative errno.
+ */
+static int snps_request_ind_irq(struct mem_ctl_info *mci)
 {
 	struct snps_edac_priv *priv = mci->pvt_info;
-	int ret, irq;
+	struct device *dev = &priv->pdev->dev;
+	int rc, irq;
 
-	irq = platform_get_irq(priv->pdev, 0);
-	if (irq < 0) {
-		edac_printk(KERN_ERR, EDAC_MC,
-			    "No IRQ %d in DT\n", irq);
+	irq = platform_get_irq_byname_optional(priv->pdev, "ecc_ce");
+	if (irq == -ENXIO)
+		return 1;
+	if (irq < 0)
+		return irq;
+
+	rc = devm_request_irq(dev, irq, snps_ce_irq_handler, 0, "ecc_ce", mci);
+	if (rc) {
+		edac_printk(KERN_ERR, EDAC_MC, "Failed to request ECC CE IRQ\n");
+		return rc;
+	}
+
+	irq = platform_get_irq_byname(priv->pdev, "ecc_ue");
+	if (irq < 0)
 		return irq;
+
+	rc = devm_request_irq(dev, irq, snps_ue_irq_handler, 0, "ecc_ue", mci);
+	if (rc) {
+		edac_printk(KERN_ERR, EDAC_MC, "Failed to request ECC UE IRQ\n");
+		return rc;
+	}
+
+	return 0;
+}
+
+/**
+ * snps_request_com_irq - Request common DDRC IRQ.
+ * @mci:	EDAC memory controller instance.
+ *
+ * It first attempts to get the named IRQ. If failed the method fallbacks
+ * to first available one.
+ *
+ * Return: 0 if the IRQ was successfully requested otherwise negative errno.
+ */
+static int snps_request_com_irq(struct mem_ctl_info *mci)
+{
+	struct snps_edac_priv *priv = mci->pvt_info;
+	struct device *dev = &priv->pdev->dev;
+	int rc, irq;
+
+	irq = platform_get_irq_byname_optional(priv->pdev, "ecc");
+	if (irq < 0) {
+		irq = platform_get_irq(priv->pdev, 0);
+		if (irq < 0)
+			return irq;
 	}
 
-	ret = devm_request_irq(&priv->pdev->dev, irq, snps_com_irq_handler,
-			       0, dev_name(&priv->pdev->dev), mci);
-	if (ret < 0) {
+	rc = devm_request_irq(dev, irq, snps_com_irq_handler, 0, "ecc", mci);
+	if (rc) {
 		edac_printk(KERN_ERR, EDAC_MC, "Failed to request IRQ\n");
-		return ret;
+		return rc;
 	}
 
+	return 0;
+}
+
+/**
+ * snps_setup_irq - Request and enable DDRC IRQs.
+ * @mci:	EDAC memory controller instance.
+ *
+ * It first tries to get and request individual IRQs. If failed the method
+ * fallbacks to the common IRQ line case. The IRQs will be enabled only if
+ * some of these requests have been successful.
+ *
+ * Return: 0 if IRQs were successfully setup otherwise negative errno.
+ */
+static int snps_setup_irq(struct mem_ctl_info *mci)
+{
+	struct snps_edac_priv *priv = mci->pvt_info;
+	int rc;
+
+	rc = snps_request_ind_irq(mci);
+	if (rc > 0)
+		rc = snps_request_com_irq(mci);
+	if (rc)
+		return rc;
+
 	snps_enable_irq(priv);
 
 	return 0;
-- 
2.35.1

