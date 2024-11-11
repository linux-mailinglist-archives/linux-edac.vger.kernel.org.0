Return-Path: <linux-edac+bounces-2487-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4928B9C3863
	for <lists+linux-edac@lfdr.de>; Mon, 11 Nov 2024 07:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D481282298
	for <lists+linux-edac@lfdr.de>; Mon, 11 Nov 2024 06:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827BC14F11E;
	Mon, 11 Nov 2024 06:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MpsxrEmg"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B001537CB;
	Mon, 11 Nov 2024 06:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731306770; cv=none; b=GjMbqoaIGoSmcw2KGGkBudJGS15Zf3fAUwlOTgkupKbjjAb9bMZ5Ikk1mABQeh3kKEBShDmmFy3+n58MZTe2K98UUolUAQ6+5ayMP38sbpxkzaPDfURi728QLeXaTFrJIgy/GGKqN39kFMZmqB7kyPF5mOk+dqE2I7341BfFBN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731306770; c=relaxed/simple;
	bh=/AWJNoGtjJs0iyapRlMs7kRqft2NxMZF9Cam36lL7fA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=MEFFuaIqemWN0dy2vqZMKRry/4U3QPRNiOwdZGJr+MkWwirZeUc5tBdS6wdu7JcgmPL6/cBI8/BX8giwgnalWlOG+Z8JPErrlHZ4DiQqFfjpbDj7iqxR8KU1yfL8AKV878GfB3PyTZQkiphID/xKp/unRY8CwfAGDRqtZ+qsKqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MpsxrEmg; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731306768; x=1762842768;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=/AWJNoGtjJs0iyapRlMs7kRqft2NxMZF9Cam36lL7fA=;
  b=MpsxrEmg0Et3FffTFTpO3Pm890kscEKngt/aOvobPqMKGDIs16Au+Uqx
   Nd2bFbIDmW2jipVoY1zK0Q0DngmBRgdi3VQv4uyaq3MWsa7L7ZTdCpsTd
   YjKPTa3FFSq3ZiQN1Uv2Npv1qg/f+kHohL+KoKTB+kKR/Rmf0IoXJlNJi
   ImRgz7h6v8P0fxjRdzh6eXlCyA+dqhoj5m32/giJVU6bOgKBZnxBqhwuZ
   bp582Ur2rC5TvgDpnR7sWTGeIGWhSKmLex3m9cevXWNtonGKkM6Pmj/pb
   x4SUUwWx9G9yhs2nVPg9+XIyXoW0buk1uKr6XoQ3DoXwyJCrNAum5Pnyi
   A==;
X-CSE-ConnectionGUID: oOJ/W2j/RaeBFUF5Y0Dtpg==
X-CSE-MsgGUID: GWHLdMrSRz6k32qC8/Qm4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11252"; a="41715498"
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="41715498"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 22:32:47 -0800
X-CSE-ConnectionGUID: /l+O6dDfSVCIv0h2AbEFew==
X-CSE-MsgGUID: 2W6kR94ZSeeQX1sFlkRIng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="117684566"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 22:32:44 -0800
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
Subject: [PATCH v4 2/8] x86/mce/threshold: Remove the redundant this_cpu_dec_return()
Date: Mon, 11 Nov 2024 14:04:22 +0800
Message-Id: <20241111060428.44258-3-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241111060428.44258-1-qiuxu.zhuo@intel.com>
References: <20241025024602.24318-1-qiuxu.zhuo@intel.com>
 <20241111060428.44258-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

The 'storm' variable points to this_cpu_ptr(&storm_desc). Access the
'stormy_bank_count' field through the 'storm' to avoid calling
this_cpu_*() on the same per-CPU variable twice.

This minor optimization reduces the text size by 16 bytes.

  $ size threshold.o.*
     text	   data	    bss	    dec	    hex	filename
     1395	   1664	      0	   3059	    bf3	threshold.o.old
     1379	   1664	      0	   3043	    be3	threshold.o.new

No functional changes intended.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
Changes in v4:
  - No changes.

Changes in v3:
  - Collect "Reviewed-by:" from Nikolay & Sohil.

Changes in v2:
  - Collect "Reviewed-by:" from Tony.

 arch/x86/kernel/cpu/mce/threshold.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/threshold.c b/arch/x86/kernel/cpu/mce/threshold.c
index 89e31e1e5c9c..f4a007616468 100644
--- a/arch/x86/kernel/cpu/mce/threshold.c
+++ b/arch/x86/kernel/cpu/mce/threshold.c
@@ -90,7 +90,7 @@ void cmci_storm_end(unsigned int bank)
 	storm->banks[bank].in_storm_mode = false;
 
 	/* If no banks left in storm mode, stop polling. */
-	if (!this_cpu_dec_return(storm_desc.stormy_bank_count))
+	if (!--storm->stormy_bank_count)
 		mce_timer_kick(false);
 }
 
-- 
2.17.1


