Return-Path: <linux-edac+bounces-2031-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 805EC99C2A9
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 10:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 016AE1F21EC1
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 08:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E031552EB;
	Mon, 14 Oct 2024 08:09:58 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4957A14A614
	for <linux-edac@vger.kernel.org>; Mon, 14 Oct 2024 08:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728893398; cv=none; b=V9jb+N1bxOQr1QL7YLckmLDarq8hD2jgh0Bcx2rmdMlbGU2+bqLiz6yzRjvAkdXLgGnt9Ymq8ZKB19IctIIrXfEJxY1ZufXjxbSYv4gTeebVF/bMI55iidMMh9YEXjhUXx0PG5BDnbtbjh8IqL34WITNsXaKL56kAWhYF5Frgqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728893398; c=relaxed/simple;
	bh=bPnlxjlI7MuDJEDssLTW/eBbHJXmLHJB/mQuRhWiLU0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D7twpiQgRhaI5nJy7pXWwCK8JJ6Sfq9aBKm4OTLjoNaNiTh581LvJRIk7tEa3AUT1IgYH0gpv1zhOMVQr49fO0D7q6iwpouvl5wkUy05VXroZgHs3TrV617UzThzuS7UBubgJSNC8+hwsLh4ma2s8DQXe3MbNd3qy0K25G1qyuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1728893379-086e23455c01f40002-QCVQLf
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx1.zhaoxin.com with ESMTP id SOeYZRn4UNjSBSXI (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 14 Oct 2024 16:09:48 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 14 Oct
 2024 16:09:41 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::3066:e339:e3d6:5264]) by
 ZXSHMBX1.zhaoxin.com ([fe80::3066:e339:e3d6:5264%7]) with mapi id
 15.01.2507.039; Mon, 14 Oct 2024 16:09:41 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from localhost.localdomain (10.32.65.165) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Oct
 2024 15:53:10 +0800
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <qiuxu.zhuo@intel.com>
CC: <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>, <LeoLiu-oc@zhaoxin.com>,
	Lyle Li <LyleLi@zhaoxin.com>
Subject: [PATCH v5 3/4] x86/mce: Add zhaoxin.c to support Zhaoxin MCA
Date: Mon, 14 Oct 2024 15:53:17 +0800
X-ASG-Orig-Subj: [PATCH v5 3/4] x86/mce: Add zhaoxin.c to support Zhaoxin MCA
Message-ID: <20241014075318.1936-4-TonyWWang-oc@zhaoxin.com>
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
X-Moderation-Data: 10/14/2024 4:09:40 PM
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1728893379
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 6814
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.131784
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

From: Lyle Li <LyleLi@zhaoxin.com>

For the sake of code standardization, add zhaoxin.c to
override the Zhaoxin MCA code.

Signed-off-by: Lyle Li <LyleLi@zhaoxin.com>
Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 arch/x86/Kconfig                   |  8 ++++
 arch/x86/kernel/cpu/mce/Makefile   |  1 +
 arch/x86/kernel/cpu/mce/core.c     | 57 --------------------------
 arch/x86/kernel/cpu/mce/internal.h |  7 ++++
 arch/x86/kernel/cpu/mce/zhaoxin.c  | 64 ++++++++++++++++++++++++++++++
 5 files changed, 80 insertions(+), 57 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/mce/zhaoxin.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1ea18662942c..a7993835f460 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1183,6 +1183,14 @@ config X86_MCE_INTEL
 	  Additional support for intel specific MCE features such as
 	  the thermal monitor.
=20
+config X86_MCE_ZHAOXIN
+	def_bool y
+	prompt "Zhaoxin MCE features"
+	depends on X86_MCE_INTEL
+	help
+	  Additional support for Zhaoxin specific MCE features such as
+	  the corrected machine check interrupt.
+
 config X86_MCE_AMD
 	def_bool y
 	prompt "AMD MCE features"
diff --git a/arch/x86/kernel/cpu/mce/Makefile b/arch/x86/kernel/cpu/mce/Mak=
efile
index 015856abdbb1..7b52c8f2f08e 100644
--- a/arch/x86/kernel/cpu/mce/Makefile
+++ b/arch/x86/kernel/cpu/mce/Makefile
@@ -4,6 +4,7 @@ obj-y				=3D  core.o severity.o genpool.o
 obj-$(CONFIG_X86_ANCIENT_MCE)	+=3D winchip.o p5.o
 obj-$(CONFIG_X86_MCE_INTEL)	+=3D intel.o
 obj-$(CONFIG_X86_MCE_AMD)	+=3D amd.o
+obj-$(CONFIG_X86_MCE_ZHAOXIN)   +=3D zhaoxin.o
 obj-$(CONFIG_X86_MCE_THRESHOLD) +=3D threshold.o
=20
 mce-inject-y			:=3D inject.o
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.=
c
index f71b33b96b5b..a1684b73b349 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1970,17 +1970,6 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_=
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
@@ -2023,49 +2012,6 @@ static void __mcheck_cpu_init_early(struct cpuinfo_x=
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
@@ -2083,9 +2029,6 @@ static void __mcheck_cpu_init_vendor(struct cpuinfo_x=
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
index 43c7f3b71df5..fb9d8b5b3b75 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -336,4 +336,11 @@ static __always_inline u32 mca_msr_reg(int bank, enum =
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
index 000000000000..6fdef2d24f31
--- /dev/null
+++ b/arch/x86/kernel/cpu/mce/zhaoxin.c
@@ -0,0 +1,64 @@
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
+	/* Older CPUs do not do MCE broadcast: */
+	if (c->x86 < 6)
+		return;
+
+	/* All newer ones do: */
+	if (c->x86 > 6)
+		goto mce_broadcast;
+
+	/* Family 6 is mixed: */
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


