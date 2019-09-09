Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 472E6AD6F6
	for <lists+linux-edac@lfdr.de>; Mon,  9 Sep 2019 12:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbfIIKgf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Mon, 9 Sep 2019 06:36:35 -0400
Received: from ZXSHCAS2.zhaoxin.com ([203.148.12.82]:59195 "EHLO
        ZXSHCAS2.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728945AbfIIKgc (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 9 Sep 2019 06:36:32 -0400
Received: from zxbjmbx3.zhaoxin.com (10.29.252.165) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Mon, 9 Sep
 2019 18:21:15 +0800
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by zxbjmbx3.zhaoxin.com
 (10.29.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Mon, 9 Sep
 2019 18:21:14 +0800
Received: from zxbjmbx1.zhaoxin.com ([fe80::b41a:737:a784:b70d]) by
 zxbjmbx1.zhaoxin.com ([fe80::b41a:737:a784:b70d%16]) with mapi id
 15.01.1261.035; Mon, 9 Sep 2019 18:21:14 +0800
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To:     "tony.luck@intel.com" <tony.luck@intel.com>,
        "Borislav Petkov (bp@alien8.de)" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "qiuxu.zhuo@intel.com" <qiuxu.zhuo@intel.com>
CC:     David Wang <DavidWang@zhaoxin.com>,
        "Cooper Yan(BJ-RD)" <CooperYan@zhaoxin.com>,
        "Qiyuan Wang(BJ-RD)" <QiyuanWang@zhaoxin.com>,
        "Herry Yang(BJ-RD)" <HerryYang@zhaoxin.com>
Subject: [PATCH v1 2/4] x86/mce: Make 4 functions non-static
Thread-Topic: [PATCH v1 2/4] x86/mce: Make 4 functions non-static
Thread-Index: AdVm9wPzkra93/0kREu4L4PJi6UVog==
Date:   Mon, 9 Sep 2019 10:21:14 +0000
Message-ID: <54f39a2e51be4ae6bed875d1fa38e0be@zhaoxin.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.32.64.75]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

These functions are declared static and cannot be used in others
.c source file. this commit removes the static attribute and adds
the declaration to the header for these functions.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 arch/x86/kernel/cpu/mce/intel.c    | 8 ++++----
 arch/x86/kernel/cpu/mce/internal.h | 8 ++++++++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index 88cd959..eee4b12 100644
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
 
@@ -467,7 +467,7 @@ static void intel_clear_lmce(void)
 	wrmsrl(MSR_IA32_MCG_EXT_CTL, val);
 }
 
-static void intel_ppin_init(struct cpuinfo_x86 *c)
+void intel_ppin_init(struct cpuinfo_x86 *c)
 {
 	unsigned long long val;
 
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 43031db..55d1f0a 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -45,11 +45,19 @@ unsigned long cmci_intel_adjust_timer(unsigned long interval);
 bool mce_intel_cmci_poll(void);
 void mce_intel_hcpu_update(unsigned long cpu);
 void cmci_disable_bank(int bank);
+void intel_init_cmci(void);
+void intel_init_lmce(void);
+void intel_clear_lmce(void);
+void intel_ppin_init(struct cpuinfo_x86 *c);
 #else
 # define cmci_intel_adjust_timer mce_adjust_timer_default
 static inline bool mce_intel_cmci_poll(void) { return false; }
 static inline void mce_intel_hcpu_update(unsigned long cpu) { }
 static inline void cmci_disable_bank(int bank) { }
+static inline void intel_init_cmci(void) { }
+static inline void intel_init_lmce(void) { }
+static inline void intel_clear_lmce(void) { }
+static inline void intel_ppin_init(struct cpuinfo_x86 *c) { }
 #endif
 
 void mce_timer_kick(unsigned long interval);
-- 
2.7.4
