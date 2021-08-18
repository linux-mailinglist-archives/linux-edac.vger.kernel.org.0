Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357383F0AAB
	for <lists+linux-edac@lfdr.de>; Wed, 18 Aug 2021 19:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhHRR5q (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 18 Aug 2021 13:57:46 -0400
Received: from mga09.intel.com ([134.134.136.24]:55653 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229533AbhHRR5o (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 18 Aug 2021 13:57:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10080"; a="216386871"
X-IronPort-AV: E=Sophos;i="5.84,332,1620716400"; 
   d="scan'208";a="216386871"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 10:57:08 -0700
X-IronPort-AV: E=Sophos;i="5.84,332,1620716400"; 
   d="scan'208";a="521178095"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 10:57:08 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     linux-edac@vger.kernel.org
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Fan Du <fan.du@intel.com>,
        Wen Jin <wen.jin@intel.com>, Tony Luck <tony.luck@intel.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] EDAC/i10nm: Fix NVDIMM detection
Date:   Wed, 18 Aug 2021 10:57:00 -0700
Message-Id: <20210818175701.1611513-2-tony.luck@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210818175701.1611513-1-tony.luck@intel.com>
References: <20210818175701.1611513-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

MCDDRCFG is a per-channel register and uses bit{0,1} to indicate
the NVDIMM presence on DIMM slot{0,1}. Current i10nm_edac driver
wrongly uses MCDDRCFG as per-DIMM register and fails to detect
the NVDIMM.

Fix it by reading MCDDRCFG as per-channel register and using its
bit{0,1} to check whether the NVDIMM is populated on DIMM slot{0,1}.

Fixes: d4dc89d069aa ("EDAC, i10nm: Add a driver for Intel 10nm server processors")
Reported-by: Fan Du <fan.du@intel.com>
Tested-by: Wen Jin <wen.jin@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/edac/i10nm_base.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index 6ce0ed2ffaaf..b4a024cb8b97 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -33,9 +33,9 @@
 #define I10NM_GET_DIMMMTR(m, i, j)	\
 	readl((m)->mbase + ((m)->hbm_mc ? 0x80c : 0x2080c) + \
 	(i) * (m)->chan_mmio_sz + (j) * 4)
-#define I10NM_GET_MCDDRTCFG(m, i, j)	\
+#define I10NM_GET_MCDDRTCFG(m, i)	\
 	readl((m)->mbase + ((m)->hbm_mc ? 0x970 : 0x20970) + \
-	(i) * (m)->chan_mmio_sz + (j) * 4)
+	(i) * (m)->chan_mmio_sz)
 #define I10NM_GET_MCMTR(m, i)		\
 	readl((m)->mbase + ((m)->hbm_mc ? 0xef8 : 0x20ef8) + \
 	(i) * (m)->chan_mmio_sz)
@@ -321,10 +321,10 @@ static int i10nm_get_dimm_config(struct mem_ctl_info *mci,
 
 		ndimms = 0;
 		amap = I10NM_GET_AMAP(imc, i);
+		mcddrtcfg = I10NM_GET_MCDDRTCFG(imc, i);
 		for (j = 0; j < imc->num_dimms; j++) {
 			dimm = edac_get_dimm(mci, i, j, 0);
 			mtr = I10NM_GET_DIMMMTR(imc, i, j);
-			mcddrtcfg = I10NM_GET_MCDDRTCFG(imc, i, j);
 			edac_dbg(1, "dimmmtr 0x%x mcddrtcfg 0x%x (mc%d ch%d dimm%d)\n",
 				 mtr, mcddrtcfg, imc->mc, i, j);
 
-- 
2.29.2

