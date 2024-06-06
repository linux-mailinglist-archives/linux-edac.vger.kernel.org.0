Return-Path: <linux-edac+bounces-1198-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1818FDECC
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 08:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4A0AB23452
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 06:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298E4770F9;
	Thu,  6 Jun 2024 06:36:28 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EE84A2D;
	Thu,  6 Jun 2024 06:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717655788; cv=none; b=teFj7cVcD60RZbaCblC//2U6OEfo99GBaE/tPiAScD8X6bb5ZP2KqyeGgVkqnXr3iJ8rCXrqGUTwDIbxj2HXQcHG1gAUAJy0MeuhU4N0YgDIM7/oGPne3YGFDoeIBeZdsXm2C6seu2/RLeK8aMBJ+kZR47PWFhpS/tWAv+Q2yAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717655788; c=relaxed/simple;
	bh=IzGMhXq7EqfxAeS3IOJb9arAgUoQiH99bBTiJqZPX0E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LPypPpK8JNlueLTT7xW0vPDXB9rp2pprwy1KncjKl3X9qvEmVwaiGeiVVrRiFPwQBbU8W9HQlSpIfJQK152gGv5+ZcIvq4M8+3m01IqM7Xz8Gim0vbcGwAT2TqeKr1I2RQHC4X8I1X7OOfqAPM8c6eY95bjhs9Yu5cRrLg9FPAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VvvdN6Xp3zwRV1;
	Thu,  6 Jun 2024 14:32:24 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 9EECF180085;
	Thu,  6 Jun 2024 14:36:22 +0800 (CST)
Received: from huawei.com (10.173.135.154) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 6 Jun
 2024 14:36:22 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <nao.horiguchi@gmail.com>, <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
Subject: [PATCH v2 00/13] Some cleanups for memory-failure
Date: Thu, 6 Jun 2024 14:32:34 +0800
Message-ID: <20240606063247.712575-1-linmiaohe@huawei.com>
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
This series contains a few cleanup patches to simplify unneeded function
variant, add helper macro, fix some obsolete comments and so on. More
details can be found in the respective changelogs.
Thanks!

Miaohe Lin (13):
  mm/memory-failure: simplify put_ref_page()
  mm/memory-failure: remove MF_MSG_SLAB
  mm/memory-failure: add macro GET_PAGE_MAX_RETRY_NUM
  mm/memory-failure: save some page_folio() calls
  mm/memory-failure: remove unneeded empty string
  mm/memory-failure: remove confusing initialization to count
  mm/memory-failure: simplify unneeded hwpoison_filter() variant
  mm/memory-failure: use helper macro task_pid_nr()
  mm/memory-failure: remove obsolete comment in unpoison_memory()
  mm/memory-failure: move some function declarations into internal.h
  mm/memory-failure: fix comment of get_hwpoison_page()
  mm/memory-failure: remove obsolete comment in kill_proc()
  mm/memory-failure: correct comment in me_swapcache_dirty

 include/linux/mm.h         |  8 -------
 include/linux/page-flags.h |  5 ----
 include/linux/rmap.h       |  2 --
 include/ras/ras_event.h    |  1 -
 mm/internal.h              | 10 ++++++++
 mm/memory-failure.c        | 48 +++++++++++++++-----------------------
 6 files changed, 29 insertions(+), 45 deletions(-)


base-commit: 19b8422c5bd56fb5e7085995801c6543a98bda1f
-- 
2.33.0


