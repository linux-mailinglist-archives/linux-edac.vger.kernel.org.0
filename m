Return-Path: <linux-edac+bounces-5574-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2442DCCE705
	for <lists+linux-edac@lfdr.de>; Fri, 19 Dec 2025 05:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B1F813030DAD
	for <lists+linux-edac@lfdr.de>; Fri, 19 Dec 2025 04:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429F722DFA5;
	Fri, 19 Dec 2025 04:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iqo2hKZ3"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35F878F4A;
	Fri, 19 Dec 2025 04:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766118768; cv=none; b=Am33Etlp0uIUCqmLdDcmtOEgECKUz7bEpHMEB2atkQAcIN7mNJ97fQnoOwhXQVyC+StQFJoniYT1C/D8TtN9g992faFLlk6tnXnxEjok5dkptjDKlVVIY5oiHeZkSgLRJNFSPS8WwT8S6vAC3MloMwfRmxWFqGQKMAMPiBH26DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766118768; c=relaxed/simple;
	bh=T7qAsEtIp7k7B3nJzQn0v54BfypZ1KLNQFP5Yucb/VM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jlO6kY0/8ax7VlKMKgeJdwkCNT9YzH0BkHb9XoOtkKnk5cG7XqdlgFDdVkeAzlPI/PJQ1rr31yAlmbZ1O+nBoF5OBAei4V9u4xaE/W1vFvzKOkm3Zw9LFzkObN1/THBd0GfRoos2wMZGTkJlHvhSih6QVM6rUboCfyi+d2mH7ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iqo2hKZ3; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766118767; x=1797654767;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T7qAsEtIp7k7B3nJzQn0v54BfypZ1KLNQFP5Yucb/VM=;
  b=iqo2hKZ3L/WwxOeMYGqpqy7WZ/sNjMtKtP1sB52uIpwwBZ2+YbV6Ujbj
   Xid9x+YhiLNNi1MD2PVOI4t3/LsQwD6XcmHTJWVFw7bbDAzRSm6G+RE4t
   FUvKWQaAGrSzq2+igTFcyUcRhsSEAIYDgHvfevNU2E+OUsHnay54f65rz
   dShKh2ib++cRSeEYH2Ysmcy572Z9nNjA70g7zaG/GXLgc9WeBXivZw7L4
   fFhVEJPFjhtMBoyRRYFsQ7LicW9129BxXp0Y8z2rW/46mn1iQx0O32RE0
   kvvMwz1HvkJAUgVcLQPMbXqetA6k1utCrTD/YEwgsY+7Sf/6fYrIb1eqE
   Q==;
X-CSE-ConnectionGUID: qR2Azds1SPaFaEpvturgiQ==
X-CSE-MsgGUID: /vwrG3X2Rgqook695kTh+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11646"; a="85500420"
X-IronPort-AV: E=Sophos;i="6.21,159,1763452800"; 
   d="scan'208";a="85500420"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 20:32:47 -0800
X-CSE-ConnectionGUID: KsZdm3UhRvuG2c4JbEiCxA==
X-CSE-MsgGUID: sJd/PoFGRJ6RxOOkElN1ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,159,1763452800"; 
   d="scan'208";a="202937714"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 20:32:44 -0800
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: tony.luck@intel.com,
	bp@alien8.de
Cc: qiuxu.zhuo@intel.com,
	jianfeng.gao@intel.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yi1.lai@intel.com
Subject: [PATCH v2 1/2] EDAC/igen6: Add two Intel Amston Lake SoCs support
Date: Fri, 19 Dec 2025 12:29:55 +0800
Message-ID: <20251219042956.3232568-2-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251219042956.3232568-1-qiuxu.zhuo@intel.com>
References: <20251124065457.3630949-1-qiuxu.zhuo@intel.com>
 <20251219042956.3232568-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel Amston Lake SoCs with IBECC (In-Band ECC) capability share the same
IBECC registers as Alder Lake-N SoCs. Add two new compute die IDs for
Amston Lake SoC products to enable EDAC support.

Tested-by: Jianfeng Gao <jianfeng.gao@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
v1->v2:
 - No changes.

 drivers/edac/igen6_edac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index 553c31a2d922..d29cfc7fad93 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -246,6 +246,8 @@ static struct work_struct ecclog_work;
 
 /* Compute did IDs for Amston Lake with IBECC */
 #define DID_ASL_SKU1	0x464a
+#define DID_ASL_SKU2	0x4646
+#define DID_ASL_SKU3	0x4652
 
 /* Compute die IDs for Raptor Lake-P with IBECC */
 #define DID_RPL_P_SKU1	0xa706
@@ -618,6 +620,8 @@ static struct pci_device_id igen6_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, DID_ADL_N_SKU12), (kernel_ulong_t)&adl_n_cfg },
 	{ PCI_VDEVICE(INTEL, DID_AZB_SKU1), (kernel_ulong_t)&adl_n_cfg },
 	{ PCI_VDEVICE(INTEL, DID_ASL_SKU1), (kernel_ulong_t)&adl_n_cfg },
+	{ PCI_VDEVICE(INTEL, DID_ASL_SKU2), (kernel_ulong_t)&adl_n_cfg },
+	{ PCI_VDEVICE(INTEL, DID_ASL_SKU3), (kernel_ulong_t)&adl_n_cfg },
 	{ PCI_VDEVICE(INTEL, DID_RPL_P_SKU1), (kernel_ulong_t)&rpl_p_cfg },
 	{ PCI_VDEVICE(INTEL, DID_RPL_P_SKU2), (kernel_ulong_t)&rpl_p_cfg },
 	{ PCI_VDEVICE(INTEL, DID_RPL_P_SKU3), (kernel_ulong_t)&rpl_p_cfg },
-- 
2.43.0


