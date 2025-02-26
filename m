Return-Path: <linux-edac+bounces-3205-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7C2A452CB
	for <lists+linux-edac@lfdr.de>; Wed, 26 Feb 2025 03:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62DA23ADA0D
	for <lists+linux-edac@lfdr.de>; Wed, 26 Feb 2025 02:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2537E19ADA2;
	Wed, 26 Feb 2025 02:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JUPcAei1"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8512E2139A1;
	Wed, 26 Feb 2025 02:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740535486; cv=none; b=V1HGPdoQ3PjSYiAY+87PJifziGOxe3sXbC2tBmeRZVUbKmZcMQxMc95ato10OAwRWuouA3UYYcF9f4dIaizactJirjgM/YxsMisBOQYbI/e/xRYjdJJWmox8aizazUtE9LxFKM51xuKJBav7i1qDDHmpC0FxfnMQ/OqWkXS55X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740535486; c=relaxed/simple;
	bh=dUAqaE4/LpIDI/rpwrof+PBLCQu2Pt1O+N9trKDJUN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=FfIFliGXA3V/PM44xu53LPd/zfk2dFat62UN4rcPxMqGyCKjburELZ45ojQ2w7TWi9qpyKO2q9Fs6gKMQpij8AHez2zNtyy9onunP4IQqUtKmzJvFTR+7q/8EKUkB+/eUKlMohJl04HUzQyw5kMydag8H9ACf8fWWqIpslW+WNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JUPcAei1; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740535485; x=1772071485;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=dUAqaE4/LpIDI/rpwrof+PBLCQu2Pt1O+N9trKDJUN4=;
  b=JUPcAei1rxDZjzCr4+6bvzf7+NCJPABPBmA/EzpHUPMzCUx0RNx5kML8
   q8GIWl9O4CT3lHTqy6t+T+POJ4tK2pYMX7BaSynSbgA9gdJtUZ+CSpNth
   TrOO/IClZzbHNiWKo//NwMAuS8SklCWmMPku1CdZYbbx6lO99KtYmzg1Y
   sEFy0S4h1fNLA72Lnhi60QNYLy/BZ4y+93391sPpTYTysBNQh/4viUmyo
   0N7oiUsC7WcI97PgalghID9VHWdyvg81u4Cmfqpy/RXsFFsGusUasYe/p
   qM7ZmkE3BtS0w7cPwVhECb1zzJu9qpjdg7Oc7pRgG3sCJcizfgjhC3rYQ
   w==;
X-CSE-ConnectionGUID: wdo6P8srTYCr17o6+WuUAg==
X-CSE-MsgGUID: cMbud1aZRQWQBKFCRx0X8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="28959733"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="28959733"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 18:04:43 -0800
X-CSE-ConnectionGUID: cWA5//3jSki4eRN3ev9t0Q==
X-CSE-MsgGUID: FjfJNMGwQ8+b6Kq1dLY8Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="121180118"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 18:04:40 -0800
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
Subject: [PATCH 03/11] EDAC/ie31200: Fix the error path order of ie31200_init()
Date: Wed, 26 Feb 2025 09:51:54 +0800
Message-Id: <20250226015202.36576-4-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226015202.36576-1-qiuxu.zhuo@intel.com>
References: <20250226015202.36576-1-qiuxu.zhuo@intel.com>
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


