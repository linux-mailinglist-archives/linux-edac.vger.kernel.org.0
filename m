Return-Path: <linux-edac+bounces-2029-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D84C99C2A5
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 10:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B23CB22C12
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 08:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BE815383C;
	Mon, 14 Oct 2024 08:09:55 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B63C14D428
	for <linux-edac@vger.kernel.org>; Mon, 14 Oct 2024 08:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728893395; cv=none; b=aguYfdnHH45ZHV4tYHFL0tW145ZbtZSDjqKtRyJkmU17NfwLQBUwX3tx5EzSQhQFa/Nz8bLrVy3Iexs4kopHm7Mz7rcKnkXMyhE5GTSRWMSBjw/JNheR6z3x+FlgfgHeGoJoGYUtf/MNZA8ZSxh8R5LR2MS1iSj8dscfwrXTYF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728893395; c=relaxed/simple;
	bh=miK4pvlIZlfESjiUK91KFPqSMzesiJqr6YPOkwQLxgY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lcLXglvmaYEGwNiB2aN+c61IeS0ZsNLM/zvEyuU6tNHCY//E+dRR33sP0a78j++P08apkMw/LYt96doeTJE5aSD0IF8IutUZb9E35C5b7PX9ZbtxQ8Fjz/M4Gr0V+V/UaS8eLWOHTAsFps6IfloAJjZ6eTbumT5qyk8xxTLPZWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1728893379-086e23455c01f40001-QCVQLf
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx1.zhaoxin.com with ESMTP id ACuS9jVZUwgkiWHT (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 14 Oct 2024 16:09:39 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 14 Oct
 2024 16:09:38 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::3066:e339:e3d6:5264]) by
 ZXSHMBX1.zhaoxin.com ([fe80::3066:e339:e3d6:5264%7]) with mapi id
 15.01.2507.039; Mon, 14 Oct 2024 16:09:38 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from localhost.localdomain (10.32.65.165) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Oct
 2024 15:53:09 +0800
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <qiuxu.zhuo@intel.com>
CC: <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>, <LeoLiu-oc@zhaoxin.com>,
	Lyle Li <LyleLi@zhaoxin.com>
Subject: [PATCH v5 2/4] x86/mce: Remove functions that disable error reporting
Date: Mon, 14 Oct 2024 15:53:16 +0800
X-ASG-Orig-Subj: [PATCH v5 2/4] x86/mce: Remove functions that disable error reporting
Message-ID: <20241014075318.1936-3-TonyWWang-oc@zhaoxin.com>
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
X-Moderation-Data: 10/14/2024 4:09:37 PM
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1728893379
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2572
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.131784
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

From: Lyle Li <LyleLi@zhaoxin.com>

Since all major vendors do not disable MCA_CTL after initialization,
remove the functions that disable error reporting.

Signed-off-by: Lyle Li <LyleLi@zhaoxin.com>
Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 arch/x86/kernel/cpu/mce/core.c | 50 ----------------------------------
 1 file changed, 50 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.=
c
index 1b647869c320..f71b33b96b5b 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2383,53 +2383,6 @@ int __init mcheck_init(void)
  * mce_syscore: PM support
  */
=20
-/*
- * Disable machine checks on suspend and shutdown. We can't really handle
- * them later.
- */
-static void mce_disable_error_reporting(void)
-{
-	struct mce_bank *mce_banks =3D this_cpu_ptr(mce_banks_array);
-	int i;
-
-	for (i =3D 0; i < this_cpu_read(mce_num_banks); i++) {
-		struct mce_bank *b =3D &mce_banks[i];
-
-		if (b->init)
-			wrmsrl(mca_msr_reg(i, MCA_CTL), 0);
-	}
-	return;
-}
-
-static void vendor_disable_error_reporting(void)
-{
-	/*
-	 * Don't clear on Intel or AMD or Hygon or Zhaoxin CPUs. Some of these
-	 * MSRs are socket-wide. Disabling them for just a single offlined CPU
-	 * is bad, since it will inhibit reporting for all shared resources on
-	 * the socket like the last level cache (LLC), the integrated memory
-	 * controller (iMC), etc.
-	 */
-	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_INTEL ||
-	    boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_HYGON ||
-	    boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_AMD ||
-	    boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_ZHAOXIN)
-		return;
-
-	mce_disable_error_reporting();
-}
-
-static int mce_syscore_suspend(void)
-{
-	vendor_disable_error_reporting();
-	return 0;
-}
-
-static void mce_syscore_shutdown(void)
-{
-	vendor_disable_error_reporting();
-}
-
 /*
  * On resume clear all MCE state. Don't want to see leftovers from the BIO=
S.
  * Only one CPU is active at this time, the others get re-added later usin=
g
@@ -2443,8 +2396,6 @@ static void mce_syscore_resume(void)
 }
=20
 static struct syscore_ops mce_syscore_ops =3D {
-	.suspend	=3D mce_syscore_suspend,
-	.shutdown	=3D mce_syscore_shutdown,
 	.resume		=3D mce_syscore_resume,
 };
=20
@@ -2729,7 +2680,6 @@ static void mce_disable_cpu(void)
 	if (!cpuhp_tasks_frozen)
 		cmci_clear();
=20
-	vendor_disable_error_reporting();
 }
=20
 static void mce_reenable_cpu(void)
--=20
2.34.1


