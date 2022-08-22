Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F61B59C84C
	for <lists+linux-edac@lfdr.de>; Mon, 22 Aug 2022 21:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238249AbiHVTOi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Aug 2022 15:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237392AbiHVTOg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Aug 2022 15:14:36 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1AC482B245;
        Mon, 22 Aug 2022 12:14:35 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 52088DA3;
        Mon, 22 Aug 2022 22:17:46 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 52088DA3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1661195866;
        bh=B6bbs4kuWYWRiAVHSN+DE3ciG3CdiiIqIzibAQa5gQ8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Gh7HpeaFCCHr9dPSz/zEikB/J+wr6K7f755r7nwzqTEk5xDHwH0a8TRvpsLAPHsjd
         nMtfPkFFnzptV8ioBGssNZbZp3gRbKNmyrN3lYLlQb7cfYUqjuv5NTybqiSK/n2z4l
         PdxLgjkKHqdmeSNNWWoVe/3+MPaW4LUjFhxrYtAs=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 22 Aug 2022 22:14:29 +0300
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
Subject: [PATCH 01/18] EDAC/synopsys: Convert sysfs nodes to debugfs ones
Date:   Mon, 22 Aug 2022 22:14:10 +0300
Message-ID: <20220822191427.27969-2-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220822191427.27969-1-Sergey.Semin@baikalelectronics.ru>
References: <20220822191427.27969-1-Sergey.Semin@baikalelectronics.ru>
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

The DW uMCTL2 DDRC EDAC driver supports creating two sysfs nodes:
"inject_data_error" and "inject_data_poison". First of them is responsible
for setting the error-injecting physical address up. The second one is
supposed to be used to enable the hardware capability of the correctable
and uncorrectable error injection. As you can see the semantics of these
nodes is pure debug. They are even created only if the EDAC_DEBUG kernel
config is enabled. Thus there is no point in having these nodes exported
in the sysfs. Let's move them to DebugFS in the device private directory
as this should have been done in the first place.

While at it we suggest to move the address map initialization procedure
invocation to the DebugFS nodes creating function and create an empty
snps_create_debugfs_nodes() method in case if the EDAC_DEBUG config is
disabled. Thus the DW uMCTL2 DDRC EDAC probe procedure will get to be a
bit simpler.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/edac/synopsys_edac.c | 221 +++++++++++++++++++----------------
 1 file changed, 122 insertions(+), 99 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index bcef9672f700..2a83c9cdc566 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -9,6 +9,7 @@
 #include <linux/bits.h>
 #include <linux/bitfield.h>
 #include <linux/edac.h>
+#include <linux/fs.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
@@ -643,6 +644,16 @@ static int snps_setup_irq(struct mem_ctl_info *mci, struct platform_device *pdev
 
 #ifdef CONFIG_EDAC_DEBUG
 
+#define SNPS_DEBUGFS_FOPS(__name, __read, __write) \
+	static const struct file_operations __name = {	\
+		.owner = THIS_MODULE,		\
+		.open = simple_open,		\
+		.read = __read,			\
+		.write = __write,		\
+	}
+
+#define SNPS_DBGFS_BUF_LEN 128
+
 /**
  * snps_data_poison_setup - Update poison registers.
  * @priv:		DDR memory controller private instance data.
@@ -703,90 +714,6 @@ static void snps_data_poison_setup(struct snps_edac_priv *priv)
 	writel(regval, priv->baseaddr + ECC_POISON1_OFST);
 }
 
-static ssize_t inject_data_error_show(struct device *dev,
-				      struct device_attribute *mattr,
-				      char *data)
-{
-	struct mem_ctl_info *mci = to_mci(dev);
-	struct snps_edac_priv *priv = mci->pvt_info;
-
-	return sprintf(data, "Poison0 Addr: 0x%08x\n\rPoison1 Addr: 0x%08x\n\r"
-			"Error injection Address: 0x%lx\n\r",
-			readl(priv->baseaddr + ECC_POISON0_OFST),
-			readl(priv->baseaddr + ECC_POISON1_OFST),
-			priv->poison_addr);
-}
-
-static ssize_t inject_data_error_store(struct device *dev,
-				       struct device_attribute *mattr,
-				       const char *data, size_t count)
-{
-	struct mem_ctl_info *mci = to_mci(dev);
-	struct snps_edac_priv *priv = mci->pvt_info;
-
-	if (kstrtoul(data, 0, &priv->poison_addr))
-		return -EINVAL;
-
-	snps_data_poison_setup(priv);
-
-	return count;
-}
-
-static ssize_t inject_data_poison_show(struct device *dev,
-				       struct device_attribute *mattr,
-				       char *data)
-{
-	struct mem_ctl_info *mci = to_mci(dev);
-	struct snps_edac_priv *priv = mci->pvt_info;
-	const char *errstr;
-	u32 regval;
-
-	regval = readl(priv->baseaddr + ECC_CFG1_OFST);
-	errstr = FIELD_GET(ECC_CEPOISON_MASK, regval) == ECC_CEPOISON_MASK ?
-		 "Correctable Error" : "UnCorrectable Error";
-
-	return sprintf(data, "Data Poisoning: %s\n\r", errstr);
-}
-
-static ssize_t inject_data_poison_store(struct device *dev,
-					struct device_attribute *mattr,
-					const char *data, size_t count)
-{
-	struct mem_ctl_info *mci = to_mci(dev);
-	struct snps_edac_priv *priv = mci->pvt_info;
-
-	writel(0, priv->baseaddr + DDR_SWCTL);
-	if (strncmp(data, "CE", 2) == 0)
-		writel(ECC_CEPOISON_MASK, priv->baseaddr + ECC_CFG1_OFST);
-	else
-		writel(ECC_UEPOISON_MASK, priv->baseaddr + ECC_CFG1_OFST);
-	writel(1, priv->baseaddr + DDR_SWCTL);
-
-	return count;
-}
-
-static DEVICE_ATTR_RW(inject_data_error);
-static DEVICE_ATTR_RW(inject_data_poison);
-
-static int snps_create_sysfs_attributes(struct mem_ctl_info *mci)
-{
-	int rc;
-
-	rc = device_create_file(&mci->dev, &dev_attr_inject_data_error);
-	if (rc < 0)
-		return rc;
-	rc = device_create_file(&mci->dev, &dev_attr_inject_data_poison);
-	if (rc < 0)
-		return rc;
-	return 0;
-}
-
-static void snps_remove_sysfs_attributes(struct mem_ctl_info *mci)
-{
-	device_remove_file(&mci->dev, &dev_attr_inject_data_error);
-	device_remove_file(&mci->dev, &dev_attr_inject_data_poison);
-}
-
 static void snps_setup_row_address_map(struct snps_edac_priv *priv, u32 *addrmap)
 {
 	u32 addrmap_row_b2_10;
@@ -1007,7 +934,115 @@ static void snps_setup_address_map(struct snps_edac_priv *priv)
 
 	snps_setup_rank_address_map(priv, addrmap);
 }
-#endif /* CONFIG_EDAC_DEBUG */
+
+static ssize_t snps_inject_data_error_read(struct file *filep, char __user *ubuf,
+					   size_t size, loff_t *offp)
+{
+	struct mem_ctl_info *mci = filep->private_data;
+	struct snps_edac_priv *priv = mci->pvt_info;
+	char buf[SNPS_DBGFS_BUF_LEN];
+	int pos;
+
+	pos = scnprintf(buf, sizeof(buf), "Poison0 Addr: 0x%08x\n\r",
+			readl(priv->baseaddr + ECC_POISON0_OFST));
+	pos += scnprintf(buf + pos, sizeof(buf) - pos, "Poison1 Addr: 0x%08x\n\r",
+			 readl(priv->baseaddr + ECC_POISON1_OFST));
+	pos += scnprintf(buf + pos, sizeof(buf) - pos, "Error injection Address: 0x%lx\n\r",
+			 priv->poison_addr);
+
+	return simple_read_from_buffer(ubuf, size, offp, buf, pos);
+}
+
+static ssize_t snps_inject_data_error_write(struct file *filep, const char __user *ubuf,
+					    size_t size, loff_t *offp)
+{
+	struct mem_ctl_info *mci = filep->private_data;
+	struct snps_edac_priv *priv = mci->pvt_info;
+	int rc;
+
+	rc = kstrtoul_from_user(ubuf, size, 0, &priv->poison_addr);
+	if (rc)
+		return rc;
+
+	snps_data_poison_setup(priv);
+
+	return size;
+}
+
+SNPS_DEBUGFS_FOPS(snps_inject_data_error, snps_inject_data_error_read,
+		  snps_inject_data_error_write);
+
+static ssize_t snps_inject_data_poison_read(struct file *filep, char __user *ubuf,
+					    size_t size, loff_t *offp)
+{
+	struct mem_ctl_info *mci = filep->private_data;
+	struct snps_edac_priv *priv = mci->pvt_info;
+	char buf[SNPS_DBGFS_BUF_LEN];
+	const char *errstr;
+	u32 regval;
+	int pos;
+
+	regval = readl(priv->baseaddr + ECC_CFG1_OFST);
+	errstr = FIELD_GET(ECC_CEPOISON_MASK, regval) == ECC_CEPOISON_MASK ?
+		 "Correctable Error" : "UnCorrectable Error";
+
+	pos = scnprintf(buf, sizeof(buf), "Data Poisoning: %s\n\r", errstr);
+
+	return simple_read_from_buffer(ubuf, size, offp, buf, pos);
+}
+
+static ssize_t snps_inject_data_poison_write(struct file *filep, const char __user *ubuf,
+					     size_t size, loff_t *offp)
+{
+	struct mem_ctl_info *mci = filep->private_data;
+	struct snps_edac_priv *priv = mci->pvt_info;
+	char buf[SNPS_DBGFS_BUF_LEN];
+	int rc;
+
+	rc = simple_write_to_buffer(buf, sizeof(buf), offp, ubuf, size);
+	if (rc < 0)
+		return rc;
+
+	writel(0, priv->baseaddr + DDR_SWCTL);
+	if (strncmp(buf, "CE", 2) == 0)
+		writel(ECC_CEPOISON_MASK, priv->baseaddr + ECC_CFG1_OFST);
+	else
+		writel(ECC_UEPOISON_MASK, priv->baseaddr + ECC_CFG1_OFST);
+	writel(1, priv->baseaddr + DDR_SWCTL);
+
+	return size;
+}
+
+SNPS_DEBUGFS_FOPS(snps_inject_data_poison, snps_inject_data_poison_read,
+		  snps_inject_data_poison_write);
+
+/**
+ * snps_create_debugfs_nodes -	Create DebugFS nodes.
+ * @mci:	EDAC memory controller instance.
+ *
+ * Create DW uMCTL2 EDAC driver DebugFS nodes in the device private
+ * DebugFS directory.
+ *
+ * Return: none.
+ */
+static void snps_create_debugfs_nodes(struct mem_ctl_info *mci)
+{
+	struct snps_edac_priv *priv = mci->pvt_info;
+
+	snps_setup_address_map(priv);
+
+	edac_debugfs_create_file("inject_data_error", 0600, mci->debugfs, mci,
+				 &snps_inject_data_error);
+
+	edac_debugfs_create_file("inject_data_poison", 0600, mci->debugfs, mci,
+				 &snps_inject_data_poison);
+}
+
+#else /* !CONFIG_EDAC_DEBUG */
+
+static inline void snps_create_debugfs_nodes(struct mem_ctl_info *mci) {}
+
+#endif /* !CONFIG_EDAC_DEBUG */
 
 /**
  * snps_mc_probe - Check controller and bind driver.
@@ -1073,17 +1108,9 @@ static int snps_mc_probe(struct platform_device *pdev)
 		goto free_edac_mc;
 	}
 
-#ifdef CONFIG_EDAC_DEBUG
-	rc = snps_create_sysfs_attributes(mci);
-	if (rc) {
-		edac_printk(KERN_ERR, EDAC_MC, "Failed to create sysfs entries\n");
-		goto free_edac_mc;
-	}
+	snps_create_debugfs_nodes(mci);
 
-	snps_setup_address_map(priv);
-#endif
-
-	return rc;
+	return 0;
 
 free_edac_mc:
 	edac_mc_free(mci);
@@ -1104,10 +1131,6 @@ static int snps_mc_remove(struct platform_device *pdev)
 
 	snps_disable_irq(priv);
 
-#ifdef CONFIG_EDAC_DEBUG
-	snps_remove_sysfs_attributes(mci);
-#endif
-
 	edac_mc_del_mc(&pdev->dev);
 	edac_mc_free(mci);
 
-- 
2.35.1

