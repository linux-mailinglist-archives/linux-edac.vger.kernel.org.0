Return-Path: <linux-edac+bounces-3203-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF97AA452A4
	for <lists+linux-edac@lfdr.de>; Wed, 26 Feb 2025 03:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 596EE18840EE
	for <lists+linux-edac@lfdr.de>; Wed, 26 Feb 2025 02:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A68C19D89E;
	Wed, 26 Feb 2025 02:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yf879iAU"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EB71624C5;
	Wed, 26 Feb 2025 02:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740535456; cv=none; b=RnYzJBMgDgoC4gkTjqcbdKZOoecRrQQBnYqA1HA6XvRD5O8Eso/QTy06ugvzDtDsnMZMZBn5BzBsehBlLXPyMM1CtBRY5yYhFgoWAXWAUEehI1p/aI60FXQolWsUHKzLdM9xZ4weUY6QRAhaz9PWI7uPymfscZWMu8K5bNrlo7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740535456; c=relaxed/simple;
	bh=Dw+Ixr0LHrrDVbNYIne8xDE2qD1/zkynIYYfHWFfDX8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Z9OqxIgyLH3wT0U8hB/b5nownc8BMAdgD7BlpI/olrjNeKFIiirl4ndOPl24JZzlDLyHCtEl0DAlW4K5JwcJg4Dfdvz3NF3Knk9X28QVH0KS+flk7U2v5v+6Jz4aNwE4T9v3Jey+19fwPXICpp+EmoipkuayRPOkxo8kxSllQIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yf879iAU; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740535454; x=1772071454;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Dw+Ixr0LHrrDVbNYIne8xDE2qD1/zkynIYYfHWFfDX8=;
  b=Yf879iAUxgkN7nXye13spCJlqK68o8wC9QmzUQj4ap5HyNOCqPUlitbn
   CUwaCWxN9uAp6PvPtvSGaAc6879dV+GmmNwHAtKZ2rF361ZQB8VeCEzHu
   PKi50gvZp3SYbh55asl0p8Q5+0o+cuwS+8ver/MX1vhi9HVGJGbQK98uy
   AFNoklRAuiEnwQxLVM84gynzBM9eXhfEhN1/aSqdNLtwivPwFeuO8woQ/
   SINC3IwCJZvcbnTdtX7FcMDs95ONSyjPPqfQg0/I7t9iiCa9WRAIVh8DF
   CKzFt77QMJJzOuAkNBjvI6w9JI+TQqs4nNSLX1Bsf8cTgMkMUsIKeqaZX
   g==;
X-CSE-ConnectionGUID: 8AQVaap5RxGLUyE6Z4xjeA==
X-CSE-MsgGUID: qTtX83NWQ7qXh0IGJcLc9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="28959627"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="28959627"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 18:04:12 -0800
X-CSE-ConnectionGUID: EOdt6HwQQBqG3brAIefJVg==
X-CSE-MsgGUID: I+M5L7v/QumiKBnFLyfX6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="121179866"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 18:03:59 -0800
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
Subject: [PATCH 01/11] EDAC/ie31200: Fix the size of EDAC_MC_LAYER_CHIP_SELECT layer
Date: Wed, 26 Feb 2025 09:51:52 +0800
Message-Id: <20250226015202.36576-2-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226015202.36576-1-qiuxu.zhuo@intel.com>
References: <20250226015202.36576-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

The EDAC_MC_LAYER_CHIP_SELECT layer pertains to the rank, not the DIMM.
Fix its size to reflect the number of ranks instead of the number of DIMMs.
Also delete the unused macros IE31200_{DIMMS,RANKS}.

Fixes: 7ee40b897d18 ("ie31200_edac: Introduce the driver")
Tested-by: Gary Wang <gary.c.wang@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/ie31200_edac.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index c6188de13c00..10301e17014c 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -94,8 +94,6 @@
 	 (((did) & PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_MASK) ==                 \
 	  PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_MASK))
 
-#define IE31200_DIMMS			4
-#define IE31200_RANKS			8
 #define IE31200_RANKS_PER_CHANNEL	4
 #define IE31200_DIMMS_PER_CHANNEL	2
 #define IE31200_CHANNELS		2
@@ -428,7 +426,7 @@ static int ie31200_probe1(struct pci_dev *pdev, int dev_idx)
 
 	nr_channels = how_many_channels(pdev);
 	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
-	layers[0].size = IE31200_DIMMS;
+	layers[0].size = IE31200_RANKS_PER_CHANNEL;
 	layers[0].is_virt_csrow = true;
 	layers[1].type = EDAC_MC_LAYER_CHANNEL;
 	layers[1].size = nr_channels;
-- 
2.17.1


