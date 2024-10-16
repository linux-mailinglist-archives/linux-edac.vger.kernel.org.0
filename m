Return-Path: <linux-edac+bounces-2100-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CDF9A0ACC
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 14:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8350E281725
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 12:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A718B209677;
	Wed, 16 Oct 2024 12:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SW6sEFRx"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167D3208972;
	Wed, 16 Oct 2024 12:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729083253; cv=none; b=Ceha0g+AqOTX7NM67PRoQOphVQb+btC7GS3KiNlo3Rr5gElzOmF1Z6oxJG6ZJa3UWnmJz6C2adJQkP8RjbW17aB8AqAHnM6gKicrxcai1ZL1cvwWkPFNUlRyQ0igGLEtJc/YN5/zH9hvz+bV+zbpMA4WcsTDVytFis+yNEqpuyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729083253; c=relaxed/simple;
	bh=sqtaSqXECldmbQXgoQpmNNoPMlSVJcxlT9DyUld/VCY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Pv+aVNjtIFozXCGTHjcoyD2I2meqfNB+a38BQmEFXHooH5SFCm4+Kon0T9b/YL301EoK4aH1CypbqVLNdHsYtg29FTMqawGFgO+wxSSZxIqtZEo7s10aUXbU0s5rBqyN6q6YLYImBpvrwIaNBk3lgmvQNyFP2oDQ46aCX0V/Ib0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SW6sEFRx; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729083253; x=1760619253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=sqtaSqXECldmbQXgoQpmNNoPMlSVJcxlT9DyUld/VCY=;
  b=SW6sEFRxytxCd2bbVjvDZSScziRiRvuXNBv1/wlKqe4Ee4JwmTd+jjcN
   jKS6Jc2Dqtj8GuHKPvHl+cST7DZbUWybkK2cnDhyHUgmAFowtYCeMmtaa
   K28V2eCqBborIvx3OKVkf5xXZFnEW6X/ba843QzE3VVKj6cVQvGE3O3qG
   71cVobR1pALpAwvQCFtmFdhUabCoPnWF5GzBD9u+PdSbwVTXLemP1Woa7
   cygBoAVdPUhWxUqbDiQ9LV1loC5io+O8n+bZ/dU3K+863mYKGt0fOxDaX
   Q1n++ToNq5kLZEZm3cAp0gGJvXoZ/8WEu008xCRPHs6W5ArBIVjiwsLD/
   A==;
X-CSE-ConnectionGUID: 1FUKrM66Q0KTMmUVl92/Zg==
X-CSE-MsgGUID: kKPKewyoTXyOY7p4nElHNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="32217507"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="32217507"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 05:54:12 -0700
X-CSE-ConnectionGUID: z7He18iMS02ZPMB8kTHUNQ==
X-CSE-MsgGUID: Tz0IwFCGQa2QONFSeTUyaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="82761701"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 05:54:09 -0700
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
Subject: [PATCH v2 04/10] x86/mce/threshold: Remove the redundant this_cpu_dec_return()
Date: Wed, 16 Oct 2024 20:30:30 +0800
Message-Id: <20241016123036.21366-5-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241016123036.21366-1-qiuxu.zhuo@intel.com>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-1-qiuxu.zhuo@intel.com>
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


