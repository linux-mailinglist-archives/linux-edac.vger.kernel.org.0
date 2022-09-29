Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5643F5F1704
	for <lists+linux-edac@lfdr.de>; Sat,  1 Oct 2022 02:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbiJAAO2 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 30 Sep 2022 20:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbiJAAOW (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 30 Sep 2022 20:14:22 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 759531BE792;
        Fri, 30 Sep 2022 17:14:20 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id BACE4E0EE4;
        Fri, 30 Sep 2022 02:36:42 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=kbxPXTheaKviZxbgELHUe8kYjjon5nfip7oE9yCHX2A=; b=VnwjtGyTMEqR
        Xx5021R8/g25mY0purmwgde6DC9sJh/98sxH8JWTBz7ebfO9s6GIvIy4xwaGdaoN
        CdVk9iIWI5iJgOCPL6RcMiqLWO3+7ol6oXjklqRSa8KdJcqTzLEFOAJhBda6fL4c
        VUil1C+uYfqhGJeWS6jKlocwtdrm7U4=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id A9E36E0E70;
        Fri, 30 Sep 2022 02:36:42 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 30 Sep 2022 02:36:43 +0300
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
Subject: [PATCH RESEND v3 17/18] EDAC/synopsys: Add system address regions support
Date:   Fri, 30 Sep 2022 02:35:29 +0300
Message-ID: <20220929233530.13016-18-Sergey.Semin@baikalelectronics.ru>
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

Aside with the Application, HIF and SDRAM address spaces DW uMCTL2 DDR
controller supports one more level of the address abstraction. It's the
System Address Regions (SARs). By default SARs are disabled by means of
the IP-core synthesize parameter UMCTL2_A_NSAR being set to zero. In that
case the System and Application address spaces match. But if that
parameter is set to non-zero value (but less than or equal to 4), then
it's possible to define the selected number of the disjoint memory regions
mapping to the SDRAM as consecutive addresses. So if the SARs are
available on the particular DW uMCTL2 DDR controller, they need to be
taken into account in order to get a correct Physical/DMA address by the
SDRAM address and vice-versa.

The SAR/Application address mapping support is implemented in the similar
way as it has been done for the HIF/SDRAM address translation. First we
get to read the mapping from the SARBASEn and SARSIZEn CSRs and save it in
the System/Application address mapping table as the regions base address,
size and offset. Second the detected mapping table is utilized to
translate the system addresses to the application addresses and vice-versa
in the framework of the sys-to-SDRAM and SDRAM-to-sys address translation
chain. Thus the implemented functionality is integrated into the code,
which requires to translate the addresses: ECC errors detection and ECC
data poisoning.

Note aside with the number of SARs there is the aUMCTL2_SARMINSIZE IP-core
parameter which indicates the SARs minimal block size. Alas it isn't
auto-detectable, but it's critical to have a correct mapping table. So
the suggested functionality expects it being specified for each particular
controller otherwise the system address regions support will be forcibly
disabled in the driver.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/edac/synopsys_edac.c | 191 ++++++++++++++++++++++++++++++++++-
 1 file changed, 188 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 946b86149ff8..84bede647947 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -15,6 +15,7 @@
 #include <linux/pfn.h>
 #include <linux/platform_device.h>
 #include <linux/seq_file.h>
+#include <linux/sizes.h>
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <linux/of.h>
@@ -92,6 +93,10 @@
 #define ECC_POISONPAT1_OFST		0x380
 #define ECC_POISONPAT2_OFST		0x384
 
+/* DDR SAR0 registers */
+#define DDR_SARBASE0_OFST		0xF04
+#define DDR_SARSIZE0_OFST		0xF08
+
 /* DDR Master Register 0 definitions */
 #define DDR_MSTR_DEV_CFG_MASK		GENMASK(31, 30)
 #define DDR_MSTR_DEV_X4			0x0
@@ -223,6 +228,10 @@
 #define RANK_B0_BASE			6
 #define RANK_B1_BASE			7
 
+/* DDRC system address parameters */
+#define DDR_MAX_NSAR			4
+#define DDR_MIN_SARSIZE			SZ_256M
+
 /**
  * enum snps_dq_width - SDRAM DQ bus width (ECC capable).
  * SNPS_DQ_32:	32-bit memory data width.
@@ -308,6 +317,24 @@ struct snps_ddrc_info {
 	unsigned int ranks;
 };
 
+/**
+ * struct snps_sys_app_map - System/Application mapping table.
+ * @nsar:	Number of SARs enabled on the controller (max 4).
+ * @minsize:	Minimal block size (from 256MB to 32GB).
+ * @sar.base:	SAR base address aligned to minsize.
+ * @sar.size:	SAR size aligned to minsize.
+ * @sar.ofst:	SAR address offset.
+ */
+struct snps_sys_app_map {
+	u8 nsar;
+	u64 minsize;
+	struct {
+		u64 base;
+		u64 size;
+		u64 ofst;
+	} sar[DDR_MAX_NSAR];
+};
+
 /**
  * struct snps_hif_sdram_map - HIF/SDRAM mapping table.
  * @row:	HIF bit offsets used as row address bits.
@@ -374,6 +401,7 @@ struct snps_ecc_status {
 /**
  * struct snps_edac_priv - DDR memory controller private data.
  * @info:		DDR controller config info.
+ * @sys_app_map:	Sys/App mapping table.
  * @hif_sdram_map:	HIF/SDRAM mapping table.
  * @pdev:		Platform device.
  * @baseaddr:		Base address of the DDR controller.
@@ -384,6 +412,7 @@ struct snps_ecc_status {
  */
 struct snps_edac_priv {
 	struct snps_ddrc_info info;
+	struct snps_sys_app_map sys_app_map;
 	struct snps_hif_sdram_map hif_sdram_map;
 	struct platform_device *pdev;
 	void __iomem *baseaddr;
@@ -395,6 +424,77 @@ struct snps_edac_priv {
 #endif
 };
 
+/**
+ * snps_map_sys_to_app - Map System address to Application address.
+ * @priv:	DDR memory controller private instance data.
+ * @sys:	System address (source).
+ * @app:	Application address (destination).
+ *
+ * System address space is used to define disjoint memory regions
+ * mapped then to the contiguous application memory space:
+ *
+ *  System Address Space (SAR) <-> Application Address Space
+ *        +------+                        +------+
+ *        | SAR0 |----------------------->| Reg0 |
+ *        +------+       -offset          +------+
+ *        | ...  |           +----------->| Reg1 |
+ *        +------+           |            +------+
+ *        | SAR1 |-----------+            | ...  |
+ *        +------+
+ *        | ...  |
+ *
+ * The translation is done by applying the corresponding SAR offset
+ * to the inbound system address. Note according to the hardware reference
+ * manual the same mapping is applied to the addresses up to the next
+ * SAR base address irrespective to the region size.
+ */
+static void snps_map_sys_to_app(struct snps_edac_priv *priv,
+				dma_addr_t sys, u64 *app)
+{
+	struct snps_sys_app_map *map = &priv->sys_app_map;
+	u64 ofst;
+	int i;
+
+	ofst = 0;
+	for (i = 0; i < map->nsar; i++) {
+		if (sys < map->sar[i].base)
+			break;
+
+		ofst = map->sar[i].ofst;
+	}
+
+	*app = sys - ofst;
+}
+
+/**
+ * snps_map_sys_to_app - Map Application address to System address.
+ * @priv:	DDR memory controller private instance data.
+ * @app:	Application address (source).
+ * @sys:	System address (destination).
+ *
+ * Backward App-to-sys translation is easier because the application address
+ * space is contiguous. So we just need to add the offset corresponding
+ * to the region the passed address belongs to. Note the later offset is applied
+ * to all the addresses above the last available region.
+ */
+static void snps_map_app_to_sys(struct snps_edac_priv *priv,
+				u64 app, dma_addr_t *sys)
+{
+	struct snps_sys_app_map *map = &priv->sys_app_map;
+	u64 ofst, size;
+	int i;
+
+	ofst = 0;
+	for (i = 0, size = 0; i < map->nsar; i++) {
+		ofst = map->sar[i].ofst;
+		size += map->sar[i].size;
+		if (app < size)
+			break;
+	}
+
+	*sys = app + ofst;
+}
+
 /**
  * snps_map_app_to_hif - Map Application address to HIF address.
  * @priv:	DDR memory controller private instance data.
@@ -543,7 +643,7 @@ static void snps_map_sys_to_sdram(struct snps_edac_priv *priv,
 {
 	u64 app, hif;
 
-	app = sys;
+	snps_map_sys_to_app(priv, sys, &app);
 
 	snps_map_app_to_hif(priv, app, &hif);
 
@@ -568,7 +668,7 @@ static void snps_map_sdram_to_sys(struct snps_edac_priv *priv,
 
 	snps_map_hif_to_app(priv, hif, &app);
 
-	*sys = app;
+	snps_map_app_to_sys(priv, app, sys);
 }
 
 /**
@@ -971,6 +1071,52 @@ static int snps_get_ddrc_info(struct snps_edac_priv *priv)
 	return init_plat ? init_plat(priv) : 0;
 }
 
+/**
+ * snps_get_sys_app_map - Get System/Application address map.
+ * @priv:	DDR memory controller private instance data.
+ * @sarregs:	Array with SAR registers value.
+ *
+ * System address regions are defined by the SARBASEn and SARSIZEn registers.
+ * Controller reference manual requires the base addresses and sizes creating
+ * a set of ascending non-overlapped regions in order to have a linear
+ * application address space. Doing otherwise causes unpredictable results.
+ */
+static void snps_get_sys_app_map(struct snps_edac_priv *priv, u32 *sarregs)
+{
+	struct snps_sys_app_map *map = &priv->sys_app_map;
+	int i, ofst;
+
+	/*
+	 * SARs are supposed to be initialized in the ascending non-overlapped
+	 * order: base[i - 1] < base[i] < etc. If that rule is broken for a SAR
+	 * it's considered as no more SARs have been enabled, so the detection
+	 * procedure will halt. Having the very first SAR with zero base
+	 * address only makes sense if there is a consequent SAR.
+	 */
+	for (i = 0, ofst = 0; i < DDR_MAX_NSAR; i++) {
+		map->sar[i].base = sarregs[2 * i] * map->minsize;
+		if (map->sar[i].base)
+			map->nsar = i + 1;
+		else if (i && map->sar[i].base <= map->sar[i - 1].base)
+			break;
+
+		map->sar[i].size = (sarregs[2 * i + 1] + 1) * map->minsize;
+		map->sar[i].ofst = map->sar[i].base - ofst;
+		ofst += map->sar[i].size;
+	}
+
+	/*
+	 * SAR block size isn't auto-detectable. If one isn't specified for the
+	 * platform there is a good chance to have invalid mapping of the
+	 * detected SARs. So proceed with 1:1 mapping then.
+	 */
+	if (!map->minsize && map->nsar) {
+		edac_printk(KERN_WARNING, EDAC_MC,
+			    "No block size specified. Discard SARs mapping\n");
+		map->nsar = 0;
+	}
+}
+
 /**
  * snps_get_hif_row_map - Get HIF/SDRAM-row address map.
  * @priv:	DDR memory controller private instance data.
@@ -1220,9 +1366,14 @@ static void snps_get_hif_rank_map(struct snps_edac_priv *priv, u32 *addrmap)
  */
 static void snps_get_addr_map(struct snps_edac_priv *priv)
 {
-	u32 regval[DDR_ADDRMAP_NREGS];
+	u32 regval[max(DDR_ADDRMAP_NREGS, 2 * DDR_MAX_NSAR)];
 	int i;
 
+	for (i = 0; i < 2 * DDR_MAX_NSAR; i++)
+		regval[i] = readl(priv->baseaddr + DDR_SARBASE0_OFST + i * 4);
+
+	snps_get_sys_app_map(priv, regval);
+
 	for (i = 0; i < DDR_ADDRMAP_NREGS; i++)
 		regval[i] = readl(priv->baseaddr + DDR_ADDRMAP0_OFST + i * 4);
 
@@ -1413,6 +1564,37 @@ static int snps_ddrc_info_show(struct seq_file *s, void *data)
 
 DEFINE_SHOW_ATTRIBUTE(snps_ddrc_info);
 
+static int snps_sys_app_map_show(struct seq_file *s, void *data)
+{
+	struct mem_ctl_info *mci = s->private;
+	struct snps_edac_priv *priv = mci->pvt_info;
+	struct snps_sys_app_map *map = &priv->sys_app_map;
+	u64 size;
+	int i;
+
+	if (!map->nsar) {
+		seq_puts(s, "No SARs detected\n");
+		return 0;
+	}
+
+	seq_printf(s, "%9s %-37s %-18s %-37s\n",
+		   "", "System address", "Offset", "App address");
+
+	for (i = 0, size = 0; i < map->nsar; i++) {
+		seq_printf(s, "Region %d: ", i);
+		seq_printf(s, "0x%016llx-0x%016llx ", map->sar[i].base,
+			   map->sar[i].base + map->sar[i].size - 1);
+		seq_printf(s, "0x%016llx ", map->sar[i].ofst);
+		seq_printf(s, "0x%016llx-0x%016llx\n", size,
+			   size + map->sar[i].size - 1);
+		size += map->sar[i].size;
+	}
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(snps_sys_app_map);
+
 static u8 snps_find_sdram_dim(struct snps_edac_priv *priv, u8 hif, char *dim)
 {
 	struct snps_hif_sdram_map *map = &priv->hif_sdram_map;
@@ -1610,6 +1792,9 @@ static void snps_create_debugfs_nodes(struct mem_ctl_info *mci)
 	edac_debugfs_create_file("ddrc_info", 0400, mci->debugfs, mci,
 				 &snps_ddrc_info_fops);
 
+	edac_debugfs_create_file("sys_app_map", 0400, mci->debugfs, mci,
+				 &snps_sys_app_map_fops);
+
 	edac_debugfs_create_file("hif_sdram_map", 0400, mci->debugfs, mci,
 				 &snps_hif_sdram_map_fops);
 
-- 
2.37.3


