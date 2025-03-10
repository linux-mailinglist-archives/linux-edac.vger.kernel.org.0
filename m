Return-Path: <linux-edac+bounces-3322-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9313CA589F2
	for <lists+linux-edac@lfdr.de>; Mon, 10 Mar 2025 02:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E8A1188D661
	for <lists+linux-edac@lfdr.de>; Mon, 10 Mar 2025 01:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC391386C9;
	Mon, 10 Mar 2025 01:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h/tx52t6"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C40D2FB;
	Mon, 10 Mar 2025 01:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741570049; cv=none; b=Wd2OJ1BXBGUrnYhHbhcblyUcvv1b9t0HABqKSmOtUOhgxFWlkoadmKsnkPOmKdM07Igm/68jF3eY76juOItR/qeZ/QOLLtNVRwoXNOCrQKRJ3n7vyUtFIAxtg948WPxT/GdBW97wJB3yx53b90uROREb2KOOW4bMJvxLCNc4pnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741570049; c=relaxed/simple;
	bh=rxSbpLnmPg/f1C5iQZrRtp2qCYHu/UFoK9lKzu9mXjU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=BOkalOlfnQIzRNqCrmpkMYKhsUhwqfUfHX4oZkvHrpibkmGlQPfaTv+GwXjW4o9a7lb+z6XZP+MYhospDL/wyGyDm/uozNwneYW7FredChjnUWf/VHYBGfIl71Vmr5r+50KE6CGktvcD9OU6xLnHp5aeYpIN4SW1GW06kmWtDlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h/tx52t6; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741570048; x=1773106048;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=rxSbpLnmPg/f1C5iQZrRtp2qCYHu/UFoK9lKzu9mXjU=;
  b=h/tx52t6/7fZQ6LuMMiFwevBdJxKkq5Jef2r91CHdZ6AUt+PIUsk/xcR
   r+lBQf6A/j9YTnnclsNqW4jJsTAuP2Ndv3XM6eLIMupIsdU6NfOXLxk7g
   b3bSuNqNFc6hsVVpAadefUzpb8Fcm1ux5PQxC8SpvuoaTq2mCHzEeaBAi
   GedtiuNl18KJxXYWu6TGuK/YkmJ2hosir2+ei3WWfAd8724B1HR+jyB6n
   74Eqh04YtSomOObHCqng2wS0Ax7tJ2mwh1ungDVfRjumMPzFvnVgutyF5
   hXJpdbf0nF08i8mlLwubY11hJlcngaY4uBr8/iMf/jGCUquqg6wwZIr9v
   A==;
X-CSE-ConnectionGUID: nw8d7VlzTpG990jrjIeuPA==
X-CSE-MsgGUID: q3IyDrO3SXS6N/GqqOfzCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="67914518"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="67914518"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 18:27:27 -0700
X-CSE-ConnectionGUID: LyWHBSXQQyOBOesHlmU9UA==
X-CSE-MsgGUID: S+/fXDVjQrWl0iF250T17g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="124925399"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 18:27:24 -0700
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
Subject: [PATCH v2 00/11] Add EDAC support for Intel Raptor Lake-S SoCs
Date: Mon, 10 Mar 2025 09:14:00 +0800
Message-Id: <20250310011411.31685-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226015202.36576-1-qiuxu.zhuo@intel.com>
References: <20250226015202.36576-1-qiuxu.zhuo@intel.com>
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

Changes in v2:
 - 0001 ~ 0010 : No changes.
 - 0011        : 1) Update the commit message to clarify that the
                    correctable memory errors of RPL-S are notified
                    via CMCI, not by #MC.

                 2) Update the configuration field: s/machine_check/cmci/

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


base-commit: 079b06b8b3a057b0f04381b4144602577f875080
-- 
2.17.1


