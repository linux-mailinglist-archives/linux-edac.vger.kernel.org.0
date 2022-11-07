Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4236461EE4A
	for <lists+linux-edac@lfdr.de>; Mon,  7 Nov 2022 10:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbiKGJKM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 7 Nov 2022 04:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbiKGJKJ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 7 Nov 2022 04:10:09 -0500
Received: from mellanox.co.il (mail-il-dmz.mellanox.com [193.47.165.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B52A17051
        for <linux-edac@vger.kernel.org>; Mon,  7 Nov 2022 01:10:05 -0800 (PST)
Received: from Internal Mail-Server by MTLPINE1 (envelope-from shravankr@mellanox.com)
        with SMTP; 7 Nov 2022 11:03:20 +0200
Received: from bu-vnc02.mtbu.labs.mlnx (bu-vnc02.mtbu.labs.mlnx [10.15.2.65])
        by mtbu-labmailer.labs.mlnx (8.14.4/8.14.4) with ESMTP id 2A793KB8028160;
        Mon, 7 Nov 2022 04:03:20 -0500
Received: (from shravankr@localhost)
        by bu-vnc02.mtbu.labs.mlnx (8.14.7/8.13.8/Submit) id 2A793JpA008377;
        Mon, 7 Nov 2022 04:03:19 -0500
From:   Shravan Kumar Ramani <shravankr@nvidia.com>
To:     James Morse <james.morse@arm.com>
Cc:     Shravan Kumar Ramani <shravankr@nvidia.com>,
        linux-edac@vger.kernel.org
Subject: [PATCH v1 2/2] EDAC/bluefield_edac: Update license and copyright info
Date:   Mon,  7 Nov 2022 04:02:54 -0500
Message-Id: <9d584ef2522e2cdc9aa28d3f952ab98b17d961a2.1667561793.git.shravankr@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1667561793.git.shravankr@nvidia.com>
References: <cover.1667561793.git.shravankr@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Signed-off-by: Shravan Kumar Ramani <shravankr@nvidia.com>
---
 drivers/edac/bluefield_edac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/bluefield_edac.c b/drivers/edac/bluefield_edac.c
index cb9e42ef64d1..828851c15d97 100644
--- a/drivers/edac/bluefield_edac.c
+++ b/drivers/edac/bluefield_edac.c
@@ -1,8 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
 /*
  * Bluefield-specific EDAC driver.
  *
- * Copyright (c) 2019 Mellanox Technologies.
+ * Copyright (c) 2022 NVIDIA Corporation.
  */
 
 #include <linux/acpi.h>
@@ -488,5 +488,5 @@ static struct platform_driver bluefield_edac_mc_driver = {
 module_platform_driver(bluefield_edac_mc_driver);
 
 MODULE_DESCRIPTION("Mellanox BlueField memory edac driver");
-MODULE_AUTHOR("Mellanox Technologies");
-MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Shravan Kumar Ramani <shravankr@nvidia.com>");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.30.1

