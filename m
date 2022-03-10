Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF81E4D43E5
	for <lists+linux-edac@lfdr.de>; Thu, 10 Mar 2022 10:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241089AbiCJJyS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Mar 2022 04:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241041AbiCJJyF (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 10 Mar 2022 04:54:05 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA2B4F46E;
        Thu, 10 Mar 2022 01:52:54 -0800 (PST)
Received: from zn.tnic (p200300ea97193878fa50b3d92789953a.dip0.t-ipconnect.de [IPv6:2003:ea:9719:3878:fa50:b3d9:2789:953a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BC9AB1EC0651;
        Thu, 10 Mar 2022 10:52:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1646905972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fbXtm+u+HV2in2x2Bb5FmI1JrBfMuSPunOHCJM5U8Co=;
        b=fsHT9qYakv16ceHXVMwAcHsqxUPmuvNmXVktZEQAkayxG4UAcJjSTQDO1VrciAJSWA8Whg
        byzw6siriYEWcivvhDbsqOGgc1XKbfszVqr2fc953x+6CadDfi4dBkFQBpaPYa3Ps4mMYT
        Hj7iyJBcEmYaVCO9FgqQp+q0CBhEZXE=
From:   Borislav Petkov <bp@alien8.de>
To:     linux-edac <linux-edac@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/5] EDAC/device: Get rid of the silly one-shot memory allocation in edac_device_alloc_ctl_info()
Date:   Thu, 10 Mar 2022 10:52:52 +0100
Message-Id: <20220310095254.1510-4-bp@alien8.de>
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

Use boring kzalloc() instead. Add pointers to the different allocated
members in struct edac_device_ctl_info for easier freeing later.

One of the reasons, perhaps, why it was done this way is to be able to
do a single kfree(ctl_info) without having to kfree() the other parts of
the struct too but that is not nearly a sensible reason as to why there
should be this obscure pointer alignment.

There should be no functional changes resulting from this.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/edac/edac_device.c       | 109 ++++++++++++-------------------
 drivers/edac/edac_device.h       |  14 ++++
 drivers/edac/edac_device_sysfs.c |   5 +-
 3 files changed, 57 insertions(+), 71 deletions(-)

diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
index 8c4d947fb848..3c91156bbd27 100644
--- a/drivers/edac/edac_device.c
+++ b/drivers/edac/edac_device.c
@@ -59,87 +59,59 @@ struct edac_device_ctl_info *edac_device_alloc_ctl_info(
 	struct edac_device_instance *dev_inst, *inst;
 	struct edac_device_block *dev_blk, *blk_p, *blk;
 	struct edac_dev_sysfs_block_attribute *dev_attrib, *attrib_p, *attrib;
-	unsigned total_size;
-	unsigned count;
 	unsigned instance, block, attr;
-	void *pvt, *p;
+	void *pvt;
 	int err;
 
 	edac_dbg(4, "instances=%d blocks=%d\n", nr_instances, nr_blocks);
 
-	/* Calculate the size of memory we need to allocate AND
-	 * determine the offsets of the various item arrays
-	 * (instance,block,attrib) from the start of an  allocated structure.
-	 * We want the alignment of each item  (instance,block,attrib)
-	 * to be at least as stringent as what the compiler would
-	 * provide if we could simply hardcode everything into a single struct.
-	 */
-	p = NULL;
-	dev_ctl = edac_align_ptr(&p, sizeof(*dev_ctl), 1);
+	dev_ctl = kzalloc(sizeof(struct edac_device_ctl_info), GFP_KERNEL);
+	if (!dev_ctl)
+		return NULL;
 
-	/* Calc the 'end' offset past end of ONE ctl_info structure
-	 * which will become the start of the 'instance' array
-	 */
-	dev_inst = edac_align_ptr(&p, sizeof(*dev_inst), nr_instances);
+	dev_inst = kmalloc_array(nr_instances,
+				 sizeof(struct edac_device_instance),
+				 GFP_KERNEL | __GFP_ZERO);
+	if (!dev_inst)
+		goto free;
 
-	/* Calc the 'end' offset past the instance array within the ctl_info
-	 * which will become the start of the block array
-	 */
-	count = nr_instances * nr_blocks;
-	dev_blk = edac_align_ptr(&p, sizeof(*dev_blk), count);
+	dev_ctl->instances = dev_inst;
 
-	/* Calc the 'end' offset past the dev_blk array
-	 * which will become the start of the attrib array, if any.
-	 */
-	/* calc how many nr_attrib we need */
-	if (nr_attrib > 0)
-		count *= nr_attrib;
-	dev_attrib = edac_align_ptr(&p, sizeof(*dev_attrib), count);
+	dev_blk = kmalloc_array(nr_instances * nr_blocks,
+				sizeof(struct edac_device_block),
+				GFP_KERNEL | __GFP_ZERO);
+	if (!dev_blk)
+		goto free;
 
-	/* Calc the 'end' offset past the attributes array */
-	pvt = edac_align_ptr(&p, sz_private, 1);
+	dev_ctl->blocks = dev_blk;
 
-	/* 'pvt' now points to where the private data area is.
-	 * At this point 'pvt' (like dev_inst,dev_blk and dev_attrib)
-	 * is baselined at ZERO
-	 */
-	total_size = ((unsigned long)pvt) + sz_private;
+	if (nr_attrib) {
+		dev_attrib = kmalloc_array(nr_attrib,
+					   sizeof(struct edac_dev_sysfs_block_attribute),
+					   GFP_KERNEL | __GFP_ZERO);
+		if (!dev_attrib)
+			goto free;
 
-	/* Allocate the amount of memory for the set of control structures */
-	dev_ctl = kzalloc(total_size, GFP_KERNEL);
-	if (dev_ctl == NULL)
-		return NULL;
+		dev_ctl->attribs = dev_attrib;
+	}
 
-	/* Adjust pointers so they point within the actual memory we
-	 * just allocated rather than an imaginary chunk of memory
-	 * located at address 0.
-	 * 'dev_ctl' points to REAL memory, while the others are
-	 * ZERO based and thus need to be adjusted to point within
-	 * the allocated memory.
-	 */
-	dev_inst = (struct edac_device_instance *)
-		(((char *)dev_ctl) + ((unsigned long)dev_inst));
-	dev_blk = (struct edac_device_block *)
-		(((char *)dev_ctl) + ((unsigned long)dev_blk));
-	dev_attrib = (struct edac_dev_sysfs_block_attribute *)
-		(((char *)dev_ctl) + ((unsigned long)dev_attrib));
-	pvt = sz_private ? (((char *)dev_ctl) + ((unsigned long)pvt)) : NULL;
-
-	/* Begin storing the information into the control info structure */
-	dev_ctl->dev_idx = device_index;
-	dev_ctl->nr_instances = nr_instances;
-	dev_ctl->instances = dev_inst;
-	dev_ctl->pvt_info = pvt;
+	if (sz_private) {
+		pvt = kzalloc(sz_private, GFP_KERNEL);
+		if (!pvt)
+			goto free;
+
+		dev_ctl->pvt_info = pvt;
+	}
+
+	dev_ctl->dev_idx	= device_index;
+	dev_ctl->nr_instances	= nr_instances;
 
 	/* Default logging of CEs and UEs */
 	dev_ctl->log_ce = 1;
 	dev_ctl->log_ue = 1;
 
 	/* Name of this edac device */
-	snprintf(dev_ctl->name,sizeof(dev_ctl->name),"%s",edac_device_name);
-
-	edac_dbg(4, "edac_dev=%p next after end=%p\n",
-		 dev_ctl, pvt + sz_private);
+	snprintf(dev_ctl->name, sizeof(dev_ctl->name),"%s", edac_device_name);
 
 	/* Initialize every Instance */
 	for (instance = 0; instance < nr_instances; instance++) {
@@ -210,10 +182,8 @@ struct edac_device_ctl_info *edac_device_alloc_ctl_info(
 	 * Initialize the 'root' kobj for the edac_device controller
 	 */
 	err = edac_device_register_sysfs_main_kobj(dev_ctl);
-	if (err) {
-		kfree(dev_ctl);
-		return NULL;
-	}
+	if (err)
+		goto free;
 
 	/* at this point, the root kobj is valid, and in order to
 	 * 'free' the object, then the function:
@@ -223,6 +193,11 @@ struct edac_device_ctl_info *edac_device_alloc_ctl_info(
 	 */
 
 	return dev_ctl;
+
+free:
+	__edac_device_free_ctl_info(dev_ctl);
+
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(edac_device_alloc_ctl_info);
 
diff --git a/drivers/edac/edac_device.h b/drivers/edac/edac_device.h
index fc2d2c218064..3f44e6b9d387 100644
--- a/drivers/edac/edac_device.h
+++ b/drivers/edac/edac_device.h
@@ -216,6 +216,8 @@ struct edac_device_ctl_info {
 	 */
 	u32 nr_instances;
 	struct edac_device_instance *instances;
+	struct edac_device_block *blocks;
+	struct edac_dev_sysfs_block_attribute *attribs;
 
 	/* Event counters for the this whole EDAC Device */
 	struct edac_device_counter counters;
@@ -348,4 +350,16 @@ edac_device_handle_ue(struct edac_device_ctl_info *edac_dev, int inst_nr,
  */
 extern int edac_device_alloc_index(void);
 extern const char *edac_layer_name[];
+
+/* Free the actual struct */
+static inline void __edac_device_free_ctl_info(struct edac_device_ctl_info *ci)
+{
+	if (ci) {
+		kfree(ci->pvt_info);
+		kfree(ci->attribs);
+		kfree(ci->blocks);
+		kfree(ci->instances);
+		kfree(ci);
+	}
+}
 #endif
diff --git a/drivers/edac/edac_device_sysfs.c b/drivers/edac/edac_device_sysfs.c
index 5e7593753799..e748a5addd38 100644
--- a/drivers/edac/edac_device_sysfs.c
+++ b/drivers/edac/edac_device_sysfs.c
@@ -207,10 +207,7 @@ static void edac_device_ctrl_master_release(struct kobject *kobj)
 	/* decrement the EDAC CORE module ref count */
 	module_put(edac_dev->owner);
 
-	/* free the control struct containing the 'main' kobj
-	 * passed in to this routine
-	 */
-	kfree(edac_dev);
+	__edac_device_free_ctl_info(edac_dev);
 }
 
 /* ktype for the main (master) kobject */
-- 
2.29.2

