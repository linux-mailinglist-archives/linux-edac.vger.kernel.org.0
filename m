Return-Path: <linux-edac+bounces-2096-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6F79A0AC3
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 14:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C36D280EA8
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 12:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1EC1F8189;
	Wed, 16 Oct 2024 12:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M5wDCbOf"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A35206945;
	Wed, 16 Oct 2024 12:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729083220; cv=none; b=X7EH9HkQG/0S3XKNKA8aNpW6qU55ioWtddZNAFkvOapQBNd8nSRy7rDpaa339ueJnmv8nFWgtHTN/PschMc6mQDZNcjSahH2+rRP22vW10zY5XqgO3PDWDWi/TVgljkpamHqUeOP+Q7hMlJcuI8bA4orP42loIJIfW5B4SwwY/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729083220; c=relaxed/simple;
	bh=MYdWvQMzNgVnn/YA/XsqtsTxzmfDhV3ZeuC9irRKkZo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Z0S1lH9eK4ZijehYTDkmxv6N5/kG4Dl8N0tsm6TEV5s71VXL11buHxzOMO4BUpST5Zn5GY16F+0WeLB5gDJvBVf4sBLuYn56EG3fZ50a2MYrZ83/mKz3R+8J1E2f+cNXNWVqJ/oRni3iWNB1NPBiBw6FCKrHO6So/I1KdNJ0Whg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M5wDCbOf; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729083219; x=1760619219;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=MYdWvQMzNgVnn/YA/XsqtsTxzmfDhV3ZeuC9irRKkZo=;
  b=M5wDCbOfFVnmEfZS/+f5x0OdFh5yS3IEl1LAamyXM7bYALq9fmiTONLb
   JPKL1Ek7dibMThjS/y9a+uI6QcI6ilh1kuw4wISPnpaTZsrkVraOmGcQW
   1B/c4AMKeMiJt1taMQ3m56n4p5YgZTJdbK7Vn6ZNxtsgMoXINbRTmn6lH
   86uoHnpB1zYCdSg48fdHVxSeCwaAlN4tosS2Wat9k4GMV0u/z7IcjjLsj
   0F5olpxlzNrX1rqb5hkfhD2hDgFZ6yWAAfs0P99wUTTUdq5Jcoc7xlnNS
   cWWTdF3GwzCNKujvpQIruq8ohj4bdC/L8ErgOb0BDyl+ZqkkVpJ8o8bqY
   Q==;
X-CSE-ConnectionGUID: x4lvyTXrT3CiVI2jjstn+g==
X-CSE-MsgGUID: +RsLRAIASXSbnoQvk35MMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="32217415"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="32217415"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 05:53:37 -0700
X-CSE-ConnectionGUID: FpEVZkUBTiuaE7VkGSUH+A==
X-CSE-MsgGUID: mNZbp9+vR2m+7+31tecn3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="82761539"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 05:53:29 -0700
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
Subject: [PATCH v2 00/10] x86/mce: Clean up some x86/mce code
Date: Wed, 16 Oct 2024 20:30:26 +0800
Message-Id: <20241016123036.21366-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
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

3. This patch series is based on v6.12-rc3.

4. Changes in v2:

   - Collect "Reviewed-by:" tags for patch {1-8,10}.

   - Update the commit message of patch 9 to include the names of all
     variables that don't need NULL pointer initializations.

Thanks Tony for reviewing this patch series.

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


base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
-- 
2.17.1


