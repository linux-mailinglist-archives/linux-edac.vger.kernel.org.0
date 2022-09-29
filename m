Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70955F16FC
	for <lists+linux-edac@lfdr.de>; Sat,  1 Oct 2022 02:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbiJAAOY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 30 Sep 2022 20:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbiJAAOW (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 30 Sep 2022 20:14:22 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54E901BCAE7;
        Fri, 30 Sep 2022 17:14:15 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id DC36DE0ED5;
        Fri, 30 Sep 2022 02:36:33 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=+RJXK72Eyp2S6Hdgbd/CtU1VvIgPKFnpS0rqvPI0Yls=; b=Er61b2wCLwmo
        1edA6/Fek/qcSZBislaWWTn4wnKxUqHzbpeyhwfUd+yxo3nKPO0j0CE2a4r1rNvM
        CRVC8lHnzXQvSQpxo2OwvROJyMHd/Bb1W1Ke7qGwnHjxZoVTORaZMlKoaXkOfJgn
        Hg6fETG67F18znoWrg0SNvilsN+PoeU=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id CD9FDE0E70;
        Fri, 30 Sep 2022 02:36:33 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 30 Sep 2022 02:36:34 +0300
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
Subject: [PATCH RESEND v3 04/18] EDAC/synopsys: Detach private data from mci instance
Date:   Fri, 30 Sep 2022 02:35:16 +0300
Message-ID: <20220929233530.13016-5-Sergey.Semin@baikalelectronics.ru>
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

We are about to add a more comprehensive DW uMCTL2 DDRC parameters
detection procedure and some resources requests (clocks and resets). Since
these parameters will be utilized in the various parts of the driver and
in particular used for the Memory Controller data instance
pre-initialization, they need to be first retrieved before the MCI is
allocated and second preserved in the driver private data. Therefore the
best approach would be to add the parameters structure right into the
driver private data and make sure the data is allocated separately from
the mem_ctl_info instance. For that we suggest to add a new static method
snps_data_create(), which aside with the snps_edac_priv structure
allocation will also perform the private data basic initialization like
CSRs region mapping, device data getting, platform data pointer copying
and spin-lock initialization. In addition to that the snps_mc_init() will
be converted to snps_mc_create(), which from now will be used to allocate
and initialize the mem_ctl_info structure instance.

Note in order to have an access to the snps_edac_priv structure instance,
as before the mem_ctl_info.pvt_info pointer will be utilized.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/edac/synopsys_edac.c | 137 +++++++++++++++++++++++------------
 1 file changed, 90 insertions(+), 47 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 5adf6598465a..f2f83b24d62c 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -240,6 +240,7 @@ struct snps_ecc_status {
 
 /**
  * struct snps_edac_priv - DDR memory controller private data.
+ * @pdev:		Platform device.
  * @baseaddr:		Base address of the DDR controller.
  * @lock:		Concurrent CSRs access lock.
  * @message:		Buffer for framing the event specific info.
@@ -253,6 +254,7 @@ struct snps_ecc_status {
  * @rank_shift:		Bit shifts for rank bit.
  */
 struct snps_edac_priv {
+	struct platform_device *pdev;
 	void __iomem *baseaddr;
 	spinlock_t lock;
 	char message[SNPS_EDAC_MSG_SIZE];
@@ -460,6 +462,34 @@ static irqreturn_t snps_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+/**
+ * snps_create_data - Create private data.
+ * @pdev:	platform device.
+ *
+ * Return: Private data instance or negative errno.
+ */
+static struct snps_edac_priv *snps_create_data(struct platform_device *pdev)
+{
+	struct snps_edac_priv *priv;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return ERR_PTR(-ENOMEM);
+
+	priv->baseaddr = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->baseaddr))
+		return ERR_CAST(priv->baseaddr);
+
+	priv->p_data = of_device_get_match_data(&pdev->dev);
+	if (!priv->p_data)
+		return ERR_PTR(-ENODEV);
+
+	priv->pdev = pdev;
+	spin_lock_init(&priv->lock);
+
+	return priv;
+}
+
 /**
  * snps_get_dtype - Return the controller memory width.
  * @base:	DDR memory controller base address.
@@ -591,18 +621,36 @@ static void snps_init_csrows(struct mem_ctl_info *mci)
 }
 
 /**
- * snps_mc_init - Initialize one driver instance.
- * @mci:	EDAC memory controller instance.
- * @pdev:	platform device.
+ * snps_mc_create - Create and initialize MC instance.
+ * @priv:	DDR memory controller private data.
+ *
+ * Allocate the EDAC memory controller descriptor and initialize it
+ * using the private data info.
  *
- * Perform initialization of the EDAC memory controller instance and
- * related driver-private data associated with the memory controller the
- * instance is bound to.
+ * Return: MC data instance or negative errno.
  */
-static void snps_mc_init(struct mem_ctl_info *mci, struct platform_device *pdev)
+static struct mem_ctl_info *snps_mc_create(struct snps_edac_priv *priv)
 {
-	mci->pdev = &pdev->dev;
-	platform_set_drvdata(pdev, mci);
+	struct edac_mc_layer layers[2];
+	struct mem_ctl_info *mci;
+
+	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
+	layers[0].size = SNPS_EDAC_NR_CSROWS;
+	layers[0].is_virt_csrow = true;
+	layers[1].type = EDAC_MC_LAYER_CHANNEL;
+	layers[1].size = SNPS_EDAC_NR_CHANS;
+	layers[1].is_virt_csrow = false;
+
+	mci = edac_mc_alloc(EDAC_AUTO_MC_NUM, ARRAY_SIZE(layers), layers, 0);
+	if (!mci) {
+		edac_printk(KERN_ERR, EDAC_MC,
+			    "Failed memory allocation for mc instance\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	mci->pvt_info = priv;
+	mci->pdev = &priv->pdev->dev;
+	platform_set_drvdata(priv->pdev, mci);
 
 	/* Initialize controller capabilities and configuration */
 	mci->mtype_cap = MEM_FLAG_LPDDR | MEM_FLAG_DDR2 | MEM_FLAG_LPDDR2 |
@@ -622,24 +670,43 @@ static void snps_mc_init(struct mem_ctl_info *mci, struct platform_device *pdev)
 	mci->ctl_page_to_phys = NULL;
 
 	snps_init_csrows(mci);
+
+	return mci;
 }
 
+/**
+ * snps_mc_free - Free MC instance.
+ * @mci:	EDAC memory controller instance.
+ *
+ * Just revert what was done in the framework of the snps_mc_create().
+ *
+ * Return: MC data instance or negative errno.
+ */
+static void snps_mc_free(struct mem_ctl_info *mci)
+{
+	struct snps_edac_priv *priv = mci->pvt_info;
+
+	platform_set_drvdata(priv->pdev, NULL);
 
+	edac_mc_free(mci);
+}
 
-static int snps_setup_irq(struct mem_ctl_info *mci, struct platform_device *pdev)
+
+
+static int snps_setup_irq(struct mem_ctl_info *mci)
 {
 	struct snps_edac_priv *priv = mci->pvt_info;
 	int ret, irq;
 
-	irq = platform_get_irq(pdev, 0);
+	irq = platform_get_irq(priv->pdev, 0);
 	if (irq < 0) {
 		edac_printk(KERN_ERR, EDAC_MC,
 			    "No IRQ %d in DT\n", irq);
 		return irq;
 	}
 
-	ret = devm_request_irq(&pdev->dev, irq, snps_irq_handler,
-			       0, dev_name(&pdev->dev), mci);
+	ret = devm_request_irq(&priv->pdev->dev, irq, snps_irq_handler,
+			       0, dev_name(&priv->pdev->dev), mci);
 	if (ret < 0) {
 		edac_printk(KERN_ERR, EDAC_MC, "Failed to request IRQ\n");
 		return ret;
@@ -1063,49 +1130,24 @@ static inline void snps_create_debugfs_nodes(struct mem_ctl_info *mci) {}
  */
 static int snps_mc_probe(struct platform_device *pdev)
 {
-	const struct snps_platform_data *p_data;
-	struct edac_mc_layer layers[2];
 	struct snps_edac_priv *priv;
 	struct mem_ctl_info *mci;
-	void __iomem *baseaddr;
 	int rc;
 
-	baseaddr = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(baseaddr))
-		return PTR_ERR(baseaddr);
-
-	p_data = of_device_get_match_data(&pdev->dev);
-	if (!p_data)
-		return -ENODEV;
+	priv = snps_create_data(pdev);
+	if (IS_ERR(priv))
+		return PTR_ERR(priv);
 
 	if (!snps_get_ecc_state(baseaddr)) {
 		edac_printk(KERN_INFO, EDAC_MC, "ECC not enabled\n");
 		return -ENXIO;
 	}
 
-	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
-	layers[0].size = SNPS_EDAC_NR_CSROWS;
-	layers[0].is_virt_csrow = true;
-	layers[1].type = EDAC_MC_LAYER_CHANNEL;
-	layers[1].size = SNPS_EDAC_NR_CHANS;
-	layers[1].is_virt_csrow = false;
-
-	mci = edac_mc_alloc(EDAC_AUTO_MC_NUM, ARRAY_SIZE(layers), layers,
-			    sizeof(struct snps_edac_priv));
-	if (!mci) {
-		edac_printk(KERN_ERR, EDAC_MC,
-			    "Failed memory allocation for mc instance\n");
-		return -ENOMEM;
-	}
-
-	priv = mci->pvt_info;
-	priv->baseaddr = baseaddr;
-	priv->p_data = p_data;
-	spin_lock_init(&priv->lock);
+	mci = snps_mc_create(priv);
+	if (IS_ERR(mci))
+		return PTR_ERR(mci);
 
-	snps_mc_init(mci, pdev);
-
-	rc = snps_setup_irq(mci, pdev);
+	rc = snps_setup_irq(mci);
 	if (rc)
 		goto free_edac_mc;
 
@@ -1121,7 +1163,7 @@ static int snps_mc_probe(struct platform_device *pdev)
 	return 0;
 
 free_edac_mc:
-	edac_mc_free(mci);
+	snps_mc_free(mci);
 
 	return rc;
 }
@@ -1140,7 +1182,8 @@ static int snps_mc_remove(struct platform_device *pdev)
 	snps_disable_irq(priv);
 
 	edac_mc_del_mc(&pdev->dev);
-	edac_mc_free(mci);
+
+	snps_mc_free(mci);
 
 	return 0;
 }
-- 
2.37.3


