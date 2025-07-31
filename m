Return-Path: <linux-edac+bounces-4486-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE520B17397
	for <lists+linux-edac@lfdr.de>; Thu, 31 Jul 2025 16:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FE34565901
	for <lists+linux-edac@lfdr.de>; Thu, 31 Jul 2025 14:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B04202F8B;
	Thu, 31 Jul 2025 14:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FmO022tU"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661A31DD543;
	Thu, 31 Jul 2025 14:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753973913; cv=none; b=NhoEhbcVe4AaUOb6L0GCDzFzqP5aS22kairzLg7rUN84AqI7eHgt8YxL7V1n1pHNt//r0IU/lbtaUr/dgj0IVIe1SWSsFtqQVXV/iblmWqOuwGjaZYuDhKKeLKZ3P5jyjLCdr7MqSa4KA+OfGjUp9xzmcSxUrixMkoNaN+2cfVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753973913; c=relaxed/simple;
	bh=nqx9yQrbzlyUy8pgUZ438nvDoogRwJuQY/PaaUd8hYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I/+igQaBlO1A3Gg9YeMgF9AOMEdM7/o5LS4CppxmQpHUYWIWmxxW2mqYgmezRaeswU6VwKTD8mOgUKlfno6j27kJkVyUnCxBXX8EU851rdPepk06e+94yteN4TC9DOhyFwwG2Y5FlS+C+D6Hl8bmPrtIZeIqT1nWBEP4vc0qQaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FmO022tU; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753973912; x=1785509912;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nqx9yQrbzlyUy8pgUZ438nvDoogRwJuQY/PaaUd8hYo=;
  b=FmO022tUpibCUUdCXUxpsKWhfiNzEAZraQ9T5w2gSD2kJvUAdbOqSGJx
   ZmbMa1COv+XXqf7tcDstCQ1DyE9HSINKfRbxaA2c7BRtPeFKcMUBrzCuZ
   Z90QyvkIhY8vmHRPXNWFfd/GoVWx3fGBrkApBERuu/4XNexF6EMfmzcMQ
   Q1SBdikIO2+JuhIptxAXPpJHU2G38uTuNgEujq/r2MheFCcJLlMBBwTCZ
   dvEUkn04w0cLQQ09foTqcmMX4JyjIxTIzcrO1EI9X7a677BfcgdNAXeuI
   bDkeywuwVyV8g8g7I4+rIfTEtwR1o9ewh+WkFTW/wycan3j3Y2m/XZCh3
   Q==;
X-CSE-ConnectionGUID: RbHd191jQweRpbsIBQuXNQ==
X-CSE-MsgGUID: 24IMnCVGRb6QboyxdCbn8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="56231893"
X-IronPort-AV: E=Sophos;i="6.17,353,1747724400"; 
   d="scan'208";a="56231893"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 07:58:32 -0700
X-CSE-ConnectionGUID: 4+D2s0aoSYKl3xpn6jCNcw==
X-CSE-MsgGUID: kK1k6PcKTSi7sFWK7Gztzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,353,1747724400"; 
   d="scan'208";a="163633606"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 07:58:30 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Lai Yi <yi1.lai@linux.intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] EDAC/skx_common: Remove unused *NUM*_IMC macros
Date: Thu, 31 Jul 2025 22:55:34 +0800
Message-ID: <20250731145534.2759334-8-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250731145534.2759334-1-qiuxu.zhuo@intel.com>
References: <20250731145534.2759334-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are no references to the *NUM*_IMC macros, so remove them.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/skx_common.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index e7038fd45d06..73ba89786cdf 100644
--- a/drivers/edac/skx_common.h
+++ b/drivers/edac/skx_common.h
@@ -29,23 +29,18 @@
 #define GET_BITFIELD(v, lo, hi) \
 	(((v) & GENMASK_ULL((hi), (lo))) >> (lo))
 
-#define SKX_NUM_IMC		2	/* Memory controllers per socket */
 #define SKX_NUM_CHANNELS	3	/* Channels per memory controller */
 #define SKX_NUM_DIMMS		2	/* Max DIMMS per channel */
 
-#define I10NM_NUM_DDR_IMC	12
 #define I10NM_NUM_DDR_CHANNELS	2
 #define I10NM_NUM_DDR_DIMMS	2
 
-#define I10NM_NUM_HBM_IMC	16
 #define I10NM_NUM_HBM_CHANNELS	2
 #define I10NM_NUM_HBM_DIMMS	1
 
-#define I10NM_NUM_IMC		(I10NM_NUM_DDR_IMC + I10NM_NUM_HBM_IMC)
 #define I10NM_NUM_CHANNELS	MAX(I10NM_NUM_DDR_CHANNELS, I10NM_NUM_HBM_CHANNELS)
 #define I10NM_NUM_DIMMS		MAX(I10NM_NUM_DDR_DIMMS, I10NM_NUM_HBM_DIMMS)
 
-#define NUM_IMC		MAX(SKX_NUM_IMC, I10NM_NUM_IMC)
 #define NUM_CHANNELS	MAX(SKX_NUM_CHANNELS, I10NM_NUM_CHANNELS)
 #define NUM_DIMMS	MAX(SKX_NUM_DIMMS, I10NM_NUM_DIMMS)
 
-- 
2.43.0


