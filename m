Return-Path: <linux-edac+bounces-1999-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC299998C81
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2024 17:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 279821C240A2
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2024 15:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A8E1CEEAB;
	Thu, 10 Oct 2024 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RhrZDpeZ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174911CEE97;
	Thu, 10 Oct 2024 15:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728575765; cv=none; b=Ipu2BjGBOkJiSkjv0BFT+k9Raozfp7+aF7lfIbLE9aPldvzCKIRg/vqmixbwi9AirpuklUi0SWKn2XvwNkKQccZSvSfxTIaCnRUxRHEMOlRD8vr5qbvrqdikLy7zHs3bvukG+UVwJdn2t+pwHLpUgWF9EXBMQ0+N5lykJTVb5MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728575765; c=relaxed/simple;
	bh=WjIJysxc0a7IXs7+dCgPg2xAxrCZA2nBFfYdAYMs99k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ZANBxpncgC9xAE9PIxvlTQ4puYjCk+wzoOUtODTr6WDTUojEPixv1I+hsp4tLo/aZKDDfnC4/Ps0aw1bvR2keXHVNjvhlLpwzq85aEHOXyQI23CwGchx8F//WDfiSteOC6j3XSWxIUqD0wlSlrCmV3p6oOFS5M5mLgrh5Jm2bfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RhrZDpeZ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728575764; x=1760111764;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=WjIJysxc0a7IXs7+dCgPg2xAxrCZA2nBFfYdAYMs99k=;
  b=RhrZDpeZ4p6Zl6wImI7fToQSiKJKYZpBwNEE4QNGCx2uhmk0caXyTZ5c
   a8TLmMSKj3noN586Ok1m7MPvI1UET7hzzOginZ6balswGx8nXYQr8NO7c
   ChRCNqO9Fi0zLnJm+6SwyrJMUUuuCkrbXPJZFs1a+F7BTw2I7oZ/rqQi3
   YLHJRPjdTfDkn6OfHrJf3W+FCCVqUz83WgAdEz+/AU1q2yzoASc17pVXh
   z09cPR717MVqnvxuz38XWZYjfFNrhhTfTYHaDW2rwwFoQ+D+hseill261
   Ff5g+HI2CYKCn6r+Gh/W/K76Hp360v3SyygTid71cqdU125repzIuv85i
   A==;
X-CSE-ConnectionGUID: Mg1OON4ORXaJV5C5pzCHcA==
X-CSE-MsgGUID: AxJ+ueBzQ7aSfLiQxMMGuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="45423225"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="45423225"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 08:56:04 -0700
X-CSE-ConnectionGUID: 3dzK/nIHT7i0ZJScdxjaSQ==
X-CSE-MsgGUID: f1oiLAG4T5qfcKXIy4uueA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="81222665"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 08:56:01 -0700
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
Subject: [PATCH 07/10] x86/mce: Remove the unnecessary {}
Date: Thu, 10 Oct 2024 23:31:59 +0800
Message-Id: <20241010153202.30876-8-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

Remove the unnecessary {} from the case statement.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 arch/x86/kernel/cpu/mce/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 40672fe0991a..e718b9bbe8e5 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2073,10 +2073,9 @@ static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
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


