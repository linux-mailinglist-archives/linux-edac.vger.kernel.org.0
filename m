Return-Path: <linux-edac+bounces-3573-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C051EA920DB
	for <lists+linux-edac@lfdr.de>; Thu, 17 Apr 2025 17:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D09674612AE
	for <lists+linux-edac@lfdr.de>; Thu, 17 Apr 2025 15:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6CF2528EE;
	Thu, 17 Apr 2025 15:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E4gSIo5U"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416DF252295;
	Thu, 17 Apr 2025 15:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744902512; cv=none; b=d33SaC5hi+eucivOa5VadJHqpJiEvQy1fxY/VncAdXNposKbLAnV6QzyYayqPt40YHDHd9FhcsCl5RYtfUrDk8//IUYdqDGp1LGwbZqqAwJr7Asuk6PRgfAdIVCOeMVgZyhDJYbaSJAFB+T22tdmBT8SU8VUD5vyD8HPRHjFGRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744902512; c=relaxed/simple;
	bh=ZJU9Vo1Ne1O0YCcJPFEiDSp1S98lJcq/9w6ikMg0SRY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qaeY7Ow6phnK99wNkyHeiPXyijBPGzjVaBBBkSfS8eNG8VXnPB9CdQPyumxBjrhGLPHKgF5WIltGscnV1JDeLgWI1EOwSWiNMHep1GvmSjee6aPNxnGr8tI/rIDROkZOdZAGK7kkKdXXoMomhhBzwyVl5gYSLyTTyYLPxGLm3v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E4gSIo5U; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744902510; x=1776438510;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZJU9Vo1Ne1O0YCcJPFEiDSp1S98lJcq/9w6ikMg0SRY=;
  b=E4gSIo5UeKgXHxxYRJc0QAT5LqNdqc3zkjjhEzm6rEhsHJSCdm61LoBJ
   5575cDbfe5SkXh4DmNNCGcktu9b0ascB75ziLf4XNdiSG6TeEImAJ3KrY
   vHWKj4v5QGBCmYB1yAklnd2WwdNT2rdNNVvPPL2b+1X+DpPzq4UYLETw4
   DSkJqV6ZJwJYCgH3YYTC8PYWFVmSiWzw8NNatXVj8jXLxsuTWm0R2xIk5
   uSOf6QUq1Q6CWHRh+ftR8NO+el+R7e1T8MBpIZGQlor0mGbvqHyhvC+vQ
   WpN1c63CbiZ2W/PNXYckcIqCjIGIU7LV2/otPSVjx6WJ/zlyK9uiXCE+x
   g==;
X-CSE-ConnectionGUID: sSGkyNM6RRihn1uX9ys4XA==
X-CSE-MsgGUID: W24pCZmXSYi3uCSSeB0eEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="57488594"
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="57488594"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 08:08:27 -0700
X-CSE-ConnectionGUID: XuFoQVNpQYuYiTTSTrrQAw==
X-CSE-MsgGUID: Szll+fIyTfuWl+IfRV+v7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="161876708"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 08:08:25 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Yi Lai <yi1.lai@intel.com>,
	Feng Xu <feng.f.xu@intel.com>,
	Shawn Fan <shawn.fan@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] EDAC/i10nm: Add RRL support for Intel Granite Rapids server
Date: Thu, 17 Apr 2025 23:07:17 +0800
Message-ID: <20250417150724.1170168-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RRL (Retry Read error Log) registers provide additional error information
during DDR memory correction. This can assist memory DIMM vendors in isolating
problematic cells within the DIMM and help CSPs predict uncorrectable errors.
This patch series is to add RRL support for Intel Granite Rapids servers and
is structured as follows:

Patch 1-3: Bug fixes and cleanup.

Patch 4-6: Refactor the RRL (Retry Read error Log) code of previous generations
           and prepare for Patch 7.

Patch 7  : Add RRL support for Intel Granite Rapids server.

Qiuxu Zhuo (7):
  EDAC/skx_common: Fix general protection fault
  EDAC/{skx_common,i10nm}: Fix the loss of saved RRL for HBM pseudo channel 0
  EDAC/i10nm: Explicitly set the modes of the RRL register sets
  EDAC/{skx_common,i10nm}: Structure the per-channel RRL registers
  EDAC/{skx_common,i10nm}: Refactor enable_retry_rd_err_log()
  EDAC/{skx_common,i10nm}: Refactor show_retry_rd_err_log()
  EDAC/{skx_common,i10nm}: Add RRL support for Intel Granite Rapids server

 drivers/edac/i10nm_base.c | 477 ++++++++++++++++++++++----------------
 drivers/edac/skx_common.c |   1 +
 drivers/edac/skx_common.h |  61 ++++-
 3 files changed, 330 insertions(+), 209 deletions(-)


base-commit: 8ffd015db85fea3e15a77027fda6c02ced4d2444
-- 
2.43.0


