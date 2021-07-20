Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C403CFF78
	for <lists+linux-edac@lfdr.de>; Tue, 20 Jul 2021 18:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbhGTPts (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 20 Jul 2021 11:49:48 -0400
Received: from mga17.intel.com ([192.55.52.151]:55372 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234941AbhGTPtk (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 20 Jul 2021 11:49:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10051"; a="191549411"
X-IronPort-AV: E=Sophos;i="5.84,255,1620716400"; 
   d="scan'208";a="191549411"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 09:30:10 -0700
X-IronPort-AV: E=Sophos;i="5.84,255,1620716400"; 
   d="scan'208";a="661569731"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 09:30:10 -0700
Date:   Tue, 20 Jul 2021 09:30:09 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Naveen Krishna Chatradhi <nchatrad@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>
Subject: [PATCH] EDAC/skx_common: Set the memory type correctly for HBM memory
Message-ID: <20210720163009.GA1417532@agluck-desk2.amr.corp.intel.com>
References: <20210630152828.162659-1-nchatrad@amd.com>
 <20210630152828.162659-4-nchatrad@amd.com>
 <20210719204758.GC19451@aus-x-yghannam.amd.com>
 <df4b694601a947d5b6f3d87c5d776807@intel.com>
 <DM8PR11MB56699B74F47AF7EFB4FB997389E29@DM8PR11MB5669.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR11MB56699B74F47AF7EFB4FB997389E29@DM8PR11MB5669.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Set the memory type to MEM_HBM2 if it's managed by the HBM2
memory controller.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/edac/skx_common.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 5e83f59bef8a..f9120e36bf3a 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -345,7 +345,10 @@ int skx_get_dimm_info(u32 mtr, u32 mcmtr, u32 amap, struct dimm_info *dimm,
 	rows = numrow(mtr);
 	cols = imc->hbm_mc ? 6 : numcol(mtr);
 
-	if (cfg->support_ddr5 && ((amap & 0x8) || imc->hbm_mc)) {
+	if (imc->hbm_mc) {
+		banks = 32;
+		mtype = MEM_HBM2;
+	} else if (cfg->support_ddr5 && (amap & 0x8)) {
 		banks = 32;
 		mtype = MEM_DDR5;
 	} else {
-- 
2.29.2

