Return-Path: <linux-edac+bounces-2695-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 896CD9EE828
	for <lists+linux-edac@lfdr.de>; Thu, 12 Dec 2024 15:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48AF1283C24
	for <lists+linux-edac@lfdr.de>; Thu, 12 Dec 2024 14:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128EC2135B9;
	Thu, 12 Dec 2024 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M9QUDKqS"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5772AF0E;
	Thu, 12 Dec 2024 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734012110; cv=none; b=kw3gybzWBPUE9TyY8VbPlE27vriN1RD7J7rB50epjZR75vv8YxWjvOv5nvRXyI56lZr+KEQOari9m4Y1Qc/MIwH4i39631b+2ZGkohmL0lcvt6zulMoC+2FI1JsjVyHie10dQidW1UOm/q1Wvut/uQOUFzArGZLfPUPjtSGWTRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734012110; c=relaxed/simple;
	bh=yN/7NKXaf5IZNycRjgggOT1nDFQtfPh/uUsMn3hE7f8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=p9/GjuzK1eJAyk6SIqCdiLa7S6rt5OoNAo5s/8oP9fD+GbJSXANF33Ec5K3EM5r4nsGDQEKWNoVxr5/ReXN46jGlni9fVyIwa3006IjqEDoKv+3S+Fl0SAs4loy85qjA+wYL6azkhxr0kaOh354u0+8moSfnWw3eD+6AON1sW2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M9QUDKqS; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734012109; x=1765548109;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=yN/7NKXaf5IZNycRjgggOT1nDFQtfPh/uUsMn3hE7f8=;
  b=M9QUDKqSDsqL8D5r8BBTqCMwqlC9Zq23su7VReIk38v3L0rYhJSPC4VF
   4fzmqWVunuy8usnsAE4Aialdo2zlS9tpn/if6MoYfKaP1atY3iEFTt6mX
   0WRAsx3NoeHqprZNcpp3pM45YMxl/mCQ7ozBaJTtTPdQVaXiVqb1mVuVq
   5NmTZnNq6/3H0G66J2nLcOF9V70HSQkhJe6W+CFXhNLytB256LpelWuV0
   1uZTcBK3xpHZ6id95mHUk+3quMAWGMnOhXbYARt3SiFDX8mXLnJ5ApEHw
   +VH/pHV927N/z0tv/Xb/0LBm/6LXZT3sEndbtclw9lUrZJ6lTC2i9IFFX
   Q==;
X-CSE-ConnectionGUID: BvhCFUhrS3iL8M+4hg5HIA==
X-CSE-MsgGUID: PbybUNiHRTexrwo4BrU5mw==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="34154678"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="34154678"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 06:01:48 -0800
X-CSE-ConnectionGUID: zR7yJjqeSky8LGXbZK2fJQ==
X-CSE-MsgGUID: LYTh2geKQdOmMwUj/dizOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="96464973"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 06:01:45 -0800
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: bp@alien8.de,
	tony.luck@intel.com
Cc: tglx@linutronix.de,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	hpa@zytor.com,
	yazen.ghannam@amd.com,
	sohil.mehta@intel.com,
	nik.borisov@suse.com,
	x86@kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	qiuxu.zhuo@intel.com
Subject: [PATCH v5 0/7] Clean up some x86/mce code
Date: Thu, 12 Dec 2024 22:00:56 +0800
Message-Id: <20241212140103.66964-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241111060428.44258-1-qiuxu.zhuo@intel.com>
References: <20241111060428.44258-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

Clean up some x86/mce code as below. No functional changes intended.
  - Simplify some code.
  - Remove some unnecessary code.
  - Improve readability for some code.
  - Convert some family/model mixed checks to VFM-based checks.

Pass the following basic tests:
  - Tested on an Intel Sapphire Rapids server.
  - Compile test.
  - System boot test.
  - Correctable/uncorrectable memory errors can be notified via CMCI/MCE interrupts.
  - Correctable/uncorrectable memory errors can be dispatched to the mcelog daemon and the EDAC driver.

Changes in v5:
  - Collect "Reviewed-by:" from Sohil & Yazen.
  - Drop "Fix typos" patch.
  - 0003: Update the commit message with mention the polarities of the return values are flipped.
  - 0005: Reduce 'if (mce_num_banks > 0)' to 'if (mce_num_banks)'.
  - 0006: Combine AMD and HYGON feature initialization and remove mce_hygon_feature_init().

Changes in v4:
  - Drop the first two patches as they've landed in the TIP ras/core branch.
  - Drop "Make mce_gen_pool_create() return explicit error codes" patch.
  - 0001: Don't rename mce_notify_irq().
  - 0003: New patch. Make four functions return bool.
  - 0004: Add necessary blank lines and directly use 'mca_cfg'.

Changes in v3:
  - Collect "Reviewed-by:" from Nikolay & Sohil.
  - Drop the "x86/mce: Remove the redundant zeroing assignments" patch.
  - 0003: Rename mce_notify_irq() to mce_notify_user().
  - 0005: Move the 'int ret' variable along with the other int variables.
  - 0006: New patch. Break up __mcheck_cpu_apply_quirks().
  - 0007: New patch. Convert family/model mixed checks to VFM-based checks.
  - 0009: Remove the variables' names from the commit message.
  - 0010: Remove the detail typos from the commit message.

Changes in v2:
  - Collect "Reviewed-by:" from Tony.
  - Update the commit message of patch 9 to include the names of all
    variables that don't need NULL pointer initializations.

This series is based on v6.13-rc2.

Thanks Thomas, Boris, Tony, Dave, Sohil, Yazen, and Nikolay for your review and discussion on this series.

Qiuxu Zhuo (6):
  x86/mce: Make several functions return bool
  x86/mce/threshold: Remove the redundant this_cpu_dec_return()
  x86/mce: Make four functions return bool
  x86/mce: Convert family/model mixed checks to VFM-based checks
  x86/mce: Remove the redundant mce_hygon_feature_init()
  x86/mce/amd: Remove unnecessary NULL pointer initializations

Tony Luck (1):
  x86/mce: Break up __mcheck_cpu_apply_quirks()

 arch/x86/include/asm/mce.h          |   6 +-
 arch/x86/kernel/cpu/mce/amd.c       |  18 +--
 arch/x86/kernel/cpu/mce/core.c      | 237 +++++++++++++++-------------
 arch/x86/kernel/cpu/mce/genpool.c   |  29 ++--
 arch/x86/kernel/cpu/mce/intel.c     |   9 +-
 arch/x86/kernel/cpu/mce/internal.h  |   4 +-
 arch/x86/kernel/cpu/mce/threshold.c |   2 +-
 7 files changed, 158 insertions(+), 147 deletions(-)


base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
-- 
2.17.1


