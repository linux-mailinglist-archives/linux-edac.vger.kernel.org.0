Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96DF46876F
	for <lists+linux-edac@lfdr.de>; Mon, 15 Jul 2019 12:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbfGOKxq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 15 Jul 2019 06:53:46 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:23243 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729591AbfGOKxp (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 15 Jul 2019 06:53:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1563188021; x=1594724021;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=EOyyHG11I2Z6Ak6ErAj9B20AxtftPw+ir535ZNv20tg=;
  b=UyI/5F9vlhJLBgI/4UqtaBkKlqL3rI+PaJ0pFFuGDpfciOD2GZW+yPIc
   OeGhN7d48n1lyv4JKTqWDGtf+z1NN8vMx+LRUgXlSdj82Gxr8Gccq4J+Y
   4xC/VE7YwWbyMXULowptiRz9BP0Arsy+2BYnLGWJDaJ29bhJYgGbKhV3m
   Q=;
X-IronPort-AV: E=Sophos;i="5.62,493,1554768000"; 
   d="scan'208";a="410721780"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-9ec21598.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 15 Jul 2019 10:53:39 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-9ec21598.us-east-1.amazon.com (Postfix) with ESMTPS id D6EC8A231E;
        Mon, 15 Jul 2019 10:53:33 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 15 Jul 2019 10:53:32 +0000
Received: from ub6d44c9ce3e25c.ant.amazon.com (10.43.160.211) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 15 Jul 2019 10:53:22 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <thor.thayer@linux.intel.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <james.morse@arm.com>, <rric@kernel.org>,
        <morbidrsa@gmail.com>, <ralf@linux-mips.org>,
        <david.daney@cavium.com>, <andy.gross@linaro.org>,
        <david.brown@linaro.org>, <ckadabi@codeaurora.org>,
        <vnkgutta@codeaurora.org>, <jglauber@cavium.com>,
        <khuong@os.amperecomputing.com>
CC:     <dwmw@amazon.co.uk>, <benh@amazon.com>, <ronenk@amazon.com>,
        <talel@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mips@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <hhhawa@amazon.com>
Subject: [RFC 1/1] edac: Add a counter parameter for edac_device_handle_ue/ce()
Date:   Mon, 15 Jul 2019 13:53:07 +0300
Message-ID: <1563187987-5847-1-git-send-email-hhhawa@amazon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.211]
X-ClientProxiedBy: EX13D20UWA003.ant.amazon.com (10.43.160.97) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add a counter parameter in order to avoid losing errors count for edac
device, the error count reports the number of errors reported by an edac
device similar to the way MC_EDAC do.

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
---
 drivers/edac/altera_edac.c      | 20 ++++++++++++--------
 drivers/edac/amd8111_edac.c     |  6 +++---
 drivers/edac/cpc925_edac.c      |  4 ++--
 drivers/edac/edac_device.c      | 18 ++++++++++--------
 drivers/edac/edac_device.h      |  8 ++++++--
 drivers/edac/highbank_l2_edac.c |  4 ++--
 drivers/edac/mpc85xx_edac.c     |  4 ++--
 drivers/edac/mv64x60_edac.c     |  4 ++--
 drivers/edac/octeon_edac-l2c.c  | 20 ++++++++++----------
 drivers/edac/octeon_edac-pc.c   |  6 +++---
 drivers/edac/qcom_edac.c        |  8 ++++----
 drivers/edac/thunderx_edac.c    | 10 +++++-----
 drivers/edac/xgene_edac.c       | 26 +++++++++++++-------------
 13 files changed, 74 insertions(+), 64 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 8816f74..747dd43 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -616,12 +616,12 @@ static irqreturn_t altr_edac_device_handler(int irq, void *dev_id)
 	if (irq == drvdata->sb_irq) {
 		if (priv->ce_clear_mask)
 			writel(priv->ce_clear_mask, drvdata->base);
-		edac_device_handle_ce(dci, 0, 0, drvdata->edac_dev_name);
+		edac_device_handle_ce(dci, 1, 0, 0, drvdata->edac_dev_name);
 		ret_value = IRQ_HANDLED;
 	} else if (irq == drvdata->db_irq) {
 		if (priv->ue_clear_mask)
 			writel(priv->ue_clear_mask, drvdata->base);
-		edac_device_handle_ue(dci, 0, 0, drvdata->edac_dev_name);
+		edac_device_handle_ue(dci, 1, 0, 0, drvdata->edac_dev_name);
 		panic("\nEDAC:ECC_DEVICE[Uncorrectable errors]\n");
 		ret_value = IRQ_HANDLED;
 	} else {
@@ -919,13 +919,15 @@ static irqreturn_t __maybe_unused altr_edac_a10_ecc_irq(int irq, void *dev_id)
 	if (irq == dci->sb_irq) {
 		writel(ALTR_A10_ECC_SERRPENA,
 		       base + ALTR_A10_ECC_INTSTAT_OFST);
-		edac_device_handle_ce(dci->edac_dev, 0, 0, dci->edac_dev_name);
+		edac_device_handle_ce(dci->edac_dev, 1, 0, 0,
+				      dci->edac_dev_name);
 
 		return IRQ_HANDLED;
 	} else if (irq == dci->db_irq) {
 		writel(ALTR_A10_ECC_DERRPENA,
 		       base + ALTR_A10_ECC_INTSTAT_OFST);
-		edac_device_handle_ue(dci->edac_dev, 0, 0, dci->edac_dev_name);
+		edac_device_handle_ue(dci->edac_dev, 1, 0, 0,
+				      dci->edac_dev_name);
 		if (dci->data->panic)
 			panic("\nEDAC:ECC_DEVICE[Uncorrectable errors]\n");
 
@@ -1308,14 +1310,16 @@ static irqreturn_t altr_edac_a10_l2_irq(int irq, void *dev_id)
 		regmap_write(dci->edac->ecc_mgr_map,
 			     A10_SYSGMR_MPU_CLEAR_L2_ECC_OFST,
 			     A10_SYSGMR_MPU_CLEAR_L2_ECC_SB);
-		edac_device_handle_ce(dci->edac_dev, 0, 0, dci->edac_dev_name);
+		edac_device_handle_ce(dci->edac_dev, 1, 0, 0,
+				      dci->edac_dev_name);
 
 		return IRQ_HANDLED;
 	} else if (irq == dci->db_irq) {
 		regmap_write(dci->edac->ecc_mgr_map,
 			     A10_SYSGMR_MPU_CLEAR_L2_ECC_OFST,
 			     A10_SYSGMR_MPU_CLEAR_L2_ECC_MB);
-		edac_device_handle_ue(dci->edac_dev, 0, 0, dci->edac_dev_name);
+		edac_device_handle_ue(dci->edac_dev, 1, 0, 0,
+				      dci->edac_dev_name);
 		panic("\nEDAC:ECC_DEVICE[Uncorrectable errors]\n");
 
 		return IRQ_HANDLED;
@@ -1652,12 +1656,12 @@ static irqreturn_t altr_edac_a10_ecc_irq_portb(int irq, void *dev_id)
 	if (irq == ad->sb_irq) {
 		writel(priv->ce_clear_mask,
 		       base + ALTR_A10_ECC_INTSTAT_OFST);
-		edac_device_handle_ce(ad->edac_dev, 0, 0, ad->edac_dev_name);
+		edac_device_handle_ce(ad->edac_dev, 1, 0, 0, ad->edac_dev_name);
 		return IRQ_HANDLED;
 	} else if (irq == ad->db_irq) {
 		writel(priv->ue_clear_mask,
 		       base + ALTR_A10_ECC_INTSTAT_OFST);
-		edac_device_handle_ue(ad->edac_dev, 0, 0, ad->edac_dev_name);
+		edac_device_handle_ue(ad->edac_dev, 1, 0, 0, ad->edac_dev_name);
 		return IRQ_HANDLED;
 	}
 
diff --git a/drivers/edac/amd8111_edac.c b/drivers/edac/amd8111_edac.c
index b5786cf..e595fab 100644
--- a/drivers/edac/amd8111_edac.c
+++ b/drivers/edac/amd8111_edac.c
@@ -303,7 +303,7 @@ static void amd8111_lpc_bridge_check(struct edac_device_ctl_info *edac_dev)
 		val8 |= IO_CTRL_1_CLEAR_MASK;
 		edac_pci_write_byte(dev, REG_IO_CTRL_1, val8);
 
-		edac_device_handle_ue(edac_dev, 0, 0, edac_dev->ctl_name);
+		edac_device_handle_ue(edac_dev, 1, 0, 0, edac_dev->ctl_name);
 	}
 
 	if (at_compat_reg_broken == 0) {
@@ -315,8 +315,8 @@ static void amd8111_lpc_bridge_check(struct edac_device_ctl_info *edac_dev)
 			out8 |= AT_COMPAT_CLRIOCHK;
 		if (out8 > 0) {
 			__do_outb(out8, REG_AT_COMPAT);
-			edac_device_handle_ue(edac_dev, 0, 0,
-						edac_dev->ctl_name);
+			edac_device_handle_ue(edac_dev, 1, 0, 0,
+					      edac_dev->ctl_name);
 		}
 	}
 }
diff --git a/drivers/edac/cpc925_edac.c b/drivers/edac/cpc925_edac.c
index 3c0881a..eb74865 100644
--- a/drivers/edac/cpc925_edac.c
+++ b/drivers/edac/cpc925_edac.c
@@ -682,7 +682,7 @@ static void cpc925_cpu_check(struct edac_device_ctl_info *edac_dev)
 	cpc925_printk(KERN_INFO, "APIMASK		0x%08x\n", apimask);
 	cpc925_printk(KERN_INFO, "APIEXCP		0x%08x\n", apiexcp);
 
-	edac_device_handle_ue(edac_dev, 0, 0, edac_dev->ctl_name);
+	edac_device_handle_ue(edac_dev, 1, 0, 0, edac_dev->ctl_name);
 }
 
 /******************** HT Link err device****************************/
@@ -756,7 +756,7 @@ static void cpc925_htlink_check(struct edac_device_ctl_info *edac_dev)
 		__raw_writel(HT_LINKERR_DETECTED,
 				dev_info->vbase + REG_LINKERR_OFFSET);
 
-	edac_device_handle_ce(edac_dev, 0, 0, edac_dev->ctl_name);
+	edac_device_handle_ce(edac_dev, 1, 0, 0, edac_dev->ctl_name);
 }
 
 static struct cpc925_dev_info cpc925_devs[] = {
diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
index 65cf2b9..d1de296 100644
--- a/drivers/edac/edac_device.c
+++ b/drivers/edac/edac_device.c
@@ -556,7 +556,8 @@ static inline int edac_device_get_panic_on_ue(struct edac_device_ctl_info
 }
 
 void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
-			int inst_nr, int block_nr, const char *msg)
+			   u16 error_count, int inst_nr, int block_nr,
+			   const char *msg)
 {
 	struct edac_device_instance *instance;
 	struct edac_device_block *block = NULL;
@@ -582,12 +583,12 @@ void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
 
 	if (instance->nr_blocks > 0) {
 		block = instance->blocks + block_nr;
-		block->counters.ce_count++;
+		block->counters.ce_count += error_count;
 	}
 
 	/* Propagate the count up the 'totals' tree */
-	instance->counters.ce_count++;
-	edac_dev->counters.ce_count++;
+	instance->counters.ce_count += error_count;
+	edac_dev->counters.ce_count += error_count;
 
 	if (edac_device_get_log_ce(edac_dev))
 		edac_device_printk(edac_dev, KERN_WARNING,
@@ -598,7 +599,8 @@ void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
 EXPORT_SYMBOL_GPL(edac_device_handle_ce);
 
 void edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
-			int inst_nr, int block_nr, const char *msg)
+			   u16 error_count, int inst_nr, int block_nr,
+			   const char *msg)
 {
 	struct edac_device_instance *instance;
 	struct edac_device_block *block = NULL;
@@ -624,12 +626,12 @@ void edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
 
 	if (instance->nr_blocks > 0) {
 		block = instance->blocks + block_nr;
-		block->counters.ue_count++;
+		block->counters.ue_count += error_count;
 	}
 
 	/* Propagate the count up the 'totals' tree */
-	instance->counters.ue_count++;
-	edac_dev->counters.ue_count++;
+	instance->counters.ue_count += error_count;
+	edac_dev->counters.ue_count += error_count;
 
 	if (edac_device_get_log_ue(edac_dev))
 		edac_device_printk(edac_dev, KERN_EMERG,
diff --git a/drivers/edac/edac_device.h b/drivers/edac/edac_device.h
index 1aaba74..cf1a1da 100644
--- a/drivers/edac/edac_device.h
+++ b/drivers/edac/edac_device.h
@@ -290,23 +290,27 @@ extern struct edac_device_ctl_info *edac_device_del_device(struct device *dev);
  *	perform a common output and handling of an 'edac_dev' UE event
  *
  * @edac_dev: pointer to struct &edac_device_ctl_info
+ * @error_count: number of errors of the same type
  * @inst_nr: number of the instance where the UE error happened
  * @block_nr: number of the block where the UE error happened
  * @msg: message to be printed
  */
 extern void edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
-				int inst_nr, int block_nr, const char *msg);
+				  u16 error_count, int inst_nr, int block_nr,
+				  const char *msg);
 /**
  * edac_device_handle_ce():
  *	perform a common output and handling of an 'edac_dev' CE event
  *
  * @edac_dev: pointer to struct &edac_device_ctl_info
+ * @error_count: number of errors of the same type
  * @inst_nr: number of the instance where the CE error happened
  * @block_nr: number of the block where the CE error happened
  * @msg: message to be printed
  */
 extern void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
-				int inst_nr, int block_nr, const char *msg);
+				  u16 error_count, int inst_nr, int block_nr,
+				  const char *msg);
 
 /**
  * edac_device_alloc_index: Allocate a unique device index number
diff --git a/drivers/edac/highbank_l2_edac.c b/drivers/edac/highbank_l2_edac.c
index cd9a2bb..65f016a 100644
--- a/drivers/edac/highbank_l2_edac.c
+++ b/drivers/edac/highbank_l2_edac.c
@@ -39,11 +39,11 @@ static irqreturn_t highbank_l2_err_handler(int irq, void *dev_id)
 
 	if (irq == drvdata->sb_irq) {
 		writel(1, drvdata->base + SR_CLR_SB_ECC_INTR);
-		edac_device_handle_ce(dci, 0, 0, dci->ctl_name);
+		edac_device_handle_ce(dci, 1, 0, 0, dci->ctl_name);
 	}
 	if (irq == drvdata->db_irq) {
 		writel(1, drvdata->base + SR_CLR_DB_ECC_INTR);
-		edac_device_handle_ue(dci, 0, 0, dci->ctl_name);
+		edac_device_handle_ue(dci, 1, 0, 0, dci->ctl_name);
 	}
 
 	return IRQ_HANDLED;
diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index 67f7bc3..0618a06 100644
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -464,10 +464,10 @@ static void mpc85xx_l2_check(struct edac_device_ctl_info *edac_dev)
 	out_be32(pdata->l2_vbase + MPC85XX_L2_ERRDET, err_detect);
 
 	if (err_detect & L2_EDE_CE_MASK)
-		edac_device_handle_ce(edac_dev, 0, 0, edac_dev->ctl_name);
+		edac_device_handle_ce(edac_dev, 1, 0, 0, edac_dev->ctl_name);
 
 	if (err_detect & L2_EDE_UE_MASK)
-		edac_device_handle_ue(edac_dev, 0, 0, edac_dev->ctl_name);
+		edac_device_handle_ue(edac_dev, 1, 0, 0, edac_dev->ctl_name);
 }
 
 static irqreturn_t mpc85xx_l2_isr(int irq, void *dev_id)
diff --git a/drivers/edac/mv64x60_edac.c b/drivers/edac/mv64x60_edac.c
index 3c68bb5..005b012 100644
--- a/drivers/edac/mv64x60_edac.c
+++ b/drivers/edac/mv64x60_edac.c
@@ -251,7 +251,7 @@ static void mv64x60_sram_check(struct edac_device_ctl_info *edac_dev)
 	       readl(pdata->sram_vbase + MV64X60_SRAM_ERR_PARITY));
 	writel(0, pdata->sram_vbase + MV64X60_SRAM_ERR_CAUSE);
 
-	edac_device_handle_ue(edac_dev, 0, 0, edac_dev->ctl_name);
+	edac_device_handle_ue(edac_dev, 1, 0, 0, edac_dev->ctl_name);
 }
 
 static irqreturn_t mv64x60_sram_isr(int irq, void *dev_id)
@@ -417,7 +417,7 @@ static void mv64x60_cpu_check(struct edac_device_ctl_info *edac_dev)
 	       readl(pdata->cpu_vbase[1] + MV64x60_CPU_ERR_PARITY));
 	writel(0, pdata->cpu_vbase[1] + MV64x60_CPU_ERR_CAUSE);
 
-	edac_device_handle_ue(edac_dev, 0, 0, edac_dev->ctl_name);
+	edac_device_handle_ue(edac_dev, 1, 0, 0, edac_dev->ctl_name);
 }
 
 static irqreturn_t mv64x60_cpu_isr(int irq, void *dev_id)
diff --git a/drivers/edac/octeon_edac-l2c.c b/drivers/edac/octeon_edac-l2c.c
index c33059e..8e58531 100644
--- a/drivers/edac/octeon_edac-l2c.c
+++ b/drivers/edac/octeon_edac-l2c.c
@@ -28,12 +28,12 @@ static void octeon_l2c_poll_oct1(struct edac_device_ctl_info *l2c)
 	l2t_err_reset.u64 = 0;
 	l2t_err.u64 = cvmx_read_csr(CVMX_L2T_ERR);
 	if (l2t_err.s.sec_err) {
-		edac_device_handle_ce(l2c, 0, 0,
+		edac_device_handle_ce(l2c, 1, 0, 0,
 				      "Tag Single bit error (corrected)");
 		l2t_err_reset.s.sec_err = 1;
 	}
 	if (l2t_err.s.ded_err) {
-		edac_device_handle_ue(l2c, 0, 0,
+		edac_device_handle_ue(l2c, 1, 0, 0,
 				      "Tag Double bit error (detected)");
 		l2t_err_reset.s.ded_err = 1;
 	}
@@ -43,12 +43,12 @@ static void octeon_l2c_poll_oct1(struct edac_device_ctl_info *l2c)
 	l2d_err_reset.u64 = 0;
 	l2d_err.u64 = cvmx_read_csr(CVMX_L2D_ERR);
 	if (l2d_err.s.sec_err) {
-		edac_device_handle_ce(l2c, 0, 1,
+		edac_device_handle_ce(l2c, 1, 0, 1,
 				      "Data Single bit error (corrected)");
 		l2d_err_reset.s.sec_err = 1;
 	}
 	if (l2d_err.s.ded_err) {
-		edac_device_handle_ue(l2c, 0, 1,
+		edac_device_handle_ue(l2c, 1, 0, 1,
 				      "Data Double bit error (detected)");
 		l2d_err_reset.s.ded_err = 1;
 	}
@@ -76,25 +76,25 @@ static void _octeon_l2c_poll_oct2(struct edac_device_ctl_info *l2c, int tad)
 		snprintf(buf2, sizeof(buf2),
 			 "L2D Double bit error (detected):%s", buf1);
 		err_tdtx_reset.s.dbe = 1;
-		edac_device_handle_ue(l2c, tad, 1, buf2);
+		edac_device_handle_ue(l2c, 1, tad, 1, buf2);
 	}
 	if (err_tdtx.s.sbe) {
 		snprintf(buf2, sizeof(buf2),
 			 "L2D Single bit error (corrected):%s", buf1);
 		err_tdtx_reset.s.sbe = 1;
-		edac_device_handle_ce(l2c, tad, 1, buf2);
+		edac_device_handle_ce(l2c, 1, tad, 1, buf2);
 	}
 	if (err_tdtx.s.vdbe) {
 		snprintf(buf2, sizeof(buf2),
 			 "VBF Double bit error (detected):%s", buf1);
 		err_tdtx_reset.s.vdbe = 1;
-		edac_device_handle_ue(l2c, tad, 1, buf2);
+		edac_device_handle_ue(l2c, 1, tad, 1, buf2);
 	}
 	if (err_tdtx.s.vsbe) {
 		snprintf(buf2, sizeof(buf2),
 			 "VBF Single bit error (corrected):%s", buf1);
 		err_tdtx_reset.s.vsbe = 1;
-		edac_device_handle_ce(l2c, tad, 1, buf2);
+		edac_device_handle_ce(l2c, 1, tad, 1, buf2);
 	}
 	if (err_tdtx_reset.u64)
 		cvmx_write_csr(CVMX_L2C_ERR_TDTX(tad), err_tdtx_reset.u64);
@@ -111,13 +111,13 @@ static void _octeon_l2c_poll_oct2(struct edac_device_ctl_info *l2c, int tad)
 		snprintf(buf2, sizeof(buf2),
 			 "Tag Double bit error (detected):%s", buf1);
 		err_ttgx_reset.s.dbe = 1;
-		edac_device_handle_ue(l2c, tad, 0, buf2);
+		edac_device_handle_ue(l2c, 1, tad, 0, buf2);
 	}
 	if (err_ttgx.s.sbe) {
 		snprintf(buf2, sizeof(buf2),
 			 "Tag Single bit error (corrected):%s", buf1);
 		err_ttgx_reset.s.sbe = 1;
-		edac_device_handle_ce(l2c, tad, 0, buf2);
+		edac_device_handle_ce(l2c, 1, tad, 0, buf2);
 	}
 	if (err_ttgx_reset.u64)
 		cvmx_write_csr(CVMX_L2C_ERR_TTGX(tad), err_ttgx_reset.u64);
diff --git a/drivers/edac/octeon_edac-pc.c b/drivers/edac/octeon_edac-pc.c
index 754eced..efd0bbc 100644
--- a/drivers/edac/octeon_edac-pc.c
+++ b/drivers/edac/octeon_edac-pc.c
@@ -59,7 +59,7 @@ static int  co_cache_error_event(struct notifier_block *this,
 				   (unsigned long long)icache_err, core, cpu,
 				   read_c0_errorepc());
 		write_octeon_c0_icacheerr(0);
-		edac_device_handle_ce(p->ed, cpu, 1, "icache");
+		edac_device_handle_ce(p->ed, 1, cpu, 1, "icache");
 	}
 	if (dcache_err & 1) {
 		edac_device_printk(p->ed, KERN_ERR,
@@ -67,9 +67,9 @@ static int  co_cache_error_event(struct notifier_block *this,
 				   (unsigned long long)dcache_err, core, cpu,
 				   read_c0_errorepc());
 		if (event)
-			edac_device_handle_ue(p->ed, cpu, 0, "dcache");
+			edac_device_handle_ue(p->ed, 1, cpu, 0, "dcache");
 		else
-			edac_device_handle_ce(p->ed, cpu, 0, "dcache");
+			edac_device_handle_ce(p->ed, 1, cpu, 0, "dcache");
 
 		/* Clear the error indication */
 		if (OCTEON_IS_OCTEON2())
diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
index 97a27e4..8730eed 100644
--- a/drivers/edac/qcom_edac.c
+++ b/drivers/edac/qcom_edac.c
@@ -261,19 +261,19 @@ dump_syn_reg(struct edac_device_ctl_info *edev_ctl, int err_type, u32 bank)
 
 	switch (err_type) {
 	case LLCC_DRAM_CE:
-		edac_device_handle_ce(edev_ctl, 0, bank,
+		edac_device_handle_ce(edev_ctl, 1, 0, bank,
 				      "LLCC Data RAM correctable Error");
 		break;
 	case LLCC_DRAM_UE:
-		edac_device_handle_ue(edev_ctl, 0, bank,
+		edac_device_handle_ue(edev_ctl, 1, 0, bank,
 				      "LLCC Data RAM uncorrectable Error");
 		break;
 	case LLCC_TRAM_CE:
-		edac_device_handle_ce(edev_ctl, 0, bank,
+		edac_device_handle_ce(edev_ctl, 1, 0, bank,
 				      "LLCC Tag RAM correctable Error");
 		break;
 	case LLCC_TRAM_UE:
-		edac_device_handle_ue(edev_ctl, 0, bank,
+		edac_device_handle_ue(edev_ctl, 1, 0, bank,
 				      "LLCC Tag RAM uncorrectable Error");
 		break;
 	default:
diff --git a/drivers/edac/thunderx_edac.c b/drivers/edac/thunderx_edac.c
index 34be60f..35a186f 100644
--- a/drivers/edac/thunderx_edac.c
+++ b/drivers/edac/thunderx_edac.c
@@ -1151,7 +1151,7 @@ static irqreturn_t thunderx_ocx_com_threaded_isr(int irq, void *irq_id)
 			}
 
 		if (ctx->reg_com_int & OCX_COM_INT_CE)
-			edac_device_handle_ce(ocx->edac_dev, 0, 0, msg);
+			edac_device_handle_ce(ocx->edac_dev, 1, 0, 0, msg);
 
 		ocx->com_ring_tail++;
 	}
@@ -1220,9 +1220,9 @@ static irqreturn_t thunderx_ocx_lnk_threaded_isr(int irq, void *irq_id)
 		strncat(msg, other, OCX_MESSAGE_SIZE);
 
 		if (ctx->reg_com_link_int & OCX_COM_LINK_INT_UE)
-			edac_device_handle_ue(ocx->edac_dev, 0, 0, msg);
+			edac_device_handle_ue(ocx->edac_dev, 1, 0, 0, msg);
 		else if (ctx->reg_com_link_int & OCX_COM_LINK_INT_CE)
-			edac_device_handle_ce(ocx->edac_dev, 0, 0, msg);
+			edac_device_handle_ce(ocx->edac_dev, 1, 0, 0, msg);
 
 		ocx->link_ring_tail++;
 	}
@@ -1899,9 +1899,9 @@ static irqreturn_t thunderx_l2c_threaded_isr(int irq, void *irq_id)
 		strncat(msg, other, L2C_MESSAGE_SIZE);
 
 		if (ctx->reg_int & mask_ue)
-			edac_device_handle_ue(l2c->edac_dev, 0, 0, msg);
+			edac_device_handle_ue(l2c->edac_dev, 1, 0, 0, msg);
 		else if (ctx->reg_int & mask_ce)
-			edac_device_handle_ce(l2c->edac_dev, 0, 0, msg);
+			edac_device_handle_ce(l2c->edac_dev, 1, 0, 0, msg);
 
 		l2c->ring_tail++;
 	}
diff --git a/drivers/edac/xgene_edac.c b/drivers/edac/xgene_edac.c
index e8b81d7..d31a8bb 100644
--- a/drivers/edac/xgene_edac.c
+++ b/drivers/edac/xgene_edac.c
@@ -574,7 +574,7 @@ static void xgene_edac_pmd_l1_check(struct edac_device_ctl_info *edac_dev,
 
 	if (val & (MEMERR_CPU_ICFESR_CERR_MASK |
 		   MEMERR_CPU_ICFESR_MULTCERR_MASK))
-		edac_device_handle_ce(edac_dev, 0, 0, edac_dev->ctl_name);
+		edac_device_handle_ce(edac_dev, 1, 0, 0, edac_dev->ctl_name);
 
 chk_lsu:
 	val = readl(pg_f + MEMERR_CPU_LSUESR_PAGE_OFFSET);
@@ -618,7 +618,7 @@ static void xgene_edac_pmd_l1_check(struct edac_device_ctl_info *edac_dev,
 
 	if (val & (MEMERR_CPU_LSUESR_CERR_MASK |
 		   MEMERR_CPU_LSUESR_MULTCERR_MASK))
-		edac_device_handle_ce(edac_dev, 0, 0, edac_dev->ctl_name);
+		edac_device_handle_ce(edac_dev, 1, 0, 0, edac_dev->ctl_name);
 
 chk_mmu:
 	val = readl(pg_f + MEMERR_CPU_MMUESR_PAGE_OFFSET);
@@ -665,7 +665,7 @@ static void xgene_edac_pmd_l1_check(struct edac_device_ctl_info *edac_dev,
 	/* Clear any HW errors */
 	writel(val, pg_f + MEMERR_CPU_MMUESR_PAGE_OFFSET);
 
-	edac_device_handle_ce(edac_dev, 0, 0, edac_dev->ctl_name);
+	edac_device_handle_ce(edac_dev, 1, 0, 0, edac_dev->ctl_name);
 }
 
 static void xgene_edac_pmd_l2_check(struct edac_device_ctl_info *edac_dev)
@@ -724,10 +724,10 @@ static void xgene_edac_pmd_l2_check(struct edac_device_ctl_info *edac_dev)
 
 	if (val & (MEMERR_L2C_L2ESR_ERR_MASK |
 		   MEMERR_L2C_L2ESR_MULTICERR_MASK))
-		edac_device_handle_ce(edac_dev, 0, 0, edac_dev->ctl_name);
+		edac_device_handle_ce(edac_dev, 1, 0, 0, edac_dev->ctl_name);
 	if (val & (MEMERR_L2C_L2ESR_UCERR_MASK |
 		   MEMERR_L2C_L2ESR_MULTUCERR_MASK))
-		edac_device_handle_ue(edac_dev, 0, 0, edac_dev->ctl_name);
+		edac_device_handle_ue(edac_dev, 1, 0, 0, edac_dev->ctl_name);
 
 chk_l2c:
 	/* Check if any memory request timed out on L2 cache */
@@ -1113,13 +1113,13 @@ static void xgene_edac_l3_check(struct edac_device_ctl_info *edac_dev)
 
 	if (ctx->version <= 1 &&
 	    xgene_edac_l3_promote_to_uc_err(l3cesr, l3celr)) {
-		edac_device_handle_ue(edac_dev, 0, 0, edac_dev->ctl_name);
+		edac_device_handle_ue(edac_dev, 1, 0, 0, edac_dev->ctl_name);
 		return;
 	}
 	if (l3cesr & L3C_ESR_CERR_MASK)
-		edac_device_handle_ce(edac_dev, 0, 0, edac_dev->ctl_name);
+		edac_device_handle_ce(edac_dev, 1, 0, 0, edac_dev->ctl_name);
 	if (l3cesr & L3C_ESR_UCERR_MASK)
-		edac_device_handle_ue(edac_dev, 0, 0, edac_dev->ctl_name);
+		edac_device_handle_ue(edac_dev, 1, 0, 0, edac_dev->ctl_name);
 }
 
 static void xgene_edac_l3_hw_init(struct edac_device_ctl_info *edac_dev,
@@ -1449,7 +1449,7 @@ static void xgene_edac_iob_gic_report(struct edac_device_ctl_info *edac_dev)
 		writel(err_addr_hi, ctx->dev_csr + GLBL_MSEC_ERRH);
 	}
 	if (reg & (SEC_ERR_MASK | MSEC_ERR_MASK))
-		edac_device_handle_ce(edac_dev, 0, 0, edac_dev->ctl_name);
+		edac_device_handle_ce(edac_dev, 1, 0, 0, edac_dev->ctl_name);
 
 	if (reg & DED_ERR_MASK) {
 		err_addr_lo = readl(ctx->dev_csr + GLBL_DED_ERRL);
@@ -1470,7 +1470,7 @@ static void xgene_edac_iob_gic_report(struct edac_device_ctl_info *edac_dev)
 		writel(err_addr_hi, ctx->dev_csr + GLBL_MDED_ERRH);
 	}
 	if (reg & (DED_ERR_MASK | MDED_ERR_MASK))
-		edac_device_handle_ue(edac_dev, 0, 0, edac_dev->ctl_name);
+		edac_device_handle_ue(edac_dev, 1, 0, 0, edac_dev->ctl_name);
 }
 
 static void xgene_edac_rb_report(struct edac_device_ctl_info *edac_dev)
@@ -1675,7 +1675,7 @@ static void xgene_edac_soc_check(struct edac_device_ctl_info *edac_dev)
 	if (pcp_lp_stat & CSW_SWITCH_TRACE_ERR_MASK) {
 		dev_info(edac_dev->dev,
 			 "CSW switch trace correctable memory parity error\n");
-		edac_device_handle_ce(edac_dev, 0, 0, edac_dev->ctl_name);
+		edac_device_handle_ce(edac_dev, 1, 0, 0, edac_dev->ctl_name);
 	}
 
 	if (!reg)
@@ -1685,14 +1685,14 @@ static void xgene_edac_soc_check(struct edac_device_ctl_info *edac_dev)
 	if (!soc_mem_err) {
 		dev_err(edac_dev->dev, "SoC memory parity error 0x%08X\n",
 			reg);
-		edac_device_handle_ue(edac_dev, 0, 0, edac_dev->ctl_name);
+		edac_device_handle_ue(edac_dev, 1, 0, 0, edac_dev->ctl_name);
 		return;
 	}
 	for (i = 0; i < 31; i++) {
 		if (reg & (1 << i)) {
 			dev_err(edac_dev->dev, "%s memory parity error\n",
 				soc_mem_err[i]);
-			edac_device_handle_ue(edac_dev, 0, 0,
+			edac_device_handle_ue(edac_dev, 1, 0, 0,
 					      edac_dev->ctl_name);
 		}
 	}
-- 
2.7.4

