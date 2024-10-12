Return-Path: <linux-edac+bounces-2018-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A123D99B1A3
	for <lists+linux-edac@lfdr.de>; Sat, 12 Oct 2024 09:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6090E282B83
	for <lists+linux-edac@lfdr.de>; Sat, 12 Oct 2024 07:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7432914658F;
	Sat, 12 Oct 2024 07:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="azW55Rto"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B99130E57;
	Sat, 12 Oct 2024 07:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728718617; cv=none; b=PgNegqzZaXTc5vm7cZQPL/PRjqyQm/OUKogU3+jJPnrKND0DWYC4dQHlkzlI8sPSM2WXLhLpkXLeCh+/RFbCYjjpqmkBL6NcdeFEADLLgzafRuS4xkF1mUTkQUt2x4jpbMDgTK0d3gHenPc6kg5v9x+PSCvKWYO9n6t9y8dVBHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728718617; c=relaxed/simple;
	bh=6QYVydsJgmTUPzv4kPZhKTADS2dkg5kJ9nXjJn5lMOk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=OVC18mlqM/kt+QnhlSLhTgcfFQ6mS43+BylLfMcdUR/ealsjEklVlMng2psNXShNmAfogXiPgpeZQYONqoXd0fJhVZ25XypAD/itbgqWa6g/EHp0AvMLW9MPtu+i0v1us4fIH/bjFZqHZCNHRnCoM5hVTtv+haTTOtUQDU2I6EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=azW55Rto; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728718616; x=1760254616;
  h=from:to:cc:subject:date:message-id;
  bh=6QYVydsJgmTUPzv4kPZhKTADS2dkg5kJ9nXjJn5lMOk=;
  b=azW55RtoFxrAwwz5X4HiGyUyV8eH597EplS9b02mTEy9u74kpS89RGVA
   nAur9bFqBbDmq+d2qH2xAKBdgLq2gqk6iYlsXyR1Hdhnx8c4wocf/C1gb
   NSKFkI2Lx5LA5UQi3/O4FMyvOAb+YSsRUW76KGPxhBhwqnPwxS0zK/6iP
   cVNmPMp07ylzHFehqryLGc0k3Wn7Q8u+FVyX7YXbL/NG8TNDUNtXyyz9l
   OW1TIbaJ02yyreaMxqQitXYRCZSf295wUUmw7kLqLVaTjnX1orLVo4oDg
   s6RaOvP0B/mlDViSphHwntFjxgiT72NTVE948gyobV5bR+aD0iUAp12lB
   g==;
X-CSE-ConnectionGUID: xIa/9aToTTWcU6IVPPzs/Q==
X-CSE-MsgGUID: hO4d0OsoRBGFRlWCvv5CRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31825951"
X-IronPort-AV: E=Sophos;i="6.11,198,1725346800"; 
   d="scan'208";a="31825951"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2024 00:36:55 -0700
X-CSE-ConnectionGUID: kgOhXKc8SQa3mRMZVfuARg==
X-CSE-MsgGUID: SC/64dXoTmSWO71hzlhIsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,198,1725346800"; 
   d="scan'208";a="77116427"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2024 00:36:52 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>
Cc: Lili Li <lili.li@intel.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] EDAC/igen6: Add Intel Panther Lake-H SoCs support
Date: Sat, 12 Oct 2024 15:14:39 +0800
Message-Id: <20241012071439.54165-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

From: Lili Li <lili.li@intel.com>

Panther Lake-H SoCs share same IBECC registers with Meteor Lake-P
SoCs. Add Panther Lake-H SoC compute die IDs for EDAC support.

Signed-off-by: Lili Li <lili.li@intel.com>
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
Tested this patch on a real Panther Lake-H device.

 drivers/edac/igen6_edac.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index 189a2fc29e74..dd29a8d33b4e 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -263,6 +263,11 @@ static struct work_struct ecclog_work;
 #define DID_ARL_UH_SKU2	0x7d20
 #define DID_ARL_UH_SKU3	0x7d30
 
+/* Compute die IDs for Panther Lake-H with IBECC */
+#define DID_PTL_H_SKU1	0xb000
+#define DID_PTL_H_SKU2	0xb001
+#define DID_PTL_H_SKU3	0xb002
+
 static int get_mchbar(struct pci_dev *pdev, u64 *mchbar)
 {
 	union  {
@@ -605,6 +610,9 @@ static const struct pci_device_id igen6_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, DID_ARL_UH_SKU1), (kernel_ulong_t)&mtl_p_cfg },
 	{ PCI_VDEVICE(INTEL, DID_ARL_UH_SKU2), (kernel_ulong_t)&mtl_p_cfg },
 	{ PCI_VDEVICE(INTEL, DID_ARL_UH_SKU3), (kernel_ulong_t)&mtl_p_cfg },
+	{ PCI_VDEVICE(INTEL, DID_PTL_H_SKU1), (kernel_ulong_t)&mtl_p_cfg },
+	{ PCI_VDEVICE(INTEL, DID_PTL_H_SKU2), (kernel_ulong_t)&mtl_p_cfg },
+	{ PCI_VDEVICE(INTEL, DID_PTL_H_SKU3), (kernel_ulong_t)&mtl_p_cfg },
 	{ },
 };
 MODULE_DEVICE_TABLE(pci, igen6_pci_tbl);

base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
-- 
2.17.1


