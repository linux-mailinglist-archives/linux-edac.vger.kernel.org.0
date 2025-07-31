Return-Path: <linux-edac+bounces-4482-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D208B1738D
	for <lists+linux-edac@lfdr.de>; Thu, 31 Jul 2025 16:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F1C63B1163
	for <lists+linux-edac@lfdr.de>; Thu, 31 Jul 2025 14:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0501DE3B5;
	Thu, 31 Jul 2025 14:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fLbCFBZI"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EA61DC9BB;
	Thu, 31 Jul 2025 14:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753973891; cv=none; b=KRwvisc/odjAwC7+X6P35YN76bc+UK6YH2HpAupLYiei1PpB4pjB3zXnmLHrp75CO3Bd3udajqE12LDzj7Hc1r23qZqTjyn4fnJE/keNjb+PbyfawzcIYyS1/cAm102XJJEZX9yILhjoZgel0DTqq+mLzmeJLrElN9+ZOqM2toA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753973891; c=relaxed/simple;
	bh=kTWrovbKWg33ZgoJgUOfy8Y/8vnqhpN1y/lXj9BnxzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FRsLfFmB7qKhH6LTnuY8JFckrv+sXp7P7BDkYpuIpQQCxtlcb7Py60s2T6F6i1QhqLGjtVhDT60H68VMNYJRjXoVo/MLhRxQ1IlUt4gfqhDznDe6ZZjAfh6QlFjYGVIF4h8KaszHmI/6a6Y41+iYG8Mo6z/+1tdbALmQ6DsV6qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fLbCFBZI; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753973890; x=1785509890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kTWrovbKWg33ZgoJgUOfy8Y/8vnqhpN1y/lXj9BnxzY=;
  b=fLbCFBZIaORvoP0JQBw4Q62KxxYSz9Q0cmGHxLhezYRgnhN42y2L7p9I
   IXdUSBYeoJmsNBqMtpZOsSMwcGNi2XJqg171ygaJCRfxTcKHsh4zjH8iH
   cejXqqdsD5TJWVLVS62PCVQHlSVUhhQ9fLMvfV+gk8vMltg4w6wuvJERo
   +VDhP/1C6I2IMa5jUwpO2XPl+YaDfNPCa3kJaC4UxWh0jrJEq8o3hHtnD
   xUH52FU9ajJS2+MocxhBim1F7OnM7necfXoK/IVNWLbGTE8Kjq90AJlus
   3XMdV1X+CXqqlit5Lk9dhumpw2LT9IZaKFbDHsafVXrgjrHS/MLUIv+o+
   w==;
X-CSE-ConnectionGUID: wR/HiQzaSuyOzsYgCdRyTQ==
X-CSE-MsgGUID: MnrckdwXReibtFp7W2AWhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="56231762"
X-IronPort-AV: E=Sophos;i="6.17,353,1747724400"; 
   d="scan'208";a="56231762"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 07:58:10 -0700
X-CSE-ConnectionGUID: jZYnWDyJSbGmJpZrMokKTw==
X-CSE-MsgGUID: 8yZJEhskQhyhZt2fVJPlZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,353,1747724400"; 
   d="scan'208";a="163633447"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 07:58:08 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Lai Yi <yi1.lai@linux.intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] EDAC/skx_common: Swap memory controller index mapping
Date: Thu, 31 Jul 2025 22:55:30 +0800
Message-ID: <20250731145534.2759334-4-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250731145534.2759334-1-qiuxu.zhuo@intel.com>
References: <20250731145534.2759334-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current mapping of memory controller indices is from physical index [1]
to logical index [2], as show below:

  skx_dev->imc[pmc].mc_mapping = lmc

Since skx_dev->imc[] is an array of present memory controller instances,
mapping memory controller indices from logical index to physical index,
as show below, is more reasonable. This is also a preparatory step for
making skx_dev->imc[] a flexible array.

  skx_dev->imc[lmc].mc_mapping = pmc

Both mappings are equivalent. No functional changes intended.

[1] Indices for memory controllers include both those present to the
    OS and those disabled by BIOS.

[2] Indices for memory controllers present to the OS.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/skx_common.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 94a66b28751a..744706334b9d 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -130,7 +130,7 @@ static void skx_init_mc_mapping(struct skx_dev *d)
 	 * the logical indices of the memory controllers enumerated by the
 	 * EDAC driver.
 	 */
-	for (int i = 0; i < NUM_IMC; i++)
+	for (int i = 0; i < d->num_imc; i++)
 		d->imc[i].mc_mapping = i;
 }
 
@@ -139,22 +139,28 @@ void skx_set_mc_mapping(struct skx_dev *d, u8 pmc, u8 lmc)
 	edac_dbg(0, "Set the mapping of mc phy idx to logical idx: %02d -> %02d\n",
 		 pmc, lmc);
 
-	d->imc[pmc].mc_mapping = lmc;
+	d->imc[lmc].mc_mapping = pmc;
 }
 EXPORT_SYMBOL_GPL(skx_set_mc_mapping);
 
-static u8 skx_get_mc_mapping(struct skx_dev *d, u8 pmc)
+static int skx_get_mc_mapping(struct skx_dev *d, u8 pmc)
 {
-	edac_dbg(0, "Get the mapping of mc phy idx to logical idx: %02d -> %02d\n",
-		 pmc, d->imc[pmc].mc_mapping);
+	for (int lmc = 0; lmc < d->num_imc; lmc++) {
+		if (d->imc[lmc].mc_mapping == pmc) {
+			edac_dbg(0, "Get the mapping of mc phy idx to logical idx: %02d -> %02d\n",
+				 pmc, lmc);
 
-	return d->imc[pmc].mc_mapping;
+			return lmc;
+		}
+	}
+
+	return -1;
 }
 
 static bool skx_adxl_decode(struct decoded_addr *res, enum error_source err_src)
 {
+	int i, lmc, len = 0;
 	struct skx_dev *d;
-	int i, len = 0;
 
 	if (res->addr >= skx_tohm || (res->addr >= skx_tolm &&
 				      res->addr < BIT_ULL(32))) {
@@ -218,7 +224,13 @@ static bool skx_adxl_decode(struct decoded_addr *res, enum error_source err_src)
 		return false;
 	}
 
-	res->imc = skx_get_mc_mapping(d, res->imc);
+	lmc = skx_get_mc_mapping(d, res->imc);
+	if (lmc < 0) {
+		skx_printk(KERN_ERR, "No lmc for imc %d\n", res->imc);
+		return false;
+	}
+
+	res->imc = lmc;
 
 	for (i = 0; i < adxl_component_count; i++) {
 		if (adxl_values[i] == ~0x0ull)
-- 
2.43.0


