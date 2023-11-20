Return-Path: <linux-edac+bounces-62-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A927F1564
	for <lists+linux-edac@lfdr.de>; Mon, 20 Nov 2023 15:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7D7EB21905
	for <lists+linux-edac@lfdr.de>; Mon, 20 Nov 2023 14:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64ECB1C287;
	Mon, 20 Nov 2023 14:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iO19RStE"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F9DA0;
	Mon, 20 Nov 2023 06:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700489587; x=1732025587;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XKZFQUi+U4ersNqM4YmQM70MnyE4Os/TQpc7j9Ab95o=;
  b=iO19RStEWjyQLAwIbTLZEi7AOOE4fHs1zJvBjy5sUCbH5AH+5KktXaSm
   Y7SJzDPSMDuC2qf0xiDtVR/Gq0AVUCv2wjEyN22RRB0nI2Cu5tlr92gBv
   bVL9HOjngVvrRsPGUwmyfQGFM0dbNsofAuN4rpOYbc+RKuWR0ge7S8UVi
   At3/LhgF238bvxXwQ1gcSGp4AR/YpNZTA3X8yLLmJ0kCKG0Gg5YYddUXU
   olmlHWz7ExltKUGiUNQKtxiE/tlrhGRm/p8BqSWyOJbl15YTbRDtjtVar
   QeQkM+w7sW0DTPPYV83TM+ZgVZrcXtw6OAPGeowQ6S0sATogxUJ32bOIf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="458121755"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="458121755"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 06:12:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="801184239"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="801184239"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 20 Nov 2023 06:12:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3DA4E4F8; Mon, 20 Nov 2023 16:12:33 +0200 (EET)
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
Subject: [PATCH v2 4/4] EDAC, pnd2: Sort headers alphabetically
Date: Mon, 20 Nov 2023 16:10:48 +0200
Message-ID: <20231120141231.1638240-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20231120141231.1638240-1-andriy.shevchenko@linux.intel.com>
References: <20231120141231.1638240-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sort the headers in alphabetic order in order to ease
the maintenance for this part.

Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: added tag (Qiuxu) 

 drivers/edac/pnd2_edac.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
index 969fb2465edb..2afcd148fcf8 100644
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -16,19 +16,20 @@
  * rank, bank, row and column using the appropriate "dunit_ops" functions/parameters.
  */
 
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/pci.h>
-#include <linux/pci_ids.h>
-#include <linux/slab.h>
+#include <linux/bitmap.h>
 #include <linux/delay.h>
 #include <linux/edac.h>
-#include <linux/mmzone.h>
-#include <linux/sizes.h>
-#include <linux/smp.h>
-#include <linux/bitmap.h>
+#include <linux/init.h>
 #include <linux/math64.h>
+#include <linux/mmzone.h>
 #include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/pci_ids.h>
+#include <linux/sizes.h>
+#include <linux/slab.h>
+#include <linux/smp.h>
+
 #include <linux/platform_data/x86/p2sb.h>
 
 #include <asm/cpu_device_id.h>
-- 
2.43.0.rc1.1.gbec44491f096


