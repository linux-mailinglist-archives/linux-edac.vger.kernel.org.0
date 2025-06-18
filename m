Return-Path: <linux-edac+bounces-4161-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D29ADE19B
	for <lists+linux-edac@lfdr.de>; Wed, 18 Jun 2025 05:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ABD6163BA8
	for <lists+linux-edac@lfdr.de>; Wed, 18 Jun 2025 03:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CD71D47B4;
	Wed, 18 Jun 2025 03:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eZ4+L12+"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6527B2F5335;
	Wed, 18 Jun 2025 03:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750216832; cv=none; b=cmTGaH/VVBP6AIqrmR3IuWQLH+EYzU6gfmMpCuNPS750RRBLZkiD3k9VKpNI3Ol9W2Eors1GrVCWoI9hQSGvA+41983yoaWxxwhmce77y1oxT+vCWT0jW4uZVbeLmIvFZbtj9fhLfmRjsmR6/CBeXn8UBbwTb3zFw4GmEQrzixM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750216832; c=relaxed/simple;
	bh=6rJgoWt4G083fL/1cCEzBQ3/Id2/n618wiLRJIcRY+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dwbe++TlZxTNxtgPIr7uFv0pqLg83ebYlvOO8znXrZEad02moq/199Oj31vBceA9JHLEDQER/sGHlK2yRjqLM98p0QOeV1Ep/lyFb+1GLYjwYy7ns1+MgKKfNkOsY5/4e9aLezEZSWg4z4DBx+PDJ80yt3Y8hBxAkSHAi3mB/9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eZ4+L12+; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750216830; x=1781752830;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6rJgoWt4G083fL/1cCEzBQ3/Id2/n618wiLRJIcRY+A=;
  b=eZ4+L12+FdCQ3N/m4iptlBkJGRcRvryQt5AFBm7ZQxLQZaB9knjTidb1
   aKlqCt8Dk66CS/MDia00JhqwNnaTOOiG42XL1F5TgQD5UV1Fc/jG+V5rs
   d/d7Vk9mgbCILuPHL+z44HQvbX5ji4vR5nLiGmSMWFMY+6GQfwRlktYrz
   h1DEo1YIq1pFVOc0xT82wG0CAQV7zKYj3qyFCDKkO2MuDxjpET7CiYH98
   dqVWIXYFb1dA4JFxBHb7KgYerKd8gsTQaSZzLADGS3Tl7oPEOs2QQO16j
   ibqqdzmJtm2Yv6gqN07ScLAKSCZj384SYcchpFxIH372nmR+TJCj8dHH6
   w==;
X-CSE-ConnectionGUID: q6AEZrOXS5eqiCs77N76VQ==
X-CSE-MsgGUID: lAilvnXEQAKvf8RzKhiU4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="74952987"
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; 
   d="scan'208";a="74952987"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 20:20:30 -0700
X-CSE-ConnectionGUID: O0b0B8FeRCCGghPzu7iCzg==
X-CSE-MsgGUID: pSKz7skZR7WsagQ62p3GKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; 
   d="scan'208";a="148985309"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 20:20:27 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	marmarek@invisiblethingslab.com
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] EDAC/igen6: Fix NULL pointer dereference
Date: Wed, 18 Jun 2025 11:18:55 +0800
Message-ID: <20250618031855.1435420-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aFFN7RlXkaK_loQb@mail-itl>
References: <aFFN7RlXkaK_loQb@mail-itl>
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

This issue occurred because one memory controller was fused off by
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
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
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


