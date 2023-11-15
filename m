Return-Path: <linux-edac+bounces-26-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D117EC7A1
	for <lists+linux-edac@lfdr.de>; Wed, 15 Nov 2023 16:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAE731C2091B
	for <lists+linux-edac@lfdr.de>; Wed, 15 Nov 2023 15:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE193BB4F;
	Wed, 15 Nov 2023 15:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nM6YNaYB"
X-Original-To: linux-edac@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0072E3BB2D
	for <linux-edac@vger.kernel.org>; Wed, 15 Nov 2023 15:50:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B0B1AC;
	Wed, 15 Nov 2023 07:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700063402; x=1731599402;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=er/1zsYTEUqBc9l1o82eaHeGbKLxLZP8/d4Zg+MKFYM=;
  b=nM6YNaYBQTKCSbY5uK8nExxOv7Hrvt/M4rk93xIg17AW2J0mzRBRaXyB
   0+by1E0cmAmUJNqyaTaT6pgZ5WqBv6ufCGxHCCA/lZmGDnNeMaULuz0YA
   EtTG+x6xfvzLu4sR67RYwzq/AjWEfowb6i2p88HYACL0kZPmW0CYjrhAl
   gxq7U8YwI1cs0/VLL+aMuS7A/KTiaxdL3H8u7AWrUaAHPRBw7z3hDY+Y1
   E9kRYAvvdxOnRv/xDkVFOubud+5IG6Mit7/rRUjBO5eGT553eAlyvo+vn
   XMA0XRuMVeFlW/WiLDHbqOJ3IKLKM8+R2MkdQwcVi11rJ3XGPl2XMJooO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="477119132"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="477119132"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 07:50:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="741469101"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="741469101"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 15 Nov 2023 07:49:59 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1C3E4305; Wed, 15 Nov 2023 17:49:58 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>
Subject: [PATCH v1 3/3] EDAC, pnd2: Sort headers alphabetically
Date: Wed, 15 Nov 2023 17:49:40 +0200
Message-ID: <20231115154940.664664-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20231115154940.664664-1-andriy.shevchenko@linux.intel.com>
References: <20231115154940.664664-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sort the headers in alphabetic order in order to ease
the maintenance for this part.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/edac/pnd2_edac.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
index 676e02c8dc43..1bbedd59e36b 100644
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


