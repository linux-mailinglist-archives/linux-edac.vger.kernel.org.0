Return-Path: <linux-edac+bounces-5473-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D654BC6F0CE
	for <lists+linux-edac@lfdr.de>; Wed, 19 Nov 2025 14:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id E69A42B1B4
	for <lists+linux-edac@lfdr.de>; Wed, 19 Nov 2025 13:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AE6364E91;
	Wed, 19 Nov 2025 13:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RqfKd18+"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A1E22CBC0;
	Wed, 19 Nov 2025 13:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763560374; cv=none; b=R3HhpmhM8bNT+15k2xFtqbff66j5BBIa+/M6Igx8JlHHYAF3+T1DnivnGmQLSYpthSJvgo7+hZ9uYIT9ho+OFmXJrO9j728Vq8bDFzXD/fXS+NIACuvsA8bDkODh9a7E31ZNw3sfHqG35ARsFPmBpdnyijZGNbgqZd2WkGdjx/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763560374; c=relaxed/simple;
	bh=Ip+OfuruZplu6JDngj96v/lpIV4100IUqpyPeNFbO9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sTA37MA+rVsEZ1ovYn/zPU3MItu/OTb2+cBJCXZyTfmURVLGQUEpwKg9SklGDuzLZpNse+6zjKqfKvslKLqzC17I+So9yuLxlCvJKaUPmWq8jVDDredpY1O46pSgDqU4WI1v6Kcg3rk2TD6mUpwslUJwkbEsedYk1jKGBE1utyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RqfKd18+; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763560373; x=1795096373;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ip+OfuruZplu6JDngj96v/lpIV4100IUqpyPeNFbO9U=;
  b=RqfKd18+LxWgB5YVO9keZoxlbDOBJ+2ooelSvsFdL3k1ioO9oDPTquRt
   YX67LAJ9klXjFffXBWU3FNUuh9aqGx4XaFX4v6CSwsubyRgv6Ej0yC8b2
   tvh7PizDZ+35mHfwawxhx4CptyhhIuQlbDhEF0jqElC73ZOEdBxDm0air
   hzoSrCGUjQJsb3LKLCUl5/pEisorTgV9Dl3XSIVQ+6Evrr4972CNbicxq
   Ng5amEd+l6dFrZRvj1s/u1U14sU62Lv/DJVw0KE4SIIodhI1IdHxFiI2Z
   Tla6AgR/mgfH5y8QxzP2SmPsE2nliBsBc2I+4g5gcwL7fsrKADE3BXuDR
   g==;
X-CSE-ConnectionGUID: 3j6/pvGCRViKp+Yptd37EQ==
X-CSE-MsgGUID: dVHaQQebRlqHlgDh8zU9fQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="64607410"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="64607410"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 05:52:52 -0800
X-CSE-ConnectionGUID: Obu4ruGaTc6x5azfYvulWQ==
X-CSE-MsgGUID: s/VB47YYRCy4lDvgbwMSag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="214439641"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 05:52:50 -0800
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Yi Lai <yi1.lai@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] EDAC/skx_common: Extend the maximum number of DRAM chip row bits
Date: Wed, 19 Nov 2025 21:41:29 +0800
Message-ID: <20251119134132.2389472-6-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251119134132.2389472-1-qiuxu.zhuo@intel.com>
References: <20251119134132.2389472-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The allowed maximum number of row bits for DRAM chips in the Diamond
Rapids server processor is up to 19. Extend the current maximum row
bits from 18 to 19.

Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/skx_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 32a4ef27a987..3276afe43922 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -451,7 +451,7 @@ static int skx_get_dimm_attr(u32 reg, int lobit, int hibit, int add,
 }
 
 #define numrank(reg)	skx_get_dimm_attr(reg, 12, 13, 0, 0, 2, "ranks")
-#define numrow(reg)	skx_get_dimm_attr(reg, 2, 4, 12, 1, 6, "rows")
+#define numrow(reg)	skx_get_dimm_attr(reg, 2, 4, 12, 1, 7, "rows")
 #define numcol(reg)	skx_get_dimm_attr(reg, 0, 1, 10, 0, 2, "cols")
 
 int skx_get_dimm_info(u32 mtr, u32 mcmtr, u32 amap, struct dimm_info *dimm,
-- 
2.43.0


