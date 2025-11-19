Return-Path: <linux-edac+bounces-5475-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F56EC6F194
	for <lists+linux-edac@lfdr.de>; Wed, 19 Nov 2025 15:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 5A28D306AD
	for <lists+linux-edac@lfdr.de>; Wed, 19 Nov 2025 13:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D19364048;
	Wed, 19 Nov 2025 13:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KfNBWPE5"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED963364026;
	Wed, 19 Nov 2025 13:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763560394; cv=none; b=r7NtpggnLZepfFh+ZoyDKuz5pUiogCGGqQr9P8RwqqPViGoZ68mAaw2lffWxodn46gAVCF12XrwtbTYpKmkNIx3rfOGlE/AzVM8nH9G3FfXsH0CZ1CNaX1PZ8gIUta/UC8/G+ASz4mDiRxDieL/2LGmkrKNh1imOWpEbazYbqY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763560394; c=relaxed/simple;
	bh=qyqLGbeqaYZi7TaAIvn7Ded65sgt4kEGWxVlLaVggn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BnB3VB/qVWOicXKqt/28SeJj/YEit4hoLq9cFg0YwWtH4pzRC7rVeFSt9qHBhWnlZUA2RxajeiFleT4kDufxV1HnLCZj37Plfas593JK3lQ2eGzuqQO8eY9ZNVec8l61eXwfrTB3R6b2QSELhIukmz7E8dgvXcRxB3jhsqOBPmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KfNBWPE5; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763560393; x=1795096393;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qyqLGbeqaYZi7TaAIvn7Ded65sgt4kEGWxVlLaVggn8=;
  b=KfNBWPE5kTYdSL/V6Hf+GwCrfqaSi1YUUmXQYVM9sGAHxC5si/n+UKIb
   vXupmQKwDA/dmhE+Sf48i709pBaRZt7BhDzrohNrYa+BiQC2VR7j2+ulH
   ebtGAHqhtNIM2haLcSZtZO4+6b7xhe0BNelVGVN284ichdZeCkXBdhN1N
   WeWsmEXG0Xoi6jfjfK4bjCFbe/H4TANoMv8c06Jq7tr4Itl2qO3nI1kp8
   m6R1Iu0C+h3AMXpGzUzp/bytVPUnfJ4g9g8uQNbTiHnwxGgl1vFYUtFYg
   S6VvhS+My7/6pMxrHy8i9RlhXUW4NNuG4Q4jqSnsO7SYfwUNH4X2aAqkv
   w==;
X-CSE-ConnectionGUID: tKSZ5VLGRwWWV0VMyj00Tw==
X-CSE-MsgGUID: BKF1l2rmQ2ymmzfplAM9Ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="64607471"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="64607471"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 05:53:13 -0800
X-CSE-ConnectionGUID: YvhKlCICT0Os90jV4hDiNw==
X-CSE-MsgGUID: PgOugZ3nQ6+QTD37wWO5LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="214439720"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 05:53:11 -0800
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Yi Lai <yi1.lai@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] EDAC/imh: Setup 'imh_test' debugfs testing node
Date: Wed, 19 Nov 2025 21:41:31 +0800
Message-ID: <20251119134132.2389472-8-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251119134132.2389472-1-qiuxu.zhuo@intel.com>
References: <20251119134132.2389472-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Setup the following debugfs testing node to enable fake memory error
address decoding tests for the imh_edac driver.

  /sys/kernel/debug/edac/imh_test/addr

Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/imh_base.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/edac/imh_base.c b/drivers/edac/imh_base.c
index 5f0313c1ac2e..91969f55cbb0 100644
--- a/drivers/edac/imh_base.c
+++ b/drivers/edac/imh_base.c
@@ -574,6 +574,7 @@ static int __init imh_init(void)
 
 	opstate_init();
 	mce_register_decode_chain(&imh_mce_dec);
+	skx_setup_debug("imh_test");
 
 	imh_printk(KERN_INFO, "%s\n", IMH_REVISION);
 
@@ -587,6 +588,7 @@ static void __exit imh_exit(void)
 {
 	edac_dbg(2, "\n");
 
+	skx_teardown_debug();
 	mce_unregister_decode_chain(&imh_mce_dec);
 	skx_adxl_put();
 	skx_remove();
-- 
2.43.0


