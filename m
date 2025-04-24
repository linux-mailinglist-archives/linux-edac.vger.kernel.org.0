Return-Path: <linux-edac+bounces-3696-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E23A9A58F
	for <lists+linux-edac@lfdr.de>; Thu, 24 Apr 2025 10:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52BDB462FE5
	for <lists+linux-edac@lfdr.de>; Thu, 24 Apr 2025 08:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6FD1F4622;
	Thu, 24 Apr 2025 08:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ITEZAVZh"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDD219994F;
	Thu, 24 Apr 2025 08:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745482539; cv=none; b=KJSv1SDrwe0LviM8ZCe5OtFa0TO5uJz6aTaYPB2m2BxGTp0OPnit8D45v1eAUyfy6HayeYO+ODzbYjJhDhQa6Rz3ygI83YN2hj0wP6JI67i4ts1tSqlh8HWrjbyGxay9x5CLTKzfGSyjt3pnzEW2o12gXiOAE+CdUBMtxAN7JN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745482539; c=relaxed/simple;
	bh=GAWx67WGM/vCu98zyuNJqXqV08Fjwm1iN7BtJT0noBM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YzFg37jAG+KUSaFaN3TLulrg0E8X2UZny/FU3QQ44Qi9EeKozbQOx+aXZU74+EEaZ5gAptolbjE9ksam46a1e4wcxbIFCpGCHxTAmj8HPEV+Yv+0KLdfAA8YYiAuRF6Ow6V7o7ZbCR7sqdnTzKc//39o6hTqhNCzYsbJdmcFdQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ITEZAVZh; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745482538; x=1777018538;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GAWx67WGM/vCu98zyuNJqXqV08Fjwm1iN7BtJT0noBM=;
  b=ITEZAVZh+I5iTpNtGaj49v385WIbQMNwdMgQcDYTgUgaOpRmzl1lD+dg
   plBTRqZb3syUuwyA3v06+eejjYISmY3Ne3CpOYh1vNENpf3abzy2t9/S/
   n4coHoW+zPpe14w1tPU6QhHTkGAUzpT+L2GMxtx+kp/Pm/KtKH04wYGAg
   o9r6g5g++O7xl9sr5itRxmd0fGHXCRg3ZWToI2XV6OPfixw7NPw4poiDy
   uTew2ozZAk8mtoJhsGvPKwWleaUjfdqIhJvWSTjmvlWwExeJ1unXrYt3r
   R8jmsOCfRqjlFKWGdUKISecroRWZBia+TgyVLUL0L1PTbICJfLSUjER9X
   A==;
X-CSE-ConnectionGUID: YEaohb3wShKQ4IKK9w66Yg==
X-CSE-MsgGUID: BdP1z+5sQ0CbylzN0ntDKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="47013635"
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="47013635"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 01:15:37 -0700
X-CSE-ConnectionGUID: DZV5zNX+RKmJjesJpTyTBg==
X-CSE-MsgGUID: sRLJ2u/QTP2s8sJj0+KA4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="132433286"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 01:15:34 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Borislav Petkov <bp@alien8.de>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Yi Lai <yi1.lai@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] EDAC/i10nm: Fix the bitwise operation between variables of different sizes
Date: Thu, 24 Apr 2025 16:14:54 +0800
Message-ID: <20250424081454.2952632-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tool of Smatch static checker reported the following warning:

  drivers/edac/i10nm_base.c:364 show_retry_rd_err_log()
  warn: should bitwise negate be 'ullong'?

This warning was due to the bitwise NOT/AND operations between
'status_mask' (a u32 type) and 'log' (a u64 type), which resulted in
the high 32 bits of 'log' were cleared.

This was a false positive warning, as only the low 32 bits of 'log' was
written to the first RRL memory controller register (a u32 type).

To improve code sanity, fix this warning by changing 'status_mask' to
a u64 type, ensuring it matches the size of 'log' for bitwise operations.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/aAih0KmEVq7ch6v2@stanley.mountain/
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
This patch is on top of the RAS tree edac-for-next branch [1] with the
top commit [2].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac-for-next
[2] f53deda1a997 ("Merge branch 'edac-drivers' into edac-for-next")

 drivers/edac/i10nm_base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index 8863f1fb4caf..a3fca2567752 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -327,10 +327,10 @@ static void show_retry_rd_err_log(struct decoded_addr *res, char *msg,
 {
 	int i, j, n, ch = res->channel, pch = res->cs & 1;
 	struct skx_imc *imc = &res->dev->imc[res->imc];
-	u32 offset, status_mask;
+	u64 log, corr, status_mask;
 	struct reg_rrl *rrl;
-	u64 log, corr;
 	bool scrub;
+	u32 offset;
 	u8 width;
 
 	if (!imc->mbase)
-- 
2.43.0


