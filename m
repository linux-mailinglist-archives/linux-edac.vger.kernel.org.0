Return-Path: <linux-edac+bounces-64-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B332F7F1562
	for <lists+linux-edac@lfdr.de>; Mon, 20 Nov 2023 15:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDD851C21821
	for <lists+linux-edac@lfdr.de>; Mon, 20 Nov 2023 14:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FAA1C295;
	Mon, 20 Nov 2023 14:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P6c6bdC1"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6C0CA;
	Mon, 20 Nov 2023 06:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700489588; x=1732025588;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TuRKMqc5s8ctrxhZQRN1hc+qrqht23N2CXc03YDUn4k=;
  b=P6c6bdC1IrSiP2WRgGJkAhfhsOD0jsZ2PIvM3mzyR6d8wWZrNYO0caZF
   0bYJ+grMhjC6Io09S7Zig2tXYA3mSnbefJPPzd5xbQ4gvNuPr7HP/tqTD
   Jw3C4GpzwiaZWHgU2hywRaBuz3NEDO4rvpr8fJcMLce1Kx1fwi8A9/haU
   xeQK55TCfVrHxmpji1g5DZ3/YO2O8bzwxckHtJXkQez9oD6AoTKGrCCFK
   L5fFEgMJDaLAQ8f5HDZIZBCzOsEUNuaGAajEcNfprSB3cFr/KCGgSyiD8
   ypeVCOczodczFcw602lpJVlEQIZ9zoT9YDMFflo26C+fM5xY8eJJExmuG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="458121759"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="458121759"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 06:12:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="801184235"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="801184235"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 20 Nov 2023 06:12:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 0C7092CA; Mon, 20 Nov 2023 16:12:32 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: [PATCH v2 1/4] EDAC, pnd2: Replace custom definition by one from sizes.h
Date: Mon, 20 Nov 2023 16:10:45 +0200
Message-ID: <20231120141231.1638240-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sizes.h provides a set of common size definitions, use it.

Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: added tag (Qiuxu) 

 drivers/edac/pnd2_edac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
index 2b306f2cc605..45e3c2913d51 100644
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -24,6 +24,7 @@
 #include <linux/delay.h>
 #include <linux/edac.h>
 #include <linux/mmzone.h>
+#include <linux/sizes.h>
 #include <linux/smp.h>
 #include <linux/bitmap.h>
 #include <linux/math64.h>
@@ -109,7 +110,6 @@ static struct mem_ctl_info *pnd2_mci;
 #define MOT_CHAN_INTLV_BIT_1SLC_2CH 12
 #define MOT_CHAN_INTLV_BIT_2SLC_2CH 13
 #define SELECTOR_DISABLED (-1)
-#define _4GB (1ul << 32)
 
 #define PMI_ADDRESS_WIDTH	31
 #define PND_MAX_PHYS_BIT	39
@@ -587,7 +587,7 @@ static int get_registers(void)
 /* Get a contiguous memory address (remove the MMIO gap) */
 static u64 remove_mmio_gap(u64 sys)
 {
-	return (sys < _4GB) ? sys : sys - (_4GB - top_lm);
+	return (sys < SZ_4G) ? sys : sys - (SZ_4G - top_lm);
 }
 
 /* Squeeze out one address bit, shift upper part down to fill gap */
@@ -643,7 +643,7 @@ static int sys2pmi(const u64 addr, u32 *pmiidx, u64 *pmiaddr, char *msg)
 
 	/* Give up if address is out of range, or in MMIO gap */
 	if (addr >= (1ul << PND_MAX_PHYS_BIT) ||
-	   (addr >= top_lm && addr < _4GB) || addr >= top_hm) {
+	   (addr >= top_lm && addr < SZ_4G) || addr >= top_hm) {
 		snprintf(msg, PND2_MSG_SIZE, "Error address 0x%llx is not DRAM", addr);
 		return -EINVAL;
 	}
-- 
2.43.0.rc1.1.gbec44491f096


