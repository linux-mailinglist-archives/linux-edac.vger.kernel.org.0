Return-Path: <linux-edac+bounces-4723-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 881C5B412C4
	for <lists+linux-edac@lfdr.de>; Wed,  3 Sep 2025 05:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C8C44822CA
	for <lists+linux-edac@lfdr.de>; Wed,  3 Sep 2025 03:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFC828504C;
	Wed,  3 Sep 2025 03:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ayIE3N5I"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA8F23AB8B;
	Wed,  3 Sep 2025 03:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756868920; cv=none; b=C61rbCz+3KoBof34a/ConebuC1BjBsJTaX/6ERevV28EAL3nXq4h3utpS0DCEaZ6uPnox82wjThvifhGGDlHpFm21XZCCF15coFR8o2yxPAxSiEVaxaGdecq0UaOArHcuPyVeKwI591wjYO+eA+G2mEzwmUmY+ACwmMCTMUJtQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756868920; c=relaxed/simple;
	bh=vt5M+cidhIHn+kml5yAKrul6jcusXVWb93phHyc4cyk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oLfoFi8173TgGE3pXnrcDihXmejuXbxsBRi5E370G2LTiTeaLyZidRu5J9UwA8FcvycizcK4TPfjD5HjInhKCvEYE1v82Z6Qo5Jvr67TyUheUtb7iT0geIDGUAI4KnWtLxJfpBg8hMA1jih7pHt75xqcfq4FGxTOLJ/btY2Pa1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ayIE3N5I; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756868919; x=1788404919;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vt5M+cidhIHn+kml5yAKrul6jcusXVWb93phHyc4cyk=;
  b=ayIE3N5Io5jc8wXnrf8J4GkS+3ZYRfRKzNEbknznsuhQsRCOI/vHNkIu
   Jks7+S6JH882s9GNN06OU9rgvn/wSdutwLeGS2KK4QA3fFmz1xXK7hR/N
   CloCVQoYT76rYk+MhtZNaI+n5yG5L3F0u11yY1U/FY8k3UX6Vl3bWnVQx
   5rmoQQEcjJREwg1d8QTQxF3h7rM5++dAyAD/nOaUs3tPNiQ3LTV3WMHOX
   eA7KRiK8pjdJALAPjR/3hpJXqLUg9EXcbJfSOWWFJJRgyUYYjmSBTVjgm
   sXLbYH0KuQuP3xE54pF/6tPJQ6xGhC0VxABxkaWqIqpuAbWRi5AB49um0
   A==;
X-CSE-ConnectionGUID: CPRKAFwCSvmDK/CAR2p4Zg==
X-CSE-MsgGUID: KMT9wc40SgOQLkzKcHQcLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="76771968"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="76771968"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 20:08:38 -0700
X-CSE-ConnectionGUID: AfuYw/OFQfmiyo2AQs4wjg==
X-CSE-MsgGUID: XHtbXvsJSvKAVuWx5dV+gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="195101152"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 20:08:36 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Lai Yi <yi1.lai@linux.intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] EDAC/skx_common: Use topology_physical_package_id() instead of open coding
Date: Wed,  3 Sep 2025 11:06:48 +0800
Message-ID: <20250903030648.3285935-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use topology_physical_package_id() to get the CPU package ID instead of
open coding.

Suggested-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/skx_common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 39c733dbc5b9..6e92f2ff5c24 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -14,6 +14,7 @@
  * Copyright (c) 2018, Intel Corporation.
  */
 
+#include <linux/topology.h>
 #include <linux/acpi.h>
 #include <linux/dmi.h>
 #include <linux/adxl.h>
@@ -265,7 +266,7 @@ static int skx_get_pkg_id(struct skx_dev *d, u8 *id)
 			struct cpuinfo_x86 *c = &cpu_data(cpu);
 
 			if (c->initialized && cpu_to_node(cpu) == node) {
-				*id = c->topo.pkg_id;
+				*id = topology_physical_package_id(cpu);
 				return 0;
 			}
 		}

base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
-- 
2.43.0


