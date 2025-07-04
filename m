Return-Path: <linux-edac+bounces-4312-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E85AF8BD0
	for <lists+linux-edac@lfdr.de>; Fri,  4 Jul 2025 10:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C4DD761CD8
	for <lists+linux-edac@lfdr.de>; Fri,  4 Jul 2025 08:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F132E499C;
	Fri,  4 Jul 2025 07:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hhmDBvUy"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981112DCF60;
	Fri,  4 Jul 2025 07:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751615682; cv=none; b=sqeFAoA1efgBho3e/Yzg/c6027Hj6hDSLNYG7vqtHURmn7JzJmhJfrU3hTsgFwIjHInoVcChr6Ic1vvOOq9Hqr1dzAKzNqE5B2Dbr86pZmwxfsqEpUWf+39jDsib8bH0t0YSm92h2hEjv4rkDqV89rC/ZtQ55Ma8uL5/U0QmT7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751615682; c=relaxed/simple;
	bh=mwU7btKAyZ9cAsrqBTZ0SjxXjFYhGz4ex9bDeH7DjAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kzUaJ3zxs7gsolxq43pSzf8a6QvDnaKDEfZBN+oczplGvMG84R1v7pWDjLGK5mW3XwW2762BIds4LmHBt5UY2jvuzNZPNEEj1niL5r/MrmL2ndoUATYAHFOOmi6nABzzlT+d5r72Td1TLDIa/zuTc0ZpFF4skEjwZ9ABVdSNRuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hhmDBvUy; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751615680; x=1783151680;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mwU7btKAyZ9cAsrqBTZ0SjxXjFYhGz4ex9bDeH7DjAw=;
  b=hhmDBvUyPmVdcvZe46Akoxv65+I151vLTzXdI8XssN1w/ILV0em2OaPt
   J+4M/hFR0PfLSzO9pJPWqjcWmEMZHZCstaUjb/e+f+I5W/MXF6qDaA9Mx
   nGs4FKJQ9Sh1iShF7CtyE5GWce+eACO0B3LOOW9h6wyfHFT/wAQ4CjKs0
   3hE05k2BWdmcMWzhyANHsL88+iQLLzWFzzskjXjzdNYgS/7xlgGjHL+Id
   nz2kF3z6Jdq7K8Unm1YdyQInEUUbBozlTcbJUnblatGEjqy/1GXL+8f1Z
   Dpl5hyU+nD5acaXza6G4b+zd74YazxQeRvWTAG9BP5NYpiSJhyALFMAbu
   w==;
X-CSE-ConnectionGUID: hmHGdZ4yQYWNkO7d76rjSA==
X-CSE-MsgGUID: 7JpYItX3Rxe47G2J49VzCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="57621134"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="57621134"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:33 -0700
X-CSE-ConnectionGUID: zCcdiXaSQWWvpz/h0rYQqg==
X-CSE-MsgGUID: m7spTVa2Qo6iAT4/Fz/Dhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="154663990"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:30 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	VikasX Chougule <vikasx.chougule@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Lili Li <lili.li@intel.com>,
	Laurens SEGHERS <laurens@rale.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] EDAC/i10nm: Add Intel Granite Rapids-D support
Date: Fri,  4 Jul 2025 23:16:07 +0800
Message-ID: <20250704151609.7833-2-qiuxu.zhuo@intel.com>
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

The Granite Rapids-D CPU model uses memory controller registers similar
to those of the Granite Rapids server CPU but with a different memory
controller MMIO base.

Add the Granite Rapids-D CPU model ID and use the new memory controller
MMIO base for EDAC support.

Tested-by: VikasX Chougule <vikasx.chougule@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/i10nm_base.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index a3fca2567752..c1e45c16f70e 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -62,6 +62,7 @@
 	((GET_BITFIELD(reg, 0, 10) << 12) + 0x140000)
 
 #define I10NM_GNR_IMC_MMIO_OFFSET	0x24c000
+#define I10NM_GNR_D_IMC_MMIO_OFFSET	0x206000
 #define I10NM_GNR_IMC_MMIO_SIZE		0x4000
 #define I10NM_HBM_IMC_MMIO_SIZE		0x9000
 #define I10NM_DDR_IMC_CH_CNT(reg)	GET_BITFIELD(reg, 21, 24)
@@ -687,6 +688,14 @@ static struct pci_dev *get_gnr_mdev(struct skx_dev *d, int logical_idx, int *phy
 	return NULL;
 }
 
+static u32 get_gnr_imc_mmio_offset(void)
+{
+	if (boot_cpu_data.x86_vfm == INTEL_GRANITERAPIDS_D)
+		return I10NM_GNR_D_IMC_MMIO_OFFSET;
+
+	return I10NM_GNR_IMC_MMIO_OFFSET;
+}
+
 /**
  * get_ddr_munit() - Get the resource of the i-th DDR memory controller.
  *
@@ -715,7 +724,7 @@ static struct pci_dev *get_ddr_munit(struct skx_dev *d, int i, u32 *offset, unsi
 			return NULL;
 
 		*offset = I10NM_GET_IMC_MMIO_OFFSET(reg) +
-			  I10NM_GNR_IMC_MMIO_OFFSET +
+			  get_gnr_imc_mmio_offset() +
 			  physical_idx * I10NM_GNR_IMC_MMIO_SIZE;
 		*size   = I10NM_GNR_IMC_MMIO_SIZE;
 
@@ -1030,6 +1039,7 @@ static const struct x86_cpu_id i10nm_cpuids[] = {
 	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X, &spr_cfg),
 	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,  &spr_cfg),
 	X86_MATCH_VFM(INTEL_GRANITERAPIDS_X,  &gnr_cfg),
+	X86_MATCH_VFM(INTEL_GRANITERAPIDS_D,  &gnr_cfg),
 	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT_X, &gnr_cfg),
 	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT,   &gnr_cfg),
 	X86_MATCH_VFM(INTEL_ATOM_DARKMONT_X,  &gnr_cfg),
-- 
2.43.0


