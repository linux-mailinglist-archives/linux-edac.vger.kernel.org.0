Return-Path: <linux-edac+bounces-2485-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 826149C385B
	for <lists+linux-edac@lfdr.de>; Mon, 11 Nov 2024 07:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39F2F1F21E07
	for <lists+linux-edac@lfdr.de>; Mon, 11 Nov 2024 06:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F8B14F108;
	Mon, 11 Nov 2024 06:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M4425PQd"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8248468;
	Mon, 11 Nov 2024 06:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731306637; cv=none; b=Ciwelt9/SyN6QY42NsGrNmIL3VwxuI/LwOro1V+YqCtgCL8MAV1dNpFilclnU46tGssA2/3wxejDJirXQcIFwVycnxsRi1mLU07WCiC4169hVBtmQv9DZfrroSXePBj5HDEwjKxhbJCluCZlMrFaMh/LIcSDGNfOJ2xOJ+Vmj8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731306637; c=relaxed/simple;
	bh=fAHzf4MAwzhuJ5NME26Zoc7Us7w5hZ/IHuoF46kUzRk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=QqbafFohqtddBPmy1CkfK2vg1b/cs22ONV8/KJ5dILy9F0BFWQhWvstKXqekua02a0zQKTq4TwbGDCMr9tQL8CDJHYGRfMghOiiptTpvQ0JDV9D7l7Jwb9mkm9kr8oDj/LpKLJkhz33NN/CiXqUw3gqjDZydrNZmI7Ld0TAa5v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M4425PQd; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731306636; x=1762842636;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=fAHzf4MAwzhuJ5NME26Zoc7Us7w5hZ/IHuoF46kUzRk=;
  b=M4425PQdA2KcLd0Vuh/iB2A80ofe1QC9JQjmO1dkd0iNrxnRyWX70aI1
   hAGp5lQ9OmrPgLqFXbWczq6NNO+sF17OvcWxuloSQl5tDjTWggI6LZzFt
   EsqnmFhOgHChKOUkStnqHldgAREeqGXMjAbVRiwHlcJ3LzOkdFqTjUFpv
   w9vD8LcoeO0k8vTEcx9bDth+QA8zgKNakb6f/ySil1FiMkyRtgL06MDiK
   /89TZ6iAsFB7nWQ1DW7lMw8olfGQpZLZbwWOVi5qQqsFmiPkaidNRk7sG
   u3g9YWfuuoenx1JGHMKB/AcPipju7gRRCoCa2jKpjIBKJjfgjOXe/ptFt
   g==;
X-CSE-ConnectionGUID: esM8cwm5SvG8seu8l3hZmg==
X-CSE-MsgGUID: 8a0wZj0OR/K46TFzhOatmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11252"; a="41715395"
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="41715395"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 22:30:36 -0800
X-CSE-ConnectionGUID: HXHkKrjNQAeNRqEql50tmw==
X-CSE-MsgGUID: ocO0D1QtTlO0OAuVOHNRWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="117683396"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 22:30:33 -0800
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
Subject: [PATCH v4 0/8] x86/mce: Clean up some x86/mce code
Date: Mon, 11 Nov 2024 14:04:20 +0800
Message-Id: <20241111060428.44258-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241025024602.24318-1-qiuxu.zhuo@intel.com>
References: <20241025024602.24318-1-qiuxu.zhuo@intel.com>
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

This series is based on the TIP branch ras/core with top commit 612c2addff36.

Thanks Thomas, Boris, Tony, Dave, Sohil and Nikolay for your review and discussion on this series.

Qiuxu Zhuo (7):
  x86/mce: Make several functions return bool
  x86/mce/threshold: Remove the redundant this_cpu_dec_return()
  x86/mce: Make four functions return bool
  x86/mce: Convert family/model mixed checks to VFM-based checks
  x86/mce: Remove the unnecessary {}
  x86/mce/amd: Remove unnecessary NULL pointer initializations
  x86/mce: Fix typos

Tony Luck (1):
  x86/mce: Break up __mcheck_cpu_apply_quirks()

 arch/x86/include/asm/mce.h          |   4 +-
 arch/x86/kernel/cpu/mce/amd.c       |  18 +--
 arch/x86/kernel/cpu/mce/core.c      | 234 +++++++++++++++-------------
 arch/x86/kernel/cpu/mce/genpool.c   |  29 ++--
 arch/x86/kernel/cpu/mce/intel.c     |   9 +-
 arch/x86/kernel/cpu/mce/internal.h  |   4 +-
 arch/x86/kernel/cpu/mce/threshold.c |   2 +-
 7 files changed, 158 insertions(+), 142 deletions(-)


base-commit: 612c2addff367ee461dc99ffca2bc786f105d2ec
-- 
2.17.1


