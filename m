Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A7E6960CD
	for <lists+linux-edac@lfdr.de>; Tue, 14 Feb 2023 11:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbjBNKd2 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 14 Feb 2023 05:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbjBNKd0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 14 Feb 2023 05:33:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056F723DA7;
        Tue, 14 Feb 2023 02:33:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0007B81D06;
        Tue, 14 Feb 2023 10:33:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2381C4339B;
        Tue, 14 Feb 2023 10:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676370801;
        bh=dyRqSGOUAca/ZqKrFgTVbS+m8CxbCuznETx0JizqtTY=;
        h=From:To:Cc:Subject:Date:From;
        b=azYTR01CS69bYBzcElOMOx7GOUmyjBxFqSdjIyoXzVCbaYaiSmpE7z/oqv5ZwXEhu
         D4szzUCrWWodYCV/cnts0Ws++1M7wSz7QMF65uwl+ku9bYqD2k7z32189ZqnsQnZqp
         jfrmzHfDSFBLPZtY2hOnmrlxHAD4gJYodd1FsUSXXkpwJLE/RdNjfx8wlQRKM8hYIs
         50mzmBEKuE964pKpjUq9hvjmjbsmNP4UhOy2BzvdQg52MpRssTSVyUXpZYC9xAETX3
         1y/7n45kFper30E1wa6GQ8NJPkQ+AQhgvYdC/S756N09/bd34g16mIoSkzBqx+6QOJ
         I85ZqkwdeDULw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        William Roche <william.roche@oracle.com>,
        Muralidhara M K <muralimk@amd.com>,
        Jia He <justin.he@arm.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] EDAC/amd64: avoid uninitialized variable use
Date:   Tue, 14 Feb 2023 11:33:14 +0100
Message-Id: <20230214103318.1294909-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

hw_info_get() tries to reserve two sibling devices, but the device IDs are
no longer initialized for Fam17 CPUs:

drivers/edac/amd64_edac.c:3936:7: error: variable 'pci_id1' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
                if (!pvt->umc)
                    ^~~~~~~~~
drivers/edac/amd64_edac.c:3943:37: note: uninitialized use occurs here
        ret = reserve_mc_sibling_devs(pvt, pci_id1, pci_id2);
                                           ^~~~~~~
drivers/edac/amd64_edac.c:3936:3: note: remove the 'if' if its condition is always true
                if (!pvt->umc)
                ^~~~~~~~~~~~~~
drivers/edac/amd64_edac.c:3936:7: error: variable 'pci_id2' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
                if (!pvt->umc)
                    ^~~~~~~~~
drivers/edac/amd64_edac.c:3943:46: note: uninitialized use occurs here
        ret = reserve_mc_sibling_devs(pvt, pci_id1, pci_id2);
                                                    ^~~~~~~
drivers/edac/amd64_edac.c:3936:3: note: remove the 'if' if its condition is always true
                if (!pvt->umc)
                ^~~~~~~~~~~~~~

Move this code into the 'else' branch where it is still possible.

Fixes: 6229235f7c66 ("EDAC/amd64: Remove PCI Function 6")
Fixes: cf981562e627 ("EDAC/amd64: Remove PCI Function 0")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I have no idea if this change makes sense, this is merely a guess
based on the description of the two other commits.
---
 drivers/edac/amd64_edac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 1c4bef1cdf28..a149cd95e806 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3938,11 +3938,11 @@ static int hw_info_get(struct amd64_pvt *pvt)
 	} else {
 		pci_id1 = fam_type->f1_id;
 		pci_id2 = fam_type->f2_id;
-	}
 
-	ret = reserve_mc_sibling_devs(pvt, pci_id1, pci_id2);
-	if (ret)
-		return ret;
+		ret = reserve_mc_sibling_devs(pvt, pci_id1, pci_id2);
+		if (ret)
+			return ret;
+	}
 
 	read_mc_regs(pvt);
 
-- 
2.39.1

