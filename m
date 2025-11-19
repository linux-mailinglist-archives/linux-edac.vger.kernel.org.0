Return-Path: <linux-edac+bounces-5468-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E60D7C6F049
	for <lists+linux-edac@lfdr.de>; Wed, 19 Nov 2025 14:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 7589629846
	for <lists+linux-edac@lfdr.de>; Wed, 19 Nov 2025 13:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D29F35E551;
	Wed, 19 Nov 2025 13:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EkuFBNYn"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597F535A15F;
	Wed, 19 Nov 2025 13:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763560104; cv=none; b=ZeEerFF5O9XTPGuC4BYse/hrvIktbI2xKoBk9OPTladBy8/4/huGZT3J+8Cy3SKUhU9OE9r7eeJ9NxzkE7L5+om16hR/0fxyxaCfqFKA8djfOqkH+75cYy609cYATSDyp04HP3Pyefdn9tdmn7HNIqAOP3z6CaLKwOPGoT2a7Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763560104; c=relaxed/simple;
	bh=/HR9pRkDr4OTLbqQWfk5Wbc0SwU9gSccVUfGW3R7Iy0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oDOvf0MZjXT1JvYFPtK9rwwdEFCKmnrVS3F3LQMY3AZUONOMaAaeiezac2Oc+KnGlVIY923+PtH7MAFw7ibFBWknzNO0cJ0XWwH+XXDf1S/UmJN2m1wlhW9ucnWvqBiNg3v4Tv7bkQE6/MfeOlpa8uQTmurU8J7UpZ3/n9NLbwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EkuFBNYn; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763560102; x=1795096102;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/HR9pRkDr4OTLbqQWfk5Wbc0SwU9gSccVUfGW3R7Iy0=;
  b=EkuFBNYn4JzDz1fNa1j88TP/l1gIGCdtNFnlP39qnpi/R+ztcsjU/uG5
   hJ2LaCnpl4Ha+4h58oCrmOyMZaTkH6qz1VVOD3kK1PlE+x2IPxHPm8pzx
   O53ZwxjH3d4INszPcMEQTiYP2UZ1nP9hElKprY5KOrhhWJlCCbokppNhr
   q8e49w2EDhgaxH0CrcD3KXJb6isOh0xnFg/8p8eH0WwFgAtwG+Ii5O3jM
   DbLs8YvjOjjXSttWjdqhjXFMRy4oNlrwc5h1hxwVrPxJmzXMBtSZF62A0
   CKnS+tITRyE9/ZG+NKM4Dup3DVyAKIodv43FGyqjb4z3WSohjTe/d0AsF
   w==;
X-CSE-ConnectionGUID: zJQwHFgBSuSXxkjBpqiLnA==
X-CSE-MsgGUID: FkgLRthZQ1ioudHkkT+mEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="64607114"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="64607114"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 05:48:22 -0800
X-CSE-ConnectionGUID: f4oL0YUpSL6iKKIEx6cQ2g==
X-CSE-MsgGUID: TfjKPVa8Rw6i5MtR4tTYyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="214439016"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 05:48:20 -0800
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Lai Yi <yi1.lai@linux.intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] EDAC: Add Intel Diamond Rapids server support
Date: Wed, 19 Nov 2025 21:41:24 +0800
Message-ID: <20251119134132.2389472-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new EDAC driver for Intel Diamond Rapids CPUs. The reasons for a
separate driver instead of building on top of previous EDAC driver are
as follows:

  1) The memory controllers of Intel Diamond Rapids server CPUs are not
     presented as PCI devices to the OS, unlike previous generations.
     The enumeration and all memory controller registers have been
     transitioned to MMIO-based memory spaces.

  2) Modifications to previous EDAC driver for Diamond Rapids CPUs would 
     require extensive validation checks against multiple platforms,
     including Ice Lake, Sapphire Rapids, Emerald Rapids, Granite Rapids,
     Sierra Forest, and Grand Ridge.

  3) Future Intel CPUs will likely only need patches on top of this new
     EDAC driver. Validation can be limited to Diamond Rapids servers
     and future Intel CPU generations.

The patch series is constructed as following parts:

  Patch 1~3: Update the skx_common library to prepare for Diamond Rapids EDAC driver.
  Patch   4: Add Diamond Rapids EDAC driver.
  Patch   5: Extend DRAM chip row bits.
  Patch   6: Detect 2-level memory configuration.
  Patch   7: Add debugfs testing node.

Qiuxu Zhuo (7):
  EDAC/{skx_common,skx,i10nm}: Make skx_register_mci() independent of pci_dev
  EDAC/skx_common: Prepare for skx_get_edac_list()
  EDAC/skx_common: Prepare for skx_set_hi_lo()
  EDAC/{skx_common,imh}: Add EDAC driver for Intel Diamond Rapids servers
  EDAC/skx_common: Extend the maximum number of DRAM chip row bits
  EDAC/{skx_comm,imh}: Detect 2-level memory configuration
  EDAC/imh: Setup 'imh_test' debugfs testing node

 drivers/edac/Kconfig      |  10 +
 drivers/edac/Makefile     |   3 +
 drivers/edac/i10nm_base.c |   3 +-
 drivers/edac/imh_base.c   | 602 ++++++++++++++++++++++++++++++++++++++
 drivers/edac/skx_base.c   |   4 +-
 drivers/edac/skx_common.c |  33 ++-
 drivers/edac/skx_common.h |  98 +++++--
 7 files changed, 717 insertions(+), 36 deletions(-)
 create mode 100644 drivers/edac/imh_base.c


base-commit: 6a23ae0a96a600d1d12557add110e0bb6e32730c
-- 
2.43.0


