Return-Path: <linux-edac+bounces-1841-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFC2972DAD
	for <lists+linux-edac@lfdr.de>; Tue, 10 Sep 2024 11:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37E7BB26748
	for <lists+linux-edac@lfdr.de>; Tue, 10 Sep 2024 09:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F752188CC9;
	Tue, 10 Sep 2024 09:31:32 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5E718C03E
	for <linux-edac@vger.kernel.org>; Tue, 10 Sep 2024 09:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725960692; cv=none; b=PDeq6Q0ZiDcN+lTRKTPRd+7qlzCKYLvfrrnmmABJUA8Imi2yui3uuyDLrmFBCGrENmZx+O+SDrfvr/l1r2lkKyI6kICCmBfnjwH+66ur4HXptmI1nyLyzu9ot0nwNXHCLI00NGcK6TRp1lprMTR1lGNL5hks26sJ1qcOGea9HYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725960692; c=relaxed/simple;
	bh=2ABtLnQe9saTfj1Lxf4ztyAnDJpHbrBzuQC0CiHcJjM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c71YcTEn8Sx5z12VRqNnzpcklYM1UXzJBRCkCq9/lmbK/ELsu4zj0sDQT5OA9t+Jv9xcq3YGuC391928+pyenFOe+7o1LTR86fGihRjrUZ05TniAUwYIHiOGwRV4JQXJUFUH3CPJ+RvOBIm31qQmq+Hklu+cKbosKxKy3bqCcG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1725960684-086e237613120240001-QCVQLf
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx1.zhaoxin.com with ESMTP id KM7dGLOT6Tzrg8db (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Tue, 10 Sep 2024 17:31:24 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXSHMBX2.zhaoxin.com (10.28.252.164) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 10 Sep
 2024 17:31:24 +0800
Received: from ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d]) by
 ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d%4]) with mapi id
 15.01.2507.039; Tue, 10 Sep 2024 17:31:24 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from localhost.localdomain (10.32.65.165) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Sep
 2024 17:26:57 +0800
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>
CC: <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>, <LeoLiu-oc@zhaoxin.com>,
	Lyle Li <LyleLi@zhaoxin.com>
Subject: [PATCH v2 2/3] x86/mce: Add zhaoxin.c to support Zhaoxin MCA
Date: Tue, 10 Sep 2024 17:26:51 +0800
X-ASG-Orig-Subj: [PATCH v2 2/3] x86/mce: Add zhaoxin.c to support Zhaoxin MCA
Message-ID: <20240910092652.13354-3-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240910092652.13354-1-TonyWWang-oc@zhaoxin.com>
References: <2024090910439.3349-1-TonyWWang-oc@zhaoxin.com>
 <20240910092652.13354-1-TonyWWang-oc@zhaoxin.com>
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
X-Moderation-Data: 9/10/2024 5:31:23 PM
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1725960684
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 4759
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.130251
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

From: Lyle Li <LyleLi@zhaoxin.com>

For the sake of code standardization, add zhaoxin.c to
override the Zhaoxin MCA code.

Signed-off-by: Lyle Li <LyleLi@zhaoxin.com>
---
 arch/x86/Kconfig                   |  8 +++++++
 arch/x86/kernel/cpu/mce/Makefile   |  2 +-
 arch/x86/kernel/cpu/mce/core.c     | 28 ------------------------
 arch/x86/kernel/cpu/mce/internal.h |  7 ++++++
 arch/x86/kernel/cpu/mce/zhaoxin.c  | 35 ++++++++++++++++++++++++++++++
 5 files changed, 51 insertions(+), 29 deletions(-)
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
index b7b98c33a..b32bfd9f3 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2028,34 +2028,6 @@ static void __mcheck_cpu_init_early(struct cpuinfo_x=
86 *c)
 	}
 }
=20
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
index 000000000..97d12ce0c
--- /dev/null
+++ b/arch/x86/kernel/cpu/mce/zhaoxin.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Zhaoxin specific MCE features
+ * Author: Lyle Li
+ */
+#include <asm/msr.h>
+#include "internal.h"
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


