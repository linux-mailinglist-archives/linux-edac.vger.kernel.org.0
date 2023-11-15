Return-Path: <linux-edac+bounces-10-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7552A7E9820
	for <lists+linux-edac@lfdr.de>; Mon, 13 Nov 2023 09:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAAB3280A61
	for <lists+linux-edac@lfdr.de>; Mon, 13 Nov 2023 08:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5EB168A9;
	Mon, 13 Nov 2023 08:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vqx2N7aJ"
X-Original-To: linux-edac@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89AF15AF6
	for <linux-edac@vger.kernel.org>; Mon, 13 Nov 2023 08:54:34 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DE410CF;
	Mon, 13 Nov 2023 00:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699865674; x=1731401674;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=pJTIQJ9tEEb9N+bWqKJWUNnAhUo1FZeNvykH2xVtMkk=;
  b=Vqx2N7aJoUPQXynJiOfhva1c35xb5KRqdDLjNYoLYKy9dEDpqam8MFo1
   QyqePv8lf+FhaZyoc3XR8O3mdahUgrhHXDWo26BHGmtvmuP9SDxAToz7+
   IRMRizQ4+ZTHmIBzL7rQSaDIsM1t2j4iql1OGmK5yLyn022OLEGTzBx9e
   +B4ozXL+USZNWUYJQf5acNVvJR0z54a9Xl5t+CL99m+6EbOVOvrhgQkmj
   EECo6K5gns0YweJgAdi0sJbu/hUeDBwIVuEEnb5WYZdMGpYEoXfqQzBuN
   K8I9UjUCW7YutXmH50m8bj8tIXUAQcrczOZArqcyXrFbBiczsS8RiLHBo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="9044596"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="9044596"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 00:54:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="937688086"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="937688086"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 00:54:27 -0800
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Aristeu Rozanski <aris@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] EDAC/igen6: Make get_mchbar() helper function
Date: Mon, 13 Nov 2023 16:53:14 +0800
Message-Id: <20231113085318.26783-2-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231113085318.26783-1-qiuxu.zhuo@intel.com>
References: <20231113085318.26783-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

Make get_mchbar() helper function to retrieve the BAR address of
the memory controller. No function changes.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/igen6_edac.c | 46 ++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index 1a18693294db..eadc3e559311 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -222,6 +222,36 @@ static struct work_struct ecclog_work;
 #define DID_ADL_SKU3	0x4621
 #define DID_ADL_SKU4	0x4641
 
+static int get_mchbar(struct pci_dev *pdev, u64 *mchbar)
+{
+	union  {
+		u64 v;
+		struct {
+			u32 v_lo;
+			u32 v_hi;
+		};
+	} u;
+
+	if (pci_read_config_dword(pdev, MCHBAR_OFFSET, &u.v_lo)) {
+		igen6_printk(KERN_ERR, "Failed to read lower MCHBAR\n");
+		return -ENODEV;
+	}
+
+	if (pci_read_config_dword(pdev, MCHBAR_OFFSET + 4, &u.v_hi)) {
+		igen6_printk(KERN_ERR, "Failed to read upper MCHBAR\n");
+		return -ENODEV;
+	}
+
+	if (!(u.v & MCHBAR_EN)) {
+		igen6_printk(KERN_ERR, "MCHBAR is disabled\n");
+		return -ENODEV;
+	}
+
+	*mchbar = MCHBAR_BASE(u.v);
+
+	return 0;
+}
+
 static bool ehl_ibecc_available(struct pci_dev *pdev)
 {
 	u32 v;
@@ -969,22 +999,8 @@ static int igen6_pci_setup(struct pci_dev *pdev, u64 *mchbar)
 
 	igen6_tom = u.v & GENMASK_ULL(38, 20);
 
-	if (pci_read_config_dword(pdev, MCHBAR_OFFSET, &u.v_lo)) {
-		igen6_printk(KERN_ERR, "Failed to read lower MCHBAR\n");
+	if (get_mchbar(pdev, mchbar))
 		goto fail;
-	}
-
-	if (pci_read_config_dword(pdev, MCHBAR_OFFSET + 4, &u.v_hi)) {
-		igen6_printk(KERN_ERR, "Failed to read upper MCHBAR\n");
-		goto fail;
-	}
-
-	if (!(u.v & MCHBAR_EN)) {
-		igen6_printk(KERN_ERR, "MCHBAR is disabled\n");
-		goto fail;
-	}
-
-	*mchbar = MCHBAR_BASE(u.v);
 
 #ifdef CONFIG_EDAC_DEBUG
 	if (pci_read_config_dword(pdev, TOUUD_OFFSET, &u.v_lo))
-- 
2.17.1


