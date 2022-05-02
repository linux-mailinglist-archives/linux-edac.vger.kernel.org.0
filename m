Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C95516D4C
	for <lists+linux-edac@lfdr.de>; Mon,  2 May 2022 11:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344711AbiEBJ1w (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 2 May 2022 05:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbiEBJ1v (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 2 May 2022 05:27:51 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523563BBD8;
        Mon,  2 May 2022 02:24:22 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D18AF1EC01E0;
        Mon,  2 May 2022 11:24:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1651483456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=RPW0vagqKHOtl5OB781xZjCEvbh3RFdFvxOJZCu3QUw=;
        b=EtlnoMp+siF7Jcq0gACzieL4K0m888hyMlxHxdG1g7w4LfENPSuEEXNchtcWBjtH3tZLrX
        wRnerGphpHZcj4pUEvHQ3nYTqoMeFOEKd2YdeTRj0Hw+bo3Q3b5Hi+5Mttc7F+m585JaJs
        Xr3AectX74zsO2xVhTKwjCGtB0AbV3Q=
Date:   Mon, 2 May 2022 11:24:14 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     linux-edac <linux-edac@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] EDAC: Use kcalloc()
Message-ID: <Ym+jPgjk/KJPMvx4@zn.tnic>
References: <20220412211957.28899-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220412211957.28899-1-bp@alien8.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Apr 12, 2022 at 11:19:57PM +0200, Borislav Petkov wrote:

v2 with one forgotten instance converted:

---
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
   5704     120       4    5828    16c4 edac_device.o.before
   5704     120       4    5828    16c4 edac_device.o.after

md5:
   880563c859da6eb9aca85ec431fdbaeb  edac_device.o.before.asm
   880563c859da6eb9aca85ec431fdbaeb  edac_device.o.after.asm

No functional changes.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/edac/edac_device.c | 13 ++++---------
 drivers/edac/edac_mc.c     |  2 +-
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
index b737349184e3..19522c568aa5 100644
--- a/drivers/edac/edac_device.c
+++ b/drivers/edac/edac_device.c
@@ -70,26 +70,21 @@ edac_device_alloc_ctl_info(unsigned pvt_sz, char *dev_name, unsigned nr_instance
 	if (!dev_ctl)
 		return NULL;
 
-	dev_inst = kmalloc_array(nr_instances,
-				 sizeof(struct edac_device_instance),
-				 GFP_KERNEL | __GFP_ZERO);
+	dev_inst = kcalloc(nr_instances, sizeof(struct edac_device_instance), GFP_KERNEL);
 	if (!dev_inst)
 		goto free;
 
 	dev_ctl->instances = dev_inst;
 
-	dev_blk = kmalloc_array(nr_instances * nr_blocks,
-				sizeof(struct edac_device_block),
-				GFP_KERNEL | __GFP_ZERO);
+	dev_blk = kcalloc(nr_instances * nr_blocks, sizeof(struct edac_device_block), GFP_KERNEL);
 	if (!dev_blk)
 		goto free;
 
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


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
