Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C375B10CB55
	for <lists+linux-edac@lfdr.de>; Thu, 28 Nov 2019 16:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfK1PI1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Nov 2019 10:08:27 -0500
Received: from mga12.intel.com ([192.55.52.136]:38479 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbfK1PI1 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 28 Nov 2019 10:08:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2019 07:08:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,253,1571727600"; 
   d="scan'208";a="199549832"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by orsmga007.jf.intel.com with ESMTP; 28 Nov 2019 07:08:26 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     linux@dominikbrodowski.net, tony.luck@intel.com, bp@alien8.de,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] x86/mce/therm_throt: Avoid updating RO and reserved bits
Date:   Thu, 28 Nov 2019 07:08:24 -0800
Message-Id: <20191128150824.22413-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

While writing to MSR IA32_THERM_STATUS/IA32_PKG_THERM_STATUS, avoid
writing 1 to read only and reserved fields. Updating some fields
generates exception.

Fixes: f6656208f04e ("x86/mce/therm_throt: Optimize notifications of thermal throttle")
Reported-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 arch/x86/kernel/cpu/mce/therm_throt.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/therm_throt.c b/arch/x86/kernel/cpu/mce/therm_throt.c
index d01e0da0163a..80be4a5ac303 100644
--- a/arch/x86/kernel/cpu/mce/therm_throt.c
+++ b/arch/x86/kernel/cpu/mce/therm_throt.c
@@ -195,17 +195,24 @@ static const struct attribute_group thermal_attr_group = {
 #define THERM_THROT_POLL_INTERVAL	HZ
 #define THERM_STATUS_PROCHOT_LOG	BIT(1)
 
+#define THERM_STATUS_CLEAR_CORE_MASK (BIT(1) | BIT(3) | BIT(5) | BIT(7) | BIT(9) | BIT(11) | BIT(13) | BIT(15))
+#define THERM_STATUS_CLEAR_PKG_MASK (BIT(1) | BIT(3) | BIT(5) | BIT(7) | BIT(9) | BIT(11))
+
 static void clear_therm_status_log(int level)
 {
 	int msr;
-	u64 msr_val;
+	u64 mask, msr_val;
 
-	if (level == CORE_LEVEL)
+	if (level == CORE_LEVEL) {
 		msr = MSR_IA32_THERM_STATUS;
-	else
+		mask = THERM_STATUS_CLEAR_CORE_MASK;
+	} else {
 		msr = MSR_IA32_PACKAGE_THERM_STATUS;
+		mask = THERM_STATUS_CLEAR_PKG_MASK;
+	}
 
 	rdmsrl(msr, msr_val);
+	msr_val &= mask;
 	wrmsrl(msr, msr_val & ~THERM_STATUS_PROCHOT_LOG);
 }
 
-- 
2.17.2

