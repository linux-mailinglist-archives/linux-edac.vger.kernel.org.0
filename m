Return-Path: <linux-edac+bounces-2491-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 480059C386F
	for <lists+linux-edac@lfdr.de>; Mon, 11 Nov 2024 07:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFA9E282349
	for <lists+linux-edac@lfdr.de>; Mon, 11 Nov 2024 06:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98420158208;
	Mon, 11 Nov 2024 06:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cMQIwlgn"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EF1156C72;
	Mon, 11 Nov 2024 06:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731306843; cv=none; b=HtKZlGd807tfj+BSCAdHf4lMJwYAiZXpjALl8WtoD3XuNttm12FffVH/M7UlaFDgjBT7+zqcfl0oEJ2pYu5I2I/i+ZlCiRbDjvW0dHBJt5Y+tQ0g4Y2TDU5Ny2EQHvENgV4Gy/kdI+Xc1PDL3rrXd+5FY77sXv6fa62HPgW7SiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731306843; c=relaxed/simple;
	bh=qy2wWiKTb3IOuAPcP5uTKIFIxLWlQ+doXmpS3z6D9MU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Biq1J6jcrSwztjxZ02YGT//4z8I3CVagZ+410nPlChzoCafDtu1qR+Cl122M3aVV6C9CI3ilQsanFte8LsLfZ39sfSuueIiHd8GwhARohQDhJqme0SQfdwZGfQr4JsCJ+LOQ3O7a5S6tIlkL3XaVY7gcp1hiYnHHIPaLcul8DtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cMQIwlgn; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731306842; x=1762842842;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=qy2wWiKTb3IOuAPcP5uTKIFIxLWlQ+doXmpS3z6D9MU=;
  b=cMQIwlgnyfQD2cT62fun7kIuMdEsA+rTRjCuuecJICCKP3lK+bIL4FH4
   xpFntQYeTdSiie4muAdYk9pyaajOVOIpIlywwxToVFPGabkEbTabHg9vc
   U9zvtIT5OSZyLZc4/Qt+9aZNLEppY+3T4EUu26ppiPDjqAJS2N2BydDvW
   g8zF+u5l+btiZLe7bg4kBBJ2EVj+5eyMAxOsUdlWPQjhNmNrZperA5OP5
   dto65S+0mmSA0qMHxTL6eCSEwlnNDFemg48HWsr549j0LNhfpS6gFbl8H
   s0tbnt7X14MVVg38YDEhwF+ZkF70tIEqqE8yqB0SfHmcGIPEFsVX21N+8
   A==;
X-CSE-ConnectionGUID: cIGW5CeCThG2PNE49iupMg==
X-CSE-MsgGUID: kxM7c6cCTgCNlNQBpN2cSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11252"; a="41715613"
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="41715613"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 22:34:00 -0800
X-CSE-ConnectionGUID: hvUX9vf7S9qElt3G6KbuAw==
X-CSE-MsgGUID: wse4bnf9Q7K05094GJIxAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="117684686"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 22:33:57 -0800
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
Subject: [PATCH v4 6/8] x86/mce: Remove the unnecessary {}
Date: Mon, 11 Nov 2024 14:04:26 +0800
Message-Id: <20241111060428.44258-7-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241111060428.44258-1-qiuxu.zhuo@intel.com>
References: <20241025024602.24318-1-qiuxu.zhuo@intel.com>
 <20241111060428.44258-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

Remove the unnecessary {} from the case statement.

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

 arch/x86/kernel/cpu/mce/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index d288cc7390f6..0f0c6e9d9183 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2118,10 +2118,9 @@ static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
 		mce_intel_feature_init(c);
 		break;
 
-	case X86_VENDOR_AMD: {
+	case X86_VENDOR_AMD:
 		mce_amd_feature_init(c);
 		break;
-		}
 
 	case X86_VENDOR_HYGON:
 		mce_hygon_feature_init(c);
-- 
2.17.1


