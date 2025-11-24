Return-Path: <linux-edac+bounces-5513-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA33C7F223
	for <lists+linux-edac@lfdr.de>; Mon, 24 Nov 2025 07:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35DEF3A602E
	for <lists+linux-edac@lfdr.de>; Mon, 24 Nov 2025 06:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F69D2DA760;
	Mon, 24 Nov 2025 06:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C1doaHe0"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5E478F2E;
	Mon, 24 Nov 2025 06:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763967469; cv=none; b=s3zK6MtSt65d9R3SsLMsjORA36yxBMciA8wHieKm0Beslza3m4m3jjVf792hJFOEaRW/ORWL4/VMdj2yPF96JmDSnPa4i0svGAikyfm2gZHqIpLmYOi6y01EX9L1RkIz+QND+EeRbCpcHZ+538JozWrimQUMylcXOTdQL5s1BOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763967469; c=relaxed/simple;
	bh=n2sfG3NsoWQ4+FdYe4rlPhtXRST35Vy7SKPnFJ1RVIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ftx6iia2nxWoa57dq8cRunrMczxlsDI+Qmtjr56Pg/JWpoYcJl4LXQeOaSPQeSrdqT0zwGiZ0ORZn5ad7EPBKTOM7wcIv3HcU5fnmq7/qIrgkBRYpbLGSZ9a55aqCiRME1bewy2cqNK2guHPHBrwhrzG3MdvcvM9huGgM//4HEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C1doaHe0; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763967468; x=1795503468;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n2sfG3NsoWQ4+FdYe4rlPhtXRST35Vy7SKPnFJ1RVIY=;
  b=C1doaHe0jg9IRknh9lxOt3n5jFIBNfZPcCOKcQol/Zxtb2fWXgOFVxZv
   NoxnVGeeBuxWPsSBb1TUqYEsvKFgGe4p0jsQB4s3SLDab5rSBr86G6TMD
   qgnVkKYZS9iUhGiwfC6vkpE02u27FlO7sOxsYt6wuK2HyGxYJ/IMXd3JB
   d36QfS0piJl1zh1Q1VpmvDBHAxx8FDYiE8sjlI85J9LBRNh3hfuUkeBwa
   W2uFQxzwccI5rZ+WCaxA0kRxJs6fP0dgIoW1Fr/aHcBt2vmlRpMNy1G5S
   2I31PCXAYJfCQTI9qUajjxgA5k2s6vhtjOsa5mrGYqQNu/INdG2njJOpg
   w==;
X-CSE-ConnectionGUID: QCWotRnxRH6AlB4jmSgDlA==
X-CSE-MsgGUID: e2wQ6iv5TAOFr8dS2ty1gA==
X-IronPort-AV: E=McAfee;i="6800,10657,11622"; a="76286883"
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="76286883"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2025 22:57:48 -0800
X-CSE-ConnectionGUID: PJVs6ygrTQK10VUjZ0ZX2g==
X-CSE-MsgGUID: waoAaKkkTwGbQ2JSk/YT4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="192272773"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2025 22:57:45 -0800
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Jianfeng Gao <jianfeng.gao@intel.com>,
	Yi Lai <yi1.lai@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] EDAC/igen6: Add two Intel Amston Lake SoCs support
Date: Mon, 24 Nov 2025 14:54:56 +0800
Message-ID: <20251124065457.3630949-2-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251124065457.3630949-1-qiuxu.zhuo@intel.com>
References: <20251124065457.3630949-1-qiuxu.zhuo@intel.com>
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
 drivers/edac/igen6_edac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index 2fc59f9eed69..5d887a3115f0 100644
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


