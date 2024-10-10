Return-Path: <linux-edac+bounces-1996-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9DE998D1C
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2024 18:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EF49B3C4A7
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2024 15:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5281CDFBD;
	Thu, 10 Oct 2024 15:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vh662cWJ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2B51CDA3C;
	Thu, 10 Oct 2024 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728575733; cv=none; b=LlymuorRJSibwyMbLdJ38yMJbS6EVBQ6+HIlhtUqqVithpz7tYxqIf0xODSxLmYp5JEaTtwRr/EBAcJ/R/tPefZEotrSXyoMIO8TITXRHNRz/f/ksJ79G+I437mkR0aQzd70FKA9c5/6uVjAhUzr9RpASHd/R1b+P45aZDu+YTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728575733; c=relaxed/simple;
	bh=dg+XAhmc+4FB4g2UYGzIBE6hIwhB0IzTGZr4sVNf/R8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=SCln7LVxF3NiF4kM9XI6acubh3aG40xVpqR61so0mOBDP6+vqyyVM5zwWNRKpXkl2BxXZ94ad50aBH2KsJcYTvZdfff+U6OWrBNA6HFbpefMLghdSiJGSFskXJrceUDaoY73W3/ZfFL3N6RBGu/VdEZy1WKioOR3LIu9rExTI7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vh662cWJ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728575733; x=1760111733;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=dg+XAhmc+4FB4g2UYGzIBE6hIwhB0IzTGZr4sVNf/R8=;
  b=Vh662cWJ8X4Opp8WYcJEestVkEyqCID4wraa++7pDrtZ9EEWGE7SDkO/
   ld9Gj2L3dKfrhrZKmOS6VLiTyTTd5bmzaRW1lkh5l6NDqqkDOoFnV8Wmv
   rMsIXe7ZdP0DMxT57pEVOcNTNwZIHBfcys1Yg/LlaGW0NK2gHCSOKK+yv
   wpqjnooMtyj6U5uGBSFpgnX8p8oWMsdXpd4BgZHg/uIbsA89NvR4WyHvY
   yoMENdwJJWxOgQ37niwK2+ufROFF7FyIVc0Xa0wsEm6GxwIgDafPTWmou
   AAivp+eI5csOvtmR1Kck+zm01AvDpeEPqHjo7Y34idA9+OZQvkgKQkgsU
   Q==;
X-CSE-ConnectionGUID: nKamjWp0TsSrbZiAb4b2ug==
X-CSE-MsgGUID: d9/PUM0cT8W+SQR/n9AxSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="31643892"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="31643892"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 08:55:33 -0700
X-CSE-ConnectionGUID: Jv5HjXJQQhWF/3nfbbrS5g==
X-CSE-MsgGUID: eyumMmWaTfymXh2k4oWDtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="81222337"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 08:55:29 -0700
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
Subject: [PATCH 04/10] x86/mce/threshold: Remove the redundant this_cpu_dec_return()
Date: Thu, 10 Oct 2024 23:31:56 +0800
Message-Id: <20241010153202.30876-5-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
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

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
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


