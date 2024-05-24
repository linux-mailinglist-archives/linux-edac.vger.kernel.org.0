Return-Path: <linux-edac+bounces-1117-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9088CE32E
	for <lists+linux-edac@lfdr.de>; Fri, 24 May 2024 11:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CE111C21BD2
	for <lists+linux-edac@lfdr.de>; Fri, 24 May 2024 09:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AB68626C;
	Fri, 24 May 2024 09:16:38 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4EC8565D;
	Fri, 24 May 2024 09:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716542198; cv=none; b=NBbd+IItrwa20XLzCNID6LCHSId/dbYUWj38gLUfpIHb2Sx5f1KyUO/JEykX7zheSlKNJZCSQXW47DICmfoFrucbyAGw1jpRhQrY7pFYUuMLh+MFs4GDGEYZc5ioreHJ/HuQ32AqeolIqjc94+bbJYiYfezI1zqVfJJktJIp47Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716542198; c=relaxed/simple;
	bh=ZqDUGoNqwZr9tSCJGpH3UTAdxs4ktSCRIfIdbyZA4oE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZLmHP2Yf0pecOuKITN0FMDOEeDIDZxXgx9xK/1L574lJyAraH3JZQxk5Nz86hojKM5swSztkMzdcZN0WVqEf9IHF/dYXrGQKpXFwrBX2cztQ4upw3CCTggCaVY4haIC5mHOWzK7XKejnS/sYNxOaoce7pk7iXpPK+1GeI/joiMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VlzpS5W1SzwPHB;
	Fri, 24 May 2024 17:12:48 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 8B0631400D1;
	Fri, 24 May 2024 17:16:29 +0800 (CST)
Received: from huawei.com (10.173.135.154) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 24 May
 2024 17:16:29 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <nao.horiguchi@gmail.com>, <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
Subject: [PATCH 07/13] mm/memory-failure: remove unneeded hwpoison_filter() variant
Date: Fri, 24 May 2024 17:13:04 +0800
Message-ID: <20240524091310.1430048-8-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240524091310.1430048-1-linmiaohe@huawei.com>
References: <20240524091310.1430048-1-linmiaohe@huawei.com>
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

When CONFIG_HWPOISON_INJECT is not enabled, there is no user of the
hwpoison_filter(). Remove it.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index be9bda281d91..2c3ecbfc2134 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -294,14 +294,8 @@ int hwpoison_filter(struct page *p)
 
 	return 0;
 }
-#else
-int hwpoison_filter(struct page *p)
-{
-	return 0;
-}
-#endif
-
 EXPORT_SYMBOL_GPL(hwpoison_filter);
+#endif
 
 /*
  * Kill all processes that have a poisoned page mapped and then isolate
-- 
2.33.0


