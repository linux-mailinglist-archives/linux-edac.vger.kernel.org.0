Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED2E45A696
	for <lists+linux-edac@lfdr.de>; Tue, 23 Nov 2021 16:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbhKWPkc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 23 Nov 2021 10:40:32 -0500
Received: from mail5.windriver.com ([192.103.53.11]:49428 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231344AbhKWPkb (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 23 Nov 2021 10:40:31 -0500
X-Greylist: delayed 1796 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Nov 2021 10:40:31 EST
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com [147.11.82.252])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 1ANF72Th012478
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Nov 2021 07:07:02 -0800
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 23 Nov 2021 07:07:00 -0800
Received: from yow-cube1.wrs.com (128.224.56.98) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2242.12 via Frontend Transport; Tue, 23 Nov 2021 07:06:59 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <linux-edac@vger.kernel.org>
CC:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        Tim Small <tim@buttersideup.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Douglas Thompson <dougthompson@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] EDAC/443bxgx: drop never enabled driver marked as broken for 14 years.
Date:   Tue, 23 Nov 2021 10:06:46 -0500
Message-ID: <20211123150646.47676-1-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

In commit 28f96eeafc89 ("drivers/edac-new-i82443bxgz-mc-driver: mark
as broken") this driver got added "depends on BROKEN", indicating:

   It will claim the PCI devices from under intel_agp.ko's feet.
   Greg is brewing some fix for that.

That was 14 years ago.  It is safe to say that 99.9% of the original
440BX/GX chipset systems have long been retired anyway.  So there is no
point in carrying around this driver any longer and making tree wide
changes to it.

In fact, the driver was added in v2.6.23-rc1~321 and then marked broken
in the following commit above - v2.6.23-rc1~320 and hence was never ever
enabled in mainline to begin with.

Cc: Borislav Petkov <bp@suse.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Tim Small <tim@buttersideup.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Douglas Thompson <dougthompson@xmission.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index ab0d25f01ee3..c5e72e770aab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6882,12 +6882,6 @@ L:	linux-edac@vger.kernel.org
 S:	Maintained
 F:	drivers/edac/i7core_edac.c
 
-EDAC-I82443BXGX
-M:	Tim Small <tim@buttersideup.com>
-L:	linux-edac@vger.kernel.org
-S:	Maintained
-F:	drivers/edac/i82443bxgx_edac.c
-
 EDAC-I82975X
 M:	"Arvind R." <arvino55@gmail.com>
 L:	linux-edac@vger.kernel.org
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 58ab63642e72..46b413a82ee4 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -127,14 +127,6 @@ config EDAC_E752X
 	  Support for error detection and correction on the Intel
 	  E7520, E7525, E7320 server chipsets.
 
-config EDAC_I82443BXGX
-	tristate "Intel 82443BX/GX (440BX/GX)"
-	depends on PCI && X86_32
-	depends on BROKEN
-	help
-	  Support for error detection and correction on the Intel
-	  82443BX/GX memory controllers (440BX/GX chipsets).
-
 config EDAC_I82875P
 	tristate "Intel 82875p (D82875P, E7210)"
 	depends on PCI && X86_32
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 2d1641a27a28..0f7c63e38d75 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -35,7 +35,6 @@ obj-$(CONFIG_EDAC_PND2)			+= pnd2_edac.o
 obj-$(CONFIG_EDAC_IGEN6)			+= igen6_edac.o
 obj-$(CONFIG_EDAC_E7XXX)		+= e7xxx_edac.o
 obj-$(CONFIG_EDAC_E752X)		+= e752x_edac.o
-obj-$(CONFIG_EDAC_I82443BXGX)		+= i82443bxgx_edac.o
 obj-$(CONFIG_EDAC_I82875P)		+= i82875p_edac.o
 obj-$(CONFIG_EDAC_I82975X)		+= i82975x_edac.o
 obj-$(CONFIG_EDAC_I3000)		+= i3000_edac.o
diff --git a/drivers/edac/i82443bxgx_edac.c b/drivers/edac/i82443bxgx_edac.c
deleted file mode 100644
index 933dcf3cfdff..000000000000
--- a/drivers/edac/i82443bxgx_edac.c
+++ /dev/null
@@ -1,462 +0,0 @@
-/*
- * Intel 82443BX/GX (440BX/GX chipset) Memory Controller EDAC kernel
- * module (C) 2006 Tim Small
- *
- * This file may be distributed under the terms of the GNU General
- * Public License.
- *
- * Written by Tim Small <tim@buttersideup.com>, based on work by Linux
- * Networx, Thayne Harbaugh, Dan Hollis <goemon at anime dot net> and
- * others.
- *
- * 440GX fix by Jason Uhlenkott <juhlenko@akamai.com>.
- *
- * Written with reference to 82443BX Host Bridge Datasheet:
- * http://download.intel.com/design/chipsets/datashts/29063301.pdf
- * references to this document given in [].
- *
- * This module doesn't support the 440LX, but it may be possible to
- * make it do so (the 440LX's register definitions are different, but
- * not completely so - I haven't studied them in enough detail to know
- * how easy this would be).
- */
-
-#include <linux/module.h>
-#include <linux/init.h>
-
-#include <linux/pci.h>
-#include <linux/pci_ids.h>
-
-
-#include <linux/edac.h>
-#include "edac_module.h"
-
-#define EDAC_MOD_STR    "i82443bxgx_edac"
-
-/* The 82443BX supports SDRAM, or EDO (EDO for mobile only), "Memory
- * Size: 8 MB to 512 MB (1GB with Registered DIMMs) with eight memory
- * rows" "The 82443BX supports multiple-bit error detection and
- * single-bit error correction when ECC mode is enabled and
- * single/multi-bit error detection when correction is disabled.
- * During writes to the DRAM, the 82443BX generates ECC for the data
- * on a QWord basis. Partial QWord writes require a read-modify-write
- * cycle when ECC is enabled."
-*/
-
-/* "Additionally, the 82443BX ensures that the data is corrected in
- * main memory so that accumulation of errors is prevented. Another
- * error within the same QWord would result in a double-bit error
- * which is unrecoverable. This is known as hardware scrubbing since
- * it requires no software intervention to correct the data in memory."
- */
-
-/* [Also see page 100 (section 4.3), "DRAM Interface"]
- * [Also see page 112 (section 4.6.1.4), ECC]
- */
-
-#define I82443BXGX_NR_CSROWS 8
-#define I82443BXGX_NR_CHANS  1
-#define I82443BXGX_NR_DIMMS  4
-
-/* 82443 PCI Device 0 */
-#define I82443BXGX_NBXCFG 0x50	/* 32bit register starting at this PCI
-				 * config space offset */
-#define I82443BXGX_NBXCFG_OFFSET_NON_ECCROW 24	/* Array of bits, zero if
-						 * row is non-ECC */
-#define I82443BXGX_NBXCFG_OFFSET_DRAM_FREQ 12	/* 2 bits,00=100MHz,10=66 MHz */
-
-#define I82443BXGX_NBXCFG_OFFSET_DRAM_INTEGRITY 7	/* 2 bits:       */
-#define I82443BXGX_NBXCFG_INTEGRITY_NONE   0x0	/* 00 = Non-ECC */
-#define I82443BXGX_NBXCFG_INTEGRITY_EC     0x1	/* 01 = EC (only) */
-#define I82443BXGX_NBXCFG_INTEGRITY_ECC    0x2	/* 10 = ECC */
-#define I82443BXGX_NBXCFG_INTEGRITY_SCRUB  0x3	/* 11 = ECC + HW Scrub */
-
-#define I82443BXGX_NBXCFG_OFFSET_ECC_DIAG_ENABLE  6
-
-/* 82443 PCI Device 0 */
-#define I82443BXGX_EAP   0x80	/* 32bit register starting at this PCI
-				 * config space offset, Error Address
-				 * Pointer Register */
-#define I82443BXGX_EAP_OFFSET_EAP  12	/* High 20 bits of error address */
-#define I82443BXGX_EAP_OFFSET_MBE  BIT(1)	/* Err at EAP was multi-bit (W1TC) */
-#define I82443BXGX_EAP_OFFSET_SBE  BIT(0)	/* Err at EAP was single-bit (W1TC) */
-
-#define I82443BXGX_ERRCMD  0x90	/* 8bit register starting at this PCI
-				 * config space offset. */
-#define I82443BXGX_ERRCMD_OFFSET_SERR_ON_MBE BIT(1)	/* 1 = enable */
-#define I82443BXGX_ERRCMD_OFFSET_SERR_ON_SBE BIT(0)	/* 1 = enable */
-
-#define I82443BXGX_ERRSTS  0x91	/* 16bit register starting at this PCI
-				 * config space offset. */
-#define I82443BXGX_ERRSTS_OFFSET_MBFRE 5	/* 3 bits - first err row multibit */
-#define I82443BXGX_ERRSTS_OFFSET_MEF   BIT(4)	/* 1 = MBE occurred */
-#define I82443BXGX_ERRSTS_OFFSET_SBFRE 1	/* 3 bits - first err row singlebit */
-#define I82443BXGX_ERRSTS_OFFSET_SEF   BIT(0)	/* 1 = SBE occurred */
-
-#define I82443BXGX_DRAMC 0x57	/* 8bit register starting at this PCI
-				 * config space offset. */
-#define I82443BXGX_DRAMC_OFFSET_DT 3	/* 2 bits, DRAM Type */
-#define I82443BXGX_DRAMC_DRAM_IS_EDO 0	/* 00 = EDO */
-#define I82443BXGX_DRAMC_DRAM_IS_SDRAM 1	/* 01 = SDRAM */
-#define I82443BXGX_DRAMC_DRAM_IS_RSDRAM 2	/* 10 = Registered SDRAM */
-
-#define I82443BXGX_DRB 0x60	/* 8x 8bit registers starting at this PCI
-				 * config space offset. */
-
-/* FIXME - don't poll when ECC disabled? */
-
-struct i82443bxgx_edacmc_error_info {
-	u32 eap;
-};
-
-static struct edac_pci_ctl_info *i82443bxgx_pci;
-
-static struct pci_dev *mci_pdev;	/* init dev: in case that AGP code has
-					 * already registered driver
-					 */
-
-static int i82443bxgx_registered = 1;
-
-static void i82443bxgx_edacmc_get_error_info(struct mem_ctl_info *mci,
-				struct i82443bxgx_edacmc_error_info
-				*info)
-{
-	struct pci_dev *pdev;
-	pdev = to_pci_dev(mci->pdev);
-	pci_read_config_dword(pdev, I82443BXGX_EAP, &info->eap);
-	if (info->eap & I82443BXGX_EAP_OFFSET_SBE)
-		/* Clear error to allow next error to be reported [p.61] */
-		pci_write_bits32(pdev, I82443BXGX_EAP,
-				 I82443BXGX_EAP_OFFSET_SBE,
-				 I82443BXGX_EAP_OFFSET_SBE);
-
-	if (info->eap & I82443BXGX_EAP_OFFSET_MBE)
-		/* Clear error to allow next error to be reported [p.61] */
-		pci_write_bits32(pdev, I82443BXGX_EAP,
-				 I82443BXGX_EAP_OFFSET_MBE,
-				 I82443BXGX_EAP_OFFSET_MBE);
-}
-
-static int i82443bxgx_edacmc_process_error_info(struct mem_ctl_info *mci,
-						struct
-						i82443bxgx_edacmc_error_info
-						*info, int handle_errors)
-{
-	int error_found = 0;
-	u32 eapaddr, page, pageoffset;
-
-	/* bits 30:12 hold the 4kb block in which the error occurred
-	 * [p.61] */
-	eapaddr = (info->eap & 0xfffff000);
-	page = eapaddr >> PAGE_SHIFT;
-	pageoffset = eapaddr - (page << PAGE_SHIFT);
-
-	if (info->eap & I82443BXGX_EAP_OFFSET_SBE) {
-		error_found = 1;
-		if (handle_errors)
-			edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, 1,
-					     page, pageoffset, 0,
-					     edac_mc_find_csrow_by_page(mci, page),
-					     0, -1, mci->ctl_name, "");
-	}
-
-	if (info->eap & I82443BXGX_EAP_OFFSET_MBE) {
-		error_found = 1;
-		if (handle_errors)
-			edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci, 1,
-					     page, pageoffset, 0,
-					     edac_mc_find_csrow_by_page(mci, page),
-					     0, -1, mci->ctl_name, "");
-	}
-
-	return error_found;
-}
-
-static void i82443bxgx_edacmc_check(struct mem_ctl_info *mci)
-{
-	struct i82443bxgx_edacmc_error_info info;
-
-	i82443bxgx_edacmc_get_error_info(mci, &info);
-	i82443bxgx_edacmc_process_error_info(mci, &info, 1);
-}
-
-static void i82443bxgx_init_csrows(struct mem_ctl_info *mci,
-				struct pci_dev *pdev,
-				enum edac_type edac_mode,
-				enum mem_type mtype)
-{
-	struct csrow_info *csrow;
-	struct dimm_info *dimm;
-	int index;
-	u8 drbar, dramc;
-	u32 row_base, row_high_limit, row_high_limit_last;
-
-	pci_read_config_byte(pdev, I82443BXGX_DRAMC, &dramc);
-	row_high_limit_last = 0;
-	for (index = 0; index < mci->nr_csrows; index++) {
-		csrow = mci->csrows[index];
-		dimm = csrow->channels[0]->dimm;
-
-		pci_read_config_byte(pdev, I82443BXGX_DRB + index, &drbar);
-		edac_dbg(1, "MC%d: Row=%d DRB = %#0x\n",
-			 mci->mc_idx, index, drbar);
-		row_high_limit = ((u32) drbar << 23);
-		/* find the DRAM Chip Select Base address and mask */
-		edac_dbg(1, "MC%d: Row=%d, Boundary Address=%#0x, Last = %#0x\n",
-			 mci->mc_idx, index, row_high_limit,
-			 row_high_limit_last);
-
-		/* 440GX goes to 2GB, represented with a DRB of 0. */
-		if (row_high_limit_last && !row_high_limit)
-			row_high_limit = 1UL << 31;
-
-		/* This row is empty [p.49] */
-		if (row_high_limit == row_high_limit_last)
-			continue;
-		row_base = row_high_limit_last;
-		csrow->first_page = row_base >> PAGE_SHIFT;
-		csrow->last_page = (row_high_limit >> PAGE_SHIFT) - 1;
-		dimm->nr_pages = csrow->last_page - csrow->first_page + 1;
-		/* EAP reports in 4kilobyte granularity [61] */
-		dimm->grain = 1 << 12;
-		dimm->mtype = mtype;
-		/* I don't think 440BX can tell you device type? FIXME? */
-		dimm->dtype = DEV_UNKNOWN;
-		/* Mode is global to all rows on 440BX */
-		dimm->edac_mode = edac_mode;
-		row_high_limit_last = row_high_limit;
-	}
-}
-
-static int i82443bxgx_edacmc_probe1(struct pci_dev *pdev, int dev_idx)
-{
-	struct mem_ctl_info *mci;
-	struct edac_mc_layer layers[2];
-	u8 dramc;
-	u32 nbxcfg, ecc_mode;
-	enum mem_type mtype;
-	enum edac_type edac_mode;
-
-	edac_dbg(0, "MC:\n");
-
-	/* Something is really hosed if PCI config space reads from
-	 * the MC aren't working.
-	 */
-	if (pci_read_config_dword(pdev, I82443BXGX_NBXCFG, &nbxcfg))
-		return -EIO;
-
-	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
-	layers[0].size = I82443BXGX_NR_CSROWS;
-	layers[0].is_virt_csrow = true;
-	layers[1].type = EDAC_MC_LAYER_CHANNEL;
-	layers[1].size = I82443BXGX_NR_CHANS;
-	layers[1].is_virt_csrow = false;
-	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers, 0);
-	if (mci == NULL)
-		return -ENOMEM;
-
-	edac_dbg(0, "MC: mci = %p\n", mci);
-	mci->pdev = &pdev->dev;
-	mci->mtype_cap = MEM_FLAG_EDO | MEM_FLAG_SDR | MEM_FLAG_RDR;
-	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_EC | EDAC_FLAG_SECDED;
-	pci_read_config_byte(pdev, I82443BXGX_DRAMC, &dramc);
-	switch ((dramc >> I82443BXGX_DRAMC_OFFSET_DT) & (BIT(0) | BIT(1))) {
-	case I82443BXGX_DRAMC_DRAM_IS_EDO:
-		mtype = MEM_EDO;
-		break;
-	case I82443BXGX_DRAMC_DRAM_IS_SDRAM:
-		mtype = MEM_SDR;
-		break;
-	case I82443BXGX_DRAMC_DRAM_IS_RSDRAM:
-		mtype = MEM_RDR;
-		break;
-	default:
-		edac_dbg(0, "Unknown/reserved DRAM type value in DRAMC register!\n");
-		mtype = -MEM_UNKNOWN;
-	}
-
-	if ((mtype == MEM_SDR) || (mtype == MEM_RDR))
-		mci->edac_cap = mci->edac_ctl_cap;
-	else
-		mci->edac_cap = EDAC_FLAG_NONE;
-
-	mci->scrub_cap = SCRUB_FLAG_HW_SRC;
-	pci_read_config_dword(pdev, I82443BXGX_NBXCFG, &nbxcfg);
-	ecc_mode = ((nbxcfg >> I82443BXGX_NBXCFG_OFFSET_DRAM_INTEGRITY) &
-		(BIT(0) | BIT(1)));
-
-	mci->scrub_mode = (ecc_mode == I82443BXGX_NBXCFG_INTEGRITY_SCRUB)
-		? SCRUB_HW_SRC : SCRUB_NONE;
-
-	switch (ecc_mode) {
-	case I82443BXGX_NBXCFG_INTEGRITY_NONE:
-		edac_mode = EDAC_NONE;
-		break;
-	case I82443BXGX_NBXCFG_INTEGRITY_EC:
-		edac_mode = EDAC_EC;
-		break;
-	case I82443BXGX_NBXCFG_INTEGRITY_ECC:
-	case I82443BXGX_NBXCFG_INTEGRITY_SCRUB:
-		edac_mode = EDAC_SECDED;
-		break;
-	default:
-		edac_dbg(0, "Unknown/reserved ECC state in NBXCFG register!\n");
-		edac_mode = EDAC_UNKNOWN;
-		break;
-	}
-
-	i82443bxgx_init_csrows(mci, pdev, edac_mode, mtype);
-
-	/* Many BIOSes don't clear error flags on boot, so do this
-	 * here, or we get "phantom" errors occurring at module-load
-	 * time. */
-	pci_write_bits32(pdev, I82443BXGX_EAP,
-			(I82443BXGX_EAP_OFFSET_SBE |
-				I82443BXGX_EAP_OFFSET_MBE),
-			(I82443BXGX_EAP_OFFSET_SBE |
-				I82443BXGX_EAP_OFFSET_MBE));
-
-	mci->mod_name = EDAC_MOD_STR;
-	mci->ctl_name = "I82443BXGX";
-	mci->dev_name = pci_name(pdev);
-	mci->edac_check = i82443bxgx_edacmc_check;
-	mci->ctl_page_to_phys = NULL;
-
-	if (edac_mc_add_mc(mci)) {
-		edac_dbg(3, "failed edac_mc_add_mc()\n");
-		goto fail;
-	}
-
-	/* allocating generic PCI control info */
-	i82443bxgx_pci = edac_pci_create_generic_ctl(&pdev->dev, EDAC_MOD_STR);
-	if (!i82443bxgx_pci) {
-		printk(KERN_WARNING
-			"%s(): Unable to create PCI control\n",
-			__func__);
-		printk(KERN_WARNING
-			"%s(): PCI error report via EDAC not setup\n",
-			__func__);
-	}
-
-	edac_dbg(3, "MC: success\n");
-	return 0;
-
-fail:
-	edac_mc_free(mci);
-	return -ENODEV;
-}
-
-/* returns count (>= 0), or negative on error */
-static int i82443bxgx_edacmc_init_one(struct pci_dev *pdev,
-				      const struct pci_device_id *ent)
-{
-	int rc;
-
-	edac_dbg(0, "MC:\n");
-
-	/* don't need to call pci_enable_device() */
-	rc = i82443bxgx_edacmc_probe1(pdev, ent->driver_data);
-
-	if (mci_pdev == NULL)
-		mci_pdev = pci_dev_get(pdev);
-
-	return rc;
-}
-
-static void i82443bxgx_edacmc_remove_one(struct pci_dev *pdev)
-{
-	struct mem_ctl_info *mci;
-
-	edac_dbg(0, "\n");
-
-	if (i82443bxgx_pci)
-		edac_pci_release_generic_ctl(i82443bxgx_pci);
-
-	if ((mci = edac_mc_del_mc(&pdev->dev)) == NULL)
-		return;
-
-	edac_mc_free(mci);
-}
-
-static const struct pci_device_id i82443bxgx_pci_tbl[] = {
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82443BX_0)},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82443BX_2)},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82443GX_0)},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82443GX_2)},
-	{0,}			/* 0 terminated list. */
-};
-
-MODULE_DEVICE_TABLE(pci, i82443bxgx_pci_tbl);
-
-static struct pci_driver i82443bxgx_edacmc_driver = {
-	.name = EDAC_MOD_STR,
-	.probe = i82443bxgx_edacmc_init_one,
-	.remove = i82443bxgx_edacmc_remove_one,
-	.id_table = i82443bxgx_pci_tbl,
-};
-
-static int __init i82443bxgx_edacmc_init(void)
-{
-	int pci_rc;
-       /* Ensure that the OPSTATE is set correctly for POLL or NMI */
-       opstate_init();
-
-	pci_rc = pci_register_driver(&i82443bxgx_edacmc_driver);
-	if (pci_rc < 0)
-		goto fail0;
-
-	if (mci_pdev == NULL) {
-		const struct pci_device_id *id = &i82443bxgx_pci_tbl[0];
-		int i = 0;
-		i82443bxgx_registered = 0;
-
-		while (mci_pdev == NULL && id->vendor != 0) {
-			mci_pdev = pci_get_device(id->vendor,
-					id->device, NULL);
-			i++;
-			id = &i82443bxgx_pci_tbl[i];
-		}
-		if (!mci_pdev) {
-			edac_dbg(0, "i82443bxgx pci_get_device fail\n");
-			pci_rc = -ENODEV;
-			goto fail1;
-		}
-
-		pci_rc = i82443bxgx_edacmc_init_one(mci_pdev, i82443bxgx_pci_tbl);
-
-		if (pci_rc < 0) {
-			edac_dbg(0, "i82443bxgx init fail\n");
-			pci_rc = -ENODEV;
-			goto fail1;
-		}
-	}
-
-	return 0;
-
-fail1:
-	pci_unregister_driver(&i82443bxgx_edacmc_driver);
-
-fail0:
-	pci_dev_put(mci_pdev);
-	return pci_rc;
-}
-
-static void __exit i82443bxgx_edacmc_exit(void)
-{
-	pci_unregister_driver(&i82443bxgx_edacmc_driver);
-
-	if (!i82443bxgx_registered)
-		i82443bxgx_edacmc_remove_one(mci_pdev);
-
-	pci_dev_put(mci_pdev);
-}
-
-module_init(i82443bxgx_edacmc_init);
-module_exit(i82443bxgx_edacmc_exit);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Tim Small <tim@buttersideup.com> - WPAD");
-MODULE_DESCRIPTION("EDAC MC support for Intel 82443BX/GX memory controllers");
-
-module_param(edac_op_state, int, 0444);
-MODULE_PARM_DESC(edac_op_state, "EDAC Error Reporting state: 0=Poll,1=NMI");
-- 
2.25.1

