Return-Path: <linux-edac+bounces-3323-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC17CA589F5
	for <lists+linux-edac@lfdr.de>; Mon, 10 Mar 2025 02:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B877188D643
	for <lists+linux-edac@lfdr.de>; Mon, 10 Mar 2025 01:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DA512A177;
	Mon, 10 Mar 2025 01:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hBMge9cM"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11CBBE6C;
	Mon, 10 Mar 2025 01:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741570091; cv=none; b=IWfP4nOOZEcmzxsncBuP1kU/+nZ6+YDPi0MuGtXRVekr0AYqi1YnkafLHt4D5Ne+VYNXFWklSDJv8OqqS8AyfMHuSuFiSdhA1bTu+bjlFkOjomanhruPoDY4DLNlllGGDdYGZ3H82m80JUp80N6f6pufTU62CyEHrec4FPWZqRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741570091; c=relaxed/simple;
	bh=Dw+Ixr0LHrrDVbNYIne8xDE2qD1/zkynIYYfHWFfDX8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=AwJVMNszH+pjq66LEhJfIF5fkqjNDOZSzoGB/GSlaQ95APeeMZ8oWvy54r8AZOBQHsS7RfwUw6BGc4ybf04jQnA9kE9Nr2NLzHL39yWF2uxgYwQHuJ1SGC+kKts6qNKrEFlWhRhQC9+yT0DzmKr9Y6a0HvnhX64ITAI4mizwDqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hBMge9cM; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741570090; x=1773106090;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Dw+Ixr0LHrrDVbNYIne8xDE2qD1/zkynIYYfHWFfDX8=;
  b=hBMge9cMVAIwxjxoopjOvDzsTmWVkJo4sVtXqtUJnLA4P3boRUlGDteh
   rwAKldmQsrVpS1GA7Zlg5NilU7uCnu9NiqYEg+QUxdjw+Gil6Di1ykVAp
   LF4L7KcBzjBPPMFNeEv+q3GywpyE8fl0dvx4hIe8PGB+KkUNMBKmOrPel
   w7MvuufprAtZStvzhh5fLa44CkGcG7gFw9POPj/+ibaLWpfSHTT/tRPLz
   3eT4OH5a3F+EKhWOhUmAud4SuTYSNcisiXAcbWw+btCH/PrTF/oVsJB7O
   LZ3yBgUIUiITNmOiGzHHHgD0LL5YMnABvVu/STmEty2G9fdIlRDookM83
   w==;
X-CSE-ConnectionGUID: syqnox8RRr+cmjGpeDE5Sg==
X-CSE-MsgGUID: OemmIA0PQbKrtzlp58SWLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="67914548"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="67914548"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 18:28:09 -0700
X-CSE-ConnectionGUID: eEyS0XkwR6yCaxmO+OTJ8w==
X-CSE-MsgGUID: 2FstGjPkRg2QuZda5WKeig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="124925471"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 18:28:07 -0700
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
Subject: [PATCH v2 01/11] EDAC/ie31200: Fix the size of EDAC_MC_LAYER_CHIP_SELECT layer
Date: Mon, 10 Mar 2025 09:14:01 +0800
Message-Id: <20250310011411.31685-2-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250310011411.31685-1-qiuxu.zhuo@intel.com>
References: <20250226015202.36576-1-qiuxu.zhuo@intel.com>
 <20250310011411.31685-1-qiuxu.zhuo@intel.com>
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


