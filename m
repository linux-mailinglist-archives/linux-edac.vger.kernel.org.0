Return-Path: <linux-edac+bounces-1210-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D54A18FDEE4
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 08:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 701B1B261F7
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 06:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958CF140360;
	Thu,  6 Jun 2024 06:36:35 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD50713F435;
	Thu,  6 Jun 2024 06:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717655795; cv=none; b=Rp0//g/QVsZFyQwiN7MevsU8VLSU4LtqImWPflYr2uEKw6vXmYbVx3PsGnEe4s5Hs+cAWdKwy1EuUhpbI6x7BCK+LEcIQp8E/dN4v8JZDkpHobKH1KKn4kLVTZ4aWVxo6F6z7E4ck0avCK5ZeU8n53QQy7Yrzq+BcnVp9mU68Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717655795; c=relaxed/simple;
	bh=Gl+/Teo62MITkwyXyaudIOLUGLTPymPDotTKCGfkDLw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=atY3WqLCcHV0qYJulbpeUAx6dhJHtQO71IObVrN8J7OrQR2FecXLV3sb9SLkoZDSzC5a6kdALEoXN5djwGrIfdZ+B/P/8fJJNBAiWW0gzcNEOCl4N002t1+GuhuuFREmQbl1hwlskYHmzMj7PVWcQxoXNuIwLEXv7hzIBGb26TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Vvvdl5g3Fz1S6Hn;
	Thu,  6 Jun 2024 14:32:43 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 447E9140109;
	Thu,  6 Jun 2024 14:36:26 +0800 (CST)
Received: from huawei.com (10.173.135.154) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 6 Jun
 2024 14:36:25 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <nao.horiguchi@gmail.com>, <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
Subject: [PATCH v2 07/13] mm/memory-failure: simplify unneeded hwpoison_filter() variant
Date: Thu, 6 Jun 2024 14:32:41 +0800
Message-ID: <20240606063247.712575-8-linmiaohe@huawei.com>
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

When CONFIG_HWPOISON_INJECT is not enabled, there is no user of the
hwpoison_filter() outside memory-failure. So there is no need to export
it and we can further make it 'static' and 'inline'.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202405242336.o1NEOrln-lkp@intel.com/
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 339752d768d8..6e26b8b975e5 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -294,15 +294,14 @@ int hwpoison_filter(struct page *p)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(hwpoison_filter);
 #else
-int hwpoison_filter(struct page *p)
+static inline int hwpoison_filter(struct page *p)
 {
 	return 0;
 }
 #endif
 
-EXPORT_SYMBOL_GPL(hwpoison_filter);
-
 /*
  * Kill all processes that have a poisoned page mapped and then isolate
  * the page.
-- 
2.33.0


