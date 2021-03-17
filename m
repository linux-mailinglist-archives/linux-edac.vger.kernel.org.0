Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE76033EAC3
	for <lists+linux-edac@lfdr.de>; Wed, 17 Mar 2021 08:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhCQHrv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 17 Mar 2021 03:47:51 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:36109 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230250AbhCQHrb (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 17 Mar 2021 03:47:31 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0USESriJ_1615967247;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0USESriJ_1615967247)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 17 Mar 2021 15:47:27 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     tony.luck@intel.com
Cc:     qiuxu.zhuo@intel.com, bp@alien8.de, mchehab@kernel.org,
        james.morse@arm.com, rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] EDAC: use NULL instead of using plain integer as pointer
Date:   Wed, 17 Mar 2021 15:47:25 +0800
Message-Id: <1615967245-35819-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This fixes the following sparse warnings:
drivers/edac/sb_edac.c:433:10: warning: Using plain integer as NULL
pointer
drivers/edac/sb_edac.c:499:10: warning: Using plain integer as NULL
pointer
drivers/edac/sb_edac.c:570:10: warning: Using plain integer as NULL
pointer
drivers/edac/sb_edac.c:614:10: warning: Using plain integer as NULL
pointer
drivers/edac/sb_edac.c:680:10: warning: Using plain integer as NULL
pointer

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/edac/sb_edac.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 93daa42..a99df55 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -433,7 +433,7 @@ struct sbridge_pvt {
 
 static const struct pci_id_table pci_dev_descr_sbridge_table[] = {
 	PCI_ID_TABLE_ENTRY(pci_dev_descr_sbridge, ARRAY_SIZE(pci_dev_descr_sbridge), 1, SANDY_BRIDGE),
-	{0,}			/* 0 terminated list. */
+	{NULL,}			/* 0 terminated list. */
 };
 
 /* This changes depending if 1HA or 2HA:
@@ -499,7 +499,7 @@ struct sbridge_pvt {
 
 static const struct pci_id_table pci_dev_descr_ibridge_table[] = {
 	PCI_ID_TABLE_ENTRY(pci_dev_descr_ibridge, 12, 2, IVY_BRIDGE),
-	{0,}			/* 0 terminated list. */
+	{NULL,}			/* 0 terminated list. */
 };
 
 /* Haswell support */
@@ -570,7 +570,7 @@ struct sbridge_pvt {
 
 static const struct pci_id_table pci_dev_descr_haswell_table[] = {
 	PCI_ID_TABLE_ENTRY(pci_dev_descr_haswell, 13, 2, HASWELL),
-	{0,}			/* 0 terminated list. */
+	{NULL,}			/* 0 terminated list. */
 };
 
 /* Knight's Landing Support */
@@ -614,7 +614,7 @@ struct sbridge_pvt {
 
 static const struct pci_id_table pci_dev_descr_knl_table[] = {
 	PCI_ID_TABLE_ENTRY(pci_dev_descr_knl, ARRAY_SIZE(pci_dev_descr_knl), 1, KNIGHTS_LANDING),
-	{0,}
+	{NULL,}
 };
 
 /*
@@ -680,7 +680,7 @@ struct sbridge_pvt {
 
 static const struct pci_id_table pci_dev_descr_broadwell_table[] = {
 	PCI_ID_TABLE_ENTRY(pci_dev_descr_broadwell, 10, 2, BROADWELL),
-	{0,}			/* 0 terminated list. */
+	{NULL,}			/* 0 terminated list. */
 };
 
 
-- 
1.8.3.1

