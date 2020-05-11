Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E301CDB41
	for <lists+linux-edac@lfdr.de>; Mon, 11 May 2020 15:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbgEKNcL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 11 May 2020 09:32:11 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58454 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729485AbgEKNcL (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 11 May 2020 09:32:11 -0400
Received: from zn.tnic (p200300EC2F05F1009D064414CC0B4AA6.dip0.t-ipconnect.de [IPv6:2003:ec:2f05:f100:9d06:4414:cc0b:4aa6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 057231EC0181;
        Mon, 11 May 2020 15:32:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1589203929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=iPXlNJyjmhoc/+5wf6LjXNZpM3wh+ALOM1hocB+sNek=;
        b=KTyX3cJEBTXG+10NgO95CWThTjlkXqTijaOioOc90nnBR8YIysLRMZ/JNLx3r+a+FIHtaH
        vjOfoy0OtsdMViN1UP8qexPb8PxQFX0zrVBIJ+sSFCwGjE+fuCf+f7UM+XQBftPAPBZ4g3
        /QnqywsQbVC1YyR5Vl9IhKF6AbGqv/M=
Date:   Mon, 11 May 2020 15:32:03 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Matthias Brugger <mbrugger@suse.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/10] EDAC/ghes: Carve out MC device handling into
 separate functions
Message-ID: <20200511133203.GB25861@zn.tnic>
References: <20200422115814.22205-1-rrichter@marvell.com>
 <20200422115814.22205-9-rrichter@marvell.com>
 <20200427163856.GG11036@zn.tnic>
 <20200506084558.tcayd2fuzoe6rsfm@rric.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200506084558.tcayd2fuzoe6rsfm@rric.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi,

see below. It probably doesn't work but this is what it should do -
straightforward and simple.

And now that I've looked at this in more detail, this whole DIMM
counting is still not doing what it should do.

So lemme try again:

1. Counting the DIMMs.

You should add a function which is called

	ghes_count_dimms()

or so, which does:

        /* Get the number of DIMMs */
        dmi_walk(ghes_edac_count_dimms, &num_dimm);

That function should run once at entry of ghes_edac_register().

When that function is done, it should spit out a data structure which
has this mapping:

	memory controller	DIMMs
	0			0-x
	1			x+1 - y
	2			y+1 - ...

and so on.

This basically will contain the DIMM layout of the system along with the
mapping which memory controller has which DIMMs.

So that you don't have to do edac_get_dimm_by_index() and rely on having
called edac_mc_alloc() *prior* to calling edac_get_dimm_by_index() so
that mci->dimms[] is properly populated and former can give you a proper
dimm_info pointer.

You can also merge the functionality of ghes_edac_dmidecode() together
and so on so that you scan all the DIMM information needed at *once* so
that you can allocate an mci properly.

2. Memory controller allocation. Once the parsing is done, you do

 	edac_mc_alloc()

for the respective memory controller using the mapping above which you
have parsed at init.

3. When the allocation is done, you set the proper DIMM handles of
the dimms of this mci so that find_dimm_by_handle() can find the DIMM
correctly.

Now, here's the important part: if ghes_edac_report_mem_error() can get
the memory controller which is in error - struct cper_sec_mem_err has a
node member but that all depends on whether your BIOS even populates it
properly - then find_dimm_by_handle() can even take an mci and search
only through the DIMMs of that memory controller by the handle.

If the BIOS does not populate them properly, then you can simply search
that mapping list of *all* DIMMs which ghes_count_dimms() has created
before.

4. You lastly add edac_mc_add_mc() and all good.

The benefits of this whole approach is that you will have a single data
structure representating the DIMMs in the system and you can traverse
it back'n'forth.

The code will be simple and straight-forward and not with those DMI
callbacks here and there, picking out pieces of needed info instead of
doing a whole system scan *once* at *init* and then working with the
parsed info.

I sincerely hope that this makes sense.

Thx.

---
diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 4eadc5b344c8..396945634a2a 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -535,15 +535,83 @@ static struct acpi_platform_list plat_list[] = {
 	{ } /* End */
 };
 
+static struct mem_ctl_info *ghes_mc_alloc(struct device *dev, int mc_idx,
+					   int num_dimm)
+{
+	struct edac_mc_layer layers[1];
+	struct mem_ctl_info *mci;
+	struct ghes_mci *pvt;
+
+	layers[0].type = EDAC_MC_LAYER_ALL_MEM;
+	layers[0].size = num_dimm;
+	layers[0].is_virt_csrow = true;
+
+	mci = edac_mc_alloc(mc_idx, ARRAY_SIZE(layers), layers, sizeof(*pvt));
+	if (!mci)
+		return NULL;
+
+	pvt		= mci->pvt_info;
+	pvt->mci	= mci;
+
+	mci->pdev = dev;
+	mci->mtype_cap = MEM_FLAG_EMPTY;
+	mci->edac_ctl_cap = EDAC_FLAG_NONE;
+	mci->edac_cap = EDAC_FLAG_NONE;
+	mci->mod_name = "ghes_edac.c";
+	mci->ctl_name = "ghes_edac";
+	mci->dev_name = "ghes";
+
+	return mci;
+}
+
+static int ghes_mc_add(struct mem_ctl_info *mci, struct list_head *dimm_list)
+{
+	unsigned long flags;
+	int rc;
+
+	rc = edac_mc_add_mc(mci);
+	if (rc < 0)
+		return rc;
+
+	spin_lock_irqsave(&ghes_lock, flags);
+	ghes_pvt = mci->pvt_info;
+	list_splice_tail(dimm_list, &ghes_dimm_list);
+	spin_unlock_irqrestore(&ghes_lock, flags);
+
+	return 0;
+}
+
+static void ghes_mc_free(void)
+{
+	struct mem_ctl_info *mci;
+	unsigned long flags;
+	LIST_HEAD(dimm_list);
+
+	/*
+	 * Wait for the irq handler being finished.
+	 */
+	spin_lock_irqsave(&ghes_lock, flags);
+	mci = ghes_pvt ? ghes_pvt->mci : NULL;
+	ghes_pvt = NULL;
+	list_splice_init(&ghes_dimm_list, &dimm_list);
+	spin_unlock_irqrestore(&ghes_lock, flags);
+
+	ghes_dimm_release(&dimm_list);
+
+	if (!mci)
+		return;
+
+	mci = edac_mc_del_mc(mci->pdev);
+	if (mci)
+		edac_mc_free(mci);
+}
+
 int ghes_edac_register(struct ghes *ghes, struct device *dev)
 {
 	bool fake = false;
 	int rc = 0, num_dimm = 0;
 	struct mem_ctl_info *mci;
-	struct ghes_mci *pvt;
-	struct edac_mc_layer layers[1];
 	struct dimm_fill dimm_fill;
-	unsigned long flags;
 	int idx = -1;
 
 	if (IS_ENABLED(CONFIG_X86)) {
@@ -577,27 +645,12 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 		num_dimm = 1;
 	}
 
-	layers[0].type = EDAC_MC_LAYER_ALL_MEM;
-	layers[0].size = num_dimm;
-	layers[0].is_virt_csrow = true;
-
-	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers, sizeof(*pvt));
+	mci = ghes_mc_alloc(dev, 0, num_dimm);
 	if (!mci) {
 		rc = -ENOMEM;
-		goto unlock;
+		goto release;
 	}
 
-	pvt		= mci->pvt_info;
-	pvt->mci	= mci;
-
-	mci->pdev = dev;
-	mci->mtype_cap = MEM_FLAG_EMPTY;
-	mci->edac_ctl_cap = EDAC_FLAG_NONE;
-	mci->edac_cap = EDAC_FLAG_NONE;
-	mci->mod_name = "ghes_edac.c";
-	mci->ctl_name = "ghes_edac";
-	mci->dev_name = "ghes";
-
 	if (fake) {
 		pr_info("This system has a very crappy BIOS: It doesn't even list the DIMMS.\n");
 		pr_info("Its SMBIOS info is wrong. It is doubtful that the error report would\n");
@@ -627,21 +680,21 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 		dimm->edac_mode = EDAC_SECDED;
 	}
 
-	rc = edac_mc_add_mc(mci);
+	rc = ghes_mc_add(mci, &dimm_fill.dimms);
 	if (rc < 0) {
-		ghes_dimm_release(&dimm_fill.dimms);
-		edac_mc_free(mci);
 		rc = -ENODEV;
-		goto unlock;
+		goto mc_free;
 	}
 
-	spin_lock_irqsave(&ghes_lock, flags);
-	ghes_pvt = pvt;
-	list_splice_tail(&dimm_fill.dimms, &ghes_dimm_list);
-	spin_unlock_irqrestore(&ghes_lock, flags);
-
 	/* only set on success */
 	refcount_set(&ghes_refcount, 1);
+	goto unlock;
+
+mc_free:
+	edac_mc_free(mci);
+
+release:
+	ghes_dimm_release(&dimm_fill.dimms);
 
 unlock:
 	if (rc < 0) {
@@ -656,35 +709,12 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 
 void ghes_edac_unregister(struct ghes *ghes)
 {
-	struct mem_ctl_info *mci;
-	unsigned long flags;
-	LIST_HEAD(dimm_list);
-
 	mutex_lock(&ghes_reg_mutex);
 
-	if (!refcount_dec_and_test(&ghes_refcount))
-		goto unlock;
-
-	/*
-	 * Wait for the irq handler being finished.
-	 */
-	spin_lock_irqsave(&ghes_lock, flags);
-	mci = ghes_pvt ? ghes_pvt->mci : NULL;
-	ghes_pvt = NULL;
-	list_splice_init(&ghes_dimm_list, &dimm_list);
-	spin_unlock_irqrestore(&ghes_lock, flags);
-
-	ghes_dimm_release(&dimm_list);
-
-	if (!mci)
-		goto unlock;
-
-	mci = edac_mc_del_mc(mci->pdev);
-	if (mci) {
-		edac_mc_free(mci);
+	if (refcount_dec_and_test(&ghes_refcount)) {
+		ghes_mc_free();
 		ghes_dimm_pool_destroy();
 	}
 
-unlock:
 	mutex_unlock(&ghes_reg_mutex);
 }

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
