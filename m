Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6EB339627C
	for <lists+linux-edac@lfdr.de>; Mon, 31 May 2021 16:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbhEaO5V (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 31 May 2021 10:57:21 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3482 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234310AbhEaOy4 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 31 May 2021 10:54:56 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Ftyrk0D9fzYq72;
        Mon, 31 May 2021 22:50:30 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 22:53:13 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 22:53:12 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Johannes Thumshirn <morbidrsa@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Jan Luebbe <jlu@pengutronix.de>,
        Andre Przywara <andre.przywara@arm.com>,
        Channagoud Kadabi <ckadabi@codeaurora.org>,
        "Venkata Narendra Kumar Gutta" <vnkgutta@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Khuong Dinh" <khuong@os.amperecomputing.com>,
        York Sun <york.sun@nxp.com>,
        linux-edac <linux-edac@vger.kernel.org>,
        linux-mips <linux-mips@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 3/3] edac: Use 'ret' instead of 'res' to store the return value
Date:   Mon, 31 May 2021 22:53:02 +0800
Message-ID: <20210531145302.9655-4-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210531145302.9655-1-thunder.leizhen@huawei.com>
References: <20210531145302.9655-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Usually 'ret' or 'rc' is used as the abbreviation for 'return code', and
'res' is used as the abbreviation for 'resource'.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/edac/altera_edac.c      | 66 ++++++++++++++++-----------------
 drivers/edac/armada_xp_edac.c   |  6 +--
 drivers/edac/cpc925_edac.c      | 16 ++++----
 drivers/edac/fsl_ddr_edac.c     | 24 ++++++------
 drivers/edac/highbank_l2_edac.c | 20 +++++-----
 drivers/edac/highbank_mc_edac.c | 20 +++++-----
 drivers/edac/layerscape_edac.c  |  8 ++--
 drivers/edac/mpc85xx_edac.c     | 48 ++++++++++++------------
 drivers/edac/skx_base.c         |  6 +--
 drivers/edac/thunderx_edac.c    | 26 ++++++-------
 10 files changed, 120 insertions(+), 120 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 50eef016a4b5a27..9e97396821f749d 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -286,7 +286,7 @@ static int altr_sdram_probe(struct platform_device *pdev)
 	struct regmap *mc_vbase;
 	struct dimm_info *dimm;
 	u32 read_reg;
-	int irq, irq2, res = 0;
+	int irq, irq2, ret = 0;
 	unsigned long mem_size, irqflags = 0;
 
 	id = of_match_device(altr_sdram_ctrl_of_match, &pdev->dev);
@@ -375,7 +375,7 @@ static int altr_sdram_probe(struct platform_device *pdev)
 	if (!devres_open_group(&pdev->dev, NULL, GFP_KERNEL)) {
 		edac_printk(KERN_ERR, EDAC_MC,
 			    "Unable to get managed device resource\n");
-		res = -ENOMEM;
+		ret = -ENOMEM;
 		goto free;
 	}
 
@@ -394,40 +394,40 @@ static int altr_sdram_probe(struct platform_device *pdev)
 	dimm->mtype = MEM_DDR3;
 	dimm->edac_mode = EDAC_SECDED;
 
-	res = edac_mc_add_mc(mci);
-	if (res < 0)
+	ret = edac_mc_add_mc(mci);
+	if (ret < 0)
 		goto err;
 
 	/* Only the Arria10 has separate IRQs */
 	if (of_machine_is_compatible("altr,socfpga-arria10")) {
 		/* Arria10 specific initialization */
-		res = a10_init(mc_vbase);
-		if (res < 0)
+		ret = a10_init(mc_vbase);
+		if (ret < 0)
 			goto err2;
 
-		res = devm_request_irq(&pdev->dev, irq2,
+		ret = devm_request_irq(&pdev->dev, irq2,
 				       altr_sdram_mc_err_handler,
 				       IRQF_SHARED, dev_name(&pdev->dev), mci);
-		if (res < 0) {
+		if (ret < 0) {
 			edac_mc_printk(mci, KERN_ERR,
 				       "Unable to request irq %d\n", irq2);
-			res = -ENODEV;
+			ret = -ENODEV;
 			goto err2;
 		}
 
-		res = a10_unmask_irq(pdev, A10_DDR0_IRQ_MASK);
-		if (res < 0)
+		ret = a10_unmask_irq(pdev, A10_DDR0_IRQ_MASK);
+		if (ret < 0)
 			goto err2;
 
 		irqflags = IRQF_SHARED;
 	}
 
-	res = devm_request_irq(&pdev->dev, irq, altr_sdram_mc_err_handler,
+	ret = devm_request_irq(&pdev->dev, irq, altr_sdram_mc_err_handler,
 			       irqflags, dev_name(&pdev->dev), mci);
-	if (res < 0) {
+	if (ret < 0) {
 		edac_mc_printk(mci, KERN_ERR,
 			       "Unable to request irq %d\n", irq);
-		res = -ENODEV;
+		ret = -ENODEV;
 		goto err2;
 	}
 
@@ -436,7 +436,7 @@ static int altr_sdram_probe(struct platform_device *pdev)
 			       priv->ecc_irq_en_mask, priv->ecc_irq_en_mask)) {
 		edac_mc_printk(mci, KERN_ERR,
 			       "Error enabling SDRAM ECC IRQ\n");
-		res = -ENODEV;
+		ret = -ENODEV;
 		goto err2;
 	}
 
@@ -453,9 +453,9 @@ static int altr_sdram_probe(struct platform_device *pdev)
 free:
 	edac_mc_free(mci);
 	edac_printk(KERN_ERR, EDAC_MC,
-		    "EDAC Probe Failed; Error %d\n", res);
+		    "EDAC Probe Failed; Error %d\n", ret);
 
-	return res;
+	return ret;
 }
 
 static int altr_sdram_remove(struct platform_device *pdev)
@@ -707,7 +707,7 @@ static int altr_edac_device_probe(struct platform_device *pdev)
 	struct edac_device_ctl_info *dci;
 	struct altr_edac_device_dev *drvdata;
 	struct resource *r;
-	int res = 0;
+	int ret = 0;
 	struct device_node *np = pdev->dev.of_node;
 	char *ecc_name = (char *)np->name;
 	static int dev_instance;
@@ -722,7 +722,7 @@ static int altr_edac_device_probe(struct platform_device *pdev)
 	if (!r) {
 		edac_printk(KERN_ERR, EDAC_DEVICE,
 			    "Unable to get mem resource\n");
-		res = -ENODEV;
+		ret = -ENODEV;
 		goto fail;
 	}
 
@@ -730,7 +730,7 @@ static int altr_edac_device_probe(struct platform_device *pdev)
 				     dev_name(&pdev->dev))) {
 		edac_printk(KERN_ERR, EDAC_DEVICE,
 			    "%s:Error requesting mem region\n", ecc_name);
-		res = -EBUSY;
+		ret = -EBUSY;
 		goto fail;
 	}
 
@@ -741,7 +741,7 @@ static int altr_edac_device_probe(struct platform_device *pdev)
 	if (!dci) {
 		edac_printk(KERN_ERR, EDAC_DEVICE,
 			    "%s: Unable to allocate EDAC device\n", ecc_name);
-		res = -ENOMEM;
+		ret = -ENOMEM;
 		goto fail;
 	}
 
@@ -752,7 +752,7 @@ static int altr_edac_device_probe(struct platform_device *pdev)
 
 	drvdata->base = devm_ioremap(&pdev->dev, r->start, resource_size(r));
 	if (!drvdata->base) {
-		res = -ENOMEM;
+		ret = -ENOMEM;
 		goto fail1;
 	}
 
@@ -761,31 +761,31 @@ static int altr_edac_device_probe(struct platform_device *pdev)
 
 	/* Check specific dependencies for the module */
 	if (drvdata->data->setup) {
-		res = drvdata->data->setup(drvdata);
-		if (res)
+		ret = drvdata->data->setup(drvdata);
+		if (ret)
 			goto fail1;
 	}
 
 	drvdata->sb_irq = platform_get_irq(pdev, 0);
-	res = devm_request_irq(&pdev->dev, drvdata->sb_irq,
+	ret = devm_request_irq(&pdev->dev, drvdata->sb_irq,
 			       altr_edac_device_handler,
 			       0, dev_name(&pdev->dev), dci);
-	if (res)
+	if (ret)
 		goto fail1;
 
 	drvdata->db_irq = platform_get_irq(pdev, 1);
-	res = devm_request_irq(&pdev->dev, drvdata->db_irq,
+	ret = devm_request_irq(&pdev->dev, drvdata->db_irq,
 			       altr_edac_device_handler,
 			       0, dev_name(&pdev->dev), dci);
-	if (res)
+	if (ret)
 		goto fail1;
 
 	dci->mod_name = "Altera ECC Manager";
 	dci->dev_name = drvdata->edac_dev_name;
 
-	res = edac_device_add_device(dci);
-	if (res) {
-		res = -ENXIO;
+	ret = edac_device_add_device(dci);
+	if (ret) {
+		ret = -ENXIO;
 		goto fail1;
 	}
 
@@ -800,9 +800,9 @@ static int altr_edac_device_probe(struct platform_device *pdev)
 fail:
 	devres_release_group(&pdev->dev, NULL);
 	edac_printk(KERN_ERR, EDAC_DEVICE,
-		    "%s:Error setting up EDAC device: %d\n", ecc_name, res);
+		    "%s:Error setting up EDAC device: %d\n", ecc_name, ret);
 
-	return res;
+	return ret;
 }
 
 static int altr_edac_device_remove(struct platform_device *pdev)
diff --git a/drivers/edac/armada_xp_edac.c b/drivers/edac/armada_xp_edac.c
index 23b9a469f100183..73d0410fe731e69 100644
--- a/drivers/edac/armada_xp_edac.c
+++ b/drivers/edac/armada_xp_edac.c
@@ -611,13 +611,13 @@ static struct platform_driver * const drivers[] = {
 
 static int __init armada_xp_edac_init(void)
 {
-	int res;
+	int ret;
 
 	/* only polling is supported */
 	edac_op_state = EDAC_OPSTATE_POLL;
 
-	res = platform_register_drivers(drivers, ARRAY_SIZE(drivers));
-	if (res)
+	ret = platform_register_drivers(drivers, ARRAY_SIZE(drivers));
+	if (ret)
 		pr_warn("Armada XP EDAC drivers fail to register\n");
 
 	return 0;
diff --git a/drivers/edac/cpc925_edac.c b/drivers/edac/cpc925_edac.c
index 9797e6d60dde4d1..2d8a42341eafc8b 100644
--- a/drivers/edac/cpc925_edac.c
+++ b/drivers/edac/cpc925_edac.c
@@ -911,19 +911,19 @@ static int cpc925_probe(struct platform_device *pdev)
 	void __iomem *vbase;
 	struct cpc925_mc_pdata *pdata;
 	struct resource *r;
-	int res = 0, nr_channels;
+	int ret = 0, nr_channels;
 
 	edac_dbg(0, "%s platform device found!\n", pdev->name);
 
 	if (!devres_open_group(&pdev->dev, cpc925_probe, GFP_KERNEL)) {
-		res = -ENOMEM;
+		ret = -ENOMEM;
 		goto out;
 	}
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!r) {
 		cpc925_printk(KERN_ERR, "Unable to get resource\n");
-		res = -ENOENT;
+		ret = -ENOENT;
 		goto err1;
 	}
 
@@ -932,14 +932,14 @@ static int cpc925_probe(struct platform_device *pdev)
 				     resource_size(r),
 				     pdev->name)) {
 		cpc925_printk(KERN_ERR, "Unable to request mem region\n");
-		res = -EBUSY;
+		ret = -EBUSY;
 		goto err1;
 	}
 
 	vbase = devm_ioremap(&pdev->dev, r->start, resource_size(r));
 	if (!vbase) {
 		cpc925_printk(KERN_ERR, "Unable to ioremap device\n");
-		res = -ENOMEM;
+		ret = -ENOMEM;
 		goto err2;
 	}
 
@@ -955,7 +955,7 @@ static int cpc925_probe(struct platform_device *pdev)
 			    sizeof(struct cpc925_mc_pdata));
 	if (!mci) {
 		cpc925_printk(KERN_ERR, "No memory for mem_ctl_info\n");
-		res = -ENOMEM;
+		ret = -ENOMEM;
 		goto err2;
 	}
 
@@ -996,7 +996,7 @@ static int cpc925_probe(struct platform_device *pdev)
 	/* get this far and it's successful */
 	edac_dbg(0, "success\n");
 
-	res = 0;
+	ret = 0;
 	goto out;
 
 err3:
@@ -1007,7 +1007,7 @@ static int cpc925_probe(struct platform_device *pdev)
 err1:
 	devres_release_group(&pdev->dev, cpc925_probe);
 out:
-	return res;
+	return ret;
 }
 
 static int cpc925_remove(struct platform_device *pdev)
diff --git a/drivers/edac/fsl_ddr_edac.c b/drivers/edac/fsl_ddr_edac.c
index 6d8ea226010d2d7..1d526c5aaaeeae1 100644
--- a/drivers/edac/fsl_ddr_edac.c
+++ b/drivers/edac/fsl_ddr_edac.c
@@ -480,7 +480,7 @@ int fsl_mc_err_probe(struct platform_device *op)
 	struct fsl_mc_pdata *pdata;
 	struct resource r;
 	u32 sdram_ctl;
-	int res;
+	int ret;
 
 	if (!devres_open_group(&op->dev, fsl_mc_err_probe, GFP_KERNEL))
 		return -ENOMEM;
@@ -512,8 +512,8 @@ int fsl_mc_err_probe(struct platform_device *op)
 	 */
 	little_endian = of_property_read_bool(op->dev.of_node, "little-endian");
 
-	res = of_address_to_resource(op->dev.of_node, 0, &r);
-	if (res) {
+	ret = of_address_to_resource(op->dev.of_node, 0, &r);
+	if (ret) {
 		pr_err("%s: Unable to get resource for MC err regs\n",
 		       __func__);
 		goto err;
@@ -523,14 +523,14 @@ int fsl_mc_err_probe(struct platform_device *op)
 				     pdata->name)) {
 		pr_err("%s: Error while requesting mem region\n",
 		       __func__);
-		res = -EBUSY;
+		ret = -EBUSY;
 		goto err;
 	}
 
 	pdata->mc_vbase = devm_ioremap(&op->dev, r.start, resource_size(&r));
 	if (!pdata->mc_vbase) {
 		pr_err("%s: Unable to setup MC err regs\n", __func__);
-		res = -ENOMEM;
+		ret = -ENOMEM;
 		goto err;
 	}
 
@@ -538,7 +538,7 @@ int fsl_mc_err_probe(struct platform_device *op)
 	if (!(sdram_ctl & DSC_ECC_EN)) {
 		/* no ECC */
 		pr_warn("%s: No ECC DIMMs discovered\n", __func__);
-		res = -ENODEV;
+		ret = -ENODEV;
 		goto err;
 	}
 
@@ -567,8 +567,8 @@ int fsl_mc_err_probe(struct platform_device *op)
 	/* clear all error bits */
 	ddr_out32(pdata->mc_vbase + FSL_MC_ERR_DETECT, ~0);
 
-	res = edac_mc_add_mc_with_groups(mci, fsl_ddr_dev_groups);
-	if (res) {
+	ret = edac_mc_add_mc_with_groups(mci, fsl_ddr_dev_groups);
+	if (ret) {
 		edac_dbg(3, "failed edac_mc_add_mc()\n");
 		goto err;
 	}
@@ -586,14 +586,14 @@ int fsl_mc_err_probe(struct platform_device *op)
 
 		/* register interrupts */
 		pdata->irq = platform_get_irq(op, 0);
-		res = devm_request_irq(&op->dev, pdata->irq,
+		ret = devm_request_irq(&op->dev, pdata->irq,
 				       fsl_mc_isr,
 				       IRQF_SHARED,
 				       "[EDAC] MC err", mci);
-		if (res < 0) {
+		if (ret < 0) {
 			pr_err("%s: Unable to request irq %d for FSL DDR DRAM ERR\n",
 			       __func__, pdata->irq);
-			res = -ENODEV;
+			ret = -ENODEV;
 			goto err2;
 		}
 
@@ -612,7 +612,7 @@ int fsl_mc_err_probe(struct platform_device *op)
 err:
 	devres_release_group(&op->dev, fsl_mc_err_probe);
 	edac_mc_free(mci);
-	return res;
+	return ret;
 }
 
 int fsl_mc_err_remove(struct platform_device *op)
diff --git a/drivers/edac/highbank_l2_edac.c b/drivers/edac/highbank_l2_edac.c
index 45dbe19c2577426..5d037ebff233cfe 100644
--- a/drivers/edac/highbank_l2_edac.c
+++ b/drivers/edac/highbank_l2_edac.c
@@ -50,7 +50,7 @@ static int highbank_l2_err_probe(struct platform_device *pdev)
 	struct edac_device_ctl_info *dci;
 	struct hb_l2_drvdata *drvdata;
 	struct resource *r;
-	int res = 0;
+	int ret = 0;
 
 	dci = edac_device_alloc_ctl_info(sizeof(*drvdata), "cpu",
 		1, "L", 1, 2, NULL, 0, 0);
@@ -67,21 +67,21 @@ static int highbank_l2_err_probe(struct platform_device *pdev)
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!r) {
 		dev_err(&pdev->dev, "Unable to get mem resource\n");
-		res = -ENODEV;
+		ret = -ENODEV;
 		goto err;
 	}
 
 	if (!devm_request_mem_region(&pdev->dev, r->start,
 				     resource_size(r), dev_name(&pdev->dev))) {
 		dev_err(&pdev->dev, "Error while requesting mem region\n");
-		res = -EBUSY;
+		ret = -EBUSY;
 		goto err;
 	}
 
 	drvdata->base = devm_ioremap(&pdev->dev, r->start, resource_size(r));
 	if (!drvdata->base) {
 		dev_err(&pdev->dev, "Unable to map regs\n");
-		res = -ENOMEM;
+		ret = -ENOMEM;
 		goto err;
 	}
 
@@ -91,22 +91,22 @@ static int highbank_l2_err_probe(struct platform_device *pdev)
 	dci->dev_name = dev_name(&pdev->dev);
 
 	if (edac_device_add_device(dci)) {
-		res = -ENXIO;
+		ret = -ENXIO;
 		goto err;
 	}
 
 	drvdata->db_irq = platform_get_irq(pdev, 0);
-	res = devm_request_irq(&pdev->dev, drvdata->db_irq,
+	ret = devm_request_irq(&pdev->dev, drvdata->db_irq,
 			       highbank_l2_err_handler,
 			       0, dev_name(&pdev->dev), dci);
-	if (res < 0)
+	if (ret < 0)
 		goto err2;
 
 	drvdata->sb_irq = platform_get_irq(pdev, 1);
-	res = devm_request_irq(&pdev->dev, drvdata->sb_irq,
+	ret = devm_request_irq(&pdev->dev, drvdata->sb_irq,
 			       highbank_l2_err_handler,
 			       0, dev_name(&pdev->dev), dci);
-	if (res < 0)
+	if (ret < 0)
 		goto err2;
 
 	devres_close_group(&pdev->dev, NULL);
@@ -116,7 +116,7 @@ static int highbank_l2_err_probe(struct platform_device *pdev)
 err:
 	devres_release_group(&pdev->dev, NULL);
 	edac_device_free_ctl_info(dci);
-	return res;
+	return ret;
 }
 
 static int highbank_l2_err_remove(struct platform_device *pdev)
diff --git a/drivers/edac/highbank_mc_edac.c b/drivers/edac/highbank_mc_edac.c
index 61b76ec226af11d..4de2e06fd8c3254 100644
--- a/drivers/edac/highbank_mc_edac.c
+++ b/drivers/edac/highbank_mc_edac.c
@@ -153,7 +153,7 @@ static int highbank_mc_probe(struct platform_device *pdev)
 	void __iomem *base;
 	u32 control;
 	int irq;
-	int res = 0;
+	int ret = 0;
 
 	id = of_match_device(hb_ddr_ctrl_of_match, &pdev->dev);
 	if (!id)
@@ -180,21 +180,21 @@ static int highbank_mc_probe(struct platform_device *pdev)
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!r) {
 		dev_err(&pdev->dev, "Unable to get mem resource\n");
-		res = -ENODEV;
+		ret = -ENODEV;
 		goto err;
 	}
 
 	if (!devm_request_mem_region(&pdev->dev, r->start,
 				     resource_size(r), dev_name(&pdev->dev))) {
 		dev_err(&pdev->dev, "Error while requesting mem region\n");
-		res = -EBUSY;
+		ret = -EBUSY;
 		goto err;
 	}
 
 	base = devm_ioremap(&pdev->dev, r->start, resource_size(r));
 	if (!base) {
 		dev_err(&pdev->dev, "Unable to map regs\n");
-		res = -ENOMEM;
+		ret = -ENOMEM;
 		goto err;
 	}
 
@@ -205,7 +205,7 @@ static int highbank_mc_probe(struct platform_device *pdev)
 	control = readl(drvdata->mc_err_base + HB_DDR_ECC_OPT) & 0x3;
 	if (!control || (control == 0x2)) {
 		dev_err(&pdev->dev, "No ECC present, or ECC disabled\n");
-		res = -ENODEV;
+		ret = -ENODEV;
 		goto err;
 	}
 
@@ -225,14 +225,14 @@ static int highbank_mc_probe(struct platform_device *pdev)
 	dimm->mtype = MEM_DDR3;
 	dimm->edac_mode = EDAC_SECDED;
 
-	res = edac_mc_add_mc_with_groups(mci, highbank_dev_groups);
-	if (res < 0)
+	ret = edac_mc_add_mc_with_groups(mci, highbank_dev_groups);
+	if (ret < 0)
 		goto err;
 
 	irq = platform_get_irq(pdev, 0);
-	res = devm_request_irq(&pdev->dev, irq, highbank_mc_err_handler,
+	ret = devm_request_irq(&pdev->dev, irq, highbank_mc_err_handler,
 			       0, dev_name(&pdev->dev), mci);
-	if (res < 0) {
+	if (ret < 0) {
 		dev_err(&pdev->dev, "Unable to request irq %d\n", irq);
 		goto err2;
 	}
@@ -244,7 +244,7 @@ static int highbank_mc_probe(struct platform_device *pdev)
 err:
 	devres_release_group(&pdev->dev, NULL);
 	edac_mc_free(mci);
-	return res;
+	return ret;
 }
 
 static int highbank_mc_remove(struct platform_device *pdev)
diff --git a/drivers/edac/layerscape_edac.c b/drivers/edac/layerscape_edac.c
index 94cac7686a56d46..959ffd072bfb3cb 100644
--- a/drivers/edac/layerscape_edac.c
+++ b/drivers/edac/layerscape_edac.c
@@ -36,7 +36,7 @@ static struct platform_driver fsl_ddr_mc_err_driver = {
 
 static int __init fsl_ddr_mc_init(void)
 {
-	int res;
+	int ret;
 
 	/* make sure error reporting method is sane */
 	switch (edac_op_state) {
@@ -48,10 +48,10 @@ static int __init fsl_ddr_mc_init(void)
 		break;
 	}
 
-	res = platform_driver_register(&fsl_ddr_mc_err_driver);
-	if (res) {
+	ret = platform_driver_register(&fsl_ddr_mc_err_driver);
+	if (ret) {
 		pr_err("MC fails to register\n");
-		return res;
+		return ret;
 	}
 
 	return 0;
diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index 6f0c95b83b076e0..fbd3d79f99d14d4 100644
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -148,7 +148,7 @@ static int mpc85xx_pci_err_probe(struct platform_device *op)
 	struct mpc85xx_edac_pci_plat_data *plat_data;
 	struct device_node *of_node;
 	struct resource r;
-	int res = 0;
+	int ret = 0;
 
 	if (!devres_open_group(&op->dev, mpc85xx_pci_err_probe, GFP_KERNEL))
 		return -ENOMEM;
@@ -173,7 +173,7 @@ static int mpc85xx_pci_err_probe(struct platform_device *op)
 	plat_data = op->dev.platform_data;
 	if (!plat_data) {
 		dev_err(&op->dev, "no platform data");
-		res = -ENXIO;
+		ret = -ENXIO;
 		goto err;
 	}
 	of_node = plat_data->of_node;
@@ -196,8 +196,8 @@ static int mpc85xx_pci_err_probe(struct platform_device *op)
 
 	pdata->edac_idx = edac_pci_idx++;
 
-	res = of_address_to_resource(of_node, 0, &r);
-	if (res) {
+	ret = of_address_to_resource(of_node, 0, &r);
+	if (ret) {
 		pr_err("%s: Unable to get resource for PCI err regs\n", __func__);
 		goto err;
 	}
@@ -208,14 +208,14 @@ static int mpc85xx_pci_err_probe(struct platform_device *op)
 	if (!devm_request_mem_region(&op->dev, r.start, resource_size(&r),
 					pdata->name)) {
 		pr_err("%s: Error while requesting mem region\n", __func__);
-		res = -EBUSY;
+		ret = -EBUSY;
 		goto err;
 	}
 
 	pdata->pci_vbase = devm_ioremap(&op->dev, r.start, resource_size(&r));
 	if (!pdata->pci_vbase) {
 		pr_err("%s: Unable to setup PCI err regs\n", __func__);
-		res = -ENOMEM;
+		ret = -ENOMEM;
 		goto err;
 	}
 
@@ -248,21 +248,21 @@ static int mpc85xx_pci_err_probe(struct platform_device *op)
 
 	if (edac_pci_add_device(pci, pdata->edac_idx) > 0) {
 		edac_dbg(3, "failed edac_pci_add_device()\n");
-		res = -ENODEV;
+		ret = -ENODEV;
 		goto err;
 	}
 
 	if (edac_op_state == EDAC_OPSTATE_INT) {
 		pdata->irq = irq_of_parse_and_map(of_node, 0);
-		res = devm_request_irq(&op->dev, pdata->irq,
+		ret = devm_request_irq(&op->dev, pdata->irq,
 				       mpc85xx_pci_isr,
 				       IRQF_SHARED,
 				       "[EDAC] PCI err", pci);
-		if (res < 0) {
+		if (ret < 0) {
 			pr_err("%s: Unable to request irq %d for MPC85xx PCI err\n",
 				__func__, pdata->irq);
 			irq_dispose_mapping(pdata->irq);
-			res = -ENODEV;
+			ret = -ENODEV;
 			goto err2;
 		}
 
@@ -297,7 +297,7 @@ static int mpc85xx_pci_err_probe(struct platform_device *op)
 err:
 	edac_pci_free_ctl_info(pci);
 	devres_release_group(&op->dev, mpc85xx_pci_err_probe);
-	return res;
+	return ret;
 }
 
 static int mpc85xx_pci_err_remove(struct platform_device *op)
@@ -492,7 +492,7 @@ static int mpc85xx_l2_err_probe(struct platform_device *op)
 	struct edac_device_ctl_info *edac_dev;
 	struct mpc85xx_l2_pdata *pdata;
 	struct resource r;
-	int res;
+	int ret;
 
 	if (!devres_open_group(&op->dev, mpc85xx_l2_err_probe, GFP_KERNEL))
 		return -ENOMEM;
@@ -512,8 +512,8 @@ static int mpc85xx_l2_err_probe(struct platform_device *op)
 	edac_dev->ctl_name = pdata->name;
 	edac_dev->dev_name = pdata->name;
 
-	res = of_address_to_resource(op->dev.of_node, 0, &r);
-	if (res) {
+	ret = of_address_to_resource(op->dev.of_node, 0, &r);
+	if (ret) {
 		pr_err("%s: Unable to get resource for L2 err regs\n", __func__);
 		goto err;
 	}
@@ -524,14 +524,14 @@ static int mpc85xx_l2_err_probe(struct platform_device *op)
 	if (!devm_request_mem_region(&op->dev, r.start, resource_size(&r),
 				     pdata->name)) {
 		pr_err("%s: Error while requesting mem region\n", __func__);
-		res = -EBUSY;
+		ret = -EBUSY;
 		goto err;
 	}
 
 	pdata->l2_vbase = devm_ioremap(&op->dev, r.start, resource_size(&r));
 	if (!pdata->l2_vbase) {
 		pr_err("%s: Unable to setup L2 err regs\n", __func__);
-		res = -ENOMEM;
+		ret = -ENOMEM;
 		goto err;
 	}
 
@@ -553,20 +553,20 @@ static int mpc85xx_l2_err_probe(struct platform_device *op)
 
 	if (edac_device_add_device(edac_dev) > 0) {
 		edac_dbg(3, "failed edac_device_add_device()\n");
-		res = -ENXIO;
+		ret = -ENXIO;
 		goto err;
 	}
 
 	if (edac_op_state == EDAC_OPSTATE_INT) {
 		pdata->irq = irq_of_parse_and_map(op->dev.of_node, 0);
-		res = devm_request_irq(&op->dev, pdata->irq,
+		ret = devm_request_irq(&op->dev, pdata->irq,
 				       mpc85xx_l2_isr, IRQF_SHARED,
 				       "[EDAC] L2 err", edac_dev);
-		if (res < 0) {
+		if (ret < 0) {
 			pr_err("%s: Unable to request irq %d for MPC85xx L2 err\n",
 				__func__, pdata->irq);
 			irq_dispose_mapping(pdata->irq);
-			res = -ENODEV;
+			ret = -ENODEV;
 			goto err2;
 		}
 
@@ -589,7 +589,7 @@ static int mpc85xx_l2_err_probe(struct platform_device *op)
 err:
 	devres_release_group(&op->dev, mpc85xx_l2_err_probe);
 	edac_device_free_ctl_info(edac_dev);
-	return res;
+	return ret;
 }
 
 static int mpc85xx_l2_err_remove(struct platform_device *op)
@@ -691,7 +691,7 @@ static struct platform_driver * const drivers[] = {
 
 static int __init mpc85xx_mc_init(void)
 {
-	int res = 0;
+	int ret;
 	u32 __maybe_unused pvr = 0;
 
 	pr_info("Freescale(R) MPC85xx EDAC driver, (C) 2006 Montavista Software\n");
@@ -706,8 +706,8 @@ static int __init mpc85xx_mc_init(void)
 		break;
 	}
 
-	res = platform_register_drivers(drivers, ARRAY_SIZE(drivers));
-	if (res)
+	ret = platform_register_drivers(drivers, ARRAY_SIZE(drivers));
+	if (ret)
 		pr_warn(EDAC_MOD_STR "drivers fail to register\n");
 
 	return 0;
diff --git a/drivers/edac/skx_base.c b/drivers/edac/skx_base.c
index 6a4f0b27c654572..7ad52659ab1e15c 100644
--- a/drivers/edac/skx_base.c
+++ b/drivers/edac/skx_base.c
@@ -530,11 +530,11 @@ static u8 skx_open_fine_column[] = {
 
 static int skx_bits(u64 addr, int nbits, u8 *bits)
 {
-	int i, res = 0;
+	int i, ret = 0;
 
 	for (i = 0; i < nbits; i++)
-		res |= ((addr >> bits[i]) & 1) << i;
-	return res;
+		ret |= ((addr >> bits[i]) & 1) << i;
+	return ret;
 }
 
 static int skx_bank_bits(u64 addr, int b0, int b1, int do_xor, int x0, int x1)
diff --git a/drivers/edac/thunderx_edac.c b/drivers/edac/thunderx_edac.c
index 3a19560232c11ec..96711e70fad49f3 100644
--- a/drivers/edac/thunderx_edac.c
+++ b/drivers/edac/thunderx_edac.c
@@ -243,11 +243,11 @@ static ssize_t thunderx_##_type##_##_field##_write(struct file *file,	    \
 					     size_t count, loff_t *ppos)    \
 {									    \
 	struct thunderx_##_type *pdata = file->private_data;		    \
-	int res;							    \
+	int ret;							    \
 									    \
-	res = kstrtoull_from_user(data, count, 0, &pdata->_field);	    \
+	ret = kstrtoull_from_user(data, count, 0, &pdata->_field);	    \
 									    \
-	return res ? res : count;					    \
+	return ret ? ret : count;					    \
 }									    \
 									    \
 DEBUGFS_STRUCT(_field, 0600,						    \
@@ -273,16 +273,16 @@ static ssize_t thunderx_##_type##_##_name##_write(struct file *file,	    \
 {									    \
 	struct thunderx_##_type *pdata = file->private_data;		    \
 	u64 val;							    \
-	int res;							    \
+	int ret;							    \
 									    \
-	res = kstrtoull_from_user(data, count, 0, &val);		    \
+	ret = kstrtoull_from_user(data, count, 0, &val);		    \
 									    \
-	if (!res) {							    \
+	if (!ret) {							    \
 		writeq(val, pdata->regs + _reg);			    \
-		res = count;						    \
+		ret = count;						    \
 	}								    \
 									    \
-	return res;							    \
+	return ret;							    \
 }									    \
 									    \
 DEBUGFS_STRUCT(_name, 0600,						    \
@@ -306,17 +306,17 @@ static ssize_t thunderx_lmc_inject_int_write(struct file *file,
 {
 	struct thunderx_lmc *lmc = file->private_data;
 	u64 val;
-	int res;
+	int ret;
 
-	res = kstrtoull_from_user(data, count, 0, &val);
+	ret = kstrtoull_from_user(data, count, 0, &val);
 
-	if (!res) {
+	if (!ret) {
 		/* Trigger the interrupt */
 		writeq(val, lmc->regs + LMC_INT_W1S);
-		res = count;
+		ret = count;
 	}
 
-	return res;
+	return ret;
 }
 
 static ssize_t thunderx_lmc_int_read(struct file *file,
-- 
2.26.0.106.g9fadedd


