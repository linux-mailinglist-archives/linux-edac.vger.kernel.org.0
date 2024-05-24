Return-Path: <linux-edac+bounces-1113-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 688308CE324
	for <lists+linux-edac@lfdr.de>; Fri, 24 May 2024 11:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC5EBB21BA7
	for <lists+linux-edac@lfdr.de>; Fri, 24 May 2024 09:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6988485655;
	Fri, 24 May 2024 09:16:36 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918218529E;
	Fri, 24 May 2024 09:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716542196; cv=none; b=lzjrsClcbwpZN6pUTnii3+fU0hXApvJrZWzz171axmxZzvdcZP3kEdwdJNAIoLjNhohD3Byr8C7oK7yZJgl8v36B1sQDhaXUZItc7mFKJ9eVyMSBX6W4VfTkplbC5ih4eUNgahqSD2ZO94ZJ20hU8dwG7N4Ya++Jrp9Trjo3gk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716542196; c=relaxed/simple;
	bh=dl3BaYvhEF+oy+IXg3fZfQU4v7868fSoS23t7LjBaiM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PomQA/qprliyUAo6PGowfW8KxNaSZsDw4Qm2Nj4M8R5Jqhi7miAkSShNrgUfISmTgK2JoIS6z7Ir/gn0C6nzcl3Seie3N5nkEd+RsRgalrtQlAhKz6gihXB8MtDnyOoGZhOLoi0VA8ssZIH1D1HRszTeKK7DqHP3AVuALFO94jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Vlzpj3Z9Dz2cMp7;
	Fri, 24 May 2024 17:13:01 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 0423A14037C;
	Fri, 24 May 2024 17:16:32 +0800 (CST)
Received: from huawei.com (10.173.135.154) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 24 May
 2024 17:16:31 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <nao.horiguchi@gmail.com>, <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
Subject: [PATCH 12/13] mm/memory-failure: remove obsolete comment in kill_proc()
Date: Fri, 24 May 2024 17:13:09 +0800
Message-ID: <20240524091310.1430048-13-linmiaohe@huawei.com>
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

When user sets SIGBUS to SIG_IGN, it won't cause loop now. For action
required mce error, SIGBUS cannot be blocked. Also when a hwpoisoned
page is re-accessed, kill_accessing_process() will be called to kill
the process.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 705cd0bbb603..b6bdb4e2834a 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -349,8 +349,6 @@ static int kill_proc(struct to_kill *tk, unsigned long pfn, int flags)
 		 * PF_MCE_EARLY set.
 		 * Don't use force here, it's convenient if the signal
 		 * can be temporarily blocked.
-		 * This could cause a loop when the user sets SIGBUS
-		 * to SIG_IGN, but hopefully no one will do that?
 		 */
 		ret = send_sig_mceerr(BUS_MCEERR_AO, (void __user *)tk->addr,
 				      addr_lsb, t);
-- 
2.33.0


