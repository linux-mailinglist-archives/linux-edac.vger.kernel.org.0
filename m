Return-Path: <linux-edac+bounces-3325-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9EEA589FA
	for <lists+linux-edac@lfdr.de>; Mon, 10 Mar 2025 02:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F32CC188CE42
	for <lists+linux-edac@lfdr.de>; Mon, 10 Mar 2025 01:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062A113C695;
	Mon, 10 Mar 2025 01:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JOxtfXGr"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630E9BE6C;
	Mon, 10 Mar 2025 01:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741570119; cv=none; b=sn5+lSRxeU7Um1fBRBnjiOiImboq/CfsPIDo5OLcQi1cLGxUG7ZsbStD3TajXyOoOLtHZnTqFLtSJxPDc5lXGOlMzbI9yy6NE9dK5vcAdfdHTT/9pLac325BDMF754WmEghqP/zJvHHse67dQ/OHXOTsy4Xmf9RfmYOMQ3qgjag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741570119; c=relaxed/simple;
	bh=dUAqaE4/LpIDI/rpwrof+PBLCQu2Pt1O+N9trKDJUN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=lMJGo5+PZ3O5hyv1RH3xWZnFEQwUIP3RYVKMDD9ly3cJFkTibM3wfLCxU9/NbARW6IQfj0Yh7R+DwR/0qzL4Zizf+n704rx6NIHl51ZrTS7yRfqJZ5MIImIGBemCHXr9p9IoEF/o4sh46BSZdUsu1BYwiN179f5wCow0weo1+c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JOxtfXGr; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741570118; x=1773106118;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=dUAqaE4/LpIDI/rpwrof+PBLCQu2Pt1O+N9trKDJUN4=;
  b=JOxtfXGrNI8xDfIPcQmfiG9uQYg74Y2MYpH5TOx0djv6IgvyedQGePz2
   GCgVlShYSb9BJYEwn4kQVsMwzTzXQfJ2ClFtagWlqXDTeZBdE549lSNHG
   ANdhtvu7nx6UVK66YRkl4pURSD2kq11Rq/8j7g1+Q6q90PeR5i2cPhOPh
   FOzEH2EvqpKmPeDhoPRvDK65EUTOYWgnwsAdFQkb+RsnUIjTt4ej7oS7C
   HaBBb3vD+7F2T+CHwN4F1X81/BoV0g+V/kSz5BkcRG117c34n04U/DnbE
   dDGjcwtD3QFhwnPiaA7D6nfsmc30EFFbDr4X7sbD9a0w6QH4BMsALjceZ
   A==;
X-CSE-ConnectionGUID: 9tvhjqh6RGSQ+8+sNBPQLg==
X-CSE-MsgGUID: /+NxCg1GQjS2mT3nY/V8nA==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="67914568"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="67914568"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 18:28:38 -0700
X-CSE-ConnectionGUID: Ev3yZVRjTsSaHI+CT79E6g==
X-CSE-MsgGUID: 7gfMg9kfRCKNB7sHflnuEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="124925510"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 18:28:35 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Jason Baron <jbaron@akamai.com>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Gary Wang <gary.c.wang@intel.com>,
	Yi Lai <yi1.lai@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/11] EDAC/ie31200: Fix the error path order of ie31200_init()
Date: Mon, 10 Mar 2025 09:14:03 +0800
Message-Id: <20250310011411.31685-4-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250310011411.31685-1-qiuxu.zhuo@intel.com>
References: <20250226015202.36576-1-qiuxu.zhuo@intel.com>
 <20250310011411.31685-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

The error path order of ie31200_init() is incorrect, fix it.

Fixes: 709ed1bcef12 ("EDAC/ie31200: Fallback if host bridge device is already initialized")
Tested-by: Gary Wang <gary.c.wang@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/ie31200_edac.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index 2886866cb457..a8dd55ec52ce 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -619,7 +619,7 @@ static int __init ie31200_init(void)
 
 	pci_rc = pci_register_driver(&ie31200_driver);
 	if (pci_rc < 0)
-		goto fail0;
+		return pci_rc;
 
 	if (!mci_pdev) {
 		ie31200_registered = 0;
@@ -630,11 +630,13 @@ static int __init ie31200_init(void)
 			if (mci_pdev)
 				break;
 		}
+
 		if (!mci_pdev) {
 			edac_dbg(0, "ie31200 pci_get_device fail\n");
 			pci_rc = -ENODEV;
-			goto fail1;
+			goto fail0;
 		}
+
 		pci_rc = ie31200_init_one(mci_pdev, &ie31200_pci_tbl[i]);
 		if (pci_rc < 0) {
 			edac_dbg(0, "ie31200 init fail\n");
@@ -642,12 +644,12 @@ static int __init ie31200_init(void)
 			goto fail1;
 		}
 	}
-	return 0;
 
+	return 0;
 fail1:
-	pci_unregister_driver(&ie31200_driver);
+	pci_dev_put(mci_pdev);
 fail0:
-	pci_dev_put(mci_pdev);
+	pci_unregister_driver(&ie31200_driver);
 
 	return pci_rc;
 }
-- 
2.17.1


