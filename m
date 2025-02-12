Return-Path: <linux-edac+bounces-3034-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4DBA32160
	for <lists+linux-edac@lfdr.de>; Wed, 12 Feb 2025 09:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74BA13A35A7
	for <lists+linux-edac@lfdr.de>; Wed, 12 Feb 2025 08:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88946205AA3;
	Wed, 12 Feb 2025 08:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MmoFFkZO"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8671E9B3B;
	Wed, 12 Feb 2025 08:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739349777; cv=none; b=rXmECmpoqd0JEC1xA0G88+qxkgyiwDLLsWXvhWP7Pm7iMMC8BhEaYbB1GUZskCFOJkjt8fFUWqYdmFZzyEcjaDss7E2OfDyAiZi3PCeoG+Muvj0jKcW5dymmTtwptBCPopAsZkVyG2Jrgl3oBBUgK/AJvbVtVCTMJYnOXHr1GS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739349777; c=relaxed/simple;
	bh=fZ/2cWrlbcdeAC/InzvSZ8DjryDQHpUwgjaOl4okXco=;
	h=From:To:Cc:Subject:Date:Message-Id; b=PWfCK3eMHioSzfBSBjxxzZuAjOyoP35vOcesh0Eh3K2+LAKNIcyWqmxyrouThyXSqRtNdNCQgCUbWvu/JTMTjnl2nF1qwl5QAOs6+cZ2EOy3kKY8tWNbHFCyE3fw/yGzIQOVfp5VOlIuMS5TwiBGlIl4GV+tRnNMEgDGSupKf1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MmoFFkZO; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739349775; x=1770885775;
  h=from:to:cc:subject:date:message-id;
  bh=fZ/2cWrlbcdeAC/InzvSZ8DjryDQHpUwgjaOl4okXco=;
  b=MmoFFkZOd3qaO+Le0kO5v8lLRiXprNv5eLKUtK+IZuhWhHqsdTEr2Q0j
   BQcnoq+EEP3TZwwOzZctoQYNZZhIe5/B6u25xsc6sTYs74cnwKNeiVtkS
   cpSU8gwg4qJG60VLuKAd72d/ae9FLw7ZfF5eO6YBSqLFUkzeHBOVj7tZj
   IVn341n1esC4y0jg2uxz3buf/0XJufohWdz2OAKVMjNAAzBzcjM2pcxf5
   o2tXbwGdymCRV3Rk0Z+vnvrJU1mg38t9q9H7g9MO3scHIyQU/187B9QzD
   AipVaglKFQGHB3TS/1/3VKQa9Sc0jTfTo6mtCEZvcZZZOvdb5Ju/72lH9
   g==;
X-CSE-ConnectionGUID: zz/yQ7yaTSemo6UrM4dvdQ==
X-CSE-MsgGUID: wmVXuMFDRiuB55VmwUaVcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="51425149"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="51425149"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 00:42:55 -0800
X-CSE-ConnectionGUID: lI2/2gr7QW2fM3QIlbhRBw==
X-CSE-MsgGUID: 6ZDyVIk3S7abahNGOdtVMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="136026824"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 00:42:51 -0800
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Ramses <ramses@well-founded.dev>,
	John <therealgraysky@proton.me>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] EDAC/igen6: Fix the flood of invalid error reports
Date: Wed, 12 Feb 2025 16:33:54 +0800
Message-Id: <20250212083354.31919-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

The ECC_ERROR_LOG register of certain SoCs may contain the invalid value
~0, which results in a flood of invalid error reports in polling mode.

Fix the flood of invalid error reports by skipping the invalid ECC error
log value ~0.

Fixes: e14232afa944 ("EDAC/igen6: Add polling support")
Reported-by: Ramses <ramses@well-founded.dev>
Closes: https://lore.kernel.org/all/OISL8Rv--F-9@well-founded.dev/
Tested-by: Ramses <ramses@well-founded.dev>
Reported-by: John <therealgraysky@proton.me>
Closes: https://lore.kernel.org/all/p5YcxOE6M3Ncxpn2-Ia_wCt61EM4LwIiN3LroQvT_-G2jMrFDSOW5k2A9D8UUzD2toGpQBN1eI0sL5dSKnkO8iteZegLoQEj-DwQaMhGx4A=@proton.me/
Tested-by: John <therealgraysky@proton.me>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/igen6_edac.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index fdf3a84fe698..595908af9e5c 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -785,13 +785,22 @@ static u64 ecclog_read_and_clear(struct igen6_imc *imc)
 {
 	u64 ecclog = readq(imc->window + ECC_ERROR_LOG_OFFSET);
 
-	if (ecclog & (ECC_ERROR_LOG_CE | ECC_ERROR_LOG_UE)) {
-		/* Clear CE/UE bits by writing 1s */
-		writeq(ecclog, imc->window + ECC_ERROR_LOG_OFFSET);
-		return ecclog;
-	}
+	/*
+	 * Quirk: The ECC_ERROR_LOG register of certain SoCs may contain
+	 *        the invalid value ~0. This will result in a flood of invalid
+	 *        error reports in polling mode. Skip it.
+	 */
+	if (ecclog == ~0)
+		return 0;
 
-	return 0;
+	/* Neither a CE nor a UE. Skip it.*/
+	if (!(ecclog & (ECC_ERROR_LOG_CE | ECC_ERROR_LOG_UE)))
+		return 0;
+
+	/* Clear CE/UE bits by writing 1s */
+	writeq(ecclog, imc->window + ECC_ERROR_LOG_OFFSET);
+
+	return ecclog;
 }
 
 static void errsts_clear(struct igen6_imc *imc)
-- 
2.17.1


