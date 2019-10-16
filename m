Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4508DD9551
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2019 17:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392704AbfJPPSB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 16 Oct 2019 11:18:01 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58552 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390248AbfJPPSB (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 16 Oct 2019 11:18:01 -0400
Received: from zn.tnic (p200300EC2F093900C973EA3B8BE79A94.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:3900:c973:ea3b:8be7:9a94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C51801EC078A;
        Wed, 16 Oct 2019 17:17:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1571239080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8z+Ta8iTx/ONA9bBJDmdNVY0BmsvjOTWR3NWXXX4eZw=;
        b=QP9SXZI62xbHm9U5dJRoEvBQhsZUMEeFt7KYh0xENwxuw/fKLKmz5dJRbD72QmHbikgFM9
        qLlB3Lg7BFOGSUnoSorDR7NtSwrhHRjbY5XPeHldN/3zKwMPPXG2iqER+RFQssy2B7utUn
        gkRByAT59xm4oDGxV9O7pGA5+R5PTZc=
Date:   Wed, 16 Oct 2019 17:17:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     James Morse <james.morse@arm.com>
Cc:     linux-edac@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Robert Richter <rrichter@marvell.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 0/2] EDAC, ghes: Fix use after free and add reference
Message-ID: <20191016151751.GH1138@zn.tnic>
References: <20191014171919.85044-1-james.morse@arm.com>
 <20191014173006.GG4715@zn.tnic>
 <86ba3fcf-d29c-1d6a-d8c3-2a03cb11263e@arm.com>
 <20191014175319.GH4715@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191014175319.GH4715@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Oct 14, 2019 at 07:53:19PM +0200, Borislav Petkov wrote:
> Provided unregister cannot be called concurrently, the
> 
>         if (!ghes_pvt)
>                 return;
> 
> in ghes_edac_unregister() should suffice.
> 
> But just to be on the safe side, it could get an "instance_mutex" or so
> under which ghes_pvt is set and cleared and then that silly counter can
> simply go away.
> 
> Thoughts?

IOW, something simple and straight-forward like this:

---
diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 0bb62857ffb2..b600f010fa0e 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -26,9 +26,11 @@ struct ghes_edac_pvt {
 	char msg[80];
 };
 
-static atomic_t ghes_init = ATOMIC_INIT(0);
 static struct ghes_edac_pvt *ghes_pvt;
 
+/* GHES instances reg/dereg mutex */
+static DEFINE_MUTEX(ghes_reg_mutex);
+
 /*
  * Sync with other, potentially concurrent callers of
  * ghes_edac_report_mem_error(). We don't know what the
@@ -461,7 +463,7 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	struct mem_ctl_info *mci;
 	struct edac_mc_layer layers[1];
 	struct ghes_edac_dimm_fill dimm_fill;
-	int idx = -1;
+	int idx = -1, err = 0;
 
 	if (IS_ENABLED(CONFIG_X86)) {
 		/* Check if safe to enable on this system */
@@ -472,11 +474,13 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 		idx = 0;
 	}
 
+	mutex_lock(&ghes_reg_mutex);
+
 	/*
 	 * We have only one logical memory controller to which all DIMMs belong.
 	 */
-	if (atomic_inc_return(&ghes_init) > 1)
-		return 0;
+	if (ghes_pvt)
+		goto unlock;
 
 	/* Get the number of DIMMs */
 	dmi_walk(ghes_edac_count_dimms, &num_dimm);
@@ -494,7 +498,8 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers, sizeof(struct ghes_edac_pvt));
 	if (!mci) {
 		pr_info("Can't allocate memory for EDAC data\n");
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto unlock;
 	}
 
 	ghes_pvt	= mci->pvt_info;
@@ -541,23 +546,29 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	if (rc < 0) {
 		pr_info("Can't register at EDAC core\n");
 		edac_mc_free(mci);
-		return -ENODEV;
+		err = -ENODEV;
 	}
-	return 0;
+
+unlock:
+	mutex_unlock(&ghes_reg_mutex);
+
+	return err;
 }
 
 void ghes_edac_unregister(struct ghes *ghes)
 {
 	struct mem_ctl_info *mci;
 
-	if (!ghes_pvt)
-		return;
+	mutex_lock(&ghes_reg_mutex);
 
-	if (atomic_dec_return(&ghes_init))
-		return;
+	if (!ghes_pvt)
+		goto unlock;
 
 	mci = ghes_pvt->mci;
 	ghes_pvt = NULL;
 	edac_mc_del_mc(mci->pdev);
 	edac_mc_free(mci);
+
+unlock:
+	mutex_unlock(&ghes_reg_mutex);
 }


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
