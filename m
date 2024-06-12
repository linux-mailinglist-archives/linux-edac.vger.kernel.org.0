Return-Path: <linux-edac+bounces-1263-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D44904CAB
	for <lists+linux-edac@lfdr.de>; Wed, 12 Jun 2024 09:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE70B28684F
	for <lists+linux-edac@lfdr.de>; Wed, 12 Jun 2024 07:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97E916D9CF;
	Wed, 12 Jun 2024 07:22:56 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED51016C6A6;
	Wed, 12 Jun 2024 07:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718176976; cv=none; b=cpK+ClZBXW7TZHjy/oCTQBvYQZFbLZGNbzcpGT+bcmfuBFjVOlm2O1lSIZbWyJiB5EtNhOpvCH8uDm06ChLe/V2Y8H0mWp6tqrVSpOxmecwQn7k2ddMGf9auOzdOe5U23xt156Eq2rGuES1CXWI43s91n9mya5VAnitL+yXAvFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718176976; c=relaxed/simple;
	bh=MlWtRMtgg4sxtzui5ZbDzlDMUicI7RngDTkJbHKrzkM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MrFwuueCYUknxQJcgUsBbzHgNZl6/NAIGaM7RnKMb/s3vS8NeRJLkih62B41H2ylM0QZer1zOEalTPptmflT/Sqvt/JdpY2nv7WAfs5g8+O6SGfMDYsWh0kGZOeM6VCk5PU/wNpWDaKtB1kzuFPggL4UNFOdsiluY8RAH8MiSBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VzcNv57flzPqKq;
	Wed, 12 Jun 2024 15:19:27 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 9B9B5180AA6;
	Wed, 12 Jun 2024 15:22:52 +0800 (CST)
Received: from huawei.com (10.173.127.72) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 12 Jun
 2024 15:22:24 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <nao.horiguchi@gmail.com>, <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
Subject: [PATCH v3 12/13] mm/memory-failure: remove obsolete comment in kill_proc()
Date: Wed, 12 Jun 2024 15:18:34 +0800
Message-ID: <20240612071835.157004-13-linmiaohe@huawei.com>
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

When user sets SIGBUS to SIG_IGN, it won't cause loop now. For action
required mce error, SIGBUS cannot be blocked. Also when a hwpoisoned
page is re-accessed, kill_accessing_process() will be called to kill
the process.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 475524f79550..12b516895ee7 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -354,8 +354,6 @@ static int kill_proc(struct to_kill *tk, unsigned long pfn, int flags)
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


