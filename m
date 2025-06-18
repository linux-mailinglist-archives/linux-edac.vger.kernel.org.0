Return-Path: <linux-edac+bounces-4175-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5AFADF286
	for <lists+linux-edac@lfdr.de>; Wed, 18 Jun 2025 18:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FE9118944C2
	for <lists+linux-edac@lfdr.de>; Wed, 18 Jun 2025 16:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B502EF2B0;
	Wed, 18 Jun 2025 16:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DtDwO1lx"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF341C861F;
	Wed, 18 Jun 2025 16:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750263868; cv=none; b=scmlwEi2UyxFaSB2mMEihDb1Ng5eN2g5zkmcSK00RiRg5Tu9guLrT8wyJjxe46DT89PCzx+qNAFeOLP22VHuwYj+2clp+37SadzLyPRayDk0d0EAbAhj/3fTzUgYbVpx+dAuwsoB8Riu7m/mWAvhiwFCvxMEZc8ltgLCjOTGXaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750263868; c=relaxed/simple;
	bh=RZLGYfaorj7vF+OMteyT5O169vk7XgFPunugw9x/f4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JjHwWztGBZ1AF2Kx/4sP+JSPpxcfXy0jBJpQTQ2nHLTVNaIctSO3fV7yqzhwXkEvHD9PFK11jCcKKSCwGKI5JSqKP5wuCxk+WfP5GRqFwmI2sXoprGu4Ps3aB6M1sualqG+4bis0oWi6qSI5AmvQcPNvOTcouGx1p0cVb6TX+tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DtDwO1lx; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750263867; x=1781799867;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RZLGYfaorj7vF+OMteyT5O169vk7XgFPunugw9x/f4Q=;
  b=DtDwO1lxYRX/Epxgwn7SGZQdo28z9AEqPDbk7vzJ7yqaBMViNufNHIU8
   ikZ/YpWmhWOOQVYdoebcVypZ/SwRDbsdEIWXO41xMbHHTmsw+GsevjQSp
   Sz0QClm0bZkS8Q8o4yA0ZRDnQ1CB99m16KQS5OtgDPDp8MV494PHJXoDQ
   f4q8fdlvGaz/Dtl428N1txS1XQ0Jnb58ZvhTqlVpiarrYkGnGJmbCbizj
   sJ64Kv4/BzB3j/EG23q5H81ihPqnEC1uBrkEyBcB64bPRYP5VlBLJC5+o
   TueYQIVZfNSJDLI9MgTmj5FNQp5hCKi5xWOArsS0gKRhK+zHnpUg5nWT8
   A==;
X-CSE-ConnectionGUID: n0ArERtQQJOj0u6nOx0FlA==
X-CSE-MsgGUID: iOxYjQQqQC6sv49c2KEJhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="52467538"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="52467538"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 09:24:26 -0700
X-CSE-ConnectionGUID: XL4ThxE8TIWSWonJb9OJUA==
X-CSE-MsgGUID: SfednA76TLOLTjayEEjX3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="150533726"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 09:24:23 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: tony.luck@intel.com,
	bp@alien8.de
Cc: james.morse@arm.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marmarek@invisiblethingslab.com,
	mchehab@kernel.org,
	qiuxu.zhuo@intel.com,
	rric@kernel.org
Subject: [PATCH v2 2/2] EDAC/igen6: Reduce log level to debug for absent memory controllers
Date: Thu, 19 Jun 2025 00:23:07 +0800
Message-ID: <20250618162307.1523736-2-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618162307.1523736-1-qiuxu.zhuo@intel.com>
References: <aFLV2YMOzXe4iP-I@agluck-desk3>
 <20250618162307.1523736-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current KERN_WARNING level message for detecting absent memory
controllers is overly dramatic. The BIOS likely had valid reasons to
disable the memory controller (e.g. it isn't connected to any DIMM
slots on the motherboard for this system). So there's nothing actually
wrong that needs to be fixed.

Reduce the log level to KERN_DEBUG to eliminate the false warning.

Suggested-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/igen6_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index 1cb5c67e78ae..5ffe9579959f 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -1351,7 +1351,7 @@ static int igen6_register_mcis(struct pci_dev *pdev, u64 mchbar)
 	}
 
 	if (lmc < res_cfg->num_imc) {
-		igen6_printk(KERN_WARNING, "Expected %d mcs, but only %d detected.",
+		igen6_printk(KERN_DEBUG, "Expected %d mcs, but only %d detected.",
 			     res_cfg->num_imc, lmc);
 		res_cfg->num_imc = lmc;
 	}
-- 
2.43.0


