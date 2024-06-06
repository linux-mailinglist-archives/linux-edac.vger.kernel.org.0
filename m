Return-Path: <linux-edac+bounces-1204-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AED8FDED6
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 08:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 034A9B245F0
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 06:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA45D13B7A7;
	Thu,  6 Jun 2024 06:36:29 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B93373465;
	Thu,  6 Jun 2024 06:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717655789; cv=none; b=p/uTnXHV3bZUprU+712vNCIsJppjmCKjvuOEcXEhETq8/tLt3zNGOUzdXmpBGG8+/CqldNdd8TwOec/IvAAs8culkCWHbwPJJ42z67kzzDjH/fH1SBLNvUok3UxXiqZttfFQBKwXHp4TX9SZIyKWiJiioM8Q4myMaNtLxTA6pEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717655789; c=relaxed/simple;
	bh=WHHs7idYRzoEGuXmcyZ8bcVwyBbgz6mH+0HZTrbe8Vs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hpy5TyiEJxhRWpdtI0i+p7OmMrNEznF3N+lZzYykTE7bizJtI57dD19OjEF6zlU57wLOuLSxO5ojjTON+NF7F7UkX0s0Xe05lsq0fHDwv5uHxDBJ4qLdPZW8UkoSMlCpWwtYIP6ryQ6Wkkl+KlKlZfb+FjeNCZWCT2XZgjbZGHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4VvvhT19Fgz1xsBF;
	Thu,  6 Jun 2024 14:35:05 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id AFA62140109;
	Thu,  6 Jun 2024 14:36:25 +0800 (CST)
Received: from huawei.com (10.173.135.154) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 6 Jun
 2024 14:36:25 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <nao.horiguchi@gmail.com>, <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
Subject: [PATCH v2 06/13] mm/memory-failure: remove confusing initialization to count
Date: Thu, 6 Jun 2024 14:32:40 +0800
Message-ID: <20240606063247.712575-7-linmiaohe@huawei.com>
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

It's meaningless and confusing to init local variable count to 1.
Remove it. No functional change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index ec482524158e..339752d768d8 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2542,7 +2542,7 @@ int unpoison_memory(unsigned long pfn)
 	struct folio *folio;
 	struct page *p;
 	int ret = -EBUSY, ghp;
-	unsigned long count = 1;
+	unsigned long count;
 	bool huge = false;
 	static DEFINE_RATELIMIT_STATE(unpoison_rs, DEFAULT_RATELIMIT_INTERVAL,
 					DEFAULT_RATELIMIT_BURST);
-- 
2.33.0


