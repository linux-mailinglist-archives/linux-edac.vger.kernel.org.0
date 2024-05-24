Return-Path: <linux-edac+bounces-1122-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D288CE339
	for <lists+linux-edac@lfdr.de>; Fri, 24 May 2024 11:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F770281D69
	for <lists+linux-edac@lfdr.de>; Fri, 24 May 2024 09:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BAF127E2D;
	Fri, 24 May 2024 09:16:40 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6CF8627E;
	Fri, 24 May 2024 09:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716542200; cv=none; b=aaX7bBfiJZ8yQ174IoLAq0nAEYdpf2cVZ4obUOMQDc4N3d7fC2eQEsaCBCF31YtjbJKJQXd1fAsm32ishmt+V0P5uEDd4Ezuczee27SnnxAU8ZA+Di1HY5qvbmkd/+UkljdeO48cFt01KwqLF811HRPygENha7ZHjDwUb/BLZfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716542200; c=relaxed/simple;
	bh=U4M+mqIJ6eqNJrMY3nhiyUmONLQVAM6acKtLt0LVyIc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H+WJIZQ+PcQJbiWfSNnJ3yMScYN77PrBwAKqN4WjaMv7mL0FL/knDl7g4T4bwJr5y/OkFC9Nh2w8Rkvi8H2aAkIXkcrsK+lpZnfK7ycowrHO9Rzp/ZnQy33jzd7BvgzhNfpcInql7OpRnYj6QeZJ1wl4X9akPPahfBqsTMZmE98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Vlzph0Cgyz1S5bv;
	Fri, 24 May 2024 17:13:00 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 10C4F14037C;
	Fri, 24 May 2024 17:16:31 +0800 (CST)
Received: from huawei.com (10.173.135.154) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 24 May
 2024 17:16:30 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <nao.horiguchi@gmail.com>, <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
Subject: [PATCH 10/13] mm/memory-failure: move some function declarations into internal.h
Date: Fri, 24 May 2024 17:13:07 +0800
Message-ID: <20240524091310.1430048-11-linmiaohe@huawei.com>
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

There are some functions only used inside mm. Move them into internal.h.
No functional change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/mm.h         | 13 -------------
 include/linux/page-flags.h |  5 -----
 include/linux/rmap.h       |  2 --
 mm/internal.h              | 16 ++++++++++++++++
 4 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 4bc97ae25ade..d5174b3b792b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1330,12 +1330,6 @@ static inline unsigned long page_size(struct page *page)
 	return PAGE_SIZE << compound_order(page);
 }
 
-/* Returns the number of bits needed for the number of bytes in a page */
-static inline unsigned int page_shift(struct page *page)
-{
-	return PAGE_SHIFT + compound_order(page);
-}
-
 /**
  * thp_order - Order of a transparent huge page.
  * @page: Head page of a transparent huge page.
@@ -4032,7 +4026,6 @@ extern int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 					bool *migratable_cleared);
 void num_poisoned_pages_inc(unsigned long pfn);
 void num_poisoned_pages_sub(unsigned long pfn, long i);
-struct task_struct *task_early_kill(struct task_struct *tsk, int force_early);
 #else
 static inline void memory_failure_queue(unsigned long pfn, int flags)
 {
@@ -4053,12 +4046,6 @@ static inline void num_poisoned_pages_sub(unsigned long pfn, long i)
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
index 104078afe0b1..00c33a6ea367 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -616,11 +616,6 @@ PAGEFLAG_FALSE(Uncached, uncached)
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
index 5cb0d419a1d7..ece0515ee21c 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -733,8 +733,6 @@ int pfn_mkclean_range(unsigned long pfn, unsigned long nr_pages, pgoff_t pgoff,
 
 void remove_migration_ptes(struct folio *src, struct folio *dst, bool locked);
 
-unsigned long page_mapped_in_vma(struct page *page, struct vm_area_struct *vma);
-
 /*
  * rmap_walk_control: To control rmap traversing for specific needs
  *
diff --git a/mm/internal.h b/mm/internal.h
index bbec99cc9d9d..188e292d2a77 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1061,6 +1061,22 @@ extern u64 hwpoison_filter_flags_mask;
 extern u64 hwpoison_filter_flags_value;
 extern u64 hwpoison_filter_memcg;
 extern u32 hwpoison_filter_enable;
+#define MAGIC_HWPOISON	0x48575053U	/* HWPS */
+extern void SetPageHWPoisonTakenOff(struct page *page);
+extern void ClearPageHWPoisonTakenOff(struct page *page);
+extern bool take_page_off_buddy(struct page *page);
+extern bool put_page_back_buddy(struct page *page);
+struct task_struct *task_early_kill(struct task_struct *tsk, int force_early);
+void add_to_kill_ksm(struct task_struct *tsk, struct page *p,
+		     struct vm_area_struct *vma, struct list_head *to_kill,
+		     unsigned long ksm_addr);
+unsigned long page_mapped_in_vma(struct page *page, struct vm_area_struct *vma);
+
+/* Returns the number of bits needed for the number of bytes in a page */
+static inline unsigned int page_shift(struct page *page)
+{
+	return PAGE_SHIFT + compound_order(page);
+}
 
 extern unsigned long  __must_check vm_mmap_pgoff(struct file *, unsigned long,
         unsigned long, unsigned long,
-- 
2.33.0


