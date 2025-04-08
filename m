Return-Path: <linux-edac+bounces-3489-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30333A80C80
	for <lists+linux-edac@lfdr.de>; Tue,  8 Apr 2025 15:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2B5A90531E
	for <lists+linux-edac@lfdr.de>; Tue,  8 Apr 2025 13:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60544374D1;
	Tue,  8 Apr 2025 13:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RegDpEec"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C750B3BBF2;
	Tue,  8 Apr 2025 13:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744118747; cv=none; b=IvXS8KS/yNG6c3fMEKf0/4OdQsyM1aONGLWn0OQavflCqNvFS+YTnQRDizGTjy8TuBYPlrKeetFs45JPvi1MVvcRJMqrM5zgny1ZHwGskU3HG7ZToC49318X4jhy72yDJVCIkTdKlawA+S8S/DzeAlrp/sOhmarz6WLaf1PJ+pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744118747; c=relaxed/simple;
	bh=4C+t+NsAFfnUWhEqKEYXfclF3vLGsAmvkbyiyZPVQCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1VdJ/Fu7NgpHJaNfhvmBJNh2qnJVee9AQRGXBhK8Sq0HUf2dYbPbvNv+MzEqmlzl95YE3MT/G65ZtSvoMDmZnxva0BA3YLBJrexoMwjIkk6CPqn1Gc5HTs12G51r2qve68QN/Fetx0uMyffiMZzCvfzHyIoTsLeVvnIpdVuds0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RegDpEec; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744118746; x=1775654746;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4C+t+NsAFfnUWhEqKEYXfclF3vLGsAmvkbyiyZPVQCE=;
  b=RegDpEecICOi4KJ6KrEkgpKjdy0WBP5hKlOkTE5x83qg2zUcwbUKWuDH
   dkHp5PeHb5israLKhgbIo3BanYaF4RRSL8lbErbVCRP8h7dG5XZ0X3j2K
   Ai5Xt9h3nn0/Lr13RHvj/Sd1DMJ4cX8CKfeFqp4G01rKWOtz+vXEyjfVG
   mYAhPjtlda9pusPl/5XjQklHb2D9PFnwrnMU+1ilQ6F9RZxFnkkT1twJI
   xWYZsknjCOuDHqgDw4n5j/Jor2151zBUZz9nGaVRWbIehpJvilKUoy5ES
   29qjTrf7yjNGsM2MkWtpAOjhR5CaFsKfgsly5hbxEZl/uOwkNjeaZPh1z
   w==;
X-CSE-ConnectionGUID: iHaUUTQFQGCRutDnj8snQg==
X-CSE-MsgGUID: vN7WTx4/S5iUh5RPgeeECg==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="44799629"
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="44799629"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 06:25:45 -0700
X-CSE-ConnectionGUID: AMs5m14WShuGD6t938wl8g==
X-CSE-MsgGUID: xx592PRfT1uksNgJwUuVmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="159258217"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 06:25:42 -0700
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
Subject: [PATCH 2/3] EDAC/igen6: Add Intel Arizona Beach SoCs support
Date: Tue,  8 Apr 2025 21:24:54 +0800
Message-ID: <20250408132455.489046-3-qiuxu.zhuo@intel.com>
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

The Intel Arizona Lake SoC series is oriented toward network computing.
Some types of these SoCs are equipped with IBECC(In-Band ECC) and share
the same IBECC registers with Alder Lake-N SoCs. Add a die ID for Arizona
Lake SoC for EDAC support.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/igen6_edac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index ec64bff8236f..13314f24536b 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -241,6 +241,9 @@ static struct work_struct ecclog_work;
 #define DID_ADL_N_SKU11	0x467c
 #define DID_ADL_N_SKU12	0x4632
 
+/* Compute die IDs for Arizona Beach with IBECC */
+#define DID_AZB_SKU1	0x4676
+
 /* Compute die IDs for Raptor Lake-P with IBECC */
 #define DID_RPL_P_SKU1	0xa706
 #define DID_RPL_P_SKU2	0xa707
@@ -596,6 +599,7 @@ static const struct pci_device_id igen6_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, DID_ADL_N_SKU10), (kernel_ulong_t)&adl_n_cfg },
 	{ PCI_VDEVICE(INTEL, DID_ADL_N_SKU11), (kernel_ulong_t)&adl_n_cfg },
 	{ PCI_VDEVICE(INTEL, DID_ADL_N_SKU12), (kernel_ulong_t)&adl_n_cfg },
+	{ PCI_VDEVICE(INTEL, DID_AZB_SKU1), (kernel_ulong_t)&adl_n_cfg },
 	{ PCI_VDEVICE(INTEL, DID_RPL_P_SKU1), (kernel_ulong_t)&rpl_p_cfg },
 	{ PCI_VDEVICE(INTEL, DID_RPL_P_SKU2), (kernel_ulong_t)&rpl_p_cfg },
 	{ PCI_VDEVICE(INTEL, DID_RPL_P_SKU3), (kernel_ulong_t)&rpl_p_cfg },
-- 
2.43.0


