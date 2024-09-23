Return-Path: <linux-edac+bounces-1916-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED18F97E6BD
	for <lists+linux-edac@lfdr.de>; Mon, 23 Sep 2024 09:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C7001C21122
	for <lists+linux-edac@lfdr.de>; Mon, 23 Sep 2024 07:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE95A4EB5E;
	Mon, 23 Sep 2024 07:37:53 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD1B41C77
	for <linux-edac@vger.kernel.org>; Mon, 23 Sep 2024 07:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727077073; cv=none; b=H/5S0EcCLkz0X7qtZwmGRlDH0eX2csZSTmmx9cZ6iWn2q1UtheN4XCgSy68T/wai2qwShdGSdiHRArBo4rmH5I8TP/K89t9S5R0Rz5HkKEIpLTEMEbONbUoLrWxR4CPenvH3HaDbUb/IDFh/92cAW4kX5C1QMLx65xIYMLxNCg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727077073; c=relaxed/simple;
	bh=uSEca6JWjWX9jnpE6/DSLp+NX6IlRbe0St6DrkY4mSc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YjFAhcZ0kkhUaJV4Cn7caS6rJFrT7oaKI3C8sxUj7jTJb1D03m1VsJkOtKZdTb5Ol9EQFViQfei/2xH72ZTr+l1Scyr8IVeYV/R+34JdpjMXlKnEkCQfnS1Aql20UpCIDtj9Ka4gV7GDm0W/llQIEGokIGUvXEfB/wQQ6dmR1y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1727077064-086e236b0500f40001-QCVQLf
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx1.zhaoxin.com with ESMTP id g4wH4ThCyntH2GFK (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 23 Sep 2024 15:37:44 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXSHMBX2.zhaoxin.com (10.28.252.164) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 23 Sep
 2024 15:37:44 +0800
Received: from ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d]) by
 ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d%4]) with mapi id
 15.01.2507.039; Mon, 23 Sep 2024 15:37:44 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from localhost.localdomain (10.32.65.165) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Sep
 2024 15:33:15 +0800
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>
CC: <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>, <LeoLiu-oc@zhaoxin.com>,
	Lyle Li <LyleLi@zhaoxin.com>
Subject: [PATCH v4 4/4] x86/mce: Add CMCI storm switching support for Zhaoxin
Date: Mon, 23 Sep 2024 15:33:11 +0800
X-ASG-Orig-Subj: [PATCH v4 4/4] x86/mce: Add CMCI storm switching support for Zhaoxin
Message-ID: <20240923073311.4290-5-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240923073311.4290-1-TonyWWang-oc@zhaoxin.com>
References: <20240918055436.15551-1-TonyWWang-oc@zhaoxin.com>
 <20240923073311.4290-1-TonyWWang-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Moderation-Data: 9/23/2024 3:37:41 PM
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1727077064
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 4332
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.130843
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

From: Lyle Li <LyleLi@zhaoxin.com>

Zhaoxin CPUs support CMCI compatible with Intel, because
Zhaoxin's UCR error is not reported through CMCI, and in
order to be compatible with intel's CMCI code, so add Zhaoxin
CMCI storm toggle to support the new CMCI storm switching
in mce/intel.c, mce/zhaoxin.c, mce/threshold.c, and mce/internal.h.

Signed-off-by: Lyle Li <LyleLi@zhaoxin.com>
Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 arch/x86/kernel/cpu/mce/intel.c     |  5 ++---
 arch/x86/kernel/cpu/mce/internal.h  |  7 ++++++-
 arch/x86/kernel/cpu/mce/threshold.c |  4 ++++
 arch/x86/kernel/cpu/mce/zhaoxin.c   | 18 ++++++++++++++++++
 4 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/inte=
l.c
index b7e67f4f7..aa75e2848 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -45,7 +45,7 @@ static DEFINE_PER_CPU(mce_banks_t, mce_banks_owned);
  * cmci_discover_lock protects against parallel discovery attempts
  * which could race against each other.
  */
-static DEFINE_RAW_SPINLOCK(cmci_discover_lock);
+DEFINE_RAW_SPINLOCK(cmci_discover_lock);
=20
 /*
  * On systems that do support CMCI but it's disabled, polling for MCEs can
@@ -61,7 +61,7 @@ static DEFINE_SPINLOCK(cmci_poll_lock);
  * MCi_CTL2 threshold for each bank when there is no storm.
  * Default value for each bank may have been set by BIOS.
  */
-static u16 cmci_threshold[MAX_NR_BANKS];
+u16 cmci_threshold[MAX_NR_BANKS];
=20
 /*
  * High threshold to limit CMCI rate during storms. Max supported is
@@ -73,7 +73,6 @@ static u16 cmci_threshold[MAX_NR_BANKS];
  * to corrected errors, so keeping CMCI enabled means that uncorrected
  * errors will still be processed in a timely fashion.
  */
-#define CMCI_STORM_THRESHOLD	32749
=20
 static int cmci_supported(int *banks)
 {
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/i=
nternal.h
index 836e56027..086b833c5 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -7,7 +7,7 @@
=20
 #include <linux/device.h>
 #include <asm/mce.h>
-
+#include <linux/spinlock.h>
 enum severity_level {
 	MCE_NO_SEVERITY,
 	MCE_DEFERRED_SEVERITY,
@@ -334,11 +334,16 @@ static __always_inline u32 mca_msr_reg(int bank, enum=
 mca_msr reg)
 }
=20
 extern void (*mc_poll_banks)(void);
+#define CMCI_STORM_THRESHOLD    32749
+extern raw_spinlock_t cmci_discover_lock;
+extern u16 cmci_threshold[MAX_NR_BANKS];
 #ifdef CONFIG_X86_MCE_ZHAOXIN
 void mce_zhaoxin_feature_init(struct cpuinfo_x86 *c);
 void mce_zhaoxin_feature_clear(struct cpuinfo_x86 *c);
+void mce_zhaoxin_handle_storm(int bank, bool on);
 #else
 static inline void mce_zhaoxin_feature_init(struct cpuinfo_x86 *c) { }
 static inline void mce_zhaoxin_feature_clear(struct cpuinfo_x86 *c) { }
+static inline void mce_zhaoxin_handle_storm(int bank, bool on) { }
 #endif
 #endif /* __X86_MCE_INTERNAL_H__ */
diff --git a/arch/x86/kernel/cpu/mce/threshold.c b/arch/x86/kernel/cpu/mce/=
threshold.c
index 89e31e1e5..200280387 100644
--- a/arch/x86/kernel/cpu/mce/threshold.c
+++ b/arch/x86/kernel/cpu/mce/threshold.c
@@ -63,6 +63,10 @@ static void mce_handle_storm(unsigned int bank, bool on)
 	case X86_VENDOR_INTEL:
 		mce_intel_handle_storm(bank, on);
 		break;
+	case X86_VENDOR_ZHAOXIN:
+	case X86_VENDOR_CENTAUR:
+		mce_zhaoxin_handle_storm(bank, on);
+		break;
 	}
 }
=20
diff --git a/arch/x86/kernel/cpu/mce/zhaoxin.c b/arch/x86/kernel/cpu/mce/zh=
aoxin.c
index de69c560f..994b8520a 100644
--- a/arch/x86/kernel/cpu/mce/zhaoxin.c
+++ b/arch/x86/kernel/cpu/mce/zhaoxin.c
@@ -63,3 +63,21 @@ void mce_zhaoxin_feature_clear(struct cpuinfo_x86 *c)
 {
 	intel_clear_lmce();
 }
+
+void mce_zhaoxin_handle_storm(int bank, bool on)
+{
+	unsigned long flags;
+	u64 val;
+
+	raw_spin_lock_irqsave(&cmci_discover_lock, flags);
+	rdmsrl(MSR_IA32_MCx_CTL2(bank), val);
+	if (on) {
+		val &=3D ~(MCI_CTL2_CMCI_EN | MCI_CTL2_CMCI_THRESHOLD_MASK);
+		val |=3D CMCI_STORM_THRESHOLD;
+	} else {
+		val &=3D ~MCI_CTL2_CMCI_THRESHOLD_MASK;
+		val |=3D (MCI_CTL2_CMCI_EN | cmci_threshold[bank]);
+	}
+	wrmsrl(MSR_IA32_MCx_CTL2(bank), val);
+	raw_spin_unlock_irqrestore(&cmci_discover_lock, flags);
+}
--=20
2.34.1


