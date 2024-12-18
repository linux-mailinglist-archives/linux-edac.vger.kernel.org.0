Return-Path: <linux-edac+bounces-2736-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE1F9F6430
	for <lists+linux-edac@lfdr.de>; Wed, 18 Dec 2024 11:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BCAC163AF4
	for <lists+linux-edac@lfdr.de>; Wed, 18 Dec 2024 10:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E1019E806;
	Wed, 18 Dec 2024 10:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="G89mkHv1"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778D019ABA3
	for <linux-edac@vger.kernel.org>; Wed, 18 Dec 2024 10:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734519348; cv=none; b=cZ2R6mmlsRA+HLxHo94cRtWoISlP0krsfBODzPoR+TJ4qgWhd/wrJscbQnBJTI8FixEzWP5yH8EnrYbcGXK61aR4XtiKOOFLQ5pMpsvbQeGNo5GgODSMIpZsrLDsfLV0dxJx/xC1utcV7xQnDgfUwKbIdlRovqJ0FvW3LUvPrgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734519348; c=relaxed/simple;
	bh=7LgGIrN5Jf4wacIHgchhVFcn8Sdm5s8Avs/xKd0EgzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g8Dw/ebIBPIUe53+og6wdg3nMXXDXyxn8InNyTHtoL8GQR+F/tt7l6DNsNjcFM6edEN389E9GfYLkdHdqy1pjitsyaDVIgSR8ghB4JOv/X/7h81VLhRFTNjpBIGcH7b263yOgzw3hc4cgapK9NpDC+f/x63usZbLni7s+5ZDKyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=G89mkHv1; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1734519337;
	bh=Eq6gua8Dj6zc9FayHosBZJTleTGFwuxWgRUbrXp9WMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G89mkHv1LuhfnrREZy6z4Udr4dxCM4FpDNjSTxvyR6NgNMnf+SmSLKOm6PqHI5b4I
	 B2Df52gM4kaQkN6l7ehM62AX2zQXydoT2KGnMWHmS/FiHi1qUROpe9GADI8CFANgV/
	 MVlR44NiuceVUyh81b+YbNrxr7/FM78JCyKoK4qL+uwIW5mm6ZttIluF+f3ylM1BQl
	 wEipSAP22mPuIxegoCeixUxaEe/BYsTpXohJ0iKm1Hum7qFkhyueEE1VGFvG2AW9Hj
	 hgGG92/FWLKY6DeDCRNayvogL1ylWuyjEoZfhGwUfykNVK43E73XZClEZS75p/nvih
	 3YbBNcKQMp8lA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4YCrF52D5fz4xfg;
	Wed, 18 Dec 2024 21:55:37 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@lists.ozlabs.org>
Cc: <arnd@arndb.de>,
	<jk@ozlabs.org>,
	<segher@kernel.crashing.org>,
	linux-edac@vger.kernel.org
Subject: [PATCH v2 23/25] EDAC/cell: Remove powerpc Cell driver
Date: Wed, 18 Dec 2024 21:55:11 +1100
Message-ID: <20241218105523.416573-23-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218105523.416573-1-mpe@ellerman.id.au>
References: <20241218105523.416573-1-mpe@ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver can no longer be built since support for IBM Cell Blades was
removed, in particular PPC_CELL_COMMON.

Remove the driver.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
v2: Rebase.

Cc: linux-edac@vger.kernel.org

 drivers/edac/Kconfig     |   8 --
 drivers/edac/Makefile    |   2 -
 drivers/edac/cell_edac.c | 281 ---------------------------------------
 3 files changed, 291 deletions(-)
 delete mode 100644 drivers/edac/cell_edac.c

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 06f7b43a6f78..766378ceecc6 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -303,14 +303,6 @@ config EDAC_PASEMI
 	  Support for error detection and correction on PA Semi
 	  PWRficient.
 
-config EDAC_CELL
-	tristate "Cell Broadband Engine memory controller"
-	depends on PPC_CELL_COMMON
-	help
-	  Support for error detection and correction on the
-	  Cell Broadband Engine internal memory controller
-	  on platform without a hypervisor
-
 config EDAC_CPC925
 	tristate "IBM CPC925 Memory Controller (PPC970FX)"
 	depends on PPC64
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index f9cf19d8d13d..a45a913b0270 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -62,8 +62,6 @@ obj-$(CONFIG_EDAC_SKX)			+= skx_edac.o skx_edac_common.o
 i10nm_edac-y				:= i10nm_base.o
 obj-$(CONFIG_EDAC_I10NM)		+= i10nm_edac.o skx_edac_common.o
 
-obj-$(CONFIG_EDAC_CELL)			+= cell_edac.o
-
 obj-$(CONFIG_EDAC_HIGHBANK_MC)		+= highbank_mc_edac.o
 obj-$(CONFIG_EDAC_HIGHBANK_L2)		+= highbank_l2_edac.o
 
diff --git a/drivers/edac/cell_edac.c b/drivers/edac/cell_edac.c
deleted file mode 100644
index c2420e2287ff..000000000000
--- a/drivers/edac/cell_edac.c
+++ /dev/null
@@ -1,281 +0,0 @@
-/*
- * Cell MIC driver for ECC counting
- *
- * Copyright 2007 Benjamin Herrenschmidt, IBM Corp.
- *                <benh@kernel.crashing.org>
- *
- * This file may be distributed under the terms of the
- * GNU General Public License.
- */
-#undef DEBUG
-
-#include <linux/edac.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/stop_machine.h>
-#include <linux/io.h>
-#include <linux/of_address.h>
-#include <asm/machdep.h>
-#include <asm/cell-regs.h>
-
-#include "edac_module.h"
-
-struct cell_edac_priv
-{
-	struct cbe_mic_tm_regs __iomem	*regs;
-	int				node;
-	int				chanmask;
-#ifdef DEBUG
-	u64				prev_fir;
-#endif
-};
-
-static void cell_edac_count_ce(struct mem_ctl_info *mci, int chan, u64 ar)
-{
-	struct cell_edac_priv		*priv = mci->pvt_info;
-	struct csrow_info		*csrow = mci->csrows[0];
-	unsigned long			address, pfn, offset, syndrome;
-
-	dev_dbg(mci->pdev, "ECC CE err on node %d, channel %d, ar = 0x%016llx\n",
-		priv->node, chan, ar);
-
-	/* Address decoding is likely a bit bogus, to dbl check */
-	address = (ar & 0xffffffffe0000000ul) >> 29;
-	if (priv->chanmask == 0x3)
-		address = (address << 1) | chan;
-	pfn = address >> PAGE_SHIFT;
-	offset = address & ~PAGE_MASK;
-	syndrome = (ar & 0x000000001fe00000ul) >> 21;
-
-	/* TODO: Decoding of the error address */
-	edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, 1,
-			     csrow->first_page + pfn, offset, syndrome,
-			     0, chan, -1, "", "");
-}
-
-static void cell_edac_count_ue(struct mem_ctl_info *mci, int chan, u64 ar)
-{
-	struct cell_edac_priv		*priv = mci->pvt_info;
-	struct csrow_info		*csrow = mci->csrows[0];
-	unsigned long			address, pfn, offset;
-
-	dev_dbg(mci->pdev, "ECC UE err on node %d, channel %d, ar = 0x%016llx\n",
-		priv->node, chan, ar);
-
-	/* Address decoding is likely a bit bogus, to dbl check */
-	address = (ar & 0xffffffffe0000000ul) >> 29;
-	if (priv->chanmask == 0x3)
-		address = (address << 1) | chan;
-	pfn = address >> PAGE_SHIFT;
-	offset = address & ~PAGE_MASK;
-
-	/* TODO: Decoding of the error address */
-	edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci, 1,
-			     csrow->first_page + pfn, offset, 0,
-			     0, chan, -1, "", "");
-}
-
-static void cell_edac_check(struct mem_ctl_info *mci)
-{
-	struct cell_edac_priv		*priv = mci->pvt_info;
-	u64				fir, addreg, clear = 0;
-
-	fir = in_be64(&priv->regs->mic_fir);
-#ifdef DEBUG
-	if (fir != priv->prev_fir) {
-		dev_dbg(mci->pdev, "fir change : 0x%016lx\n", fir);
-		priv->prev_fir = fir;
-	}
-#endif
-	if ((priv->chanmask & 0x1) && (fir & CBE_MIC_FIR_ECC_SINGLE_0_ERR)) {
-		addreg = in_be64(&priv->regs->mic_df_ecc_address_0);
-		clear |= CBE_MIC_FIR_ECC_SINGLE_0_RESET;
-		cell_edac_count_ce(mci, 0, addreg);
-	}
-	if ((priv->chanmask & 0x2) && (fir & CBE_MIC_FIR_ECC_SINGLE_1_ERR)) {
-		addreg = in_be64(&priv->regs->mic_df_ecc_address_1);
-		clear |= CBE_MIC_FIR_ECC_SINGLE_1_RESET;
-		cell_edac_count_ce(mci, 1, addreg);
-	}
-	if ((priv->chanmask & 0x1) && (fir & CBE_MIC_FIR_ECC_MULTI_0_ERR)) {
-		addreg = in_be64(&priv->regs->mic_df_ecc_address_0);
-		clear |= CBE_MIC_FIR_ECC_MULTI_0_RESET;
-		cell_edac_count_ue(mci, 0, addreg);
-	}
-	if ((priv->chanmask & 0x2) && (fir & CBE_MIC_FIR_ECC_MULTI_1_ERR)) {
-		addreg = in_be64(&priv->regs->mic_df_ecc_address_1);
-		clear |= CBE_MIC_FIR_ECC_MULTI_1_RESET;
-		cell_edac_count_ue(mci, 1, addreg);
-	}
-
-	/* The procedure for clearing FIR bits is a bit ... weird */
-	if (clear) {
-		fir &= ~(CBE_MIC_FIR_ECC_ERR_MASK | CBE_MIC_FIR_ECC_SET_MASK);
-		fir |= CBE_MIC_FIR_ECC_RESET_MASK;
-		fir &= ~clear;
-		out_be64(&priv->regs->mic_fir, fir);
-		(void)in_be64(&priv->regs->mic_fir);
-
-		mb();	/* sync up */
-#ifdef DEBUG
-		fir = in_be64(&priv->regs->mic_fir);
-		dev_dbg(mci->pdev, "fir clear  : 0x%016lx\n", fir);
-#endif
-	}
-}
-
-static void cell_edac_init_csrows(struct mem_ctl_info *mci)
-{
-	struct csrow_info		*csrow = mci->csrows[0];
-	struct dimm_info		*dimm;
-	struct cell_edac_priv		*priv = mci->pvt_info;
-	struct device_node		*np;
-	int				j;
-	u32				nr_pages;
-
-	for_each_node_by_name(np, "memory") {
-		struct resource r;
-
-		/* We "know" that the Cell firmware only creates one entry
-		 * in the "memory" nodes. If that changes, this code will
-		 * need to be adapted.
-		 */
-		if (of_address_to_resource(np, 0, &r))
-			continue;
-		if (of_node_to_nid(np) != priv->node)
-			continue;
-		csrow->first_page = r.start >> PAGE_SHIFT;
-		nr_pages = resource_size(&r) >> PAGE_SHIFT;
-		csrow->last_page = csrow->first_page + nr_pages - 1;
-
-		for (j = 0; j < csrow->nr_channels; j++) {
-			dimm = csrow->channels[j]->dimm;
-			dimm->mtype = MEM_XDR;
-			dimm->edac_mode = EDAC_SECDED;
-			dimm->nr_pages = nr_pages / csrow->nr_channels;
-		}
-		dev_dbg(mci->pdev,
-			"Initialized on node %d, chanmask=0x%x,"
-			" first_page=0x%lx, nr_pages=0x%x\n",
-			priv->node, priv->chanmask,
-			csrow->first_page, nr_pages);
-		break;
-	}
-	of_node_put(np);
-}
-
-static int cell_edac_probe(struct platform_device *pdev)
-{
-	struct cbe_mic_tm_regs __iomem	*regs;
-	struct mem_ctl_info		*mci;
-	struct edac_mc_layer		layers[2];
-	struct cell_edac_priv		*priv;
-	u64				reg;
-	int				rc, chanmask, num_chans;
-
-	regs = cbe_get_cpu_mic_tm_regs(cbe_node_to_cpu(pdev->id));
-	if (regs == NULL)
-		return -ENODEV;
-
-	edac_op_state = EDAC_OPSTATE_POLL;
-
-	/* Get channel population */
-	reg = in_be64(&regs->mic_mnt_cfg);
-	dev_dbg(&pdev->dev, "MIC_MNT_CFG = 0x%016llx\n", reg);
-	chanmask = 0;
-	if (reg & CBE_MIC_MNT_CFG_CHAN_0_POP)
-		chanmask |= 0x1;
-	if (reg & CBE_MIC_MNT_CFG_CHAN_1_POP)
-		chanmask |= 0x2;
-	if (chanmask == 0) {
-		dev_warn(&pdev->dev,
-			 "Yuck ! No channel populated ? Aborting !\n");
-		return -ENODEV;
-	}
-	dev_dbg(&pdev->dev, "Initial FIR = 0x%016llx\n",
-		in_be64(&regs->mic_fir));
-
-	/* Allocate & init EDAC MC data structure */
-	num_chans = chanmask == 3 ? 2 : 1;
-
-	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
-	layers[0].size = 1;
-	layers[0].is_virt_csrow = true;
-	layers[1].type = EDAC_MC_LAYER_CHANNEL;
-	layers[1].size = num_chans;
-	layers[1].is_virt_csrow = false;
-	mci = edac_mc_alloc(pdev->id, ARRAY_SIZE(layers), layers,
-			    sizeof(struct cell_edac_priv));
-	if (mci == NULL)
-		return -ENOMEM;
-	priv = mci->pvt_info;
-	priv->regs = regs;
-	priv->node = pdev->id;
-	priv->chanmask = chanmask;
-	mci->pdev = &pdev->dev;
-	mci->mtype_cap = MEM_FLAG_XDR;
-	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_EC | EDAC_FLAG_SECDED;
-	mci->edac_cap = EDAC_FLAG_EC | EDAC_FLAG_SECDED;
-	mci->mod_name = "cell_edac";
-	mci->ctl_name = "MIC";
-	mci->dev_name = dev_name(&pdev->dev);
-	mci->edac_check = cell_edac_check;
-	cell_edac_init_csrows(mci);
-
-	/* Register with EDAC core */
-	rc = edac_mc_add_mc(mci);
-	if (rc) {
-		dev_err(&pdev->dev, "failed to register with EDAC core\n");
-		edac_mc_free(mci);
-		return rc;
-	}
-
-	return 0;
-}
-
-static void cell_edac_remove(struct platform_device *pdev)
-{
-	struct mem_ctl_info *mci = edac_mc_del_mc(&pdev->dev);
-	if (mci)
-		edac_mc_free(mci);
-}
-
-static struct platform_driver cell_edac_driver = {
-	.driver		= {
-		.name	= "cbe-mic",
-	},
-	.probe		= cell_edac_probe,
-	.remove		= cell_edac_remove,
-};
-
-static int __init cell_edac_init(void)
-{
-	/* Sanity check registers data structure */
-	BUILD_BUG_ON(offsetof(struct cbe_mic_tm_regs,
-			      mic_df_ecc_address_0) != 0xf8);
-	BUILD_BUG_ON(offsetof(struct cbe_mic_tm_regs,
-			      mic_df_ecc_address_1) != 0x1b8);
-	BUILD_BUG_ON(offsetof(struct cbe_mic_tm_regs,
-			      mic_df_config) != 0x218);
-	BUILD_BUG_ON(offsetof(struct cbe_mic_tm_regs,
-			      mic_fir) != 0x230);
-	BUILD_BUG_ON(offsetof(struct cbe_mic_tm_regs,
-			      mic_mnt_cfg) != 0x210);
-	BUILD_BUG_ON(offsetof(struct cbe_mic_tm_regs,
-			      mic_exc) != 0x208);
-
-	return platform_driver_register(&cell_edac_driver);
-}
-
-static void __exit cell_edac_exit(void)
-{
-	platform_driver_unregister(&cell_edac_driver);
-}
-
-module_init(cell_edac_init);
-module_exit(cell_edac_exit);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Benjamin Herrenschmidt <benh@kernel.crashing.org>");
-MODULE_DESCRIPTION("ECC counting for Cell MIC");
-- 
2.47.1


