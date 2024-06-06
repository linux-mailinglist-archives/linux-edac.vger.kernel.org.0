Return-Path: <linux-edac+bounces-1205-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DE88FDED8
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 08:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 100502894B2
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 06:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5679013C812;
	Thu,  6 Jun 2024 06:36:30 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2D27A141;
	Thu,  6 Jun 2024 06:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717655790; cv=none; b=VUIo08PVDiItkHU7x8+I7R6p1iMP0FcZLaN/t0IwmbIGYiKF9IGpwVGv4zK/3WqPgKxnwE7qFN+k4Y6+TyQjn3ZtUKwOh/dh7YnO8c4bv7BydvnwwRbyqI32m5qcHif9XNeEMvB2ce0DHYm+vJIUwI+W2W8rb8SM3gywTiMeVbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717655790; c=relaxed/simple;
	bh=vinIoh1mF0LVftrP2O7FIMlW//2qg1WiOhM2v+HwznY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nLuc+aomnRiJCQMCUmsEGwsIBFR1B5xJVKBmC7Bn8SVSGdefbCOjzKrcgLSMZB776gfQBYzchxLjC2thRedd5z7Y6Q/4Z9oQo+FfULE2KlRmMXiM5a5/7Y2YuQ53EU4pr8n7HgnqDCH/+RlBT8jXuxIcRVLck6fEGxd/umxb/lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VvvdS74xmzwRlg;
	Thu,  6 Jun 2024 14:32:28 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id B4A05141177;
	Thu,  6 Jun 2024 14:36:26 +0800 (CST)
Received: from huawei.com (10.173.135.154) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 6 Jun
 2024 14:36:26 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <nao.horiguchi@gmail.com>, <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
Subject: [PATCH v2 08/13] mm/memory-failure: use helper macro task_pid_nr()
Date: Thu, 6 Jun 2024 14:32:42 +0800
Message-ID: <20240606063247.712575-9-linmiaohe@huawei.com>
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

Use helper macro task_pid_nr() to get the pid of a task. No functional
change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 6e26b8b975e5..81a544df8381 100644
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


