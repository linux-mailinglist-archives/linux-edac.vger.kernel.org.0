Return-Path: <linux-edac+bounces-5471-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B83C6F1D7
	for <lists+linux-edac@lfdr.de>; Wed, 19 Nov 2025 15:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC43A4F65B3
	for <lists+linux-edac@lfdr.de>; Wed, 19 Nov 2025 13:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32117361DA7;
	Wed, 19 Nov 2025 13:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fHJQRBJT"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E31C35F8C5;
	Wed, 19 Nov 2025 13:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763560364; cv=none; b=WPcLc1p7HWVoUcQ2cNCZwT57QnfjldVh1YEpCFeGYVQ4Oed4CJxw+k5U3T4uDd6dwlYrl71jOGTjAjUp/DsI4WDqIct4zy8ghkt3h4vBIgDT5CIeuhF1YBDFwbBwMgnTyqLyuJT4Jtxioce7hOQPuk7eK5FcX1jlrY75Lh7s7yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763560364; c=relaxed/simple;
	bh=u4wUA6apnhjKgKWvp/nnJucr11Vb3MfjMnaOIa4dsTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MOZJ6zb8pcxUXRnm9GuVbOuHPyBtWJA2O4eF1nToAJ5IYdIeDwcIPECIB/HQetB1g1JJp+p50KmKK30bEW4oR5XwYYIGum37eEnmFc/u72DCXvxbrc6fNGNVhiT1qXLNn8+cJO89t1xrls2m7TXJqEfLXt9z4mKfxVMv+dbDDic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fHJQRBJT; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763560363; x=1795096363;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u4wUA6apnhjKgKWvp/nnJucr11Vb3MfjMnaOIa4dsTQ=;
  b=fHJQRBJTWv+urzPgIyuOYAilU/9YW4FU12ioiE4i6ZbAU5PEYlAxLu8T
   xXQgYv0McfkLxf9QCvJgFqnj5F4tz68xk5j4f/CkNy6GJ6MLPQasbcN/X
   OOFkCvDtGew/qDsfRfK2LQ9q2o7kVIOVZ3Lc8mLSd1ZoFl5Xs50cfSY/r
   RZoiPd62xAthe2fqAp2VvjZzjAUnr7Urq/t5ms2ov1PqidDZK9qaGZkVC
   elegJtb9ym8HohZNkXsvB/nQgxeJUg8egUrpf7FEDd1Bmnn6PEo800+I0
   sZ5UeBAN2K/VBdXpJxcdYyiKJIfIbiNSanv1WgxPccKKgdQhRRJ5SxgXR
   g==;
X-CSE-ConnectionGUID: 7XzLoaODQL64eLdBLetNXA==
X-CSE-MsgGUID: aL0x7oy6SuyA2zL7czcyXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="64607369"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="64607369"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 05:52:42 -0800
X-CSE-ConnectionGUID: QOEUOEbhSjm2tFdgpo22tg==
X-CSE-MsgGUID: wqqaOwxcR2ymvYg2xuqKyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="214439570"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 05:52:40 -0800
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Yi Lai <yi1.lai@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] EDAC/skx_common: Prepare for skx_set_hi_lo()
Date: Wed, 19 Nov 2025 21:41:27 +0800
Message-ID: <20251119134132.2389472-4-qiuxu.zhuo@intel.com>
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

The upcoming imh_edac driver for Intel Diamond Rapids servers cannot
use skx_get_hi_lo() in skx_common to retrieve the TOHM (Top of High
Memory) and TOLM (Top of Low Memory) parameters. Instead, it obtains
these parameters within its own EDAC driver. To accommodate this,
prepare skx_set_hi_lo() to allow the driver to notify skx_common of
these parameters.

Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/skx_common.c | 7 +++++++
 drivers/edac/skx_common.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 6a1b30aa1ee6..e45abd0008ef 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -430,6 +430,13 @@ int skx_get_hi_lo(unsigned int did, int off[], u64 *tolm, u64 *tohm)
 }
 EXPORT_SYMBOL_GPL(skx_get_hi_lo);
 
+void skx_set_hi_lo(u64 tolm, u64 tohm)
+{
+	skx_tolm = tolm;
+	skx_tohm = tohm;
+}
+EXPORT_SYMBOL_GPL(skx_set_hi_lo);
+
 static int skx_get_dimm_attr(u32 reg, int lobit, int hibit, int add,
 			     int minval, int maxval, const char *name)
 {
diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index 52734091a79d..86a883d3c2a4 100644
--- a/drivers/edac/skx_common.h
+++ b/drivers/edac/skx_common.h
@@ -296,6 +296,7 @@ int skx_get_all_bus_mappings(struct res_config *cfg, struct list_head **list);
 struct list_head *skx_get_edac_list(void);
 
 int skx_get_hi_lo(unsigned int did, int off[], u64 *tolm, u64 *tohm);
+void skx_set_hi_lo(u64 tolm, u64 tohm);
 
 int skx_get_dimm_info(u32 mtr, u32 mcmtr, u32 amap, struct dimm_info *dimm,
 		      struct skx_imc *imc, int chan, int dimmno,
-- 
2.43.0


