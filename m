Return-Path: <linux-edac+bounces-4483-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C86B17391
	for <lists+linux-edac@lfdr.de>; Thu, 31 Jul 2025 16:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F05671C24A32
	for <lists+linux-edac@lfdr.de>; Thu, 31 Jul 2025 14:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A091EB9FF;
	Thu, 31 Jul 2025 14:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gb3cmjsJ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFCB1C07C3;
	Thu, 31 Jul 2025 14:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753973897; cv=none; b=CXWdab7d6Z9LKQeukhBMAUYDyYyqsBx9WU1EvWYtZxSBjiHWRRFFJe8UxxDPoM8LO73bx0LPSAw7KuYf+MJoPs4gIml6A+0/Jz5aK+DKH+XKxKHQQFGuTga0eC1y/vp0CEBTIg0ft2AcL/42KZSkb4UZw42ZDR0+ro18F5mq1z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753973897; c=relaxed/simple;
	bh=CsQ0NsLhZC3D51og3rV3ztx5MRn/2Yqq7eYgtmtxpV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFedSryR3CkmU/Rktnjwr9pI7jx5owD/1ccoyNVHCeqi5yU00PyTC/6yNgY1AAV5OCdro/EzjJf1VnJzRqj+ym+z+o44+9M4PKlrxZOEZlGdsTYVHRwsNasw2hOVx6vo2enPJJ5G/e/Nmwvncn515zZlanortRM+gj4jGj1FqRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gb3cmjsJ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753973896; x=1785509896;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CsQ0NsLhZC3D51og3rV3ztx5MRn/2Yqq7eYgtmtxpV4=;
  b=gb3cmjsJhau66dUW0F6fCmhFQlYgq0ct+poOfrlO9nIJz1xvxTnmJH5n
   yfRnR7sywBaT/zZZYto+MuSwVwMsT308rHksGjYENPr9PLGLwhUGx9SOe
   Nu7irW3Gsq1JGgB2+yXfqj/SCmqsMtfwJL9c/1/WZspqNcmzqj0bpEqqi
   zqkQc181AKlstZETTa6/2+9z9kOdudzJvMhW0gXx6J6HmYA+gxQAHHFfQ
   u/GuqPvwkKlauJgKmIBW+R49gZZAv4mr9LUKipW8P/wlVF98WXSDejVpc
   KyVKP1fUphAW4zvZAhZMsEbN8636Wtg91/Z4c72yE0qHmgBXVyC0ZI8Z8
   w==;
X-CSE-ConnectionGUID: g2dd9V7gTZKqDniJn9a5xQ==
X-CSE-MsgGUID: r9D/5JllRJKDjlFQQH7aSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="56231800"
X-IronPort-AV: E=Sophos;i="6.17,353,1747724400"; 
   d="scan'208";a="56231800"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 07:58:15 -0700
X-CSE-ConnectionGUID: 1RJvmsxBQ1WiiltlHGtAxA==
X-CSE-MsgGUID: egnMO/jcQ92Hiu8Qa33pSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,353,1747724400"; 
   d="scan'208";a="163633496"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 07:58:13 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Lai Yi <yi1.lai@linux.intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] EDAC/skx_common: Make skx_dev->imc[] a flexible array
Date: Thu, 31 Jul 2025 22:55:31 +0800
Message-ID: <20250731145534.2759334-5-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250731145534.2759334-1-qiuxu.zhuo@intel.com>
References: <20250731145534.2759334-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current skx->imc[NUM_IMC] array of memory controller instances is
sized using the macro NUM_IMC. Each time EDAC support is added for a
new CPU, NUM_IMC needs to be updated to ensure it is greater than or
equal to the number of memory controllers for the new CPU. This approach
is inconvenient and results in memory waste for older CPUs with fewer
memory controllers.

To address this, make skx->imc[] a flexible array and determine its size
from configuration data or at runtime.

Suggested-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/skx_common.c | 3 ++-
 drivers/edac/skx_common.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 744706334b9d..dffd75144060 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -17,6 +17,7 @@
 #include <linux/acpi.h>
 #include <linux/dmi.h>
 #include <linux/adxl.h>
+#include <linux/overflow.h>
 #include <acpi/nfit.h>
 #include <asm/mce.h>
 #include <asm/uv/uv.h>
@@ -343,7 +344,7 @@ int skx_get_all_bus_mappings(struct res_config *cfg, struct list_head **list)
 		if (!pdev)
 			break;
 		ndev++;
-		d = kzalloc(sizeof(*d), GFP_KERNEL);
+		d = kzalloc(struct_size(d, imc, imc_num), GFP_KERNEL);
 		if (!d) {
 			pci_dev_put(pdev);
 			return -ENOMEM;
diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index 95d61d23f89e..e7038fd45d06 100644
--- a/drivers/edac/skx_common.h
+++ b/drivers/edac/skx_common.h
@@ -172,7 +172,7 @@ struct skx_dev {
 				u8 colbits;
 			} dimms[NUM_DIMMS];
 		} chan[NUM_CHANNELS];
-	} imc[NUM_IMC];
+	} imc[];
 };
 
 struct skx_pvt {
-- 
2.43.0


