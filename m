Return-Path: <linux-edac+bounces-1742-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2DE963B84
	for <lists+linux-edac@lfdr.de>; Thu, 29 Aug 2024 08:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2C9C1C21C4D
	for <lists+linux-edac@lfdr.de>; Thu, 29 Aug 2024 06:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387ED14F130;
	Thu, 29 Aug 2024 06:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="goRHsBek"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8967E1B813;
	Thu, 29 Aug 2024 06:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724912906; cv=none; b=M8iCogk8ZGEaFwB3EoBBHIgtjL5I3sntrAYHLnL3dDpoXHwdmsvnVjVKM0UPLwM6SLEK3xhnLJLRGc1lI1L21olHI3hVQUZi4wMrGb/eERieujUjmFBf0vpARmjnmIXGNe2R3BKih9i5Bz7wKkWBXujHZe5DuFNvnGywi6NmcVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724912906; c=relaxed/simple;
	bh=CC/Lxc2OKAqLqILZZ5OBWYXOqCl5U8tQXMtCMWltyW8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=M3DPbK6fhTfEzQE6cd7j/8qY/08j5gFrmw/7zX1EahvhBXt23VoLqp1JkfCL+1pCdE3dZ2snwZ9mFJuQIlA+ULyTqAIg2BsvkpFGLZWf+QHQY8T9dgopYMQ7Ulicr+QZafdR+oxG6lYGkldjGgyMoudcPGsYrKPIsLDPsP5dfmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=goRHsBek; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724912900; x=1756448900;
  h=from:to:cc:subject:date:message-id;
  bh=CC/Lxc2OKAqLqILZZ5OBWYXOqCl5U8tQXMtCMWltyW8=;
  b=goRHsBekm+oi05veOv+6hJNYwaG3mXON94A0mSPIXOa3PyAtCetAIUxI
   8Mr+/8r2XVwmFmsNsCKz/rJKb0VYxbmMn5bP7oCUfbXIQjXlhN76niGPo
   8vGUfVUUJixXh5OSTml4qDtK9UFTtAMAs2pmiVVVWiujtAqMrVvBhEjpC
   IrVnXhL8Sq9cYIRUuZhJPQK4WKutatBXiNT4hyvLXdh/dHqbKOzI4/ISr
   XR6InXBMDRU1Rg0s2D4p25baq0dla2ySRKQ8eNpu6J3ErLh5J1a3ra+U9
   1yj+XENEQi3blwcm5qBnQYqwPt4pcPihfwtFJoTYoYwyKR77IbzWNRHPZ
   A==;
X-CSE-ConnectionGUID: RGGEa92vTXKPNRbgW87oFQ==
X-CSE-MsgGUID: Jo1IVG3qQuGVNN/fNs3fNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23059903"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="23059903"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 23:28:19 -0700
X-CSE-ConnectionGUID: fI7cP9kvQam7HTqB7XIRPg==
X-CSE-MsgGUID: tYVoKNqDQDSSpvwz0Nv3/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="86684583"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 23:28:17 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] EDAC/{skx_common,i10nm}: Remove the AMAP register for determing DDR5
Date: Thu, 29 Aug 2024 14:13:09 +0800
Message-Id: <20240829061309.57738-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

The configuration flag 'res_config->support_ddr5 = true' sufficiently
indicates DDR5 memory support for Sapphire Rapids and Granite Rapids.
Additionally, the i10nm_edac driver doesn't need to use the AMAP
register for setting the 'fine_grain_bank' of each DIMM. Therefore,
remove the AMAP register for determining DDR5.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/i10nm_base.c | 9 ++-------
 drivers/edac/skx_common.c | 2 +-
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index 24dd896d9a9d..33cdb3016b7c 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -47,10 +47,6 @@
 	readl((m)->mbase + ((m)->hbm_mc ? 0xef8 :	\
 	(res_cfg->type == GNR ? 0xaf8 : 0x20ef8)) +	\
 	(i) * (m)->chan_mmio_sz)
-#define I10NM_GET_AMAP(m, i)		\
-	readl((m)->mbase + ((m)->hbm_mc ? 0x814 :	\
-	(res_cfg->type == GNR ? 0xc14 : 0x20814)) +	\
-	(i) * (m)->chan_mmio_sz)
 #define I10NM_GET_REG32(m, i, offset)	\
 	readl((m)->mbase + (i) * (m)->chan_mmio_sz + (offset))
 #define I10NM_GET_REG64(m, i, offset)	\
@@ -971,7 +967,7 @@ static int i10nm_get_dimm_config(struct mem_ctl_info *mci,
 {
 	struct skx_pvt *pvt = mci->pvt_info;
 	struct skx_imc *imc = pvt->imc;
-	u32 mtr, amap, mcddrtcfg = 0;
+	u32 mtr, mcddrtcfg = 0;
 	struct dimm_info *dimm;
 	int i, j, ndimms;
 
@@ -980,7 +976,6 @@ static int i10nm_get_dimm_config(struct mem_ctl_info *mci,
 			continue;
 
 		ndimms = 0;
-		amap = I10NM_GET_AMAP(imc, i);
 
 		if (res_cfg->type != GNR)
 			mcddrtcfg = I10NM_GET_MCDDRTCFG(imc, i);
@@ -992,7 +987,7 @@ static int i10nm_get_dimm_config(struct mem_ctl_info *mci,
 				 mtr, mcddrtcfg, imc->mc, i, j);
 
 			if (IS_DIMM_PRESENT(mtr))
-				ndimms += skx_get_dimm_info(mtr, 0, amap, dimm,
+				ndimms += skx_get_dimm_info(mtr, 0, 0, dimm,
 							    imc, i, j, cfg);
 			else if (IS_NVDIMM_PRESENT(mcddrtcfg, j))
 				ndimms += skx_get_nvdimm_info(dimm, imc, i, j,
diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 8d18099fd528..724d41322dda 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -363,7 +363,7 @@ int skx_get_dimm_info(u32 mtr, u32 mcmtr, u32 amap, struct dimm_info *dimm,
 	if (imc->hbm_mc) {
 		banks = 32;
 		mtype = MEM_HBM2;
-	} else if (cfg->support_ddr5 && (amap & 0x8)) {
+	} else if (cfg->support_ddr5) {
 		banks = 32;
 		mtype = MEM_DDR5;
 	} else {
-- 
2.17.1


