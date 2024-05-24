Return-Path: <linux-edac+bounces-1111-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A87668CE321
	for <lists+linux-edac@lfdr.de>; Fri, 24 May 2024 11:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03E5828197E
	for <lists+linux-edac@lfdr.de>; Fri, 24 May 2024 09:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3AD85640;
	Fri, 24 May 2024 09:16:36 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D3285260;
	Fri, 24 May 2024 09:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716542195; cv=none; b=O1uPQqnE8iLcFpjfguFFpSsbah5GmFT6jSJvJnc3W98m25zIBwEhr6wW0oLMzOcxnaGSwImUVekQ3SiN6X8X3q7CI2t2vBub50M60AdJ8h1hopVg1ZLylGZ1mY93cPXOtvRsr4PjcjLt7BK0aF85Iupvyoo8ZnZArlGlcPCsxU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716542195; c=relaxed/simple;
	bh=OxOlLFwntFTxrhHfNG8R6BPeycdVesbhAez+Ydgo82w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ARZI5Tazro2O/OOQSbts0QitvvELnXEgSqf2qh43KR6qCIu6Zz1DKkVXXQSCQRjjQXZzMCa7jZW2n0Ln13/nHrmBeRSY23Jc7RJphfyUFf2Xga/9yeIc7nJOmsZQoWl+QpYkoIYVMHmuZMejW/xa+GsHajRQcWl3mXf6Ehcebss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VlzpP2TjczwPHd;
	Fri, 24 May 2024 17:12:45 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 20A3E180A9C;
	Fri, 24 May 2024 17:16:26 +0800 (CST)
Received: from huawei.com (10.173.135.154) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 24 May
 2024 17:16:25 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <nao.horiguchi@gmail.com>, <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
Subject: [PATCH 00/13] Some cleanups for memory-failure
Date: Fri, 24 May 2024 17:12:57 +0800
Message-ID: <20240524091310.1430048-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
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

Hi everyone,
This series contains a few cleanup patches to remove unneeded function
variant, add helper macro, fix some obsolete comments and so on. More
details can be found in the respective changelogs.
Thanks!

Miaohe Lin (13):
  mm/memory-failure: simplify put_ref_page()
  mm/memory-failure: remove MF_MSG_SLAB
  mm/memory-failure: add macro GET_PAGE_MAX_RETRY_NUM
  mm/memory-failure: save a page_folio() call
  mm/memory-failure: remove unneeded empty string
  mm/memory-failure: remove confusing initialization to count
  mm/memory-failure: remove unneeded hwpoison_filter() variant
  mm/memory-failure: use helper macro task_pid_nr()
  mm/memory-failure: remove obsolete comment in unpoison_memory()
  mm/memory-failure: move some function declarations into internal.h
  mm/memory-failure: fix comment of get_hwpoison_page()
  mm/memory-failure: remove obsolete comment in kill_proc()
  mm/memory-failure: correct comment in me_swapcache_dirty

 include/linux/mm.h         | 14 ------------
 include/linux/page-flags.h |  5 ----
 include/linux/rmap.h       |  2 --
 include/ras/ras_event.h    |  1 -
 mm/internal.h              | 16 +++++++++++++
 mm/memory-failure.c        | 47 +++++++++++++-------------------------
 6 files changed, 32 insertions(+), 53 deletions(-)

-- 
2.33.0


