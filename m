Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30B76F9DA2
	for <lists+linux-edac@lfdr.de>; Mon,  8 May 2023 04:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjEHCJ2 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 7 May 2023 22:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbjEHCJ1 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 7 May 2023 22:09:27 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84318124BE;
        Sun,  7 May 2023 19:09:25 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QF4Qy28c7zLntj;
        Mon,  8 May 2023 10:06:34 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 8 May 2023 10:09:22 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <jane.chu@oracle.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] x86/mce: set MCE_IN_KERNEL_COPYIN for all MC-Safe Copy
Date:   Mon, 8 May 2023 10:22:33 +0800
Message-ID: <20230508022233.13890-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Both EX_TYPE_FAULT_MCE_SAFE and EX_TYPE_DEFAULT_MCE_SAFE exception
fixup types are used to identify fixups which allow in kernel #MC
recovery, that is the Machine Check Safe Copy.

For now, the MCE_IN_KERNEL_COPYIN flag is only set for EX_TYPE_COPY
and EX_TYPE_UACCESS when copy from user, and corrupted page is
isolated in this case, for MC-safe copy, memory_failure() is not
always called, some places, like __wp_page_copy_user, copy_subpage,
copy_user_gigantic_page and ksm_might_need_to_copy manually call
memory_failure_queue() to cope with such unhandled error pages,
recently coredump hwposion recovery support[1] is asked to do the
same thing, and there are some other already existed MC-safe copy
scenarios, eg, nvdimm, dm-writecache, dax, which has similar issue.

The best way to fix them is set MCE_IN_KERNEL_COPYIN to MCE_SAFE
exception, then kill_me_never() will be queued to call memory_failure()
in do_machine_check() to isolate corrupted page, which avoid calling
memory_failure_queue() after every MC-safe copy return.

[1] https://lkml.kernel.org/r/20230417045323.11054-1-wangkefeng.wang@huawei.com

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/x86/kernel/cpu/mce/severity.c |  3 +--
 mm/ksm.c                           |  1 -
 mm/memory.c                        | 12 +++---------
 3 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index c4477162c07d..63e94484c5d6 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -293,12 +293,11 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
 	case EX_TYPE_COPY:
 		if (!copy_user)
 			return IN_KERNEL;
-		m->kflags |= MCE_IN_KERNEL_COPYIN;
 		fallthrough;
 
 	case EX_TYPE_FAULT_MCE_SAFE:
 	case EX_TYPE_DEFAULT_MCE_SAFE:
-		m->kflags |= MCE_IN_KERNEL_RECOV;
+		m->kflags |= MCE_IN_KERNEL_RECOV | MCE_IN_KERNEL_COPYIN;
 		return IN_KERNEL_RECOV;
 
 	default:
diff --git a/mm/ksm.c b/mm/ksm.c
index 0156bded3a66..7abdf4892387 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2794,7 +2794,6 @@ struct page *ksm_might_need_to_copy(struct page *page,
 	if (new_page) {
 		if (copy_mc_user_highpage(new_page, page, address, vma)) {
 			put_page(new_page);
-			memory_failure_queue(page_to_pfn(page), 0);
 			return ERR_PTR(-EHWPOISON);
 		}
 		SetPageDirty(new_page);
diff --git a/mm/memory.c b/mm/memory.c
index 5e2c6b1fc00e..c0f586257017 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2814,10 +2814,8 @@ static inline int __wp_page_copy_user(struct page *dst, struct page *src,
 	unsigned long addr = vmf->address;
 
 	if (likely(src)) {
-		if (copy_mc_user_highpage(dst, src, addr, vma)) {
-			memory_failure_queue(page_to_pfn(src), 0);
+		if (copy_mc_user_highpage(dst, src, addr, vma))
 			return -EHWPOISON;
-		}
 		return 0;
 	}
 
@@ -5852,10 +5850,8 @@ static int copy_user_gigantic_page(struct folio *dst, struct folio *src,
 
 		cond_resched();
 		if (copy_mc_user_highpage(dst_page, src_page,
-					  addr + i*PAGE_SIZE, vma)) {
-			memory_failure_queue(page_to_pfn(src_page), 0);
+					  addr + i*PAGE_SIZE, vma))
 			return -EHWPOISON;
-		}
 	}
 	return 0;
 }
@@ -5871,10 +5867,8 @@ static int copy_subpage(unsigned long addr, int idx, void *arg)
 	struct copy_subpage_arg *copy_arg = arg;
 
 	if (copy_mc_user_highpage(copy_arg->dst + idx, copy_arg->src + idx,
-				  addr, copy_arg->vma)) {
-		memory_failure_queue(page_to_pfn(copy_arg->src + idx), 0);
+				  addr, copy_arg->vma))
 		return -EHWPOISON;
-	}
 	return 0;
 }
 
-- 
2.35.3

