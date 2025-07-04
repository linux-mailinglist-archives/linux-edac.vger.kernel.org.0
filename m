Return-Path: <linux-edac+bounces-4314-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5899BAF8BC2
	for <lists+linux-edac@lfdr.de>; Fri,  4 Jul 2025 10:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 968B81886639
	for <lists+linux-edac@lfdr.de>; Fri,  4 Jul 2025 08:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97C92EFDBD;
	Fri,  4 Jul 2025 07:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g4OxOzT2"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091D42EF299;
	Fri,  4 Jul 2025 07:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751615694; cv=none; b=PZ+fmj3xzUu6pQBgjJwJwtMFHG0febDftSq1w/rpDsC2NiIjnoXEW87EOUc3OkFUcM9PtnPDpyM2Dddf5RcLnvqkAjVLep1bOGxLhl3gYtzo0GpYXdcVxlaU5eTaKrE20pywJn5GP4U3Z7Ps7vx06rPCH0uX4+C1Yydl1Jf4A3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751615694; c=relaxed/simple;
	bh=XL16kP0PZnjoqoViYhoYPPV5qOcdw3Kn409Pww6lGhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gAKpkYwC1AqanTpwvEu2KqoQLsnAqZRdhPmY9qZxyQTRsYQG93Uvzh80c1A5N4I7wTfnvEdgkRGCJSljZ0ufgqKceHuz1edjzd+fUX7xNFAdcd8yd49vhxUoLp6zL/gFlNPdGyQmLk2FNwdGzPYv6DG/RY9aLiLKipSMID3Rvlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g4OxOzT2; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751615692; x=1783151692;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XL16kP0PZnjoqoViYhoYPPV5qOcdw3Kn409Pww6lGhs=;
  b=g4OxOzT29ly0hWFFVhbQ+jNuwkhuraVfFY5W1jK+F8UmuUyZ29GpK6ez
   yyZJojOFXqW2Z9nf5Yeos1TQ90kS+DN/3Pcb1YgrRz9KesR7g6N2F/4zb
   JAkG8k9jqUCDkt67LdRkQNdH7kBIhpwXcZ1L+03AiFSyJxPvjgpfMBpw2
   R2hlZboyZG5ugmMgl7DZArc9B9XDKOXHQ/g9N2F1f8y0jxlSPjB7SGagf
   OzjOLx/OIcAK7cKKGbFHjJIlGlfXiAFNUMDr3Xmrsg2eWQ2JhaiwUdcXy
   7+khwTZCc253QgdbYi8/BAJbcePAaLP7j3P/Y7ta/N+0viuVYRNrEtSJH
   A==;
X-CSE-ConnectionGUID: h+N2/KbMR7eGjFOYxNcMQA==
X-CSE-MsgGUID: L2xUQhOIToiWm4lZPGLo2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="57621180"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="57621180"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:51 -0700
X-CSE-ConnectionGUID: dDHsq61tTAaPg6EQF7QhNA==
X-CSE-MsgGUID: wmU7MIggTn6PNHty1Z6djA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="154664104"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:48 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Laurens SEGHERS <laurens@rale.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Lili Li <lili.li@intel.com>,
	VikasX Chougule <vikasx.chougule@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] EDAC/ie31200: Add Intel Raptor Lake-HX SoCs support
Date: Fri,  4 Jul 2025 23:16:09 +0800
Message-ID: <20250704151609.7833-4-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704151609.7833-1-qiuxu.zhuo@intel.com>
References: <20250704151609.7833-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel Raptor Lake-HX SoC shares the same memory controller registers
as Raptor Lake-S SoC. Add a compute die ID for Raptor Lake-HX SoCs with
Out-of-Band ECC capability for EDAC support.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Tested-by: Laurens SEGHERS <laurens@rale.com>
---
 drivers/edac/ie31200_edac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index d9533ca25635..5c1fa1c0d12e 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -94,6 +94,9 @@
 #define PCI_DEVICE_ID_INTEL_IE31200_RPL_S_5	0xa740 /* 8P+12E, e.g. i7-14700 */
 #define PCI_DEVICE_ID_INTEL_IE31200_RPL_S_6	0xa704 /* 6P+8E,  e.g. i5-14600 */
 
+/* Raptor Lake-HX */
+#define PCI_DEVICE_ID_INTEL_IE31200_RPL_HX_1	0xa702 /* 8P+16E, e.g. i9-13950HX */
+
 /* Alder Lake-S */
 #define PCI_DEVICE_ID_INTEL_IE31200_ADL_S_1	0x4660
 
@@ -756,6 +759,7 @@ static const struct pci_device_id ie31200_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_RPL_S_4), (kernel_ulong_t)&rpl_s_cfg},
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_RPL_S_5), (kernel_ulong_t)&rpl_s_cfg},
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_RPL_S_6), (kernel_ulong_t)&rpl_s_cfg},
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_RPL_HX_1), (kernel_ulong_t)&rpl_s_cfg},
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_ADL_S_1), (kernel_ulong_t)&rpl_s_cfg},
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_BTL_S_1), (kernel_ulong_t)&rpl_s_cfg},
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_BTL_S_2), (kernel_ulong_t)&rpl_s_cfg},
-- 
2.43.0


