Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC444D43EE
	for <lists+linux-edac@lfdr.de>; Thu, 10 Mar 2022 10:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241063AbiCJJyS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Mar 2022 04:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241033AbiCJJyE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 10 Mar 2022 04:54:04 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8163B434A1;
        Thu, 10 Mar 2022 01:52:53 -0800 (PST)
Received: from zn.tnic (p200300ea97193878fa50b3d92789953a.dip0.t-ipconnect.de [IPv6:2003:ea:9719:3878:fa50:b3d9:2789:953a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 292681EC0644;
        Thu, 10 Mar 2022 10:52:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1646905972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V0Fb300fSebS4i9B9w/sAZrMoYBxU/8cREsoOOVoTbM=;
        b=Yp3eidbngjg7IwQDczK2Pm2FpoQo2PycDMK2CzW4MJdqHg8+FMfvGunUWnrf+4nKCw0BQA
        Q+4LuiBqLoSAlSrWt5Lca5mFlELxdtsVwglrd72jhG/6Xuwhh+rLGfaLulkj49PgP1WGDh
        wkc3W2lj5Qv5430qmZ6Shw7KdIU3hRw=
From:   Borislav Petkov <bp@alien8.de>
To:     linux-edac <linux-edac@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/5] EDAC/pci: Get rid of the silly one-shot memory allocation in edac_pci_alloc_ctl_info()
Date:   Thu, 10 Mar 2022 10:52:51 +0100
Message-Id: <20220310095254.1510-3-bp@alien8.de>
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

Use boring kzalloc() instead.

There should be no functional changes resulting from this.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/edac/edac_pci.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/edac/edac_pci.c b/drivers/edac/edac_pci.c
index 48c844a72a27..2205d7e731db 100644
--- a/drivers/edac/edac_pci.c
+++ b/drivers/edac/edac_pci.c
@@ -29,32 +29,31 @@ static LIST_HEAD(edac_pci_list);
 static atomic_t pci_indexes = ATOMIC_INIT(0);
 
 struct edac_pci_ctl_info *edac_pci_alloc_ctl_info(unsigned int sz_pvt,
-						const char *edac_pci_name)
+						  const char *edac_pci_name)
 {
 	struct edac_pci_ctl_info *pci;
-	void *p = NULL, *pvt;
-	unsigned int size;
 
 	edac_dbg(1, "\n");
 
-	pci = edac_align_ptr(&p, sizeof(*pci), 1);
-	pvt = edac_align_ptr(&p, 1, sz_pvt);
-	size = ((unsigned long)pvt) + sz_pvt;
-
-	/* Alloc the needed control struct memory */
-	pci = kzalloc(size, GFP_KERNEL);
-	if (pci  == NULL)
+	pci = kzalloc(sizeof(struct edac_pci_ctl_info), GFP_KERNEL);
+	if (!pci)
 		return NULL;
 
-	/* Now much private space */
-	pvt = sz_pvt ? ((char *)pci) + ((unsigned long)pvt) : NULL;
+	if (sz_pvt) {
+		pci->pvt_info = kzalloc(sz_pvt, GFP_KERNEL);
+		if (!pci->pvt_info)
+			goto free;
+	}
 
-	pci->pvt_info = pvt;
 	pci->op_state = OP_ALLOC;
 
 	snprintf(pci->name, strlen(edac_pci_name) + 1, "%s", edac_pci_name);
 
 	return pci;
+
+free:
+	kfree(pci);
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(edac_pci_alloc_ctl_info);
 
-- 
2.29.2

