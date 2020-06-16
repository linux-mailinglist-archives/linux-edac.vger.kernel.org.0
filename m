Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E8A1FBCDC
	for <lists+linux-edac@lfdr.de>; Tue, 16 Jun 2020 19:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730801AbgFPR1v (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 16 Jun 2020 13:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729241AbgFPR1u (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 16 Jun 2020 13:27:50 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAF2C061573;
        Tue, 16 Jun 2020 10:27:50 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f4c001d7e5f403e90d72b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:4c00:1d7e:5f40:3e90:d72b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C5DD51EC03AC;
        Tue, 16 Jun 2020 19:27:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592328468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cumoy0mABNpxDdDaNdwweDyc0gOKs5OmHE1VxSQjrgM=;
        b=L5+qT7uCD4UEsrpR4D19zqGcsqAIKuSlpinkKfdqYQhbiNQp/azdPMYW2EzGluHOfkuGsC
        D1EdwMu4Z5jo306h7gWfdcAuxPGs/kcF+mvmW3LLjfxu/adHggl3f/bakwkBG6xD8A7SGB
        CSRTjQSvQrNs1pa2RZ5aho3iW2qtSV4=
From:   Borislav Petkov <bp@alien8.de>
To:     Mauro Carvalho Chehab <mchehab@infradead.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/4] EDAC/ghes: Remove unused members of struct ghes_edac_pvt, rename it to ghes_pvt
Date:   Tue, 16 Jun 2020 19:27:35 +0200
Message-Id: <20200616172737.30171-3-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200616172737.30171-1-bp@alien8.de>
References: <20200616172737.30171-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Robert Richter <rrichter@marvell.com>

The struct members list and ghes of struct ghes_edac_pvt are unused,
remove them. On that occasion, rename it to the shorter name struct
ghes_pvt.

Signed-off-by: Robert Richter <rrichter@marvell.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200519104443.15673-2-rrichter@marvell.com
---
 drivers/edac/ghes_edac.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 94c70c95a896..f4f9ae32c743 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -15,9 +15,7 @@
 #include "edac_module.h"
 #include <ras/ras_event.h>
 
-struct ghes_edac_pvt {
-	struct list_head list;
-	struct ghes *ghes;
+struct ghes_pvt {
 	struct mem_ctl_info *mci;
 
 	/* Buffers for the error handling routine */
@@ -32,7 +30,7 @@ static refcount_t ghes_refcount = REFCOUNT_INIT(0);
  * also provides the necessary (implicit) memory barrier for the SMP
  * case to make the pointer visible on another CPU.
  */
-static struct ghes_edac_pvt *ghes_pvt;
+static struct ghes_pvt *ghes_pvt;
 
 /* GHES registration mutex */
 static DEFINE_MUTEX(ghes_reg_mutex);
@@ -212,7 +210,7 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 {
 	struct edac_raw_error_desc *e;
 	struct mem_ctl_info *mci;
-	struct ghes_edac_pvt *pvt;
+	struct ghes_pvt *pvt;
 	unsigned long flags;
 	char *p;
 
@@ -470,7 +468,7 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	bool fake = false;
 	int rc = 0, num_dimm = 0;
 	struct mem_ctl_info *mci;
-	struct ghes_edac_pvt *pvt;
+	struct ghes_pvt *pvt;
 	struct edac_mc_layer layers[1];
 	struct ghes_edac_dimm_fill dimm_fill;
 	unsigned long flags;
@@ -507,7 +505,7 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	layers[0].size = num_dimm;
 	layers[0].is_virt_csrow = true;
 
-	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers, sizeof(struct ghes_edac_pvt));
+	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers, sizeof(struct ghes_pvt));
 	if (!mci) {
 		pr_info("Can't allocate memory for EDAC data\n");
 		rc = -ENOMEM;
@@ -515,7 +513,6 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	}
 
 	pvt		= mci->pvt_info;
-	pvt->ghes	= ghes;
 	pvt->mci	= mci;
 
 	mci->pdev = dev;
-- 
2.21.0

