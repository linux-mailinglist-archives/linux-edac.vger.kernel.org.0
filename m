Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E164FEB8F
	for <lists+linux-edac@lfdr.de>; Wed, 13 Apr 2022 01:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiDLX2h (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 12 Apr 2022 19:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiDLX0r (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 12 Apr 2022 19:26:47 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6418EE5E17;
        Tue, 12 Apr 2022 15:36:41 -0700 (PDT)
Received: from zn.tnic (p200300ea971b584e329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:584e:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 774D31EC0559;
        Tue, 12 Apr 2022 23:20:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649798400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=GlHl/2jxkBEfPRxyBRwwLrraiX+W/kin918whTHPlOY=;
        b=GDw+J8xtvQ5oIO+Jja/gzzTP10OTdC0r8F11tzXJjpGP5kt7wQAxvd3icFSuskkl2EOI9Y
        fTNBgkLgCsa/GgnSm87cKXkoQicQ/nBnr7/0Bvi5LOm6MXXy9hJbs6lQbPV4Gqb4tYkgIg
        W7vZg8SkFqoPQADWiQcFOBs58wrHb3E=
From:   Borislav Petkov <bp@alien8.de>
To:     linux-edac <linux-edac@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] EDAC: Use kcalloc()
Date:   Tue, 12 Apr 2022 23:19:57 +0200
Message-Id: <20220412211957.28899-1-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
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

It is syntactic sugar anyway:

  # drivers/edac/edac_mc.o:

   text    data     bss     dec     hex filename
  13378     324       8   13710    358e edac_mc.o.before
  13378     324       8   13710    358e edac_mc.o.after

md5:
   70a53ee3ac7f867730e35c2be9110748  edac_mc.o.before.asm
   70a53ee3ac7f867730e35c2be9110748  edac_mc.o.after.asm

  # drivers/edac/edac_device.o:

   text    data     bss     dec     hex filename
   5684     120       4    5808    16b0 edac_device.o.before
   5684     120       4    5808    16b0 edac_device.o.after

md5:
   811325c80acb5a1d6df7b290df3e1636  edac_device.o.before.asm
   811325c80acb5a1d6df7b290df3e1636  edac_device.o.after.asm

No functional changes.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/edac/edac_device.c | 9 +++------
 drivers/edac/edac_mc.c     | 2 +-
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
index b737349184e3..3d5a4944735f 100644
--- a/drivers/edac/edac_device.c
+++ b/drivers/edac/edac_device.c
@@ -70,9 +70,7 @@ edac_device_alloc_ctl_info(unsigned pvt_sz, char *dev_name, unsigned nr_instance
 	if (!dev_ctl)
 		return NULL;
 
-	dev_inst = kmalloc_array(nr_instances,
-				 sizeof(struct edac_device_instance),
-				 GFP_KERNEL | __GFP_ZERO);
+	dev_inst = kcalloc(nr_instances, sizeof(struct edac_device_instance), GFP_KERNEL);
 	if (!dev_inst)
 		goto free;
 
@@ -87,9 +85,8 @@ edac_device_alloc_ctl_info(unsigned pvt_sz, char *dev_name, unsigned nr_instance
 	dev_ctl->blocks = dev_blk;
 
 	if (nr_attrib) {
-		dev_attrib = kmalloc_array(nr_attrib,
-					   sizeof(struct edac_dev_sysfs_block_attribute),
-					   GFP_KERNEL | __GFP_ZERO);
+		dev_attrib = kcalloc(nr_attrib, sizeof(struct edac_dev_sysfs_block_attribute),
+				     GFP_KERNEL);
 		if (!dev_attrib)
 			goto free;
 
diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 387b6851c975..eb58644bb019 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -366,7 +366,7 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
 	if (!mci)
 		return NULL;
 
-	mci->layers = kmalloc_array(n_layers, sizeof(struct edac_mc_layer), GFP_KERNEL | __GFP_ZERO);
+	mci->layers = kcalloc(n_layers, sizeof(struct edac_mc_layer), GFP_KERNEL);
 	if (!mci->layers)
 		goto error;
 
-- 
2.35.1

