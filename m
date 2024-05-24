Return-Path: <linux-edac+bounces-1120-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DDE8CE334
	for <lists+linux-edac@lfdr.de>; Fri, 24 May 2024 11:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E4A61C21C43
	for <lists+linux-edac@lfdr.de>; Fri, 24 May 2024 09:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8631386ADE;
	Fri, 24 May 2024 09:16:39 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2FE85C69;
	Fri, 24 May 2024 09:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716542199; cv=none; b=JEfM6DGbu5Dtk2/4DRl59hkCXpK1MLdYiZIFGZosVFqoymD8OTFPIjDhOrwwz8m5R+pjXgbycD2ktLEYs+ETdVWrju+zVo8c4C2cHJJj+0x4MPkQgT4mS8G6RWtlzg2lD5Jucs6ePnKT+wsHaUD7wqRmHTci63BCnHoORgpSa9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716542199; c=relaxed/simple;
	bh=2l/HnKNW7m8L+dYV3Z20Y12gb/3RrpQ7muKsdZwTe/4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PHniNEpJNFQpVfrFtEm/Dr7ZV5Ua48A4pZ/zPgxmYvn0W4unnJSzAMTWGskIaGPOFRmCko74Db5L2/dHm+zCaQzm0pANMit3hITtKRwHmZ+sZ/CYlb8LuKQ+XIoega6UPk+2DvUUYo4QpQquyk37qYGYkOTvbzcFptUYzmi3KZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VlzpQ3LHqzsR5g;
	Fri, 24 May 2024 17:12:46 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 0AB32180A9C;
	Fri, 24 May 2024 17:16:30 +0800 (CST)
Received: from huawei.com (10.173.135.154) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 24 May
 2024 17:16:29 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <nao.horiguchi@gmail.com>, <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
Subject: [PATCH 08/13] mm/memory-failure: use helper macro task_pid_nr()
Date: Fri, 24 May 2024 17:13:05 +0800
Message-ID: <20240524091310.1430048-9-linmiaohe@huawei.com>
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

Use helper macro task_pid_nr() to get the pid of a task. No functional
change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 2c3ecbfc2134..19d338e83e43 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -338,7 +338,7 @@ static int kill_proc(struct to_kill *tk, unsigned long pfn, int flags)
 	int ret = 0;
 
 	pr_err("%#lx: Sending SIGBUS to %s:%d due to hardware memory corruption\n",
-			pfn, t->comm, t->pid);
+			pfn, t->comm, task_pid_nr(t));
 
 	if ((flags & MF_ACTION_REQUIRED) && (t == current))
 		ret = force_sig_mceerr(BUS_MCEERR_AR,
@@ -356,7 +356,7 @@ static int kill_proc(struct to_kill *tk, unsigned long pfn, int flags)
 				      addr_lsb, t);
 	if (ret < 0)
 		pr_info("Error sending signal to %s:%d: %d\n",
-			t->comm, t->pid, ret);
+			t->comm, task_pid_nr(t), ret);
 	return ret;
 }
 
@@ -518,7 +518,7 @@ static void kill_procs(struct list_head *to_kill, int forcekill,
 		if (forcekill) {
 			if (tk->addr == -EFAULT) {
 				pr_err("%#lx: forcibly killing %s:%d because of failure to unmap corrupted page\n",
-				       pfn, tk->tsk->comm, tk->tsk->pid);
+				       pfn, tk->tsk->comm, task_pid_nr(tk->tsk));
 				do_send_sig_info(SIGKILL, SEND_SIG_PRIV,
 						 tk->tsk, PIDTYPE_PID);
 			}
@@ -531,7 +531,7 @@ static void kill_procs(struct list_head *to_kill, int forcekill,
 			 */
 			else if (kill_proc(tk, pfn, flags) < 0)
 				pr_err("%#lx: Cannot send advisory machine check signal to %s:%d\n",
-				       pfn, tk->tsk->comm, tk->tsk->pid);
+				       pfn, tk->tsk->comm, task_pid_nr(tk->tsk));
 		}
 		list_del(&tk->nd);
 		put_task_struct(tk->tsk);
-- 
2.33.0


