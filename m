Return-Path: <linux-edac+bounces-4525-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DEAB1C0C3
	for <lists+linux-edac@lfdr.de>; Wed,  6 Aug 2025 08:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C2D03A7B1F
	for <lists+linux-edac@lfdr.de>; Wed,  6 Aug 2025 06:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4472135DD;
	Wed,  6 Aug 2025 06:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HyFEZJJq"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0052116F4;
	Wed,  6 Aug 2025 06:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754463561; cv=none; b=TeUome6bevgYAP9TXc4h3JTwvSZapzcozA5BXuiG4/F96Imnq4+RrBaezwUHATkOOMcqhHdi09r9m0xRblPHohFnq1r8Mxr9T+jMH/EVEmcZnhbc6kORDvzCAe4GUtG1fvRajFPPCWzGFhrrOAW0LLExTfLWsvr0mmbPUVCvKOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754463561; c=relaxed/simple;
	bh=1O89QYN8d1dcc3QruuHauYoW5IWmr4ZkIeVcdj9XOp8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tnRlXMJo9PYFaEwL+Ea83w9N4K7qi93tMFDFcMGqxqRr6XKUrROVpoCLDta3sMnHghgf8iivXQZAocOqGrfIyWG6D8RBvVXlK6TLKgE6Zo+8HG2CtKrY2TaTgQ0s5IKio2Atbc/gLbDzjntnwnTOnzfcpMjMRMxYUgFtF4j5sP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HyFEZJJq; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754463560; x=1785999560;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1O89QYN8d1dcc3QruuHauYoW5IWmr4ZkIeVcdj9XOp8=;
  b=HyFEZJJqlLEqG9aihkH0NY/opa9AB0bzn7TQOMvRQ9YlXsOW7/UQrqnJ
   lyfyfdhbDgQVcaxMaV+PSOQXSj1P7CpEaLunswKvVmZY8DxX9zIhnHicn
   JbSWnHgYCGtPMZ8lvzzkq6lBmx98WeyNmb9/d99CICmytMvV3WTZZyU6b
   Xf31tQ0tV8PrwxQxnbxXrFDykKVRVkFcCjuRpMQhNJ8qgCAR+qd3fs8Mg
   ScS2de819Nu6bFhjosVFoxOE4GMNGz6KmnIM/AHTLSmOx/80ARP0CDrWy
   52jhi54asc94Z5t+Zb91fERQIFZxkShBjmuiOvB/dFQBxqjnhQzaGyvbN
   A==;
X-CSE-ConnectionGUID: 73XcvumNRB23WYdAh1DyIQ==
X-CSE-MsgGUID: XO12QrYoRoeofcaxydom1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="56638239"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="56638239"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 23:59:19 -0700
X-CSE-ConnectionGUID: BDovrBJgTsumwTBklslw4g==
X-CSE-MsgGUID: yK8+ak9uSwKJCfV1tPPIJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="170076107"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 23:59:17 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Jose Jesus Ambriz Meza <jose.jesus.ambriz.meza@intel.com>,
	Chia-Lin Kao <acelan.kao@canonical.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Lai Yi <yi1.lai@linux.intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] EDAC/i10nm: Skip DIMM enumeration on a disabled memory controller
Date: Wed,  6 Aug 2025 14:57:07 +0800
Message-ID: <20250806065707.3533345-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When loading the i10nm_edac driver on some Intel Granite Rapids servers,
a call trace may appear as follows:

  UBSAN: shift-out-of-bounds in drivers/edac/skx_common.c:453:16
  shift exponent -66 is negative
  ...
  __ubsan_handle_shift_out_of_bounds+0x1e3/0x390
  skx_get_dimm_info.cold+0x47/0xd40 [skx_edac_common]
  i10nm_get_dimm_config+0x23e/0x390 [i10nm_edac]
  skx_register_mci+0x159/0x220 [skx_edac_common]
  i10nm_init+0xcb0/0x1ff0 [i10nm_edac]
  ...

This occurs because some BIOS may disable a memory controller if there
aren't any memory DIMMs populated on this memory controller. The DIMMMTR
register of this disabled memory controller contains the invalid value
~0, resulting in the call trace above.

Fix this call trace by skipping DIMM enumeration on a disabled memory
controller.

Fixes: ba987eaaabf9 ("EDAC/i10nm: Add Intel Granite Rapids server support")
Reported-by: Jose Jesus Ambriz Meza <jose.jesus.ambriz.meza@intel.com>
Reported-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
Closes: https://lore.kernel.org/all/20250730063155.2612379-1-acelan.kao@canonical.com/
Tested-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/i10nm_base.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index a3fca2567752..ac9afcf461d7 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -1047,6 +1047,15 @@ static bool i10nm_check_ecc(struct skx_imc *imc, int chan)
 	return !!GET_BITFIELD(mcmtr, 2, 2);
 }
 
+static bool i10nm_channel_disabled(struct skx_imc *imc, int chan)
+{
+	u32 mcmtr = I10NM_GET_MCMTR(imc, chan);
+
+	edac_dbg(1, "mc%d ch%d mcmtr reg %x\n", imc->mc, chan, mcmtr);
+
+	return (mcmtr == ~0 || GET_BITFIELD(mcmtr, 18, 18));
+}
+
 static int i10nm_get_dimm_config(struct mem_ctl_info *mci,
 				 struct res_config *cfg)
 {
@@ -1060,6 +1069,11 @@ static int i10nm_get_dimm_config(struct mem_ctl_info *mci,
 		if (!imc->mbase)
 			continue;
 
+		if (i10nm_channel_disabled(imc, i)) {
+			edac_dbg(1, "mc%d ch%d is disabled.\n", imc->mc, i);
+			continue;
+		}
+
 		ndimms = 0;
 
 		if (res_cfg->type != GNR)

base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
-- 
2.43.0


