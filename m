Return-Path: <linux-edac+bounces-1203-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCBC8FDED5
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 08:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B95D2B2456C
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 06:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73EC13B5B9;
	Thu,  6 Jun 2024 06:36:29 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CCD71742;
	Thu,  6 Jun 2024 06:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717655789; cv=none; b=BeZZADlmraVgAP6gsL9aTZkDeAc6QkulI8mh28ZttcmhEQXbgGnMbMMQBevhZ0JKloqRsQeU9Pnz2TD0KbG3KoYZvxQwEo5U8tw7ydYuIQm1k7ajUDsprruq3IYqUm/TZu8fIGz4QKnhfAjhen7aDSYgEfGnrLSOprfrLi/crJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717655789; c=relaxed/simple;
	bh=aFmTDdL6f3Poyf65rZFKS5CZMuSGKoQ6Us/3IeLsbcg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RAOrP1uuxtIaVlwP99amr8h7SOFGamjgH2j+Ujo25g3qteD6HWaGNxCwgGoNGflLWjuOK7fhd6yBYSrIxizQ9pFTazNbhvZm73Ss7q/IVXgVWCQAiusl65R2bZEYuMZzqTsc8WL4KB60BH0T6YdUr1XKAkgX4Bu6weSx6PwsCyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VvvhN4h4DzdZNN;
	Thu,  6 Jun 2024 14:35:00 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 2B4EC14022D;
	Thu,  6 Jun 2024 14:36:25 +0800 (CST)
Received: from huawei.com (10.173.135.154) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 6 Jun
 2024 14:36:24 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <nao.horiguchi@gmail.com>, <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
Subject: [PATCH v2 05/13] mm/memory-failure: remove unneeded empty string
Date: Thu, 6 Jun 2024 14:32:39 +0800
Message-ID: <20240606063247.712575-6-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240606063247.712575-1-linmiaohe@huawei.com>
References: <20240606063247.712575-1-linmiaohe@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)

Remove unneeded empty string in definition of macro pr_fmt. No functional
change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 470c570d779c..ec482524158e 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2518,7 +2518,7 @@ static int __init memory_failure_init(void)
 core_initcall(memory_failure_init);
 
 #undef pr_fmt
-#define pr_fmt(fmt)	"" fmt
+#define pr_fmt(fmt)	fmt
 #define unpoison_pr_info(fmt, pfn, rs)			\
 ({							\
 	if (__ratelimit(rs))				\
-- 
2.33.0


