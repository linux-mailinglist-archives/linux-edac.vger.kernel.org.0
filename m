Return-Path: <linux-edac+bounces-1261-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CF4904CA9
	for <lists+linux-edac@lfdr.de>; Wed, 12 Jun 2024 09:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82CD4B22486
	for <lists+linux-edac@lfdr.de>; Wed, 12 Jun 2024 07:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6898516C852;
	Wed, 12 Jun 2024 07:22:56 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D32916C69C;
	Wed, 12 Jun 2024 07:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718176976; cv=none; b=cWxZuhZdwP8HIt0f5pMd+HUSFpw5ZliQIKqcJ0d6kJ2E4Ig7QClo/4LYxoE1VuBszoofNBwqvBh5o3vXb4HKfV7T69vc8vfP9ZBb1X9R2i7eE5MNKpmiyuTkYYiewWN0rz3ezj+H9j91+cMwizFg3FLN/d+5iyLAIbI/znhUZ4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718176976; c=relaxed/simple;
	bh=b2/V8tU5ZF/CpHYgF/QbeItq0c97/2BBib6tDU8+atk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PXImis/0W+eawkytlpgM6aQWHAZla9pD3x4O2lUvCj3LneNfu1t9ReT1WiyFdMzDnqCuLt2uHalBmZ3ZyDycwYnJ1CCdsC7TzBv6+ffW6mVs4ZoMRWvOh1y4fPOkl33PQ47n5xTfzkEmJHOHQO/3RT2SccMio1lEgY6ziUu6t3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VzcMN65pyzmb4P;
	Wed, 12 Jun 2024 15:18:08 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 7399D180AAB;
	Wed, 12 Jun 2024 15:22:52 +0800 (CST)
Received: from huawei.com (10.173.127.72) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 12 Jun
 2024 15:22:22 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <nao.horiguchi@gmail.com>, <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
Subject: [PATCH v3 08/13] mm/memory-failure: use helper macro task_pid_nr()
Date: Wed, 12 Jun 2024 15:18:30 +0800
Message-ID: <20240612071835.157004-9-linmiaohe@huawei.com>
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

Use helper macro task_pid_nr() to get the pid of a task. No functional
change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index ee6ec63534b7..bd3ab367ba2f 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -343,7 +343,7 @@ static int kill_proc(struct to_kill *tk, unsigned long pfn, int flags)
 	int ret = 0;
 
 	pr_err("%#lx: Sending SIGBUS to %s:%d due to hardware memory corruption\n",
-			pfn, t->comm, t->pid);
+			pfn, t->comm, task_pid_nr(t));
 
 	if ((flags & MF_ACTION_REQUIRED) && (t == current))
 		ret = force_sig_mceerr(BUS_MCEERR_AR,
@@ -361,7 +361,7 @@ static int kill_proc(struct to_kill *tk, unsigned long pfn, int flags)
 				      addr_lsb, t);
 	if (ret < 0)
 		pr_info("Error sending signal to %s:%d: %d\n",
-			t->comm, t->pid, ret);
+			t->comm, task_pid_nr(t), ret);
 	return ret;
 }
 
@@ -523,7 +523,7 @@ static void kill_procs(struct list_head *to_kill, int forcekill,
 		if (forcekill) {
 			if (tk->addr == -EFAULT) {
 				pr_err("%#lx: forcibly killing %s:%d because of failure to unmap corrupted page\n",
-				       pfn, tk->tsk->comm, tk->tsk->pid);
+				       pfn, tk->tsk->comm, task_pid_nr(tk->tsk));
 				do_send_sig_info(SIGKILL, SEND_SIG_PRIV,
 						 tk->tsk, PIDTYPE_PID);
 			}
@@ -536,7 +536,7 @@ static void kill_procs(struct list_head *to_kill, int forcekill,
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


