Return-Path: <linux-edac+bounces-1829-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B30D971624
	for <lists+linux-edac@lfdr.de>; Mon,  9 Sep 2024 13:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74DF8B2650B
	for <lists+linux-edac@lfdr.de>; Mon,  9 Sep 2024 11:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FB91B5803;
	Mon,  9 Sep 2024 11:02:58 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27911B533E
	for <linux-edac@vger.kernel.org>; Mon,  9 Sep 2024 11:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.110.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725879778; cv=none; b=F3A9vizivEAnooY3A9mtFaROvczFM9ZV90AnCCZt5QQRtKxDKKNzSbI6GNKtP+kYUD/Bcabp0Z/Wyzmvm1Jg8CH9srm/GwHenHMFB8/vk45nrPsSlQ3884HVjOvSosw1IQc0tBXZc5SAkFsWo4FDNbEbi7f6DhQ0krWCn2qKM6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725879778; c=relaxed/simple;
	bh=s9A502O3iKkERZoBN8m5F2WimPPfkpUnmF3aUeXrBek=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XKQNvy9D+/m4w8PNXWk0NHJBp3/9sgqeaMHpuJfK3i0t3nDXDpcuHj5L0lvducH3SPTzkpmZi/CCRPqTtY7iManexkGxTijyB3mm8dNoUX7QMoqnIGwlYSTaJCF52Fqul8H9mNG69uToV5H6Xyb8cM2j5xNARnAsrQAFEPrMFQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=203.110.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1725879772-1eb14e31a6f3b00001-QCVQLf
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx2.zhaoxin.com with ESMTP id n9pBb5GZiHjEdqyT (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 09 Sep 2024 19:02:52 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXSHMBX2.zhaoxin.com (10.28.252.164) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 9 Sep
 2024 19:02:51 +0800
Received: from ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d]) by
 ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d%4]) with mapi id
 15.01.2507.039; Mon, 9 Sep 2024 19:02:51 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from tony.zhaoxin.com (10.32.65.165) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 18:43:54 +0800
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>
CC: <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>, <LeoLiu-oc@zhaoxin.com>,
	Lyle Li <LyleLi@zhaoxin.com>
Subject: [PATCH v1 3/3] x86/mce: Add CMCI storm switching support for Zhaoxin
Date: Mon, 9 Sep 2024 18:43:49 +0800
X-ASG-Orig-Subj: [PATCH v1 3/3] x86/mce: Add CMCI storm switching support for Zhaoxin
Message-ID: <20240909104349.3349-4-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240909104349.3349-1-TonyWWang-oc@zhaoxin.com>
References: <20240909104349.3349-1-TonyWWang-oc@zhaoxin.com>
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
X-Moderation-Data: 9/9/2024 7:02:50 PM
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1725879772
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 4285
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.130206
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
Reviewed-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
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
index e9b06b825..8fa1f590f 100644
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
 void mce_zhaoxin_feature_init(struct cpuinfo_x86 *c) {}
 void mce_zhaoxin_feature_clear(struct cpuinfo_x86 *c) {}
+void mce_zhaoxin_handle_storm(int bank, bool on) {}
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
index 97d12ce0c..38beca449 100644
--- a/arch/x86/kernel/cpu/mce/zhaoxin.c
+++ b/arch/x86/kernel/cpu/mce/zhaoxin.c
@@ -33,3 +33,21 @@ void mce_zhaoxin_feature_clear(struct cpuinfo_x86 *c)
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


