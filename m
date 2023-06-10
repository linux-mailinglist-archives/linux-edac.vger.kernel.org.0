Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A292972A8F2
	for <lists+linux-edac@lfdr.de>; Sat, 10 Jun 2023 05:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbjFJDxf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 9 Jun 2023 23:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234069AbjFJDw6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 9 Jun 2023 23:52:58 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDCB3C19;
        Fri,  9 Jun 2023 20:52:56 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QdPBN23tYzLmlc;
        Sat, 10 Jun 2023 11:51:08 +0800 (CST)
Received: from huawei.com (10.175.104.170) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sat, 10 Jun
 2023 11:52:53 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <mchehab@kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>
CC:     <james.morse@arm.com>, <rric@kernel.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] EDAC/ghes: mark some functions __init
Date:   Sat, 10 Jun 2023 11:52:37 +0800
Message-ID: <20230610035237.1017638-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

They're only called from __init section. So mark them __init too.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 drivers/edac/ghes_edac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index cf2b618c1ada..ea0be56543e5 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -200,7 +200,7 @@ static void assign_dmi_dimm_info(struct dimm_info *dimm, struct memdev_dmi_entry
 	dimm->smbios_handle = entry->handle;
 }
 
-static void enumerate_dimms(const struct dmi_header *dh, void *arg)
+static void __init enumerate_dimms(const struct dmi_header *dh, void *arg)
 {
 	struct memdev_dmi_entry *entry = (struct memdev_dmi_entry *)dh;
 	struct ghes_hw_desc *hw = (struct ghes_hw_desc *)arg;
@@ -231,7 +231,7 @@ static void enumerate_dimms(const struct dmi_header *dh, void *arg)
 	hw->num_dimms++;
 }
 
-static void ghes_scan_system(void)
+static void __init ghes_scan_system(void)
 {
 	if (system_scanned)
 		return;
@@ -385,7 +385,7 @@ static struct notifier_block ghes_edac_mem_err_nb = {
 	.priority	= 0,
 };
 
-static int ghes_edac_register(struct device *dev)
+static int __init ghes_edac_register(struct device *dev)
 {
 	bool fake = false;
 	struct mem_ctl_info *mci;
-- 
2.27.0

