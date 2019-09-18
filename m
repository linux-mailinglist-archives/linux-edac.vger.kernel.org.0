Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54911B5BC7
	for <lists+linux-edac@lfdr.de>; Wed, 18 Sep 2019 08:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfIRGTo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 18 Sep 2019 02:19:44 -0400
Received: from ZXSHCAS2.zhaoxin.com ([203.148.12.82]:39983 "EHLO
        ZXSHCAS2.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727131AbfIRGTo (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 18 Sep 2019 02:19:44 -0400
Received: from zxbjmbx2.zhaoxin.com (10.29.252.164) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Wed, 18 Sep
 2019 14:19:41 +0800
Received: from tony-HX002EA.zhaoxin.com (10.32.64.46) by zxbjmbx2.zhaoxin.com
 (10.29.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Wed, 18 Sep
 2019 14:19:39 +0800
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To:     <tony.luck@intel.com>, <bp@alien8.de>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <hpa@zytor.com>, <x86@kernel.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yazen.ghannam@amd.com>, <vishal.l.verma@intel.com>,
        <qiuxu.zhuo@intel.com>
CC:     <DavidWang@zhaoxin.com>, <CooperYan@zhaoxin.com>,
        <QiyuanWang@zhaoxin.com>, <HerryYang@zhaoxin.com>
Subject: [PATCH v4 2/4] x86/mce: Make 3 functions non-static
Date:   Wed, 18 Sep 2019 14:19:31 +0800
Message-ID: <1568787573-1297-3-git-send-email-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568787573-1297-2-git-send-email-TonyWWang-oc@zhaoxin.com>
References: <1568787573-1297-1-git-send-email-TonyWWang-oc@zhaoxin.com>
 <1568787573-1297-2-git-send-email-TonyWWang-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.32.64.46]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx2.zhaoxin.com (10.29.252.164)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

These functions are declared static and cannot be used in others
.c source file. this commit removes the static attribute and adds
the declaration to the header for these functions.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 arch/x86/kernel/cpu/mce/intel.c    | 6 +++---
 arch/x86/kernel/cpu/mce/internal.h | 6 ++++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index 88cd959..70799a5 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -423,7 +423,7 @@ void cmci_disable_bank(int bank)
 	raw_spin_unlock_irqrestore(&cmci_discover_lock, flags);
 }
 
-static void intel_init_cmci(void)
+void intel_init_cmci(void)
 {
 	int banks;
 
@@ -442,7 +442,7 @@ static void intel_init_cmci(void)
 	cmci_recheck();
 }
 
-static void intel_init_lmce(void)
+void intel_init_lmce(void)
 {
 	u64 val;
 
@@ -455,7 +455,7 @@ static void intel_init_lmce(void)
 		wrmsrl(MSR_IA32_MCG_EXT_CTL, val | MCG_EXT_CTL_LMCE_EN);
 }
 
-static void intel_clear_lmce(void)
+void intel_clear_lmce(void)
 {
 	u64 val;
 
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 43031db..842b273 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -45,11 +45,17 @@ unsigned long cmci_intel_adjust_timer(unsigned long interval);
 bool mce_intel_cmci_poll(void);
 void mce_intel_hcpu_update(unsigned long cpu);
 void cmci_disable_bank(int bank);
+void intel_init_cmci(void);
+void intel_init_lmce(void);
+void intel_clear_lmce(void);
 #else
 # define cmci_intel_adjust_timer mce_adjust_timer_default
 static inline bool mce_intel_cmci_poll(void) { return false; }
 static inline void mce_intel_hcpu_update(unsigned long cpu) { }
 static inline void cmci_disable_bank(int bank) { }
+static inline void intel_init_cmci(void) { }
+static inline void intel_init_lmce(void) { }
+static inline void intel_clear_lmce(void) { }
 #endif
 
 void mce_timer_kick(unsigned long interval);
-- 
2.7.4

