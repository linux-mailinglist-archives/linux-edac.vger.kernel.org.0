Return-Path: <linux-edac+bounces-5288-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BD9C29F7F
	for <lists+linux-edac@lfdr.de>; Mon, 03 Nov 2025 04:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A2A84E43E2
	for <lists+linux-edac@lfdr.de>; Mon,  3 Nov 2025 03:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486821684B0;
	Mon,  3 Nov 2025 03:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="pDisz5Xi"
X-Original-To: linux-edac@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730439460;
	Mon,  3 Nov 2025 03:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762140950; cv=none; b=ZKODkE3yaS17eBcmrZt5YabhvcQIPf9CGD6OntybDUYq7TH6SWBg4wMEKF7Q6/TfJbnRMv6x1Zl+9GL+pg2HyjDPzLjM0rxsR9MHdHon4PDFnG8kNf+XGyMVdA+ocCxueKUOJnofZpkzaxGhKuQY5FYoJOaG/4bBMz7PYRBbJYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762140950; c=relaxed/simple;
	bh=htqHMTR5Sa0nfFEJJAmSbj389BAc9SCsx1/agIbMhow=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MMnab+OAOHJq/P1KnsC7k8TxPj7zSf8paABYauasQQkV9Rwp9aF8fR1yAmTfj7NFBcwsKP8btbJ8Krj3JztEOYA7woqVD03QnDJGawGogRq10s6DxWzyOmFrH1r34Jwmi8nBgcfsj5XH1T3ZmOx16dkqJLOIry6dGjhTgyiXFOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=pDisz5Xi; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=WPxs96Hs/koLnIBv2CHx6Mog13FyM3+Pfhd5CDpvcDQ=;
	b=pDisz5Xis5C/jNgPZPCj4fd73OzkDQPHOjqPBdGsn5EocB4cKbPdWwXHji3iShhaxUFcN5oJa
	RpWFYbFWrrmpd8ulEATo1MF23QHDhANbAHoAI26Fyd0tm0Y1IGIEGbI/RpaD4zQjFMUpPMecuqr
	jFdaCtWi8qv6+sLvpAPM4ag=
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4d0HJ126Ycz1cyNp;
	Mon,  3 Nov 2025 11:34:09 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 7A92C18001B;
	Mon,  3 Nov 2025 11:35:43 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 3 Nov 2025 11:35:42 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<david@redhat.com>, <lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>,
	<vbabka@suse.cz>, <rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>,
	<linmiaohe@huawei.com>, <nao.horiguchi@gmail.com>, <luto@kernel.org>,
	<peterz@infradead.org>, <tony.luck@intel.com>
CC: <x86@kernel.org>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-edac@vger.kernel.org>, <will@kernel.org>, <liaohua4@huawei.com>,
	<lilinjie8@huawei.com>, Xie Yuanbin <xieyuanbin1@huawei.com>
Subject: [PATCH 1/2] x86/mm: support memory-failure on 32-bits with SPARSEMEM
Date: Mon, 3 Nov 2025 11:35:35 +0800
Message-ID: <20251103033536.52234-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemj100009.china.huawei.com (7.202.194.3)

The historical commit d949f36f1865c60239d4 ("x86: Fix hwpoison code
related build failure on 32-bit NUMAQ"), disabled x86_32's
memory-failure when SPARSEMEM is enabled, because the number of
page-flags are insufficient.

The commit 09022bc196d23484a7a5 ("mm: remove PG_error") removes a
page flag, so memory-failure can now be enable now.

Signed-off-by: Xie Yuanbin <xieyuanbin1@huawei.com>
---
 arch/x86/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d55c01efd7c2..f9ee57a55500 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -750,13 +750,10 @@ config IOSF_MBI_DEBUG
 
 config X86_SUPPORTS_MEMORY_FAILURE
 	def_bool y
 	# MCE code calls memory_failure():
 	depends on X86_MCE
-	# On 32-bit this adds too big of NODES_SHIFT and we run out of page flags:
-	# On 32-bit SPARSEMEM adds too big of SECTIONS_WIDTH:
-	depends on X86_64 || !SPARSEMEM
 	select ARCH_SUPPORTS_MEMORY_FAILURE
 
 config X86_32_IRIS
 	tristate "Eurobraille/Iris poweroff module"
 	depends on X86_32
-- 
2.51.0


