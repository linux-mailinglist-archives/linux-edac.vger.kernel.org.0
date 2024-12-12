Return-Path: <linux-edac+bounces-2702-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEAC9EE851
	for <lists+linux-edac@lfdr.de>; Thu, 12 Dec 2024 15:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABE99167CB1
	for <lists+linux-edac@lfdr.de>; Thu, 12 Dec 2024 14:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C004215795;
	Thu, 12 Dec 2024 14:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eMA5e9ZO"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8729621505C;
	Thu, 12 Dec 2024 14:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734012271; cv=none; b=MDgIHAROHpYZtf7CI8L6fxjrAkuaO0WpoNlH13KlQikoX79lAufL7rtVhHkrRKHM0p+bHsXuo7NZLNfVTuPR/z27FLohGw2T/oaVQJiErNBG/OaQ46b+LCuJ1zOj2jnj0EAYioQEJ13fxK/ZBdnoqpUCwp8BB+hj9F63m2FEqyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734012271; c=relaxed/simple;
	bh=dRZuCgzkF8LRP0FHf8Z/ipBUnEl/jt69NXlBHfdeevU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=SKXldqVbFFCLk+R7qVRGFPhJ5tNmip/hdImV5T6cSu0dAT/V7NYIgcs53adOB3QikLElhanTPi9Fiuvb0uTPgS9GPZa0LQRfoTnv7sXgpPA6jZoJ0S5bYrMoecfiPnQ1pJ/q4n0DAuY/XzvMTZLzxzppGSBd2EKkE3n6eOaI7s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eMA5e9ZO; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734012270; x=1765548270;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=dRZuCgzkF8LRP0FHf8Z/ipBUnEl/jt69NXlBHfdeevU=;
  b=eMA5e9ZOavNyGYDsQ2gPIbYcG0XU/zdru0oiLpFbvLPFEfgmlWw5C4W+
   bv4r3pyOyTAhOFoBq4m+3io5iVY4SvBZnoep/iv4p1jMqvGzdyHumsF+X
   JvowGUR+ZvUCXQDQXj6zuzfPAZnmdRG98wJfoTLrNShRnQp6vP/xgUMpe
   dJwEaXZxEmKlEerxANEyIF0BRkbBtvi4j3NXnW3Y/OSG+j9OXe/H0ZtIv
   0V6L/yOgt2Q9hiCiJieBg8u9hc1UvwwK7no3DNnc2SiiPLJ1U1Cx/UUNw
   ydzlO6wo8PtxeAlSbwsF22T8M4+dEIS1lcORM5Y4bM1fvmi1Kg9oi2JST
   g==;
X-CSE-ConnectionGUID: jGpUyJo4SpOOoZVhBcK0RA==
X-CSE-MsgGUID: K8Z5iJ/FTZiYOeUoSL2uiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="34155317"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="34155317"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 06:04:00 -0800
X-CSE-ConnectionGUID: 0f2cORRfTDq8hXg94djBGg==
X-CSE-MsgGUID: LgLEob6QTJKK7undv+4DzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="96465621"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 06:03:56 -0800
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
Subject: [PATCH v5 7/7] x86/mce/amd: Remove unnecessary NULL pointer initializations
Date: Thu, 12 Dec 2024 22:01:03 +0800
Message-Id: <20241212140103.66964-8-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241212140103.66964-1-qiuxu.zhuo@intel.com>
References: <20241111060428.44258-1-qiuxu.zhuo@intel.com>
 <20241212140103.66964-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

Remove unnecessary NULL pointer initializations from variables that
are already initialized before use.

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
Changes in v5:
 - Collect "Reviewed-by:" Yazen.

Changes in v4:
 - No changes.

Changes in v3:
 - Collect "Reviewed-by:" Nikolay & Sohil.
 - Remove the variables' names from the commit message (Sohil).

 arch/x86/kernel/cpu/mce/amd.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 018874b554cb..c79a82912d38 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -921,8 +921,8 @@ static void log_and_reset_block(struct threshold_block *block)
  */
 static void amd_threshold_interrupt(void)
 {
-	struct threshold_block *first_block = NULL, *block = NULL, *tmp = NULL;
 	struct threshold_bank **bp = this_cpu_read(threshold_banks);
+	struct threshold_block *first_block, *block, *tmp;
 	unsigned int bank, cpu = smp_processor_id();
 
 	/*
@@ -1201,8 +1201,7 @@ static int allocate_threshold_blocks(unsigned int cpu, struct threshold_bank *tb
 static int __threshold_add_blocks(struct threshold_bank *b)
 {
 	struct list_head *head = &b->blocks->miscj;
-	struct threshold_block *pos = NULL;
-	struct threshold_block *tmp = NULL;
+	struct threshold_block *pos, *tmp;
 	int err = 0;
 
 	err = kobject_add(&b->blocks->kobj, b->kobj, b->blocks->kobj.name);
@@ -1312,8 +1311,7 @@ static void deallocate_threshold_blocks(struct threshold_bank *bank)
 
 static void __threshold_remove_blocks(struct threshold_bank *b)
 {
-	struct threshold_block *pos = NULL;
-	struct threshold_block *tmp = NULL;
+	struct threshold_block *pos, *tmp;
 
 	kobject_put(b->kobj);
 
-- 
2.17.1


