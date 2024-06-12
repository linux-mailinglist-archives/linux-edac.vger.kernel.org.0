Return-Path: <linux-edac+bounces-1262-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 403A7904CAA
	for <lists+linux-edac@lfdr.de>; Wed, 12 Jun 2024 09:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEBF4286055
	for <lists+linux-edac@lfdr.de>; Wed, 12 Jun 2024 07:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAED16D9C1;
	Wed, 12 Jun 2024 07:22:56 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D37416C69D;
	Wed, 12 Jun 2024 07:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718176976; cv=none; b=P4ka+L+m4X6CQSezRbo6f+GEr8mY0L7OdBwvsoj8SCsb2ZS6akdd5yq5xHNlECGn/GgGh0je3cK6PBpkpFcICk26hedp64MJ8VjRBPguLeGTCv2NHlCQ0rDTW4QAqHD4AtTa8KSaixJRmWveMughYZmP0Lc4NfW+jzpdB0lE+3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718176976; c=relaxed/simple;
	bh=qR2oD7hunfoIEUGG0TzefVW1cv8J0Az/lJNxPgknD2E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WTUgc0UVxuHxlJjdyi4SYpnKs6qntux/4gWqyXrvn4hzJ+QTrpAljukocy2/DJRHqTCZBhXoXmi9tPsqRThD690FK+XbjO8yGljxAdC/qjPbPpZ6qdpbOZCTOCv6ZBIElfYgRB1eU1kXkVOHRzMSkmFjo3iuJHDmpqqVJN8AGYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VzcR91fP6zdfqZ;
	Wed, 12 Jun 2024 15:21:25 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 84D26180AA6;
	Wed, 12 Jun 2024 15:22:52 +0800 (CST)
Received: from huawei.com (10.173.127.72) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 12 Jun
 2024 15:22:23 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <nao.horiguchi@gmail.com>, <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
Subject: [PATCH v3 10/13] mm/memory-failure: move some function declarations into internal.h
Date: Wed, 12 Jun 2024 15:18:32 +0800
Message-ID: <20240612071835.157004-11-linmiaohe@huawei.com>
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

There are some functions only used inside mm. Move them into internal.h.
No functional change intended.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202405251049.hxjwX7zO-lkp@intel.com/
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/mm.h         |  7 -------
 include/linux/page-flags.h |  5 -----
 include/linux/rmap.h       |  2 --
 mm/internal.h              | 10 ++++++++++
 4 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0bf0f22b32c8..587d34879865 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3981,7 +3981,6 @@ extern int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 					bool *migratable_cleared);
 void num_poisoned_pages_inc(unsigned long pfn);
 void num_poisoned_pages_sub(unsigned long pfn, long i);
-struct task_struct *task_early_kill(struct task_struct *tsk, int force_early);
 #else
 static inline void memory_failure_queue(unsigned long pfn, int flags)
 {
@@ -4002,12 +4001,6 @@ static inline void num_poisoned_pages_sub(unsigned long pfn, long i)
 }
 #endif
 
-#if defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_KSM)
-void add_to_kill_ksm(struct task_struct *tsk, struct page *p,
-		     struct vm_area_struct *vma, struct list_head *to_kill,
-		     unsigned long ksm_addr);
-#endif
-
 #if defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_MEMORY_HOTPLUG)
 extern void memblk_nr_poison_inc(unsigned long pfn);
 extern void memblk_nr_poison_sub(unsigned long pfn, long i);
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 0c9fd5250687..9a98b657ba07 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -611,11 +611,6 @@ PAGEFLAG_FALSE(Uncached, uncached)
 PAGEFLAG(HWPoison, hwpoison, PF_ANY)
 TESTSCFLAG(HWPoison, hwpoison, PF_ANY)
 #define __PG_HWPOISON (1UL << PG_hwpoison)
-#define MAGIC_HWPOISON	0x48575053U	/* HWPS */
-extern void SetPageHWPoisonTakenOff(struct page *page);
-extern void ClearPageHWPoisonTakenOff(struct page *page);
-extern bool take_page_off_buddy(struct page *page);
-extern bool put_page_back_buddy(struct page *page);
 #else
 PAGEFLAG_FALSE(HWPoison, hwpoison)
 #define __PG_HWPOISON 0
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index cae38a2a643d..b1bbe237ea4c 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -745,8 +745,6 @@ int pfn_mkclean_range(unsigned long pfn, unsigned long nr_pages, pgoff_t pgoff,
 
 void remove_migration_ptes(struct folio *src, struct folio *dst, bool locked);
 
-unsigned long page_mapped_in_vma(struct page *page, struct vm_area_struct *vma);
-
 /*
  * rmap_walk_control: To control rmap traversing for specific needs
  *
diff --git a/mm/internal.h b/mm/internal.h
index 14bab8a41baf..c9dc056a47a3 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1078,6 +1078,16 @@ extern u64 hwpoison_filter_flags_mask;
 extern u64 hwpoison_filter_flags_value;
 extern u64 hwpoison_filter_memcg;
 extern u32 hwpoison_filter_enable;
+#define MAGIC_HWPOISON	0x48575053U	/* HWPS */
+void SetPageHWPoisonTakenOff(struct page *page);
+void ClearPageHWPoisonTakenOff(struct page *page);
+bool take_page_off_buddy(struct page *page);
+bool put_page_back_buddy(struct page *page);
+struct task_struct *task_early_kill(struct task_struct *tsk, int force_early);
+void add_to_kill_ksm(struct task_struct *tsk, struct page *p,
+		     struct vm_area_struct *vma, struct list_head *to_kill,
+		     unsigned long ksm_addr);
+unsigned long page_mapped_in_vma(struct page *page, struct vm_area_struct *vma);
 
 extern unsigned long  __must_check vm_mmap_pgoff(struct file *, unsigned long,
         unsigned long, unsigned long,
-- 
2.33.0


