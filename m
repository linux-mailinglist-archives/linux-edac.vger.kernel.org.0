Return-Path: <linux-edac+bounces-3094-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EE0A37B67
	for <lists+linux-edac@lfdr.de>; Mon, 17 Feb 2025 07:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD943167CA2
	for <lists+linux-edac@lfdr.de>; Mon, 17 Feb 2025 06:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F2518FC74;
	Mon, 17 Feb 2025 06:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="G/FjIkAH"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B35614D2A0;
	Mon, 17 Feb 2025 06:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739774026; cv=none; b=jIIKCkVyDZwEoxQc+zNtoZ1gkU7j8rUxD5r624Jn2jwl+VMJbilIF9Sxs8AUujd86n/SPC/+/1x+FF6DBPhXgnZNdvnDsAqjNEj2Bd0MX9tShmQlM9iztww5loJCZ3CpOhrnkZkxiZhTq61DW6Y6OaZZIoXghIcu/N4Kgq1J8Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739774026; c=relaxed/simple;
	bh=gQS7lE6aR1pvIvgjR1Y3fZI8Acds0U8IcKCYS4/p84k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJ8VKlKr/Q+6McimzZ7o2etO6mkf1BM18xSuEPnQkELrreSWt6nzpHd9kGEa0fe5xexfilh6OChoy5TfiJQRNj4iDYT/dLJeMdHjKeBDARJPbklWHHPaNoXHodK/scby/90Xr0+TWk/g9aGRiNIyy6c4EeQgPWSqvgmlktyQkbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=G/FjIkAH; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739774021; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=bq0U27NFG8TdcE9f/ikRqDiyjfIWEAdUTwz5YbwhJro=;
	b=G/FjIkAHdtoE4pIMsp/BLl7mYccI1HS8ALP0uEgJvmh2GTePuty86DKWN5yDqBDKG+RR9CFlSdkM75GJZTq6kw4mDciVxhrHM3MO7j8RGoXCyn9P9WYQ53CRN4QNzqMckmFGwUmqYt2DV4ldOTa3ytLAOEmHJ3tfElhkGKs/sf8=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WPb1mPM_1739774018 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Feb 2025 14:33:39 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: tony.luck@intel.com,
	bp@alien8.de,
	nao.horiguchi@gmail.com
Cc: tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	linmiaohe@huawei.com,
	akpm@linux-foundation.org,
	peterz@infradead.org,
	jpoimboe@kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	baolin.wang@linux.alibaba.com,
	tianruidong@linux.alibaba.com
Subject: [PATCH v2 2/5] x86/mce: dump error msg from severities
Date: Mon, 17 Feb 2025 14:33:32 +0800
Message-ID: <20250217063335.22257-3-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
References: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The message in severities is useful for identifying the type of MCE that
has occurred; dump it if it is valid.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 arch/x86/kernel/cpu/mce/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index f2e730d4acc5..c1b945dbccdf 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1456,6 +1456,8 @@ static void queue_task_work(struct mce_hw_err *err, char *msg, void (*func)(stru
 	if (count > 1)
 		return;
 
+	if (msg)
+		pr_err("%s\n", msg);
 	task_work_add(current, &current->mce_kill_me, TWA_RESUME);
 }
 
-- 
2.39.3


