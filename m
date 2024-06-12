Return-Path: <linux-edac+bounces-1259-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC72904CA6
	for <lists+linux-edac@lfdr.de>; Wed, 12 Jun 2024 09:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9674E28610F
	for <lists+linux-edac@lfdr.de>; Wed, 12 Jun 2024 07:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B2616C6BD;
	Wed, 12 Jun 2024 07:22:55 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7371816C44C;
	Wed, 12 Jun 2024 07:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718176975; cv=none; b=XlUnpePKJ9akzt4bSNwVUEa9ZuboSvspRIQmlD9GsVjhNJL8Oo2YMhVQn1yBGC2ZqlmycJPosmA62wyyWnHBKSvOphbhmNbUDnbnihLO832zbjOQKFCA3TM21OfIMZnpAGPRT3zFSWv+yV+PtqED3Jph+jzG5mfwbqwCTNgVCxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718176975; c=relaxed/simple;
	bh=uVvWfICUrt4QEDDTU84xvZm4BajvZE6L2/1wby/hGYI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ShbsIvfTjeA8WeogVgVhN9xFKtJmguXtvvFNBARJcXe/suLHEaYfkvQlUZ1hhDyAFiJegKSDAhVzhkEuuZWjBCWmsHO1xYhA0DB5rlnI5tSqSpcZJkjAKIM7HIMjlwLT6jqclBN1Fao1eBFQS+sISbZXCnS4Lepw4JQ42QQGKTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VzcN66mtsz1JCn9;
	Wed, 12 Jun 2024 15:18:46 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 69F36180A9C;
	Wed, 12 Jun 2024 15:22:37 +0800 (CST)
Received: from huawei.com (10.173.127.72) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 12 Jun
 2024 15:22:22 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <nao.horiguchi@gmail.com>, <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
Subject: [PATCH v3 07/13] mm/memory-failure: don't export hwpoison_filter() when !CONFIG_HWPOISON_INJECT
Date: Wed, 12 Jun 2024 15:18:29 +0800
Message-ID: <20240612071835.157004-8-linmiaohe@huawei.com>
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

When CONFIG_HWPOISON_INJECT is not enabled, there is no user of the
hwpoison_filter() outside memory-failure. So there is no need to export
it in that case.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406070136.hGQwVbsv-lkp@intel.com/
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 339752d768d8..ee6ec63534b7 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -294,6 +294,7 @@ int hwpoison_filter(struct page *p)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(hwpoison_filter);
 #else
 int hwpoison_filter(struct page *p)
 {
@@ -301,8 +302,6 @@ int hwpoison_filter(struct page *p)
 }
 #endif
 
-EXPORT_SYMBOL_GPL(hwpoison_filter);
-
 /*
  * Kill all processes that have a poisoned page mapped and then isolate
  * the page.
-- 
2.33.0


