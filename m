Return-Path: <linux-edac+bounces-1253-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F001B904C95
	for <lists+linux-edac@lfdr.de>; Wed, 12 Jun 2024 09:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2E8D1C22949
	for <lists+linux-edac@lfdr.de>; Wed, 12 Jun 2024 07:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E65169ACF;
	Wed, 12 Jun 2024 07:22:25 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8A712F5A1;
	Wed, 12 Jun 2024 07:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718176945; cv=none; b=OSQ6l4vS8AXukll+mx+lWC+eYyirVOHQALcULCipmjPM6wG57BBt2WO3P0yvQA3CyfYJcJNh4nDztfYJlqu01SHX21vKxvcvYgsDNcCNpgfrPS7Fk0Z0Z22EcLcdALE5wzusMk97Q912ZvDzmbDdm6QblCYmVyE8js8LuCGn8X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718176945; c=relaxed/simple;
	bh=LpCilvrxxf8tM9GGSPfQXv0XzkTIE5c7P5qRmJ7Ugoo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EGDPvOKa3aThVwwPp8fYvV4frwlNwpDKIG1o1brH8VOGk28lmSHS5iS4K+B8/KjHf2peMO4/7NkuaTMsLOdglJ+aH/vsG02mjMaWlqtn3efC32EQ5jxe6KR8lgb2q5guUSusiMT4XR/7PpCS7BYWu0MPfyVa+fNOOz5lpaVYLgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VzcMW2kkSz1JCg2;
	Wed, 12 Jun 2024 15:18:15 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id D6827180AA6;
	Wed, 12 Jun 2024 15:22:20 +0800 (CST)
Received: from huawei.com (10.173.127.72) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 12 Jun
 2024 15:22:20 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <nao.horiguchi@gmail.com>, <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
Subject: [PATCH v3 03/13] mm/memory-failure: add macro GET_PAGE_MAX_RETRY_NUM
Date: Wed, 12 Jun 2024 15:18:25 +0800
Message-ID: <20240612071835.157004-4-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240612071835.157004-1-linmiaohe@huawei.com>
References: <20240612071835.157004-1-linmiaohe@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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


