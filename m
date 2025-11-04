Return-Path: <linux-edac+bounces-5311-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDEDC2F968
	for <lists+linux-edac@lfdr.de>; Tue, 04 Nov 2025 08:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF8C9189A97C
	for <lists+linux-edac@lfdr.de>; Tue,  4 Nov 2025 07:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D798A305972;
	Tue,  4 Nov 2025 07:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="rRFvaS8d"
X-Original-To: linux-edac@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F175328FFFB;
	Tue,  4 Nov 2025 07:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762240998; cv=none; b=Y9qNVQYOh/+elelLLw0ZntDTiCyqWtW777V/BCIMbLrpDGM9wauq+ZPx3f7tVpM1PLpcu2x8qR51oC8gj1xXqSvdoNqCcDd+TRvQoGr7vd8KxK0/Ur4BNQ9JzD9OqkGWcOCR/arVwngegbsdYzJBF1XPd8DtcHtr5AEaq0f82Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762240998; c=relaxed/simple;
	bh=3vVe7TDYnR9ehJ7D6C2tMAepXRSFgcke+mQsyT7GWCQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sGNI9E1LfGJvzuG2lrmyVurRpdxPwAh//34A0Q8skK/wWI+m8xRjxpD3+QUiIUQ/ovChPatQ43tzJYfR3f7qizLspTFOx5kZ0HRZcBy4t2mfyKD1fMBVM29kDbhIfD3pjH/CZJPkVjAgRQ2yJn+RYdfio7aERz4F13mtfZY9WNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=rRFvaS8d; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=NghPoVpU9F9TPfTZpSz+vCAG1iGPiKItcdvquhOQIn4=;
	b=rRFvaS8dJ0mRc4JzcbwoZpDYcsM59LP6EXUUKmiKOrxgiB0iiudwogcBujZwcoQpbPe7pATMf
	0l75qpkTRD2jQoXbGvabjU417w2lVBfvW0swG76sU3jj0Lv3+6XUo8y+QX31/VO4WfDJoNHjzAd
	6yMq/k3X8v/JfJWUEr1U41o=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4d10J254Ktzcb3X;
	Tue,  4 Nov 2025 15:21:38 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 5D9BA1402E9;
	Tue,  4 Nov 2025 15:23:13 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Nov 2025 15:23:12 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <david@redhat.com>, <dave.hansen@intel.com>, <bp@alien8.de>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <akpm@linux-foundation.org>, <lorenzo.stoakes@oracle.com>,
	<Liam.Howlett@oracle.com>, <vbabka@suse.cz>, <rppt@kernel.org>,
	<surenb@google.com>, <mhocko@suse.com>, <linmiaohe@huawei.com>,
	<nao.horiguchi@gmail.com>, <luto@kernel.org>, <peterz@infradead.org>,
	<tony.luck@intel.com>
CC: <x86@kernel.org>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-edac@vger.kernel.org>, <will@kernel.org>, <liaohua4@huawei.com>,
	<lilinjie8@huawei.com>, Xie Yuanbin <xieyuanbin1@huawei.com>
Subject: [PATCH v2 1/2] x86/mm: support memory-failure on 32-bits with SPARSEMEM
Date: Tue, 4 Nov 2025 15:23:05 +0800
Message-ID: <20251104072306.100738-2-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104072306.100738-1-xieyuanbin1@huawei.com>
References: <20251104072306.100738-1-xieyuanbin1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemj100009.china.huawei.com (7.202.194.3)

The historical commit d949f36f1865c60239d4 ("x86: Fix hwpoison code
related build failure on 32-bit NUMAQ"), disabled x86_32's
memory-failure when SPARSEMEM is enabled, because the number of
page-flags are insufficient.

The commit 46df8e73a4a3f1445f2a ("mm: free up PG_slab") removes PG_slab
flag that allows MEMORY_FAILURE to be enabled from here on.

The commit 09022bc196d23484a7a5 ("mm: remove PG_error") removes PG_error
flag.

The commit cceba6f7e46c48deca43 ("mm: add PG_dropbehind folio flag") add
PG_dropbehind flag, but MEMORY_FAILURE can still be enabled.

For the current version, for x86_32, when SPARSEMEM && HIGHMEM && X86_PAE
&& X86_PAT, the number of pageflags reaches its maximum value,
which is 31. Therefore, MEMORY_FAILURE can be safely enabled.

Signed-off-by: Xie Yuanbin <xieyuanbin1@huawei.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Dave Hansen <dave.hansen@intel.com>
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


