Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4A51FBCDF
	for <lists+linux-edac@lfdr.de>; Tue, 16 Jun 2020 19:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730960AbgFPR2A (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 16 Jun 2020 13:28:00 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40792 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730790AbgFPR1v (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 16 Jun 2020 13:27:51 -0400
Received: from zn.tnic (p200300ec2f0f4c001d7e5f403e90d72b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:4c00:1d7e:5f40:3e90:d72b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 97D171EC03D5;
        Tue, 16 Jun 2020 19:27:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592328469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ii6RwD3A1fwYeEnwYsx+uHIeZwlzQ259B3QkfstbqVE=;
        b=mo/T9fK6RnCi8bM5n2MRm4lrF2dBGgc7NRg050vln14aOMOqeZAsAuvoKfrRd2dkYvE2GB
        75zaPctXZYCu9ZVvOCgr6eU8PyrglLVfivpAE5DBzoKy2lAMXihDPfTFvHIjCBidpJR7nU
        hwRREDmRLpMvPONfUao7V355lEpwx28=
From:   Borislav Petkov <bp@alien8.de>
To:     Mauro Carvalho Chehab <mchehab@infradead.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/4] EDAC/ghes: Scan the system once on driver init
Date:   Tue, 16 Jun 2020 19:27:36 +0200
Message-Id: <20200616172737.30171-4-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200616172737.30171-1-bp@alien8.de>
References: <20200616172737.30171-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Change the hardware scanning and figuring out how many DIMMs a machine
has to a single, one-time thing which happens once on driver init. After
that scanning completes, struct ghes_hw_desc contains a representation
of the hardware which the driver can then use for later initialization.

Then, copy the DIMM information into the respective EDAC core
representation of those.

Get rid of ghes_edac_dimm_fill and use a struct dimm_info array
directly.

This way, hw detection and further driver initialization is nicely
and logically split. Further additions should all be added to
ghes_scan_system() and the hw representation extended as needed.

There should be no functionality change resulting from this patch.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/edac/ghes_edac.c | 279 +++++++++++++++++++++++----------------
 1 file changed, 166 insertions(+), 113 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index f4f9ae32c743..da60c29468a7 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -32,6 +32,15 @@ static refcount_t ghes_refcount = REFCOUNT_INIT(0);
  */
 static struct ghes_pvt *ghes_pvt;
 
+/*
+ * This driver's representation of the system hardware, as collected
+ * from DMI.
+ */
+struct ghes_hw_desc {
+	int num_dimms;
+	struct dimm_info *dimms;
+} ghes_hw;
+
 /* GHES registration mutex */
 static DEFINE_MUTEX(ghes_reg_mutex);
 
@@ -72,19 +81,6 @@ struct memdev_dmi_entry {
 	u16 conf_mem_clk_speed;
 } __attribute__((__packed__));
 
-struct ghes_edac_dimm_fill {
-	struct mem_ctl_info *mci;
-	unsigned int count;
-};
-
-static void ghes_edac_count_dimms(const struct dmi_header *dh, void *arg)
-{
-	int *num_dimm = arg;
-
-	if (dh->type == DMI_ENTRY_MEM_DEVICE)
-		(*num_dimm)++;
-}
-
 static struct dimm_info *find_dimm_by_handle(struct mem_ctl_info *mci, u16 handle)
 {
 	struct dimm_info *dimm;
@@ -108,102 +104,135 @@ static void dimm_setup_label(struct dimm_info *dimm, u16 handle)
 		snprintf(dimm->label, sizeof(dimm->label), "%s %s", bank, device);
 }
 
-static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
+static void assign_dmi_dimm_info(struct dimm_info *dimm, struct memdev_dmi_entry *entry)
 {
-	struct ghes_edac_dimm_fill *dimm_fill = arg;
-	struct mem_ctl_info *mci = dimm_fill->mci;
-
-	if (dh->type == DMI_ENTRY_MEM_DEVICE) {
-		struct memdev_dmi_entry *entry = (struct memdev_dmi_entry *)dh;
-		struct dimm_info *dimm = edac_get_dimm(mci, dimm_fill->count, 0, 0);
-		u16 rdr_mask = BIT(7) | BIT(13);
-
-		if (entry->size == 0xffff) {
-			pr_info("Can't get DIMM%i size\n",
-				dimm_fill->count);
-			dimm->nr_pages = MiB_TO_PAGES(32);/* Unknown */
-		} else if (entry->size == 0x7fff) {
-			dimm->nr_pages = MiB_TO_PAGES(entry->extended_size);
-		} else {
-			if (entry->size & BIT(15))
-				dimm->nr_pages = MiB_TO_PAGES((entry->size & 0x7fff) << 10);
-			else
-				dimm->nr_pages = MiB_TO_PAGES(entry->size);
-		}
+	u16 rdr_mask = BIT(7) | BIT(13);
 
-		switch (entry->memory_type) {
-		case 0x12:
-			if (entry->type_detail & BIT(13))
-				dimm->mtype = MEM_RDDR;
-			else
-				dimm->mtype = MEM_DDR;
-			break;
-		case 0x13:
-			if (entry->type_detail & BIT(13))
-				dimm->mtype = MEM_RDDR2;
-			else
-				dimm->mtype = MEM_DDR2;
-			break;
-		case 0x14:
-			dimm->mtype = MEM_FB_DDR2;
-			break;
-		case 0x18:
-			if (entry->type_detail & BIT(12))
-				dimm->mtype = MEM_NVDIMM;
-			else if (entry->type_detail & BIT(13))
-				dimm->mtype = MEM_RDDR3;
-			else
-				dimm->mtype = MEM_DDR3;
-			break;
-		case 0x1a:
-			if (entry->type_detail & BIT(12))
-				dimm->mtype = MEM_NVDIMM;
-			else if (entry->type_detail & BIT(13))
-				dimm->mtype = MEM_RDDR4;
-			else
-				dimm->mtype = MEM_DDR4;
-			break;
-		default:
-			if (entry->type_detail & BIT(6))
-				dimm->mtype = MEM_RMBS;
-			else if ((entry->type_detail & rdr_mask) == rdr_mask)
-				dimm->mtype = MEM_RDR;
-			else if (entry->type_detail & BIT(7))
-				dimm->mtype = MEM_SDR;
-			else if (entry->type_detail & BIT(9))
-				dimm->mtype = MEM_EDO;
-			else
-				dimm->mtype = MEM_UNKNOWN;
-		}
+	if (entry->size == 0xffff) {
+		pr_info("Can't get DIMM%i size\n", dimm->idx);
+		dimm->nr_pages = MiB_TO_PAGES(32);/* Unknown */
+	} else if (entry->size == 0x7fff) {
+		dimm->nr_pages = MiB_TO_PAGES(entry->extended_size);
+	} else {
+		if (entry->size & BIT(15))
+			dimm->nr_pages = MiB_TO_PAGES((entry->size & 0x7fff) << 10);
+		else
+			dimm->nr_pages = MiB_TO_PAGES(entry->size);
+	}
 
-		/*
-		 * Actually, we can only detect if the memory has bits for
-		 * checksum or not
-		 */
-		if (entry->total_width == entry->data_width)
-			dimm->edac_mode = EDAC_NONE;
+	switch (entry->memory_type) {
+	case 0x12:
+		if (entry->type_detail & BIT(13))
+			dimm->mtype = MEM_RDDR;
+		else
+			dimm->mtype = MEM_DDR;
+		break;
+	case 0x13:
+		if (entry->type_detail & BIT(13))
+			dimm->mtype = MEM_RDDR2;
 		else
-			dimm->edac_mode = EDAC_SECDED;
+			dimm->mtype = MEM_DDR2;
+		break;
+	case 0x14:
+		dimm->mtype = MEM_FB_DDR2;
+		break;
+	case 0x18:
+		if (entry->type_detail & BIT(12))
+			dimm->mtype = MEM_NVDIMM;
+		else if (entry->type_detail & BIT(13))
+			dimm->mtype = MEM_RDDR3;
+		else
+			dimm->mtype = MEM_DDR3;
+		break;
+	case 0x1a:
+		if (entry->type_detail & BIT(12))
+			dimm->mtype = MEM_NVDIMM;
+		else if (entry->type_detail & BIT(13))
+			dimm->mtype = MEM_RDDR4;
+		else
+			dimm->mtype = MEM_DDR4;
+		break;
+	default:
+		if (entry->type_detail & BIT(6))
+			dimm->mtype = MEM_RMBS;
+		else if ((entry->type_detail & rdr_mask) == rdr_mask)
+			dimm->mtype = MEM_RDR;
+		else if (entry->type_detail & BIT(7))
+			dimm->mtype = MEM_SDR;
+		else if (entry->type_detail & BIT(9))
+			dimm->mtype = MEM_EDO;
+		else
+			dimm->mtype = MEM_UNKNOWN;
+	}
 
-		dimm->dtype = DEV_UNKNOWN;
-		dimm->grain = 128;		/* Likely, worse case */
-
-		dimm_setup_label(dimm, entry->handle);
-
-		if (dimm->nr_pages) {
-			edac_dbg(1, "DIMM%i: %s size = %d MB%s\n",
-				dimm_fill->count, edac_mem_types[dimm->mtype],
-				PAGES_TO_MiB(dimm->nr_pages),
-				(dimm->edac_mode != EDAC_NONE) ? "(ECC)" : "");
-			edac_dbg(2, "\ttype %d, detail 0x%02x, width %d(total %d)\n",
-				entry->memory_type, entry->type_detail,
-				entry->total_width, entry->data_width);
-		}
+	/*
+	 * Actually, we can only detect if the memory has bits for
+	 * checksum or not
+	 */
+	if (entry->total_width == entry->data_width)
+		dimm->edac_mode = EDAC_NONE;
+	else
+		dimm->edac_mode = EDAC_SECDED;
+
+	dimm->dtype = DEV_UNKNOWN;
+	dimm->grain = 128;		/* Likely, worse case */
 
-		dimm->smbios_handle = entry->handle;
+	dimm_setup_label(dimm, entry->handle);
 
-		dimm_fill->count++;
+	if (dimm->nr_pages) {
+		edac_dbg(1, "DIMM%i: %s size = %d MB%s\n",
+			dimm->idx, edac_mem_types[dimm->mtype],
+			PAGES_TO_MiB(dimm->nr_pages),
+			(dimm->edac_mode != EDAC_NONE) ? "(ECC)" : "");
+		edac_dbg(2, "\ttype %d, detail 0x%02x, width %d(total %d)\n",
+			entry->memory_type, entry->type_detail,
+			entry->total_width, entry->data_width);
 	}
+
+	dimm->smbios_handle = entry->handle;
+}
+
+static void enumerate_dimms(const struct dmi_header *dh, void *arg)
+{
+	struct memdev_dmi_entry *entry = (struct memdev_dmi_entry *)dh;
+	struct ghes_hw_desc *hw = (struct ghes_hw_desc *)arg;
+	struct dimm_info *d;
+
+	if (dh->type != DMI_ENTRY_MEM_DEVICE)
+		return;
+
+	/* Enlarge the array with additional 16 */
+	if (!hw->num_dimms || !(hw->num_dimms % 16)) {
+		struct dimm_info *new;
+
+		new = krealloc(hw->dimms, (hw->num_dimms + 16) * sizeof(struct dimm_info),
+			        GFP_KERNEL);
+		if (!new) {
+			WARN_ON_ONCE(1);
+			return;
+		}
+
+		hw->dimms = new;
+	}
+
+	d = &hw->dimms[hw->num_dimms];
+	d->idx = hw->num_dimms;
+
+	assign_dmi_dimm_info(d, entry);
+
+	hw->num_dimms++;
+}
+
+static void ghes_scan_system(void)
+{
+	static bool scanned;
+
+	if (scanned)
+		return;
+
+	dmi_walk(enumerate_dimms, &ghes_hw);
+
+	scanned = true;
 }
 
 void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
@@ -466,13 +495,12 @@ static struct acpi_platform_list plat_list[] = {
 int ghes_edac_register(struct ghes *ghes, struct device *dev)
 {
 	bool fake = false;
-	int rc = 0, num_dimm = 0;
 	struct mem_ctl_info *mci;
 	struct ghes_pvt *pvt;
 	struct edac_mc_layer layers[1];
-	struct ghes_edac_dimm_fill dimm_fill;
 	unsigned long flags;
 	int idx = -1;
+	int rc = 0;
 
 	if (IS_ENABLED(CONFIG_X86)) {
 		/* Check if safe to enable on this system */
@@ -492,17 +520,16 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	if (refcount_inc_not_zero(&ghes_refcount))
 		goto unlock;
 
-	/* Get the number of DIMMs */
-	dmi_walk(ghes_edac_count_dimms, &num_dimm);
+	ghes_scan_system();
 
 	/* Check if we've got a bogus BIOS */
-	if (num_dimm == 0) {
+	if (!ghes_hw.num_dimms) {
 		fake = true;
-		num_dimm = 1;
+		ghes_hw.num_dimms = 1;
 	}
 
 	layers[0].type = EDAC_MC_LAYER_ALL_MEM;
-	layers[0].size = num_dimm;
+	layers[0].size = ghes_hw.num_dimms;
 	layers[0].is_virt_csrow = true;
 
 	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers, sizeof(struct ghes_pvt));
@@ -533,13 +560,34 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 		pr_info("So, the end result of using this driver varies from vendor to vendor.\n");
 		pr_info("If you find incorrect reports, please contact your hardware vendor\n");
 		pr_info("to correct its BIOS.\n");
-		pr_info("This system has %d DIMM sockets.\n", num_dimm);
+		pr_info("This system has %d DIMM sockets.\n", ghes_hw.num_dimms);
 	}
 
 	if (!fake) {
-		dimm_fill.count = 0;
-		dimm_fill.mci = mci;
-		dmi_walk(ghes_edac_dmidecode, &dimm_fill);
+		struct dimm_info *src, *dst;
+		int i = 0;
+
+		mci_for_each_dimm(mci, dst) {
+			src = &ghes_hw.dimms[i];
+
+			dst->idx	   = src->idx;
+			dst->smbios_handle = src->smbios_handle;
+			dst->nr_pages	   = src->nr_pages;
+			dst->mtype	   = src->mtype;
+			dst->edac_mode	   = src->edac_mode;
+			dst->dtype	   = src->dtype;
+			dst->grain	   = src->grain;
+
+			/*
+			 * If no src->label, preserve default label assigned
+			 * from EDAC core.
+			 */
+			if (strlen(src->label))
+				memcpy(dst->label, src->label, sizeof(src->label));
+
+			i++;
+		}
+
 	} else {
 		struct dimm_info *dimm = edac_get_dimm(mci, 0, 0, 0);
 
@@ -552,7 +600,7 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 
 	rc = edac_mc_add_mc(mci);
 	if (rc < 0) {
-		pr_info("Can't register at EDAC core\n");
+		pr_info("Can't register with the EDAC core\n");
 		edac_mc_free(mci);
 		rc = -ENODEV;
 		goto unlock;
@@ -566,6 +614,11 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	refcount_set(&ghes_refcount, 1);
 
 unlock:
+
+	/* Not needed anymore */
+	kfree(ghes_hw.dimms);
+	ghes_hw.dimms = NULL;
+
 	mutex_unlock(&ghes_reg_mutex);
 
 	return rc;
-- 
2.21.0

