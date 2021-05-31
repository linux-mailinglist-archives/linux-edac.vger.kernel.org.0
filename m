Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70CEB39627D
	for <lists+linux-edac@lfdr.de>; Mon, 31 May 2021 16:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbhEaO5U (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 31 May 2021 10:57:20 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3356 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234294AbhEaOyy (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 31 May 2021 10:54:54 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FtyqX5ffTz66Ql;
        Mon, 31 May 2021 22:49:28 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 22:53:11 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 22:53:10 +0800
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
Subject: [PATCH v2 1/3] edac: Fix error return code when edac_pci_add_device() fails
Date:   Mon, 31 May 2021 22:53:00 +0800
Message-ID: <20210531145302.9655-2-thunder.leizhen@huawei.com>
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

When edac_pci_add_device() fails, fix to return -ENODEV from the error
handling case instead of 0.

The "goto err" in octeon_pci_probe() is removed to simplify code.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/edac/amd8111_edac.c    | 1 +
 drivers/edac/mpc85xx_edac.c    | 1 +
 drivers/edac/octeon_edac-pci.c | 9 ++-------
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/amd8111_edac.c b/drivers/edac/amd8111_edac.c
index 7508aa416ddbd7b..16b28da6489177a 100644
--- a/drivers/edac/amd8111_edac.c
+++ b/drivers/edac/amd8111_edac.c
@@ -480,6 +480,7 @@ static int amd8111_pci_probe(struct pci_dev *dev,
 	if (edac_pci_add_device(pci_info->edac_dev, pci_info->edac_idx) > 0) {
 		printk(KERN_ERR "failed to add edac_pci for %s\n",
 			pci_info->ctl_name);
+		ret = -ENODEV;
 		goto err_edac_free_ctl;
 	}
 
diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index 67f7bc3fe5b3b62..312de75e66b851e 100644
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -248,6 +248,7 @@ static int mpc85xx_pci_err_probe(struct platform_device *op)
 
 	if (edac_pci_add_device(pci, pdata->edac_idx) > 0) {
 		edac_dbg(3, "failed edac_pci_add_device()\n");
+		res = -ENODEV;
 		goto err;
 	}
 
diff --git a/drivers/edac/octeon_edac-pci.c b/drivers/edac/octeon_edac-pci.c
index 28b238eecefcc9d..07995de4ea703ee 100644
--- a/drivers/edac/octeon_edac-pci.c
+++ b/drivers/edac/octeon_edac-pci.c
@@ -60,7 +60,6 @@ static void octeon_pci_poll(struct edac_pci_ctl_info *pci)
 static int octeon_pci_probe(struct platform_device *pdev)
 {
 	struct edac_pci_ctl_info *pci;
-	int res = 0;
 
 	pci = edac_pci_alloc_ctl_info(0, "octeon_pci_err");
 	if (!pci)
@@ -76,15 +75,11 @@ static int octeon_pci_probe(struct platform_device *pdev)
 
 	if (edac_pci_add_device(pci, 0) > 0) {
 		pr_err("%s: edac_pci_add_device() failed\n", __func__);
-		goto err;
+		edac_pci_free_ctl_info(pci);
+		return -ENODEV;
 	}
 
 	return 0;
-
-err:
-	edac_pci_free_ctl_info(pci);
-
-	return res;
 }
 
 static int octeon_pci_remove(struct platform_device *pdev)
-- 
2.26.0.106.g9fadedd


