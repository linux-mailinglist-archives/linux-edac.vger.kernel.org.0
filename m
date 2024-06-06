Return-Path: <linux-edac+bounces-1208-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9A08FDEE0
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 08:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CACCD1F21A5B
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 06:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA53313E40D;
	Thu,  6 Jun 2024 06:36:32 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAE413C67D;
	Thu,  6 Jun 2024 06:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717655792; cv=none; b=oTMve/BbSVAwMK6vVAYmi21tCGFV1UFDplClCUsaWSbOaoP6rAyZPAh/m0g3xmx0TJRXb2a1uoGtOTIMJWeLObE6Q6cDMHT+JLiNdj0btzyxDxqubh2pA2EduBjrkc//7j7nfqmKu6Pn47jZ3plVkqnbL4mxPYUWIM/D4wtbLBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717655792; c=relaxed/simple;
	bh=r0o38on2ja+vixzhLX7/gU++hoA9bxb5rZiA7ubuZSY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iV7FRb/2QMsaS3RzMwyaJuxRJ7iZrj5RsX5tNGq8vRsiiXGM5g3KlDLtId5k5fP2a7NFVcIw/DdeP30by477e6qtAXBDyzRqWwI16VAQ5q8cx5xCZOWPGzZcTRkMDx8+ntLgRGi/3HdVZt9bCwQzUs64yiJREa5UqKDrT81FjXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Vvvdn5nT7z355kv;
	Thu,  6 Jun 2024 14:32:45 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id BC2BD1A0188;
	Thu,  6 Jun 2024 14:36:27 +0800 (CST)
Received: from huawei.com (10.173.135.154) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 6 Jun
 2024 14:36:27 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <nao.horiguchi@gmail.com>, <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
Subject: [PATCH v2 10/13] mm/memory-failure: move some function declarations into internal.h
Date: Thu, 6 Jun 2024 14:32:44 +0800
Message-ID: <20240606063247.712575-11-linmiaohe@huawei.com>
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
index ec7141fb0252..5ca79aff5e39 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4011,7 +4011,6 @@ extern int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 					bool *migratable_cleared);
 void num_poisoned_pages_inc(unsigned long pfn);
 void num_poisoned_pages_sub(unsigned long pfn, long i);
-struct task_struct *task_early_kill(struct task_struct *tsk, int force_early);
 #else
 static inline void memory_failure_queue(unsigned long pfn, int flags)
 {
@@ -4032,12 +4031,6 @@ static inline void num_poisoned_pages_sub(unsigned long pfn, long i)
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
index f04fea86324d..b4e3444f1d9b 100644
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
index 0fd9bebce54c..8ff042c3eae2 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -723,8 +723,6 @@ int pfn_mkclean_range(unsigned long pfn, unsigned long nr_pages, pgoff_t pgoff,
 
 void remove_migration_ptes(struct folio *src, struct folio *dst, bool locked);
 
-unsigned long page_mapped_in_vma(struct page *page, struct vm_area_struct *vma);
-
 /*
  * rmap_walk_control: To control rmap traversing for specific needs
  *
diff --git a/mm/internal.h b/mm/internal.h
index 12e95fdf61e9..7b1368d14e85 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1077,6 +1077,16 @@ extern u64 hwpoison_filter_flags_mask;
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
 
 extern unsigned long  __must_check vm_mmap_pgoff(struct file *, unsigned long,
         unsigned long, unsigned long,
-- 
2.33.0


