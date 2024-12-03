Return-Path: <linux-edac+bounces-2641-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7119F9E1178
	for <lists+linux-edac@lfdr.de>; Tue,  3 Dec 2024 03:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06B05B2197D
	for <lists+linux-edac@lfdr.de>; Tue,  3 Dec 2024 02:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F487FBAC;
	Tue,  3 Dec 2024 02:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iDvPNwPH"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D69E364AE;
	Tue,  3 Dec 2024 02:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733194167; cv=none; b=cO4AnFEOBpzXipdsxNZXkFaySnZ30lAm8rcLEKf7SVyV4ckCecxjFqR41CGIPrNP8+UtlQxSFT1nqBMZswdFB9042YXxmkySoMC0lazxxdbgO20RFxoM7ZcK0EJLUF9u+iX6X5s2xyNhUq4cozMA2CHE229z17CC7U41FsAR+14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733194167; c=relaxed/simple;
	bh=GFIxusrONwQkldKNOO0nMkmdmgBy06iFX7XnlPYW2CA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=c+GW4K536pKAzDYINlBWG3SfGkA+atrUUi8QF1eeF5GOybCyqqv6Gx23aCM7XpyOueGmi3CMlEOi6YvPER5iBCjew+DfHecG/HQBjvmxiwIP4zLQJNXwdO0LUU6cCckpC2VG/21mqTUWoDgemlzi+KFrISfYsnr+SiSQ3NGXzCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iDvPNwPH; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733194167; x=1764730167;
  h=from:to:cc:subject:date:message-id;
  bh=GFIxusrONwQkldKNOO0nMkmdmgBy06iFX7XnlPYW2CA=;
  b=iDvPNwPHwzrvsqNEgQd+Hvce3tAyEhvyCMpmcMM/D/qnV7x+x2cIGJeD
   iNCjVKg5lE+P0Vul0iE+NUXZtDDLc2/6zJ5Kk33ilrfjwbGe2MMa0UuSW
   2QmXriRwmHdhBJCyjuZSx3X7v/oecHGB275uUoTNFM3VeL/WY8VM4pSn8
   rLvOwturoaR5k6ZuWWTPuqQC14lVC80JqdKmZMFGx1zRzzGHNBpW6BQRt
   hBRJufFpIPzl2eY6AwG89TQLCBBMFYlF7lZyujAEfKs+DlAuAgWfrj75d
   QUx9DMVx1XQvjir6GEFdcRJhb+Nm7OoGJSgNH7demHQuWtqHZouvSmxMQ
   A==;
X-CSE-ConnectionGUID: b4q+FFvKTVSt1uYtZhag9A==
X-CSE-MsgGUID: q2fsNAuSQZmnqJqZUWAaKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="44423413"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="44423413"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 18:49:26 -0800
X-CSE-ConnectionGUID: /kpo08aXRHGEOo/HE2btyQ==
X-CSE-MsgGUID: QLEKQXMNSBeKQG2WvURcQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="93378911"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 18:49:23 -0800
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
Subject: [PATCH 1/1] EDAC/i10nm: Add Intel Clearwater Forest server support
Date: Tue,  3 Dec 2024 10:20:38 +0800
Message-Id: <20241203022038.72873-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

Clearwater Forest is the successor to Sierra Forest. Add Clearwater
Forest CPU model ID for EDAC support.

Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/i10nm_base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index 51556c72a967..5e18ddbbb8a5 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -948,6 +948,7 @@ static const struct x86_cpu_id i10nm_cpuids[] = {
 	X86_MATCH_VFM_STEPPINGS(INTEL_GRANITERAPIDS_X,	X86_STEPPINGS(0x0, 0xf), &gnr_cfg),
 	X86_MATCH_VFM_STEPPINGS(INTEL_ATOM_CRESTMONT_X,	X86_STEPPINGS(0x0, 0xf), &gnr_cfg),
 	X86_MATCH_VFM_STEPPINGS(INTEL_ATOM_CRESTMONT,	X86_STEPPINGS(0x0, 0xf), &gnr_cfg),
+	X86_MATCH_VFM_STEPPINGS(INTEL_ATOM_DARKMONT_X,	X86_STEPPINGS(0x0, 0xf), &gnr_cfg),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, i10nm_cpuids);

base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
-- 
2.17.1


