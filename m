Return-Path: <linux-edac+bounces-1255-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6A5904C99
	for <lists+linux-edac@lfdr.de>; Wed, 12 Jun 2024 09:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96BC21C22DB0
	for <lists+linux-edac@lfdr.de>; Wed, 12 Jun 2024 07:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AE116C86C;
	Wed, 12 Jun 2024 07:22:29 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF6F16C86A;
	Wed, 12 Jun 2024 07:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718176949; cv=none; b=kkVNnf2Aw8umlBJg8nBStEWXcgnBQ67VBHOVvbfir62lASaFDyc3XhGR6Jb3S6WRTQDwHGweGj66kb6adAq+xYnd/QbaVrQrI1YdAPMnfIt6vH7ynV40zFCeEdRUHnbRg3q29jgDP/jHCnEAJbyez5FCL4xefV0sHjE0DKGkd3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718176949; c=relaxed/simple;
	bh=7XkyMNNVFbwIywmIqmH+fmp6s2CF96J+4RJhXNaHaj0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L9yiY7wuyl2Nta9vqJxUNS3FvW1sX63lM2fxoQvdxfpOj+H1YPj08rG4o8J5wzkMkuQ3Et20hyM3oRebD12vSwmecpX99iDniDywDayvgJWeupjHVv8ZeB91nzjcz8BN9AjD+S1p0NDhh5nT+M7qz6fB9ZI0srsELHdMYhPWt7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4VzcMq4TN0z1X3YJ;
	Wed, 12 Jun 2024 15:18:31 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 6ADD3140360;
	Wed, 12 Jun 2024 15:22:19 +0800 (CST)
Received: from huawei.com (10.173.127.72) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 12 Jun
 2024 15:22:18 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <nao.horiguchi@gmail.com>, <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
Subject: [PATCH v3 00/13] Some cleanups for memory-failure
Date: Wed, 12 Jun 2024 15:18:22 +0800
Message-ID: <20240612071835.157004-1-linmiaohe@huawei.com>
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
 canpemm500002.china.huawei.com (7.192.104.244)

Hi everyone,
This series contains a few cleanup patches to avoid exporting unused
function, add helper macro, fix some obsolete comments and so on. More
details can be found in the respective changelogs.
Thanks!
---
v3:
 Fix build error per kernel test robot. Thanks.
 s/extern// for function declarations per Matthew. Thanks.
v2:
 Collect Reviewed-by tag and use folio_mapped() per David. Thanks.
 Fix build error per kernel test robot. Thanks.
---
Miaohe Lin (13):
  mm/memory-failure: simplify put_ref_page()
  mm/memory-failure: remove MF_MSG_SLAB
  mm/memory-failure: add macro GET_PAGE_MAX_RETRY_NUM
  mm/memory-failure: save some page_folio() calls
  mm/memory-failure: remove unneeded empty string
  mm/memory-failure: remove confusing initialization to count
  mm/memory-failure: don't export hwpoison_filter() when
    !CONFIG_HWPOISON_INJECT
  mm/memory-failure: use helper macro task_pid_nr()
  mm/memory-failure: remove obsolete comment in unpoison_memory()
  mm/memory-failure: move some function declarations into internal.h
  mm/memory-failure: fix comment of get_hwpoison_page()
  mm/memory-failure: remove obsolete comment in kill_proc()
  mm/memory-failure: correct comment in me_swapcache_dirty

 include/linux/mm.h         |  8 -------
 include/linux/page-flags.h |  5 -----
 include/linux/rmap.h       |  2 --
 include/ras/ras_event.h    |  1 -
 mm/internal.h              | 10 +++++++++
 mm/memory-failure.c        | 46 +++++++++++++++-----------------------
 6 files changed, 28 insertions(+), 44 deletions(-)


base-commit: 8a58962d482f5ab03d698f56fcbd5449757accfa
-- 
2.33.0


