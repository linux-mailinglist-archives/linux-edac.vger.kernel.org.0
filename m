Return-Path: <linux-edac+bounces-2068-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC07D99DF7E
	for <lists+linux-edac@lfdr.de>; Tue, 15 Oct 2024 09:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C46F2834A5
	for <lists+linux-edac@lfdr.de>; Tue, 15 Oct 2024 07:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5B619F420;
	Tue, 15 Oct 2024 07:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BSgjl2kD"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E98317DFE3;
	Tue, 15 Oct 2024 07:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728978302; cv=none; b=lRwlp2dILnd41mShwkpwp7SdS0HanrZN8tM+vp96050ryXzhWAvN+6DZFvFMQ8CjLNoHMUpNGCkqive94SrGhQCVz+vu86vQZ9WFh9Sz8+C5ouGzY1vw/RMEjO4ux4i/nbRjLXAbSfBjv4VGJkDsBqrZUffH4p8zVM4gLMojio0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728978302; c=relaxed/simple;
	bh=pg6huS9orWVHA8z+tE8SRJtPswKHKWq9Ep/HS4CMVxY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ojQrLPesT8+tbdl3sLhHmJnwQ7RmRxxzFFNIuAndbTK/znk6y+iwhjNIf749XFw9OOfxngISIpzCOdNrOHlUA3Ri1YH20QjHvn8QVPB/IoIx3IU5uyjezErzZQ9xeiu83gzjfeHKuKt2xAV2iJN75QIHbBNUr7QTS2pVOKem6BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BSgjl2kD; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728978300; x=1760514300;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=pg6huS9orWVHA8z+tE8SRJtPswKHKWq9Ep/HS4CMVxY=;
  b=BSgjl2kDwgiCb+wjKpqYoi4ZPQ38gevv5DzNeXu+Ut8ywMlumf34REcp
   +qdHCaY4H72w/EytEM/2Ri6gQyZbMs6dLOjTwbazXZmPz5w3SRInWqFVd
   rCwYCGQLswxBFmiVJjCpi3uO1CbMkJpWCfo8dV8c1JnuWgrah5fDlpAtF
   cU5uJbOmkD94JT6KnBiyXE0wpgIenPPIwf+hJ/mo+hTSgC9n9YvRzB7XA
   Diayt73oxFV69tO2ne0TmwXX8SozJz7fNR5C353AGpLpedX+K3G72v7pl
   MgVmM36K55FO1U19zBh1TS1/0OLZS54H9Ma90Sq+H4M2IKNCQBrin47K+
   A==;
X-CSE-ConnectionGUID: XcFHxbdpSoK2YQ1ad4wdpA==
X-CSE-MsgGUID: 4aHA9Am7SFOBllJbh9PLnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="28483524"
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="28483524"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 00:44:58 -0700
X-CSE-ConnectionGUID: wCS3SrVoSca0hx60hbZoNQ==
X-CSE-MsgGUID: AJgsbuv5RL2Nxgk7p+ETVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="77752307"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 00:44:56 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Diego Garcia Rodriguez <diego.garcia.rodriguez@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] EDAC/skx_common: Distinguish the memory error source
Date: Tue, 15 Oct 2024 15:22:35 +0800
Message-Id: <20241015072236.24543-2-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241015072236.24543-1-qiuxu.zhuo@intel.com>
References: <20241015072236.24543-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

The current skx_common determines whether the memory error source is the
near memory of the 2LM system and then retrieves the decoded error results
from the ADXL components (near-memory vs. non-near-memory) accordingly.

However, some memory controllers may have limitations in correctly
reporting the memory error source, leading to the retrieval of incorrect
decoded parts from the ADXL.

To address these limitations, instead of simply determining whether the
memory error is from the near memory of the 2LM system, it is necessary to
distinguish the memory error source details as follows:

  Memory error from the near memory of the 2LM system.
  Memory error from the far memory of the 2LM system.
  Memory error from the 1LM system.
  Not a memory error.

This will enable the i10nm_edac driver to take appropriate actions for
those memory controllers that have limitations in reporting the memory
error source.

Fixes: ba987eaaabf9 ("EDAC/i10nm: Add Intel Granite Rapids server support")
Tested-by: Diego Garcia Rodriguez <diego.garcia.rodriguez@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/skx_common.c | 34 ++++++++++++++++------------------
 drivers/edac/skx_common.h |  7 +++++++
 2 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 85713646957b..52b462899870 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -119,7 +119,7 @@ void skx_adxl_put(void)
 }
 EXPORT_SYMBOL_GPL(skx_adxl_put);
 
-static bool skx_adxl_decode(struct decoded_addr *res, bool error_in_1st_level_mem)
+static bool skx_adxl_decode(struct decoded_addr *res, enum error_source err_src)
 {
 	struct skx_dev *d;
 	int i, len = 0;
@@ -136,7 +136,7 @@ static bool skx_adxl_decode(struct decoded_addr *res, bool error_in_1st_level_me
 	}
 
 	res->socket  = (int)adxl_values[component_indices[INDEX_SOCKET]];
-	if (error_in_1st_level_mem) {
+	if (err_src == ERR_SRC_2LM_NM) {
 		res->imc     = (adxl_nm_bitmap & BIT_NM_MEMCTRL) ?
 			       (int)adxl_values[component_indices[INDEX_NM_MEMCTRL]] : -1;
 		res->channel = (adxl_nm_bitmap & BIT_NM_CHANNEL) ?
@@ -620,31 +620,27 @@ static void skx_mce_output_error(struct mem_ctl_info *mci,
 			     optype, skx_msg);
 }
 
-static bool skx_error_in_1st_level_mem(const struct mce *m)
+static enum error_source skx_error_source(const struct mce *m)
 {
-	u32 errcode;
+	u32 errcode = GET_BITFIELD(m->status, 0, 15) & MCACOD_MEM_ERR_MASK;
+
+	if (errcode != MCACOD_MEM_CTL_ERR && errcode != MCACOD_EXT_MEM_ERR)
+		return ERR_SRC_NOT_MEMORY;
 
 	if (!skx_mem_cfg_2lm)
-		return false;
+		return ERR_SRC_1LM;
 
-	errcode = GET_BITFIELD(m->status, 0, 15) & MCACOD_MEM_ERR_MASK;
+	if (errcode == MCACOD_EXT_MEM_ERR)
+		return ERR_SRC_2LM_NM;
 
-	return errcode == MCACOD_EXT_MEM_ERR;
-}
-
-static bool skx_error_in_mem(const struct mce *m)
-{
-	u32 errcode;
-
-	errcode = GET_BITFIELD(m->status, 0, 15) & MCACOD_MEM_ERR_MASK;
-
-	return (errcode == MCACOD_MEM_CTL_ERR || errcode == MCACOD_EXT_MEM_ERR);
+	return ERR_SRC_2LM_FM;
 }
 
 int skx_mce_check_error(struct notifier_block *nb, unsigned long val,
 			void *data)
 {
 	struct mce *mce = (struct mce *)data;
+	enum error_source err_src;
 	struct decoded_addr res;
 	struct mem_ctl_info *mci;
 	char *type;
@@ -652,8 +648,10 @@ int skx_mce_check_error(struct notifier_block *nb, unsigned long val,
 	if (mce->kflags & MCE_HANDLED_CEC)
 		return NOTIFY_DONE;
 
+	err_src = skx_error_source(mce);
+
 	/* Ignore unless this is memory related with an address */
-	if (!skx_error_in_mem(mce) || !(mce->status & MCI_STATUS_ADDRV))
+	if (err_src == ERR_SRC_NOT_MEMORY || !(mce->status & MCI_STATUS_ADDRV))
 		return NOTIFY_DONE;
 
 	memset(&res, 0, sizeof(res));
@@ -667,7 +665,7 @@ int skx_mce_check_error(struct notifier_block *nb, unsigned long val,
 	/* Try driver decoder first */
 	if (!(driver_decode && driver_decode(&res))) {
 		/* Then try firmware decoder (ACPI DSM methods) */
-		if (!(adxl_component_count && skx_adxl_decode(&res, skx_error_in_1st_level_mem(mce))))
+		if (!(adxl_component_count && skx_adxl_decode(&res, err_src)))
 			return NOTIFY_DONE;
 	}
 
diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index f945c1bf5ca4..cd47f8186831 100644
--- a/drivers/edac/skx_common.h
+++ b/drivers/edac/skx_common.h
@@ -146,6 +146,13 @@ enum {
 	INDEX_MAX
 };
 
+enum error_source {
+	ERR_SRC_1LM,
+	ERR_SRC_2LM_NM,
+	ERR_SRC_2LM_FM,
+	ERR_SRC_NOT_MEMORY,
+};
+
 #define BIT_NM_MEMCTRL	BIT_ULL(INDEX_NM_MEMCTRL)
 #define BIT_NM_CHANNEL	BIT_ULL(INDEX_NM_CHANNEL)
 #define BIT_NM_DIMM	BIT_ULL(INDEX_NM_DIMM)
-- 
2.17.1


