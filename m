Return-Path: <linux-edac+bounces-3016-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69807A30331
	for <lists+linux-edac@lfdr.de>; Tue, 11 Feb 2025 07:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B317C16220A
	for <lists+linux-edac@lfdr.de>; Tue, 11 Feb 2025 06:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0AD1EA7C1;
	Tue, 11 Feb 2025 06:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pWuOqqTL"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7451E3DF2;
	Tue, 11 Feb 2025 06:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739253738; cv=none; b=gSl8hjIosr+5N6Wq+ENB1VID7TSf6uKIbuaZTsJaZ2q/ky8VdZTBG3ERCVxQt9nW4MEHmfAx9cR2aW3kROyL7DotwzNXhaQddfBwkU8jlJrVbLxOWw85cTGfCAaAueBDrzSaUOmz4bURIhD87lAhlUNwbhXWT+a2yRmnqxTYYRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739253738; c=relaxed/simple;
	bh=RkIOq+yMW57uuxCtNKxSE7c7bKxX+2UwZSbM+XjszGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=khf9868FYz7vokscSTlh5z4lFDLSEMYQuKgfu8LzfnSBb9n+1vgLaPfl+mHWRyHHsuIQnET4IzSqIBe56zuBaekWRm6x/RFTeK64P7FF8IYy9R9erzNyRzYQuZvx5xb8tq/fAxnsjDdzQ5mO5qZhzTWO0nozCZvoskZCDxVmwI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pWuOqqTL; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739253727; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=uL5qJeKW+ivS15GzFIfPM3QlAABBDaL6EotBeml3uRU=;
	b=pWuOqqTLy78Zhjw0Cvkhlq60/WwPDcNap6kOvYitKOtRY5MZ43yQRmrTwKr4EKD8Yp9rAnh9DBFF4qwFxhfNHvRhbNoURCvg4ZwdxKqJcSpV5VrZ5xtaKkg/P8fwZnmuWyHj7eOt1xxM1P5i/E9Mq1E7/c/UI2FcqHPPpvmNR7g=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WPFiSIs_1739253725 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 11 Feb 2025 14:02:06 +0800
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
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	baolin.wang@linux.alibaba.com,
	tianruidong@linux.alibaba.com
Subject: [PATCH v1 4/4] mm/hwpoison: Fix incorrect "not recovered" report for recovered clean pages
Date: Tue, 11 Feb 2025 14:02:00 +0800
Message-ID: <20250211060200.33845-5-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250211060200.33845-1-xueshuai@linux.alibaba.com>
References: <20250211060200.33845-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an uncorrected memory error is consumed there is a race between
the CMCI from the memory controller reporting an uncorrected error
with a UCNA signature, and the core reporting and SRAR signature
machine check when the data is about to be consumed.

If the CMCI wins that race, the page is marked poisoned when
uc_decode_notifier() calls memory_failure(). For dirty pages,
memory_failure() invokes try_to_unmap() with the TTU_HWPOISON flag,
converting the PTE to a hwpoison entry. However, for clean pages, the
TTU_HWPOISON flag is cleared, leaving the PTE unchanged and not converted
to a hwpoison entry. Consequently, for an unmapped dirty page, the PTE is
marked as a hwpoison entry allowing kill_accessing_process() to:

- call walk_page_range() and return 1
- call kill_proc() to make sure a SIGBUS is sent
- return -EHWPOISON to indicate that SIGBUS is already sent to the process
  and kill_me_maybe() doesn't have to send it again.

Conversely, for clean pages where PTE entries are not marked as hwpoison,
kill_accessing_process() returns -EFAULT, causing kill_me_maybe() to send a
SIGBUS.

Console log looks like this:

    Memory failure: 0x827ca68: corrupted page was clean: dropped without side effects
    Memory failure: 0x827ca68: recovery action for clean LRU page: Recovered
    Memory failure: 0x827ca68: already hardware poisoned
    mce: Memory error not recovered

To fix it, return -EHWPOISON if no hwpoison PTE entry is found, preventing
an unnecessary SIGBUS.

Fixes: 046545a661af ("mm/hwpoison: fix error page recovered but reported "not recovered"")
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 mm/memory-failure.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 995a15eb67e2..f9a6b136a6f0 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -883,10 +883,9 @@ static int kill_accessing_process(struct task_struct *p, unsigned long pfn,
 			      (void *)&priv);
 	if (ret == 1 && priv.tk.addr)
 		kill_proc(&priv.tk, pfn, flags);
-	else
-		ret = 0;
 	mmap_read_unlock(p->mm);
-	return ret > 0 ? -EHWPOISON : -EFAULT;
+
+	return ret >= 0 ? -EHWPOISON : -EFAULT;
 }
 
 /*
-- 
2.39.3


