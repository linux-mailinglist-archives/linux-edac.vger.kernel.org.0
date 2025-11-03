Return-Path: <linux-edac+bounces-5289-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F399C29F85
	for <lists+linux-edac@lfdr.de>; Mon, 03 Nov 2025 04:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9FD53AF629
	for <lists+linux-edac@lfdr.de>; Mon,  3 Nov 2025 03:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DAC1C6FE8;
	Mon,  3 Nov 2025 03:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="cAsCMg1B"
X-Original-To: linux-edac@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E221E1339B1;
	Mon,  3 Nov 2025 03:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762140958; cv=none; b=bldSJQNTbCEoJKFWPS3PjoDFK6s1I/u5q/B9+57p+OZ9bSqgvyiNtxkO9WytlZPUOiLr15UKOE1B1CoV4vZdgPQgtb/Ng2ttceWSbJ9QQS72U+p7+2bFzeRnYKMpHdT+3dofzkPhO3GLekwYIp/2cps8dSgcsKjElKeuYFnsC/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762140958; c=relaxed/simple;
	bh=6SFg1x6PoSrmi6rv0iLomf8vqw2/CViQpjBOtbhVtz4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OF1r+9T8v1kkHA7+1+tJg7wfO1akBTAZFOGuFWk12+sx7rMnorBf6LNGKLBaCJLrQ9Lm6IDw88dJ+Wj/pYl2KabBHz+aF0G2md7oZhc7brQ5wlAdwmv+zQb87yivwF+QUncQ7QmR72p6m+qII3Dp/RVfbRTS+84/ULISWUbNH/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=cAsCMg1B; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=5iAlRuAIsi2GE5ItcdrGuYTZod15rl8M0hhAckNHMcs=;
	b=cAsCMg1BrDm96i8ognht4vAKSaZKt8SVQAMotpszTJBJw3IMv69XAQmpy1g5RnlhCc2rIjwzt
	gXbsfEiX7W4ucdEJCpVZk59tAx3Xu8OTPFH61xGh3ZdGoquc2Z3PrYVIwpxPVPxTNV+VtESZRrv
	ODY/L0Sak3nX9dqGFpx0wgg=
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4d0HJ63dr3zmV8P;
	Mon,  3 Nov 2025 11:34:14 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 7950E140277;
	Mon,  3 Nov 2025 11:35:48 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 3 Nov 2025 11:35:47 +0800
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
Subject: [PATCH 2/2] mm/memory-failure: remove the selection of RAS
Date: Mon, 3 Nov 2025 11:35:36 +0800
Message-ID: <20251103033536.52234-2-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103033536.52234-1-xieyuanbin1@huawei.com>
References: <20251103033536.52234-1-xieyuanbin1@huawei.com>
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

The commit 97f0b13452198290799f ("tracing: add trace event for
memory-failure") introduces the selection of RAS in memory-failure.
This commit is just a tracing feature; in reality, there is no dependency
between memory-failure and RAS. RAS increases the size of the bzImage
image by 8k, which is very valuable for embedded devices.

Signed-off-by: Xie Yuanbin <xieyuanbin1@huawei.com>
---
 mm/Kconfig          | 1 -
 mm/memory-failure.c | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index a5a90b169435..c3a8e0ba1ac1 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -738,11 +738,10 @@ config ARCH_SUPPORTS_MEMORY_FAILURE
 
 config MEMORY_FAILURE
 	depends on MMU
 	depends on ARCH_SUPPORTS_MEMORY_FAILURE
 	bool "Enable recovery from hardware memory errors"
-	select RAS
 	help
 	  Enables code to recover from some memory failures on systems
 	  with MCA recovery. This allows a system to continue running
 	  even when some of its memory has uncorrected errors. This requires
 	  special hardware support and typically ECC memory.
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index f698df156bf8..baf2bd79b2fb 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1276,11 +1276,13 @@ static void update_per_node_mf_stats(unsigned long pfn,
  * setting PG_dirty outside page lock. See also comment above set_page_dirty().
  */
 static int action_result(unsigned long pfn, enum mf_action_page_type type,
 			 enum mf_result result)
 {
+#ifdef CONFIG_RAS
 	trace_memory_failure_event(pfn, type, result);
+#endif
 
 	if (type != MF_MSG_ALREADY_POISONED) {
 		num_poisoned_pages_inc(pfn);
 		update_per_node_mf_stats(pfn, result);
 	}
-- 
2.51.0


