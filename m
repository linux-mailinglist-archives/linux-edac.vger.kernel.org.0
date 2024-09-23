Return-Path: <linux-edac+bounces-1914-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC9797E6B7
	for <lists+linux-edac@lfdr.de>; Mon, 23 Sep 2024 09:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 695141F2108F
	for <lists+linux-edac@lfdr.de>; Mon, 23 Sep 2024 07:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A437B6E2BE;
	Mon, 23 Sep 2024 07:37:31 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22BA3C485
	for <linux-edac@vger.kernel.org>; Mon, 23 Sep 2024 07:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.110.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727077051; cv=none; b=qdAuVhVMKhKufuVhqcwfYUctBv8jWT6djVc9KTLSHfXcxqMN5aQauAmhZbbZ2INKY253F02DzLjZSMnxtIeygroASRZnAV2P5oAwIl9xjAf0jDZK0hOlx0BXTEAnDnM+9RsjUrdR+EUK92kl+PKg3c4IdtBZlWgNaEygumwoMcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727077051; c=relaxed/simple;
	bh=2oeV+afBSOOqynCQM1WBP3//mRNM7gvN+utn4b6xGMQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gN21Xh5MVcx5FOIH2wKij3PWPlOIazTcugp1f/noHXPMvAC4Yy6Pp2P9WaPyE6WnfKhGP+l9EZ3f1W0y364Jgi1PEts9YUPTSM9+iXUl1v7DuI6D8it8Nsg8jDhxDFmG2QTyUiYZ4COTYibc1tKfpRPh8P/40BfBM2bcvsI9OJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=203.110.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1727077035-1eb14e31a71164e0001-QCVQLf
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx2.zhaoxin.com with ESMTP id FYaIoiMM5E9mZSYS (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 23 Sep 2024 15:37:15 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXSHMBX2.zhaoxin.com (10.28.252.164) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 23 Sep
 2024 15:37:14 +0800
Received: from ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d]) by
 ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d%4]) with mapi id
 15.01.2507.039; Mon, 23 Sep 2024 15:37:14 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from localhost.localdomain (10.32.65.165) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Sep
 2024 15:33:09 +0800
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>
CC: <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>, <LeoLiu-oc@zhaoxin.com>,
	Lyle Li <LyleLi@zhaoxin.com>
Subject: [PATCH v4 1/4] x86/mce: Add centaur vendor to support Zhaoxin MCA
Date: Mon, 23 Sep 2024 15:33:08 +0800
X-ASG-Orig-Subj: [PATCH v4 1/4] x86/mce: Add centaur vendor to support Zhaoxin MCA
Message-ID: <20240923073311.4290-2-TonyWWang-oc@zhaoxin.com>
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
X-Moderation-Data: 9/23/2024 3:37:13 PM
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1727077035
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2594
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.130842
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

From: Lyle Li <LyleLi@zhaoxin.com>

Zhaoxin consists of two vendors, X86_VENDOR_ZHAOXIN and
X86_VENDOR_CENTAUR, so add the centaur vendor to support
Zhaoxin MCA in mce/core.c and mce/intel.c.

Signed-off-by: Lyle Li <LyleLi@zhaoxin.com>
Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 arch/x86/kernel/cpu/mce/core.c  | 9 +++++++--
 arch/x86/kernel/cpu/mce/intel.c | 3 ++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.=
c
index ad0623b65..4ad6b5083 100644
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
@@ -2092,6 +2096,7 @@ static void __mcheck_cpu_clear_vendor(struct cpuinfo_=
x86 *c)
 		break;
=20
 	case X86_VENDOR_ZHAOXIN:
+	case X86_VENDOR_CENTAUR:
 		mce_zhaoxin_feature_clear(c);
 		break;
=20
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


