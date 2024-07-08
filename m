Return-Path: <linux-edac+bounces-1451-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A23929B03
	for <lists+linux-edac@lfdr.de>; Mon,  8 Jul 2024 05:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21DC72811E7
	for <lists+linux-edac@lfdr.de>; Mon,  8 Jul 2024 03:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E90C4685;
	Mon,  8 Jul 2024 03:10:21 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AFD803;
	Mon,  8 Jul 2024 03:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720408221; cv=none; b=p56Nd/JlCdI1JjUXLxC0KthCBaxO4a90Z5b8plHJPtQMx7YyQaSGAtUcQDD7Xx4OOx9/EA9mEWX9/vT7rq+Whx90Zu12WQdjGKW9+kzLdKwui/L6/kED/l4Xy4LOW9D0UNO5spxlXm9aK91aXKhN5M7AKIT8v/104eIp132Wfkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720408221; c=relaxed/simple;
	bh=6QRBZZnKzv5EfLA6Znk0did6tqxKKmiAfCm/PptubKQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uKpkr8m/U8nkDgJDo8poWw9fWM2gsBf0o2UE9M3rvwg1D0nsEavCUWhT7zEFmW9g+qtc5kGvwLBq7HfnQvg+K6/OuC0NMGS3x8y1vJbMBj6sOcILZxjDURRyvyHumTciQ9i834VfRgfCXdPr5/eq7RvNoPT7jjbhRI+IltjwSnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WHTWz4ZyXzwWJg;
	Mon,  8 Jul 2024 11:05:35 +0800 (CST)
Received: from kwepemd200019.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id 47D81140F65;
	Mon,  8 Jul 2024 11:10:15 +0800 (CST)
Received: from huawei.com (10.173.127.72) by kwepemd200019.china.huawei.com
 (7.221.188.193) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 8 Jul
 2024 11:10:14 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>
CC: <tony.luck@intel.com>, <bp@alien8.de>, <nao.horiguchi@gmail.com>,
	<linmiaohe@huawei.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>
Subject: [PATCH] mm/memory-failure: remove obsolete MF_MSG_DIFFERENT_COMPOUND
Date: Mon, 8 Jul 2024 11:05:44 +0800
Message-ID: <20240708030544.196919-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200019.china.huawei.com (7.221.188.193)

The page cannot become compound pages again just after folio is splited
as extra refcnt is held. So MF_MSG_DIFFERENT_COMPOUND case is obsolete and
could be removed to get rid of this false assumption and code burden. But
add one WARN_ON() here to keep the scene clear.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/ras/ras_event.h |  1 -
 mm/memory-failure.c     | 19 +++----------------
 2 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index 9bc707fe8819..e5f7ee0864e7 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -356,7 +356,6 @@ TRACE_EVENT(aer_event,
 #define MF_PAGE_TYPE		\
 	EM ( MF_MSG_KERNEL, "reserved kernel page" )			\
 	EM ( MF_MSG_KERNEL_HIGH_ORDER, "high-order kernel page" )	\
-	EM ( MF_MSG_DIFFERENT_COMPOUND, "different compound page after locking" ) \
 	EM ( MF_MSG_HUGE, "huge page" )					\
 	EM ( MF_MSG_FREE_HUGE, "free huge page" )			\
 	EM ( MF_MSG_GET_HWPOISON, "get hwpoison page" )			\
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 16f8651436d5..581d3e5c9117 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -919,7 +919,6 @@ static const char *action_name[] = {
 static const char * const action_page_types[] = {
 	[MF_MSG_KERNEL]			= "reserved kernel page",
 	[MF_MSG_KERNEL_HIGH_ORDER]	= "high-order kernel page",
-	[MF_MSG_DIFFERENT_COMPOUND]	= "different compound page after locking",
 	[MF_MSG_HUGE]			= "huge page",
 	[MF_MSG_FREE_HUGE]		= "free huge page",
 	[MF_MSG_GET_HWPOISON]		= "get hwpoison page",
@@ -2349,22 +2348,10 @@ int memory_failure(unsigned long pfn, int flags)
 
 	/*
 	 * We're only intended to deal with the non-Compound page here.
-	 * However, the page could have changed compound pages due to
-	 * race window. If this happens, we could try again to hopefully
-	 * handle the page next round.
+	 * The page cannot become compound pages again as folio has been
+	 * splited and extra refcnt is held.
 	 */
-	if (folio_test_large(folio)) {
-		if (retry) {
-			ClearPageHWPoison(p);
-			folio_unlock(folio);
-			folio_put(folio);
-			flags &= ~MF_COUNT_INCREASED;
-			retry = false;
-			goto try_again;
-		}
-		res = action_result(pfn, MF_MSG_DIFFERENT_COMPOUND, MF_IGNORED);
-		goto unlock_page;
-	}
+	WARN_ON(folio_test_large(folio));
 
 	/*
 	 * We use page flags to determine what action should be taken, but
-- 
2.33.0


