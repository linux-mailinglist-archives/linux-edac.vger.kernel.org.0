Return-Path: <linux-edac+bounces-1885-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C094597B801
	for <lists+linux-edac@lfdr.de>; Wed, 18 Sep 2024 08:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 393B1B294AB
	for <lists+linux-edac@lfdr.de>; Wed, 18 Sep 2024 06:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687B016B75C;
	Wed, 18 Sep 2024 06:37:25 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDEA166F1A
	for <linux-edac@vger.kernel.org>; Wed, 18 Sep 2024 06:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.110.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726641445; cv=none; b=N88e5WsJidFTe4Z2RHP2S+Ku2MuFg/jfIEBEAHCSGuEFq1eYI/dGutkHHWOylkH3chd9K+zLHDfHPxP/2K15m/3wEKjh61zZvTOW2D20GVklw/hFJ/gXOxZWwx/m1ao0F1ihq2an8IvWdoXNbjgBu6fm7BUIu7ceVG5j3Ru0Ics=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726641445; c=relaxed/simple;
	bh=N3aGBwdT9UYU+2MpqZLj3+mukv9VtWPnwBbWht+iH3U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EFT6i7FtPtQsv9Vf6ZrBc3zs8B55FcDsMNNal7yetRB9p6xr8MAi+WJeO+jMz9N+Zg0Ygf7M+iZZu/Lf+GBTgqVRnZdmsxcvfSNjQX1oQprIKBseasWpC8OoWQmFxmYSCPKhAkncjwvkqWBGqyUQVYcs2+BHphMYkKDPnFtKyxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=203.110.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1726641428-1eb14e31a710e7e0001-QCVQLf
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx2.zhaoxin.com with ESMTP id beNQjCALb4fPtFsj (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Wed, 18 Sep 2024 14:37:08 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXSHMBX2.zhaoxin.com (10.28.252.164) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 18 Sep
 2024 14:37:07 +0800
Received: from ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d]) by
 ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d%4]) with mapi id
 15.01.2507.039; Wed, 18 Sep 2024 14:37:07 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from localhost.localdomain (10.32.65.165) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Sep
 2024 13:54:35 +0800
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>
CC: <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>, <LeoLiu-oc@zhaoxin.com>,
	Lyle Li <LyleLi@zhaoxin.com>
Subject: [PATCH v3 0/3] x86/mce: Add Zhaoxin MCE support
Date: Wed, 18 Sep 2024 13:54:33 +0800
X-ASG-Orig-Subj: [PATCH v3 0/3] x86/mce: Add Zhaoxin MCE support
Message-ID: <20240918055436.15551-1-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240910092652.13354-1-TonyWWang-oc@zhaoxin.com>
References: <20240910092652.13354-1-TonyWWang-oc@zhaoxin.com>
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
X-Moderation-Data: 9/18/2024 2:37:06 PM
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1726641428
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1625
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.130611
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

From: Lyle Li <LyleLi@zhaoxin.com>

Zhaoxin consists of two vendors, X86_VENDOR_ZHAOXIN and
X86_VENDOR_CENTAUR, so add the centaur vendor to support
Zhaoxin MCA in mce/core.c and mce/intel.c.

For the sake of code standardization, add zhaoxin.c to
override the Zhaoxin MCA code.

Zhaoxin CPUs support CMCI compatible with Intel, because
Zhaoxin's UCR error is not reported through CMCI, and in
order to be compatible with intel's CMCI code, so add Zhaoxin
CMCI storm toggle to support the new CMCI storm switching
in mce/intel.c, mce/zhaoxin.c, mce/threshold.c, and mce/internal.h.

v2->v3:
 - Consolidate the MCA code for Zhaoxin and Centaur regarding the
   broadcast MCE configuration (patch 1/3, 2/3)

v1->v2:
 - Fix multiple definition of "mce_zhaoxin_feature_init" (patch 2/3)
 - Fix multiple definition of "mce_zhaoxin_feature_clear" (patch 2/3)
 - Fix multiple definition of "mce_zhaoxin_handle_storm" (patch 3/3)

Lyle Li (3):
  x86/mce: Add centaur vendor to support Zhaoxin MCA
  x86/mce: Add zhaoxin.c to support Zhaoxin MCA
  x86/mce: Add CMCI storm switching support for Zhaoxin

 arch/x86/Kconfig                    |  8 +++
 arch/x86/kernel/cpu/mce/Makefile    |  2 +-
 arch/x86/kernel/cpu/mce/core.c      | 69 ++++--------------------
 arch/x86/kernel/cpu/mce/intel.c     |  8 +--
 arch/x86/kernel/cpu/mce/internal.h  | 14 ++++-
 arch/x86/kernel/cpu/mce/threshold.c |  4 ++
 arch/x86/kernel/cpu/mce/zhaoxin.c   | 83 +++++++++++++++++++++++++++++
 7 files changed, 122 insertions(+), 66 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/mce/zhaoxin.c

--=20
2.34.1


