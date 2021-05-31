Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33EF3396279
	for <lists+linux-edac@lfdr.de>; Mon, 31 May 2021 16:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbhEaO5R (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 31 May 2021 10:57:17 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2804 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbhEaOyy (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 31 May 2021 10:54:54 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FtypR4MMxzWpMh;
        Mon, 31 May 2021 22:48:31 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 22:53:12 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 22:53:11 +0800
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
Subject: [PATCH v2 2/3] edac: Fix error return code when edac_device_add_device() fails
Date:   Mon, 31 May 2021 22:53:01 +0800
Message-ID: <20210531145302.9655-3-thunder.leizhen@huawei.com>
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

When edac_device_add_device() fails, fix to return -ENXIO from the error
handling case instead of 0, -ENOMEM or -EINVAL.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/edac/altera_edac.c      | 8 +++++---
 drivers/edac/amd8111_edac.c     | 1 +
 drivers/edac/armada_xp_edac.c   | 2 +-
 drivers/edac/highbank_l2_edac.c | 4 +++-
 drivers/edac/mpc85xx_edac.c     | 1 +
 drivers/edac/qcom_edac.c        | 4 +++-
 drivers/edac/thunderx_edac.c    | 2 ++
 drivers/edac/xgene_edac.c       | 6 +++---
 8 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 5f7fd79ec82fc98..50eef016a4b5a27 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -784,8 +784,10 @@ static int altr_edac_device_probe(struct platform_device *pdev)
 	dci->dev_name = drvdata->edac_dev_name;
 
 	res = edac_device_add_device(dci);
-	if (res)
+	if (res) {
+		res = -ENXIO;
 		goto fail1;
+	}
 
 	altr_create_edacdev_dbgfs(dci, drvdata->data);
 
@@ -1555,7 +1557,7 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 	if (rc) {
 		edac_printk(KERN_ERR, EDAC_DEVICE,
 			    "edac_device_add_device portB failed\n");
-		rc = -ENOMEM;
+		rc = -ENXIO;
 		goto err_release_group_1;
 	}
 	altr_create_edacdev_dbgfs(dci, prv);
@@ -1963,7 +1965,7 @@ static int altr_edac_a10_device_add(struct altr_arria10_edac *edac,
 	rc = edac_device_add_device(dci);
 	if (rc) {
 		dev_err(edac->dev, "edac_device_add_device failed\n");
-		rc = -ENOMEM;
+		rc = -ENXIO;
 		goto err_release_group1;
 	}
 
diff --git a/drivers/edac/amd8111_edac.c b/drivers/edac/amd8111_edac.c
index 16b28da6489177a..216ef32172bc58c 100644
--- a/drivers/edac/amd8111_edac.c
+++ b/drivers/edac/amd8111_edac.c
@@ -388,6 +388,7 @@ static int amd8111_dev_probe(struct pci_dev *dev,
 	if (edac_device_add_device(dev_info->edac_dev) > 0) {
 		printk(KERN_ERR "failed to add edac_dev for %s\n",
 			dev_info->ctl_name);
+		ret = -ENXIO;
 		goto err_edac_free_ctl;
 	}
 
diff --git a/drivers/edac/armada_xp_edac.c b/drivers/edac/armada_xp_edac.c
index e3e757513d1bc38..23b9a469f100183 100644
--- a/drivers/edac/armada_xp_edac.c
+++ b/drivers/edac/armada_xp_edac.c
@@ -558,7 +558,7 @@ static int aurora_l2_probe(struct platform_device *pdev)
 
 	if (edac_device_add_device(dci)) {
 		edac_device_free_ctl_info(dci);
-		return -EINVAL;
+		return -ENXIO;
 	}
 
 #ifdef CONFIG_EDAC_DEBUG
diff --git a/drivers/edac/highbank_l2_edac.c b/drivers/edac/highbank_l2_edac.c
index c4549cec788b098..45dbe19c2577426 100644
--- a/drivers/edac/highbank_l2_edac.c
+++ b/drivers/edac/highbank_l2_edac.c
@@ -90,8 +90,10 @@ static int highbank_l2_err_probe(struct platform_device *pdev)
 	dci->ctl_name = id ? id->compatible : "unknown";
 	dci->dev_name = dev_name(&pdev->dev);
 
-	if (edac_device_add_device(dci))
+	if (edac_device_add_device(dci)) {
+		res = -ENXIO;
 		goto err;
+	}
 
 	drvdata->db_irq = platform_get_irq(pdev, 0);
 	res = devm_request_irq(&pdev->dev, drvdata->db_irq,
diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index 312de75e66b851e..6f0c95b83b076e0 100644
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -553,6 +553,7 @@ static int mpc85xx_l2_err_probe(struct platform_device *op)
 
 	if (edac_device_add_device(edac_dev) > 0) {
 		edac_dbg(3, "failed edac_device_add_device()\n");
+		res = -ENXIO;
 		goto err;
 	}
 
diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
index 97a27e42dd610db..b06e0746ff28423 100644
--- a/drivers/edac/qcom_edac.c
+++ b/drivers/edac/qcom_edac.c
@@ -361,8 +361,10 @@ static int qcom_llcc_edac_probe(struct platform_device *pdev)
 	edev_ctl->pvt_info = llcc_driv_data;
 
 	rc = edac_device_add_device(edev_ctl);
-	if (rc)
+	if (rc) {
+		rc = -ENXIO;
 		goto out_mem;
+	}
 
 	platform_set_drvdata(pdev, edev_ctl);
 
diff --git a/drivers/edac/thunderx_edac.c b/drivers/edac/thunderx_edac.c
index 0eb5eb97fd74279..3a19560232c11ec 100644
--- a/drivers/edac/thunderx_edac.c
+++ b/drivers/edac/thunderx_edac.c
@@ -1421,6 +1421,7 @@ static int thunderx_ocx_probe(struct pci_dev *pdev,
 	ret = edac_device_add_device(edac_dev);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot add EDAC device: %d\n", ret);
+		ret = -ENXIO;
 		goto err_free;
 	}
 
@@ -2051,6 +2052,7 @@ static int thunderx_l2c_probe(struct pci_dev *pdev,
 	ret = edac_device_add_device(edac_dev);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot add EDAC device: %d\n", ret);
+		ret = -ENXIO;
 		goto err_free;
 	}
 
diff --git a/drivers/edac/xgene_edac.c b/drivers/edac/xgene_edac.c
index 2ccd1db5e98ff0b..1263434c155ea86 100644
--- a/drivers/edac/xgene_edac.c
+++ b/drivers/edac/xgene_edac.c
@@ -953,7 +953,7 @@ static int xgene_edac_pmd_add(struct xgene_edac *edac, struct device_node *np,
 	rc = edac_device_add_device(edac_dev);
 	if (rc > 0) {
 		dev_err(edac->dev, "edac_device_add_device failed\n");
-		rc = -ENOMEM;
+		rc = -ENXIO;
 		goto err_free;
 	}
 
@@ -1236,7 +1236,7 @@ static int xgene_edac_l3_add(struct xgene_edac *edac, struct device_node *np,
 	rc = edac_device_add_device(edac_dev);
 	if (rc > 0) {
 		dev_err(edac->dev, "failed edac_device_add_device()\n");
-		rc = -ENOMEM;
+		rc = -ENXIO;
 		goto err_ctl_free;
 	}
 
@@ -1774,7 +1774,7 @@ static int xgene_edac_soc_add(struct xgene_edac *edac, struct device_node *np,
 	rc = edac_device_add_device(edac_dev);
 	if (rc > 0) {
 		dev_err(edac->dev, "failed edac_device_add_device()\n");
-		rc = -ENOMEM;
+		rc = -ENXIO;
 		goto err_ctl_free;
 	}
 
-- 
2.26.0.106.g9fadedd


