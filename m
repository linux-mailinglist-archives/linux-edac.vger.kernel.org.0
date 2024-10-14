Return-Path: <linux-edac+bounces-2027-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1F099C2A0
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 10:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CC001C23FF6
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 08:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1457B14B965;
	Mon, 14 Oct 2024 08:09:53 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6171F149C7A
	for <linux-edac@vger.kernel.org>; Mon, 14 Oct 2024 08:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728893393; cv=none; b=P77cCC5ez6VWgpcO9znsJ8tDRKzaXxQlgtY7Xfsh35Sxnf2f3PfHBsNYovKdkThTj8LspnkO8QqPSkC3YqmZ3YS/Fza+LYtu+y1CX2hK9F6PybM3EomfBj4YyHE41va5n4VPYSi6pPI3ERb8OPER1seizM7Y3yChHBB5Wfjl6cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728893393; c=relaxed/simple;
	bh=lmdKs9zSLSWdPcx2HQ1T4PArqLXL/2JVOcmE+HMRI4g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ly+v9kk/WQtdYkO+ZHwTLydr/8jUoe3oc3XiSXRYsef1axRKCsU4C7M0/yVXW/U2/l45tXWJxaQbwsbW7Un7z8kazFmRlACCUDhYl3w2D21BVFv2ykJhPnUTDut8idr/d7X13IXu6b2RJaiYRKejbFqRkbIDUXcJ0aOmt8Xkdv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1728893372-086e23455a01f30001-QCVQLf
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx1.zhaoxin.com with ESMTP id ghRR1QVVergP57ov (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 14 Oct 2024 16:09:32 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 14 Oct
 2024 16:09:31 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::3066:e339:e3d6:5264]) by
 ZXSHMBX1.zhaoxin.com ([fe80::3066:e339:e3d6:5264%7]) with mapi id
 15.01.2507.039; Mon, 14 Oct 2024 16:09:31 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from localhost.localdomain (10.32.65.165) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Oct
 2024 15:53:06 +0800
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <qiuxu.zhuo@intel.com>
CC: <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>, <LeoLiu-oc@zhaoxin.com>,
	Lyle Li <LyleLi@zhaoxin.com>
Subject: [PATCH v5 0/4] x86/mce: Add Zhaoxin MCE support and remove functions that disable error reporting
Date: Mon, 14 Oct 2024 15:53:14 +0800
X-ASG-Orig-Subj: [PATCH v5 0/4] x86/mce: Add Zhaoxin MCE support and remove functions that disable error reporting
Message-ID: <20241014075318.1936-1-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240923073311.4290-1-TonyWWang-oc@zhaoxin.com>
References: <20240923073311.4290-1-TonyWWang-oc@zhaoxin.com>
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
X-Moderation-Data: 10/14/2024 4:09:30 PM
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1728893372
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2036
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.131784
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

From: Lyle Li <LyleLi@zhaoxin.com>

Zhaoxin consists of two vendors, X86_VENDOR_ZHAOXIN and
X86_VENDOR_CENTAUR. Add the missing Centaur vendor to
support Zhaoxin MCA.

Since all major vendors do not disable MCA_CTL after initialization,
remove the functions that disable error reporting.

For the sake of code standardization, add zhaoxin.c to
override the Zhaoxin MCA code.

Zhaoxin CPUs support CMCI which is compatible with Intel, but
their UCR errors are not reported through CMCI like Intel's. To
be compatible with intel's CMCI code, add Zhaoxin's specific
CMCI storm toggle.

v4->v5:
 - Simplify the commit message (patch 1/4)
 - Modify the commit message (patch 2/4)
 - Simplify the code comments and modify the compilation order in the
   Makefile (patch 3/4)
 - Simplify the commit message and modify the order of header file
   imports (patch 4/4)

v3->v4:
 - Remove functions that disable error reporting (patch 2/4)

v2->v3:
 - Consolidate the MCA code for Zhaoxin and Centaur regarding the
   broadcast MCE configuration (patch 3/4)

v1->v2:
 - Fix multiple definition of "mce_zhaoxin_feature_init" (patch 3/4)
 - Fix multiple definition of "mce_zhaoxin_feature_clear" (patch 3/4)
 - Fix multiple definition of "mce_zhaoxin_handle_storm" (patch 4/4)

Lyle Li (4):
  x86/mce: Add Centaur vendor to support Zhaoxin MCA
  x86/mce: Remove functions that disable error reporting
  x86/mce: Add zhaoxin.c to support Zhaoxin MCA
  x86/mce: Add CMCI storm switching support for Zhaoxin

 arch/x86/Kconfig                    |   8 ++
 arch/x86/kernel/cpu/mce/Makefile    |   1 +
 arch/x86/kernel/cpu/mce/core.c      | 116 ++--------------------------
 arch/x86/kernel/cpu/mce/intel.c     |   8 +-
 arch/x86/kernel/cpu/mce/internal.h  |  14 ++++
 arch/x86/kernel/cpu/mce/threshold.c |   4 +
 arch/x86/kernel/cpu/mce/zhaoxin.c   |  82 ++++++++++++++++++++
 7 files changed, 120 insertions(+), 113 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/mce/zhaoxin.c

--=20
2.34.1


