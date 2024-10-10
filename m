Return-Path: <linux-edac+bounces-1992-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE44D998C67
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2024 17:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54EB41F23E8D
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2024 15:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961171C3F34;
	Thu, 10 Oct 2024 15:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eZJ+W72Q"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCA31917FB;
	Thu, 10 Oct 2024 15:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728575618; cv=none; b=kmGoiEEXy3lVUbOPc781gQmjuSyFf5t3ZLSuvgp8XUH9gJ4ZwVgjk6y4noGp3C8hJUkgZEbESOHROsW8JU7IFM+nQYeleU9QnBiIrTTYShg0aY43jv7lsS81PadMQqqWInCRYj4HwzrwMxw9qH43cDqynX2PqR/CUtNJAig922s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728575618; c=relaxed/simple;
	bh=b68TMNixbJy7Wtf4/eoCaCNV0RHGXTaO6jAyhchzRFk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Q0VT+mbwm6QMOjdxajeGZw0S8myUK/+q4QsGFobStKiEfmI6pWYzlOU1zQiTsWKUQuRa63oyEGjnoQQow7WFtwTc43xNJZYf1VYd5h0loYNy8TfVXkj8+GILeBbQVMii44cS8cBEP9FRQvWTKtQeC8lEDeGc143XWn3aZ3RDqbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eZJ+W72Q; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728575617; x=1760111617;
  h=from:to:cc:subject:date:message-id;
  bh=b68TMNixbJy7Wtf4/eoCaCNV0RHGXTaO6jAyhchzRFk=;
  b=eZJ+W72QPzG1N2tuaViiXW5xR3nGxdqWOTOCeuCFaAxEwXl5AIwK6djZ
   8gxhNdDH0Ehsi/8aJKe3dtK4Sf2MWB1EYAPxb7ApAtbP/Ltogpf+GG2yq
   3faapVUDMA9/xFfecRUl06bnSGlxsfUH+bPA7qqvGmZERBGVKrvAkKIV3
   O+maqJsZcXGDek8xSTAnSZmRsxjECHLjDvJF1+LXb5GfZwGD3qwEEAOFA
   62535AkymeWe3R4fwPPWc8RmVLBOA3u/psplUri6wTeQgx0j9guYEiHym
   XxHRflLaQSUiJLyutgi5cVcwbOZx1Xq9OV94ZSHKhz90vNV0wnvMytCaI
   Q==;
X-CSE-ConnectionGUID: otw229xdQ+i91D7dygG0lg==
X-CSE-MsgGUID: 2yi5AJ/hQO+qfEJN+5mY1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="31643414"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="31643414"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 08:53:37 -0700
X-CSE-ConnectionGUID: Mt0Zb7ozRhGLwMLoG+5vuw==
X-CSE-MsgGUID: Bai38vZrSU6/zkNvc+ntDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="81221635"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 08:53:33 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: tony.luck@intel.com,
	bp@alien8.de
Cc: tglx@linutronix.de,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	hpa@zytor.com,
	x86@kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	qiuxu.zhuo@intel.com
Subject: [PATCH 00/10] Clean up some x86/mce code
Date: Thu, 10 Oct 2024 23:31:52 +0800
Message-Id: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

1. Clean up some x86/mce code as below. No functional changes intended.

    - Simplify some code.

    - Remove some unnecessary code.

    - Improve readability for some code.

    - Fix some typos.

    [ Reduce the text segment size by ~116 bytes. ]

2. Pass the following basic tests:

   - Compile test.

   - Correctable/uncorrectable memory errors can be notified via CMCI/MCE interrupts.

   - Correctable/uncorrectable memory errors can be dispatched to the mcelog daemon and the EDAC driver.

   [ Tested on an Intel Sapphire Rapids server. ]

3. This patch series is based on v6.12-rc2.

Qiuxu Zhuo (10):
  x86/mce/dev-mcelog: Use xchg() to get and clear the flags
  x86/mce/intel: Use MCG_BANKCNT_MASK instead of 0xff
  x86/mce: Make several functions return bool
  x86/mce/threshold: Remove the redundant this_cpu_dec_return()
  x86/mce/genpool: Make mce_gen_pool_create() return explicit error codes
  x86/mce: Convert multiple if () statements into a switch() statement
  x86/mce: Remove the unnecessary {}
  x86/mce: Remove the redundant zeroing assignments
  x86/mce/amd: Remove unnecessary NULL pointer initializations
  x86/mce: Fix typos in comments

 arch/x86/include/asm/mce.h           |  4 +--
 arch/x86/kernel/cpu/mce/amd.c        | 18 +++++------
 arch/x86/kernel/cpu/mce/core.c       | 47 ++++++++++++++--------------
 arch/x86/kernel/cpu/mce/dev-mcelog.c | 11 ++-----
 arch/x86/kernel/cpu/mce/genpool.c    |  8 ++---
 arch/x86/kernel/cpu/mce/intel.c      | 11 ++++---
 arch/x86/kernel/cpu/mce/threshold.c  |  2 +-
 7 files changed, 46 insertions(+), 55 deletions(-)


base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
-- 
2.17.1


