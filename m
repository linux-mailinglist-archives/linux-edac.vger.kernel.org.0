Return-Path: <linux-edac+bounces-1887-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0179597B805
	for <lists+linux-edac@lfdr.de>; Wed, 18 Sep 2024 08:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 259CA1C2258A
	for <lists+linux-edac@lfdr.de>; Wed, 18 Sep 2024 06:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7B71714D7;
	Wed, 18 Sep 2024 06:37:29 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D484E16FF5F
	for <linux-edac@vger.kernel.org>; Wed, 18 Sep 2024 06:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.110.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726641449; cv=none; b=sfVRtP24p8B4+5p2fTcpx6/k7WCKdLeUMAOQKNy6GY5b0uh8Z6Cl4HoKSEY+vkVMCNyRJ7Umr5eVHlzoFbZQd/cvAIaQ+NAYiYmH/RyS5g06fpJOd3/yfWz7Hyt/3kMYdXfcSZtu92ZDGfo1oNYIqr2PZ62/YOrMGFfi3mE1S6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726641449; c=relaxed/simple;
	bh=GvgQJTd21P7Cx1enPoHooMLpVxGar3AjZOHkK9fht4Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t5WosnKs31RJpQedmFlDkkducng8pxL5bUudwvNig1GP/timwk+XngvnuyIug/XuR7swq1PgjBkGiVKQcJ58jTi+g3KNq05VDNnmuROzNIqZdK1tUfFyqQquJQjQHf1E6Y/cRnrRMYIBxvbT8Dx3RWyGypaLlN+dbwjCI/1yhSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=203.110.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1726641436-1eb14e31a910e980001-QCVQLf
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx2.zhaoxin.com with ESMTP id gHlV3rbiqUBi4BKr (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Wed, 18 Sep 2024 14:37:16 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXSHMBX2.zhaoxin.com (10.28.252.164) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 18 Sep
 2024 14:37:16 +0800
Received: from ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d]) by
 ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d%4]) with mapi id
 15.01.2507.039; Wed, 18 Sep 2024 14:37:15 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from localhost.localdomain (10.32.65.165) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Sep
 2024 13:54:37 +0800
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>
CC: <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>, <LeoLiu-oc@zhaoxin.com>,
	Lyle Li <LyleLi@zhaoxin.com>
Subject: [PATCH v3 2/3] x86/mce: Add zhaoxin.c to support Zhaoxin MCA
Date: Wed, 18 Sep 2024 13:54:35 +0800
X-ASG-Orig-Subj: [PATCH v3 2/3] x86/mce: Add zhaoxin.c to support Zhaoxin MCA
Message-ID: <20240918055436.15551-3-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240918055436.15551-1-TonyWWang-oc@zhaoxin.com>
References: <20240910092652.13354-1-TonyWWang-oc@zhaoxin.com>
 <20240918055436.15551-1-TonyWWang-oc@zhaoxin.com>
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
X-Moderation-Data: 9/18/2024 2:37:14 PM
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1726641436
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 6821
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.130611
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

From: Lyle Li <LyleLi@zhaoxin.com>

For the sake of code standardization, add zhaoxin.c to
override the Zhaoxin MCA code.

Signed-off-by: Lyle Li <LyleLi@zhaoxin.com>
Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 arch/x86/Kconfig                   |  8 ++++
 arch/x86/kernel/cpu/mce/Makefile   |  2 +-
 arch/x86/kernel/cpu/mce/core.c     | 57 --------------------------
 arch/x86/kernel/cpu/mce/internal.h |  7 ++++
 arch/x86/kernel/cpu/mce/zhaoxin.c  | 65 ++++++++++++++++++++++++++++++
 5 files changed, 81 insertions(+), 58 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/mce/zhaoxin.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1d7122a18..b908cdfb9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1171,6 +1171,14 @@ config X86_MCE_INTEL
 	  Additional support for intel specific MCE features such as
 	  the thermal monitor.
=20
+config X86_MCE_ZHAOXIN
+	def_bool y
+	prompt "Zhaoxin MCE features"
+	depends on X86_MCE_INTEL
+	help
+	  Additional support for zhaoxin specific MCE features such as
+	  the corrected machine check interrupt.
+
 config X86_MCE_AMD
 	def_bool y
 	prompt "AMD MCE features"
diff --git a/arch/x86/kernel/cpu/mce/Makefile b/arch/x86/kernel/cpu/mce/Mak=
efile
index 015856abd..2e863e78d 100644
--- a/arch/x86/kernel/cpu/mce/Makefile
+++ b/arch/x86/kernel/cpu/mce/Makefile
@@ -5,7 +5,7 @@ obj-$(CONFIG_X86_ANCIENT_MCE)	+=3D winchip.o p5.o
 obj-$(CONFIG_X86_MCE_INTEL)	+=3D intel.o
 obj-$(CONFIG_X86_MCE_AMD)	+=3D amd.o
 obj-$(CONFIG_X86_MCE_THRESHOLD) +=3D threshold.o
-
+obj-$(CONFIG_X86_MCE_ZHAOXIN)   +=3D zhaoxin.o
 mce-inject-y			:=3D inject.o
 obj-$(CONFIG_X86_MCE_INJECT)	+=3D mce-inject.o
=20
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.=
c
index 7f79d900f..5315c86b6 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1963,17 +1963,6 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_=
x86 *c)
 			mce_flags.skx_repmov_quirk =3D 1;
 	}
=20
-	if (c->x86_vendor =3D=3D X86_VENDOR_ZHAOXIN) {
-		/*
-		 * All newer Zhaoxin CPUs support MCE broadcasting. Enable
-		 * synchronization with a one second timeout.
-		 */
-		if (c->x86 > 6 || (c->x86_model =3D=3D 0x19 || c->x86_model =3D=3D 0x1f)=
) {
-			if (cfg->monarch_timeout < 0)
-				cfg->monarch_timeout =3D USEC_PER_SEC;
-		}
-	}
-
 	if (cfg->monarch_timeout < 0)
 		cfg->monarch_timeout =3D 0;
 	if (cfg->bootlog !=3D 0)
@@ -2016,49 +2005,6 @@ static void __mcheck_cpu_init_early(struct cpuinfo_x=
86 *c)
 	}
 }
=20
-static void mce_centaur_feature_init(struct cpuinfo_x86 *c)
-{
-	struct mca_config *cfg =3D &mca_cfg;
-
-	 /*
-	  * All newer Centaur CPUs support MCE broadcasting. Enable
-	  * synchronization with a one second timeout.
-	  */
-	if ((c->x86 =3D=3D 6 && c->x86_model =3D=3D 0xf && c->x86_stepping >=3D 0=
xe) ||
-	     c->x86 > 6) {
-		if (cfg->monarch_timeout < 0)
-			cfg->monarch_timeout =3D USEC_PER_SEC;
-	}
-}
-
-static void mce_zhaoxin_feature_init(struct cpuinfo_x86 *c)
-{
-	struct mce_bank *mce_banks =3D this_cpu_ptr(mce_banks_array);
-
-	/*
-	 * These CPUs have MCA bank 8 which reports only one error type called
-	 * SVAD (System View Address Decoder). The reporting of that error is
-	 * controlled by IA32_MC8.CTL.0.
-	 *
-	 * If enabled, prefetching on these CPUs will cause SVAD MCE when
-	 * virtual machines start and result in a system  panic. Always disable
-	 * bank 8 SVAD error by default.
-	 */
-	if ((c->x86 =3D=3D 7 && c->x86_model =3D=3D 0x1b) ||
-	    (c->x86_model =3D=3D 0x19 || c->x86_model =3D=3D 0x1f)) {
-		if (this_cpu_read(mce_num_banks) > 8)
-			mce_banks[8].ctl =3D 0;
-	}
-
-	intel_init_cmci();
-	intel_init_lmce();
-}
-
-static void mce_zhaoxin_feature_clear(struct cpuinfo_x86 *c)
-{
-	intel_clear_lmce();
-}
-
 static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
 {
 	switch (c->x86_vendor) {
@@ -2076,9 +2022,6 @@ static void __mcheck_cpu_init_vendor(struct cpuinfo_x=
86 *c)
 		break;
=20
 	case X86_VENDOR_CENTAUR:
-		mce_centaur_feature_init(c);
-		break;
-
 	case X86_VENDOR_ZHAOXIN:
 		mce_zhaoxin_feature_init(c);
 		break;
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/i=
nternal.h
index 01f8f0396..836e56027 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -334,4 +334,11 @@ static __always_inline u32 mca_msr_reg(int bank, enum =
mca_msr reg)
 }
=20
 extern void (*mc_poll_banks)(void);
+#ifdef CONFIG_X86_MCE_ZHAOXIN
+void mce_zhaoxin_feature_init(struct cpuinfo_x86 *c);
+void mce_zhaoxin_feature_clear(struct cpuinfo_x86 *c);
+#else
+static inline void mce_zhaoxin_feature_init(struct cpuinfo_x86 *c) { }
+static inline void mce_zhaoxin_feature_clear(struct cpuinfo_x86 *c) { }
+#endif
 #endif /* __X86_MCE_INTERNAL_H__ */
diff --git a/arch/x86/kernel/cpu/mce/zhaoxin.c b/arch/x86/kernel/cpu/mce/zh=
aoxin.c
new file mode 100644
index 000000000..de69c560f
--- /dev/null
+++ b/arch/x86/kernel/cpu/mce/zhaoxin.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Zhaoxin specific MCE features
+ * Author: Lyle Li
+ */
+#include <asm/msr.h>
+#include "internal.h"
+
+static void mce_zhaoxin_apply_mce_broadcast(struct cpuinfo_x86 *c)
+{
+	struct mca_config *cfg =3D &mca_cfg;
+
+	/* Older CPUs do not do MCE broadcast */
+	if (c->x86 < 6)
+		return;
+	/*
+	 * All newer Zhaoxin and Centaur CPUs support MCE broadcasting. Enable
+	 * synchronization with a one second timeout.
+	 */
+	if (c->x86 > 6)
+		goto mce_broadcast;
+
+	if (c->x86_vendor =3D=3D X86_VENDOR_CENTAUR) {
+		if (c->x86_model =3D=3D 0xf && c->x86_stepping >=3D 0xe)
+			goto mce_broadcast;
+	} else if (c->x86_vendor =3D=3D X86_VENDOR_ZHAOXIN) {
+		if (c->x86_model =3D=3D 0x19 || c->x86_model =3D=3D 0x1f)
+			goto mce_broadcast;
+	}
+
+	return;
+
+mce_broadcast:
+	if (cfg->monarch_timeout <=3D 0)
+		cfg->monarch_timeout =3D USEC_PER_SEC;
+}
+
+void mce_zhaoxin_feature_init(struct cpuinfo_x86 *c)
+{
+	struct mce_bank *mce_banks =3D this_cpu_ptr(mce_banks_array);
+
+	/*
+	 * These CPUs have MCA bank 8 which reports only one error type called
+	 * SVAD (System View Address Decoder). The reporting of that error is
+	 * controlled by IA32_MC8.CTL.0.
+	 *
+	 * If enabled, prefetching on these CPUs will cause SVAD MCE when
+	 * virtual machines start and result in a system  panic. Always disable
+	 * bank 8 SVAD error by default.
+	 */
+	if ((c->x86 =3D=3D 7 && c->x86_model =3D=3D 0x1b) ||
+	    (c->x86_model =3D=3D 0x19 || c->x86_model =3D=3D 0x1f)) {
+		if (this_cpu_read(mce_num_banks) > 8)
+			mce_banks[8].ctl =3D 0;
+	}
+
+	mce_zhaoxin_apply_mce_broadcast(c);
+	intel_init_cmci();
+	intel_init_lmce();
+}
+
+void mce_zhaoxin_feature_clear(struct cpuinfo_x86 *c)
+{
+	intel_clear_lmce();
+}
--=20
2.34.1


