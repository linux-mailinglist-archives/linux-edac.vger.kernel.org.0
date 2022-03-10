Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483564D43E3
	for <lists+linux-edac@lfdr.de>; Thu, 10 Mar 2022 10:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241007AbiCJJyB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Mar 2022 04:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240968AbiCJJx7 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 10 Mar 2022 04:53:59 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056733A1A5;
        Thu, 10 Mar 2022 01:52:52 -0800 (PST)
Received: from zn.tnic (p200300ea97193878fa50b3d92789953a.dip0.t-ipconnect.de [IPv6:2003:ea:9719:3878:fa50:b3d9:2789:953a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8DE4C1EC0628;
        Thu, 10 Mar 2022 10:52:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1646905971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8HPBjAt12e9y+TmY1dLjbvw33G2uomnQGijd5JC3m8U=;
        b=KGR5aVyoePUhfWWGQ90BrMCUmM2ACWD0mPuEAqaJktxQNn2is9iehnVj+35VLdirW+7gT3
        MMnnlxVOyoMwOnRRoQeRiVOi0Se0mAvDStnRruhoowhMyGkU7azV+uYU0A6VFW+1bYCO7j
        A/kWzzuhspgNAlmlK+XzcTyuyrQroz8=
From:   Borislav Petkov <bp@alien8.de>
To:     linux-edac <linux-edac@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/5] EDAC/mc: Get rid of silly one-shot struct allocation in edac_mc_alloc()
Date:   Thu, 10 Mar 2022 10:52:50 +0100
Message-Id: <20220310095254.1510-2-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220310095254.1510-1-bp@alien8.de>
References: <20220310095254.1510-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

This has probably meant something at some point but there's no need for
it anymore - the struct mem_ctl_info allocation can happen with normal,
boring k*alloc() calls like everyone else does it.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/edac/edac_mc.c | 41 +++++++++++++----------------------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index f5677d81bd2d..b9b298a59f46 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -257,6 +257,8 @@ static void mci_release(struct device *dev)
 		}
 		kfree(mci->csrows);
 	}
+	kfree(mci->pvt_info);
+	kfree(mci->layers);
 	kfree(mci);
 }
 
@@ -392,9 +394,8 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
 {
 	struct mem_ctl_info *mci;
 	struct edac_mc_layer *layer;
-	unsigned int idx, size, tot_dimms = 1;
+	unsigned int idx, tot_dimms = 1;
 	unsigned int tot_csrows = 1, tot_channels = 1;
-	void *pvt, *ptr = NULL;
 	bool per_rank = false;
 
 	if (WARN_ON(n_layers > EDAC_MAX_LAYERS || n_layers == 0))
@@ -416,41 +417,25 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
 			per_rank = true;
 	}
 
-	/* Figure out the offsets of the various items from the start of an mc
-	 * structure.  We want the alignment of each item to be at least as
-	 * stringent as what the compiler would provide if we could simply
-	 * hardcode everything into a single struct.
-	 */
-	mci	= edac_align_ptr(&ptr, sizeof(*mci), 1);
-	layer	= edac_align_ptr(&ptr, sizeof(*layer), n_layers);
-	pvt	= edac_align_ptr(&ptr, sz_pvt, 1);
-	size	= ((unsigned long)pvt) + sz_pvt;
-
-	edac_dbg(1, "allocating %u bytes for mci data (%d %s, %d csrows/channels)\n",
-		 size,
-		 tot_dimms,
-		 per_rank ? "ranks" : "dimms",
-		 tot_csrows * tot_channels);
-
-	mci = kzalloc(size, GFP_KERNEL);
-	if (mci == NULL)
+	mci = kzalloc(sizeof(struct mem_ctl_info), GFP_KERNEL);
+	if (!mci)
 		return NULL;
 
+	mci->layers = kmalloc_array(n_layers, sizeof(struct edac_mc_layer), GFP_KERNEL | __GFP_ZERO);
+	if (!mci->layers)
+		goto error;
+
+	mci->pvt_info = kzalloc(sz_pvt, GFP_KERNEL);
+	if (!mci->pvt_info)
+		goto error;
+
 	mci->dev.release = mci_release;
 	device_initialize(&mci->dev);
 
-	/* Adjust pointers so they point within the memory we just allocated
-	 * rather than an imaginary chunk of memory located at address 0.
-	 */
-	layer = (struct edac_mc_layer *)(((char *)mci) + ((unsigned long)layer));
-	pvt = sz_pvt ? (((char *)mci) + ((unsigned long)pvt)) : NULL;
-
 	/* setup index and various internal pointers */
 	mci->mc_idx = mc_num;
 	mci->tot_dimms = tot_dimms;
-	mci->pvt_info = pvt;
 	mci->n_layers = n_layers;
-	mci->layers = layer;
 	memcpy(mci->layers, layers, sizeof(*layer) * n_layers);
 	mci->nr_csrows = tot_csrows;
 	mci->num_cschannel = tot_channels;
-- 
2.29.2

