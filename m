Return-Path: <linux-edac+bounces-1755-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAB6967E03
	for <lists+linux-edac@lfdr.de>; Mon,  2 Sep 2024 05:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46D32B246BE
	for <lists+linux-edac@lfdr.de>; Mon,  2 Sep 2024 03:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6DD4084D;
	Mon,  2 Sep 2024 03:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="X4n70cfF"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE1622092;
	Mon,  2 Sep 2024 03:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725246055; cv=none; b=Vdg5LFXrnu8Pli8FDlZ4Ls+jbROvtLRjSe83H57O6a4JhNA7T7QVzmEsCFjCrLBMn+zUzCTId8grn2S/dw7iYgs6yi1Q2hMHUTyAHKxN01HpYI/ogh7LR5v7R1osVFKCr/OLGF695sOOPsaDrxDhvxefuOIhpJsA6olAsQ0jX0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725246055; c=relaxed/simple;
	bh=xV4/fzkLNvpbcVrR4IaZq64AiaJLTa17KAh1LisFv5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lsG+eW/m1Q9Vnmb7QYs2hfZzlUTNYBPnJZQ4SvKXePz5S+4Tp8MHC8NVyqDXZLZPl52UecB6m1WBYsyCR8BOSh7fE/HKV0Xm8aetih4c3drpDgj3tLXr1kvV2d12osISmSZpHDw1pW2V2uroaORoMwh4db+Br5Mum1eXl6gymak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=X4n70cfF; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725246050; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=T07Izsq7HNgi0OoshzXXCt7DRFHrDmyIOgvlsgOO0Bo=;
	b=X4n70cfFPjEWgwx72wbY+12f0yRAh4ZNg8e4e7LLQyzDhSTfodG9K0zT90zSy6HS9BQ1P9tc14/qVclOkfiPwpV+0Gz3UM0qQbRkKslmldbAdKLUFliY1ap7Gw8zJRan7l6EkfzXxhr+S6iBgdKD/OXdDNivLiFgvZ1PgQ+FzbY=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WE1odp4_1725246047)
          by smtp.aliyun-inc.com;
          Mon, 02 Sep 2024 11:00:48 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: bp@alien8.de,
	rafael@kernel.org,
	wangkefeng.wang@huawei.com,
	tanxiaofei@huawei.com,
	mawupeng1@huawei.com,
	tony.luck@intel.com,
	linmiaohe@huawei.com,
	naoya.horiguchi@nec.com,
	james.morse@arm.com,
	tongtiangen@huawei.com,
	gregkh@linuxfoundation.org,
	will@kernel.org,
	jarkko@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-edac@vger.kernel.org,
	x86@kernel.org,
	xueshuai@linux.alibaba.com,
	justin.he@arm.com,
	ardb@kernel.org,
	ying.huang@intel.com,
	ashish.kalra@amd.com,
	baolin.wang@linux.alibaba.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	lenb@kernel.org,
	hpa@zytor.com,
	robert.moore@intel.com,
	lvying6@huawei.com,
	xiexiuqi@huawei.com,
	zhuo.song@linux.alibaba.com
Subject: [PATCH v12 2/3] mm: memory-failure: move return value documentation to function declaration
Date: Mon,  2 Sep 2024 11:00:33 +0800
Message-ID: <20240902030034.67152-3-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Part of return value comments for memory_failure() were originally
documented at the call site. Move those comments to the function
declaration to improve code readability and to provide developers with
immediate access to function usage and return information.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 arch/x86/kernel/cpu/mce/core.c | 7 -------
 mm/memory-failure.c            | 9 ++++++---
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index b85ec7a4ec9e..66693b6dd1cd 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1361,13 +1361,6 @@ static void kill_me_maybe(struct callback_head *cb)
 		return;
 	}
 
-	/*
-	 * -EHWPOISON from memory_failure() means that it already sent SIGBUS
-	 * to the current process with the proper error info,
-	 * -EOPNOTSUPP means hwpoison_filter() filtered the error event,
-	 *
-	 * In both cases, no further processing is required.
-	 */
 	if (ret == -EHWPOISON || ret == -EOPNOTSUPP)
 		return;
 
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 7066fc84f351..df26e2ff5e06 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2199,9 +2199,12 @@ static void kill_procs_now(struct page *p, unsigned long pfn, int flags,
  * Must run in process context (e.g. a work queue) with interrupts
  * enabled and no spinlocks held.
  *
- * Return: 0 for successfully handled the memory error,
- *         -EOPNOTSUPP for hwpoison_filter() filtered the error event,
- *         < 0(except -EOPNOTSUPP) on failure.
+ * Return values:
+ *   0             - success,
+ *   -EOPNOTSUPP   - hwpoison_filter() filtered the error event,
+ *   -EHWPOISON    - the page was already poisoned, potentially
+ *                   kill process,
+ *   other negative values - failure.
  */
 int memory_failure(unsigned long pfn, int flags)
 {
-- 
2.39.3


