Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1141D21F39B
	for <lists+linux-edac@lfdr.de>; Tue, 14 Jul 2020 16:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgGNONT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 14 Jul 2020 10:13:19 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7309 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725821AbgGNONS (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 14 Jul 2020 10:13:18 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CE89CA5F2418CD528226;
        Tue, 14 Jul 2020 22:13:15 +0800 (CST)
Received: from kernelci-master.huawei.com (10.175.101.6) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Tue, 14 Jul 2020 22:13:05 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>,
        Robert Richter <rrichter@marvell.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <linux-edac@vger.kernel.org>
Subject: [PATCH -next] EDAC, thunderx: Make symbol 'lmc_dfs_ents' static
Date:   Tue, 14 Jul 2020 22:23:08 +0800
Message-ID: <20200714142308.46612-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The sparse tool complains as follows:

drivers/edac/thunderx_edac.c:457:22: warning:
 symbol 'lmc_dfs_ents' was not declared. Should it be static?

Symbol 'lmc_dfs_ents' is not used outside of thunderx_edac.c, so
marks it static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/edac/thunderx_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/thunderx_edac.c b/drivers/edac/thunderx_edac.c
index 4af9744cc6d0..0eb5eb97fd74 100644
--- a/drivers/edac/thunderx_edac.c
+++ b/drivers/edac/thunderx_edac.c
@@ -454,7 +454,7 @@ DEBUGFS_STRUCT(inject_int, 0200, thunderx_lmc_inject_int_write, NULL);
 DEBUGFS_STRUCT(inject_ecc, 0200, thunderx_lmc_inject_ecc_write, NULL);
 DEBUGFS_STRUCT(int_w1c, 0400, NULL, thunderx_lmc_int_read);
 
-struct debugfs_entry *lmc_dfs_ents[] = {
+static struct debugfs_entry *lmc_dfs_ents[] = {
 	&debugfs_mask0,
 	&debugfs_mask2,
 	&debugfs_parity_test,

