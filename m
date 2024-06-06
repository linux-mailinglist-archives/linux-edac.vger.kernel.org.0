Return-Path: <linux-edac+bounces-1202-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E698FDED4
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 08:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA4BB288301
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 06:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B9013B2BC;
	Thu,  6 Jun 2024 06:36:29 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9055440BE5;
	Thu,  6 Jun 2024 06:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717655789; cv=none; b=agao5Xn0+PpDtYuJ0WCjqaBibyXA2Ioa4/6gIKs4YEWNOR1KtCJ7nbXwxz88gOe/nrePb7TrO+nOsxbmBeHWMLVosEMGGHcfQklhBy+Oq3WHNGRc2/Y9OPQ4e2dezhgFVZ7PGBz4UI/Fi/ZB4UStE0aLPAzSne0yH99i2oEw8YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717655789; c=relaxed/simple;
	bh=LpCilvrxxf8tM9GGSPfQXv0XzkTIE5c7P5qRmJ7Ugoo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YqHmum8zH9cBn5yI4IRfLOGTUFCRixJhJ2nvhj/hu1DzdBpNY68OyoNkFz3w0QWCnDiYjkAZHHmjiePhTj7LG/UPgygnv5b5BIixp9sVr6WPH/JeHs9bCCHnfWJBpX5u59dhAr/d72h49RrzDUFPdgXB8GFLFICJOYA9tvRdhvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Vvvf95PB3zPpZH;
	Thu,  6 Jun 2024 14:33:05 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 16305140133;
	Thu,  6 Jun 2024 14:36:24 +0800 (CST)
Received: from huawei.com (10.173.135.154) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 6 Jun
 2024 14:36:23 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <nao.horiguchi@gmail.com>, <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
Subject: [PATCH v2 03/13] mm/memory-failure: add macro GET_PAGE_MAX_RETRY_NUM
Date: Thu, 6 Jun 2024 14:32:37 +0800
Message-ID: <20240606063247.712575-4-linmiaohe@huawei.com>
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

Add helper macro GET_PAGE_MAX_RETRY_NUM to replace magic number 3.
No functional change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 4b9a9298d478..958b17a4b0f5 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1417,6 +1417,8 @@ static int __get_hwpoison_page(struct page *page, unsigned long flags)
 	return 0;
 }
 
+#define GET_PAGE_MAX_RETRY_NUM 3
+
 static int get_any_page(struct page *p, unsigned long flags)
 {
 	int ret = 0, pass = 0;
@@ -1431,12 +1433,12 @@ static int get_any_page(struct page *p, unsigned long flags)
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
@@ -1462,7 +1464,7 @@ static int get_any_page(struct page *p, unsigned long flags)
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


