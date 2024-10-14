Return-Path: <linux-edac+bounces-2030-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3698499C2A6
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 10:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E095A281492
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 08:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E5F1547D2;
	Mon, 14 Oct 2024 08:09:57 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CEC152517
	for <linux-edac@vger.kernel.org>; Mon, 14 Oct 2024 08:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728893397; cv=none; b=T8LZF6IJsOknsyajoTkAL1qg1tHc/JONcyWQh9En0IUMltfqmFBRqLFUrAD74XQWz91qSOr9vu7NjdSvTTkT6P+qrMARCW2B+ahFapui4iQeanEmfI5SvHotyaQNjsrBl93RmOK8c7W5l2VRJVpVcSontj28+tWiAvquwrgijtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728893397; c=relaxed/simple;
	bh=yisnsM5bk8qmWpql+PtmE/GceSqV3F6HB30pytRDjeo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LOfP2wTTzvMB1lvt94GXIfAi++rcmxbzdXNNMxVFysh6vqO/MlaF3A8qSnjukRyJ43MYovbUQdZU6nrcizJfHjDSLFHH1t1jwekmXKDTkrBBFGbP897GfgaK0wNiTPztiza9ZCjZFp3F5z02A7s61m0VmKC4upV10y/XwcJux34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1728893385-086e23455b01f40001-QCVQLf
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx1.zhaoxin.com with ESMTP id pg1Crtg5oRIK5lJy (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 14 Oct 2024 16:09:45 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 14 Oct
 2024 16:09:44 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::3066:e339:e3d6:5264]) by
 ZXSHMBX1.zhaoxin.com ([fe80::3066:e339:e3d6:5264%7]) with mapi id
 15.01.2507.039; Mon, 14 Oct 2024 16:09:44 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from localhost.localdomain (10.32.65.165) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Oct
 2024 15:53:12 +0800
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <qiuxu.zhuo@intel.com>
CC: <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>, <LeoLiu-oc@zhaoxin.com>,
	Lyle Li <LyleLi@zhaoxin.com>
Subject: [PATCH v5 4/4] x86/mce: Add CMCI storm switching support for Zhaoxin
Date: Mon, 14 Oct 2024 15:53:18 +0800
X-ASG-Orig-Subj: [PATCH v5 4/4] x86/mce: Add CMCI storm switching support for Zhaoxin
Message-ID: <20241014075318.1936-5-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241014075318.1936-1-TonyWWang-oc@zhaoxin.com>
References: <20240923073311.4290-1-TonyWWang-oc@zhaoxin.com>
 <20241014075318.1936-1-TonyWWang-oc@zhaoxin.com>
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
X-Moderation-Data: 10/14/2024 4:09:43 PM
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1728893385
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 4298
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.131784
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

From: Lyle Li <LyleLi@zhaoxin.com>

Zhaoxin CPUs support CMCI which is compatible with Intel, but
their UCR errors are not reported through CMCI like Intel's. To
be compatible with intel's CMCI code, add Zhaoxin's specific
CMCI storm toggle.

Signed-off-by: Lyle Li <LyleLi@zhaoxin.com>
Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 arch/x86/kernel/cpu/mce/intel.c     |  5 ++---
 arch/x86/kernel/cpu/mce/internal.h  |  7 +++++++
 arch/x86/kernel/cpu/mce/threshold.c |  4 ++++
 arch/x86/kernel/cpu/mce/zhaoxin.c   | 18 ++++++++++++++++++
 4 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/inte=
l.c
index b7e67f4f7edd..aa75e28486c3 100644
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
index fb9d8b5b3b75..69377664bacf 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -6,6 +6,8 @@
 #define pr_fmt(fmt) "mce: " fmt
=20
 #include <linux/device.h>
+#include <linux/spinlock.h>
+
 #include <asm/mce.h>
=20
 enum severity_level {
@@ -336,11 +338,16 @@ static __always_inline u32 mca_msr_reg(int bank, enum=
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
index 89e31e1e5c9c..200280387f04 100644
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
index 6fdef2d24f31..6e38e2b8af20 100644
--- a/arch/x86/kernel/cpu/mce/zhaoxin.c
+++ b/arch/x86/kernel/cpu/mce/zhaoxin.c
@@ -62,3 +62,21 @@ void mce_zhaoxin_feature_clear(struct cpuinfo_x86 *c)
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


