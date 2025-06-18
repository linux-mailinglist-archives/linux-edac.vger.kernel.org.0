Return-Path: <linux-edac+bounces-4174-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5B1ADF283
	for <lists+linux-edac@lfdr.de>; Wed, 18 Jun 2025 18:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3588C4A1687
	for <lists+linux-edac@lfdr.de>; Wed, 18 Jun 2025 16:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760762EE5ED;
	Wed, 18 Jun 2025 16:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Arj9sbtc"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C301C861F;
	Wed, 18 Jun 2025 16:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750263853; cv=none; b=pb8avVzcBzWIYTZNtX6RSXs5TJ505aSnBbEJ3gjpMKK+gv1CiO9Rss4J/IeR+uMzzfaAf65ehIBw9jTYzcG1p9WIXFx6bN5wcGPn75xoVZs3VplbDrlFuNjrbyIU9gvX4MvVvL5xlmOyXm5ouOW1tiYU1r4+Dn/G7ETVrekxIiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750263853; c=relaxed/simple;
	bh=LpnXSIsmxA1FuFrogSoh7zOoT8duqsFyTMNTWWi5Z+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cw1yoFHSueedLBWATQZiKv3GBnime8ZNLYVpZRWE0m4mTk4mZVmPQdF0drgji4FUVzGlwk/+psXUaDzjOyD6kUWysUbT0nnpzSZ4yAT59XZmfFzVZ73MzsVx2NRxPxIcz5KmLfq4MpIffjEehspjNXCwzbvMzgVu1wy4FrkBwXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Arj9sbtc; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750263852; x=1781799852;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LpnXSIsmxA1FuFrogSoh7zOoT8duqsFyTMNTWWi5Z+Y=;
  b=Arj9sbtceeNVmMFqVd8f58AFBbn4wtZfjwfz5OKNQUJO+/mYVI+8CyS5
   Q8jRr8gbEsIQJ9PN4QCVZVmOmCgKnEEZtM1UOSo6dG278JK1Cvjcb8lRh
   MjAQvUdmwsfjOnEl2fK7cHgufaTO6rIoYIZG9Fxr1Cc4iVFCmBBMgt+Xz
   IPHZocgx7gbkb2p3pswiMoJemzC2kDzc7s2Exr7ZwU7BLtF5U8s2GNqGI
   cjPQ/+nXhV3njPTbBV+2pjAV6/MwizwwOO4kiTtuBeapUqiyHBfkHPBF5
   j6Dl67HKCnWOCdxWR3gtRvwIp6j1wWuuctszdt7d2KxlK4Vc1fX1Ww4e3
   Q==;
X-CSE-ConnectionGUID: JAwlpou/TIa4WWobrqLtVw==
X-CSE-MsgGUID: rqCdo6CnSIunfmIbmSVQyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="52467521"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="52467521"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 09:24:11 -0700
X-CSE-ConnectionGUID: J2RqrhivS1iMmRGjAGvSnw==
X-CSE-MsgGUID: 0Rn7xJIDSVaNzKexdWn9ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="150533446"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 09:24:08 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: tony.luck@intel.com,
	bp@alien8.de
Cc: james.morse@arm.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marmarek@invisiblethingslab.com,
	mchehab@kernel.org,
	qiuxu.zhuo@intel.com,
	rric@kernel.org
Subject: [PATCH v2 1/2] EDAC/igen6: Fix NULL pointer dereference
Date: Thu, 19 Jun 2025 00:23:06 +0800
Message-ID: <20250618162307.1523736-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aFLV2YMOzXe4iP-I@agluck-desk3>
References: <aFLV2YMOzXe4iP-I@agluck-desk3>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A kernel panic was reported with the following kernel log:

  EDAC igen6: Expected 2 mcs, but only 1 detected.
  BUG: unable to handle page fault for address: 000000000000d570
  ...
  Hardware name: Notebook V54x_6x_TU/V54x_6x_TU, BIOS Dasharo (coreboot+UEFI) v0.9.0 07/17/2024
  RIP: e030:ecclog_handler+0x7e/0xf0 [igen6_edac]
  ...
  igen6_probe+0x2a0/0x343 [igen6_edac]
  ...
  igen6_init+0xc5/0xff0 [igen6_edac]
  ...

This issue occurred because one memory controller was disabled by
the BIOS but the igen6_edac driver still checked all the memory
controllers, including this absent one, to identify the source of
the error. Accessing the null MMIO for the absent memory controller
resulted in the oops above.

Fix this issue by reverting the configuration structure to non-const
and updating the field 'res_cfg->num_imc' to reflect the number of
detected memory controllers.

Fixes: 20e190b1c1fd ("EDAC/igen6: Skip absent memory controllers")
Reported-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
Closes: https://lore.kernel.org/all/aFFN7RlXkaK_loQb@mail-itl/
Suggested-by: Borislav Petkov <bp@alien8.de>
Tested-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
v1->v2:
  - Add "Tested-by" tag from Marek.
  - s/fused off/disabled/ in the commit message, as suggested by Tony. 

 drivers/edac/igen6_edac.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index 1930dc00c791..1cb5c67e78ae 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -125,7 +125,7 @@
 #define MEM_SLICE_HASH_MASK(v)		(GET_BITFIELD(v, 6, 19) << 6)
 #define MEM_SLICE_HASH_LSB_MASK_BIT(v)	GET_BITFIELD(v, 24, 26)
 
-static const struct res_config {
+static struct res_config {
 	bool machine_check;
 	/* The number of present memory controllers. */
 	int num_imc;
@@ -479,7 +479,7 @@ static u64 rpl_p_err_addr(u64 ecclog)
 	return ECC_ERROR_LOG_ADDR45(ecclog);
 }
 
-static const struct res_config ehl_cfg = {
+static struct res_config ehl_cfg = {
 	.num_imc		= 1,
 	.imc_base		= 0x5000,
 	.ibecc_base		= 0xdc00,
@@ -489,7 +489,7 @@ static const struct res_config ehl_cfg = {
 	.err_addr_to_imc_addr	= ehl_err_addr_to_imc_addr,
 };
 
-static const struct res_config icl_cfg = {
+static struct res_config icl_cfg = {
 	.num_imc		= 1,
 	.imc_base		= 0x5000,
 	.ibecc_base		= 0xd800,
@@ -499,7 +499,7 @@ static const struct res_config icl_cfg = {
 	.err_addr_to_imc_addr	= ehl_err_addr_to_imc_addr,
 };
 
-static const struct res_config tgl_cfg = {
+static struct res_config tgl_cfg = {
 	.machine_check		= true,
 	.num_imc		= 2,
 	.imc_base		= 0x5000,
@@ -513,7 +513,7 @@ static const struct res_config tgl_cfg = {
 	.err_addr_to_imc_addr	= tgl_err_addr_to_imc_addr,
 };
 
-static const struct res_config adl_cfg = {
+static struct res_config adl_cfg = {
 	.machine_check		= true,
 	.num_imc		= 2,
 	.imc_base		= 0xd800,
@@ -524,7 +524,7 @@ static const struct res_config adl_cfg = {
 	.err_addr_to_imc_addr	= adl_err_addr_to_imc_addr,
 };
 
-static const struct res_config adl_n_cfg = {
+static struct res_config adl_n_cfg = {
 	.machine_check		= true,
 	.num_imc		= 1,
 	.imc_base		= 0xd800,
@@ -535,7 +535,7 @@ static const struct res_config adl_n_cfg = {
 	.err_addr_to_imc_addr	= adl_err_addr_to_imc_addr,
 };
 
-static const struct res_config rpl_p_cfg = {
+static struct res_config rpl_p_cfg = {
 	.machine_check		= true,
 	.num_imc		= 2,
 	.imc_base		= 0xd800,
@@ -547,7 +547,7 @@ static const struct res_config rpl_p_cfg = {
 	.err_addr_to_imc_addr	= adl_err_addr_to_imc_addr,
 };
 
-static const struct res_config mtl_ps_cfg = {
+static struct res_config mtl_ps_cfg = {
 	.machine_check		= true,
 	.num_imc		= 2,
 	.imc_base		= 0xd800,
@@ -558,7 +558,7 @@ static const struct res_config mtl_ps_cfg = {
 	.err_addr_to_imc_addr	= adl_err_addr_to_imc_addr,
 };
 
-static const struct res_config mtl_p_cfg = {
+static struct res_config mtl_p_cfg = {
 	.machine_check		= true,
 	.num_imc		= 2,
 	.imc_base		= 0xd800,
@@ -569,7 +569,7 @@ static const struct res_config mtl_p_cfg = {
 	.err_addr_to_imc_addr	= adl_err_addr_to_imc_addr,
 };
 
-static const struct pci_device_id igen6_pci_tbl[] = {
+static struct pci_device_id igen6_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, DID_EHL_SKU5), (kernel_ulong_t)&ehl_cfg },
 	{ PCI_VDEVICE(INTEL, DID_EHL_SKU6), (kernel_ulong_t)&ehl_cfg },
 	{ PCI_VDEVICE(INTEL, DID_EHL_SKU7), (kernel_ulong_t)&ehl_cfg },
@@ -1350,9 +1350,11 @@ static int igen6_register_mcis(struct pci_dev *pdev, u64 mchbar)
 		return -ENODEV;
 	}
 
-	if (lmc < res_cfg->num_imc)
+	if (lmc < res_cfg->num_imc) {
 		igen6_printk(KERN_WARNING, "Expected %d mcs, but only %d detected.",
 			     res_cfg->num_imc, lmc);
+		res_cfg->num_imc = lmc;
+	}
 
 	return 0;
 

base-commit: e04c78d86a9699d136910cfc0bdcf01087e3267e
-- 
2.43.0


