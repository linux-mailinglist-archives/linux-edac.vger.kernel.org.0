Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFAE4C06A
	for <lists+linux-edac@lfdr.de>; Wed, 19 Jun 2019 20:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfFSSAS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 19 Jun 2019 14:00:18 -0400
Received: from mga14.intel.com ([192.55.52.115]:26075 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbfFSSAS (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 19 Jun 2019 14:00:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2019 11:00:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,393,1557212400"; 
   d="scan'208";a="162114886"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by fmsmga007.fm.intel.com with ESMTP; 19 Jun 2019 11:00:18 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Tony Luck <tony.luck@intel.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org
Subject: [PATCH] EDAC, i10nm: Add Intel additional Ice-Lake support
Date:   Wed, 19 Jun 2019 11:00:17 -0700
Message-Id: <20190619180017.30410-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Two new CPU models share the same memory controller
architecture with Jacobsville/Tremont, so can use the
same i10nm EDAC driver.

Add ICX and ICX-D CPU model numbers for EDAC support.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/edac/i10nm_base.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index 6f06aec4877c..48c6cecc9683 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -124,6 +124,8 @@ static int i10nm_get_all_munits(void)
 
 static const struct x86_cpu_id i10nm_cpuids[] = {
 	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ATOM_TREMONT_X, 0, 0 },
+	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ICELAKE_X, 0, 0 },
+	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ICELAKE_XEON_D, 0, 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(x86cpu, i10nm_cpuids);
-- 
2.20.1

