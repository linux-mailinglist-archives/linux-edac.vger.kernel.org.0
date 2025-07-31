Return-Path: <linux-edac+bounces-4485-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC80BB17396
	for <lists+linux-edac@lfdr.de>; Thu, 31 Jul 2025 16:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 816477A0301
	for <lists+linux-edac@lfdr.de>; Thu, 31 Jul 2025 14:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10DF1D5CE8;
	Thu, 31 Jul 2025 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FGIHw0my"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3731CF5C0;
	Thu, 31 Jul 2025 14:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753973909; cv=none; b=a0f3VXKubrgIFN4Tq+ZojTUGYbMLzCHsVHh9U5dQTFWqP3aT+FmduGCAzMHBxBdUcuYdTLXoVfjXFcHhV7aSC4+deA8l5WKyZcEY4An1bNUW/qed0yjrHb8hNfaO5uRlus5NuXy5v1Ev5pLTC3mI2NNUd2xT56Kj8OmE91sEQDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753973909; c=relaxed/simple;
	bh=6DVFCE09TQcKFTBk76h9iCXAZesWmZ9XWwRWAqxW2OU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pIkWqYuO5uzRxvmfEVhHUVmXsEzOOHZRxTcLN1nOM2E6LHKEDO/NHWDwQf4pyRzkD4xc/JkQhIxCbZO4chK0x6MIUXpdo4p7uX9X4OqCCJYdsUwnLSxi7G1ogNagOUMFSI1//cGGgwXlgRhMQdnGyWfTf7hkEa2trjtWccPlkh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FGIHw0my; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753973908; x=1785509908;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6DVFCE09TQcKFTBk76h9iCXAZesWmZ9XWwRWAqxW2OU=;
  b=FGIHw0myeUmNLumaLlt5+o88Rs9ifSg06qn2+5s1PcFWhhfKgMgm8hJy
   S7KkcbBJZ0DG6NdERuMDnANJMXrSEaqVeFHA7zwLFoHla+MjMpjCsb5VA
   Co8jwpQRX5jQOE0CymcQ6qNe1YWrttnZkoZDOudIt4/8EVvR2e2ZZ+qvM
   fnY6dC9Hloz1p5mbk29U/zaVdtGzwEcNItmuw2KTqI33EeuVJ/dXJ2QS8
   Uxl+GNQjLC6U0ZgZ9521oB5ugpYoOCfEq+YJaE7i2zkqS+k0fFf9YD9+U
   ie6XrpgBm9DBa5va57ujBkW1By1Scy8gAToDvf6Q6RyQoovqoN62AnmXB
   Q==;
X-CSE-ConnectionGUID: P0TmDlwiQ4e8om1hcxcCfw==
X-CSE-MsgGUID: rLQ4Uos1QtuJ0m8qSJ6Low==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="56231877"
X-IronPort-AV: E=Sophos;i="6.17,353,1747724400"; 
   d="scan'208";a="56231877"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 07:58:27 -0700
X-CSE-ConnectionGUID: MSuvZCpXRYiSbVxi2clMsQ==
X-CSE-MsgGUID: RoPT7rLSTYWJM8kIFKe+MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,353,1747724400"; 
   d="scan'208";a="163633571"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 07:58:24 -0700
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
Subject: [PATCH 6/7] EDAC/i10nm: Reallocate skx_dev list if preconfigured cnt != runtime cnt
Date: Thu, 31 Jul 2025 22:55:33 +0800
Message-ID: <20250731145534.2759334-7-qiuxu.zhuo@intel.com>
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

Ideally, read the present DDR memory controller count first and then
allocate the skx_dev list using this count. However, this approach
requires adding a significant amount of code similar to
skx_get_all_bus_mappings() to obtain the PCI bus mappings for the first
socket and use these mappings along with the related PCI register offset
to read the memory controller count.

Given that the Granite Rapids CPU is the only one that can detect the
count of memory controllers at runtime (other CPUs use the count in the
configuration data), to reduce code complexity, reallocate the skx_dev
list only if the preconfigured count of DDR memory controllers differs
from the count read at runtime for Granite Rapids CPU.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/i10nm_base.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index a3fca2567752..d0218df66a34 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -467,17 +467,18 @@ static int i10nm_get_imc_num(struct res_config *cfg)
 			return -ENODEV;
 		}
 
-		if (imc_num > I10NM_NUM_DDR_IMC) {
-			i10nm_printk(KERN_ERR, "Need to make I10NM_NUM_DDR_IMC >= %d\n", imc_num);
-			return -EINVAL;
-		}
-
 		if (cfg->ddr_imc_num != imc_num) {
 			/*
-			 * Store the number of present DDR memory controllers.
+			 * Update the configuration data to reflect the number of
+			 * present DDR memory controllers.
 			 */
 			cfg->ddr_imc_num = imc_num;
 			edac_dbg(2, "Set DDR MC number: %d", imc_num);
+
+			/* Release and reallocate skx_dev list with the updated number. */
+			skx_remove();
+			if (skx_get_all_bus_mappings(cfg, &i10nm_edac_list) <= 0)
+				return -ENODEV;
 		}
 
 		return 0;
-- 
2.43.0


