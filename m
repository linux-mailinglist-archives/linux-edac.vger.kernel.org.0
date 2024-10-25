Return-Path: <linux-edac+bounces-2267-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B15DF9AF7F4
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2024 05:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB3C31C2100F
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2024 03:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3623B18BBA4;
	Fri, 25 Oct 2024 03:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hCrdAXrt"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11401C8DF;
	Fri, 25 Oct 2024 03:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729825769; cv=none; b=MrTDOcZ/O2yl6xSLRjLrjeuwP7OzM1xRFU6GBDv34oOin/p5y4ofpAnD6+QGe/7coxx9aQUNebDyXuC5YPID9j765jTA81iQI8qj5Jxie7yXqAHvnL8JTCJxi0xeooAc29bxGvIzibKVsdFdqAmyJl8j+VOIMyY3o3BMrkASyMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729825769; c=relaxed/simple;
	bh=6VJus/l5StwHkk8r49U4gwlOc1jAPg6JciXrbFlFxNY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=EhT31RcMoBQ+Lus+ccmW9mztSgs81F8yCAePdl5ug/eTr57kFbmQvGGtytv4faG5KJJLsuC+VLmFnCe93MVmSZce80UrhKOyAhVzL8HRUZsB9U56+eHFXVrozgZAv7hQZ5sAlJA13BlK/HYXgNdPJtYl4lCij44+ngufgo0QIuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hCrdAXrt; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729825767; x=1761361767;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=6VJus/l5StwHkk8r49U4gwlOc1jAPg6JciXrbFlFxNY=;
  b=hCrdAXrtxhGetD70Q+ZWwLSNNao+RHamqCRUCq/3FUb8h8yH+Jbz6A9r
   JEFrlI/qaOThEMdcJ36UqqSyOkzwpNh5Wi45n+IPe02YNniThItHxv+zB
   WkY6Mj5vwOLj/alUr3FN+MGOju/EkIhU/9PcV5K877IBp3yj8TwbbZ2Di
   wk4tgbv8Zr5zlYy3ri6G+n6JEcgZ89ste/ZB9Wko+gwEqrQMmoxHPRqzs
   qTN5qFlqPqDU/0sxMX4d/WysxcKg6UnJR7qGGeNWUToRC8w7bRjJl5DrW
   B9OP0iDnvLe+WVqVCIevvxrGKdR64gRVPZX2TmQ3dljEZ6lAaee4EnNmh
   g==;
X-CSE-ConnectionGUID: 44EbWmLSSOufocjbSBXOig==
X-CSE-MsgGUID: qsu2oyzxScCTdiJYrpWjdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="29385487"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="29385487"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 20:09:25 -0700
X-CSE-ConnectionGUID: au4VqgsXQX+4Nx/RT6QQhw==
X-CSE-MsgGUID: zy106mxaTZmo4gzV1v3QrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="80449088"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 20:09:24 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: bp@alien8.de,
	tony.luck@intel.com
Cc: tglx@linutronix.de,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	hpa@zytor.com,
	x86@kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	qiuxu.zhuo@intel.com
Subject: [PATCH v3 00/10] x86/mce: Clean up some x86/mce code
Date: Fri, 25 Oct 2024 10:45:52 +0800
Message-Id: <20241025024602.24318-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241016123036.21366-1-qiuxu.zhuo@intel.com>
References: <20241016123036.21366-1-qiuxu.zhuo@intel.com>
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

  - Fix some typos.

Pass the following basic tests:

  - Tested on an Intel Sapphire Rapids server.

  - Compile test.

  - System boot test.

  - Correctable/uncorrectable memory errors can be notified via CMCI/MCE interrupts.

  - Correctable/uncorrectable memory errors can be dispatched to the mcelog daemon and the EDAC driver.

Changes in v3:

  - Collect "Reviewed-by:" from Nikolay & Sohil.

  - Drop the "x86/mce: Remove the redundant zeroing assignments" patch.

  - 0003: Rename mce_notify_irq() to mce_notify_user().

  - 0005: Move the 'int ret' variable along with the other int variables.

  - 0006: New patch. Break up __mcheck_cpu_apply_quirks().

  - 0007: New patch. Convert family/model mixed checks to VFM-based checks.

  - 0009: Remove the variable names from the commit message.

  - 0010: Remove the detail typos from the commit message.

Changes in v2:

  - Collect "Reviewed-by:" from Tony.

  - 0009: Add the missing variable names to the commit message.

This series is based on v6.12-rc4.

Thanks Tony, Dave, Sohil and Nikolay for your review and discussion on this series.

Qiuxu Zhuo (9):
  x86/mce/dev-mcelog: Use xchg() to get and clear the flags
  x86/mce/intel: Use MCG_BANKCNT_MASK instead of 0xff
  x86/mce: Make several functions return bool and rename a function
  x86/mce/threshold: Remove the redundant this_cpu_dec_return()
  x86/mce/genpool: Make mce_gen_pool_create() return explicit error codes
  x86/mce: Convert family/model mixed checks to VFM-based checks
  x86/mce: Remove the unnecessary {}
  x86/mce/amd: Remove unnecessary NULL pointer initializations
  x86/mce: Fix typos

Tony Luck (1):
  x86/mce: Break up __mcheck_cpu_apply_quirks()

 arch/x86/include/asm/mce.h           |   4 +-
 arch/x86/kernel/cpu/mce/amd.c        |  18 +--
 arch/x86/kernel/cpu/mce/core.c       | 230 +++++++++++++++------------
 arch/x86/kernel/cpu/mce/dev-mcelog.c |  11 +-
 arch/x86/kernel/cpu/mce/genpool.c    |   9 +-
 arch/x86/kernel/cpu/mce/inject.c     |   2 +-
 arch/x86/kernel/cpu/mce/intel.c      |  11 +-
 arch/x86/kernel/cpu/mce/threshold.c  |   2 +-
 8 files changed, 149 insertions(+), 138 deletions(-)


base-commit: 42f7652d3eb527d03665b09edac47f85fb600924
-- 
2.17.1


