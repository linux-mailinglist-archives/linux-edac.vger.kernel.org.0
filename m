Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1CA4D4405
	for <lists+linux-edac@lfdr.de>; Thu, 10 Mar 2022 10:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241077AbiCJJyR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Mar 2022 04:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241034AbiCJJyE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 10 Mar 2022 04:54:04 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FE14BB97;
        Thu, 10 Mar 2022 01:52:54 -0800 (PST)
Received: from zn.tnic (p200300ea97193878fa50b3d92789953a.dip0.t-ipconnect.de [IPv6:2003:ea:9719:3878:fa50:b3d9:2789:953a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6B5D91EC0657;
        Thu, 10 Mar 2022 10:52:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1646905973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sOz3IsU1XG3CZ3H5QYkSj2D2RKEPjahq9MTYiDMHFSY=;
        b=ozSHGnFb1ZeCWOZ+DcXBU0wyUkTKWLr1uErV+2jdLN8IdQN6W71XU68blZaDedEXdmqF8h
        GxkuElTPlQNhNz9lI3lgwug5IyFi+hZ7qF6jy9fjNoeRD6D0m7xrSzZbHmOR0xBYJVfVyQ
        dEC/rTJuSY/dBr9npmhE/+3fPgY8c/I=
From:   Borislav Petkov <bp@alien8.de>
To:     linux-edac <linux-edac@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/5] EDAC/device: Sanitize edac_device_alloc_ctl_info() definition
Date:   Thu, 10 Mar 2022 10:52:53 +0100
Message-Id: <20220310095254.1510-5-bp@alien8.de>
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

Shorten argument names, correct formatting, sort local vars in reverse
x-mas tree order.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/edac/edac_device.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
index 3c91156bbd27..b737349184e3 100644
--- a/drivers/edac/edac_device.c
+++ b/drivers/edac/edac_device.c
@@ -47,18 +47,19 @@ static void edac_device_dump_device(struct edac_device_ctl_info *edac_dev)
 }
 #endif				/* CONFIG_EDAC_DEBUG */
 
-struct edac_device_ctl_info *edac_device_alloc_ctl_info(
-	unsigned sz_private,
-	char *edac_device_name, unsigned nr_instances,
-	char *edac_block_name, unsigned nr_blocks,
-	unsigned offset_value,		/* zero, 1, or other based offset */
-	struct edac_dev_sysfs_block_attribute *attrib_spec, unsigned nr_attrib,
-	int device_index)
+/*
+ * @off_val: zero, 1, or other based offset
+ */
+struct edac_device_ctl_info *
+edac_device_alloc_ctl_info(unsigned pvt_sz, char *dev_name, unsigned nr_instances,
+			   char *blk_name, unsigned nr_blocks, unsigned off_val,
+			   struct edac_dev_sysfs_block_attribute *attrib_spec,
+			   unsigned nr_attrib, int device_index)
 {
-	struct edac_device_ctl_info *dev_ctl;
-	struct edac_device_instance *dev_inst, *inst;
-	struct edac_device_block *dev_blk, *blk_p, *blk;
 	struct edac_dev_sysfs_block_attribute *dev_attrib, *attrib_p, *attrib;
+	struct edac_device_block *dev_blk, *blk_p, *blk;
+	struct edac_device_instance *dev_inst, *inst;
+	struct edac_device_ctl_info *dev_ctl;
 	unsigned instance, block, attr;
 	void *pvt;
 	int err;
@@ -95,8 +96,8 @@ struct edac_device_ctl_info *edac_device_alloc_ctl_info(
 		dev_ctl->attribs = dev_attrib;
 	}
 
-	if (sz_private) {
-		pvt = kzalloc(sz_private, GFP_KERNEL);
+	if (pvt_sz) {
+		pvt = kzalloc(pvt_sz, GFP_KERNEL);
 		if (!pvt)
 			goto free;
 
@@ -111,7 +112,7 @@ struct edac_device_ctl_info *edac_device_alloc_ctl_info(
 	dev_ctl->log_ue = 1;
 
 	/* Name of this edac device */
-	snprintf(dev_ctl->name, sizeof(dev_ctl->name),"%s", edac_device_name);
+	snprintf(dev_ctl->name, sizeof(dev_ctl->name),"%s", dev_name);
 
 	/* Initialize every Instance */
 	for (instance = 0; instance < nr_instances; instance++) {
@@ -122,15 +123,14 @@ struct edac_device_ctl_info *edac_device_alloc_ctl_info(
 		inst->blocks = blk_p;
 
 		/* name of this instance */
-		snprintf(inst->name, sizeof(inst->name),
-			 "%s%u", edac_device_name, instance);
+		snprintf(inst->name, sizeof(inst->name), "%s%u", dev_name, instance);
 
 		/* Initialize every block in each instance */
 		for (block = 0; block < nr_blocks; block++) {
 			blk = &blk_p[block];
 			blk->instance = inst;
 			snprintf(blk->name, sizeof(blk->name),
-				 "%s%d", edac_block_name, block+offset_value);
+				 "%s%d", blk_name, block + off_val);
 
 			edac_dbg(4, "instance=%d inst_p=%p block=#%d block_p=%p name='%s'\n",
 				 instance, inst, block, blk, blk->name);
-- 
2.29.2

