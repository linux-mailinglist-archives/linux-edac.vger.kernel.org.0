Return-Path: <linux-edac+bounces-4479-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38596B17387
	for <lists+linux-edac@lfdr.de>; Thu, 31 Jul 2025 16:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5A1E189E0BC
	for <lists+linux-edac@lfdr.de>; Thu, 31 Jul 2025 14:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC3B1AC44D;
	Thu, 31 Jul 2025 14:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LfumEIUV"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C186E15573F;
	Thu, 31 Jul 2025 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753973868; cv=none; b=UltxcMUav/zZmiJinjgBUi+bhd/Ufl0Rhh6nS7CRNp70+ALMqMNEEGQLeOdYVYJp9Cui0EUT3cFaJQeKiDvkbB00056d1yCYsmhkv5qGohXGlIL8pwzN9PzuLEB7TjNyYLXnmbZEvqHsbnbWoogc0GAO3AtzRsP6pwLSwn5P9ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753973868; c=relaxed/simple;
	bh=UFFR+hTx3dxFPTSyw62BqAvy6iS2U2OxnwlQbFRHkJw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P0ei5wnDcNDITru/H0mhQGPHA7d+gKHlvP4mbtzfglNYWU2ypVSJfFGiWkk5aQCON0xmUdkjZUOi9ud2phhmma7lHk4/6ZO/txPs8HMqVQ3AyNSrj7P9u8QrScA+x201KBtlCV24BJdk1qtqLRUzw/6PIuxE8Xk4s9L1LNO5qXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LfumEIUV; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753973866; x=1785509866;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UFFR+hTx3dxFPTSyw62BqAvy6iS2U2OxnwlQbFRHkJw=;
  b=LfumEIUV333va11DgxtnlPAEoRqEn/CVE2rtlmz8Zf8myerri20pOkD2
   pBjZzoZwD3x3kdJXFGdaOPNW2W/IvLzmLdbkaDcNT6Xa6bmfdPzsOIUs+
   Xmds17L4OspQ/X9lvn4lPpRW2JzdYy5ePaTRg+PyvsFoq4QhfHlIkRwuB
   VnaOl8Simvqps/U6OyBi1JahGdGnrQUL+2RuyYNfwwoeD7RzjCzQYCBQZ
   ckIiCQ88qtxVxixHoUPGvrSrrpAXkYq4g/SYywaizyqL+LwjoQPsFSHQg
   JIiAdSBAbaXFPfD56WXedR/PAd4xX0PACnPXc8NujhdAJTPcAFxKLaZG8
   w==;
X-CSE-ConnectionGUID: 9XizOVkOSTagIsJhLTpA6g==
X-CSE-MsgGUID: QWw8RBQdRdOvsO1PhSEsuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="56231695"
X-IronPort-AV: E=Sophos;i="6.17,353,1747724400"; 
   d="scan'208";a="56231695"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 07:57:46 -0700
X-CSE-ConnectionGUID: w17u4r+jSBeL1zfWrabTfg==
X-CSE-MsgGUID: ldNseBrTRZ2jw4+KoBwwxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,353,1747724400"; 
   d="scan'208";a="163633289"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 07:57:44 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Lai Yi <yi1.lai@linux.intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] EDAC/Intel: Make memory controller instances into a flexible array
Date: Thu, 31 Jul 2025 22:55:27 +0800
Message-ID: <20250731145534.2759334-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Problem
=======
The current array of memory controller instances for Intel server EDAC
driver is sized using the macro NUM_IMC. Each time EDAC support is added
for a new CPU, NUM_IMC needs to be updated to ensure it is greater than
or equal to the number of memory controllers for the new CPU. This approach
is inconvenient and also results in memory waste for older CPUs with fewer
memory controllers.

Solution
========
Make the array of memory controller instances a flexible array and
determine its size from configuration data or at runtime.

Patches
=======
Patch 1~3: Refactor code to be independent of *NUM*_IMC macros.
Patch   4: Make the array of memory controller instances a flexible array.
Patch 5~7: Clean up and remove unused *NUM*_IMC macros.

Testing
=======
Pass basic testing on Cascade Lake, {Sapphire, Granite} Rapids server CPUs.
- Load and unload the {skx,i10nm_}edac driver.
- Receive events for memory correctable errors.
- Decode memory errors.

This patch series is on top of v6.16.

Qiuxu Zhuo (7):
  EDAC/{skx_common,skx}: Use configuration data, not global macros
  EDAC/skx_common: Move mc_mapping to be a field inside struct skx_imc
  EDAC/skx_common: Swap memory controller index mapping
  EDAC/skx_common: Make skx_dev->imc[] a flexible array
  EDAC/skx_common: Remove redundant upper bound check for res->imc
  EDAC/i10nm: Reallocate skx_dev list if preconfigured cnt != runtime cnt
  EDAC/skx_common: Remove unused *NUM*_IMC macros

 drivers/edac/i10nm_base.c | 13 +++++-----
 drivers/edac/skx_base.c   | 33 +++++++++++++++----------
 drivers/edac/skx_common.c | 51 +++++++++++++++++++++++++--------------
 drivers/edac/skx_common.h | 28 +++++++++------------
 4 files changed, 72 insertions(+), 53 deletions(-)


base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
-- 
2.43.0


