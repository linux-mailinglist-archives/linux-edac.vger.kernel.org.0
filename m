Return-Path: <linux-edac+bounces-3202-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45467A452C6
	for <lists+linux-edac@lfdr.de>; Wed, 26 Feb 2025 03:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FAD43AC49C
	for <lists+linux-edac@lfdr.de>; Wed, 26 Feb 2025 02:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A241FFC44;
	Wed, 26 Feb 2025 02:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GizMn7ss"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94F147F4A;
	Wed, 26 Feb 2025 02:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740535430; cv=none; b=APTk6krYMKlfAe/S4YPe4wc/lzJSnQBTsMt0NAybAmO1vKkG6T1Ss0GnrluyJVdkM0sa+eTyncLurkz1EenjkHodiHgQ5+B/hhK7MaIROTOeor6kH+rQ5NU8XopohR3pdyvkASf9MjAlLr4DhwJuTG8Tr3txZgEtNi+oKRjZUXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740535430; c=relaxed/simple;
	bh=8eCh4A5o3GNS8GRHee/m7J2MLUsmPbtSX21L8prJpzA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=azr7Lz/aznEWViaEbBLbc+IrFKfdmt2une2eOdsFO4YLDTs4OV7Y28KHrddxX1zHkwei3gowzhWenlQgilPQ2qt6wtxh8A6oDYdGvmKvwPoPJRtkAxJsU9Gzx7mT4x1a8uOn8AMpdDeoCGKcnmIX8X5MBvwTBge2LxG52jLARCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GizMn7ss; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740535429; x=1772071429;
  h=from:to:cc:subject:date:message-id;
  bh=8eCh4A5o3GNS8GRHee/m7J2MLUsmPbtSX21L8prJpzA=;
  b=GizMn7ssMdb8LuZUAleQSijdudrFCM7SnHQ1tZ9SIoqjB68b7OHUTWNt
   e6r2BMKx4L0d2F0gzqvWuQwAaNDCVk8/PqwDeq7f0YLU4x45URJd6kkhG
   y2mdWrdmpwRh7BMawDfeZbkXlz0F2bDR9U7JfdunJMOn7IVyQDw0o3T+a
   jThV/zgMaCpzPib63j7aDtOp+R4rB+oOyJR6c0gMFHRmGqdXwsihRJSg1
   NMJ/YfLmA1H4lhYC7uXkZjB+4Yt/WMTcZIGe0DpUcTxY0JbroYcyJJVns
   B3Y4J9zOkIhmIVgX92UaWMbolKcd0qP8LIb5drMJTdkeyCOS2YK7t+su1
   w==;
X-CSE-ConnectionGUID: lDcKveKbTeKXLLuXUB5r8Q==
X-CSE-MsgGUID: 8x7JDsSGQoW3Ah2LB9FQxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="28959508"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="28959508"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 18:03:25 -0800
X-CSE-ConnectionGUID: lYJwZv5fS5aVrfSlm/S+zQ==
X-CSE-MsgGUID: k9+x47KkTAGzldJF3ZrpZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="121179524"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 18:03:22 -0800
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Jason Baron <jbaron@akamai.com>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Gary Wang <gary.c.wang@intel.com>,
	Yi Lai <yi1.lai@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] EDAC/ie31200: Add EDAC support for Intel Raptor Lake-S SoCs
Date: Wed, 26 Feb 2025 09:51:51 +0800
Message-Id: <20250226015202.36576-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

This series refactors the ie31200_edac driver to add EDAC support for Intel
client SoCs with multiple memory controllers and out-of-band ECC capability.
The first SoC with multiple memory controllers to be added is Raptor Lake-S.

Patch 0001 ~ 0005: Bug fixes and cleanup.
Patch 0006 ~ 0009: Refactor and make resource data configurable.
Patch 0010 ~ 0011: Add EDAC support for Raptor Lake-S.

This series is on top of:

  https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac-for-next

Qiuxu Zhuo (11):
  EDAC/ie31200: Fix the size of EDAC_MC_LAYER_CHIP_SELECT layer
  EDAC/ie31200: Fix the DIMM size mask for several SoCs
  EDAC/ie31200: Fix the error path order of ie31200_init()
  EDAC/ie31200: Fix the 3rd parameter name of *populate_dimm_info()
  EDAC/ie31200: Simplify the pci_device_id table
  EDAC/ie31200: Make the memory controller resources configurable
  EDAC/ie31200: Make struct dimm_data contain decoded information
  EDAC/ie31200: Fold the two channel loops into one loop
  EDAC/ie31200: Break up ie31200_probe1()
  EDAC/ie31200: Add Intel Raptor Lake-S SoCs support
  EDAC/ie31200: Switch Raptor Lake-S to interrupt mode

 drivers/edac/Kconfig        |   2 +-
 drivers/edac/ie31200_edac.c | 637 ++++++++++++++++++++++--------------
 2 files changed, 387 insertions(+), 252 deletions(-)


base-commit: b3205f5a415b88d73b18130af1bacefd876de8bf
-- 
2.17.1


