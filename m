Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A971B54D5
	for <lists+linux-edac@lfdr.de>; Thu, 23 Apr 2020 08:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725562AbgDWGqU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 Apr 2020 02:46:20 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35460 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726032AbgDWGqU (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 23 Apr 2020 02:46:20 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4BC04130DCD682959441;
        Thu, 23 Apr 2020 14:46:15 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Thu, 23 Apr 2020 14:46:08 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <rrichter@marvell.com>, <bp@alien8.de>, <mchehab@kernel.org>,
        <tony.luck@intel.com>, <james.morse@arm.com>
CC:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] EDAC, thunderx: Make some symbols static
Date:   Thu, 23 Apr 2020 14:52:24 +0800
Message-ID: <1587624744-97240-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Fix the following sparse warning:

drivers/edac/thunderx_edac.c:1281:22: warning: symbol 'ocx_dfs_ents'
was not declared. Should it be static?
drivers/edac/thunderx_edac.c:1922:22: warning: symbol 'l2c_tad_dfs_ents'
was not declared. Should it be static?
drivers/edac/thunderx_edac.c:1928:22: warning: symbol 'l2c_cbc_dfs_ents'
was not declared. Should it be static?
drivers/edac/thunderx_edac.c:1934:22: warning: symbol 'l2c_mci_dfs_ents'
was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/edac/thunderx_edac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/thunderx_edac.c b/drivers/edac/thunderx_edac.c
index 34be60f..4af9744 100644
--- a/drivers/edac/thunderx_edac.c
+++ b/drivers/edac/thunderx_edac.c
@@ -1278,7 +1278,7 @@ OCX_DEBUGFS_ATTR(lne23_badcnt, OCX_LNE_BAD_CNT(23));
 
 OCX_DEBUGFS_ATTR(com_int, OCX_COM_INT_W1S);
 
-struct debugfs_entry *ocx_dfs_ents[] = {
+static struct debugfs_entry *ocx_dfs_ents[] = {
 	&debugfs_tlk0_ecc_ctl,
 	&debugfs_tlk1_ecc_ctl,
 	&debugfs_tlk2_ecc_ctl,
@@ -1919,19 +1919,19 @@ static irqreturn_t thunderx_l2c_threaded_isr(int irq, void *irq_id)
 
 L2C_DEBUGFS_ATTR(tad_int, L2C_TAD_INT_W1S);
 
-struct debugfs_entry *l2c_tad_dfs_ents[] = {
+static struct debugfs_entry *l2c_tad_dfs_ents[] = {
 	&debugfs_tad_int,
 };
 
 L2C_DEBUGFS_ATTR(cbc_int, L2C_CBC_INT_W1S);
 
-struct debugfs_entry *l2c_cbc_dfs_ents[] = {
+static struct debugfs_entry *l2c_cbc_dfs_ents[] = {
 	&debugfs_cbc_int,
 };
 
 L2C_DEBUGFS_ATTR(mci_int, L2C_MCI_INT_W1S);
 
-struct debugfs_entry *l2c_mci_dfs_ents[] = {
+static struct debugfs_entry *l2c_mci_dfs_ents[] = {
 	&debugfs_mci_int,
 };
 
-- 
2.6.2

