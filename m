Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 625551766C
	for <lists+linux-edac@lfdr.de>; Wed,  8 May 2019 13:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfEHLIS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 8 May 2019 07:08:18 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58466 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbfEHLIS (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 8 May 2019 07:08:18 -0400
Received: from zn.tnic (p2E584D41.dip0.t-ipconnect.de [46.88.77.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6759D1EC0C12;
        Wed,  8 May 2019 13:08:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1557313696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=VAvkdEAhjrbk9stbIW++ThlQ9foWSny29PRehsUDR34=;
        b=KhU+nnqH2ORWxbl99Wg34QsRvs7ky5ml1GVvrpb322vb4KEBZGi5r5V9GEkV3kSbeGLnxQ
        e82bNOQ2QVQ54BX3oNZQukImRqe82pDQaSh5S1vBRT8kgPW986gRaWBkV7UyP4UM356XOW
        ezL2hludxFYrlSfFkcXPebJPTYUKQ5o=
Date:   Wed, 8 May 2019 13:06:05 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     PanBian <bianpan2016@163.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] EDAC/sysfs: Drop device references properly
Message-ID: <20190508110605.GE19015@zn.tnic>
References: <1555554438-103953-1-git-send-email-bianpan2016@163.com>
 <20190418172548.GL27160@zn.tnic>
 <20190419003536.GA57795@bianpan2016@163.com>
 <20190419004516.GC559@zn.tnic>
 <20190427214925.GE16338@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190427214925.GE16338@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

--
From: Greg KH <gregkh@linuxfoundation.org>

Do put_device() if device_add() fails.

 [ bp: do device_del() for the successfully created devices in
   edac_create_csrow_objects(), on the unwind path. ]

Signed-off-by: Greg KH <gregkh@linuxfoundation.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20190427214925.GE16338@kroah.com
---
 drivers/edac/edac_mc_sysfs.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index 9b7d396f26e9..7c01e1cc030c 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -449,7 +449,8 @@ static int edac_create_csrow_objects(struct mem_ctl_info *mci)
 		csrow = mci->csrows[i];
 		if (!nr_pages_per_csrow(csrow))
 			continue;
-		put_device(&mci->csrows[i]->dev);
+
+		device_del(&mci->csrows[i]->dev);
 	}
 
 	return err;
@@ -651,9 +652,11 @@ static int edac_create_dimm_object(struct mem_ctl_info *mci,
 	dev_set_drvdata(&dimm->dev, dimm);
 	pm_runtime_forbid(&mci->dev);
 
-	err =  device_add(&dimm->dev);
+	err = device_add(&dimm->dev);
+	if (err)
+		put_device(&dimm->dev);
 
-	edac_dbg(0, "creating rank/dimm device %s\n", dev_name(&dimm->dev));
+	edac_dbg(0, "created rank/dimm device %s\n", dev_name(&dimm->dev));
 
 	return err;
 }
@@ -934,6 +937,7 @@ int edac_create_sysfs_mci_device(struct mem_ctl_info *mci,
 	err = device_add(&mci->dev);
 	if (err < 0) {
 		edac_dbg(1, "failure: create device %s\n", dev_name(&mci->dev));
+		put_device(&mci->dev);
 		goto out;
 	}
 
-- 
2.21.0


-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
