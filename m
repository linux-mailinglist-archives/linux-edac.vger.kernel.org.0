Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C59F47EA55
	for <lists+linux-edac@lfdr.de>; Fri, 24 Dec 2021 02:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350787AbhLXBcw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 Dec 2021 20:32:52 -0500
Received: from mga18.intel.com ([134.134.136.126]:9874 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245122AbhLXBcv (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 23 Dec 2021 20:32:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640309571; x=1671845571;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=G+4Blk1PEnOk/BdXn40Lnu8L0XGoZgem6KDA9qaNe2c=;
  b=RDU9/wYFtQQbwhIMn8sbu7y9ig1FPuGgJ5Gb6flvGMQA9OIk/tFo6gpb
   6NrzyVhp+IbKHQErF1Al7U7WVukhSTXBcQfw10e8WJr+l/de/ZXsme5C4
   Wda0Sr3xNxCF9b6pgGyMKT3Kfb/vqJtXhaR7G3O2KQvIwl863qO7GmoSI
   GIjkPtQ5PR/P3TxlVvhBjFXYmX2j+z8jaS+QgD83egIZ9FiGlqm9aOQl1
   B8qoQGI1WT5UhOMRHeQsqFfeieQOWl0wOXm8ByXB8oIxU248zD3qcOjLq
   sNwN/oTDYnNs4Lgwrz/FMnSJEUmJtzu6pV7aR6wG9DzFTmM/+BpP7oQZB
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10207"; a="227753434"
X-IronPort-AV: E=Sophos;i="5.88,231,1635231600"; 
   d="scan'208";a="227753434"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 17:32:49 -0800
X-IronPort-AV: E=Sophos;i="5.88,231,1635231600"; 
   d="scan'208";a="756991241"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.115])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 17:32:47 -0800
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Borislav Petkov <bp@alien8.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] EDAC/i10nm: Release mdev/mbase when failing to detect HBM
Date:   Fri, 24 Dec 2021 04:11:26 -0500
Message-Id: <20211224091126.1246-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <202112161000.15tF7PTx-lkp@intel.com>
References: <202112161000.15tF7PTx-lkp@intel.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Commit in Fixes doesn't release mdev/mbase when failing to detect
HBM. Add the code to release mdev/mbase when failing to detect HBM.

Fixes: c945088384d0 ("EDAC/i10nm: Add support for high bandwidth memory")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/i10nm_base.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index 83345bfac246..6cf50ee0b77c 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -358,6 +358,9 @@ static int i10nm_get_hbm_munits(void)
 
 			mbase = ioremap(base + off, I10NM_HBM_IMC_MMIO_SIZE);
 			if (!mbase) {
+				pci_dev_put(d->imc[lmc].mdev);
+				d->imc[lmc].mdev = NULL;
+
 				i10nm_printk(KERN_ERR, "Failed to ioremap for hbm mc 0x%llx\n",
 					     base + off);
 				return -ENOMEM;
@@ -368,6 +371,12 @@ static int i10nm_get_hbm_munits(void)
 
 			mcmtr = I10NM_GET_MCMTR(&d->imc[lmc], 0);
 			if (!I10NM_IS_HBM_IMC(mcmtr)) {
+				iounmap(d->imc[lmc].mbase);
+				d->imc[lmc].mbase = NULL;
+				d->imc[lmc].hbm_mc = false;
+				pci_dev_put(d->imc[lmc].mdev);
+				d->imc[lmc].mdev = NULL;
+
 				i10nm_printk(KERN_ERR, "This isn't an hbm mc!\n");
 				return -ENODEV;
 			}
-- 
2.17.1

