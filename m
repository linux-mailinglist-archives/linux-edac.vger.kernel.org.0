Return-Path: <linux-edac+bounces-3490-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA9BA80C87
	for <lists+linux-edac@lfdr.de>; Tue,  8 Apr 2025 15:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A67D7901922
	for <lists+linux-edac@lfdr.de>; Tue,  8 Apr 2025 13:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3063413AD3F;
	Tue,  8 Apr 2025 13:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dw2SA4Km"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DF43BBF2;
	Tue,  8 Apr 2025 13:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744118755; cv=none; b=DUHqGws8Q/e81h+nEwRl72x21nDKvR+69EniQBxGOfqvBL3kFRDUvMJZ+Fj2WPeRjiHCpqa3nuJp0l1xO7x5ap4TOlYKIZE8O8gzZoT1act8kUFeEEVQ4sxCk7wiHV94Dtl4XgUqjkVJZGT4nHSOPUbteLNIaS39pzBLPvATOzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744118755; c=relaxed/simple;
	bh=eIYL+W0qNdQyEZYoFpWw1PXFI0J3GSiKF7Bhr9jioTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBOI9YN1s/pFXzKGhAenVHL4nnES7dkoJr9gtLrvyvq/t/ucEVxykcgE853a7QIJ8xlMDaT9jhV4ygWTla310+FOXt7/K+3Iabzgqiv5FB6Dv7FBr3Zpc7DJU7mM9Xr/h5QBxKQ9OJOAzTBR5EZGNP72ijo+s1amhIldkCfDtOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dw2SA4Km; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744118753; x=1775654753;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eIYL+W0qNdQyEZYoFpWw1PXFI0J3GSiKF7Bhr9jioTs=;
  b=Dw2SA4KmZnyInFRtiZwA9+hq1QCb87IUyDVb4QPhgIvFf7FuoMNd3Var
   Xwth12+JmBSobt64O/wmyJA3OzEQvYx63QctXpjBv5rHJPm9uVOHGNkVC
   yvf3nH56SJ2Bz4pYgy6q+sN6LeQkiX/sKLuGu6371v4Nk+uZqMv+MZYKo
   ZTh3Yj+pEk5HKuNlRgqVdcXMrrGMv457F700iGGLk3p7an5XqGBsiyOnE
   6+DKqnJkVtpVI2xNr1nfT+ClXa7ZKVv7faN/2Yiizkml1BGMUhRDErq3k
   rRm793S0dU21zXtnWtg+3L7oprQ8kq1KhJKIBqm6aSKAbBnxwr4dlFKLj
   Q==;
X-CSE-ConnectionGUID: IresKA8bSwSz6RNcPiREKg==
X-CSE-MsgGUID: qmxyXPFMR++QAMVqfNNQBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="44799638"
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="44799638"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 06:25:52 -0700
X-CSE-ConnectionGUID: BrPx6C64RyuOYPmsvMbJXg==
X-CSE-MsgGUID: XKLRXlQfQyaB/vwio25t6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="159258220"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 06:25:50 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Yi Lai <yi1.lai@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] EDAC/igen6: Add Intel Amston Lake SoCs support
Date: Tue,  8 Apr 2025 21:24:55 +0800
Message-ID: <20250408132455.489046-4-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250408132455.489046-1-qiuxu.zhuo@intel.com>
References: <20250408132455.489046-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel Amston Lake is a series of SoCs tailored for edge computing needs.
The Amston Lake SoCs, equipped with IBECC(In-Band ECC) capability, share
the same IBECC registers with Alder Lake-N SoCs. Add the Intel Amston Lake
SoC compute die ID for EDAC support.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/igen6_edac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index 13314f24536b..1930dc00c791 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -244,6 +244,9 @@ static struct work_struct ecclog_work;
 /* Compute die IDs for Arizona Beach with IBECC */
 #define DID_AZB_SKU1	0x4676
 
+/* Compute did IDs for Amston Lake with IBECC */
+#define DID_ASL_SKU1	0x464a
+
 /* Compute die IDs for Raptor Lake-P with IBECC */
 #define DID_RPL_P_SKU1	0xa706
 #define DID_RPL_P_SKU2	0xa707
@@ -600,6 +603,7 @@ static const struct pci_device_id igen6_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, DID_ADL_N_SKU11), (kernel_ulong_t)&adl_n_cfg },
 	{ PCI_VDEVICE(INTEL, DID_ADL_N_SKU12), (kernel_ulong_t)&adl_n_cfg },
 	{ PCI_VDEVICE(INTEL, DID_AZB_SKU1), (kernel_ulong_t)&adl_n_cfg },
+	{ PCI_VDEVICE(INTEL, DID_ASL_SKU1), (kernel_ulong_t)&adl_n_cfg },
 	{ PCI_VDEVICE(INTEL, DID_RPL_P_SKU1), (kernel_ulong_t)&rpl_p_cfg },
 	{ PCI_VDEVICE(INTEL, DID_RPL_P_SKU2), (kernel_ulong_t)&rpl_p_cfg },
 	{ PCI_VDEVICE(INTEL, DID_RPL_P_SKU3), (kernel_ulong_t)&rpl_p_cfg },
-- 
2.43.0


