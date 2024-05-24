Return-Path: <linux-edac+bounces-1114-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3908CE327
	for <lists+linux-edac@lfdr.de>; Fri, 24 May 2024 11:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFFEC1F22830
	for <lists+linux-edac@lfdr.de>; Fri, 24 May 2024 09:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C368592F;
	Fri, 24 May 2024 09:16:36 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DD385627;
	Fri, 24 May 2024 09:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716542196; cv=none; b=Qh/PuP6MWZh+w8e3/R+DhB7DLAIEPTPQwGeAZry57hVQCRIeflswQA6tMdTQn5XeOBUcwHZP95o/mtb3g+yBjLW8lJ2e4htCzqPluL1uV//WUklHI+y6JylcLf+ayshFt246V3xF8Qzd4oWZTYkOprblNQjQBBWktJ4g2KBo14w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716542196; c=relaxed/simple;
	bh=BJQ5Y1QVIHcM4l7Cvr2CsSiO6VipPHGeGZ8/aYXJXLI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pON9eNMvzPzTNblYGpYnhFfgw2NJeH+wRqRGc8ogqr/0ouh1bT3JjCZ385qIIdNMKJEPPM7gw7H/VbunkXqAFqEuXr9trtGdgeTGqWd9oD1+VvTpDcTS1woblimM6bEOxysmGO+TIOdU/yVAYDHThE/2JQm5tMn/LDG3vU/Tvrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VlzpQ5VQJzwPF9;
	Fri, 24 May 2024 17:12:46 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 8A84A18007E;
	Fri, 24 May 2024 17:16:27 +0800 (CST)
Received: from huawei.com (10.173.135.154) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 24 May
 2024 17:16:27 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <nao.horiguchi@gmail.com>, <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
Subject: [PATCH 03/13] mm/memory-failure: add macro GET_PAGE_MAX_RETRY_NUM
Date: Fri, 24 May 2024 17:13:00 +0800
Message-ID: <20240524091310.1430048-4-linmiaohe@huawei.com>
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

Add helper macro GET_PAGE_MAX_RETRY_NUM to replace magic number 3.
No functional change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 9c23adceee75..b571aaf987a2 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1446,6 +1446,8 @@ static int __get_hwpoison_page(struct page *page, unsigned long flags)
 	return 0;
 }
 
+#define GET_PAGE_MAX_RETRY_NUM 3
+
 static int get_any_page(struct page *p, unsigned long flags)
 {
 	int ret = 0, pass = 0;
@@ -1460,12 +1462,12 @@ static int get_any_page(struct page *p, unsigned long flags)
 		if (!ret) {
 			if (page_count(p)) {
 				/* We raced with an allocation, retry. */
-				if (pass++ < 3)
+				if (pass++ < GET_PAGE_MAX_RETRY_NUM)
 					goto try_again;
 				ret = -EBUSY;
 			} else if (!PageHuge(p) && !is_free_buddy_page(p)) {
 				/* We raced with put_page, retry. */
-				if (pass++ < 3)
+				if (pass++ < GET_PAGE_MAX_RETRY_NUM)
 					goto try_again;
 				ret = -EIO;
 			}
@@ -1491,7 +1493,7 @@ static int get_any_page(struct page *p, unsigned long flags)
 		 * A page we cannot handle. Check whether we can turn
 		 * it into something we can handle.
 		 */
-		if (pass++ < 3) {
+		if (pass++ < GET_PAGE_MAX_RETRY_NUM) {
 			put_page(p);
 			shake_page(p);
 			count_increased = false;
-- 
2.33.0


