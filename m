Return-Path: <linux-edac+bounces-1833-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F195E9716A1
	for <lists+linux-edac@lfdr.de>; Mon,  9 Sep 2024 13:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4112EB231CB
	for <lists+linux-edac@lfdr.de>; Mon,  9 Sep 2024 11:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B3F1B5833;
	Mon,  9 Sep 2024 11:20:42 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8660E1B5EB7
	for <linux-edac@vger.kernel.org>; Mon,  9 Sep 2024 11:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725880842; cv=none; b=iz1Uwam5jSvPTYRjd9t8HP1JkWWtm0BalqpuOqFpA272ImYBsh+HrZF5bb6z5NNmxvONWWiowb6cGC3OJtkUVwqwa8grOFAlB69LH/U/2Xy1DEi+odu5CNR9XeJsHbxC0NEl4Yr3caBBdY+kJe+m3BrQNtQ9EKhFVisv2m+e5z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725880842; c=relaxed/simple;
	bh=Y4GHECrA4sX/5ytDMOJCJyu0pijH8ibJXwTLjO/w8ok=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TIwDgpj412GdWvUBLB0Uosth0GZB4oJAckU8Cs0CCb2I3+IOImnFtzuTEiChiEKYBMxUw4lJQaITgKFASE/ren8gTkcx8oE6AyivTiMT4+JVxHa75VgHGoub97KlU7raVjWh9nq9K1gFBrnDHYrT2y0AXfmZsysqpwv7RfK2BCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1725879764-086e23761311ef60001-QCVQLf
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx1.zhaoxin.com with ESMTP id SAdoT31GxFeKHGxr (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 09 Sep 2024 19:02:44 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXSHMBX2.zhaoxin.com (10.28.252.164) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 9 Sep
 2024 19:02:43 +0800
Received: from ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d]) by
 ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d%4]) with mapi id
 15.01.2507.039; Mon, 9 Sep 2024 19:02:43 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from tony.zhaoxin.com (10.32.65.165) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 18:43:51 +0800
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>
CC: <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>, <LeoLiu-oc@zhaoxin.com>,
	Lyle Li <LyleLi@zhaoxin.com>
Subject: [PATCH v1 1/3] x86/mce: Add centaur vendor to support Zhaoxin MCA
Date: Mon, 9 Sep 2024 18:43:47 +0800
X-ASG-Orig-Subj: [PATCH v1 1/3] x86/mce: Add centaur vendor to support Zhaoxin MCA
Message-ID: <20240909104349.3349-2-TonyWWang-oc@zhaoxin.com>
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
X-Moderation-Data: 9/9/2024 7:02:42 PM
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1725879764
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 4507
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.130207
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

From: Lyle Li <LyleLi@zhaoxin.com>

Zhaoxin consists of two vendors, X86_VENDOR_ZHAOXIN and
X86_VENDOR_CENTAUR, so add the centaur vendor to support
Zhaoxin MCA in mce/core.c and mce/intel.c.

Signed-off-by: Lyle Li <LyleLi@zhaoxin.com>
Reviewed-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 arch/x86/kernel/cpu/mce/core.c  | 42 ++++++++++++++++-----------------
 arch/x86/kernel/cpu/mce/intel.c |  3 ++-
 2 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.=
c
index ad0623b65..b7b98c33a 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -496,6 +496,7 @@ bool mce_usable_address(struct mce *m)
=20
 	case X86_VENDOR_INTEL:
 	case X86_VENDOR_ZHAOXIN:
+	case X86_VENDOR_CENTAUR:
 		return intel_mce_usable_address(m);
=20
 	default:
@@ -513,6 +514,7 @@ bool mce_is_memory_error(struct mce *m)
=20
 	case X86_VENDOR_INTEL:
 	case X86_VENDOR_ZHAOXIN:
+	case X86_VENDOR_CENTAUR:
 		/*
 		 * Intel SDM Volume 3B - 15.9.2 Compound Error Codes
 		 *
@@ -1247,7 +1249,8 @@ static noinstr bool mce_check_crashing_cpu(void)
=20
 		mcgstatus =3D __rdmsr(MSR_IA32_MCG_STATUS);
=20
-		if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_ZHAOXIN) {
+		if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_ZHAOXIN ||
+		    boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_CENTAUR) {
 			if (mcgstatus & MCG_STATUS_LMCES)
 				return false;
 		}
@@ -1521,7 +1524,8 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	 * on Intel, Zhaoxin only.
 	 */
 	if (m.cpuvendor =3D=3D X86_VENDOR_INTEL ||
-	    m.cpuvendor =3D=3D X86_VENDOR_ZHAOXIN)
+	    m.cpuvendor =3D=3D X86_VENDOR_ZHAOXIN ||
+	    m.cpuvendor =3D=3D X86_VENDOR_CENTAUR)
 		lmce =3D m.mcgstatus & MCG_STATUS_LMCES;
=20
 	/*
@@ -1970,6 +1974,18 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_=
x86 *c)
 		}
 	}
=20
+	if (c->x86_vendor =3D=3D X86_VENDOR_CENTAUR) {
+		/*
+		 * All newer Centaur CPUs support MCE broadcasting. Enable
+		 * synchronization with a one second timeout.
+		 */
+		if ((c->x86 =3D=3D 6 && c->x86_model =3D=3D 0xf && c->x86_stepping >=3D =
0xe) ||
+		     c->x86 > 6) {
+			if (cfg->monarch_timeout < 0)
+				cfg->monarch_timeout =3D USEC_PER_SEC;
+		}
+	}
+
 	if (cfg->monarch_timeout < 0)
 		cfg->monarch_timeout =3D 0;
 	if (cfg->bootlog !=3D 0)
@@ -2012,21 +2028,6 @@ static void __mcheck_cpu_init_early(struct cpuinfo_x=
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
 static void mce_zhaoxin_feature_init(struct cpuinfo_x86 *c)
 {
 	struct mce_bank *mce_banks =3D this_cpu_ptr(mce_banks_array);
@@ -2072,9 +2073,6 @@ static void __mcheck_cpu_init_vendor(struct cpuinfo_x=
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
@@ -2092,6 +2090,7 @@ static void __mcheck_cpu_clear_vendor(struct cpuinfo_=
x86 *c)
 		break;
=20
 	case X86_VENDOR_ZHAOXIN:
+	case X86_VENDOR_CENTAUR:
 		mce_zhaoxin_feature_clear(c);
 		break;
=20
@@ -2401,7 +2400,8 @@ static void vendor_disable_error_reporting(void)
 	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_INTEL ||
 	    boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_HYGON ||
 	    boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_AMD ||
-	    boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_ZHAOXIN)
+	    boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_ZHAOXIN ||
+	    boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_CENTAUR)
 		return;
=20
 	mce_disable_error_reporting();
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/inte=
l.c
index f6103e6bf..b7e67f4f7 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -88,7 +88,8 @@ static int cmci_supported(int *banks)
 	 * makes sure none of the backdoors are entered otherwise.
 	 */
 	if (boot_cpu_data.x86_vendor !=3D X86_VENDOR_INTEL &&
-	    boot_cpu_data.x86_vendor !=3D X86_VENDOR_ZHAOXIN)
+	    boot_cpu_data.x86_vendor !=3D X86_VENDOR_ZHAOXIN &&
+	    boot_cpu_data.x86_vendor !=3D X86_VENDOR_CENTAUR)
 		return 0;
=20
 	if (!boot_cpu_has(X86_FEATURE_APIC) || lapic_get_maxlvt() < 6)
--=20
2.34.1


