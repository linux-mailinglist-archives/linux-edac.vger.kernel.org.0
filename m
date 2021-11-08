Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499E3447D7E
	for <lists+linux-edac@lfdr.de>; Mon,  8 Nov 2021 11:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238734AbhKHKQ0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 8 Nov 2021 05:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238646AbhKHKPj (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 8 Nov 2021 05:15:39 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C91C061225;
        Mon,  8 Nov 2021 02:12:41 -0800 (PST)
Received: from zn.tnic (p200300ec2f33110088892b77bd117736.dip0.t-ipconnect.de [IPv6:2003:ec:2f33:1100:8889:2b77:bd11:7736])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 157C81EC0532;
        Mon,  8 Nov 2021 11:12:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636366360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=09n/BxWcIS/wpoPlTHkUE3fbYzuqeKtXWX0IynIoGCU=;
        b=X+rE+/Sg1vx8f2dmqU+VpPZVwVtgvV+qaNxy3EahuloQ6rhm5dAF/2rSn0PisDeOMZ3eqt
        1vIksk0vJ9XD9aQV8Y4NSF9b0WJ9TMbMfUgRHhfxR1kqeWyhOjOl59/tF/w4LwjB2XYRK/
        /CT7IrVHmQqEtn7sMEnTsm6+KInBSJM=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-edac@vger.kernel.org
Subject: [PATCH v0 40/42] EDAC/altera: Check notifier registration return value
Date:   Mon,  8 Nov 2021 11:11:55 +0100
Message-Id: <20211108101157.15189-41-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211108101157.15189-1-bp@alien8.de>
References: <20211108101157.15189-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Avoid homegrown notifier registration checks.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: linux-edac@vger.kernel.org
---
 drivers/edac/altera_edac.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 3a6d2416cb0f..49fa7ae77ba3 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -2125,8 +2125,10 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 		int dberror, err_addr;
 
 		edac->panic_notifier.notifier_call = s10_edac_dberr_handler;
-		atomic_notifier_chain_register(&panic_notifier_list,
-					       &edac->panic_notifier);
+
+		if (atomic_notifier_chain_register(&panic_notifier_list,
+						   &edac->panic_notifier))
+			pr_warn("Panic notifier already registered\n");
 
 		/* Printout a message if uncorrectable error previously. */
 		regmap_read(edac->ecc_mgr_map, S10_SYSMGR_UE_VAL_OFST,
-- 
2.29.2

