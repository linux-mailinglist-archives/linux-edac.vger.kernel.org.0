Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F501FBCE1
	for <lists+linux-edac@lfdr.de>; Tue, 16 Jun 2020 19:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgFPR2A (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 16 Jun 2020 13:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728382AbgFPR1x (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 16 Jun 2020 13:27:53 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F6FC06174E;
        Tue, 16 Jun 2020 10:27:51 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f4c001d7e5f403e90d72b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:4c00:1d7e:5f40:3e90:d72b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7B59F1EC03D6;
        Tue, 16 Jun 2020 19:27:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592328470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JpTZBW6WOiaUX1H/zqdpGjGYoDjdyKsEKReQ25W89TE=;
        b=YrLmFDsL3KvylqpcxW0qkQVorEXR4y/QNQcVl45UPGpbRCS3OVyb0vqRVIDjSPkm0Swn4P
        o+XmqCUe3ZQVh7senI8bhD04Y2WUg0OcnJRzwvTRWGgnSpIZdyLl9tCvyLTjTNxWr8BfMn
        R/SqCpbsHF6F6gNESEGadfzp8d0M5CU=
From:   Borislav Petkov <bp@alien8.de>
To:     Mauro Carvalho Chehab <mchehab@infradead.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] EDAC: Remove edac_get_dimm_by_index()
Date:   Tue, 16 Jun 2020 19:27:37 +0200
Message-Id: <20200616172737.30171-5-bp@alien8.de>
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

It is unused now.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 include/linux/edac.h | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/include/linux/edac.h b/include/linux/edac.h
index 6eb7d55d7c3d..15e8f3d8a895 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -594,27 +594,6 @@ struct mem_ctl_info {
 		     ? (mci)->dimms[(dimm)->idx + 1]		\
 		     : NULL)
 
-/**
- * edac_get_dimm_by_index - Get DIMM info at @index from a memory
- * 			    controller
- *
- * @mci:	MC descriptor struct mem_ctl_info
- * @index:	index in the memory controller's DIMM array
- *
- * Returns a struct dimm_info * or NULL on failure.
- */
-static inline struct dimm_info *
-edac_get_dimm_by_index(struct mem_ctl_info *mci, int index)
-{
-	if (index < 0 || index >= mci->tot_dimms)
-		return NULL;
-
-	if (WARN_ON_ONCE(mci->dimms[index]->idx != index))
-		return NULL;
-
-	return mci->dimms[index];
-}
-
 /**
  * edac_get_dimm - Get DIMM info from a memory controller given by
  *                 [layer0,layer1,layer2] position
@@ -650,6 +629,12 @@ static inline struct dimm_info *edac_get_dimm(struct mem_ctl_info *mci,
 	if (mci->n_layers > 2)
 		index = index * mci->layers[2].size + layer2;
 
-	return edac_get_dimm_by_index(mci, index);
+	if (index < 0 || index >= mci->tot_dimms)
+		return NULL;
+
+	if (WARN_ON_ONCE(mci->dimms[index]->idx != index))
+		return NULL;
+
+	return mci->dimms[index];
 }
 #endif /* _LINUX_EDAC_H_ */
-- 
2.21.0

