Return-Path: <linux-edac+bounces-1913-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E9C97E6B8
	for <lists+linux-edac@lfdr.de>; Mon, 23 Sep 2024 09:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C14AB20BF3
	for <lists+linux-edac@lfdr.de>; Mon, 23 Sep 2024 07:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE5562A02;
	Mon, 23 Sep 2024 07:37:31 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186F41D52B
	for <linux-edac@vger.kernel.org>; Mon, 23 Sep 2024 07:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727077051; cv=none; b=Ltyx+WvE38NyMH1SZdI327P4+LkIfHBCYW45shiB4ebJbjFvk9qcJ4fxc3u1L9c+6Ti14nT9ZiWcps+lxMfp8o2zehbB6yod1ff8tv/EFKZRTq/tawxHtKscaKbjMNgqNJjOxtA3STXMhbVUbEyDT6zLzL/6+NkLL//WS7hCl6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727077051; c=relaxed/simple;
	bh=UU3F7rp5L33A79PMMkLquJ16YIaQMeV0iXpwK5hZmAE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TjARmIZ8EhkKz8GhgXtnOUe1Ldd629lHSEajGBXro93vjnt+E+ItLWZ33RNNu34nvnQHNKqHTwoQI8FzlhWx8e4CEhipIyc5aXajGMnPDFLNOm6EEiYSRJ36qkFt4pcfT2AlBMm0B9wszSG2zQ8DIb9tofyugyohROux/L49mlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1727077043-086e236b0600f40001-QCVQLf
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx1.zhaoxin.com with ESMTP id LE9uIJCPP4DqDH0J (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 23 Sep 2024 15:37:23 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXSHMBX2.zhaoxin.com (10.28.252.164) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 23 Sep
 2024 15:37:22 +0800
Received: from ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d]) by
 ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d%4]) with mapi id
 15.01.2507.039; Mon, 23 Sep 2024 15:37:22 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from localhost.localdomain (10.32.65.165) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Sep
 2024 15:33:11 +0800
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>
CC: <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>, <LeoLiu-oc@zhaoxin.com>,
	Lyle Li <LyleLi@zhaoxin.com>
Subject: [PATCH v4 2/4] x86/mce: Remove functions that disable error reporting
Date: Mon, 23 Sep 2024 15:33:09 +0800
X-ASG-Orig-Subj: [PATCH v4 2/4] x86/mce: Remove functions that disable error reporting
Message-ID: <20240923073311.4290-3-TonyWWang-oc@zhaoxin.com>
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
X-Moderation-Data: 9/23/2024 3:37:18 PM
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1727077043
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2539
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.130843
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

From: Lyle Li <LyleLi@zhaoxin.com>

Since all major vendors do not disable MCA_CTL after initialization,
functions that disable error reporting should be removed in mce/core.c.

Signed-off-by: Lyle Li <LyleLi@zhaoxin.com>
Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 arch/x86/kernel/cpu/mce/core.c | 50 ----------------------------------
 1 file changed, 50 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.=
c
index 4ad6b5083..1654133da 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2376,53 +2376,6 @@ int __init mcheck_init(void)
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
@@ -2436,8 +2389,6 @@ static void mce_syscore_resume(void)
 }
=20
 static struct syscore_ops mce_syscore_ops =3D {
-	.suspend	=3D mce_syscore_suspend,
-	.shutdown	=3D mce_syscore_shutdown,
 	.resume		=3D mce_syscore_resume,
 };
=20
@@ -2722,7 +2673,6 @@ static void mce_disable_cpu(void)
 	if (!cpuhp_tasks_frozen)
 		cmci_clear();
=20
-	vendor_disable_error_reporting();
 }
=20
 static void mce_reenable_cpu(void)
--=20
2.34.1


