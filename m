Return-Path: <linux-edac+bounces-3574-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 868D6A920DE
	for <lists+linux-edac@lfdr.de>; Thu, 17 Apr 2025 17:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D5BC7AF0AC
	for <lists+linux-edac@lfdr.de>; Thu, 17 Apr 2025 15:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DCC252295;
	Thu, 17 Apr 2025 15:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ERKG8JzX"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F1021D3EA;
	Thu, 17 Apr 2025 15:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744902530; cv=none; b=ooG32tK6nGB00PAG+0bWGeHOeXXAhhy8dK9tIoXYO+y1L2kaBaBDt2bZzaVbDq8Kb1AyA3JC7dddFGAhXX1uklKo6b7gej+cI8QySBK+FtcED9hh0cALfc8Pn/PY45FtxgDoITa1ZzawQOsiV3qWkNG5Njl0t7SA4fNHBYmDPAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744902530; c=relaxed/simple;
	bh=F2GZRp++KxKOvNNAn2NVxZTL1RAxokaCzoH8dbomSxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=txINqyqUc/TjyrqEq9PuMXRcR2Qao/32bMXg0f2CD2omUmSg2ayIm5ZD2Au6RaYyaXDMzokbWM6lS2BU7anXuZ69USSvbIylnbvMdkQIui0cMEgd2VoEdPv3M9I7xA2pGAhTbhaz02ezNdeCxoIvU4WLPzqGPYh2AFMi3DeYxGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ERKG8JzX; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744902528; x=1776438528;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F2GZRp++KxKOvNNAn2NVxZTL1RAxokaCzoH8dbomSxA=;
  b=ERKG8JzXEexNOWy7Vg1pA0uwYbrdbhgcNFaChm5Y/ixbBJXN3g78dtpN
   t8W2vlvSqaF0vUfWHhSls1MSTcuLdsjZVGjgVYyDVVlMSAN1+m8DMyJaO
   tqX5mUxrERImrCnQ30YkoctyEsUZ2WKynjkMKQDA30ptZh3O3+qknVXuf
   5tRL6fResCY9aoU541pfmd/xmvBoN+6EXoKAhntQne1mDDad8daRkierK
   K4DLLQign6oJU9or18smOIhjDkrDNaHp2byHqQmpL2Upu5/FbFeyMYrsS
   V0QlcCQUzxpaCOExwh17v6AkwM8VeJoyL29VQwJGWQ8Mhq1iRljSZ23/R
   w==;
X-CSE-ConnectionGUID: bXuu3WHIQ9WMxVWeWX3gFg==
X-CSE-MsgGUID: 083XihPqS3GEtuQf5qMjSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="57488636"
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="57488636"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 08:08:47 -0700
X-CSE-ConnectionGUID: bPmZ1V1mSQmkKcpH/My3DQ==
X-CSE-MsgGUID: a+2UpJGDRZGV3Rq5stfpkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="161876770"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 08:08:45 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Feng Xu <feng.f.xu@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Yi Lai <yi1.lai@intel.com>,
	Shawn Fan <shawn.fan@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] EDAC/skx_common: Fix general protection fault
Date: Thu, 17 Apr 2025 23:07:18 +0800
Message-ID: <20250417150724.1170168-2-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417150724.1170168-1-qiuxu.zhuo@intel.com>
References: <20250417150724.1170168-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After loading i10nm_edac (which automatically loads skx_edac_common), if
unload only i10nm_edac, then reload it and perform error injection testing,
a general protection fault may occur:

  mce: [Hardware Error]: Machine check events logged
  Oops: general protection fault ...
  ...
  Workqueue: events mce_gen_pool_process
  RIP: 0010:string+0x53/0xe0
  ...
  Call Trace:
  <TASK>
  ? die_addr+0x37/0x90
  ? exc_general_protection+0x1e7/0x3f0
  ? asm_exc_general_protection+0x26/0x30
  ? string+0x53/0xe0
  vsnprintf+0x23e/0x4c0
  snprintf+0x4d/0x70
  skx_adxl_decode+0x16a/0x330 [skx_edac_common]
  skx_mce_check_error.part.0+0xf8/0x220 [skx_edac_common]
  skx_mce_check_error+0x17/0x20 [skx_edac_common]
  ...

The issue arose was because the variable 'adxl_component_count' (inside
skx_edac_common), which counts the ADXL components, was not reset. During
the reloading of i10nm_edac, the count was incremented by the actual number
of ADXL components again, resulting in a count that was double the real
number of ADXL components. This led to an out-of-bounds reference to the
ADXL component array, causing the general protection fault above.

Fix this issue by resetting the 'adxl_component_count' in adxl_put(),
which is called during the unloading of {skx,i10nm}_edac.

Fixes: 123b15863550 ("EDAC, i10nm: make skx_common.o a separate module")
Reported-by: Feng Xu <feng.f.xu@intel.com>
Tested-by: Feng Xu <feng.f.xu@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/skx_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index fa5b442b1844..c9ade45c1a99 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -116,6 +116,7 @@ EXPORT_SYMBOL_GPL(skx_adxl_get);
 
 void skx_adxl_put(void)
 {
+	adxl_component_count = 0;
 	kfree(adxl_values);
 	kfree(adxl_msg);
 }
-- 
2.43.0


